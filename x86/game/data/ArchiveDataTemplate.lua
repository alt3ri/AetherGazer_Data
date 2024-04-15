HeroTrustRelationNet = class("HeroTrustRelationNet")

function HeroTrustRelationNet.Ctor(slot0, slot1)
	slot0.heroId = slot1
	slot0.tier_Dir = {}
end

function HeroTrustRelationNet.InitData(slot0, slot1)
	slot0.tier_Dir = {}

	for slot5, slot6 in ipairs(slot1.tier_list) do
		slot7 = slot6.tier
		slot8 = {}

		for slot12, slot13 in ipairs(slot6.upgrade_complete_list) do
			table.insert(slot8, slot13)
		end

		slot0.tier_Dir[slot7] = slot8
	end
end

function HeroTrustRelationNet.GetRelationNetAttr(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(HeroRelationNetCfg.get_id_list_by_hero_id[slot0.heroId] or {}) do
		for slot14, slot15 in ipairs(slot0.tier_Dir[HeroRelationNetCfg[slot7].index] or {}) do
			for slot21, slot22 in pairs(HeroRelationUpgradeCfg[slot8.relation_upgrade_group[slot15]].attr) do
				slot23 = slot22[1]
				slot1[slot23] = HeroTools.AttributeAdd(slot23, slot1[slot23], slot22[2])
			end
		end
	end

	slot3 = {}

	for slot7, slot8 in pairs(slot1) do
		table.insert(slot3, {
			slot7,
			slot8
		})
	end

	return slot1, slot3
end

function HeroTrustRelationNet.GetIsUnlock(slot0, slot1, slot2)
	if not slot0.tier_Dir[slot1] then
		return false
	end

	return table.indexof(slot0.tier_Dir[slot1], slot2)
end

function HeroTrustRelationNet.UnlockRelationNet(slot0, slot1, slot2)
	if not slot0.tier_Dir[slot1] then
		slot0.tier_Dir[slot1] = {
			slot2
		}

		return
	end

	if not table.indexof(slot0.tier_Dir[slot1], slot2) then
		table.insert(slot0.tier_Dir[slot1], slot2)
	end
end
