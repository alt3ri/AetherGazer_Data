slot0 = class("PushBoxCellItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.overCon_ = ControllerUtil.GetController(slot0.transform_, "over")
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.bridgeCon_ = ControllerUtil.GetController(slot0.transform_, "bridge")
end

function slot0.AddUIListeners(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.coordinateX_ = slot1
	slot0.coordinateY_ = slot2
	slot0.type_ = slot3

	slot0:Reset()
	slot0:RefreshType()
end

function slot0.Reset(slot0)
	slot0.onReadyEnterHandler_ = nil
	slot0.actionPassHandler_ = nil
	slot0.onPassedHandler_ = nil
	slot0.onStopHandler_ = nil
	slot0.isCanPass_ = true
end

function slot0.RefreshType(slot0)
	slot0.stateCon_:SetSelectedState(slot0.type_)
	slot0.bridgeCon_:SetSelectedState("false")
	slot0.overCon_:SetSelectedState("false")

	if slot0.type_ == PushBoxConst.CELL_TYPE.NORMAL then
		slot0.actionPassHandler_ = handler(slot0, slot0.NormalActionPass)
		slot0.onStopHandler_ = handler(slot0, slot0.NormalStop)
	elseif slot0.type_ == PushBoxConst.CELL_TYPE.BLOCK then
		slot0.isCanPass_ = false
	elseif slot0.type_ == PushBoxConst.CELL_TYPE.GOAL then
		slot0.actionPassHandler_ = handler(slot0, slot0.GoalActionPass)
		slot0.onPassedHandler_ = handler(slot0, slot0.GoalPass)
		slot0.onStopHandler_ = handler(slot0, slot0.GoalStop)
	elseif slot0.type_ == PushBoxConst.CELL_TYPE.BRIDGE then
		slot0.actionPassHandler_ = handler(slot0, slot0.BridgeActionPass)
		slot0.onPassedHandler_ = handler(slot0, slot0.BridgePass)
		slot0.onStopHandler_ = handler(slot0, slot0.NormalStop)
	elseif slot0.type_ == PushBoxConst.CELL_TYPE.UP_SLIDER then
		slot0.actionPassHandler_ = handler(slot0, slot0.NormalActionPass)
		slot0.onStopHandler_ = handler(slot0, slot0.UpSlider)
		slot0.onReadyEnterHandler_ = handler(slot0, slot0.UpSliderEnter)
	elseif slot0.type_ == PushBoxConst.CELL_TYPE.DOWN_SLIDER then
		slot0.actionPassHandler_ = handler(slot0, slot0.NormalActionPass)
		slot0.onStopHandler_ = handler(slot0, slot0.DownSlider)
		slot0.onReadyEnterHandler_ = handler(slot0, slot0.DownSliderEnter)
	elseif slot0.type_ == PushBoxConst.CELL_TYPE.LEFT_SLIDER then
		slot0.actionPassHandler_ = handler(slot0, slot0.NormalActionPass)
		slot0.onStopHandler_ = handler(slot0, slot0.LeftSlider)
		slot0.onReadyEnterHandler_ = handler(slot0, slot0.LeftSliderEnter)
	elseif slot0.type_ == PushBoxConst.CELL_TYPE.RIGHT_SLIDER then
		slot0.actionPassHandler_ = handler(slot0, slot0.NormalActionPass)
		slot0.onStopHandler_ = handler(slot0, slot0.RightSlider)
		slot0.onReadyEnterHandler_ = handler(slot0, slot0.RightSliderEnter)
	end
end

function slot0.IsCanPass(slot0)
	return slot0.isCanPass_
end

function slot0.GetType(slot0)
	return slot0.type_
end

function slot0.GetPos(slot0)
	return slot0.coordinateX_, slot0.coordinateY_
end

function slot0.GetLoaclPosition(slot0)
	return slot0.transform_.localPosition.x, slot0.transform_.localPosition.y
end

function slot0.OnReadyEnter(slot0)
	if slot0.onReadyEnterHandler_ then
		slot0.onReadyEnterHandler_()
	end
end

function slot0.ActionPass(slot0)
	if slot0.actionPassHandler_ then
		slot0.actionPassHandler_()
	end
end

function slot0.OnPass(slot0)
	if slot0.onPassedHandler_ then
		slot0.onPassedHandler_()
	end
end

function slot0.OnStop(slot0)
	if slot0.onStopHandler_ then
		slot0.onStopHandler_()
	end
end

function slot0.UpSliderEnter(slot0)
	if not PushBoxTool:CheckCanPass(slot0.coordinateX_, slot0.coordinateY_, 0, -1) then
		return
	end

	slot0:SliderEnter()
end

function slot0.DownSliderEnter(slot0)
	if not PushBoxTool:CheckCanPass(slot0.coordinateX_, slot0.coordinateY_, 0, 1) then
		return
	end

	slot0:SliderEnter()
end

function slot0.LeftSliderEnter(slot0)
	if not PushBoxTool:CheckCanPass(slot0.coordinateX_, slot0.coordinateY_, -1, 0) then
		return
	end

	slot0:SliderEnter()
end

function slot0.RightSliderEnter(slot0)
	if not PushBoxTool:CheckCanPass(slot0.coordinateX_, slot0.coordinateY_, 1, 0) then
		return
	end

	slot0:SliderEnter()
end

function slot0.SliderEnter(slot0)
	manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_change")
end

function slot0.NormalStop(slot0)
	slot0.isCanPass_ = false
end

function slot0.GoalActionPass(slot0)
	slot0.isCanPass_ = true
end

function slot0.GoalPass(slot0)
	slot0.overCon_:SetSelectedState("false")
end

function slot0.GoalStop(slot0)
	slot0.overCon_:SetSelectedState("true")

	slot0.isCanPass_ = false
end

function slot0.BridgeActionPass(slot0)
	slot0.isCanPass_ = false
end

function slot0.NormalActionPass(slot0)
	slot0.isCanPass_ = true
end

function slot0.BridgePass(slot0)
	slot0.bridgeCon_:SetSelectedState("true")
	manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_break")
end

function slot0.UpSlider(slot0)
	if not PushBoxTool:CheckCanPass(slot0.coordinateX_, slot0.coordinateY_, 0, -1) then
		slot0.isCanPass_ = false

		return
	end

	manager.notify:Invoke(PUSH_BOX_ACTION, 0, -1, slot0.coordinateX_, slot0.coordinateY_)
end

function slot0.DownSlider(slot0)
	if not PushBoxTool:CheckCanPass(slot0.coordinateX_, slot0.coordinateY_, 0, 1) then
		slot0.isCanPass_ = false

		return
	end

	manager.notify:Invoke(PUSH_BOX_ACTION, 0, 1, slot0.coordinateX_, slot0.coordinateY_)
end

function slot0.LeftSlider(slot0)
	if not PushBoxTool:CheckCanPass(slot0.coordinateX_, slot0.coordinateY_, -1, 0) then
		slot0.isCanPass_ = false

		return
	end

	manager.notify:Invoke(PUSH_BOX_ACTION, -1, 0, slot0.coordinateX_, slot0.coordinateY_)
end

function slot0.RightSlider(slot0)
	if not PushBoxTool:CheckCanPass(slot0.coordinateX_, slot0.coordinateY_, 1, 0) then
		slot0.isCanPass_ = false

		return
	end

	manager.notify:Invoke(PUSH_BOX_ACTION, 1, 0, slot0.coordinateX_, slot0.coordinateY_)
end

function slot0.OnExit(slot0)
	slot0:Reset()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:Reset()
	slot0.super.Dispose(slot0)
end

return slot0
