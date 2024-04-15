slot1 = class("AffixSelectBossInfoJapanRegionView", import("game.views.AffixSelect.AffixSelectBossInfoView"))

function slot1.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionAffixSelect/AffixSelectBossInfoUI"
end

function slot1.UpdateView(slot0)
	slot0.nameText_.text = GetMonsterName(slot0.bossIDList_)
	slot6 = MonsterCfg[slot0.bossIDList_[1]].race
	slot0.raceText_.text = GetTips("RACE_TYPE_" .. slot6)

	for slot6, slot7 in pairs(slot0.bossIDList_) do
		slot2 = "" .. slot7
	end

	slot0.icon_.sprite = getSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. slot2)
	slot0.riskText_.text = NumberTools.IntToRomam(slot1.type + 1)

	slot0:UpdateData()
	slot0:RefreshSkill()
end

return slot1
