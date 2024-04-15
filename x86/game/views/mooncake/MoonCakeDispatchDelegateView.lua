slot0 = class("MoonCakeDispatchDelegateView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonDelegateDispatchUI"
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

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.clickCakeHandler_ = handler(slot0, slot0.OnClickCake)
	slot0.cakeItemList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.scrollView_, MoonCakeItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.dispatchBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if not uv0.targetCakeID_ then
			return
		end

		MoonCakeAction.DispatchDelegate(uv0.activityID_, uv0.targetCakeID_, function ()
			uv0:Back()
		end)
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.Dispose(slot0)
	slot0.cakeItemList_:Dispose()

	slot0.cakeItemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.targetCakeID_ = nil

	slot0:RefreshUI()
	slot0:RefreshStatus()
end

function slot0.RefreshUI(slot0)
	slot0.cakeIdList_ = MoonCakeCfg.get_id_list_by_activity[slot0.activityID_]

	slot0.cakeItemList_:StartScroll(#slot0.cakeIdList_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.cakeIdList_[slot1]

	slot2:SetData(MoonCakeCfg[slot3].moon_cakes, slot3)
	slot2:SetClickHandler(slot0.clickCakeHandler_)
	slot2:SetSelect(slot0.targetCakeID_)
end

function slot0.RefreshStatus(slot0)
	if not slot0.targetCakeID_ then
		slot0.statusController_:SetSelectedState("off")
	else
		slot0.statusController_:SetSelectedState("on")

		slot1 = MoonCakeCfg[slot0.targetCakeID_].moon_cakes
		slot0.dispatchCakeName_.text = ItemTools.getItemName(slot1)
		slot0.dispatchCakeIcon_.sprite = ItemTools.getItemSprite(slot1)
	end
end

function slot0.OnClickCake(slot0, slot1)
	slot0.targetCakeID_ = slot1

	for slot6, slot7 in pairs(slot0.cakeItemList_:GetItemList()) do
		slot7:SetSelect(slot1)
	end

	slot0:RefreshStatus()
end

return slot0
