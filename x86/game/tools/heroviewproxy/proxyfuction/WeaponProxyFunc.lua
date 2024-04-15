return {
	GetHeroWeaponInfo = function (slot0, slot1)
		slot2 = slot0.dataClass:GetHeroWeaponInfo(slot1, slot0.tempHeroList)

		if slot0:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
			slot3 = deepClone(slot2)
			slot3.breakthrough = 0
			slot3.exp = 0
			slot3.level = 1

			return slot3
		end

		return slot2
	end
}
