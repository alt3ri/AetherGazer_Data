slot0 = class("BossSwitchView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Challenge_Boss/BossSwitchUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.bossItemList_ = {}
	slot0.bossGoList_ = {
		slot0.goItem1_,
		slot0.goItem2_,
		slot0.goItem3_
	}
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("BOSS_CHALLENGE_DESC")
	BossTools.CheckTimeout()
	slot0:RefreshUI()
	manager.redPoint:bindUIandKey(slot0.transformStar_, RedPointConst.BOSS_CHALLENGE_NORMAL)

	slot0.challengeUpdateHandler_ = handler(slot0, slot0.UpdateBossChallenge)

	manager.notify:RegistListener(BOSS_CHALLENGE_BACK_ENTRACE, slot0.challengeUpdateHandler_)

	slot0.challengeInitHandler_ = handler(slot0, slot0.RefreshUI)
	slot4 = slot0.challengeInitHandler_

	manager.notify:RegistListener(BOSS_CHALLENGE_UPDATE, slot4)

	for slot4, slot5 in ipairs(slot0.bossItemList_) do
		slot5:OnEnter()
	end

	slot0:CheckMail(slot0.CheckRewardPreview)
end

function slot0.CheckMail(slot0, slot1)
	if PlayerData:GetUnclaimed(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.BOSS) ~= nil then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("UNCLAIMED_BONUS_MAIL_TIP"),
			OkCallback = function ()
				PlayerAction.ReadUnclaimedMessage(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.BOSS)
				uv0()
			end
		})
	else
		slot1()
	end
end

function slot0.OnTop(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveUpdateTimer()
	manager.redPoint:unbindUIandKey(slot0.transformStar_)
	manager.notify:RemoveListener(BOSS_CHALLENGE_BACK_ENTRACE, slot0.challengeUpdateHandler_)

	slot4 = slot0.challengeInitHandler_

	manager.notify:RemoveListener(BOSS_CHALLENGE_UPDATE, slot4)

	slot0.challengeUpdateHandler_ = nil
	slot0.challengeInitHandler_ = nil

	for slot4, slot5 in ipairs(slot0.bossItemList_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.bossItemList_) do
		slot5:Dispose()
	end

	slot0.bossItemList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonShop_, nil, function ()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.DREAM_SHOP
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.buttonExchange_, nil, function ()
		JumpTools.OpenPageByJump("bossStarExchange")
	end)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("BOSS_CHALLENGE_RESET_MODE"),
			OkCallback = function ()
				BattleBossChallengeAction.ResetHardMode(function (slot0)
					if isSuccess(slot0.result) then
						gameContext:OverrideUrl("/bossSwitch", "/bossMode", nil, "home")
						gameContext:OverrideUrl("/bossAdvanceSwitch", "/bossMode", nil, "home")
						gameContext:Go("/bossMode")
					else
						ShowTips(slot0.result)
					end
				end)
			end
		})
	end)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshText()
	slot0:RefreshBossBtnList()
	slot0:AddUpdateTimer()
	slot0:RefreshStar()
	slot0:RefreshResetBtn()
end

function slot0.CheckRewardPreview(slot0)
	if not GuideData:IsFinish(13) then
		return
	end

	if not BossTools.IsFirstEnterUI(BossConst.MODE_NORMAL) then
		return
	end

	slot2 = 0

	for slot7, slot8 in ipairs(BattleBossChallengeNormalData:GetBossChallengeCfg().reward) do
		slot2 = slot8[1]
		slot3 = mergeRewardList({}, getRewardFromDropCfg(slot8[2], true))
	end

	JumpTools.OpenPageByJump("bossChallengeRewardPreview", {
		titleText = string.format("%s·%s", BossChallengeAdvanceCfg[3].name, slot1.name),
		targetText = string.format(GetTips("BOSS_CHALLENGE_REWARD_TARGET"), slot2),
		rewardList = sortReward(formatRewardCfgList(slot3))
	})
	BossTools.SaveFirstEnterUIValue(BossConst.MODE_NORMAL)
end

function slot0.RefreshResetBtn(slot0)
	SetActive(slot0.resetGo_, table.length(BattleBossChallengeNormalData:GetReceiveStarList()) <= 0 and #BattleBossChallengeData:GetOpenModeList() > 0)
end

function slot0.UpdateBossChallenge(slot0)
	BattleBossChallengeAction.BossChallengeBackEntrace()
end

function slot0.RefreshText(slot0)
	slot1 = BattleBossChallengeNormalData:GetBossChallengeCfg()
	slot0.textLv_.text = string.format("(%s%s~%s)", GetTips("LEVEL"), slot1.level[1], slot1.level[2])
	slot0.textName_.text = GetI18NText(slot1.name)
end

function slot0.RefreshStar(slot0)
	slot1 = BattleBossChallengeNormalData:GetBossChallengeCfg()
	slot2 = slot1.reward[#slot1.reward][1]

	for slot7 = 1, #slot1.reward do
		if not table.keyof(BattleBossChallengeNormalData:GetReceiveStarList(), slot1.reward[slot7][1]) then
			slot2 = slot1.reward[slot7][1]

			break
		end
	end

	slot0.textCurStar_.text = StageTools.CalcBossChallengeStar()
	slot0.textTotalStar_.text = string.format("/%s", slot2)
end

function slot0.RefreshBossBtnList(slot0)
	for slot5, slot6 in ipairs(BattleBossChallengeNormalData:GetBossList()) do
		if slot0.bossItemList_[slot5] then
			slot0.bossItemList_[slot5]:RefreshUI()
		else
			slot0.bossItemList_[slot5] = BattleBossChallengeBossItem.New(slot0.bossGoList_[slot5], slot5)
		end
	end

	for slot5 = #slot0.bossItemList_, #slot1 + 1, -1 do
		slot0.bossItemList_[slot5]:OnExit()
		slot0.bossItemList_[slot5]:Dispose()

		slot0.bossItemList_[slot5] = nil
	end
end

function slot0.AddUpdateTimer(slot0)
	slot0:RemoveUpdateTimer()

	slot0.textTime_.text = manager.time:GetLostTimeStrWith2Unit(BattleBossChallengeData:GetNextRefreshTime())
	slot0.updateTimer_ = Timer.New(function ()
		if uv0 ~= BattleBossChallengeData:GetNextRefreshTime() then
			uv1:RemoveUpdateTimer()
		end

		uv1.textTime_.text = manager.time:GetLostTimeStrWith2Unit(slot0)
	end, 1, -1)

	slot0.updateTimer_:Start()
end

function slot0.RemoveUpdateTimer(slot0)
	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end
end

return slot0
