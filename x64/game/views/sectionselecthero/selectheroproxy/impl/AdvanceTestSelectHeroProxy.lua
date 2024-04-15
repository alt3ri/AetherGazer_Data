slot1 = class("AdvanceTestSelectHeroProxy", import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy"))

function slot1.InitCustomParams(slot0, slot1)
	slot0.dest = slot1.dest
	slot0.stageDifficult = slot1.stageDifficult
	slot0.heroDataType_ = HeroConst.HERO_DATA_TYPE.ADVANCETEST

	slot0:SetHeroDataType(slot0.heroDataType_)
end

function slot1.GetStageData(slot0)
	return BattleStageFactory.Produce(slot0.stageType, slot0.stageID, {
		dest = slot0.dest,
		activityID = slot0.activityID
	})
end

function slot1.GetHeroTeamInfoRoute(slot0)
	return "/advanceTestTeamInfo"
end

function slot1.GetCustomeTeamInfoParams(slot0, slot1)
	return {
		stageDifficult = slot0.stageDifficult
	}
end

return slot1
