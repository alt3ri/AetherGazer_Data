slot0 = class("PushBoxView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/JapanRegionUI_2_10AnniversaryBoxPlayUI"
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

	slot0.guideTitleTip_ = {
		GetTips("BOX_PUZZLE_TIPS1_1"),
		GetTips("BOX_PUZZLE_TIPS2_1"),
		GetTips("BOX_PUZZLE_TIPS3_1"),
		GetTips("BOX_PUZZLE_TIPS4_1")
	}
	slot0.guideDescTip_ = {
		GetTips("BOX_PUZZLE_TIPS1_2"),
		GetTips("BOX_PUZZLE_TIPS2_2"),
		GetTips("BOX_PUZZLE_TIPS3_2"),
		GetTips("BOX_PUZZLE_TIPS4_2")
	}
	slot0.onStopHandler_ = handler(slot0, slot0.OnStop)
	slot0.onSelectHandler_ = handler(slot0, slot0.OnSelect)
	slot0.onActionHandler_ = handler(slot0, slot0.OnAction)
	slot0.onResetHandler_ = handler(slot0, slot0.OnReset)
	slot0.boxItem_ = {}
	slot0.cellItem_ = {}
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		JumpTools.OpenPageByJump("activityPushBoxReset", {
			activityID = uv0.activityID_
		})
	end)
	slot0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.BeginDrag)))
	slot0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.EndDrag)))
end

function slot0.BeginDrag(slot0, slot1, slot2)
	slot0.pressPos_ = slot2.position
end

function slot0.EndDrag(slot0, slot1, slot2)
	if not slot0.pressPos_ then
		return
	end

	if not slot0.boxItem_[slot0.curBoxIndex_] then
		return
	end

	SetActive(slot0.aniGo_, false)
	SetActive(slot0.guideGo_, false)
	slot0:CalDir(slot0.pressPos_, slot2.position)
end

function slot0.CalDir(slot0, slot1, slot2)
	if slot0.isAction_ then
		return
	end

	slot3 = slot2.x - slot1.x
	slot4 = slot2.y - slot1.y

	if slot3 * slot3 + slot4 * slot4 < 0.001 then
		return
	end

	slot0.isAction_ = true

	if math.abs(slot3) / UnityEngine.Screen.width > math.abs(slot4) / UnityEngine.Screen.height then
		if slot3 > 0 then
			PushBoxTool:OperateMove(1, 0, slot0.curBoxIndex_)
		else
			PushBoxTool:OperateMove(-1, 0, slot0.curBoxIndex_)
		end
	elseif slot4 > 0 then
		PushBoxTool:OperateMove(0, -1, slot0.curBoxIndex_)
	else
		PushBoxTool:OperateMove(0, 1, slot0.curBoxIndex_)
	end
end

function slot0.OnEnter(slot0)
	slot0:RegisterListener()

	slot0.guideIndex_ = 0

	slot0:InitData()
	slot0:InitMap()
	slot0:ResetType()
	slot0:RefreshUI()
	slot0.guideGo_.transform:SetAsLastSibling()
end

function slot0.InitData(slot0)
	slot0.id_ = slot0.params_.map_id
	slot0.activityID_ = slot0.params_.activityID
	slot0.goalTotal_ = 0
	slot0.cfg_ = ActivityCelebrationGameCfg[slot0.id_]

	for slot5, slot6 in ipairs(ActivityCelebrationBoxCfg.get_id_list_by_mapId[slot0.cfg_.mapId]) do
		if ActivityCelebrationBoxCfg[slot6].type == PushBoxConst.CELL_TYPE.GOAL then
			slot0.goalTotal_ = slot0.goalTotal_ + 1
		end
	end

	slot0.pressPos_ = nil
end

function slot0.InitMap(slot0)
	slot4 = slot0.id_
	slot5 = slot0.cellPanel_
	slot0.boxItem_, slot0.cellItem_, slot0.goalTbl_ = PushBoxTool:InitMap(slot4, slot5, slot0.boxPanel_, slot0.mapContent_, slot0.cellTemplate_, slot0.boxTemplate_)

	for slot4, slot5 in ipairs(slot0.boxItem_) do
		slot5:RegistDragFunc(function (slot0, slot1)
			SetActive(uv0.guideGo_, false)
			SetActive(uv0.aniGo_, false)
			uv0:CalDir(slot0, slot1)
		end)
	end
