local var_0_0 = import("game.views.heroTeamInfo.HeroTeamInfoBaseView")
local var_0_1 = class("GuildBossSetAssistantView", var_0_0)

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)
	arg_1_0.filterView_:SetExtraSorter(function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = GuildData:GetCurrentBossAssistantHeroId()
		local var_2_1 = arg_2_0.id == var_2_0 and 1 or 0
		local var_2_2 = arg_2_1.id == var_2_0 and 1 or 0

		if var_2_1 ~= var_2_2 then
			return true, var_2_2 < var_2_1
		end

		return false, false
	end)
end

function var_0_1.HeadRenderer(arg_3_0, arg_3_1, arg_3_2)
	var_0_1.super.HeadRenderer(arg_3_0, arg_3_1, arg_3_2)

	local var_3_0 = arg_3_0.heroDataList_[arg_3_1].id

	if GuildData:GetCurrentBossAssistantHeroId() == var_3_0 then
		arg_3_2:SetTeamMarkBg("purple")
		arg_3_2:SetTeamMark(true, GetTips("CURRENT_ASSISTANT"))
	else
		arg_3_2:SetTeamMark(false)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_2.teamMarkTransform_)
end

function var_0_1.UpdateHeroView(arg_4_0)
	local var_4_0 = HeroTools.HeroUsingSkinInfo(arg_4_0.selectID_).id
	local var_4_1 = arg_4_0.selectID_

	arg_4_0.fightPowerText_.text = getHeroPower(var_4_1, false)

	arg_4_0.heroAvatarView_:SetSkinId(var_4_0)

	local var_4_2 = HeroCfg[var_4_1]

	arg_4_0.nameText_.text = GetI18NText(var_4_2.name)
	arg_4_0.subNameText_.text = GetI18NText(var_4_2.suffix)
end

function var_0_1.OnEnter(arg_5_0)
	var_0_1.super.OnEnter(arg_5_0)
	arg_5_0:AddEventListeners()
end

function var_0_1.OnExit(arg_6_0)
	var_0_1.super.OnExit(arg_6_0)
	arg_6_0:RemoveAllEventListener()
end

function var_0_1.AddEventListeners(arg_7_0)
	arg_7_0:RegistEventListener(GUILD_BOSS_ASSISTANT_HERO_CHANGE, function(arg_8_0)
		arg_7_0.heroHeadList_:Refresh()
		arg_7_0:RefreshJoinBtn()
	end)
	arg_7_0:RegistEventListener(GUILD_EXIT, function()
		arg_7_0:Go("/home")
	end)
end

function var_0_1.GetHeroTeam(arg_10_0)
	return
end

function var_0_1.OnJoinClick(arg_11_0)
	local var_11_0 = arg_11_0.selectID_

	if GuildData:GetCurrentBossAssistantHeroId() == var_11_0 then
		return
	end

	local var_11_1 = GuildData:GetGuildInfo().id

	GuildAction.SetAssistHero(var_11_1, var_11_0)
end

function var_0_1.GetTextAndImage(arg_12_0)
	if arg_12_0.selectID_ == GuildData:GetCurrentBossAssistantHeroId() then
		return string.format("<color=#222222>%s</color>", GetTips("CURRENT_ASSISTANT")), "0", true
	end

	return string.format("<color=#222222>%s</color>", GetTips("CHANGE_ASSISTANT_ROLE")), "0", true
end

function var_0_1.IsInTeam(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_1 == GuildData:GetCurrentBossAssistantHeroId(), false, -1
end

function var_0_1.GetDefaultHeroData(arg_14_0)
	return GuildData:GetCurrentBossAssistantHeroId() > 0 and GuildData:GetCurrentBossAssistantHeroId() or arg_14_0.heroDataList_[1].id, 0
end

function var_0_1.ChangeTeam(arg_15_0, arg_15_1, arg_15_2)
	CustomLog.Log(debug.traceback(string.format("heroes = %s", tostring(arg_15_1))))
end

return var_0_1
