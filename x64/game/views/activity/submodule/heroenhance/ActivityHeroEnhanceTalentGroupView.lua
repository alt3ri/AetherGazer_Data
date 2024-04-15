slot0 = class("ActivityHeroEnhanceTalentDetailView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.expanded_ = false
	slot0.selected_ = false

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.talentItem_ = ActivityHeroEnhanceTalentItem.New(slot0.curTalentGo_)
	slot0.talentList_ = {}

	for slot4 = 1, 3 do
		table.insert(slot0.talentList_, ActivityHeroEnhanceTalentItem.New(slot0["selTalentGo_" .. slot4]))
	end

	slot0.lineController_ = slot0.controller_:GetController("line")

	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	function slot4(slot0)
		uv0:OnClickTalent(true, slot0, 0)
	end

	slot0.talentItem_:SetClickHandler(slot4)

	for slot4, slot5 in ipairs(slot0.talentList_) do
		slot5:SetClickHandler(function (slot0)
			uv0:OnClickTalent(false, slot0, uv1)
		end)
	end
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.cfgId_ = slot1
	slot0.stage_ = slot2
	slot0.talentIdList_ = slot3
end

function slot0.SetSelected(slot0, slot1)
	slot0.selected_ = slot1
end

function slot0.SelectIdx(slot0, slot1)
	slot0.selectIdx_ = slot1

	slot0:RefreshUI_SelectState()
end

function slot0.SetClickHandler(slot0, slot1)
	slot0.onClickTalenCallback_ = slot1
end

function slot0.RefreshUI(slot0)
	slot2 = nil
	slot4 = ActivityHeroEnhanceCfg[slot0.cfgId_].activity_id

	for slot8, slot9 in ipairs(slot0.talentIdList_) do
		slot11 = ActivityHeroEnhanceTools.IsTalentLock(slot4, slot9, true)
		slot12 = slot0.talentList_[slot8]

		slot12:SetData(slot4, slot9)
		slot12:SetUsed(ActivityHeroEnhanceData:IsTalentActivated(slot4, slot9))
		slot12:SetSelected(slot0.selectIdx_ == slot8)
		slot12:SetLock(slot11)
		slot12:RefreshUI()
		SetActive(slot12.gameObject_, slot0.selected_)

		slot3 = true and slot11

		if slot10 then
			slot2 = slot9
		end
	end

	slot0.talentItem_:SetData(slot4, slot2)
	slot0.talentItem_:SetSelected(slot0.selected_)
	slot0.talentItem_:SetLock(slot3)
	slot0.talentItem_:SetFirstAddFlag(ActivityHeroEnhanceTools.IsCfgTalentStageFirstCanAdd(slot1, slot0.stage_))
	slot0.talentItem_:RefreshUI()
	slot0.lineController_:SetSelectedState(slot3 and "weak" or "normal")
end

function slot0.RefreshUI_SelectState(slot0)
	for slot4, slot5 in ipairs(slot0.talentList_) do
		slot5:SetSelected(slot0.selectIdx_ == slot4)
		slot5:RefreshUI()
		SetActive(slot5.gameObject_, slot0.selected_)
	end

	slot0.talentItem_:SetSelected(slot0.selected_)
	slot0.talentItem_:RefreshUI()
end

function slot0.OnClickTalent(slot0, slot1, slot2, slot3)
	if slot0.onClickTalenCallback_ then
		slot0.onClickTalenCallback_(slot1, slot0.stage_, slot2, slot3)
	end
end

function slot0.Dispose(slot0)
	slot0.talentItem_:Dispose()

	for slot4, slot5 in ipairs(slot0.talentList_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
