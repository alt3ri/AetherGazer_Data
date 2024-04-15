return {
	GetBattlePower = function (slot0, slot1)
		slot2 = slot0:GetHeroData(slot1)
		slot3 = slot0:GetEquipDataList(slot1)
		slot4 = slot0:GetHeroServantInfo(slot1)
		slot5 = nil
		slot6 = 0

		if slot0.tempHeroList then
			slot6 = slot2.tempID
		end

		return calcBattlePower(slot2, slot4, slot3, slot2.tempID, (slot0:GetViewDataType() ~= HeroConst.HERO_DATA_TYPE.POLYHEDRON or GetPolyhedronHeroPracticalAttr(PolyhedronData:GetPolyhedronInfo(), slot2, slot3, slot6)) and GetHeroFinalAttr(slot2, slot2:GetServantInfo(), slot3, slot6, true))
	end,
	GetHeroAllAttribute = function (slot0, slot1, slot2)
		slot3 = 0
		slot4 = nil
		slot4 = (slot2 or slot0:GetHeroData(slot1)) and slot2
		slot5 = slot0:GetEquipDataList(slot1)

		if slot0.tempHeroList then
			slot3 = slot4.tempID
		end

		slot6 = nil
		slot6 = (slot0:GetViewDataType() ~= HeroConst.HERO_DATA_TYPE.POLYHEDRON or GetPolyhedronHeroPracticalAttr(PolyhedronData:GetPolyhedronInfo(), slot4, slot5, slot3)) and GetHeroFinalAttr(slot4, slot4:GetServantInfo(), slot5, slot3, false)
		slot6[HeroConst.HERO_ATTRIBUTE.ATK] = (slot6[HeroConst.HERO_ATTRIBUTE.ATK] or 0) * (1 + (slot6[11] or 0) / 1000 + (slot6[13] or 0) / 1000) + (slot6[12] or 0)
		slot6[HeroConst.HERO_ATTRIBUTE.ARM] = (slot6[HeroConst.HERO_ATTRIBUTE.ARM] or 0) * (1 + (slot6[21] or 0) / 1000) + (slot6[22] or 0)
		slot6[HeroConst.HERO_ATTRIBUTE.STA] = (slot6[HeroConst.HERO_ATTRIBUTE.STA] or 0) * (1 + (slot6[31] or 0) / 1000) + (slot6[32] or 0)

		return slot6
	end
}
