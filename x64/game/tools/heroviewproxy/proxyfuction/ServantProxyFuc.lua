return {
	GetServantEffect = function (slot0, slot1, slot2, slot3)
		slot7 = slot0:GetHeroData(ServantTools.GetServantSpecHero(slot1))

		if WeaponServantCfg[slot1].effect[1] == 0 then
			return WeaponServantCfg[slot1].effect_desc
		else
			slot8 = nil

			if slot3 == true then
				if WeaponEffectCfg[slot5].simple_strength_description[1] and table.indexof((not slot7 or HeroTools:GetModulePowersByHeroIDAndLevel(slot7.id, slot7.moduleLevel)) and HeroTools:GetModulePowersByHeroIDAndLevel(slot6, 0), slot9.simple_strength_description[1]) then
					return slot9.simple_strength_description[2]
				else
					return slot9.simple_description
				end
			else
				slot9 = WeaponEffectCfg[slot5].description[1]

				if WeaponEffectCfg[slot5].strengthen_description[1] and table.indexof(slot8, WeaponEffectCfg[slot5].strengthen_description[1]) then
					slot9 = WeaponEffectCfg[slot5].strengthen_description[2]
				end

				return GetCfgDescription(slot9, slot2)
			end
		end
	end
}
