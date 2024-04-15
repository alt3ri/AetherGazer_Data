local var_0_0 = import("game.views.sectionSelectHero.SectionSelectHeroBaseView")
local var_0_1 = class("SectionSelectHeroAttributeArenaView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/ArenaUI/IndiaBattleSelectHeroUI"
end

function var_0_1.OnEnter(arg_2_0)
	arg_2_0.attribute_arena_id = arg_2_0.params_.attribute_arena_id

	var_0_1.super.OnEnter(arg_2_0)

	local var_2_0 = ActivityAttributeArenaCfg[arg_2_0.attribute_arena_id]

	for iter_2_0, iter_2_1 in ipairs(GameDisplayCfg.hero_atack_type_tag.value) do
		if iter_2_1[1] == var_2_0.attribute then
			local var_2_1 = iter_2_1[2]

			break
		end
	end
end

function var_0_1.GoHeroInfoUI(arg_3_0, arg_3_1)
	arg_3_0:Go("/heroTeamInfoAttributeArena", {
		isEnter = true,
		selectHeroPos = arg_3_1,
		stageID = arg_3_0.stageID_,
		activityID = arg_3_0.params_.activityID,
		stageType = arg_3_0.stageType_,
		attribute_arena_id = arg_3_0.attribute_arena_id,
		reserveParams = arg_3_0.reserveParams_
	})
end

function var_0_1.StartBattle(arg_4_0)
	local var_4_0 = BattleActivityAttributeArenaTemplate.New(arg_4_0.stageID_, arg_4_0.params_.activityID, arg_4_0.attribute_arena_id, arg_4_0.reserveParams_)

	BattleController.GetInstance():LaunchBattle(var_4_0)
end

return var_0_1
