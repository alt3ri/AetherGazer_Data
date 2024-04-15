slot0 = class("MoonFillingItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selecteController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.makeTimesController_ = ControllerUtil.GetController(slot0.transform_, "makeTimes")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickHandler_ then
			uv0.clickHandler_(uv0.ID_)
		end
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.ID_ = slot1

	slot0:RefrehsUI()
end

function slot0.RefrehsUI(slot0)
	slot1 = MoonCakeFillingCfg[slot0.ID_].patties
	slot0.icon_.sprite = ItemTools.getItemSprite(slot1)
	slot0.nameText_.text = ItemTools.getItemName(slot1)
end

function slot0.SetType(slot0, slot1)
	slot0.type_ = slot1

	slot0.typeController_:SetSelectedIndex(slot0.type_)

	if slot0.type_ == MoonCakeConst.FILLING_ITEM_TYPE.FILLING_MAKE then
		slot0.maxTimes_ = MoonCakeTools.GetFillingMultiTimes(slot0.ID_)

		if slot0.maxTimes_ > 0 then
			slot0.timesText_.text = string.format(GetTips("%d", slot0.maxTimes_))
		else
			slot0.timesText_.text = GetTips("NOT_ENOUGH")
		end

		slot0.makeTimesController_:SetSelectedState(slot0.maxTimes_ and "true" or "false")
	end
end

function slot0.SetSelect(slot0, slot1)
	slot0.selecteController_:SetSelectedState(slot0.ID_ == slot1 and "true" or "false")
end

function slot0.SetClickHandler(slot0, slot1)
	slot0.clickHandler_ = slot1
end

return slot0