end

function slot0.ResetType(slot0)
	slot0.goalCnt_ = 0
	slot0.curBoxIndex_ = 1
	slot0.isAction_ = false

	PushBoxTool:SetStartTime()
	slot0:OnStop()
	slot0:RefreshBox()
end

function slot0.RefreshBox(slot0)
	for slot4 = 1, #slot0.cfg_.box_list do
		if slot0.boxItem_[slot4] then
			slot0.boxItem_[slot4]:SetSelect(slot4 == slot0.curBoxIndex_)
		end
	end
end

function slot0.RefreshUI(slot0)
	slot0.destID_ = slot0.params_.id
	slot0.title_.text = ActivityCelebrationOrderCfg[slot0.destID_].order_title

	slot0:RefreshGoal()
end

function slot0.RefreshGoal(slot0)
	slot0.goal_.text = slot0.goalCnt_ .. "/" .. slot0.goalTotal_
end

function slot0.EndGame(slot0)
	if table.indexof(ActivityPushBoxData:GetFinishList(slot0.activityID_), slot0.destID_) then
		PushBoxTool:SendSdk(slot0.activityID_, slot0.id_, 1)
		JumpTools.OpenPageByJump("pushBoxResult", {
			activityID = slot0.activityID_,
			rewardList = {}
		})
	else
		ActivityPushBoxAction.FinishPushBox(slot0.activityID_, slot0.destID_)
	end
end

function slot0.CheckGuide(slot0)
	if #ActivityPushBoxData:GetFinishList(slot0.activityID_) > 0 or slot0.guideIndex_ >= #slot0.guideTitleTip_ then
		SetActive(slot0.guideGo_, false)
		SetActive(slot0.aniGo_, false)

		return
	end

	if slot0.boxItem_[slot0.curBoxIndex_] then
		slot2 = slot0.boxItem_[slot0.curBoxIndex_].transform_
		slot3 = slot2.localPosition
		slot6 = slot2.rect.width * slot2.localScale.x / 2
		slot0.guideGo_.transform.localPosition = Vector3.New(slot3.x + slot6, slot3.y + slot6, slot3.z)
	end

	SetActive(slot0.guideGo_, true)

	slot0.guideIndex_ = slot0.guideIndex_ + 1
	slot0.guideTitle_.text = slot0.guideTitleTip_[slot0.guideIndex_]
	slot0.guideDesc_.text = slot0.guideDescTip_[slot0.guideIndex_]

	SetActive(slot0.aniGo_, true)

	if slot0.guideIndex_ == 1 then
		slot0.aniGo_.transform:SetParent(slot0.boxItem_[slot0.curBoxIndex_].transform_, false)
	elseif slot0.guideIndex_ == 2 then
		slot0.aniGo_.transform:SetParent(slot0.boxItem_[slot0.curBoxIndex_].transform_, false)
	elseif slot0.guideIndex_ == 3 then
		if slot0.cellItem_[slot0.goalTbl_[1]] then
			slot0.aniGo_.transform:SetParent(slot0.cellItem_[slot2].transform_, false)
		end
	elseif slot0.guideIndex_ == 4 then
		slot0.aniGo_.transform:SetParent(slot0.resetBtnRect_, false)
	end

	slot0.aniRect_:SetAsFirstSibling()

	slot0.aniRect_.anchorMin = Vector3.zero
	slot0.aniRect_.anchorMax = Vector3.one
	slot0.aniRect_.offsetMin = Vector2.New(0, 0)
	slot0.aniRect_.offsetMax = Vector2.New(0, 0)

	slot0.ani_:Play("Box_glow", -1, 0)
end

function slot0.OnStop(slot0)
	slot0:CheckGuide()
	slot0:RefreshBox()

	slot0.isAction_ = false
	slot4 = slot0.curBoxIndex_

	slot0:BoxStop(slot4)

	for slot4 = 1, #slot0.cfg_.box_list do
		if slot0.isAction_ then
			return
		end

		if slot4 ~= slot0.curBoxIndex_ then
			slot0:BoxStop(slot4)
		end
	end

	slot0:CalGoal()
