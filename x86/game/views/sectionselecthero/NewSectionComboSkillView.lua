slot0 = class("NewSectionComboSkillView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Show(true)
	slot0:Init()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.heroItemList_) do
		slot5:Dispose()
	end

	slot0.heroItemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = slot0.controllerExCollection_:GetController("state")
	slot0.heroItemList_ = {}
end

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if not uv0.sectionProxy_.canChangeComboSkill then
			ShowTips("CANNOT_CHANGE_COMBO_SKILL")

			return
		end

		uv0:ClickComboSkillBtn()
	end)
end

function slot0.ClickComboSkillBtn(slot0)
	JumpTools.OpenPageByJump("sectionComboSelect", {
		stageType = slot0.sectionProxy_.stageType,
		stageID = slot0.sectionProxy_.stageID,
		heroList = slot0.sectionProxy_:GetHeroIDList(),
		trialList = slot0.sectionProxy_:GetTrialIDList(),
		comboSkillID = slot0.comboSkillID_,
		sectionProxy = slot0.sectionProxy_
	})
end

function slot0.SetProxy(slot0, slot1)
	slot0.sectionProxy_ = slot1
end

function slot0.SetData(slot0)
	slot0.comboSkillID_ = slot0:GetComboSkillID()

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if slot0.comboSkillID_ == 0 then
		slot0.stateController_:SetSelectedState("unEquip")
	else
		slot0.stateController_:SetSelectedState("equip")

		slot1 = ComboSkillCfg[slot0.comboSkillID_]
		slot6 = slot1.skill_id
		slot0.skillIcon_.sprite = getSpriteViaConfig("ComboSkill", slot6)
		slot0.titleText_.text = HeroSkillCfg[slot1.skill_id].name

		for slot6, slot7 in ipairs(slot1.cooperate_role_ids) do
			if not slot0.heroItemList_[slot6] then
				slot0.heroItemList_[slot6] = SectionSmallHeroItem.New(Object.Instantiate(slot0.heroItemGo_, slot0.heroContentTrans_))
			end

			slot0.heroItemList_[slot6]:SetData(slot7)
		end

		for slot6 = #slot1.cooperate_role_ids + 1, 3 do
			if slot0.heroItemList_[slot6] then
				slot0.heroItemList_[slot6]:Show(false)
			end
		end
	end
end

function slot0.GetComboSkillID(slot0)
	return slot0.sectionProxy_:GetComboSkillID()
end

function slot0.GetCurComboSkill(slot0)
	return slot0.comboSkillID_ or 0
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.OnComboSkillSelect(slot0)
	slot0.comboSkillID_ = slot0:GetComboSkillID()

	slot0:RefreshUI()
end

return slot0
