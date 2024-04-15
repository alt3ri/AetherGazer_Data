slot0 = class("EquipNewSkillItem", ReduxView)
slot1 = import("game.tools.EquipTools")

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
	slot0:Init()
end

function slot0.SetIsEnchant(slot0, slot1, slot2)
	slot0.isEnchant_ = true
	slot0.index_ = slot1
end

function slot0.SetLockStatus(slot0, slot1)
end

function slot0.RefreshData(slot0, slot1, slot2, slot3, slot4)
	slot0.handler_ = slot1
	slot0.info_ = slot2
	slot0.lvmax_ = slot3

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListener(nil, , "OnClick")

	slot0.selectController_ = slot0.skillCon_:GetController("select")
	slot0.lockController_ = slot0.skillCon_:GetController("lock")
end

function slot0.Render(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if slot0.info_ then
		slot1 = EquipSkillCfg[slot0.info_.id]
		slot0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. slot1.icon)
		slot0.name_.text = GetI18NText(slot1.name)
		slot0.lv_.text = GetTips("LEVEL") .. (slot1.lvmax < slot0.info_.num and slot1.lvmax or slot0.info_.num)

		if slot0.info_.level and slot0.info_.level < (slot0.info_.unlockLevel or 0) then
			slot0.unlockLv_.text = string.format(GetTips("EQUIP_SKILL_LOCK_LEVEL"), slot0.info_.unlockLevel)

			slot0.lockController_:SetSelectedState("lock")
		else
			slot0.lockController_:SetSelectedState("unlock")
		end
	end
end

function slot0.ShowSelect(slot0, slot1)
	slot0.selectController_:SetSelectedState(slot1 and "select" or "unSelect")
end

function slot0.OnClick(slot0)
	if slot0.clickFunc then
		slot0.clickFunc(slot0.info_)
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

function slot0.Dispose(slot0)
	slot0.clickFunc = nil

	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
