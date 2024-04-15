slot0 = class("MythicUltimateView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Challenge_Mythic/MythicFinalUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0._affixMonster = {}
	slot0.isStarController = ControllerUtil.GetController(slot0.transform_, "isStar")
	slot0.mosterAffixController_ = ControllerUtil.GetController(slot0.m_mosterAffixController, "affix")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		JumpTools.OpenPageByJump("mythicFinalRewardView")
	end)
	slot0:AddBtnListener(slot0.m_shopBtn, nil, function ()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.BLACK_AREA
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.m_refreshBtn, nil, function ()
		JumpTools.OpenPageByJump("popCostItem", {
			costCount = 1,
			costId = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
			content = string.format(GetTips("MYTHIC_REFRESH_CHECK"), ItemCfg[MaterialConst.MYTHIC_REFRESH_ITEM_ID].name, 1),
			itemId = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
			popCostCallBack = handler(uv0, uv0.PopCostCallBack)
		})
	end)
	slot0:AddBtnListener(slot0.m_difficultyBtn, nil, function ()
		if MythicData:GetFinalIsReward() == 0 then
			JumpTools.OpenPageByJump("mythicDifficulty")
		end
	end)
	slot0:AddBtnListener(slot0.m_startBtn, nil, function ()
		if MythicData:GetIsBattleIng() then
			gameContext:Go("/mythicFinalTeamView")
		else
			JumpTools.OpenPageByJump("mythicFinalLevelView")
		end
	end)
	slot0:AddBtnListener(slot0.m_rankBtn, nil, function ()
		JumpTools.OpenPageByJump("/mythicFinalRankView", {
			reset = true
		})
	end)
end

function slot0.OnEnter(slot0)
	getSpriteWithoutAtlas("TextureConfig/Item_l/40701")
	slot0:RegistEventListener(MATERIAL_MODIFY, handler(slot0, slot0.RefreshMaterial))

	if not RankData:GetCommonRank(RankConst.RANK_ID.MYTHIC) then
		RankAction.QueryOwnCommonRank(RankConst.RANK_ID.MYTHIC)
	end

	slot0:RefreshUI()

	slot0.cdText_.text = string.format(GetTips("TIME_DISPLAY_9"), "" .. manager.time:GetLostTimeStrWith2Unit(MythicData:GetNextRefreshTime()))
	slot0.updateTimer_ = Timer.New(function ()
		uv0.cdText_.text = string.format(GetTips("TIME_DISPLAY_9"), "" .. manager.time:GetLostTimeStrWith2Unit(MythicData:GetNextRefreshTime()))
	end, 1, -1)

	slot0.updateTimer_:Start()
	manager.redPoint:bindUIandKey(slot0.m_rewardBtn.transform, RedPointConst.MYTHIC_FINAL_AWARD)
end

function slot0.PopCostCallBack(slot0)
	if MythicData:GetFinalRewardNotGet() then
		ShowTips("ERROR_BATTLE_MYTHIC_REWARD_NO_RECEIVED")

		return
	end

	CommonAction.TryToUseItem({
		{
			item_info = {
				num = 1,
				id = MaterialConst.MYTHIC_REFRESH_ITEM_ID
			},
			use_list = {}
		}
	})
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("MYTHIC_FINAL_DESC")
	MythicData:SetIsNew(false)
	slot0:RefreshUI()
	slot0:CheckDifficultyChange()
end

function slot0.OnMyticUpdate(slot0)
	slot0:RefreshUI()

	if MythicData:GetDifficulty() == 0 then
		JumpTools.OpenPageByJump("/mythicUltimateView/mythicDifficulty", nil)
	end
end

function slot0.OnMythicFinalGetReward(slot0)
	slot0:RefreshUI()
end

function slot0.OnMythicFinalUpdate(slot0)
	slot0:RefreshUI()
end

function slot0.OnTryToUseItem(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		MythicAction.QueryMythicInfo()
	else
		ShowTips(slot1.result)
	end
end

function slot0.CheckDifficultyChange(slot0)
	if MythicData:GetIsNewDifficulty() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_NEW_LEVEL_UNLOCK"),
			OkCallback = function ()
				MythicAction:QueryMythicRead()
				uv0:CheckMail()
			end
		})
	elseif MythicData:GetIsNewHotLevel() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_FINAL_LEVEL_UNLOCK"),
			OkCallback = function ()
				MythicAction:QueryMythicFinalRead()
				uv0:CheckMail()
			end
		})
	else
		slot0:CheckMail()
	end
end

