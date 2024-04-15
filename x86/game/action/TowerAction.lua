manager.net:Bind(41001, function (slot0)
	TowerData:InitTowerData(slot0.info_list)
	uv0.UpdateTowerRedPoint()
end)
manager.notify:RegistListener(PLAYER_LEVEL_UP, function ()
	uv0.UpdateTowerRedPoint()
end)

return {
	UpdateTowerRedPoint = function ()
		if JumpTools.GetSystemLockedText(ChapterClientCfg[401].jump_system) then
			return
		end

		slot3 = false

		for slot7, slot8 in ipairs(ChapterClientCfg.get_id_list_by_toggle[401]) do
			if PlayerData:GetPlayerInfo().userLevel >= (ChapterCfg[slot8].level or 0) then
				if RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + slot8) == nil then
					slot3 = true
				end

				if (table.indexof(slot9.section_id_list, TowerData:GetOverId(slot8)) or 0) == 0 and RedPointData:GetIsRedPointOpen(RedPointConst.TOWER_NEW_LEVEL + slot8) == nil then
					manager.redPoint:setTip(RedPointConst.TOWER_NEW_LEVEL + slot8, 1, RedPointStyle.SHOW_NEW_TAG)
				else
					manager.redPoint:setTip(RedPointConst.TOWER_NEW_LEVEL + slot8, 0, RedPointStyle.SHOW_NEW_TAG)
				end
			end
		end

		manager.redPoint:setTip(RedPointConst.TOWER, slot3 and 1 or 0, RedPointStyle.SHOW_NEW_TAG)
	end,
	CancelTowerRedPoint = function ()
		for slot5, slot6 in ipairs(ChapterClientCfg.get_id_list_by_toggle[401]) do
			if PlayerData:GetPlayerInfo().userLevel >= (ChapterCfg[slot6].level or 0) and RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + slot6) == nil then
				RedPointAction.HandleRedPoint(RedPointConst.CHAPTER_CHANLLAGE_RANGE + slot6)
			end
		end

		manager.redPoint:setTip(RedPointConst.TOWER, 0, RedPointStyle.SHOW_NEW_TAG)
	end
}
