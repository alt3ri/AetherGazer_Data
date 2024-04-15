slot1 = class("NewGuildBossAssistHeroFilterView", import("game.views.newHero.NewHeroListFilterView"))

function slot1.SetHeroIdList(slot0, slot1)
	slot0.heroDataList_ = slot1
	slot0.displayHeroDataList_ = {}

	for slot5, slot6 in ipairs(slot1) do
		if not HeroTools.GetIsHide(slot6.assist_hero_id) then
			table.insert(slot0.displayHeroDataList_, slot6)
		end
	end

	slot0:RefreshSort()
end

function slot1.UpdateList(slot0)
	slot1 = GameSetting.unlock_hero_need.value

	table.sort(slot0.displayHeroDataList_, function (slot0, slot1)
		slot2 = false
		slot3 = false

		if uv0.extraSorter_ ~= nil then
			slot4, slot3 = uv0.extraSorter_(slot0, slot1)

			if slot4 then
				return slot3
			end
		end

		slot4 = slot0
		slot5 = slot1

		if uv0.curSortType_ == 0 then
			slot6, slot3 = uv0:FightPowerSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:RareSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:LevelSorter(slot4, slot5)

			if slot6 then
				return slot3
			end
		else
			slot6, slot3 = uv0:RareSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:FightPowerSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:LevelSorter(slot4, slot5)

			if slot6 then
				return slot3
			end
		end

		if slot0.assist_hero_id ~= slot1.assist_hero_id then
			return slot1.assist_hero_id < slot0.assist_hero_id
		end

		return tonumber(slot1.member_id) < tonumber(slot0.member_id)
	end)

	if slot0.callback_ ~= nil then
		slot0.callback_(slot0.displayHeroDataList_)
	end
end

function slot1.FightPowerSorter(slot0, slot1, slot2)
	if slot1.fight_capacity ~= slot2.fight_capacity then
		if slot0.curOrder_ == "desc" then
			return true, slot4 < slot3
		else
			return true, slot3 < slot4
		end
	end

	return false, false
end

function slot1.RareSorter(slot0, slot1, slot2)
	if HeroCfg[slot1.assist_hero_id].rare ~= HeroCfg[slot2.assist_hero_id].rare then
		if slot0.curOrder_ == "desc" then
			return true, slot4.rare < slot3.rare
		else
			return true, slot3.rare < slot4.rare
		end
	end

	return false, false
end

function slot1.RefreshSort(slot0, slot1)
	if not slot0.available_ then
		return
	end

	for slot5, slot6 in ipairs(slot0.heroDataList_) do
		slot6.id = slot6.assist_hero_id
	end

	slot0.displayHeroDataList_ = HeroTools.GetHeroShowData(slot0.heroDataList_, slot1)

	slot0:UpdateList()
	slot0:RenderFilterBtn()
end

return slot1
