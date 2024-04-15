slot0 = class("MoonFillingMakeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonFillingMakeUI"
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
	slot0.menuList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.scrollView_, MoonFillingMenuItem)
	slot0.chooseMenuHandler_ = handler(slot0, slot0.OnChooseMenu)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.makeBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if not uv0.curChoosedID_ then
			ShowTips("MID_AUTUMN_FESTIVAL_FILLING_MAKING_MATERIALS_SELECT")

			return
		end

		MoonCakeAction.MakeFilling(uv0.activityID_, uv0.curChoosedID_, uv0.curTimes_)
	end)
	slot0:AddBtnListener(slot0.addBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		uv0.curTimes_ = uv0.curTimes_ + 1

		uv0:RefreshMakePanel()
	end)
	slot0:AddBtnListener(slot0.subBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		uv0.curTimes_ = uv0.curTimes_ - 1

		uv0:RefreshMakePanel()
	end)
	slot0:AddBtnListener(slot0.maxBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		uv0.curTimes_ = uv0.maxTimes_

		uv0:RefreshMakePanel()
	end)
end

function slot0.Dispose(slot0)
	slot0.menuList_:Dispose()

	slot0.menuList_ = nil
	slot0.chooseMenuHandler_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID

	slot0:RefreshUI()

	slot0.materialAnim_.enabled = false
end

function slot0.OnExit(slot0)
	slot0.curChoosedID_ = nil
end

function slot0.RefreshUI(slot0)
	slot0.statusController_:SetSelectedState("none")
	slot0:RefreshMenu()
end

function slot0.RefreshMenu(slot0)
	slot0.fillingIdList_ = MoonCakeTools.GetSortedFilling(slot0.activityID_)

	slot0.menuList_:StartScroll(#slot0.fillingIdList_)
end

function slot0.RefreshMakePanel(slot0)
	slot0:RefreshMultiBtn()
	slot0:RefreshMaterial()

	slot0.curTimesText_.text = slot0.curTimes_
	slot0.makeBtn_.interactable = slot0.curTimes_ > 0
	slot1 = MoonCakeFillingCfg[slot0.curChoosedID_].patties
	slot0.chooseFillingIcon_.sprite = ItemTools.getItemSprite(slot1)
	slot0.chooseFillingNameText_.text = ItemTools.getItemName(slot1)
	slot0.chooseFillingNum_.text = string.format(GetTips("ALREADY_HAVE_COUNT"), ItemTools.getItemNum(slot1))
end

function slot0.RefreshMultiBtn(slot0)
	slot0.subBtn_.interactable = slot0.minTimes_ < slot0.curTimes_
	slot0.addBtn_.interactable = slot0.curTimes_ < slot0.maxTimes_
	slot0.maxBtn_.interactable = slot0.curTimes_ < slot0.maxTimes_
end

function slot0.RefreshMaterial(slot0)
	for slot5, slot6 in ipairs(MoonCakeFillingCfg[slot0.curChoosedID_].recipe) do
		slot0[string.format("materialIcon%d_", slot5)].sprite = ItemTools.getItemSprite(slot6[1])
		slot0[string.format("materialNum%d_", slot5)].text = "X" .. slot6[2] * slot0.curTimes_
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.fillingIdList_[slot1], slot0.activityID_)
	slot2:SetChooseHandler(slot0.chooseMenuHandler_)
end

function slot0.OnChooseMenu(slot0, slot1)
	if slot0.curChoosedID_ == slot1 then
		return
	end

	slot0.statusController_:SetSelectedState("select")

	slot2 = slot0.curChoosedID_ == slot1
	slot0.curChoosedID_ = slot1

	for slot7, slot8 in ipairs(slot0.menuList_:GetItemList()) do
		slot8:SetSelect(slot1)
	end

	slot0.maxTimes_, slot0.minTimes_ = MoonCakeTools.GetFillingMultiTimes(slot0.curChoosedID_)
	slot0.curTimes_ = slot0.minTimes_

	slot0:RefreshMakePanel()

	if not slot2 then
		slot0.materialAnim_.enabled = true

		slot0.materialAnim_:Play("Fx_icon_cx", -1, 0)
		slot0.materialAnim_:Update(0)
	end
end

function slot0.OnMoonCakeFillingMade(slot0)
	slot0.maxTimes_, slot0.minTimes_ = MoonCakeTools.GetFillingMultiTimes(slot0.curChoosedID_)

	if slot0.minTimes_ > 0 then
		slot0.curTimes_ = slot0.minTimes_

		slot0:RefreshMakePanel()
		slot0.menuList_:StartScroll(#slot0.fillingIdList_, table.indexof(slot0.fillingIdList_))
	else
		slot0:RefreshUI()

		slot0.curChoosedID_ = nil

		for slot5, slot6 in ipairs(slot0.menuList_:GetItemList()) do
			slot6:SetSelect(nil)
		end
	end
end

function slot0.BindRedPoint(slot0)
end

function slot0.UnBindRedPoint(slot0)
end

return slot0
