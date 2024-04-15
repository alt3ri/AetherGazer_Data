slot1 = class("GuildActivitySPSelectHeroProxy", import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy"))

function slot1.InitCustomParams(slot0, slot1)
	slot0.activityClubCfg = ActivityClubSPCfg[slot1.nodeId]
	slot0.nodeId = slot1.nodeId
	slot0.pathList = slot1.pathList
	slot0.needPresetReservePanel = false
	slot0.needHeroEnergy = true
end

function slot1.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})
	manager.windowBar:RegistHomeCallBack(function ()
		slot1 = nil
		slot2 = GuildActivitySPData:GetCurRunActivityID()

		gameContext:Go("/guildActivitySPWarField", {
			level = (GuildActivitySPData:GetCurrentGrid() == nil or slot0 <= 0 or table.indexof(ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()], ActivityClubSPCfg[slot0].map_id)) and 1,
			activityID = slot2,
			totalActivityID = slot2
		})
	end)
	manager.windowBar:RegistBackCallBack(function ()
		JumpTools.Back()
	end)
end

function slot1.CustomGetHeroEnergy(slot0, slot1, slot2, slot3)
	slot4 = slot0.activityClubCfg.vitality_cost

	for slot10, slot11 in pairs(slot0:GetHeroIDList()) do
		if slot11 and slot11 > 0 then
			slot6 = 0 + 1
		end
	end

	return string.format("%d(-%d)", GuildActivitySPData:GetHeroFatigue(slot2), math.floor(slot4 / slot6))
end

function slot1.CustomCheckBeforeGotoHeroInfoUI(slot0)
	if #GuildActivitySPData:GetFightHeroList() <= 0 then
		return false, "ACTIVITY_CLUB_NO_FIGHT_HERO_TIP"
	end

	return true
end

function slot1.GetHeroTeamInfoRoute(slot0)
	return "/guildActivitySPTeamInfo"
end

function slot1.CustomCheckBeforeBattle(slot0)
	slot2 = slot0.activityClubCfg.vitality_cost

	for slot7, slot8 in pairs(slot0:GetHeroIDList()) do
		if slot8 and slot8 > 0 then
			slot3 = 0 + 1
		end
	end

	for slot8, slot9 in pairs(slot1) do
		if slot9 and slot9 > 0 then
			slot10 = GuildActivitySPData:GetFightHeroById(slot9)

			if GuildActivitySPData:GetHeroFatigue(slot9) < math.floor(slot2 / slot3) then
				return false, "ACTIVITY_CLUB_HERO_VITALITY_NOT_ENOUGH_TIP"
			end
		end
	end

	return true
end

function slot1.GetStageData(slot0)
	slot1 = BattleStageFactory.Produce(slot0.stageType, slot0.stageID, slot0.activityID)

	slot1:SetNodeId(slot0.activityClubCfg.id)
	slot1:SetPathList(slot0.pathList)

	return slot1
end

return slot1
