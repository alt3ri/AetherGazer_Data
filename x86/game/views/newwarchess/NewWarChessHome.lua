slot0 = class("NewWarChessHome", ReduxView)
slot1 = {
	"Normal",
	"MoreThenCurMovePoint",
	"MoreThenMax"
}

function slot0.UIName(slot0)
	return "UI/NewWarChess/NewWarChessMain"
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

	slot0.taskList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.taskListGo_, NewWarChessHomeTaskItem)
	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.diceList_ = LuaList.New(handler(slot0, slot0.IndexDiceItem), slot0.diceListGo_, NewWarChessDiceItem)
	slot0.isShowingBuff_ = false
	slot0.curShowBuffIndex_ = 0
	slot0.buffList_ = LuaList.New(handler(slot0, slot0.IndexBuffItem), slot0.buffList_, NewWarChessBuffItem)
	slot0.clickBuffHandler_ = handler(slot0, slot0.OnClickBuff)
	slot0.moveController_ = ControllerUtil.GetController(slot0.moveTrans_, "state")
	slot0.moveState_ = uv0[1]
	slot0.curCost_ = 0
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.taskIDList_[slot1])
end

function slot0.IndexDiceItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.diceDataList_[slot1])
	slot2:SetClickCallBack(function (slot0)
		ShowMessageBox({
			content = string.format(GetTips("ACTIVITY_NEW_WARCHESS_CHECK_DICE_TO_MOVEPOINT"), uv0.dicePoint_, uv0.dicePoint_),
			OkCallback = function ()
				NewWarChessAction.DiceToMovePoint(uv0.dicePoint_, function ()
					slot0 = math.floor(uv0 * NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_DICE_TO_MOVE_POINT_TIMES") / 1000)

					NewWarChessData:SubAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT", slot0)
					manager.NewChessManager:CreateTips({
						tipsType = NewChessConst.TIPS_TYPE.SWITCH,
						tipsText = string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_TO_MOVEPOINT"), uv0, slot0),
						tipsDiceNum = uv0
					})
					NewWarChessData:RemoveDice({
						uv1.dicePoint_
					})
					uv2:RefreshDiceList()
				end)
			end
		})
	end)
end

function slot0.IndexBuffItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.curShowBuffIndex_, slot0.buffEntityList_[slot1])
	slot2:SetClickCallBack(slot0.clickBuffHandler_)
end

function slot0.OnClickBuff(slot0, slot1, slot2, slot3)
	if slot0.isShowingBuff_ then
		SetActive(slot0.buffInfoGo_, false)

		slot0.curShowBuffIndex_ = 0

		slot0.buffList_:Refresh()

		slot0.isShowingBuff_ = false
	else
		SetActive(slot0.buffInfoGo_, true)

		slot0.curShowBuffIndex_ = slot1
		slot0.buffInfoNameText_.text = slot2
		slot0.buffInfoDesText_.text = slot3

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.infoContentTrans_)

		slot0.isShowingBuff_ = true
	end
end

function slot0.OnEnter(slot0)
	slot0.curMovePointText_.text = NewChessTools.GetMovePointText(NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT"))
	slot2 = NewWarChessData:GetExploreValue(NewWarChessData:GetCurrentWarChessMapID())
	slot0.exploreValueText_.text = slot2 .. "%"
	slot0.exploreValueImage_.fillAmount = slot2 / 100

	SetActive(slot0.lookatBtn_.gameObject, false)
	SetActive(slot0.buffInfoGo_, false)

	slot0.curShowBuffIndex_ = 0
	slot0.isShowingBuff_ = false

	slot0:RefreshDiceList()
	slot0:RefreshTaskList()
	slot0:RefreshBuffList()
	slot0:BindRedPoint()
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, RedPointConst.NEW_WARCHESS_EXPROLE_REWARD .. "_" .. NewWarChessLevelCfg[NewWarChessData:GetCurrentWarChessMapID()].activity)
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, RedPointConst.NEW_WARCHESS_EXPROLE_REWARD .. "_" .. NewWarChessLevelCfg[NewWarChessData:GetCurrentWarChessMapID()].activity)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		NewChessTools.ExitNewChessScene(false)
	end)
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			isPrefab = true,
			pages = NewChessTools.GetNewWarChessGameSetting("new_warchess_describe", NewWarChessData:GetCurrentMainActivity())
		}
	})
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.useItemBtn_, nil, function ()
		JumpTools.OpenPageByJump("newWarChessPopItemView", {
			mainActivityID = NewWarChessData:GetCurrentMainActivity()
		})
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("activityNewWarChessRewardView", {
			mainActivityID = NewWarChessData:GetCurrentMainActivity(),
			activityIDList = {
				NewWarChessData:GetCurrentActivity()
			}
		})
	end)
	slot0:AddBtnListener(slot0.lookatBtn_, nil, function ()
		NewChessLuaBridge.LookAtPlayer()
		manager.NewChessManager:ClearEndPoint()
		SetActive(uv0.lookatBtn_.gameObject, false)
	end)
	slot0:AddBtnListener(slot0.moveBtn_, nil, function ()
		if uv0.moveState_ == uv1[1] then
			manager.NewChessManager:StartMoveToCaChePath()
		elseif uv0.moveState_ == uv1[2] then
			ShowTips("ACTIVITY_NEW_WARCHESS_MOVEPOINT_DEFICIENCY")
		elseif uv0.moveState_ == uv1[3] then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("ACTIVITY_NEW_WARCHESS_MOVEPOINT_COST_MORETHEN_MAX"), NewChessTools.GetNewWarChessGameSetting("new_warchess_single_move_point_max", NewWarChessData:GetCurrentMainActivity())[1]),
				OkCallback = function ()
					manager.NewChessManager:StartMoveToCaChePath()
				end
			})
		end
	end)
	slot0:AddBtnListener(slot0.farClickBtn_, nil, function ()
		if uv0.farClickFun_ then
			uv0.farClickFun_()

			uv0.farClickFun_ = nil

			uv0.statusController_:SetSelectedState("normal")
		end
	end)
	slot0:AddBtnListener(slot0.heroBtn_, nil, function ()
		JumpTools.OpenPageByJump("newWarChessHeroView")
	end)
	slot0:AddBtnListener(slot0.buffinfoBtn_, nil, function ()
		if uv0.isShowingBuff_ then
			uv0.isShowingBuff_ = false
			uv0.curShowBuffIndex_ = 0

			SetActive(uv0.buffInfoGo_, false)
			uv0.buffList_:Refresh()
		end
	end)
