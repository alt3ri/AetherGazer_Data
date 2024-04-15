slot1 = class("GuildBossSelectHeroProxy", import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy"))

function slot1.InitCustomParams(slot0, slot1)
	slot0.dest = slot1.dest
	slot0.needHeroAssistant = true
end

function slot1.CustomRefreshHeroInfoList(slot0, slot1, slot2, slot3, slot4)
	slot0.reserveHeroInfoList = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.GUILD_BOSS):GetCurHeroInfoList()

	for slot9 = 1, #slot0.heroInfoList do
		if slot0.reserveHeroInfoList[slot9] then
			if slot0.reserveHeroInfoList[slot9].type == 2 then
				slot0.heroInfoList[slot9]:SetAssistantInfo(true, slot0.reserveHeroInfoList[slot9].info)
			else
				slot0.heroInfoList[slot9]:SetAssistantInfo(false)
			end
		end
	end
end

function slot1.CustomChangeHeroTeam(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		for slot11, slot12 in ipairs(slot0.reserveHeroInfoList) do
			if slot12.type == 2 and slot12.info.assist_hero_id == slot7 then
				slot2[slot7] = slot12
			elseif slot12.type == 1 and slot12.heroId == slot7 then
				slot2[slot7] = slot12
			end
		end
	end

	for slot7, slot8 in pairs(slot1) do
		-- Nothing
	end

	slot0.reserveHeroInfoList = {
		[slot7] = slot2[slot8]
	}

	slot0:GuildBossChangeHeroTeam(slot0.reserveHeroInfoList)
end

function slot1.CustomApplyRroposalHeroTeam(slot0, slot1)
	for slot6, slot7 in pairs(slot1) do
		-- Nothing
	end

	slot0.reserveHeroInfoList = {
		[slot6] = {
			type = 1,
			heroId = slot7
		}
	}

	slot0:GuildBossChangeHeroTeam(slot0.reserveHeroInfoList)
end

function slot1.CustomSaveTeam(slot0)
	slot0:GuildBossChangeHeroTeam(slot0.reserveHeroInfoList)
end

function slot1.GuildBossChangeHeroTeam(slot0, slot1)
	slot3 = {
		0,
		0,
		0
	}
	slot4 = {}
	slot5 = 1

	for slot9 = 1, 3 do
		if slot1[slot9] then
			if slot1[slot9].type == 1 then
				-- Nothing
			elseif slot10.type == 2 then
				slot2[slot5] = slot10.info.assist_hero_id
				slot4[slot5] = slot10.info.member_id
			end

			slot5 = slot5 + 1
		end
	end

	slot6 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.GUILD_BOSS)

	slot6:SetHeroList(slot0.reserveParams, {
		[slot5] = slot10.heroId
	}, slot3)
	slot6:SetOwnerID(slot4)
end

function slot1.CustomGetSkinCfg(slot0, slot1, slot2, slot3)
	if slot0.reserveHeroInfoList[slot1] and slot0.reserveHeroInfoList[slot1].type == 2 then
		if slot0.reserveHeroInfoList[slot1].info.assist_hero_skin == 0 then
			slot4 = slot0.reserveHeroInfoList[slot1].info.assist_hero_id
		end

		return SkinCfg[slot4]
	end

	return HeroTools.HeroUsingSkinInfo(slot0.reserveHeroInfoList[slot1].heroId)
end

function slot1.CustomGetHeroPower(slot0, slot1, slot2, slot3)
	if slot0.reserveHeroInfoList[slot1] and slot0.reserveHeroInfoList[slot1].type == 2 then
		return slot0.reserveHeroInfoList[slot1].info.fight_capacity
	end

	return getHeroPower(slot0.reserveHeroInfoList[slot1].heroId, false)
end

function slot1.GetHeroTeamInfoRoute(slot0)
	return "/guildBossTeamInfo"
end

function slot1.GetCustomeTeamInfoParams(slot0, slot1)
	return {
		heroList = slot0.reserveHeroInfoList
	}
end

function slot1.GetCustomeReserveProposalParams(slot0)
	slot1 = slot0:GetHeroIDList()
	slot2 = 1

	for slot6, slot7 in ipairs(slot0.reserveHeroInfoList) do
		if slot7.type == 1 then
			slot1[slot2] = slot1[slot6]

			if slot2 ~= slot6 then
				slot1[slot6] = 0
			end

			slot2 = slot2 + 1
		elseif slot7.type == 2 then
			slot1[slot6] = 0
		end
	end

	return {
		heroList = slot1
	}
end

function slot1.GetStageData(slot0)
	slot1 = BattleStageFactory.Produce(slot0.stageType, slot0.stageID, 1, slot0.reserveParams)
	slot2 = {}
	slot3 = {}
	slot0.assistList = {}
	slot0.assistOwnerList = {}

	for slot7, slot8 in ipairs(slot0.reserveHeroInfoList) do
		if slot8.type == 2 then
			table.insert(slot2, slot8.info.assist_hero_id)
			table.insert(slot3, slot8.info.member_id)
			table.insert(slot0.assistList, slot8.info.assist_hero_id)
			table.insert(slot0.assistOwnerList, slot8.info.member_id)
		else
			table.insert(slot2, slot8.heroId)
			table.insert(slot3, "0")
		end
	end

	slot1:SetReserveParams(slot0.reserveParams)
	slot1:SetGuildBossTeam(slot2, slot3)
	slot1:SetMultiple(slot0.multiple)
	slot1:SetDest(slot0.dest)
	slot1:InitChipData()

	return slot1
end

function slot1.LaunchBattle(slot0, slot1)
	slot2 = 0

	if #slot0.assistList > 0 then
		for slot6, slot7 in ipairs(slot0.assistList) do
			ForeignInfoAction:TryToCheckForeignHeroInfo(slot0.assistOwnerList[slot6], slot7, 2, function ()
				uv0 = uv0 + 1

				if uv0 >= #uv1.assistList then
					slot0 = {}

					for slot4, slot5 in ipairs(uv1.assistList) do
						slot7 = {}

						if ForeignInfoData:GetHeroData(slot5).using_hero_chip then
							for slot11, slot12 in ipairs(slot6.using_hero_chip) do
								if slot12 > 0 then
									table.insert(slot7, slot12)
								end
							end
						end

						slot0[slot5] = slot7
					end

					uv2:SetChipDic(slot0)
					BattleController.GetInstance():LaunchBattle(uv2)
				end
			end)
		end
	else
		BattleController.GetInstance():LaunchBattle(slot1)
	end
end

return slot1
