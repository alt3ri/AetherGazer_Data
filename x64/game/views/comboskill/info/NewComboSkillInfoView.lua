slot0 = class("NewComboSkillInfoView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_skill/HeroSkillPopUPUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.comboSkillList = {}
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(nil, slot0.backBtn_, function ()
		JumpTools.Back()
	end)
end

function slot0.CreatComboSkill(slot0, slot1)
	slot2 = nil
	slot0.comboSkillList[slot1] = NewComboSkillItem.New((slot1 ~= 1 or slot0.empoweringskillGo_) and Object.Instantiate(slot0.empoweringskillGo_, slot0.contentTrs_))

	return slot0.comboSkillList[slot1]
end

function slot0.OnEnter(slot0)
	slot0.heroId = slot0.params_.heroID

	slot0:UpdateSkillList()
end

function slot0.UpdateSkillList(slot0)
	slot0.comboSkillList_ = ComboSkillTools.GetHeroComboSkill(slot0.params_.heroID)

	for slot4, slot5 in pairs(slot0.comboSkillList) do
		SetActive(slot5.gameObject_, false)
	end

	for slot4, slot5 in pairs(slot0.comboSkillList_) do
		slot6 = slot0.comboSkillList[slot4] or slot0:CreatComboSkill(slot4)

		SetActive(slot6.gameObject_, true)
		slot6:RefreshUI(slot5, slot0.heroId)
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.comboSkillList) do
		if slot5 then
			slot5:Dispose()
		end
	end

	uv0.super.Dispose(slot0)
end

return slot0
