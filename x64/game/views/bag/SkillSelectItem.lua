slot0 = class("SkillSelectItem", ReduxView)
slot1 = import("game.const.EquipConst")
slot2 = import("game.tools.EquipTools")

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.info_ = slot2

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListener(slot0.clickBtn_, nil, "OnClick")

	slot0.selectController_ = slot0.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function slot0.Init(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 and slot1.id ~= 0 then
		slot2 = EquipSkillCfg[slot1.id]
		slot0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. slot2.icon)
		slot0.name_.text = GetI18NText(slot2.name)
	end
end

function slot0.SetIndex(slot0, slot1)
	slot0.transform_:SetSiblingIndex(slot1)
end

function slot0.SetBottomText(slot0, slot1)
	if slot0.num_ then
		slot0.numText_.text = slot1
	end
end

function slot0.RefreshPos(slot0, slot1, slot2)
	slot0.num_ = uv0.GetEquipSkillNum(slot0.info_.id, nil, slot1, slot2)

	slot0:SetBottomText(slot0.num_)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.info_ = nil
	slot0.clickFunc = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnClick(slot0)
	if slot0.clickFunc and slot0.num_ ~= 0 then
		slot0.clickFunc(slot0.info_.id)
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

function slot0.GetItemInfo(slot0)
	return slot0.info_
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
