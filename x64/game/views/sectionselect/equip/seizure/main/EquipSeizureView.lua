slot0 = class("EquipSeizureView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Equip_Seizure/EquipSeizureUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.affixItemList_ = {}
	slot0.updateHandler_ = handler(slot0, slot0.RefreshUI)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("EQUIP_SEIZURE_INFO")
	manager.redPoint:bindUIandKey(slot0.pointBtn_.transform, RedPointConst.EQUIP_SEIZURE_REWARD)
	manager.notify:RegistListener(EQUIP_SEIZURE_UPDATE, slot0.updateHandler_)
	slot0:RefreshUI()
	EquipSeizureAction.OpenWindow()
end

function slot0.OnExit(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.notify:RemoveListener(EQUIP_SEIZURE_UPDATE, slot0.updateHandler_)
	manager.redPoint:unbindUIandKey(slot0.pointBtn_.transform, RedPointConst.EQUIP_SEIZURE_REWARD)
	slot0:StopTimer()
	slot0:StopRefreshTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.updateHandler_ = nil

	for slot4 = #slot0.affixItemList_, 1, -1 do
		slot0.affixItemList_[slot4]:Dispose()

		slot0.affixItemList_[slot4] = nil
	end

	slot0.affixItemList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.pointBtn_, nil, function ()
		JumpTools.OpenPageByJump("equipSeizureReward", {})
	end)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		uv0:Go("/sectionSelectHero", {
			section = EquipSeizureData:GetStageID(),
			sectionType = BattleConst.STAGE_TYPE_NEW.EQUIP_SEIZURE
		})
	end)
end

function slot0.RefreshUI(slot0)
	slot0.pointText_.text = EquipSeizureData:GetTodayMaxScore()
	slot5 = EquipSeizureData
	slot5 = slot5.GetChallengeRate
	slot0.rateText_.text = string.format("x%s", slot5(slot5))

	for slot5 = #slot0.affixItemList_, #EquipSeizureData:GetAffixIDList() + 1, -1 do
		slot0.affixItemList_[slot5]:Dispose()

		slot0.affixItemList_[slot5] = nil
	end

	for slot5 = 1, #slot1 do
		slot0.affixItemList_[slot5] = slot0.affixItemList_[slot5] or EquipSeizureAffixItem.New(slot0.affixItem_, slot0.affixParent_)

		slot0.affixItemList_[slot5]:SetData(slot1[slot5])
	end

	slot0:AddTimer()
	slot0:AddRefreshTimer()
	slot0:CheckMail()
end

function slot0.CheckMail(slot0)
	if PlayerData:GetUnclaimed(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.EQUIP_SEIZURE) ~= nil then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("UNCLAIMED_BONUS_MAIL_TIP"),
			OkCallback = function ()
				PlayerAction.ReadUnclaimedMessage(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.EQUIP_SEIZURE)
			end
		})
	end
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot0.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr2(EquipSeizureData:GetAffixRefreshTimestamp(), nil, true))
	slot0.timer_ = Timer.New(function ()
		uv0.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr2(EquipSeizureData:GetAffixRefreshTimestamp(), nil, true))
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.AddRefreshTimer(slot0)
	slot0:StopRefreshTimer()

	slot0.refreshText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr2(EquipSeizureData:NextRefreshTimestamp(), nil, true))
	slot0.refreshTimer_ = Timer.New(function ()
		uv0.refreshText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr2(EquipSeizureData:NextRefreshTimestamp(), nil, true))
	end, 1, -1)

	slot0.refreshTimer_:Start()
end

function slot0.StopRefreshTimer(slot0)
	if slot0.refreshTimer_ then
		slot0.refreshTimer_:Stop()

		slot0.refreshTimer_ = nil
	end
end

return slot0
