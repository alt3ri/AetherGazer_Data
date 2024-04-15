slot0 = class("ComboSkillSelectItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.selectBtnController_ = ControllerUtil.GetController(slot0.transformSelectBtn_, "conName")
	slot0.iconController_ = {}

	for slot5 = 1, 3 do
		slot0.iconController_[slot5] = ControllerUtil.GetController(slot0[string.format("transformItem%s_", slot5)], "conName")
	end

	slot0:AddBtnListener(slot0.buttonSelect_, nil, function ()
		if uv0.comboSkillID_ ~= 0 and not uv0.canUse_ then
			return
		end

		uv0:ClickBtn()
		uv0:Back()
	end)
end

function slot0.ClickBtn(slot0)
	ReserveTools.SetComboSkillID(slot0.reserveParams_, slot0.comboSkillID_)
	manager.notify:Invoke(COMBO_SKILL_SELECT, slot0.comboSkillID_)
end

function slot0.CanUse(slot0)
	if slot0.comboSkillID_ == 0 then
		return true
	end

	for slot6, slot7 in ipairs(ComboSkillCfg[slot1].cooperate_role_ids) do
		if not table.keyof(slot0.heroList_, slot7) then
			return false
		end
	end

	return true
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0.stageType_ = slot1
	slot0.stageID_ = slot2
	slot0.activityID_ = slot3
	slot0.comboSkillID_ = slot4
	slot0.heroList_ = slot6
	slot0.reserveParams_ = slot7

	if not (slot4 == 0) then
		slot0:RefreshInfo()
	end

	slot0.canUse_ = slot0:CanUse()

	SetActive(slot0.goEmpty_, slot8)
	SetActive(slot0.goInfo_, not slot8)
	slot0:ShowSelect(slot5)
end

function slot0.RefreshInfo(slot0)
	slot1 = slot0.comboSkillID_
	slot2 = ComboSkillCfg[slot1]

	slot0:RefreshLevelText(slot1)

	slot0.textName_.text = GetI18NText(HeroSkillCfg[slot2.skill_id].name)
	slot7 = slot2.skill_id
	slot0.imageSkillIcon_.sprite = getSpriteViaConfig("ComboSkill", slot7)

	for slot7, slot8 in ipairs(slot2.cooperate_role_ids) do
		SetActive(slot0[string.format("transformItem%s_", slot7)].gameObject, true)

		slot0[string.format("imageHeroIcon%s_", slot7)].sprite = getSpriteViaConfig("HeroLittleIcon", slot8)

		if table.keyof(slot0.heroList_, slot8) then
			slot0.iconController_[slot7]:SetSelectedState("on")
		else
			slot0.iconController_[slot7]:SetSelectedState("in")
		end
	end

	for slot7 = #slot2.cooperate_role_ids + 1, 3 do
		SetActive(slot0[string.format("transformItem%s_", slot7)].gameObject, false)
	end
end

function slot0.RefreshLevelText(slot0, slot1)
	slot0.textLv_.text = GetTips("LEVEL") .. string.format("%s", ComboSkillData:GetCurComboSkillLevel(slot1))
end

function slot0.ShowSelect(slot0, slot1)
	if slot1 then
		slot0.selectBtnController_:SetSelectedState("current")
	elseif slot0.canUse_ then
		slot0.selectBtnController_:SetSelectedState("change_1")
	else
		slot0.selectBtnController_:SetSelectedState("unclick")
	end
end

function slot0.OnComboSkillSelect(slot0, slot1)
	slot0:ShowSelect(slot0.comboSkillID_ == slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.selectBtnController_ = nil
	slot0.iconController_ = nil
end

return slot0
