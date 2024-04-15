slot1 = class("SectionSelectHeroAttributeArenaView", import("game.views.sectionSelectHero.SectionSelectHeroBaseView"))

function slot1.UIName(slot0)
	return "UI/ArenaUI/IndiaBattleSelectHeroUI"
end

function slot1.OnEnter(slot0)
	slot0.attribute_arena_id = slot0.params_.attribute_arena_id

	uv0.super.OnEnter(slot0)

	for slot5, slot6 in ipairs(GameDisplayCfg.hero_atack_type_tag.value) do
		if slot6[1] == ActivityAttributeArenaCfg[slot0.attribute_arena_id].attribute then
			slot7 = slot6[2]

			break
		end
	end
end

function slot1.GoHeroInfoUI(slot0, slot1)
	slot0:Go("/heroTeamInfoAttributeArena", {
		isEnter = true,
		selectHeroPos = slot1,
		stageID = slot0.stageID_,
		activityID = slot0.params_.activityID,
		stageType = slot0.stageType_,
		attribute_arena_id = slot0.attribute_arena_id,
		reserveParams = slot0.reserveParams_
	})
end

function slot1.StartBattle(slot0)
	BattleController.GetInstance():LaunchBattle(BattleActivityAttributeArenaTemplate.New(slot0.stageID_, slot0.params_.activityID, slot0.attribute_arena_id, slot0.reserveParams_))
end

return slot1
