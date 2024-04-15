manager.net:Bind(72201, function (slot0)
	if not HeroClueData:IsInited(slot0.activity_id) then
		uv0.InitRedConst(slot1)
	end

	HeroClueData:InitData(slot0)
	uv0.UpdateDrawRedPoint(slot1)
	uv0.UpdateNewClueRedPoint(slot1)
end)

return {
	Draw = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(72202, {
			clue_pool_id = slot1,
			open_num = slot2
		}, 72203, function (slot0)
			if isSuccess(slot0.result) then
				for slot5, slot6 in ipairs(slot0.clue_list) do
					HeroClueData:SetUnlockClue(slot6, 1)
				end

				uv0.UpdateDrawRedPoint(uv1)
				uv0.UpdateNewClueRedPoint(uv1)
				manager.notify:CallUpdateFunc(HERO_CLUE_DRAW, slot1)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	InitRedConst = function (slot0)
		slot6 = string.format("%s_%d", RedPointConst.HERO_CLUE_PLAY, slot0)

		manager.redPoint:addGroup(slot6, {
			string.format("%s_%d", RedPointConst.ACTIVITY_TASK, HeroClueTools.GetPlayTaskActivityID(slot0)),
			string.format("%s_%d", RedPointConst.HERO_CLUE_DRAW, slot0)
		})
		manager.redPoint:addGroup(string.format("%s_%d", RedPointConst.HERO_CLUE, slot0), {
			string.format("%s_%d", RedPointConst.ACTIVITY_TASK, HeroClueTools.GetTaskActivityID(slot0)),
			slot6
		})
	end,
	UpdateDrawRedPoint = function (slot0)
		slot1 = 0
		slot2 = HeroCluePoolCfg.get_id_list_by_activity_id[slot0][1]
		slot3 = HeroClueCfg.get_id_list_by_clue_pool[slot2]
		slot4 = HeroClueData:GetUnlockClueDataDic()

		if ItemTools.getItemNum(HeroCluePoolCfg[slot2].item_id) >= 1 then
			for slot10, slot11 in ipairs(slot3) do
				if slot4[slot11] ~= nil then
					if slot12.level < #HeroClueCfg[slot11].level then
						slot1 = 1

						break
					end
				else
					slot1 = 1

					break
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.HERO_CLUE_DRAW, slot0), slot1)
	end,
	UpdateNewClueRedPoint = function (slot0)
		for slot7, slot8 in ipairs(HeroClueCfg.get_id_list_by_clue_pool[HeroCluePoolCfg.get_id_list_by_activity_id[slot0][1]]) do
			slot11 = 0

			manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.HERO_CLUE_NEW, slot0, slot8), HeroClueData:GetNewClueDic()[slot8] == true and (not (HeroClueData:GetSelectedClue(slot0, slot8) == true) and 1 or 0) or 0)
		end
	end
}
