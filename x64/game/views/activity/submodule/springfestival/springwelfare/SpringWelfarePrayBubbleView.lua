SpringPreheatPrayBubbleView = import("game.views.activity.Submodule.springFestival.springPreheat.SpringPreheatPrayBubbleView")
slot0 = class("SpringWelfarePrayBubbleView", SpringPreheatPrayBubbleView)

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	slot0.signController_ = ControllerUtil.GetController(slot0.transform_, "sign")
	slot0.acquireController_ = ControllerUtil.GetController(slot0.transform_, "acquire")
end

function slot0.SwitchController(slot0, slot1)
	if not slot0.selectController_ or not slot0.lockController_ or not slot0.signController_ or not slot0.acquireController_ then
		return
	end

	slot0.lockController_:SetSelectedState("false")
	slot0.selectController_:SetSelectedState("selected")

	if slot1 == SPRING_WELFARE_DAY_STATE_TYPE.ACQUIRED then
		slot0.acquireController_:SetSelectedState("acquired")
		slot0.signController_:SetSelectedState("false")
	elseif slot1 == SPRING_WELFARE_DAY_STATE_TYPE.NOT_ACQUIRE then
		slot0.acquireController_:SetSelectedState("notready")
		slot0.signController_:SetSelectedState("false")
	elseif slot1 == SPRING_WELFARE_DAY_STATE_TYPE.NEED_SIGN then
		slot0.acquireController_:SetSelectedState("ready")
		slot0.signController_:SetSelectedState("true")
	elseif slot1 == SPRING_WELFARE_DAY_STATE_TYPE.CAN_PRAY then
		slot0.acquireController_:SetSelectedState("ready")
		slot0.signController_:SetSelectedState("false")
	end
end

function slot0.GetDayState(slot0)
	return SpringWelfareData:GetDayState(slot0.day_)
end

function slot0.GetPraySelectionList(slot0)
	return SpringWelfareData:GetPraySelectionList(slot0.day_)
end

return slot0
