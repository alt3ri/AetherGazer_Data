slot0 = class("TangramPuzzlePlayView", ReduxView)

function slot0.UIName(slot0)
	return TangramPuzzleTools.GetPlayViewUIName(slot0.params_.activityID)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.puzzleItemList_ = {}
	slot0.puzzleGlobalIndexListByRegionTypeAndLocalIndex_ = {}
	slot0.regionContentItemList_ = {}
	slot0.regionItemList_ = {}
	slot0.clueItemList_ = {}
	slot0.statusConst_ = {
		PLAY = 0,
		EDIT = 1,
		FINAL = 2,
		NONE = -1
	}

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.autoPutBtnController_ = ControllerUtil.GetController(slot0.autoBtn_.transform, "status")
	slot0.finalRewardController_ = ControllerUtil.GetController(slot0.finalRewardPanelTrans_, "status")
	slot0.dragController_ = ControllerUtil.GetController(slot0.transform_, "drag")
	slot0.beginDragPuzzleHandler_ = handler(slot0, slot0.OnBeginDragPuzzle)
	slot0.endDragPuzzleHandler_ = handler(slot0, slot0.OnDragPuzzleEnd)
	slot0.onClickPuzzleHandler_ = handler(slot0, slot0.OnClickPuzzle)

	slot0:InitAnimNode()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.exitEditBtn_, nil, function ()
		uv0:ExitEdit()
		uv0:SwitchToPlay()
	end)
	slot0:AddBtnListener(slot0.rollClockwiseBtn_, nil, function ()
		if not uv0.editPuzzleIndex_ then
			ShowTips("ACTIVITY_PUZZLE_III_SELECT")

			return
		end

		slot1, slot2 = uv0.puzzleItemList_[uv0.editPuzzleIndex_]:GetCurRegion()

		TangramPuzzleAction.RotateRegion(uv0.activityID_, slot1, 1)
	end)
	slot0:AddBtnListener(slot0.rollAntiClockwiseBtn_, nil, function ()
		if not uv0.editPuzzleIndex_ then
			ShowTips("ACTIVITY_PUZZLE_III_SELECT")

			return
		end

		slot1, slot2 = uv0.puzzleItemList_[uv0.editPuzzleIndex_]:GetCurRegion()

		TangramPuzzleAction.RotateRegion(uv0.activityID_, slot1, -1)
	end)
	slot0:AddBtnListener(slot0.autoBtn_, nil, function ()
		if not uv0:IsActivityTime() then
			return
		end

		if uv0.isPlayingFirstTips_ == true then
			uv0:ClickFirstTips()
		end

		slot0 = uv0.puzzleCfg_.coin_id[1]

		if ItemTools.getItemNum(slot0[1]) < slot0[2] then
			ShowTips("ACTIVITY_PUZZLE_III_NOT_ENOUGH")

			return
		end

		for slot8, slot9 in pairs(TangramPuzzleTools.GetRegionCfg(uv0.activityID_)) do
			if not TangramPuzzleData:GetUnlockRegionDic(uv0.activityID_)[slot8] then
				ShowTips("ACTIVITY_PUZZLE_III_AUTO_AREA")

				return
			end
		end

		slot5 = false

		for slot9, slot10 in pairs(slot4) do
			if TangramPuzzleTools.CheckWrongSideByRegionID(uv0.activityID_, slot9) then
				slot5 = true

				break
			end
		end

		if slot5 == true then
			TangramPuzzleAction.Operation(uv0.activityID_, TangramPuzzleAction.OPERATION_TYPE.FULL_AUTO_PUT)
		end
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if not uv0:IsActivityTime() then
			return
		end

		manager.windowBar:HideBar()
		JumpTools.OpenPageByJump("tangramPuzzleReward", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.firstTipsBtn_, nil, function ()
		uv0:ClickFirstTips()
	end)

	slot0.clueMaskListener_.isPassEvent = true
	slot0.clueMaskListener_.isPassAll = false
	slot0.clueMaskListener_.isExecuteHierarchy = true

	slot0.clueMaskListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(handler(slot0, slot0.OnClickClueMask)))
end

function slot0.ClickFirstTips(slot0)
	slot0.isPlayingFirstTips_ = false

	TangramPuzzleData:SetFirstTips(slot0.activityID_, true)
	SetActive(slot0.firstTipsPanelGo_, false)
end

