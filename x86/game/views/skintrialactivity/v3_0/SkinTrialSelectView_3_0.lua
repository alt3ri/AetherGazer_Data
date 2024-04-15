slot0 = class("SkinTrialSelectView_3_0", SkinTrialSelectView_2_0)

function slot0.Init(slot0)
	uv0.super.Init(slot0)
end

function slot0.AddListeners(slot0)
	uv0.super.AddListeners(slot0)

	if slot0.getBtn_ then
		slot0:AddBtnListener(slot0.getBtn_, nil, function ()
			SkinTrialAction.RequestSkinTrialReward(uv0.skinTrialID_)
		end)
	end

	slot0:RegistEventListener(SKIN_TRIAL_UPDATE, handler(slot0, slot0.OnSkinTrialUpdate))
end

function slot0.RefreshUI(slot0)
	uv0.super.RefreshUI(slot0)
	slot0:RefreshReceive()
end

function slot0.RefreshReceive(slot0)
	if not slot0.receiveController_ then
		return
	end

	if not slot0.receiveController then
		slot0.receiveController = slot0.receiveController_:GetController("default0")
	end

	if SkinTrialData:GetSkinTrialStatus(slot0.skinTrialID_) == 0 then
		slot0.receiveController:SetSelectedState("state0")
	elseif slot1 == 1 then
		slot0.receiveController:SetSelectedState("state2")
	elseif slot1 == 2 then
		slot0.receiveController:SetSelectedState("state1")
	end
end

function slot0.GetRewardItem(slot0)
	return CommonItemView
end

function slot0.OnSkinTrialUpdate(slot0, slot1)
	slot0:RefreshReceive()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.rewardCfg_[slot1]
	slot4 = clone(ItemTemplateData)
	slot4.index = slot1
	slot4.id = slot3[1]
	slot4.number = slot3[2]
	slot4.completedFlag = false

	function slot4.clickFun(slot0)
		if uv0.clickCallback_ then
			if uv0.clickCallback_() then
				ShowPopItem(uv0.popType_, slot0)
			end
		else
			ShowPopItem(uv0.popType_, slot0)
		end
	end

	slot2:SetData(slot4)
end

function slot0.SaveRoute(slot0)
	SkinTrialData:SaveRoute({
		name = "skinTrialSelectView_3_0",
		activityID = slot0.activityID_,
		skinTrialID = slot0.skinTrialID_
	})
end

return slot0
