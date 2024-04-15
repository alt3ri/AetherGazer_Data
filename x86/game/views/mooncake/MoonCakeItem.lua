slot0 = class("MoonCakeItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddListeners()
	SetActive(slot0.gameObject_, true)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selecteController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.enoughController_ = ControllerUtil.GetController(slot0.transform_, "enough")
	slot0.unlockController_ = ControllerUtil.GetController(slot0.transform_, "unlock")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickHandler_ then
			uv0.clickHandler_(uv0.ID_, uv0)
		end
	end)
end

function slot0.Dispose(slot0)
	slot0.clickHandler_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.itemID_ = slot1
	slot0.ID_ = slot2

	if slot3 ~= true then
		slot0:RefreshUI()
	end

	slot0:SetActive(true)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshNum()
	slot0:RefreshName()
	slot0:RefreshIcon()
end

function slot0.RefreshNum(slot0, slot1)
	slot0.numText_.text = slot1 or ItemTools.getItemNum(slot0.itemID_)
end

function slot0.RefreshName(slot0)
	slot0.nameText_.text = ItemTools.getItemName(slot0.itemID_)
end

function slot0.RefreshIcon(slot0)
	slot0.icon_.sprite = ItemTools.getItemSprite(slot0.itemID_)
end

function slot0.SetUnlock(slot0, slot1)
	slot0.unlockController_:SetSelectedState(slot1 == true and "on" or "off")
end

function slot0.SetSelect(slot0, slot1)
	slot0.selecteController_:SetSelectedState(slot0.ID_ == slot1 and "on" or "off")
end

function slot0.SetEnough(slot0, slot1)
	slot0.enoughController_:SetSelectedState(slot1 == true and "on" or "off")
end

function slot0.SetMakeTimes(slot0, slot1)
	slot0.makeTimesText_.text = string.format(GetTips("MID_AUTUMN_FESTIVAL_MOONCAKE_MAKING_PREVIEW"), slot1)
end

function slot0.SetType(slot0, slot1)
	slot0.type_ = slot1

	slot0.typeController_:SetSelectedIndex(slot0.type_)
end

function slot0.SetClickHandler(slot0, slot1)
	slot0.clickHandler_ = slot1
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
