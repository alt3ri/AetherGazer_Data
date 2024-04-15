return {
	GetRankHeroList = function (slot0, slot1)
		slot2 = {}
		slot3 = {}
		slot4 = nil

		if slot1 then
			slot4 = ActivityCfg[slot1].activity_template
		end

		if slot4 == ActivityTemplateConst.DESTROY_BOX_GAME_RANK then
			slot7 = clone(DestroyBoxGameCfg[DestroyBoxGameCfg.get_id_list_by_activity_id[ActivityCfg.get_id_list_by_sub_activity_list[slot1][1]][1]].trial_hero)

			table.sort(slot7, function (slot0, slot1)
				slot3 = RankData:GetActivityRank(uv0, slot0) and slot2.curRank
				slot6 = RankData:GetActivityRank(uv0, slot1) and slot5.curRank

				if (slot3 and slot3.score or 0) ~= (slot6 and slot6.score or 0) then
					print("xxxxxx", slot0, slot1)

					return slot7 < slot4
				else
					return slot0 < slot1
				end
			end)

			for slot11, slot12 in ipairs(slot7) do
				table.insert(slot2, HeroStandardSystemCfg[slot12].hero_id)
				table.insert(slot3, slot12)
			end
		end

		return slot2, slot3
	end
}
