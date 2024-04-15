slot0 = class("ChipManagerUnlockView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.handler_ = handler(slot0, slot0.RefreshBtn)

	manager.notify:RegistListener(ENABLED_CHIP_MANAGER, slot0.handler_)

	slot0.btnCon_ = slot0.btnControllerexcollection_:GetController("btn")
end

function slot0.AddListeners(slot0)
	for slot4 = 1, GameSetting.ai_secondary_chip_equip_num.value[1] do
		slot0:AddBtnListener(slot0[string.format("chipBtn%s_", slot4)], nil, function ()
			uv0:OnSelectChipBtn(uv1)
		end)
	end
end

function slot0.SetDataTemplate(slot0, slot1)
	slot0.chipDatatemplate_ = slot1
end

function slot0.SetChipManagerID(slot0, slot1)
	slot0.chipManagerID_ = slot1
	slot2 = ChipCfg[slot1]

	for slot7 = 1, #slot0:GetChipData() do
		slot0[string.format("chipIcon%s_", slot7)].sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[slot3[slot7]].picture_id)

		slot0[string.format("use%s_", slot7)]:GetController("useState"):SetSelectedState("use")
	end

	for slot7 = #slot3 + 1, GameSetting.ai_secondary_chip_equip_num.value[1] do
		if slot0[string.format("use%s_", slot7)] then
			slot0[string.format("use%s_", slot7)]:GetController("useState"):SetSelectedState("nouse")
		end
	end
end

function slot0.RefreshBtn(slot0)
	slot0.btnCon_:SetSelectedState("unlock")
end

function slot0.Dispose(slot0)
	slot0:UnbindRedPoint()
	uv0.super.Dispose(slot0)
	manager.notify:RemoveListener(ENABLED_CHIP_MANAGER, slot0.handler_)

	slot0.handler_ = nil
end

function slot0.GetChipData(slot0)
	return slot0.chipDatatemplate_:GetEquipChipList()
end

function slot0.GetEnabledManagerID(slot0)
	return slot0.chipDatatemplate_.useChipmanagerId
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.chipBtnTransform_, RedPointConst.CHIP_CHIP)
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.chipBtnTransform_)
end

function slot0.OnSelectChipBtn(slot0, slot1)
	slot0:Go(slot0.chipDatatemplate_:GetChipInfoViewPath() or "/chipInfo", {
		chipManagerID = slot0.chipManagerID_,
		selectChipIndex = slot1,
		chipDataTemplate = slot0.chipDatatemplate_
	})
end

function slot0.SetActive(slot0, slot1)
	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, slot1)
	end
end

return slot0
