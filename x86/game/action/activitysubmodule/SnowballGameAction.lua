manager.net:Bind(65427, function (slot0)
	SnowballGameData:InitFromServer(slot0)
end)

function slot1(slot0)
	for slot4, slot5 in ipairs(SnowballGameCfg.all) do
		if SnowballGameCfg[slot5].activity_id == slot0 then
			return true
		end
	end

	return false
end

manager.notify:RegistListener(ACTIVITY_UPDATE, function (slot0)
	if ActivityTools.GetActivityType(slot0) == ActivityTemplateConst.MINIGAME_STAGE and uv0(acitvityID) then
		SnowballGameData:UpdateUnlockLevelRedPoint()
	end
end)
manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function ()
	SnowballGameData:CheckTaskRedPoint()
end)

return {
	EnterGameAction = function (slot0, slot1)
		manager.net:SendWithLoadingNew(65422, {
			activity_id = SnowballGameData.activityID,
			stage_id = slot0
		}, 65423, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 then
					uv0(uv1)
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	LevelClearAction = function (slot0, slot1)
		print(slot0.level, slot0.score, SnowballGameData.activityID)
		manager.net:SendWithLoadingNew(65424, {
			activity_id = SnowballGameData.activityID,
			stage_id = slot0.level,
			score = slot0.score,
			hero_id = slot0.heroId,
			use_seconds = slot0.seconds,
			enemy_list = slot0.enemy_list
		}, 65425, function (slot0)
			if isSuccess(slot0.result) then
				SnowballGameData:OnLevelClear(uv0.level, uv0.score)
			else
				ShowTips(slot0.result)
			end

			if uv1 then
				uv1(uv0)
			end
		end)
	end
}
