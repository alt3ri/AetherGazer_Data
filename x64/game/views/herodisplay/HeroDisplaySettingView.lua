slot0 = class("HeroDisplaySettingView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.dropDownText_ = {
		GetTips("LEFT_TOP"),
		GetTips("LEFT_BOTTOM"),
		GetTips("RIGHT_TOP"),
		GetTips("RIGHT_BOTTOM")
	}
	slot0.cardController_ = slot0.cardControllerEx_:GetController("default0")
	slot0.levelController_ = slot0.levelControllerEx_:GetController("default0")
	slot0.uidController_ = slot0.uidControllerEx_:GetController("default0")
	slot0.actionController_ = slot0.actionControllerEx_:GetController("default0")
	slot0.color_ = Color.New(0.372549, 0.372549, 0.372549, 1)
	slot0.bgColor_ = Color.New(0.8862746, 0.8862746, 0.8862746, 1)
	slot0.checkmarkColor_ = Color.New(0.2980392, 0.3490196, 0.4156863, 1)

	slot0:InitDropdownData()
end

function slot0.InitDropdownData(slot0)
	slot1 = "<color=#FFFFFF>%s</color>"
	slot0.dropDownLogo_.itemText.color = Color.New(0, 0, 0, 1)
	slot0.dropDownCard_.itemText.color = Color.New(0, 0, 0, 1)
	slot2 = GetTips("LEFT_TOP")

	slot0.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(slot1, slot2), nil))
	slot0.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(slot1, slot2), nil))

	slot2 = GetTips("LEFT_BOTTOM")

	slot0.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(slot1, slot2), nil))
	slot0.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(slot1, slot2), nil))

	slot2 = GetTips("RIGHT_TOP")

	slot0.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(slot1, slot2), nil))
	slot0.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(slot1, slot2), nil))

	slot2 = GetTips("RIGHT_BOTTOM")

	slot0.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(slot1, slot2), nil))
	slot0.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(slot1, slot2), nil))
	slot0:RefreshDropDownOptions(slot0.dropDownLogo_)
	slot0:RefreshDropDownOptions(slot0.dropDownCard_)
end

function slot0.RefreshDropDownOptions(slot0, slot1)
	slot2 = "<color=#FFFFFF>%s</color>"

	for slot7 = 1, slot1.options.Count do
		if slot7 - 1 == slot1.value then
			slot1.options[slot7 - 1].text = slot0.dropDownText_[slot7]
		else
			slot1.options[slot7 - 1].text = string.format(slot2, slot0.dropDownText_[slot7])
		end
	end
end

function slot0.OnEnter(slot0)
	slot1 = HeroDisplayData:GetSetting()
	slot0.dropDownLogo_.value = slot1.logoPos
	slot0.toggleCard_.isOn = slot1.cardShow
	slot0.dropDownCard_.value = slot1.cardPos
	slot0.toggleLevel_.isOn = slot1.cardShowLv
	slot0.toggleUID_.isOn = slot1.cardShowUID

	slot0:RefreshInteractable(slot1.cardShow)
end

function slot0.RefreshInteractable(slot0, slot1)
	slot0.dropDownCard_.interactable = slot1
	slot0.toggleLevel_.interactable = slot1
	slot0.toggleUID_.interactable = slot1

	if slot1 then
		slot0.imageUID2_.color = slot0.checkmarkColor_
		slot0.imageLv2_.color = slot0.checkmarkColor_
	else
		slot0.imageUID2_.color = slot0.color_
		slot0.imageLv2_.color = slot0.color_
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonCancel_, nil, function ()
		uv0:OnExit()
		SetActive(uv0.gameObject_, false)
	end)
	slot0:AddBtnListener(slot0.buttonOk_, nil, function ()
		HeroDisplayData:SaveSetting({
			logoPos = uv0.dropDownLogo_.value,
			cardShow = uv0.toggleCard_.isOn,
			cardPos = uv0.dropDownCard_.value,
			cardShowLv = uv0.toggleLevel_.isOn,
			cardShowUID = uv0.toggleUID_.isOn
		})
		uv0:OnExit()
		SetActive(uv0.gameObject_, false)
	end)
	slot0:AddToggleListener(slot0.dropDownLogo_, function (slot0)
		if uv0.dropDownCard_.value == slot0 then
			if slot0 == 0 then
				uv0.dropDownCard_.value = 1
			else
				uv0.dropDownCard_.value = 0
			end
		end

		uv0:RefreshDropDownOptions(uv0.dropDownLogo_)
	end)
	slot0:AddToggleListener(slot0.dropDownCard_, function (slot0)
		if uv0.dropDownLogo_.value == slot0 then
			if slot0 == 0 then
				uv0.dropDownLogo_.value = 1
			else
				uv0.dropDownLogo_.value = 0
			end
		end

		uv0:RefreshDropDownOptions(uv0.dropDownCard_)
	end)
	slot0:AddToggleListener(slot0.toggleCard_, function (slot0)
		uv0:RefreshInteractable(slot0)
		uv0.cardController_:SetSelectedIndex(slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.toggleLevel_, function (slot0)
		uv0.levelController_:SetSelectedIndex(slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.toggleUID_, function (slot0)
		uv0.uidController_:SetSelectedIndex(slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.toggleAction_, function (slot0)
		uv0.actionController_:SetSelectedIndex(slot0 and 1 or 0)
	end)
end

return slot0
