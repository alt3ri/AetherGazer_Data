slot0 = class("SectionComboSelectView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Formation/FormationSkillPopUPUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.skillItemList_ = {}
	slot0.chooseSkillHandler_ = handler(slot0, slot0.OnChooseSkill)
end

function slot0.GetComboSkillItemView(slot0)
	return SectionComboSelectItem
end

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.heroList_ = slot0.params_.heroList
	slot0.trialHeroList_ = slot0.params_.trailList
	slot0.stageType_ = slot0.params_.stageType
	slot0.stageID_ = slot0.params_.stageID
	slot0.sectionProxy_ = slot0.params_.sectionProxy
	slot0.comboSkillID_ = slot0.params_.comboSkillID

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.comboSkillIDList_ = slot0:GetComboSkillList()

	for slot4, slot5 in ipairs(slot0.comboSkillIDList_) do
		if not slot0.skillItemList_[slot4] then
			slot0.skillItemList_[slot4] = slot0:GetComboSkillItemView().New(Object.Instantiate(slot0.skillItemGo_, slot0.contentTrans_))

			slot0.skillItemList_[slot4]:RegistChooseCallback(slot0.chooseSkillHandler_)
		end

		slot0.skillItemList_[slot4]:SetData(slot0.stageType_, slot0.stageID_, slot5, slot0.comboSkillID_ == slot5, slot0.heroList_)
	end

	for slot4 = #slot0.comboSkillIDList_ + 1, #slot0.skillItemList_ do
		slot0.skillItemList_[slot4]:Show(false)
	end
end

function slot0.GetComboSkillList(slot0)
	return ComboSkillTools.GetComboSkillList(slot0.heroList_, true)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.skillItemList_) do
		slot5:Dispose()
	end

	slot0.skillItemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnShowComboSkillDesc(slot0)
	FrameTimer.New(function ()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.contentTrans_)
	end, 1, 1):Start()
end

function slot0.OnChooseSkill(slot0, slot1)
	slot0:SetComboSkillID(slot1)
	manager.notify:CallUpdateFunc(COMBO_SKILL_SELECT, slot1)
	manager.notify:Invoke(COMBO_SKILL_SELECT, slot1)
end

function slot0.SetComboSkillID(slot0, slot1)
	slot0.sectionProxy_:SetComboSkillID(slot1)
end

return slot0
