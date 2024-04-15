slot1 = class("XH3rdWaterBattleStatisticsView", import("game.views.battleResult.statistics.BattleStatisticsView"))

function slot1.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdWaterparkUI/XH3rdWPStatisticsUI"
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot1, slot2 = slot0.stageData:GetIsCooperation()
	slot4 = 0
	slot6 = 59

	for slot10 = 1, 3 do
		slot11, slot12 = nil
		slot13 = false

		if slot1 then
			if slot2[slot10] then
				if BattleFieldData:GetBattleResultData().battle_record_dir and slot15[slot11.playerID] then
					if 0 < (slot12[45] or 0) then
						slot3 = slot16
					end

					if slot4 < (slot12[slot6] or 0) then
						slot4 = slot17
					end
				end

				slot13 = slot11.is_master
			end
		else
			slot14, slot15, slot16 = BattleTools.GetBattleStatisticsData()
			slot13 = slot10 == 1
			slot19 = slot0.stageData:GetHeroTeam()
			slot21 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas
			slot12 = {}

			if slot10 <= ((LuaExchangeHelper.GetBattleStatisticsData() and slot17.dataForLua.currentHPHero or {}).Count or 0) then
				slot11 = {
					playerID = PlayerData:GetPlayerInfo().userID,
					nick = PlayerData:GetPlayerInfo().nick
				}
				slot22 = nil

				if slot10 == 1 and slot21:TryGetValue(slot5, slot22) then
					if slot3 < (slot21[slot5] or 0) then
						slot3 = slot23
					end

					slot12[slot5] = slot23
				end

				if slot10 == 1 and slot21:TryGetValue(slot6, slot22) then
					if slot4 < (slot21[slot6] or 0) then
						slot4 = slot23
					end

					slot12[slot6] = slot23
				end
			end
		end

		slot0.statisticsHeroItem_[slot10]:SetPlayer(slot10, slot0.stageData:GetActivityID(), slot11, slot3, slot4, slot1, slot12, slot13)
	end
end

function slot1.GetStatisticsItem(slot0)
	return XH3rdWaterBattleStatisticsItemView
end

return slot1
