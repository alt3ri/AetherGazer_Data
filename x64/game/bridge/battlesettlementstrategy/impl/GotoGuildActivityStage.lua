slot0 = class("GotoGuildActivityStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot4 = slot1.stageData:GetType()

	if slot1.isHalfWay_ then
		slot0:GotoBattleFaild(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult)

		return
	end

	if slot4 == BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY then
		slot0:GotoGuildActivity(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult)
	elseif slot4 == BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP then
		slot0:GotoGuildActivitySP(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult)
	end
end

function slot0.GotoGuildActivity(slot0, slot1, slot2, slot3, slot4)
	if ActivityClubCfg[slot2:GetNodeId()].type == 1 then
		if isSuccess(slot1) then
			function BattleCallLuaCallBack()
				manager.story:RemovePlayer()
				gameContext:Go("/guildActivityNodeResult", {
					isSuccess = true,
					multiple = 1,
					stageData = uv0,
					battleResult = uv1,
					nodeId = uv0:GetNodeId()
				})
				EndBattleLogic(uv2)
			end
		else
			slot0:GotoBattleFaild(slot1, slot2, slot3, slot4)
		end
	elseif slot5.type == 2 then
		if not GuildActivityData:GetSelfNodeData(slot2:GetNodeId()) then
			slot0:GotoBattleFaild(slot1, slot2, slot3, slot4)
		else
			function BattleCallLuaCallBack()
				manager.story:RemovePlayer()
				gameContext:Go("/guildActivityNodeResult", {
					multiple = 1,
					stageData = uv0,
					battleResult = uv1,
					isSuccess = isSuccess(uv2),
					nodeId = uv0:GetNodeId()
				})
				EndBattleLogic(uv2)
			end
		end
	elseif slot5.type == 3 then
		function BattleCallLuaCallBack()
			manager.story:RemovePlayer()

			slot0, slot1 = GetResultReward()
			slot4, slot5, slot6 = BattleTools.GetBattleStatisticsData()
			slot7 = slot5.damage
			slot8 = GameSetting.activity_club_point_cal.value
			slot9 = slot8[1]
			slot12 = uv0.boss_stage_hp
			slot13 = 0

			if isSuccess(uv1) then
				slot13 = math.max(slot8[2] - math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime) * slot8[3], 0)
			end

			slot14 = GuildActivityData:GetUnLockAffixList()
			slot16 = 0

			for slot20, slot21 in pairs(GuildActivityData:GetTempEffectiveAffixList()) do
				for slot25, slot26 in ipairs(TalentTreeCfg[slot20].formula_condition) do
					if slot26[1] == 1 then
						slot16 = slot16 + slot14[slot20].level * slot26[2] * slot21
					end
				end
			end

			slot18 = math.floor(math.min(math.floor(tonumber(tostring(slot7) * 100) / (100 - slot16)) / slot12, 1) * slot9 + slot13)
			slot19 = "choose"

			if isSuccess(uv1) then
				slot19 = "score"
			elseif ActivityClubCfg.all[#ActivityClubCfg.all] == uv2:GetNodeId() and GuildActivityData:GetNodeData(uv2:GetNodeId()) and slot20.health <= 0 then
				slot19 = "score"
			end

			gameContext:Go("/battleScorResult", {
				resultType = slot19,
				okHandler = function ()
					GuildActivityAction.SaveEliteCombatResult(1)
				end,
				giveUpHandler = function ()
					GuildActivityAction.SaveEliteCombatResult(0)
				end,
				stageData = uv2,
				rewardList = slot1,
				score = slot18,
				battleResult = uv3,
				isSuccess = isSuccess(uv1),
				nodeId = uv2:GetNodeId()
			})
			EndBattleLogic(uv1)
		end
	end
end

function slot0.GotoGuildActivitySP(slot0, slot1, slot2, slot3, slot4)
	GuildActivitySPData:SetCurrentGrid(slot2:GetNodeId())

	if ActivityClubSPCfg[slot2:GetNodeId()].type == 1 then
		if isSuccess(slot1) then
			function BattleCallLuaCallBack()
				manager.story:RemovePlayer()

				slot0, slot1 = GetResultReward()

				gameContext:Go("/battleMultipleResult", {
					multiple = 1,
					notOnceMore = true,
					stageData = uv0,
					rewardList = slot1,
					battleResult = uv1
				})
				EndBattleLogic(uv2)
			end
		else
			slot0:GotoBattleFaild(slot1, slot2, slot3, slot4)
		end
	elseif slot5.type == 2 then
		if not GuildActivitySPData:GetSelfNodeData(slot2:GetNodeId()) then
			slot0:GotoBattleFaild(slot1, slot2, slot3, slot4)
		else
			function BattleCallLuaCallBack()
				manager.story:RemovePlayer()

				slot0, slot1 = GetResultReward()

				if isSuccess(uv0) then
					gameContext:Go("/battleMultipleResult", {
						multiple = 1,
						notOnceMore = true,
						stageData = uv1,
						rewardList = slot1,
						battleResult = uv2
					})
				else
					gameContext:Go("/guildActivitySPNodeResult", {
						multiple = 1,
						stageData = uv1,
						battleResult = uv2,
						isSuccess = isSuccess(uv0),
						nodeId = uv1:GetNodeId()
					})
				end

				EndBattleLogic(uv0)
			end
		end
	elseif slot5.type == 3 or slot5.type == 4 then
		function BattleCallLuaCallBack()
			manager.story:RemovePlayer()

			slot0, slot1 = GetResultReward()
			slot3 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
			slot4, slot5, slot6 = BattleTools.GetBattleStatisticsData()
			slot7 = slot5.damage
			slot9 = nil

			for slot13, slot14 in ipairs(ActivityClubSpPointCfg.all) do
				if ActivityClubSpPointCfg[slot14].activity == GuildActivitySPData:GetCurRunActivityID() then
					slot9 = ActivityClubSpPointCfg[slot14].boss_point_cal

					break
				end
			end

			if not slot9 then
				return
			end

			slot10 = slot9[1]
			slot13 = uv0.boss_stage_hp
			slot14 = 0

			if isSuccess(uv1) then
				slot14 = math.max(slot9[2] - slot3 * slot9[3], 0)
			end

			slot15 = GuildActivitySPData:GetUnLockAffixList()
			slot17 = 0

			for slot21, slot22 in pairs(GuildActivitySPData:GetTempEffectiveAffixList()) do
				for slot26, slot27 in ipairs(TalentTreeCfg[slot21].formula_condition) do
					if slot27[1] == 1 then
						slot17 = slot17 + slot15[slot21].level * slot27[2] * slot22
					end
				end
			end

			slot19 = math.floor(math.min(math.floor(tonumber(tostring(slot7) * 100) / (100 - slot17)) / slot13, 1) * slot10 + slot14)
			slot20 = "choose"

			if isSuccess(uv1) then
				slot20 = "score"
			elseif GuildActivitySPData:GetMaxNodeId() == uv2:GetNodeId() and GuildActivitySPData:GetNodeData(uv2:GetNodeId()) and slot21.health <= 0 then
				slot20 = "score"
			end

			slot22 = -1
			slot23 = nil

			if #ActivityClubSPCfg[uv2:GetNodeId()].boss_reward_exchange > 0 then
				slot24 = 1

				for slot28, slot29 in ipairs(slot21.boss_reward_exchange[1]) do
					slot31 = slot29[2]

					if slot19 < slot29[1] then
						slot22 = slot21.boss_reward_exchange[1][slot24 - 1][2][2]
						slot23 = slot21.boss_reward_exchange[1][slot24 - 1][2][1]

						break
					end

					slot24 = slot24 + 1
				end

				if slot22 < 0 then
					slot22 = slot21.boss_reward_exchange[1][#slot21.boss_reward_exchange[1]][2][2]
					slot23 = slot21.boss_reward_exchange[1][#slot21.boss_reward_exchange[1]][2][1]
				end
			end

			gameContext:Go("/guildActivitySPBoosNodeResultView", {
				noOnceMore = true,
				resultType = slot20,
				okHandler = function (slot0)
					if not slot0 then
						GuildActivitySPAction.SaveEliteCombatResult(1)
					end
				end,
				giveUpHandler = function ()
					GuildActivitySPAction.SaveEliteCombatResult(0)
				end,
				stageData = uv2,
				rewardList = slot1,
				score = slot19,
				battleResult = uv3,
				isSuccess = isSuccess(uv1),
				nodeId = uv2:GetNodeId(),
				awardNum = slot22,
				currencyID = slot23,
				condition = function ()
					slot0 = ActivityClubSPCfg[uv0:GetNodeId()].vitality_cost
					slot4 = uv0
					slot6 = slot4

					for slot5, slot6 in pairs(slot4.GetHeroTeam(slot6)) do
						if slot6 and slot6 > 0 then
							slot1 = 0 + 1
						end
					end

					slot5 = uv0
					slot7 = slot5

					for slot6, slot7 in pairs(slot5.GetHeroTeam(slot7)) do
						if slot7 and slot7 > 0 then
							slot8 = GuildActivitySPData:GetFightHeroById(slot7)

							if GuildActivitySPData:GetHeroFatigue(slot7) < math.floor(slot0 / slot1) then
								return false, "ACTIVITY_CLUB_HERO_VITALITY_NOT_ENOUGH_TIP"
							end
						end
					end

					return true
				end
			})
			EndBattleLogic(uv1)
		end
	end
end

return slot0
