slot0 = class("SectionComboSkillView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.comboSkillController_ = ControllerUtil.GetController(slot0.transform_, "teamwork")

	slot0:AddBtnListener(slot0.buttonComboSkill_, nil, function ()
		if uv0.isCustom_ then
			ShowTips("CANNOT_CHANGE_COMBO_SKILL")

			return
		end

		uv0:ClickComboSkillBtn()
	end)

	slot0.handler_ = handler(slot0, slot0.OnComboSkillSelect)

	manager.notify:RegistListener(COMBO_SKILL_SELECT, slot0.handler_)
end

function slot0.ClickComboSkillBtn(slot0)
	JumpTools.OpenPageByJump("comboSkillSelect", {
		stageType = slot0.stageType_,
		stageID = slot0.stageID_,
		activityID = slot0.activityID_,
		heroList = slot0.heroList_,
		trialList = slot0.trialList_,
		comboSkillID = slot0.comboSkillID_,
		reserveParams = slot0.reserveParams_
	})
end

function slot0.RefreshUI(slot0)
	if slot0.comboSkillID_ == 0 then
		slot0.comboSkillController_:SetSelectedState("off")
	else
		slot0.comboSkillController_:SetSelectedState("on")

		slot1 = ComboSkillCfg[slot0.comboSkillID_]
		slot5 = slot1.skill_id
		slot0.imageSkillIcon_.sprite = getSpriteViaConfig("ComboSkill", slot5)

		for slot5, slot6 in ipairs(slot1.cooperate_role_ids) do
			SetActive(slot0[string.format("goHeroItem%s_", slot5)], true)

			slot0[string.format("imageHeroIcon%s_", slot5)].sprite = getSpriteViaConfig("HeroLittleIcon", slot6)
		end

		for slot5 = #slot1.cooperate_role_ids + 1, 3 do
			SetActive(slot0[string.format("goHeroItem%s_", slot5)], false)
		end
	end
end

function slot0.SetHeroList(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0.isCustom_ = false
	slot0.stageType_ = slot1
	slot0.stageID_ = slot2
	slot0.activityID_ = slot3
	slot0.reserveParams_ = slot7

	if BattleStageTools.GetStageCfg(slot1, slot2) and slot8.combo_skill_id and slot8.combo_skill_id ~= 0 then
		slot0.comboSkillID_ = slot8.combo_skill_id

		SetActive(slot0.gameObject_, true)
		slot0:RefreshUI()

		slot0.isCustom_ = true

		return
	end

	if type(BattleStageTools.GetRestrictHeroList(slot1, slot2)) == "table" then
		SetActive(slot0.gameObject_, false)

		slot0.isCustom_ = true

		return
	end

	for slot14, slot15 in ipairs(slot4) do
		if slot15 ~= 0 then
			slot10 = 0 + 1
		end
	end

	if slot10 < 2 then
		SetActive(slot0.gameObject_, false)
		slot0:SetComboSkillID(0)

		slot0.comboSkillID_ = 0

		slot0:RefreshUI()

		return
	end

	SetActive(slot0.gameObject_, true)

	slot0.heroList_ = slot4
	slot0.trialList_ = slot5
	slot0.comboSkillID_ = slot0:GetComboSkillID()

	slot0:RefreshUI()
end

function slot0.GetComboSkillID(slot0)
	return ReserveTools.GetComboSkillID(slot0.reserveParams_)
end

function slot0.SetComboSkillID(slot0, slot1)
	ReserveTools.SetComboSkillID(slot0.reserveParams_, slot1)
end

function slot0.GetNeedRefresh(slot0)
	return ComboSkillData:GetNeedRefresh(slot0.stageType_, slot0.activityID_)
end

function slot0.SetNeedRefresh(slot0, slot1)
	ComboSkillData:SetNeedRefresh(slot1)
end

function slot0.OnComboSkillSelect(slot0, slot1)
	slot0.comboSkillID_ = slot1

	slot0:RefreshUI()
end

function slot0.GetCurComboSkill(slot0)
	return slot0.comboSkillID_ or 0
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.notify:RemoveListener(COMBO_SKILL_SELECT, slot0.handler_)

	slot0.handler_ = nil
end

return slot0
