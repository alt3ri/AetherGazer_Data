slot0 = class("GotoActivityReforgeStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot0:GotoActivityReforgeStage(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult, slot1.isHalfWay_)
end

function slot0.GotoActivityReforgeStage(slot0, slot1, slot2, slot3, slot4, slot5)
	if isSuccess(slot1) and not slot5 then
		function BattleCallLuaCallBack()
			manager.story:RemovePlayer()

			slot4 = ActivityReforgeLevelCfg[uv0:GetLevelID()].wave_list

			if slot4[#slot4] == uv0:GetWaveID() then
				gameContext:Go("/activityReforgeBattleInfoView", {
					IsBattleBack = true,
					activityID = uv0:GetMainActivityID(),
					chapterActivityID = uv0:GetChapterActivityID(),
					levelID = slot2,
					waveID = slot3,
					stageData = uv0
				})
			else
				ActivityReforgeData:SetCachePopBattleInfoView(true)
				gameContext:Go("/activityReforgeTrimView", {
					IsBattleBack = true,
					activityID = slot0,
					chapterActivityID = slot1,
					levelID = slot2,
					stageData = uv0
				})
			end

			EndBattleLogic(uv1)
		end
	else
		slot0:GotoBattleFaild(slot1, slot2, slot3, slot4)
	end
end

return slot0
