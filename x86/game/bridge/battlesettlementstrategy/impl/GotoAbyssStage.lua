slot0 = class("GotoAbyssStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot3 = slot1.stageData
	slot4 = slot1.starMissionData
	slot5 = slot1.battleResult
	slot6 = 1

	if isSuccess(slot1.num) then
		if not slot3:IsBoss() then
			AbyssData:CompleteNormalStage(slot3:GetLayer(), slot3:GetStageId())
		end

		slot0:GotoAbyssSuccess(slot1.isHalfWay_, AbyssData:GetStageScore(slot3:GetLayer(), slot3:GetStageIndex()), slot2, slot3, slot4, slot5)
	elseif slot3:IsBoss() then
		slot9 = 0
		slot10 = AbyssData:GetCurrentBossPhase()

		if LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas:TryGetValue(37, nil) then
			slot9 = slot7[37] or 0
		end

		if slot7:TryGetValue(36, slot8) then
			slot10 = slot7[36] or 0
		end

		slot11 = AbyssData:GetBossTotalHp(slot3:GetStageId())

		if slot5.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
			slot0:GotoAbyssBossFailed(slot11, slot11, slot2, slot3, slot5, slot1.isHalfWay_)
		else
			slot15 = slot9 / (AbyssData:GetPhaseBossHp(slot3:GetStageId(), slot10) * AbyssData:GetStageData(slot3:GetLayer(), slot3:GetStageIndex()).boss_hp_rate / 1000)

			if not slot7:TryGetValue(37, slot8) then
				slot15 = 1
			end

			slot0:GotoAbyssBossFailed(AbyssData:ConvertPhaseBossHpToTotal(slot3:GetStageId(), slot10, slot13.boss_hp_rate * slot15), slot11, slot2, slot3, slot5, slot1.isHalfWay_)
		end
	else
		function BattleCallLuaCallBack()
			manager.story:CheckBattleStory(uv0:GetStageId(), manager.story.LOSE, function ()
				JumpTools.OpenPageByJump("/battlefailedWithButton", {
					stageData = uv0,
					battleResult = uv1
				})
				manager.story:RemovePlayer()
				EndBattleLogic(uv2)
			end)
		end
	end
end

function slot0.GotoAbyssBossFailed(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if slot6 == true then
		slot3 = 3
	end

	function BattleCallLuaCallBack()
		manager.audio:PlayBGM("ui_battle", "ui_battle_lose", "ui_battle.awb")
		gameContext:Go("/abyssBattleResult", {
			resultType = "choose",
			scoreType = "hp",
			stageData = uv0,
			hp = uv1,
			totalHp = uv2,
			battleResult = uv3,
			title = GetTips("ABYSS_BATTLE_FAIL_TIP"),
			okHandler = function ()
				AbyssAction.ClearTeamCache(uv0:GetStageId())
				AbyssAction.SaveProgress(uv0:GetStageId(), true)
				AbyssTools.SetLayerBossTeamCacheFlag(uv0:GetLayer(), uv0:GetStageIndex(), false)
			end,
			giveUpHandler = function ()
				AbyssAction.SaveProgress(uv0:GetStageId(), false)
			end
		})
		EndBattleLogic(uv4)
	end
end

function slot0.GotoAbyssSuccess(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if slot1 == true then
		slot3 = 3
	end

	slot8, slot9 = GetResultReward()

	if isSuccess(slot3) then
		function BattleCallLuaCallBack()
			gameContext:Go("/abyssBattleResult", {
				stageData = uv0,
				rewardList = uv1,
				score = uv2,
				battleResult = uv3
			})
			EndBattleLogic(uv4)
		end
	end
end

return slot0
