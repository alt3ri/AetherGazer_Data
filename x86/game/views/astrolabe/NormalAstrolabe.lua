slot1 = class("NormalAstrolabe", import("game.views.astrolabe.BaseAstrolabe"))

function slot1.InitItem(slot0)
	if (HeroTools.IsSpHero(slot0.heroID) and slot0.lastHeroID and HeroTools.IsSpHero(slot0.lastHeroID)) == false then
		slot0:ClearItem()

		slot0.itemS_ = {}
	end

	for slot4 = 1, 3 do
		if not slot0.itemS_[slot4] then
			slot0.itemS_[slot4] = {}
		end

		for slot8 = 1, 3 do
			slot9 = slot0[string.format("item%d_%dGo_", slot4, slot8)]

			if not slot0.itemS_[slot4][slot8] then
				slot0.itemS_[slot4][slot8] = AstrolabeNode.New(slot0, Object.Instantiate(Asset.Load(slot0:GetItemName(slot0.heroID, slot8)), slot9.transform), slot4)
				slot0.itemS_[slot4][slot8].lineStar = slot9.transform:Find("line_star")

				if slot9.transform:Find("line_star_01") then
					slot0.itemS_[slot4][slot8].lineStar2 = slot13
				end
			end

			slot0.itemS_[slot4][slot8]:SetParent(slot9.transform)
		end
	end
end

function slot1.GetItemName(slot0, slot1, slot2)
	if HeroTools.IsSpHero(slot0.heroID) then
		if slot2 == 1 then
			return "UI/HeroGodHood/item_SP_01"
		end

		return "UI/HeroGodHood/item_SP_02"
	else
		return "UI/HeroGodHood/item"
	end
end

function slot1.RegistCallBack(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.itemS_ or {}) do
		for slot10, slot11 in ipairs(slot6) do
			slot11:RegistCallBack(slot1)
		end
	end
end

function slot1.RefreshData(slot0, slot1, slot2)
	slot0.heroInfo_ = slot1
	slot0.astrolabeInfo_ = slot2

	for slot6, slot7 in ipairs(slot0.itemS_ or {}) do
		for slot12, slot13 in ipairs(slot7) do
			slot13:SetNodeNameIsHide(slot0.isHideNodeName)
			slot13:SetProxy(slot0.heroViewProxy_)
			slot13:RefreshUI(slot0.astrolabeInfo_[slot6].astrolabe[slot12], slot0.heroInfo_)
			slot13:ResetEffect()

			if HeroTools.IsSpHero(slot0.heroInfo_.id) then
				slot13:ShowSelfEffect()
				slot13:ShowNextSpEffect()
			else
				slot13:ShowNextEffect()
			end
		end
	end
end

function slot1.SetNodeNameIsHide(slot0, slot1)
	slot0.isHideNodeName = slot1
end

function slot1.RefreshRedPoint(slot0)
	for slot4, slot5 in ipairs(slot0.itemS_) do
		for slot9, slot10 in ipairs(slot5) do
			slot11 = slot10:GetItemInfo()

			if slot0.heroViewProxy_ and (slot0.heroViewProxy_.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW or slot0.heroViewProxy_.viewDataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON or slot0.heroViewProxy_.viewDataType == HeroConst.HERO_DATA_TYPE.FOREIGN) then
				slot10:SetRedPoint(false)
			else
				slot12 = AstrolabeTools.GetIsCanUnlock(slot11.id, slot11.heroId)

				if HeroTools.IsSpHero(slot11.heroId) then
					slot10:SetRedPoint(AstrolabeTools.GetSpAstrolabeNodeCanEquiped(slot11.id, slot11.heroId))
				else
					slot10:SetRedPoint(slot12)
				end
			end
		end
	end
end

function slot1.GetFirstSelectItem(slot0)
	if slot0.heroInfo_ and slot0.astrolabeInfo_ and slot0.heroInfo_.using_astrolabe[#slot0.heroInfo_.using_astrolabe] then
		for slot5, slot6 in ipairs(slot0.itemS_ or {}) do
			for slot10, slot11 in ipairs(slot6) do
				if slot11:GetItemInfo().id == slot1 then
					return slot11
				end
			end
		end
	end

	return slot0:GetItem(1, 1)
end

function slot1.GetItem(slot0, slot1, slot2)
	return slot0.itemS_[slot1][slot2]
end

function slot1.ClearItem(slot0)
	for slot4, slot5 in ipairs(slot0.itemS_) do
		for slot9, slot10 in pairs(slot5) do
			if slot10 and slot10.Dispose then
				slot10:Dispose()
			end
		end
	end
end

function slot1.Dispose(slot0)
	slot0.super.Dispose(slot0)
end

return slot1
