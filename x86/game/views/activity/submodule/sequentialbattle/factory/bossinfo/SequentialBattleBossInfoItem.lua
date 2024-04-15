slot0 = class("SequentialBattleBossInfoItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.skillList_ = {}
	slot0.scrollRectCast_ = slot0:FindCom("ScrollRectCast", "", slot0.scrollView_.transform)

	slot0.scrollRectCast_:SetParent(slot0.parentGo_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.skillList_) do
		slot5:Dispose()
	end

	slot0.skillList_ = nil
end

function slot0.SetBossID(slot0, slot1, slot2)
	slot0.bossIDList_ = slot1

	for slot7, slot8 in pairs(slot0.bossIDList_) do
		slot3 = (nil ~= nil or tostring(slot8)) and tostring(slot8) .. tostring(slot8)
	end

	slot0.portraitImage_.sprite = getSpriteWithoutAtlas(string.format("TextureConfig/MardukUI/boss/solo582x648/%s", slot3))
	slot0.nameText_.text = GetMonsterName(slot0.bossIDList_)
	slot0.tagText_.text = GetTips("RACE_TYPE_" .. MonsterCfg[slot0.bossIDList_[1]].race)
	slot5 = GetMonsterSkillDesList(slot0.bossIDList_)
	slot6 = 1

	for slot10 = 1, 6 do
		if slot5[slot10] then
			if not slot0.skillList_[slot6] then
				slot0.skillList_[slot6] = BattleBossChallengeSkillItem.New(slot0.skillItem_, slot0.skillParent_)
			end

			slot0.skillList_[slot6]:RefreshUI(slot5[slot10])

			slot6 = slot6 + 1
		end
	end

	for slot10 = slot6, #slot0.skillList_ do
		slot0.skillList_[slot10]:Hide()
	end

	slot0.lvText_.text = NumberTools.IntToRomam(slot2)
end

return slot0