end

function slot0.BoxStop(slot0, slot1)
	if slot0.boxItem_[slot1] then
		slot3, slot4 = slot2:GetCoordinate()

		slot0.cellItem_[PushBoxTool:GetCellIndex(slot3, slot4)]:OnStop()
	end
end

function slot0.OnSelect(slot0, slot1)
	if slot0.isAction_ then
		return
	end

	if slot0.curBoxIndex_ == slot1 then
		return
	end

	slot0:CheckGuide()

	slot0.curBoxIndex_ = slot1

	slot0:RefreshBox()
end

function slot0.CalGoal(slot0)
	for slot5 = 1, #slot0.cfg_.box_list do
		if slot0.boxItem_[slot5] then
			slot7, slot8 = slot6:GetCoordinate()

			if slot0.cellItem_[PushBoxTool:GetCellIndex(slot7, slot8)]:GetType() == PushBoxConst.CELL_TYPE.GOAL then
				slot1 = 0 + 1
			end
		end
	end

	slot0.goalCnt_ = slot1

	slot0:RefreshGoal()

	if slot0.goalCnt_ == slot0.goalTotal_ then
		slot0:EndGame()
	end
end

function slot0.OnAction(slot0, slot1, slot2, slot3, slot4)
	if slot0.isAction_ then
		return
	end

	slot0.isAction_ = true

	for slot8 = 1, #slot0.cfg_.box_list do
		if slot0.boxItem_[slot8] then
			slot10, slot11 = slot9:GetCoordinate()

			if slot10 == slot3 and slot11 == slot4 then
				slot0.curBoxIndex_ = slot8

				slot0:RefreshBox()
				PushBoxTool:OperateMove(slot1, slot2, slot0.curBoxIndex_)

				break
			end
		end
	end
end

function slot0.OnReset(slot0)
	PushBoxTool:SendSdk(slot0.activityID_, slot0.id_, 4)
	slot0:InitData()
	slot0:InitMap()
	slot0:ResetType()
end

function slot0.RegisterListener(slot0)
	manager.notify:RegistListener(PUSH_BOX_STOP, slot0.onStopHandler_)
	manager.notify:RegistListener(PUSH_BOX_SELECT, slot0.onSelectHandler_)
	manager.notify:RegistListener(PUSH_BOX_ACTION, slot0.onActionHandler_)
	manager.notify:RegistListener(PUSH_BOX_RESET, slot0.onResetHandler_)
end

function slot0.RemoveListener(slot0)
	manager.notify:RemoveListener(PUSH_BOX_STOP, slot0.onStopHandler_)
	manager.notify:RemoveListener(PUSH_BOX_SELECT, slot0.onSelectHandler_)
	manager.notify:RemoveListener(PUSH_BOX_ACTION, slot0.onActionHandler_)
	manager.notify:RemoveListener(PUSH_BOX_RESET, slot0.onResetHandler_)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		JumpTools.OpenPageByJump("activityPushBoxQuit", {
			way = "back",
			activityID = uv0.activityID_,
			id = uv0.id_
		})
	end)
	manager.windowBar:RegistHomeCallBack(function ()
		JumpTools.OpenPageByJump("activityPushBoxQuit", {
			way = "home",
			activityID = uv0.activityID_,
			id = uv0.id_
		})
	end)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveListener()

	for slot4, slot5 in ipairs(slot0.cellItem_) do
		slot5:OnExit()
	end

	for slot4, slot5 in ipairs(slot0.boxItem_) do
		slot5:OnExit()
	end

	PushBoxTool:OnExit()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.onStopHandler_ = nil
	slot0.onSelectHandler_ = nil
	slot0.onActionHandler_ = nil
	slot0.onResetHandler_ = nil

	for slot4, slot5 in ipairs(slot0.cellItem_) do
		slot5:Dispose()
	end

	slot0.cellItem_ = {}

	for slot4, slot5 in ipairs(slot0.boxItem_) do
		slot5:Dispose()
	end

	slot0.boxItem_ = {}
	slot0.goalTbl_ = {}

	PushBoxTool:Dispose()
	slot0.super.Dispose(slot0)
end

return slot0
