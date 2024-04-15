slot1 = class("SkinTrialSelectView_2_2", import("game.views.skinTrialActivity.V2_0.SkinTrialSelectView_2_0"))

function slot1.Init(slot0)
	uv0.super.Init(slot0)

	slot0.styleController_ = ControllerUtil.GetController(slot0.transform_, "style")
end

function slot1.RefreshUI(slot0)
	uv0.super.RefreshUI(slot0)

	if slot0.styleController_ then
		slot0.styleController_:SetSelectedState("V2_2")
	end
end

function slot1.SaveRoute(slot0)
	SkinTrialData:SaveRoute({
		name = "skinTrialSelectView_2_2",
		activityID = slot0.activityID_,
		skinTrialID = slot0.skinTrialID_
	})
end

return slot1
