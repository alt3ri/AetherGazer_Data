slot0 = class("MoonPartyOpenView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonPartyOpenUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.planController1_ = ControllerUtil.GetController(slot0.planTrans1_, "status")
	slot0.planController2_ = ControllerUtil.GetController(slot0.planTrans2_, "status")
end

function slot0.AddUIListener(slot0)
	for slot4 = 1, 2 do
		slot0:AddBtnListener(slot0[string.format("planBtn%d_", slot4)], nil, function ()
			if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
				ShowTips("TIME_OVER")

				return
			end

			uv0:SelectPlan(uv1)
		end)
	end

	slot0:AddBtnListener(slot0.confirmBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if uv0.selectPlan_ == 0 then
			return
		end

		ShowMessageBox({
			title = GetTips("COMFIRM"),
			content = GetTips("MID_AUTUMN_FESTIVAL_PARTY_BEGIN"),
			OkCallback = function ()
				MoonCakeAction.OpenParty(uv0.activityID_, uv0.selectPlan_)
			end
		})
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot1, slot2, slot3 = MoonCakeTools.CheckPartyPlanValid(slot0.activityID_, MoonCakeConst.PARTY_TYPE.CAKE)
	slot0.planDescText1_.text = string.format(GetTips("MID_AUTUMN_FESTIVAL_PARTY_CONSUME_1"), slot3)
	slot0.progressText1_.text = string.format(GetTips("%d/%d"), slot2, slot3)

	slot0.planController1_:SetSelectedState(slot1 and "on" or "off")

	slot4, slot5, slot6 = MoonCakeTools.CheckPartyPlanValid(slot0.activityID_, MoonCakeConst.PARTY_TYPE.VISIT)
	slot0.planDescText2_.text = string.format(GetTips("MID_AUTUMN_FESTIVAL_PARTY_CONSUME_2"), slot6)
	slot0.progressText2_.text = string.format(GetTips("MID_AUTUMN_FESTIVAL_PARTY_CONSUME_PROGRESS"), slot5, slot6)

	slot0.planController2_:SetSelectedState(slot4 and "on" or "off")

	slot0.selectPlan_ = 0

	if slot1 then
		slot0.selectPlan_ = 1
	elseif slot4 then
		slot0.selectPlan_ = 2
	end

	slot0:SelectPlan(slot0.selectPlan_)
	slot0:BindRedPoint()
end

function slot0.OnExit(slot0)
	slot0:UnBindRedPoint()
end

function slot0.SelectPlan(slot0, slot1)
	slot0.selectPlan_ = slot1

	slot0.selectController_:SetSelectedIndex(slot1)
end

function slot0.OnPartyOpen(slot0)
	slot0:Back()
end

function slot0.OnPartyReset(slot0)
	if not manager.messageBox:GetIsAllFree() then
		manager.messageBox:HideAll()
	end
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.confirmBtn_.transform, string.format("%s_%s", RedPointConst.MOON_PARTY_OPEN, slot0.activityID_))
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.confirmBtn_.transform, string.format("%s_%s", RedPointConst.MOON_PARTY_OPEN, slot0.activityID_))
end

return slot0
