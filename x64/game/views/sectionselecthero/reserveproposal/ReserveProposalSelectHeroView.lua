slot1 = class("ReserveProposalSelectHeroView", import("game.views.sectionSelectHero.SelectHeroBaseView"))

function slot1.OnEnter(slot0)
	slot0:RegistEventListener(COMBO_SKILL_SELECT, slot0.selectComboSkillHandler_)
	slot0:SubViewOnEnter()
end

function slot1.SetContID(slot0, slot1)
	if #slot0.loadingList_ > 0 then
		return
	end

	slot0.reserveParams_.contID = slot1

	slot0:RefreshHeroTeam()
	slot0:RefreshMimir()
	slot0:LoadHeroModels(clone(slot0.cacheHeroTeam_))
end

function slot1.LoadHeroModels(slot0, slot1)
	slot2 = slot0.heroModel_
	slot3 = {
		[slot8] = slot7
	}

	for slot7, slot8 in ipairs(slot1) do
		if slot8 ~= 0 then
			-- Nothing
		end
	end

	slot0.heroModel_ = {}

	for slot7, slot8 in ipairs(slot0.cacheHeroTeam_) do
		slot3[slot8] = nil

		if slot3[slot8] ~= nil and slot9 ~= slot7 then
			slot2[slot9] = nil

			slot0:SetHeroModelPos(slot2[slot9], slot7)
		end
	end

	for slot7, slot8 in pairs(slot2) do
		manager.resourcePool:DestroyOrReturn(slot8, ASSET_TYPE.TPOSE)
	end

	for slot7, slot8 in pairs(slot0.loadAsyncIndex_) do
		manager.resourcePool:StopAsyncQuest(slot0.loadAsyncIndex_[slot7])
	end

	slot0.loadAsyncIndex_ = {}
	slot0.loadingList_ = {}
	slot0.cacheHeroNumber_ = {
		1,
		2,
		3
	}

	for slot7, slot8 in ipairs(slot0.cacheHeroTeam_) do
		if slot8 ~= 0 and slot8 and slot0.heroModel_[slot7] == nil then
			table.insert(slot0.loadingList_, slot8)

			slot0.loadAsyncIndex_[slot7] = manager.resourcePool:AsyncLoad("Char/" .. slot0:GetSkinCfg(slot7).ui_modelId, ASSET_TYPE.TPOSE, function (slot0)
				uv0:SetHeroModelPos(slot0, uv1)

				if table.keyof(uv0.loadingList_, uv2) then
					table.remove(uv0.loadingList_, slot1)
				end
			end)
		end
	end
end

function slot1.SetHeroModelPos(slot0, slot1, slot2)
	slot0.heroModel_[slot2] = slot1
	slot0.heroModel_[slot2].transform.localEulerAngles = SectionSelectHeroTools.HeroTransform[slot2].rotation
	slot0.heroModel_[slot2].transform.localPosition = SectionSelectHeroTools.HeroTransform[slot2].position
	slot0.heroModel_[slot2].transform.localScale = SectionSelectHeroTools.HeroTransform[slot2].scale
end

function slot1.GetHeroInfoItemClass(slot0)
	return SectionSelectHeroInfoItem
end

function slot1.GetMimirInfoViewClass(slot0)
	return NewSectionMimirView
end

function slot1.GetComboSkillViewClass(slot0)
	return NewSectionComboSkillView
end

return slot1