function slot0.OnEnter(slot0)
	slot1 = ActivityData:GetActivityData(slot0.params_.activityID)
	slot0.startTime_ = slot1.startTime
	slot0.stopTime_ = slot1.stopTime

	if slot0.activityID_ ~= slot0.params_.activityID then
		slot0.activityID_ = slot0.params_.activityID
		slot0.puzzleCfg_ = TangramPuzzleCfg[slot0.params_.activityID]

		slot0:Spawn()
	end

	slot0:RefreshUI()
	SetActive(slot0.maskGo_, false)
	SetActive(slot0.autoPutPanelGo_, false)
	slot0.dragController_:SetSelectedState("false")

	slot2, slot3 = slot0:CheckFirstEnter()

	if slot2 == true then
		for slot7, slot8 in ipairs(slot3) do
			TangramPuzzleData:SetFirstEnterRegionType(slot0.activityID_, slot8, true)
		end

		slot0:PlayFirstEnterAnim(slot3)
	elseif TangramPuzzleData:GetFirstTips(slot0.activityID_) ~= true then
		SetActive(slot0.firstEnterPanelGo_, false)
		slot0:PlayFirstTipsAnim()
	else
		SetActive(slot0.firstEnterPanelGo_, false)
		SetActive(slot0.firstTipsPanelGo_, false)

		slot0.isPlayingFirstTips_ = false
	end

	slot0:AddTimer()
	slot0:RegistEventListener(ACTIVITY_UPDATE, handler(slot0, slot0.OnPuzzleActivityUpdate))
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:ExitEdit()
	slot0:StopTimer()

	if slot0.animtimer_ ~= nil then
		slot0.animtimer_:Stop()

		slot0.animtimer_ = nil
	end

	if slot0.firstAnimTimer_ then
		slot0.firstAnimTimer_:Stop()

		slot0.firstAnimTimer_ = nil
	end

	slot0:StopAnimNode()

	for slot4, slot5 in pairs(slot0.regionContentItemList_) do
		slot5:OnExit()
	end

	for slot4, slot5 in pairs(slot0.regionItemList_) do
		slot5:OnExit()
	end

	for slot4, slot5 in pairs(slot0.puzzleItemList_) do
		slot5:OnExit()
	end

	slot0:RemoveAllEventListener()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		slot0.puzzleCfg_.coin_id[1][1]
	})
	manager.windowBar:SetBarCanClick(slot0.puzzleCfg_.coin_id[1][1], true)
	manager.windowBar:RegistBackCallBack(function ()
		uv0:OnClickClueMask()
		JumpTools.Back()
	end)
	manager.windowBar:RegistHomeCallBack(function ()
		uv0:OnClickClueMask()
		gameContext:Go("/home", nil, , true)
	end)
	manager.windowBar:RegistInfoCallBack(function ()
		uv0:OnClickClueMask()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = string.format(GetTips("ACTIVITY_PUZZLE_III_EXPLAIN"), ItemTools.getItemName(uv0.puzzleCfg_.coin_id[1][1]))
		})
	end)
end

function slot0.Dispose(slot0)
	slot0.beginDragPuzzleHandler_ = nil
	slot0.endDragPuzzleHandler_ = nil
	slot0.onClickPuzzleHandler_ = nil

	slot0.clueMaskListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerClick)
	slot0:DespawnPuzzle()
	slot0:DespawnClue()
	slot0:DisposeAnimNode()
	uv0.super.Dispose(slot0)
end

function slot0.Spawn(slot0)
	slot0:DespawnPuzzle()
	slot0:SpawnPuzzle()
	slot0:DespawnClue()
	slot0:SpawnClue()
end

function slot0.RefreshUI(slot0)
	if not TangramPuzzleTools.CheckRegionAllRight(slot0.activityID_) then
		slot0:SwitchToPlay()
		slot0:CheckRegionReward()
	else
		slot0:SwitchToFinal()
		slot0:CheckFinalReward()
	end

	slot0.completeImg_.sprite = getSpriteWithoutAtlas(slot0.puzzleCfg_.path .. slot0.puzzleCfg_.album_id)
end

function slot0.SwitchToPlay(slot0)
	slot0.curStatus_ = slot0.statusConst_.PLAY

	slot0.statusController_:SetSelectedIndex(slot0.curStatus_)
	slot0:RefreshPlayUI()
end

function slot0.SwitchToEdit(slot0)
	slot0.curStatus_ = slot0.statusConst_.EDIT

	slot0.statusController_:SetSelectedIndex(slot0.curStatus_)
	slot0:RefreshEditUI()
end

function slot0.SwitchToFinal(slot0)
	slot0.curStatus_ = slot0.statusConst_.FINAL

	slot0.statusController_:SetSelectedIndex(slot0.curStatus_)
	slot0:RefreshFinalUI()
end

function slot0.RefreshPlayUI(slot0)
	slot0:RefreshRegionContentList()
	slot0:RefreshRegionList()
	slot0:RefreshPuzzleList()
	slot0:RefreshClueList()
	slot0:RefreshAutoPutCost()
