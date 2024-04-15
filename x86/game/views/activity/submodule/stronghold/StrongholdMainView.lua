slot0 = class("StrongholdMainView", ReduxView)

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/StrongholdMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.difficultyList = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_difficultyList, StrongholdMainDifficultyItem)
	slot0.itemClickHandler = handler(slot0, slot0.OnItemClick)
	slot0.matchTime = 0
	slot0.colorController = ControllerUtil.GetController(slot0.transform_, "color")
	slot0.matchController = ControllerUtil.GetController(slot0.transform_, "match")

	slot0.matchController:SetSelectedIndex(0)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_createRoomBtn, function ()
		if not ActivityTools.GetActivityIsOpenWithTip(uv0.selectId) then
			return
		end

		if CooperationData:GetRoomData() then
			CooperationTools.GotoCooperation()
		else
			if CooperationData:GetIsMatching() then
				ShowTips("ERROR_COORDINATOR_ALREADY_IN_MATCH")

				return
			end

			CooperationAction.CreateRoom(uv0.selectId, BattleConst.STAGE_TYPE_NEW.STRONGHOLD, {
				CooperationData:GetCooperationHero(BattleConst.STAGE_TYPE_NEW.STRONGHOLD, uv0.selectId, uv0.selectId)
			}, uv0.selectId)
		end
	end)
	slot0:AddBtnListener(nil, slot0.m_quickJoinBtn, function ()
		if CooperationData:GetIsMatching() then
			CooperationAction.CancelMatching()
		else
			if not ActivityTools.GetActivityIsOpenWithTip(uv0.selectId) then
				return
			end

			CooperationAction.StartMatching(uv0.selectId, BattleConst.STAGE_TYPE_NEW.STRONGHOLD, {
				CooperationData:GetCooperationHero(BattleConst.STAGE_TYPE_NEW.STRONGHOLD, uv0.selectId, uv0.selectId)
			}, uv0.selectId)
		end
	end)
	slot0:AddBtnListener(nil, slot0.m_inviteBtn, function ()
		JumpTools.OpenPageByJump("cooperationApply", {
			selectIndex = BattleConst.STAGE_TYPE_NEW.STRONGHOLD
		})
	end)
	slot0:AddBtnListener(nil, slot0.m_taskBtn, function ()
		JumpTools.OpenPageByJump("/strongholdOperate", {
			selectIndex = 1,
			activity_id = uv0.activity_id
		})
	end)
	slot0:AddBtnListener(nil, slot0.m_skillBtn, function ()
		JumpTools.OpenPageByJump("/strongholdOperate", {
			selectIndex = 2,
			activity_id = uv0.activity_id
		})
	end)
	slot0:AddBtnListener(nil, slot0.m_increaseBtn, function ()
		JumpTools.OpenPageByJump("/strongholdOperate", {
			selectIndex = 3,
			activity_id = uv0.activity_id
		})
	end)
	slot0:AddBtnListener(nil, slot0.m_rewardBtn, function ()
		JumpTools.OpenPageByJump("/strongholdOperate", {
			selectIndex = 4,
			activity_id = uv0.activity_id
		})
	end)
	slot0:AddBtnListener(nil, slot0.m_atlasBtn, function ()
		JumpTools.OpenPageByJump("strongholdAtlas", {
			activity_id = uv0.activity_id
		})
	end)
	slot0:AddBtnListener(nil, slot0.m_teachBtn, function ()
		uv0:Go("/sectionSelectHeroTeach", {
			section = BattleConst.COOPERATION_STRONGHOLD_TEACH_STAGE_ID,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING
		})
	end)
	slot0:AddBtnListener(nil, slot0.m_operateBtn, function ()
		JumpTools.OpenPageByJump("strongholdOperate", {
			selectIndex = 1,
			activity_id = uv0.activity_id
		})
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INVITE_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_STRONGHOLD_DES")
end

function slot0.OnEnter(slot0)
	slot0.activity_id = ActivityConst.ACTIVITY_STRONGHOLD
	slot0.stronghold_stage_activity_list = {}

	for slot5, slot6 in ipairs(ActivityCfg[slot0.activity_id].sub_activity_list) do
		if ActivityTemplateConst.STRONGHOLD_STAGE == ActivityCfg[slot6].activity_template then
			table.insert(slot0.stronghold_stage_activity_list, slot6)
		end
	end

	if slot0.selectId == nil then
		slot0.selectId = slot0.stronghold_stage_activity_list[1]
	end

	if slot0.selectId == 182203 then
		slot0.colorController:SetSelectedIndex(1)
	else
		slot0.colorController:SetSelectedIndex(0)
	end

	slot0.difficultyList:StartScroll(#slot0.stronghold_stage_activity_list)

	slot0.m_lvLab.text, slot3 = StrongholdData:GetStrongholdLevelAndIncreasePoint(slot0.activity_id)

	slot0:RefreshUI()

	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:RefreshTime()
		end, 1, -1)
	end

	slot0.timer_:Start()
	slot0:RefreshTime()
	manager.redPoint:bindUIandKey(slot0.m_taskBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_TASK, slot0.activity_id))
	manager.redPoint:bindUIandKey(slot0.m_increaseBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_INCREASE, slot0.activity_id))
	manager.redPoint:bindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_REWARD, slot0.activity_id))
	manager.redPoint:bindUIandKey(slot0.m_operateBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD, slot0.activity_id))
	manager.redPoint:bindUIandKey(slot0.m_inviteBtn.transform, RedPointConst.COOPERATION_INVIT)
