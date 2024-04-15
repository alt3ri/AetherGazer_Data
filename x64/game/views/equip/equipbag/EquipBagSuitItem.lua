slot0 = class("EquipBagSuitItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListener(nil, , "OnClick")

	slot0.recommendController_ = slot0.transform_:GetComponent("ControllerExCollection"):GetController("recommend")
	slot0.selectController_ = slot0.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data = slot2
	slot0.ids = {}

	if table.indexof(EquipRecommendCfg[slot1] and EquipRecommendCfg[slot1].suit_list or {}, slot2) then
		slot0.recommendController_:SetSelectedIndex(0)
	else
		slot0.recommendController_:SetSelectedIndex(1)
	end

	slot4 = EquipSuitCfg[slot2]

	SetSpriteWithoutAtlasAsync(slot0.icon_, SpritePathCfg.EquipIcon_s.path .. slot4.icon)

	slot0.name_.text = GetI18NText(slot4.name)

	table.insert(slot0.ids, slot2)
end

function slot0.RefreshPos(slot0, slot1, slot2)
	slot0.num_ = 0

	for slot6, slot7 in ipairs(slot0.ids) do
		slot0.num_ = slot0.num_ + EquipTools.GetSuitEquipNum(slot7, nil, slot1, slot2)
	end

	slot0:SetBottomText()
end

function slot0.SetBottomText(slot0)
	slot0.numText_.text = slot0.num_
end

function slot0.Dispose(slot0)
	slot0.clickFunc = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnClick(slot0)
	if slot0.clickFunc and slot0.num_ ~= 0 then
		slot0.clickFunc(slot0.data)
	end
end

function slot0.SetSelect(slot0, slot1)
	if slot0.num_ == 0 then
		slot0.selectController_:SetSelectedIndex(2)
	elseif slot1 then
		slot0.selectController_:SetSelectedIndex(1)
	else
		slot0.selectController_:SetSelectedIndex(0)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

return slot0