end

function slot0.RefreshEditUI(slot0)
	slot1 = slot0.puzzleItemList_[slot0.editPuzzleIndex_]

	slot1:SetSelect(true)

	slot2, slot3 = slot1:GetCurRegion()
	slot0.curValidPuzzleList_ = slot0.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[TangramPuzzleTools.GetRegionType(slot0.activityID_, slot2)][slot3]

	for slot8, slot9 in ipairs(slot0.curValidPuzzleList_) do
		if slot0.puzzleItemList_[slot9] ~= slot1 then
			slot10:SetHighLight(true)
		end
	end
end

function slot0.CanEnterEdit(slot0, slot1)
	slot3, slot4 = slot0.puzzleItemList_[slot1]:GetCurRegion()

	if TangramPuzzleTools.CheckRegionAllRightByType(slot0.activityID_, TangramPuzzleTools.GetRegionType(slot0.activityID_, slot3)) then
		return false
	end

	return true
end

function slot0.EnterEdit(slot0, slot1)
	slot0.editPuzzleIndex_ = slot1

	slot0:SwitchToEdit()
end

function slot0.ExitEdit(slot0)
	if slot0.curStatus_ == slot0.statusConst_.EDIT then
		slot0:ResetEditPuzzle()

		slot0.curStatus_ = slot0.statusConst_.NONE
	end
end

function slot0.SwitchEditTarget(slot0, slot1)
	if slot0.curStatus_ == slot0.statusConst_.EDIT then
		slot0:ResetEditPuzzle()

		slot0.editPuzzleIndex_ = slot1

		slot0:RefreshEditUI()
	end
end

function slot0.ResetEditPuzzle(slot0)
	if slot0.curValidPuzzleList_ then
		for slot4, slot5 in ipairs(slot0.curValidPuzzleList_) do
			slot0.puzzleItemList_[slot5]:SetHighLight(false)
		end

		slot0.curValidPuzzleList_ = nil
	end

	if slot0.editPuzzleIndex_ then
		slot0.puzzleItemList_[slot0.editPuzzleIndex_]:SetSelect(false)

		slot0.editPuzzleIndex_ = nil
	end
end

function slot0.RefreshFinalUI(slot0)
	slot0:RefreshClueList()

	slot0.finalRewardIcon_.sprite = ItemTools.getItemSprite(slot0.puzzleCfg_.final_reward[1][1])

	if TangramPuzzleTools.IsAllClueCompleted(slot0.activityID_) then
		if TangramPuzzleData:GetRegionReceivedDic(slot0.activityID_)[0] then
			slot0.finalRewardTipsText_.text = string.format(GetTips("ACTIVITY_PUZZLE_III_FINALREWARD_GET"), slot0.puzzleCfg_.final_reward[1][2])

			slot0.finalRewardController_:SetSelectedState("received")
		end
	else
		slot0.finalRewardTipsText_.text = string.format(GetTips("ACTIVITY_PUZZLE_III_FINALREWARD_SHOW"), slot2)

		slot0.finalRewardController_:SetSelectedState("normal")
	end
end

function slot0.OnPuzzleActivityUpdate(slot0, slot1)
	if slot1 == slot0.activityID_ then
		slot0:RefreshPlayUI()
	end
end

function slot0.OnPuzzleAutoPut(slot0)
	slot0:ExitEdit()

	slot0.blackboard_.isAutoPutPuzzle_ = true

	if not slot0:CheckRegionReward() then
		slot0:CreateAnimNodeList()
		slot0:StartRunAnimNode()
	end
end

function slot0.RefreshPuzzleList(slot0)
	slot1 = TangramPuzzleData:GetCurPuzzleDic(slot0.activityID_)

	for slot5, slot6 in ipairs(slot0.puzzleItemList_) do
		if slot1[slot5] then
			slot0.puzzleItemList_[slot5]:SetData(slot1[slot5], slot0.activityID_)
		else
			slot0.puzzleItemList_[slot5]:SetData(0, slot0.activityID_)
		end
	end
end

function slot0.RefreshAutoPutCost(slot0)
	slot1 = slot0.puzzleCfg_.coin_id[1]
	slot2 = slot1[2]
	slot0.autoPutCostText_.text = "x" .. slot2
	slot0.autoPutCostImg_.sprite = ItemTools.getItemSprite(slot1[1])

	slot0.autoPutBtnController_:SetSelectedIndex(ItemTools.getItemNum(slot1[1]) < slot2 and 1 or 0)
end

