slot0 = class("BattleSettlementChallengeModule", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot0:InstView(slot1)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.InstView(slot0, slot1)
	return Object.Instantiate(Asset.Load("Widget/System/BattleResult/Common/Module/BattleChallengeContent"), slot1)
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.scoreTween = nil
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.RenderView(slot0, slot1)
	slot0.battleCtx = slot1
	slot2 = slot1.stageType
	slot3 = slot1.stageData
	slot4 = slot1.score

	if slot1.scoreTitle then
		slot0.scoreTitleTxt_.text = slot1.scoreTitle
	end

	if slot2 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE then
		slot0:RefreshBossAdvanceScore()

		return
	end

	if slot2 == BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA then
		slot0.targetScore = ActivityAttributeArenaData:GetArenaScore(slot3:GetActivityID(), slot3:GetDest())

		slot0:StartTween()

		return
	end

	if slot4 then
		if type(slot4) == "number" then
			slot0.targetScore = slot4

			slot0:StartTween()
		else
			slot0.scoreText_.text = slot4
		end
	elseif ActivityTools.GetActivityTheme(slot3:GetActivityID()) == ActivityConst.THEME.SUMMER or slot5 == ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION then
		slot7 = 0
		slot9 = GameSetting.limit_calculation_time_score_args.value
		slot10 = slot9[1]
		slot11 = slot9[2]
		slot13 = slot9[4]
		slot7 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime) < slot9[3] and slot10 * slot12 + slot11 or slot8 < slot13 and slot10 * slot8 + slot11 or slot10 * slot13 + slot11
		slot14 = 0
		slot15 = 0
		slot16, slot17, slot18 = BattleTools.GetBattleStatisticsData()
		slot19 = GameSetting.limit_calculation_injured_score_args.value

		if slot19[#slot19][1] <= tonumber(tostring(slot16[1].hurt)) then
			slot15 = slot19[#slot19][1]
		end

		for slot23, slot24 in ipairs(slot19) do
			if slot15 <= slot24[1] then
				slot14 = slot24[2]

				break
			end
		end

		slot0.targetScore = math.floor((slot7 + slot14) * ActivityLimitCalculationCfg[slot3:GetDest()].reward_point / 100)

		slot0:StartTween()
	elseif slot6 == ActivityConst.THEME.FACTORY or ActivityConst.THEME.TYR then
		slot0.scoreText_.text = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime) .. "s"
	end
end

function slot0.RefreshBossAdvanceScore(slot0)
	slot2 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
	slot4 = BattleBossChallengeAdvanceData:GetBossList()[slot0.battleCtx.stageData:GetBossIndex()]
	slot5 = slot4.multipleIndex
	slot12 = BossConst.TYPE_STAGE

	for slot12, slot13 in pairs(slot4.condition[slot12]) do
		if BattleInstance.CaculateStar(slot1, StageChallengeConditionPoolCfg[slot13].condition, LuaExchangeHelper.GetBattleStatisticsData().dataForLua).isComplete then
			slot7 = BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].difficult_point[slot4.multipleIndex] + StageChallengeConditionPoolCfg[slot13].point
		end
	end

	slot12 = BossConst.TYPE_AFFIX

	for slot12, slot13 in pairs(slot4.condition[slot12]) do
		slot7 = slot7 + ActivityAffixPoolCfg[slot13].point
	end

	slot0.targetScore = slot7

	slot0:StartTween()
end

function slot0.OnTop(slot0)
	slot0:StartTween()
end

function slot0.StartTween(slot0)
	if not slot0.targetScore then
		return
	end

	if not isNil(slot0.scoreTween) then
		LeanTween.cancel(slot0.scoreText_.gameObject)

		slot0.scoreTween = nil
	end

	slot0.scoreText_.text = 0
	slot0.scoreTween = LeanTween.value(slot0.scoreText_.gameObject, 0, slot0.targetScore, 0.6):setEase(LeanTweenType.easeOutExpo):setTime(1):setOnUpdate(LuaHelper.FloatAction(function (slot0)
		uv0.scoreText_.text = math.floor(slot0)
	end)):setOnComplete(System.Action(function ()
		uv0.scoreText_.text = math.floor(uv0.targetScore)
	end))
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if not isNil(slot0.scoreTween) then
		LeanTween.cancel(slot0.scoreText_.gameObject)

		slot0.scoreTween = nil
	end
end

return slot0
