slot0 = class("NewComboSkillItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUi()
end

function slot0.InitUi(slot0)
	slot0:BindCfgUI()

	slot0.jumpController = slot0.controllerexcollection_:GetController("jump")

	slot0:AddBtnListener(nil, slot0.m_jumpBtn, function ()
		JumpTools.OpenPageByJump("/heroTrammels", {
			page = 1,
			heroId = uv0.heroId,
			comboId = uv0.comboId
		})
	end)
	TerminologyTools.AddTerminologyHandler(slot0, slot0.textDesc_, nil, )
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.heroId = slot2
	slot0.comboId = slot1
	slot3 = ComboSkillCfg[slot1]
	slot4 = HeroSkillCfg[slot3.skill_id]
	slot5 = ComboSkillData:GetCurComboSkillLevel(slot1)
	slot0.textLv_.text = GetTips("LEVEL") .. string.format("%s", slot5)
	slot0.textTitle_.text = GetI18NText(slot4.name)
	slot10 = slot5
	slot0.textDesc_.text = GetI18NText(GetCfgDescription(slot4.desc[1], slot10, 2, slot3.maxLevel))
	slot9 = slot3.skill_id
	slot0.imageIcon_.sprite = getSpriteViaConfig("ComboSkill", slot9)

	for slot9, slot10 in ipairs(slot3.cooperate_role_ids) do
		SetActive(slot0[string.format("roleitem%sGo_", slot9)], true)

		slot0[string.format("iconImg%s_", slot9)].sprite = getSpriteViaConfig("HeroLittleIcon", slot10)
	end

	for slot9 = #slot3.cooperate_role_ids + 1, 3 do
		SetActive(slot0[string.format("roleitem%sGo_", slot9)], false)
	end

	if ArchiveData:GetTrustLevel(slot0.heroId) == 0 then
		slot0.jumpController:SetSelectedIndex(0)
	else
		slot0.jumpController:SetSelectedIndex(1)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
