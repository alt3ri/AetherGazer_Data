manager.net:Bind(83021, function (slot0)
	ColorPuzzleData:SetFinishedLevels(slot0.stage_completed_list)
end)

return {
	LevelClearAction = function (slot0, slot1)
		slot0.useseconds = math.floor(slot0.useseconds)

		manager.net:SendWithLoadingNew(83024, slot0, 83025, uv0.OnClearLevelCallback)

		slot0.callback = slot1
	end,
	OnClearLevelCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if slot1.result == 1 then
				ColorPuzzleData:SetFinishedLevels(slot0.finished_list)
			end

			ColorPuzzleData:UpdateLevelClearTime(slot1.stage_id, slot1.useseconds)

			if slot1.callback then
				slot1:callback(slot0)
			end
		else
			ShowTips(slot0.result)
		end
	end,
	LevelResetAction = function (slot0)
		slot0.useseconds = math.floor(slot0.useseconds)

		manager.net:Send(83024, slot0, 83025)
	end
}
