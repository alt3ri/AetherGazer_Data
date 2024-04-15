slot0 = class("EquipSkillLocationItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.info_ = slot2

	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = slot0.stateCon_:GetController("state")
	slot0.posController_ = slot0.stateCon_:GetController("pos")
end

function slot0.RefreshUI(slot0)
	if slot0.info_.isEquip then
		slot0.stateController_:SetSelectedState("equip")

		slot0.equipIcon_.sprite = ItemTools.getItemSprite(slot0.info_.prefab_id)

		slot0.posController_:SetSelectedState(EquipCfg[slot0.info_.prefab_id].pos)

		slot0.nameText_.text = ItemTools.getItemName(slot0.info_.prefab_id)
	else
		slot0.stateController_:SetSelectedState("transition")

		slot0.nameText_.text = GetTips("UPGRADE_STAR")
	end

	slot0.lvText_.text = "+" .. slot0.info_.level
end

function slot0.GetItemInfo(slot0)
	return slot0.info_
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