end

function slot0.OnNewChessHomeUpdateState(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot1 == NewChessConst.HOME_STATUS.NORMAL then
		slot0.statusController_:SetSelectedState("normal")

		slot0.curCost_ = 0
	elseif slot1 == NewChessConst.HOME_STATUS.MOVING then
		slot0.statusController_:SetSelectedState("moving")

		slot0.curCost_ = 0
	elseif slot1 == NewChessConst.HOME_STATUS.READY then
		slot0.statusController_:SetSelectedState("ready")

		slot0.curCost_ = slot2
		slot0.costText_.text = slot2

		slot0:RefreshMoveCost()

		slot0.moveTrans_.localPosition = Vector3.New(slot3 / Screen.width * manager.ui.canvasSize_.x, slot4 / Screen.height * manager.ui.canvasSize_.y)
	elseif slot1 == NewChessConst.HOME_STATUS.FARCLICK then
		slot0.statusController_:SetSelectedState("farClick")

		slot0.farClickFun_ = slot5
		slot0.curCost_ = 0
		slot0.farClickTrans_.localPosition = Vector3.New(slot3 / Screen.width * manager.ui.canvasSize_.x, slot4 / Screen.height * manager.ui.canvasSize_.y)
	end
end

function slot0.RefreshMoveCost(slot0)
	if slot0.curCost_ > 0 then
		if NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT") < slot0.curCost_ or NewChessTools.GetNewWarChessGameSetting("new_warchess_single_move_point_max", NewWarChessData:GetCurrentMainActivity())[1] < slot0.curCost_ then
			if slot1 < slot0.curCost_ then
				slot0.moveState_ = uv0[2]
			elseif slot2 < slot0.curCost_ then
				slot0.moveState_ = uv0[3]
			end

			slot0.moveController_:SetSelectedState("lock")
		else
			slot0.moveState_ = uv0[1]

			slot0.moveController_:SetSelectedState("normal")
		end
	end
end

function slot0.OnNewWarChessBuffUpDate(slot0)
	slot0:RefreshBuffList()
end

function slot0.OnNewWarChessExploreValueUpdate(slot0, slot1)
	slot0.exploreValueText_.text = slot1 .. "%"
	slot0.exploreValueImage_.fillAmount = slot1 / 100
end

function slot0.RefreshTaskList(slot0)
	slot0.taskIDList_ = {}
	slot2 = {}

	for slot6, slot7 in pairs(manager.NewChessManager.taskManager_:GetTaskList()) do
		if NewWarChessTaskPoolCfg[slot6].type == NewChessConst.TASKTYPE.MAIN then
			table.insert(slot0.taskIDList_, slot6)
		else
			table.insert(slot2, slot6)
		end
	end

	for slot6, slot7 in pairs(slot2) do
		table.insert(slot0.taskIDList_, slot7)
	end

	slot0.taskList_:StartScroll(#slot0.taskIDList_)

	if #slot0.taskIDList_ > 2 then
		slot0.taskListImg_.raycastTarget = true
		slot0.taskListScroll_.enabled = true
	else
		slot0.taskListImg_.raycastTarget = false
		slot0.taskListScroll_.enabled = false
	end
end

function slot0.RefreshBuffList(slot0)
	slot0.buffEntityList_ = manager.NewChessManager.buffManager_:GetActiveBuffEntityList()

	slot0.buffList_:StartScroll(#slot0.buffEntityList_)
end

function slot0.OnDiceUpdate(slot0)
	slot0:RefreshDiceList()
end

function slot0.RefreshDiceList(slot0)
	slot0.diceDataList_ = NewWarChessData:GetDiceContinuousList()

	slot0.diceList_:StartScroll(#slot0.diceDataList_)
end

function slot0.OnCurMovePointUpdate(slot0)
	slot0.curMovePointText_.text = NewChessTools.GetMovePointText(NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT"))

	slot0:RefreshMoveCost()
end

function slot0.OnTaskUpdate(slot0)
	slot0:RefreshTaskList()
end

function slot0.OnNewWarChessCameraMove(slot0, slot1)
	SetActive(slot0.lookatBtn_.gameObject, slot1)
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	NewWarChessData:ClearDiceContinuousList()
	slot0:UnBindRedPoint()
	slot0.taskList_:StopRender()
	slot0.diceList_:StopRender()
	slot0.buffList_:StopRender()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.taskList_ then
		slot0.taskList_:Dispose()

		slot0.taskList_ = nil
	end

	if slot0.diceList_ then
		slot0.diceList_:Dispose()

		slot0.diceList_ = nil
	end

	if slot0.buffList_ then
		slot0.buffList_:Dispose()

		slot0.buffList_ = nil
	end

	slot0.clickBuffHandler_ = nil
end

return slot0
