slot0 = class("PuzzleNewPlayView", ReduxView)

function slot0.UIName(slot0)
	return PuzzleNewTools.GetPlayViewUIName(slot0.params_.activityID)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.puzzleItemList_ = {}
	slot0.puzzleItemDicByID_ = {}
	slot0.regionItemList_ = {}
	slot0.statusConst_ = {
		PLAY = 0,
		CHECK = 1
	}

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.putBtnController_ = ControllerUtil.GetController(slot0.putBtn_.transform, "status")
	slot0.checkBtnController_ = ControllerUtil.GetController(slot0.checkTipsBtn_.transform, "status")
	slot0.checkPointList_ = {}
	slot0.endDragHandler_ = handler(slot0, slot0.OnDragPuzzleEnd)
	slot0.onClickHandler_ = handler(slot0, slot0.OnClick)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.autoBtn_, nil, function ()
		if not uv0:IsActivityTime() then
			return
		end

		if not PuzzleNewTools.CheckWrongSide(false, uv0.activityID_) then
			ShowTips("ACTIVITY_PUZZLE_GUIDE_ENOUGH")

			return
		end

		slot0 = uv0.puzzleCfg_.coin_id[1]

		if ItemTools.getItemNum(slot0[1]) < slot0[2] then
			ShowTips("ACTIVITY_PUZZLE_COIN_NOT_ENOUGH")

			return
		end

		SetActive(uv0.maskGo_, true)
		PuzzleNewAction.Operation(uv0.activityID_, PuzzleNewAction.OPERATION_TYPE.AUTO_PUT)
	end)
	slot0:AddBtnListener(slot0.putBtn_, nil, function ()
		if not uv0:IsActivityTime() then
			return
		end

		if not PuzzleNewTools.CheckWrongSide(true, uv0.activityID_) then
			ShowTips("ACTIVITY_PUZZLE_ENOUGH")

			return
		end

		slot0 = uv0.puzzleCfg_.fragment_id[1]

		if ItemTools.getItemNum(slot0[1]) < slot0[2] then
			ShowTips("ACTIVITY_PUZZLE_FRAGMENT_NOT_ENOUGH")

			return
		end

		PuzzleNewData:SetPutBtnSelected(uv0.activityID_)
		SetActive(uv0.maskGo_, true)
		PuzzleNewAction.Operation(uv0.activityID_, PuzzleNewAction.OPERATION_TYPE.PUT)
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if not uv0:IsActivityTime() then
			return
		end

		manager.windowBar:HideBar()
		JumpTools.OpenPageByJump("puzzleNewReward", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.previewBtn_, nil, function ()
		if not uv0:IsActivityTime() then
			return
		end

		manager.windowBar:HideBar()
		JumpTools.OpenPageByJump("puzzleNewPreview", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.checkTipsBtn_, nil, function ()
		if not uv0:IsActivityTime() then
			return
		end

		slot3 = false
		slot4 = 0

		for slot8, slot9 in ipairs(uv0.puzzleCfg_.clue_id) do
			if PuzzleNewData:GetCurCheckList(uv0.activityID_)[slot9] == nil and PuzzleNewData:GetCheckTipsList(uv0.activityID_)[slot9] == nil then
				slot3 = true
				slot4 = slot9

				break
			end
		end

		if not slot3 then
			ShowTips("ACTIVITY_PUZZLE_CULE")

			return
		end

		slot5 = uv0.puzzleCfg_.clue_tips_id[1]

		if ItemTools.getItemNum(slot5[1]) < slot5[2] then
			ShowTips("ACTIVITY_PUZZLE_FRAGMENT_NOT_ENOUGH")

			return
		end

		SetActive(uv0.maskGo_, true)
		PuzzleNewAction.Operation(uv0.activityID_, PuzzleNewAction.OPERATION_TYPE.CHECK_TIPS, nil, slot4)
	end)
	slot0:AddBtnListener(slot0.checkPreviewBtn_, nil, function ()
		if not uv0:IsActivityTime() then
			return
		end

		manager.windowBar:HideBar()
		JumpTools.OpenPageByJump("puzzleNewCheckPreview", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.shareBtn_, nil, function ()
		manager.share:Share(function ()
			uv0:HideAllUI()
		end, function ()
			uv0:RecoverAllUI()
		end, function ()
		end)
	end)
end

function slot0.OnEnter(slot0)
	slot1 = ActivityData:GetActivityData(slot0.params_.activityID)
	slot0.startTime_ = slot1.startTime
	slot0.stopTime_ = slot1.stopTime

	if slot0.activityID_ ~= slot0.params_.activityID then
		slot0.activityID_ = slot0.params_.activityID
		slot0.puzzleCfg_ = PuzzleNewCfg[slot0.params_.activityID]

		slot0:Spawn()
	end

	slot0.params_.isEnter = true

	slot0:SwitchStatus()
	slot0:AddTimer()
	SetActive(slot0.maskGo_, false)
	manager.redPoint:bindUIandKey(slot0.putBtn_.transform, string.format("%s_%s", RedPointConst.PUZZLE_NEW_PIECE, slot0.activityID_))
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.checkAnimtimer_ ~= nil then
		slot0.checkAnimtimer_:Stop()

		slot0.checkAnimtimer_ = nil
	end

	slot0:StopTimer()

	slot0.params_.isEnter = false

	SetActive(slot0.maskGo_, false)
	manager.redPoint:unbindUIandKey(slot0.putBtn_.transform, string.format("%s_%s", RedPointConst.PUZZLE_NEW_PIECE, slot0.activityID_))
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		slot0.puzzleCfg_.coin_id[1][1],
		slot0.puzzleCfg_.fragment_id[1][1]
	})
	manager.windowBar:SetBarCanClick(slot0.puzzleCfg_.coin_id[1][1], true)
	manager.windowBar:SetBarCanClick(slot0.puzzleCfg_.fragment_id[1][1], true)
end

function slot0.Dispose(slot0)
	slot0:StopTimer()

	slot0.endDragHandler_ = nil
	slot0.onClickHandler_ = nil

	slot0:DespawnPuzzle()
	slot0:DespawnRegion()
	slot0:DespawnCheckPoint()
	uv0.super.Dispose(slot0)
end

function slot0.Spawn(slot0)
	if not PuzzleNewData:IsCompleted(slot0.activityID_) then
		slot0:DespawnPuzzle()
		slot0:SpawnPuzzle()
		slot0:DespawnRegion()
		slot0:SpawnRegion()

		return
	end

	slot0:DespawnCheckPoint()
	slot0:SpawnCheckPoint()
end

function slot0.SwitchStatus(slot0)
	if not PuzzleNewData:IsCompleted(slot0.activityID_) then
		slot0:SwitchToPlay()

		return
	end

	slot0:SwitchToCheck()
end

function slot0.SwitchToPlay(slot0)
	slot0.statusController_:SetSelectedIndex(slot0.statusConst_.PLAY)
	slot0:RefreshPuzzle()
	slot0:CheckRegionResult()
end

function slot0.SwitchToCheck(slot0)
	slot0.statusController_:SetSelectedIndex(slot0.statusConst_.CHECK)
	slot0:RefreshCheckPoint()
	slot0.checkAnim_:Play("puzzlePieceTemplate_ImagePanel", -1, 999)
end

function slot0.OnPuzzleNewUpdate(slot0)
	SetActive(slot0.maskGo_, false)
	slot0:RefreshPuzzle()
	slot0:CheckRegionResult()
end

function slot0.RefreshPuzzle(slot0)
	slot0.params_.isEnter = false
	slot2 = PuzzleNewData:GetCurPuzzleList(slot0.activityID_)

	for slot6, slot7 in ipairs(slot0.puzzleItemList_) do
		if slot2[slot6] then
			slot0.puzzleItemList_[slot6]:SetData(slot2[slot6], slot0.activityID_, not slot0.params_.isEnter)
		else
			slot0.puzzleItemList_[slot6]:SetData(0, slot0.activityID_, false)
		end
	end

	slot0:RefreshPuzzleCost()
end

function slot0.MovePuzzle(slot0, slot1, slot2)
	SetActive(slot0.maskGo_, true)
	PuzzleNewAction.MovePuzzle(slot0.activityID_, slot0.puzzleItemList_[slot1]:GetCurID(), slot2, function ()
		SetActive(uv0.maskGo_, false)

		slot0 = uv0.puzzleItemList_[uv1]
		slot1 = uv0.puzzleItemList_[uv2]

		slot0:SetData(slot1:GetCurID(), uv0.activityID_, true)
		slot1:SetData(slot0:GetCurID(), uv0.activityID_, true)
		PuzzleNewData:SetPuzzle(uv0.activityID_, slot0:GetCurID(), uv1)
		PuzzleNewData:SetPuzzle(uv0.activityID_, slot1:GetCurID(), uv2)
		uv0:CheckRegionResult()
	end)
end

function slot0.OnDragPuzzleEnd(slot0, slot1, slot2)
	slot3, slot4 = PuzzleNewTools.FindPuzzleByScreenPos(slot0.puzzleContentTrans_, slot0.col_, slot0.row_, slot2)

	if slot3 == true then
		if slot1 ~= slot4 and not slot0.puzzleItemList_[slot4]:IsRightSide() then
			slot0:MovePuzzle(slot1, slot4)
		else
			slot0.puzzleItemList_[slot1]:Recover()
		end
	else
		slot0.puzzleItemList_[slot1]:Recover()
	end
end

function slot0.SpawnPuzzle(slot0)
	slot0.row_ = slot0.puzzleCfg_.size[1]
	slot0.col_ = slot0.puzzleCfg_.size[2]
	slot0.puzzleItemList_ = slot0.puzzleItemList_ or {}

	for slot6 = 1, slot0.puzzleContentTrans_.childCount do
		if not slot0.puzzleItemList_[slot6] then
			slot8 = slot0.puzzleCfg_.correct_array[slot6]
			slot0.puzzleItemList_[slot6] = PuzzleNewPiece.New(slot0.puzzleContentTrans_, slot0.puzzleContentTrans_:GetChild(slot6 - 1), slot6, slot8)

			slot0.puzzleItemList_[slot6]:RegistEndDragCallback(slot0.endDragHandler_)

			slot0.puzzleItemDicByID_[slot8] = slot0.puzzleItemList_[slot6]
		end
	end
end

function slot0.DespawnPuzzle(slot0)
	for slot4, slot5 in pairs(slot0.puzzleItemList_) do
		slot5:Dispose()
	end

	slot0.puzzleItemList_ = nil
end

function slot0.RefreshPuzzleCost(slot0)
	slot1 = slot0.puzzleCfg_.fragment_id[1]
	slot2 = slot1[2]
	slot0.putCostText_.text = "x" .. slot2
	slot0.putCostImg_.sprite = ItemTools.getItemSprite(slot1[1])

	slot0.putBtnController_:SetSelectedIndex(ItemTools.getItemNum(slot1[1]) < slot2 and 1 or 0)
end

function slot0.SpawnRegion(slot0)
	slot2 = slot0.puzzleCfg_.reward_area_list
	slot0.regionItemList_ = slot0.regionItemList_ or {}

	for slot8 = 1, slot0.regionPanelTrans_.childCount do
		slot10 = tonumber(slot0.regionPanelTrans_:GetChild(slot8 - 1).name)
		slot13 = slot0.puzzleCfg_.area_fragment_list[PuzzleNewTools.GetRegionPosDic(slot0.activityID_)[slot10]][2]

		if not slot0.regionItemList_[slot10] then
			slot0.regionItemList_[slot10] = PuzzleNewRegionAnimItem.New(slot9)
		end

		for slot17, slot18 in ipairs(slot13) do
			slot0.puzzleItemDicByID_[slot18]:SetRegionID(slot10)
		end
	end
end

function slot0.DespawnRegion(slot0)
	for slot4, slot5 in pairs(slot0.regionItemList_) do
		slot5:Dispose()
	end

	slot0.regionItemList_ = nil
end

function slot0.OnRegionReceived(slot0, slot1, slot2)
	for slot6 = 1, #slot1 do
		if slot6 == #slot1 then
			slot0.regionItemList_[slot1[slot6]]:PlayAnim(function ()
				SetActive(uv0.maskGo_, false)
				uv0:OnRegionAnimEnd(uv1)
			end)
		else
			slot0.regionItemList_[slot6]:PlayAnim()
		end
	end
end

function slot0.OnRegionAnimEnd(slot0, slot1)
	getReward2(slot1, nil, function ()
		if PuzzleNewData:IsCompleted(uv0.activityID_) then
			uv0:Spawn()
			uv0:SwitchStatus()
			SetActive(uv0.maskGo_, true)
			uv0.checkAnim_:Play("puzzlePieceTemplate_ImagePanel", -1, 0)
			uv0.checkAnim_:Update(0)

			uv0.checkAnimtimer_ = Timer.New(function ()
				if uv0.checkAnim_:GetCurrentAnimatorStateInfo(0):IsName(uv1) and slot0.normalizedTime >= 1 then
					if uv0.checkAnimtimer_ ~= nil then
						uv0.checkAnimtimer_:Stop()

						uv0.checkAnimtimer_ = nil
					end

					SetActive(uv0.maskGo_, false)
				end
			end, 0.033, -1)

			uv0.checkAnimtimer_:Start()
			manager.audio:PlayEffect("minigame_activity_2_1", "minigame_activity_2_1_puzzle_complete", "")
		end
	end)
end

function slot0.CheckRegionResult(slot0)
	slot1, slot6 = PuzzleNewTools.CheckRegionResult(slot0.activityID_)

	if #slot1 > 0 then
		SetActive(slot0.maskGo_, true)
		PuzzleNewAction.ReceiveRegionReward(slot0.activityID_, slot1, slot6)

		for slot6, slot7 in pairs(slot0.puzzleItemList_) do
			slot7:StopAnim()
		end
	end
end

function slot0.OnPuzzleNewCheckUpdate(slot0)
	SetActive(slot0.maskGo_, false)
	slot0:RefreshCheckPoint()
end

function slot0.RefreshCheckPoint(slot0)
	for slot4, slot5 in pairs(slot0.checkPointList_) do
		slot5:SetData(slot0.activityID_, slot4)
	end

	slot0:RefreshCheckProgress()
	slot0:RefreshCheckCost()
end

function slot0.RefreshCheckProgress(slot0)
	slot1 = #slot0.puzzleCfg_.clue_id

	for slot7, slot8 in pairs(PuzzleNewData:GetCurCheckList(slot0.activityID_)) do
		slot3 = 0 + 1
	end

	slot0.progressText_.text = string.format("%d/%d", slot3, slot1)
end

function slot0.OnClick(slot0, slot1)
	slot0:RefreshCheckProgress()
end

function slot0.SpawnCheckPoint(slot0)
	slot0.checkPointList_ = slot0.checkPointList_ or {}

	for slot6 = 1, slot0.checkPointContent_.childCount do
		if not slot0.checkPointList_[slot0.puzzleCfg_.clue_id[slot6]] then
			slot0.checkPointList_[slot8] = PuzzleNewCheckPoint.New(slot0.checkPointContent_:GetChild(slot6 - 1))
		end
	end

	slot0.originImage_.sprite = getSpriteWithoutAtlas(slot0.puzzleCfg_.preview_album_id)
	slot0.checkPanelImage_.sprite = getSpriteWithoutAtlas(slot0.puzzleCfg_.album_id)
end

function slot0.DespawnCheckPoint(slot0)
	for slot4, slot5 in pairs(slot0.checkPointList_) do
		slot5:Dispose()
	end

	slot0.checkPointList_ = nil
end

function slot0.RefreshCheckCost(slot0)
	slot1 = slot0.puzzleCfg_.clue_tips_id[1]
	slot2 = slot1[2]
	slot0.checkCostText_.text = "x" .. slot2
	slot0.checkCostImg_.sprite = ItemTools.getItemSprite(slot1[1])

	slot0.checkBtnController_:SetSelectedIndex(ItemTools.getItemNum(slot1[1]) < slot2 and 1 or 0)
end

function slot0.HideAllUI(slot0)
	manager.windowBar:HideBar()
	SetActive(slot0.btnPanelGo_, false)
	SetActive(slot0.titlePanelGo_, false)
end

function slot0.RecoverAllUI(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		slot0.puzzleCfg_.coin_id[1][1],
		slot0.puzzleCfg_.fragment_id[1][1]
	})
	SetActive(slot0.btnPanelGo_, true)
	SetActive(slot0.titlePanelGo_, true)
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
		slot0.timeText_.text = manager.time:GetLostTimeStr2(slot0.stopTime_, nil, true)
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
