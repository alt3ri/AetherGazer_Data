slot0 = class("HeroTrammelsComboItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.combRoleNumController = ControllerUtil.GetController(slot0.transform_, "combRoleNum")
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_btn, function ()
		if uv0.callback_ then
			uv0.callback_(uv0.comboId)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.comboId = slot1

	slot0:Refresh()
	slot0:RefreshRedPoint()
end

function slot0.Refresh(slot0)
	slot2 = ComboSkillCfg[slot0.comboId]
	slot0.m_skillLevel.text = GetTips("LEVEL") .. ComboSkillData:GetCurComboSkillLevel(slot0.comboId)
	slot0.m_comboName.text = HeroSkillCfg[slot2.skill_id].name
	slot7 = slot2.skill_id
	slot0.m_icon.sprite = getSpriteViaConfig("ComboSkill", slot7)

	for slot7, slot8 in ipairs(slot2.cooperate_role_ids) do
		slot0["m_comboHead" .. slot7].sprite = getSpriteViaConfig("HeroLittleIcon", slot8)
	end

	slot0.combRoleNumController:SetSelectedIndex(#slot2.cooperate_role_ids)
end

function slot0.RefreshRedPoint(slot0)
	if ComboSkillData:GetCurComboSkillLevel(slot0.comboId) < ComboSkillTools.GetMaxComboSkillLevel(slot0.comboId) then
		slot4 = true

		for slot8, slot9 in ipairs(ComboSkillLevelCfg.get_id_list_by_level[slot2]) do
			if not ComboSkillTools.CheckComboSkillUpContion(slot9, slot0.comboId) then
				slot4 = false

				break
			end
		end

		if slot4 then
			manager.redPoint:SetRedPointIndependent(slot0.transform_, true)
		else
			manager.redPoint:SetRedPointIndependent(slot0.transform_, false)
		end
	else
		manager.redPoint:SetRedPointIndependent(slot0.transform_, false)
	end
end

function slot0.RefreshState(slot0, slot1)
	slot0.stateController:SetSelectedIndex(slot1 == slot0.comboId and 1 or 0)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if not slot1 then
		slot0.comboId = 0
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.GetComboId(slot0)
	return slot0.comboId
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
