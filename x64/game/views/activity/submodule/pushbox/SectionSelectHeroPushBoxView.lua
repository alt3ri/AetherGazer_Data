slot1 = class("SectionSelectHeroPushBoxView", import("game.views.sectionSelectHero.SectionSelectHeroBaseView"))

function slot1.StartBattle(slot0)
	BattleController.GetInstance():LaunchBattle(BattleActivityPushBoxTemplate.New(slot0.stageID_, slot0.params_.activityID, slot0.params_.dest_id))
end

return slot1