function slot0.CheckMail(slot0)
	if PlayerData:GetUnclaimed(3) ~= nil then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("UNCLAIMED_BONUS_MAIL_TIP"),
			OkCallback = function ()
				PlayerAction.ReadUnclaimedMessage(3)

				if MythicData:IsShowDifficultySelectView() then
					TimeTools.StartAfterSeconds(0.033, function ()
						JumpTools.OpenPageByJump("mythicDifficulty")
					end, {})
				end
			end
		})
	end
end

function slot0.RefreshUI(slot0)
	slot0:RefreshMaterial()

	if MythicData:GetFinalIsReward() == 0 then
		slot0.isStarController:SetSelectedIndex(0)
	else
		slot0.isStarController:SetSelectedIndex(1)
	end

	slot0.levelText_.text = string.format(MythicFinalCfg[MythicData:GetCurHotLevelId()].level_diffuculty)

	slot0:RefreshAffixItems(MythicData:GetFinalMonsterAffix(), false, slot0._affixMonsterParent, slot0._affixMonster, slot0.mosterAffixController_)
	slot0:RefreshRank()
end

function slot0.RefreshMaterial(slot0)
	slot0.m_refreshCountText.text = "x1"

	if ItemTools.getItemNum(MaterialConst.MYTHIC_REFRESH_ITEM_ID) > 0 then
		SetActive(slot0.m_refreshBtn.gameObject, true)
	else
		SetActive(slot0.m_refreshBtn.gameObject, false)
	end
end

function slot0.RefreshAffixItems(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = {}
	slot8 = math.min(#(slot1 or {}), 3)

	for slot12, slot13 in ipairs(slot1) do
		slot14 = clone(slot13)
		slot14.lock = false
		slot7 = 0 + 1

		table.insert(slot6, slot14)
	end

	slot13 = "_"
	slot12 = slot8 .. slot13 .. slot7

	slot5:SetSelectedState(slot12)

	for slot12, slot13 in ipairs(slot6) do
		slot0["affixname_" .. slot12].text = getAffixName(slot13)
		slot0["affixdes_" .. slot12].text = getAffixDesc(slot13)
		slot0["affiximage_" .. slot12].sprite = getAffixSprite(slot13)
	end

	for slot12 = #slot6 + 1, #slot4 do
		slot4[slot12]:Show(false)
	end
end

function slot0.ShowAffixInfo(slot0, slot1, slot2)
	slot0.affixinfoTrs_:SetParent(slot1)

	slot0.affixinfoTrs_.localPosition = Vector3(0, -60, 0)

	SetActive(slot0.affixinfoTrs_.gameObject, true)

	slot0.affixcontentTrs_.transform.localPosition = Vector3(261.505, slot0.affixcontentTrs_.transform.localPosition.y, 0)

	if slot0.endPoint_:TransformPoint(Vector3(0, 0, 0)).x <= slot0.affixcontentTrs_:TransformPoint(Vector3(0, 0, 0)).x then
		slot0.affixcontentTrs_.transform.localPosition = Vector3(slot0.affixinfoTrs_:InverseTransformPoint(slot4).x, slot3.y, 0)
	else
		slot0.affixcontentTrs_.transform.localPosition = Vector3(261.505, slot3.y, 0)
	end

	slot0.affixcontentText_.text = getAffixDesc(slot2)
	slot0.affixnameText_.text = getAffixName(slot2)

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.affixcontentTrs_)

	if slot0.countdownTimer_ then
		slot0.countdownTimer_:Stop()

		slot0.countdownTimer_ = nil
	end

	slot0.countdownTimer_ = Timer.New(function ()
		SetActive(uv0.affixinfoTrs_.gameObject, false)
	end, 2, 1)

	slot0.countdownTimer_:Start()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(slot0.m_rewardBtn.transform, RedPointConst.MYTHIC_FINAL_AWARD)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0._affixMonster) do
		slot5:Dispose()
	end

	slot0._affixMonster = {}

	slot0.super.Dispose(slot0)
end

function slot0.OnMatrixCurRankUpdate(slot0)
	slot0:RefreshRank()
end

function slot0.RefreshRank(slot0)
	if RankData:GetCommonRank(RankConst.RANK_ID.MYTHIC) and slot1.curRank and slot2.rank ~= 0 then
		slot0.m_score.text = slot2.score
	else
		slot0.m_score.text = GetTips("MATRIX_RANK_NO_INFO")
	end
end

function slot0.OnMythicCurRankUpdate(slot0)
	slot0:RefreshRank()
end

function slot0.OnRankUpdate(slot0)
	slot0:RefreshRank()
end

return slot0
