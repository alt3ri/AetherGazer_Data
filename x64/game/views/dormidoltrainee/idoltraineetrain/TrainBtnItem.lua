slot0 = class("TrainBtnItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.upgradeController_ = slot0.mainControllerEx_:GetController("upgradeState")
	slot0.costController_ = slot0.mainControllerEx_:GetController("costState")
	slot0.selectController_ = slot0.mainControllerEx_:GetController("select")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.maxState_ then
			return
		end

		if uv0.select_ and uv0.timeOut_ then
			ShowTips(GetTips("IDOL_TRAIN_TIMES_NOT_ENOUGH"))

			return
		end

		if uv0.select_ and not uv0.costState_ then
			ShowTips(GetTips("DORM_FATIGUE_NOT_ENOUGH"))

			return
		end

		if uv0.select_ and not uv0.maxState_ and not uv0.timeOut_ and uv0.costState_ then
			IdolTraineeAction.TrainHeroProperty(uv0.heroID_, uv0.propertyIndex_)
		end

		if uv0.clickFunc then
			uv0.clickFunc(uv0.propertyIndex_)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.heroID_ = slot1
	slot0.propertyIndex_ = slot2
	slot0.maxState_ = slot3
	slot0.timeOut_ = slot6
	slot0.costState_ = slot4
	slot0.costText_.text = GameSetting.dorm_idol_hero_exercise_cost.value[1]

	slot0.costController_:SetSelectedState(slot4 and "true" or "false")

	if slot3 then
		slot0.upgradeController_:SetSelectedState("max")
	else
		slot0.upgradeController_:SetSelectedState("cannot")
	end
end

function slot0.RegisterClickFunc(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.RefreshBtnState(slot0, slot1)
	if slot0.propertyIndex_ == slot1 then
		slot0.selectController_:SetSelectedState("state1")

		slot0.select_ = true
	else
		slot0.selectController_:SetSelectedState("state0")

		slot0.select_ = false
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
