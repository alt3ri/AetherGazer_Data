slot1 = class("PushBoxSelectHeroProxy", import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy"))

function slot1.InitCustomParams(slot0, slot1)
	slot0.destID = slot1.dest_id
end

function slot1.GetStageData(slot0)
	return BattleActivityPushBoxTemplate.New(slot0.stageID, slot0.activityID, slot0.destID)
end

return slot1
