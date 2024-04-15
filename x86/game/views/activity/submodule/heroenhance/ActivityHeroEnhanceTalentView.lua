slot0 = class("ActivityHeroEnhanceTalentView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.talentGroups_ = {}

	for slot5 = 1, 4 do
		table.insert(slot0.talentGroups_, ActivityHeroEnhanceTalentGroupView.New(slot0["talentGroupGo_" .. slot5]))
	end

	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	for slot4, slot5 in ipairs(slot0.talentGroups_) do
		slot5:SetClickHandler(function (slot0, slot1, slot2, slot3)
			if uv0.onClickTalenCallback_ then
				uv0.onClickTalenCallback_(uv1, uv2, slot0, slot1, slot2, slot3)
			end
		end)
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.cfgId_ = slot1
end

function slot0.SelectGroupIdx(slot0, slot1, slot2)
	if slot0.selectGroupIdx_ == slot1 then
		return
	end

	slot0.selectGroupIdx_ = slot1

	if slot1 > 0 then
		slot0.talentGroups_[slot1]:SelectIdx(slot2)
	end
end

function slot0.SetClickTalentHandler(slot0, slot1)
	slot0.onClickTalenCallback_ = slot1
end

function slot0.RefreshUI(slot0)
	slot1 = ActivityHeroEnhanceCfg[slot0.cfgId_]
	slot2 = slot1.activity_id
	slot0.heroImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. slot1.hero_id)

	slot0.heroImage_:SetNativeSize()

	for slot8, slot9 in ipairs(slot0.talentGroups_) do
		slot10 = slot8

		slot9:SetData(slot0.cfgId_, slot10, ActivityHeroEnhanceTools.GetCfgTalentDict(slot1)[slot10])
		slot9:SetSelected(slot0.selectGroupIdx_ == slot8)
		slot9:RefreshUI()
	end
end

function slot0.RefreshUI_SelectState(slot0)
	for slot4, slot5 in ipairs(slot0.talentGroups_) do
		slot5:SetSelected(slot0.selectGroupIdx_ == slot4)
		slot5:RefreshUI_SelectState()
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.talentGroups_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