function slot0.MovePuzzle(slot0, slot1, slot2, slot3)
	slot0.blackboard_.isMoveImmediately_ = slot3

	TangramPuzzleAction.MovePuzzle(slot0.activityID_, slot1, slot2)
end

function slot0.OnMovePuzzle(slot0, slot1, slot2)
	slot0:ExitEdit()

	slot0.blackboard_.isMovePuzzle_ = true
	slot0.blackboard_.moveOriginPuzzleIndex_ = slot1
	slot0.blackboard_.moveTargetPuzzleIndex_ = slot2
	slot0.blackboard_.needCheckAllRightRegionType_ = true
	slot0.blackboard_.checkAllRightRegionTypeDic_ = slot0.blackboard_.checkAllRightRegionTypeDic_ or {}
	slot0.blackboard_.checkAllRightRegionTypeDic_[TangramPuzzleTools.GetRegionType(slot0.activityID_, slot0.puzzleItemList_[slot1]:GetCurRegion())] = true

	if not slot0:CheckRegionReward() then
		slot0:CreateAnimNodeList()
		slot0:StartRunAnimNode()
	end
end

function slot0.UpdatePuzzleData(slot0, slot1)
	slot3 = slot0.puzzleItemList_[slot1]

	slot3:SetData(TangramPuzzleData:GetCurPuzzleDic(slot0.activityID_)[slot1] or 0, slot0.activityID_)
	slot3:RecoverTrans()
end

