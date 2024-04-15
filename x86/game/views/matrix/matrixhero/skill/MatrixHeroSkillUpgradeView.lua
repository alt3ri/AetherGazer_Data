local var_0_0 = import("game.views.newHero.skill.HeroSkillUpgradeView")
local var_0_1 = class("MatrixHeroSkillUpgradeView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	var_0_1.super.InitUI(arg_1_0)
	SetActive(arg_1_0.costPanelGo_, false)
end

function var_0_1.OnEnter(arg_2_0)
	arg_2_0.params_.extra = {}

	var_0_1.super.OnEnter(arg_2_0)
end

function var_0_1.GetRealSkillId(arg_3_0)
	return SkillTools.GetRealSkillIdByWeaponServantId(arg_3_0.params_.heroId, arg_3_0.params_.servantId, arg_3_0.params_.skillId)
end

function var_0_1.GetSkillLv(arg_4_0)
	return arg_4_0.params_.lv
end

function var_0_1.GetHeroData(arg_5_0)
	local var_5_0, var_5_1 = GetVirtualData(arg_5_0.params_.standardId)

	return var_5_0
end

return var_0_1