end

function slot0.RefreshUI(slot0)
	slot0.m_matchingLab.text = CooperationData:GetIsMatching() and GetTips("COOPERATION_CANCEL_MATCH") or GetTips("COOPERATION_START_MATCH")
	slot0.matchTime = 0
	slot0.m_matchingTime.text = ""

	slot0.matchController:SetSelectedIndex(slot1 and 1 or 0)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if CooperationData:GetIsMatching() then
		CooperationAction.CancelMatching()
	end

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	manager.redPoint:unbindUIandKey(slot0.m_taskBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_TASK, slot0.activity_id))
	manager.redPoint:unbindUIandKey(slot0.m_increaseBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_INCREASE, slot0.activity_id))
	manager.redPoint:unbindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_REWARD, slot0.activity_id))
	manager.redPoint:unbindUIandKey(slot0.m_operateBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD, slot0.activity_id))
	manager.redPoint:unbindUIandKey(slot0.m_inviteBtn.transform, RedPointConst.COOPERATION_INVIT)
	slot0.matchController:SetSelectedIndex(0)
end

function slot0.RefreshTime(slot0)
	if ActivityData:GetActivityData(slot0.activity_id) and slot1:IsActivitying() then
		slot0.m_timeLab.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr(slot1.stopTime)
	else
		slot0.m_timeLab.text = GetTips("TIME_OUT")
	end

	for slot6, slot7 in pairs(slot0.difficultyList:GetItemList()) do
		slot7:RefreshTime()
	end

	if CooperationData:GetIsMatching() then
		slot0.matchTime = slot0.matchTime + 1
		slot0.m_matchingTime.text = string.format(GetTips("COOPERATION_MATCHING"), slot0.matchTime)
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.activity_id, slot0.stronghold_stage_activity_list[slot1])
	slot2:SetSelect(slot0.selectId)
	slot2:RegistCallBack(slot0.itemClickHandler)
end

function slot0.OnItemClick(slot0, slot1)
	slot0.selectId = slot1

	slot0.difficultyList:Refresh()

	if slot1 == 182203 then
		slot0.colorController:SetSelectedIndex(1)
	else
		slot0.colorController:SetSelectedIndex(0)
	end
end

function slot0.Dispose(slot0)
	slot0.difficultyList:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnCooperationIsMatchingChange(slot0)
	slot0:RefreshUI()
end

function slot0.OnStrongholdUpgradeIncrease(slot0)
	slot0.difficultyList:Refresh()
end

return slot0
