slot0 = class("SectionComboSelectItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.heroItemList_) do
		slot5:Dispose()
	end

	slot0.heroItemList_ = nil
	slot0.chooseCallback_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = slot0.controllerExCollection_:GetController("state")
	slot0.selectController_ = slot0.btnControllerExCollection_:GetController("select")
	slot0.heroItemList_ = {}
end

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.buttonSelect_, nil, function ()
		if uv0.comboSkillID_ ~= 0 and not uv0.canUse_ then
			return
		end

		uv0.chooseCallback_(uv0.comboSkillID_)
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		if uv0.comboSkillID_ == 0 then
			return
		end

		uv0:ShowDesc()
	end)
end

function slot0.RegistChooseCallback(slot0, slot1)
	slot0.chooseCallback_ = slot1
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:Show(true)

	slot0.stageType_ = slot1
	slot0.stageID_ = slot2
	slot0.comboSkillID_ = slot3
	slot0.isSelect_ = slot4
	slot0.heroList_ = slot5
	slot0.canUse_ = slot0:CanUse()

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if not (slot0.comboSkillID_ == 0) then
		slot0:RefreshInfo()
	end

	slot0.stateController_:SetSelectedState(tostring(not slot1))
	slot0:RefreshSelect()
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.CanUse(slot0)
	if slot0.comboSkillID_ == 0 then
		return true
	end

	for slot5, slot6 in ipairs(ComboSkillCfg[slot0.comboSkillID_].cooperate_role_ids) do
		if not table.keyof(slot0.heroList_, slot6) then
			return false
		end
	end

	return true
end

function slot0.RefreshInfo(slot0)
	slot1 = ComboSkillCfg[slot0.comboSkillID_]
	slot8 = ComboSkillData:GetCurComboSkillLevel(slot0.comboSkillID_)
	slot0.textLv_.text = GetTips("LEVEL") .. string.format("%s", slot8)
	slot0.titleText_.text = GetI18NText(HeroSkillCfg[slot1.skill_id].name)
	slot7 = slot1.skill_id
	slot0.skillIcon.sprite = getSpriteViaConfig("ComboSkill", slot7)

	for slot7, slot8 in ipairs(slot1.cooperate_role_ids) do
		if not slot0.heroItemList_[slot7] then
			slot0.heroItemList_[slot7] = SectionSmallHeroItem.New(Object.Instantiate(slot0.heroItemGo_, slot0.heroContentTrans_))
		end

		slot0.heroItemList_[slot7]:SetData(slot8)
		slot0.heroItemList_[slot7]:RefreshState(table.keyof(slot0.heroList_, slot8) ~= nil)
	end

	for slot7 = #slot1.cooperate_role_ids + 1, 3 do
		if slot0.heroItemList_[slot7] then
			slot0.heroItemList_[slot7]:Show(false)
		end
	end

	SetActive(slot0.descGo_, false)
end

function slot0.RefreshSelect(slot0)
	if slot0.canUse_ then
		if slot0.isSelect_ then
			slot0.selectController_:SetSelectedState("true")
		else
			slot0.selectController_:SetSelectedState("false")
		end
	else
		slot0.selectController_:SetSelectedState("none")
	end
end

function slot0.ShowDesc(slot0)
	SetActive(slot0.descGo_, not slot0.isOpeningDesc_)

	slot0.isOpeningDesc_ = not slot0.isOpeningDesc_
	slot1 = ComboSkillCfg[slot0.comboSkillID_]
	slot0.descText_.text = GetI18NText(GetCfgDescription(HeroSkillCfg[slot1.skill_id].desc[1], ComboSkillData:GetCurComboSkillLevel(slot0.comboSkillID_), 2, slot1.maxLevel))

	manager.notify:CallUpdateFunc(SECTION_COMBO_SELECT_SHOW_DESC)
end

return slot0
