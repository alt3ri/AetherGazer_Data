BattleScoreResultView = import("game.views.battleResult.score.BattleScoreResultView")
slot0 = class("CoreVerificationBattleResultView", BattleScoreResultView)

function slot0.UIName(slot0)
	return "Widget/System/BattleResult/BattleCoreVerification/CoreVerificationBattleResult"
end

function slot0.InitUI(slot0)
	slot0.hasSnapshot_ = GetBattleResultSnapShot()

	slot0:BindCfgUI()
end

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.btnBack_, nil, function ()
		uv0:CloseFunc()
	end)
	slot0:AddBtnListener(slot0.statisticsBtn_, nil, function ()
		uv0:GoToBattleStatistics()
	end)
end

function slot0.RefreshUI(slot0)
	slot0.battleTime2Text_.text = slot0:GetBattleTime()
	slot0.titleText_.text = string.format("难度%s", GetTips("NUM_" .. CoreVerificationInfoCfg[slot0.stageData:GetDest()].difficult))
end

function slot0.GoToBattleStatistics(slot0)
	JumpTools.OpenPageByJump("battleStatistics", {
		stageData = slot0.params_.stageData,
		battleTime = slot0:GetBattleTime(),
		hasSnapshot_ = slot0.hasSnapshot_
	})
end

function slot0.OnExit(slot0)
	slot1 = slot0.stageData:GetDest()
	slot2 = {}

	for slot6, slot7 in ipairs(slot0.stageData:GetHeroTeam()) do
		if slot7 ~= 0 then
			table.insert(slot2, slot7)
		end
	end

	CoreVerificationData:BattleStageData(slot1, slot2, LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

return slot0
