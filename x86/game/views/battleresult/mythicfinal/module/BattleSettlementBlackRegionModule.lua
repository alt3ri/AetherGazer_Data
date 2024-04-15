slot0 = class("BattleSettlementBlackRegionModule", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot0:InstView(slot1)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.InstView(slot0, slot1)
	return Object.Instantiate(Asset.Load("Widget/System/BattleResult/Common/Module/BattleBlackRegionContent"), slot1)
end

function slot0.BuildContext(slot0)
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:BuildContext()
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.RenderView(slot0, slot1)
	slot0.stageData = slot1.stageData
	slot2 = nil
	slot0.teamindextext_.text = string.format((slot0.stageData:GetDest() == 0 and 1 or slot0.stageData:GetDest()) .. "/" .. #MythicData:GetCurLevelIdList())

	slot0:RenderBattleTime()
	slot0:RenderPoint()
end

function slot0.RenderBattleTime(slot0)
	slot1 = GetTips("DAY")
	slot2 = GetTips("HOUR")
	slot5 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime
	slot6 = math.floor(slot5 / 86400)
	slot7 = math.fmod(math.floor(slot5 / 3600), 24)
	slot0.sec1Txt_.text = GetTips("SECOND")
	slot0.wasteSecondTxt_.text = math.floor(math.fmod(slot5, 60))

	if math.floor(math.fmod(math.floor(slot5 / 60), 60)) > 0 then
		slot0.min1Txt_.text = GetTips("TIP_MINUTE")
		slot0.wasteMinuteTxt_.text = slot8
	else
		slot0.min1Txt_.text = ""
		slot0.wasteMinuteTxt_.text = ""
	end

	slot10 = MythicData:GetBattlingTime()
	slot6 = math.floor(slot10 / 86400)
	slot7 = math.fmod(math.floor(slot10 / 3600), 24)
	slot0.sec2Txt_.text = slot4
	slot0.reminSecondTxt_.text = math.floor(math.fmod(slot10, 60))

	if math.floor(math.fmod(math.floor(slot10 / 60), 60)) > 0 then
		slot0.min2Txt_.text = slot3
		slot0.reminMinuteTxt_.text = slot8
	else
		slot0.min2Txt_.text = ""
		slot0.reminMinuteTxt_.text = ""
	end
end

function slot0.RenderPoint(slot0)
	if #MythicData:GetCurLevelIdList() > 1 and slot0.stageData:GetDest() < #MythicData:GetCurLevelIdList() then
		SetActive(slot0.scoreObj_, false)
	else
		if not MythicData:GetIsNew() then
			RankAction.QueryOwnCommonRank(RankConst.RANK_ID.MATRIX)
			MythicAction.UpdateMythicFinalRedPoint()
		end

		SetActive(slot0.scoreObj_, true)

		slot0.scoreTxt_.text = MythicData:GetCurPoint()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
