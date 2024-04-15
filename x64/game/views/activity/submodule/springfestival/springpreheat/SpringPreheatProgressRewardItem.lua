slot0 = class("SpringPreheatProgressRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.normalizedLocation_ = 0.5
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.onClickHandler_ then
			uv0:onClickHandler_()
		end
	end)
	slot0:AddBtnListener(slot0.getBtn_, nil, function ()
		if uv0.onClickHandler_ then
			uv0:onClickHandler_()
		end
	end)
end

function slot0.SetClickHandler(slot0, slot1)
	if slot1 then
		slot0.onClickHandler_ = slot1
	end
end

function slot0.SetData(slot0, slot1)
	slot0.id_ = slot1
end

function slot0.SetNormalizeLocation(slot0, slot1)
	slot0.normalizedLocation_ = slot1
end

function slot0.RefreshUI(slot0)
	if SpringPreheatData:IsAcquired(slot0.id_) then
		slot0.stateController_:SetSelectedState("received")
	elseif SpringPreheatData:CanAcquire(slot0.id_) then
		slot0.stateController_:SetSelectedState("complete")
	else
		slot0.stateController_:SetSelectedState("uncomplete")
	end

	slot0.needText_.text = ActivityPointRewardCfg[slot0.id_].need
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
