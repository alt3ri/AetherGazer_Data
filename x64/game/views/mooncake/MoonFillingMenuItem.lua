slot0 = class("MoonFillingMenuItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selecteController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.materialList_ = {}
	slot0.fillingItem_ = MoonCakeItem.New(slot0.fillingItemGo_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if uv0.maxTimes_ <= 0 then
			ShowTips("MID_AUTUMN_FESTIVAL_FILLING_MAKING_INSUFFICIENT_RAW_MATERIALS")

			return
		end

		if uv0.chooseHandler_ then
			uv0.chooseHandler_(uv0.fillingID_)
		end
	end)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.materialList_) do
		slot5:Dispose()
	end

	slot0.materialList_ = nil

	slot0.fillingItem_:Dispose()

	slot0.fillingItem_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.activityID_ = slot2
	slot0.fillingID_ = slot1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.fillingItem_:SetData(MoonCakeFillingCfg[slot0.fillingID_].patties)
	slot0.fillingItem_:SetType(MoonCakeConst.ITEM_STYLE.MAKE)

	slot0.maxTimes_ = MoonCakeTools.GetFillingMultiTimes(slot0.fillingID_)

	if slot0.maxTimes_ > 0 then
		slot0.fillingItem_:SetMakeTimes(slot0.maxTimes_)
	end

	slot0.fillingItem_:SetEnough(slot0.maxTimes_ > 0)
	slot0:RefreshMaterial()
end

function slot0.RefreshMaterial(slot0)
	for slot5, slot6 in ipairs(MoonCakeFillingCfg[slot0.fillingID_].recipe) do
		if not slot0.materialList_[slot5] then
			slot0.materialList_[slot5] = MoonCakeItem.New(Object.Instantiate(slot0.materialGo_, slot0.materialContentTrans_))
		end

		slot0.materialList_[slot5]:SetData(slot6[1])
		slot0.materialList_[slot5]:SetEnough(slot6[2] <= ItemTools.getItemNum(slot6[1]))
	end

	for slot6 = #slot1 + 1, #slot0.materialList_ do
		slot0.materialList_[slot6]:SetActive(false)
	end
end

function slot0.SetSelect(slot0, slot1)
	slot0.selecteController_:SetSelectedState(slot0.ID_ == slot1 and "true" or "false")
end

function slot0.SetChooseHandler(slot0, slot1)
	slot0.chooseHandler_ = slot1
end

return slot0
