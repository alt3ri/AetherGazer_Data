slot0 = class("SnowBallInfinityLevelItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.gameObject_.transform, "state")

	slot0:AddUIListener()
end

function slot0.GetController(slot0)
	return slot0.stateController
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.selectBtn_, nil, function ()
		if uv0.stateController:GetSelectedState() == "lock" then
			ShowTips("INFINITY_LOCK")
		else
			uv0.register(uv0.index)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.poolID = slot1
	slot0.index = slot2
	slot0.activityId = slot3
	slot0.register = slot5
	slot0.phase = slot4

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.levelTxt_.text = string.format(GetTips("ACTIVITY_SNOWBALL_ICE_LEVEL"), slot0.index)

	if OsirisInfinityPoolData:GetOpenPhase(slot0.activityId) < slot0.index then
		slot0.stateController:SetSelectedState("lock")
	else
		slot0.stateController:SetSelectedState(slot0.index == slot0.phase and "select" or "normal")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
