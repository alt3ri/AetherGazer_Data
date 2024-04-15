slot0 = class("GotoGuildBossStage", BattleSettlementStrategyBase)
slot0.StageNum = {
	[BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE] = 1,
	[BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE] = 2
}

function slot0.OnGotoSettlement(slot0, slot1)
	slot0:GotoGuildBossStage(uv0.StageNum[slot1.stageData:GetType()] or 1, slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult)
end

function slot0.GotoGuildBossStage(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6, slot7 = GetResultReward()

	if slot2 + 1 ~= BattleConst.BATTLE_RESULT.QUIT then
		function BattleCallLuaCallBack()
			slot0 = 0

			if not GuildData:GetBossData().initedFromServer then
				gameContext:Go("/battleScorResult", {
					stageData = uv0,
					rewardList = uv1,
					score = 0,
					battleResult = uv2
				})
				EndBattleLogic(uv3)
				ShowTips("CLUB_KICK")

				return
			end

			slot3, slot4, slot5 = BattleTools.GetBattleStatisticsData()
			slot6 = slot4.damage
			slot7 = ClubBossIdCfg[GuildData:GetBossData().challengeInfo.boss_id].boss_hp[GuildData:GetBossDifficulty()]

			if uv4 == 1 then
				slot8 = GameSetting.club_boss_point_cal_pre_stage.value

				if isSuccess(uv3) then
					GuildData:OnPreposeSuccess()
					gameContext:Go("/battleScorResult", {
						stageData = uv0,
						rewardList = uv1,
						score = math.floor(slot8[1] + (1 - math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime) / slot8[2]) * slot8[3]),
						battleResult = uv2,
						condition = function ()
							if GuildData:GetBossLastTime() <= 0 then
								return false, GetTips("ERROR_BATTLE_DAILY_BATTLE_TIMES_LIMIT")
							end

							slot0, slot1 = GuildData:GetLastTime()

							if slot0 ~= "prepose" then
								return false, GetTips("CLUB_BOSS_PREPOSE_FINISH_TIP")
							end

							return true, ""
						end
					})
					EndBattleLogic(uv3)
				else
					manager.story:CheckBattleStory(uv0:GetStageId(), manager.story.LOSE, function ()
						JumpTools.OpenPageByJump("/battlefailed", {
							stageData = uv0,
							starMissionData = uv1,
							battleResult = uv2,
							isHalfWay_ = uv3.tempData.isHalfWay_
						})
						manager.story:RemovePlayer()
						EndBattleLogic(uv4)
					end)
				end
			else
				CustomLog.Log(debug.traceback(string.format("公会BOSS总伤害：%s", tostring(slot6))))

				slot8 = GameSetting.club_boss_point_cal.value
				slot9 = 0

				if isSuccess(uv3) then
					slot9 = (1 - slot2 / slot8[2]) * slot8[3]
				end

				slot0 = math.floor(math.min(tonumber(tostring(slot6)) / slot7, 1) * slot8[1] + slot9)

				GuildData:ResetBossPersonalScore(slot0)
				gameContext:Go("/battleScorResult", {
					stageData = uv0,
					rewardList = uv1,
					score = slot0,
					battleResult = uv2
				})
				EndBattleLogic(uv3)
			end
		end
	else
		slot0:GotoBattleFaild(slot2, slot3, slot4, slot5)
	end
end

return slot0
