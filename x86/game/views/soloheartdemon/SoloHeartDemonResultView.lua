BattleScoreResultView = import("game.views.battleResult.score.BattleScoreResultView")
slot0 = class("SoloHeartDemonResultView", BattleScoreResultView)
slot1 = {
	"SOLO_HEART_DEMON_EASY",
	"SOLO_HEART_DEMON_HARD",
	"SOLO_HEART_DEMON_NIGHTMARE"
}

function slot0.UIName(slot0)
	return "UI/BattleResult/SoloHeartMultipletUI"
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.btnBack_, nil, function ()
		uv0:CloseFunc()
	end)
end

function slot0.RefreshUI(slot0)
	slot1 = BattleTools.GetBattleStatisticsData()
	slot0.missTimes = 0

	if LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas:TryGetValue(8, nil) then
		slot0.missTimes = slot3[8] or 0
	end

	slot0.hitTime = 0

	if slot3:TryGetValue(61, slot4) then
		slot0.hitTime = slot3[61] or 0
	end

	slot0.battleTime = slot2.battleTime
	slot0.hitDamage = tonumber(tostring(slot1[1].hurt))
	slot0.battleTime2Text_.text = slot0:GetBattleTime()
	slot6 = SoloHeartDemonData:GetDataByPara("stageToDifficulty")[slot0.stageData:GetDest()]
	slot0.hitDamageTxt_.text = tostring(slot0.hitTime)
	slot0.difficultytext.text = GetTips(uv0[slot6])

	SetActive(slot0.hitNewGo_, slot0.hitTime < SoloHeartDemonData:GetDataByPara("difficultyData")[slot6].hitTime)
	SetActive(slot0.timeNewGo_, slot0.battleTime < slot7.shortestBattleTime)

	slot0.score = SoloHeartDemonData:GetDataByPara("battleScore") or 0
	slot0.scoreTxt_.text = slot0.score

	SetActive(slot0.scoreNewGo_, slot7.maxScore < slot0.score)
end

function slot0.OnSoloDemonHeartScoreUpdate(slot0)
	slot0.scoreTxt_.text = SoloHeartDemonData:GetDataByPara("battleScore")

	SetActive(slot0.scoreNewGo_, SoloHeartDemonData:GetDataByPara("difficultyData")[stageToDifficulty[slot0.stageData:GetDest()]].maxScore < SoloHeartDemonData:GetDataByPara("battleScore"))
end

function slot0.OnExit(slot0)
	SoloHeartDemonData:UpdateBattleFinishData(2, slot0.battleTime, slot0.score, slot0.hitDamage, slot0.missTimes, slot0.hitTime, slot0.stageData:GetDest())
end

return slot0