function slot0.OnBeginDragPuzzle(slot0, slot1)
	slot0.dragController_:SetSelectedState("true")

	if slot0.isPlayingFirstTips_ == true then
		slot0:ClickFirstTips()
	end

	slot0:OnClickClueMask()

	if slot0:CanEnterEdit(slot1) then
		if slot0.curStatus_ == slot0.statusConst_.EDIT then
			slot0:SwitchEditTarget(slot1)
		else
			slot0:EnterEdit(slot1)
		end

		slot3, slot4 = slot0.puzzleItemList_[slot1]:GetCurRegion()
		slot0.curValidPuzzleList_ = slot0.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[TangramPuzzleTools.GetRegionType(slot0.activityID_, slot3)][slot4]
		slot0.curValidPuzzlePosList_ = {}

		for slot9, slot10 in ipairs(slot0.curValidPuzzleList_) do
			slot0.curValidPuzzlePosList_[#slot0.curValidPuzzlePosList_ + 1] = slot0.puzzleItemList_[slot10].transform_.position
		end

		slot2:SetTransParent(slot0.dragPanelTrans_)

		return true
	else
		return false
	end
end

function slot0.OnDragPuzzleEnd(slot0, slot1, slot2)
	slot0.dragController_:SetSelectedState("false")

	slot3 = slot0.puzzleItemList_[slot1]
	slot4, slot5 = TangramPuzzleTools.FindClosestTarget(slot0.curValidPuzzlePosList_, slot2)

	if slot0.puzzleCfg_.puzzle_distance < slot5 or slot0.puzzleItemList_[slot0.curValidPuzzleList_[slot4]] == slot3 then
		slot3:RecoverTrans()
	else
		slot0:MovePuzzle(slot1, slot7:GetGlobalIndex(), true)
	end
end

function slot0.OnClickPuzzle(slot0, slot1)
	if slot0.isPlayingFirstTips_ == true then
		slot0:ClickFirstTips()
	end

	slot0:OnClickClueMask()

	if slot0.curStatus_ == slot0.statusConst_.PLAY and slot0.curStatus_ ~= slot0.statusConst_.EDIT then
		if slot0:CanEnterEdit(slot1) then
			slot0:EnterEdit(slot1)
		end
	elseif slot0.puzzleItemList_[slot1] ~= slot0.puzzleItemList_[slot0.editPuzzleIndex_] then
		slot0:SwitchEditTarget(slot1)
	else
		slot0:ExitEdit()
		slot0:SwitchToPlay()
	end
end

function slot0.SpawnPuzzle(slot0)
	slot1 = slot0.puzzleCfg_.area_type_list
	slot0.regionContentItemList_ = slot0.regionContentItemList_ or {}
	slot0.regionItemList_ = slot0.regionItemList_ or {}
	slot0.puzzleItemList_ = slot0.puzzleItemList_ or {}
	slot2 = 0
	slot3 = 0

	for slot8 = 1, slot0.regionContetnPanelTrans_.childCount do
		if not slot0.regionContentItemList_[slot1[slot8][1]] then
			slot0.regionContentItemList_[slot11] = TangramRegionContentItem.New(slot0.regionContetnPanelTrans_:GetChild(slot8 - 1).gameObject, slot11, slot1[slot8][2])
		end

		for slot18 = 1, slot0.regionContentItemList_[slot11]:GetRegionContentTrans().childCount do
			slot2 = slot2 + 1

			if not slot0.regionItemList_[slot12[slot18]] then
				slot0.regionItemList_[slot21] = TangramRegionItem.New(slot13:GetChild(slot18 - 1).gameObject)
			end

			slot0.regionItemList_[slot21].gameObject_.name = slot21

			for slot28 = 1, slot0.regionItemList_[slot21]:GetPuzzleContent().childCount do
				if not slot0.puzzleItemList_[slot3 + 1] then
					slot32 = TangramPuzzlePiece.New(slot23:GetChild(slot28 - 1).gameObject, slot3, slot0.puzzleCfg_.correct_array[slot2][slot28])

					slot32:RegistBeginDragCallback(slot0.beginDragPuzzleHandler_)
					slot32:RegistEndDragCallback(slot0.endDragPuzzleHandler_)
					slot32:RegistClickCallback(slot0.onClickPuzzleHandler_)
					slot32:SetRegionID(slot21, slot28)

					slot32.gameObject_.name = slot3
					slot0.puzzleItemList_[slot3] = slot32
					slot0.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[slot11] = slot0.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[slot11] or {}
					slot0.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[slot11][slot28] = slot0.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[slot11][slot28] or {}

					table.insert(slot0.puzzleGlobalIndexListByRegionTypeAndLocalIndex_[slot11][slot28], slot3)
				end
			end
		end
	end
end

function slot0.DespawnPuzzle(slot0)
	for slot4, slot5 in pairs(slot0.regionContentItemList_) do
		slot5:Dispose()
	end

	slot0.regionContentItemList_ = nil

	for slot4, slot5 in pairs(slot0.regionItemList_) do
		slot5:Dispose()
	end

	slot0.regionItemList_ = nil

	for slot4, slot5 in pairs(slot0.puzzleItemList_) do
		slot5:Dispose()
	end

	slot0.puzzleItemList_ = nil
end

function slot0.RefreshRegionContentList(slot0)
	for slot4, slot5 in ipairs(slot0.regionContentItemList_) do
		slot5:SetData(slot0.activityID_)
	end
end

function slot0.RefreshRegionList(slot0)
	for slot4, slot5 in ipairs(slot0.regionItemList_) do
		slot5:SetData(slot0.activityID_)
	end
end

function slot0.OnRegionRotate(slot0, slot1, slot2)
	slot4, slot5 = slot0.puzzleItemList_[slot0.editPuzzleIndex_]:GetCurRegion()
	slot7 = #TangramPuzzleTools.GetPuzzleGlobalIndexListByRegionID(slot0.activityID_)[slot1]
	slot9 = slot5 + slot2

	if slot2 > 0 == true and slot7 < slot9 then
		slot9 = slot9 % slot7
	elseif slot8 == false and slot9 <= 0 then
		slot9 = slot9 + slot7
	end

	slot0.blackboard_.newEditIndex_ = slot6[slot9]

	slot0:ExitEdit()

	slot0.blackboard_.isRotateRegion_ = true
	slot0.blackboard_.rotateRegionID_ = slot1
	slot0.blackboard_.rotateTimes_ = slot2
	slot0.blackboard_.needCheckAllRightRegionType_ = true
	slot0.blackboard_.checkAllRightRegionTypeDic_ = slot0.blackboard_.checkAllRightRegionTypeDic_ or {}
	slot0.blackboard_.checkAllRightRegionTypeDic_[TangramPuzzleTools.GetRegionType(slot0.activityID_, slot1)] = true

	if not slot0:CheckRegionReward() then
		slot0:CreateAnimNodeList()
		slot0:StartRunAnimNode()
	end
end

function slot0.OnRegionReceived(slot0, slot1, slot2)
	slot0.blackboard_.isReceivedRegionReward_ = true
	slot0.blackboard_.receivedRegionList_ = slot1
	slot0.blackboard_.rewardList_ = slot2
	slot0.blackboard_.needCheckAllRightRegionType_ = true
	slot0.blackboard_.checkAllRightRegionTypeDic_ = slot0.blackboard_.checkAllRightRegionTypeDic_ or {}

	for slot6, slot7 in ipairs(slot1) do
		slot0.blackboard_.checkAllRightRegionTypeDic_[TangramPuzzleTools.GetRegionType(slot0.activityID_, slot7)] = true
	end

	slot0:CreateAnimNodeList()
	slot0:StartRunAnimNode()
end

function slot0.CheckRegionAllRgithByRegionType(slot0, slot1)
	return TangramPuzzleTools.CheckRegionAllRightByType(slot0.activityID_, slot1)
end

function slot0.CheckRegionAllRight(slot0)
	return TangramPuzzleTools.CheckRegionAllRight(slot0.activityID_)
end

function slot0.CheckRegionReward(slot0)
	slot1, slot2 = TangramPuzzleTools.CheckRegionReward(slot0.activityID_)

	if #slot1 > 0 then
		TangramPuzzleAction.ReceiveRegionReward(slot0.activityID_, slot1, slot2)

		return true
	end

	return false
end

function slot0.OnClueUpdate(slot0)
	slot0:CheckFinalReward()
end

function slot0.RefreshClueList(slot0)
	for slot4, slot5 in pairs(slot0.clueItemList_) do
		slot5:SetData(slot0.activityID_, slot4)
	end
end

function slot0.OnClickClueMask(slot0)
	for slot4, slot5 in pairs(slot0.clueItemList_) do
		slot5:SetTipsController(false)
	end
end

function slot0.CheckFinalReward(slot0)
	if TangramPuzzleTools.IsAllClueCompleted(slot0.activityID_) and not TangramPuzzleData:IsReceivedFinalReward(slot0.activityID_) then
		TangramPuzzleAction.ReceiveFinalReward(slot0.activityID_)
	end
end

function slot0.OnReceivedFinalReward(slot0)
	slot0:RefreshFinalUI()
end

function slot0.SpawnClue(slot0)
	slot0.clueItemList_ = {}

	for slot5 = 1, slot0.cluePanelTrans_.childCount do
		if not slot0.clueItemList_[tonumber(slot0.cluePanelTrans_:GetChild(slot5 - 1).gameObject.name)] then
			slot0.clueItemList_[slot8] = TangramPuzzleClueItem.New(slot7)
		end
	end
end

function slot0.DespawnClue(slot0)
	for slot4, slot5 in pairs(slot0.clueItemList_) do
		slot5:Dispose()
	end

	slot0.clueItemList_ = nil
end

function slot0.CheckFirstEnter(slot0)
	slot1 = false
	slot2 = {}
	slot3 = TangramPuzzleData:GetUnlockRegionDic(slot0.activityID_)

	for slot8, slot9 in pairs(TangramPuzzleTools.GetRegionListByType(slot0.activityID_)) do
		if not TangramPuzzleData:GetFirstEnterRegionType(slot0.activityID_, slot8) then
			slot10 = true

			for slot14, slot15 in ipairs(slot9) do
				if not slot3[slot15] then
					slot10 = false

					break
				end
			end

			if slot10 == true and not TangramPuzzleTools.IsAllRegionReceived(slot0.activityID_, slot8) then
				slot1 = true
				slot2[#slot2 + 1] = slot8
			end
		end
	end

	return slot1, slot2
end

function slot0.PlayFirstEnterAnim(slot0, slot1)
	SetActive(slot0.maskGo_, true)
	SetActive(slot0.firstEnterPanelGo_, false)

	slot2 = {}
	slot3 = TangramPuzzleTools.GetRegionListByType(slot0.activityID_)

	for slot7, slot8 in ipairs(slot1) do
		for slot13, slot14 in ipairs(slot3[slot8]) do
			for slot19, slot20 in ipairs(TangramPuzzleTools.GetPuzzleGlobalIndexListByRegionID(slot0.activityID_)[slot14]) do
				slot2[#slot2 + 1] = slot0.puzzleItemList_[slot20]
			end
		end
	end

	if #slot2 == 0 then
		return
	end

	for slot7, slot8 in ipairs(slot2) do
		slot8:SetActive(false)
	end

	slot0:PlayPuzzlePieceEnterAnim(slot2, 1)

	slot0.firstTipsText_.text = GetTips("ACTIVITY_PUZZLE_III_FIRSTSHOW")
end

function slot0.PlayPuzzlePieceEnterAnim(slot0, slot1, slot2)
	if slot2 > #slot1 then
		SetActive(slot0.firstEnterPanelGo_, true)
		slot0:PlayAnim(slot0.firstEnterAnim_, "JigsawPuzzleUI_firstEnterPanel", function ()
			SetActive(uv0.firstEnterPanelGo_, false)
			SetActive(uv0.maskGo_, false)
			uv0:PlayFirstTipsAnim()
		end)

		return
	end

	slot1[slot2]:PlayEnterAnim(function ()
		uv0 = uv0 + 1

		uv1:PlayPuzzlePieceEnterAnim(uv2, uv0)
	end)
	manager.audio:PlayEffect("minigame_activity_2_1", "minigame_activity_2_1_connect_cancel", "")
end

function slot0.PlayFirstTipsAnim(slot0)
	slot0.isPlayingFirstTips_ = true

	SetActive(slot0.firstTipsPanelGo_, true)

	slot0.firstTipsText_.text = GetTips("ACTIVITY_PUZZLE_III_FIRSTSHOW")
end

function slot0.PlayAnim(slot0, slot1, slot2, slot3)
	if not slot1 then
		if slot3 then
			slot3()
		end

		return
	end

	SetActive(slot0.maskGo_, true)

	slot1.enabled = true

	slot1:Play(slot2, -1, 0)
	slot1:Update(0)

	if slot0.animtimer_ then
		slot0.animtimer_:Stop()

		slot0.animtimer_ = nil
	end

	slot0.animtimer_ = Timer.New(function ()
		if uv0:GetCurrentAnimatorStateInfo(0):IsName(uv1) and slot0.normalizedTime >= 1 then
			if uv2.animtimer_ ~= nil then
				uv2.animtimer_:Stop()

				uv2.animtimer_ = nil
			end

			SetActive(uv2.maskGo_, false)

			if uv3 then
				uv3()
			end
		end
	end, 0.033, -1)

	slot0.animtimer_:Start()
end

function slot0.InitAnimNode(slot0)
	slot0.blackboard_ = TangramPuzzleBlackboard.New()
	slot0.nodeDic_ = {
		autoPutNode = TangramAutoPutNode.New(slot0, slot0.blackboard_),
		movePuzzleNode = TangramMovePuzzleNode.New(slot0, slot0.blackboard_),
		movePuzzleImmediateltNode = TangramMovePuzzleImmediatelyNode.New(slot0, slot0.blackboard_),
		rotateRegionNode = TangramRotateRegionNode.New(slot0, slot0.blackboard_),
		receiveRegionNode = TangramRegionReceiveNode.New(slot0, slot0.blackboard_),
		regionTypeAllRightNode = TangramRegionTypeAllRightNode.New(slot0, slot0.blackboard_),
		switchToPlayNode = TangramSwitchToPlayNode.New(slot0, slot0.blackboard_),
		switchToEditNode = TangramSwitchToEditNode.New(slot0, slot0.blackboard_),
		switchToFinalNode = TangramSwitchToFinalNode.New(slot0, slot0.blackboard_)
	}
end

function slot0.CreateAnimNodeList(slot0)
	slot0.nodeList_ = {}

	if slot0.blackboard_.isAutoPutPuzzle_ == true then
		slot1 = TangramAnimGroup.New()

		slot1:Init(slot0, slot0.blackboard_, slot0)

		slot2 = slot0:TryToCreateAutoPutNode()

		slot2:Init(slot1, slot0.blackboard_, slot0)

		slot3 = slot0:TryToCreateRegionTypeAllRightNode()

		slot3:Init(slot1, slot0.blackboard_, slot0)
		slot1:Add(slot2)
		slot1:Add(slot3)

		slot0.nodeList_[#slot0.nodeList_ + 1] = slot1
		slot0.blackboard_.isOnlyRegionRewardPop_ = true

		if slot0:TryToCreateReceiveRegionNode() then
			slot4:Init(slot0, slot0.blackboard_, slot0)

			slot0.nodeList_[#slot0.nodeList_ + 1] = slot4
		end

		slot0.blackboard_.needSwitchToPlay_ = false
		slot0.blackboard_.needSwitchToEdit_ = false
		slot0.blackboard_.needSwitchToFinal_ = true

		if slot0:TryToCreateSwitchNode() then
			slot5:Init(slot0, slot0.blackboard_, slot0)

			slot0.nodeList_[#slot0.nodeList_ + 1] = slot5
		end

		return
	end

	if slot0:TryToCreateMovePuzzleNode() then
		slot0.nodeList_[#slot0.nodeList_ + 1] = slot1
	end

	if slot0:TryToCreateRotateRegionNode() then
		slot0.nodeList_[#slot0.nodeList_ + 1] = slot2
	end

	if slot0:TryToCreateReceiveRegionNode() then
		slot0.nodeList_[#slot0.nodeList_ + 1] = slot3
	end

	if slot0:TryToCreateRegionTypeAllRightNode() then
		slot0.nodeList_[#slot0.nodeList_ + 1] = slot4
	end

	if slot0:TryToCreateSwitchNode() then
		slot0.nodeList_[#slot0.nodeList_ + 1] = slot5
	end

	for slot9, slot10 in ipairs(slot0.nodeList_) do
		slot10:Init(slot0, slot0.blackboard_, slot0)
	end
end

function slot0.TryToCreateAutoPutNode(slot0)
	if slot0.blackboard_.isAutoPutPuzzle_ == true then
		slot0.blackboard_.isAutoPutPuzzle_ = false
		slot0.blackboard_.needSwitchToFinal_ = true

		return slot0.nodeDic_.autoPutNode
	end
end

function slot0.TryToCreateMovePuzzleNode(slot0)
	if slot0.blackboard_.isMovePuzzle_ == true then
		slot0.blackboard_.isMovePuzzle_ = false
		slot0.blackboard_.needSwitchToPlay_ = true
		slot1 = nil

		return (slot0.blackboard_.isMoveImmediately_ ~= true or slot0.nodeDic_.movePuzzleImmediateltNode) and slot0.nodeDic_.movePuzzleNode
	end
end

function slot0.TryToCreateRotateRegionNode(slot0)
	if slot0.blackboard_.isRotateRegion_ == true then
		slot0.blackboard_.isRotateRegion_ = false
		slot0.blackboard_.needSwitchToEdit_ = true

		return slot0.nodeDic_.rotateRegionNode
	end
end

function slot0.TryToCreateReceiveRegionNode(slot0)
	if slot0.blackboard_.isReceivedRegionReward_ == true then
		slot0.blackboard_.isReceivedRegionReward_ = false
		slot0.blackboard_.needSwitchToPlay_ = true

		return slot0.nodeDic_.receiveRegionNode
	end
end

function slot0.TryToCreateRegionTypeAllRightNode(slot0)
	if slot0.blackboard_.needCheckAllRightRegionType_ == true then
		slot0.blackboard_.needCheckAllRightRegionType_ = false
		slot1 = {}

		for slot5, slot6 in pairs(slot0.blackboard_.checkAllRightRegionTypeDic_) do
			if slot0:CheckRegionAllRgithByRegionType(slot5) == true then
				table.insert(slot1, slot5)
			end
		end

		if #slot1 > 0 then
			slot0.blackboard_.allRightRegionTypeList_ = slot1
			slot0.blackboard_.needSwitchToPlay_ = true

			if slot0:CheckRegionAllRight() == true then
				slot0.blackboard_.needSwitchToPlay_ = false
				slot0.blackboard_.needSwitchToEdit_ = false
				slot0.blackboard_.needSwitchToFinal_ = true
			end

			return slot0.nodeDic_.regionTypeAllRightNode
		end
	end
end

function slot0.TryToCreateSwitchNode(slot0)
	if slot0.blackboard_.needSwitchToPlay_ == true then
		slot0.blackboard_.needSwitchToPlay_ = false

		return slot0.nodeDic_.switchToPlayNode
	elseif slot0.blackboard_.needSwitchToEdit_ == true then
		slot0.blackboard_.needSwitchToEdit_ = false

		return slot0.nodeDic_.switchToEditNode
	elseif slot0.blackboard_.needSwitchToFinal_ == true then
		slot0.blackboard_.needSwitchToFinal_ = false

		return slot0.nodeDic_.switchToFinalNode
	end
end

function slot0.StartRunAnimNode(slot0)
	SetActive(slot0.maskGo_, true)

	slot0.animNodeRunning_ = true
	slot0.curNodeIndex_ = 0

	slot0:RunNode()
end

function slot0.StopAnimNode(slot0)
	SetActive(slot0.maskGo_, false)

	slot0.animNodeRunning_ = false
	slot0.nodeList_ = nil

	slot0.blackboard_:Reset()
end

function slot0.RunNode(slot0)
	if not slot0.animNodeRunning_ then
		return
	end

	slot0.curNodeIndex_ = slot0.curNodeIndex_ + 1

	slot0.nodeList_[slot0.curNodeIndex_]:RunFunc()
end

function slot0.SetNodeRunComplete(slot0)
	if not slot0.animNodeRunning_ or slot0.curNodeIndex_ >= #slot0.nodeList_ then
		slot0:StopAnimNode()

		return
	end

	slot0:RunNode()
end

function slot0.DisposeAnimNode(slot0)
	if slot0.nodeDic_ then
		for slot4, slot5 in pairs(slot0.nodeDic_) do
			slot5:Dispose()
		end

		slot0.nodeDic_ = nil
	end
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()
	slot0:RefreshTimeText()

	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ < manager.time:GetServerTime() then
			uv0.timeText_.text = GetTips("TIME_OVER")

			return
		end

		uv0:RefreshTimeText()
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshTimeText(slot0)
	if slot0.timeText_ then
		slot0.timeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(slot0.stopTime_, nil, true)
	end
end

function slot0.IsActivityTime(slot0)
	if manager.time:GetServerTime() < slot0.startTime_ then
		ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(slot0.startTime_, nil, true)))

		return false
	end

	if slot0.stopTime_ <= manager.time:GetServerTime() then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

return slot0
