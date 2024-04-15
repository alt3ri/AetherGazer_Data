local var_0_0 = class("ActivityRaceRankView", ReduxView)
local var_0_1 = {
	ALL = 1,
	GUILD = 2
}

function var_0_0.UIName(arg_1_0)
	return ActivityRaceRankTools.GetRankUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.curRankType_ = var_0_1.ALL

	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, ActivityRaceRankTools.GetRankItemClass(arg_4_0.params_.activityID))
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(arg_5_0.rankList_[arg_5_1])
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddToggleListener(arg_6_0.allToggle_, function(arg_7_0)
		if arg_7_0 then
			arg_6_0.curRankType_ = var_0_1.ALL

			arg_6_0:RefreshUI()
		end
	end)
	arg_6_0:AddToggleListener(arg_6_0.guildToggle_, function(arg_8_0)
		if arg_8_0 then
			arg_6_0.curRankType_ = var_0_1.GUILD

			arg_6_0:RefreshUI()
		end
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.activityID_ = arg_9_0.params_.activityID

	RankAction.QueryActivityRank(arg_9_0.activityID_)

	if GuildData:GetGuildInfo().id == nil then
		SetActive(arg_9_0.guildToggleGo_, false)

		arg_9_0.curRankType_ = var_0_1.ALL
	else
		SetActive(arg_9_0.guildToggleGo_, true)
		RankAction.QueryGuildActivityRank(arg_9_0.activityID_)
	end

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0:RefreshSelfRank()
	arg_10_0:RefreshList()
end

function var_0_0.RefreshSelfRank(arg_11_0)
	local var_11_0 = PlayerData:GetPlayerInfo()

	arg_11_0.icon_.sprite = ItemTools.getItemSprite(var_11_0 and var_11_0.portrait)
	arg_11_0.frame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. var_11_0.icon_frame)
	arg_11_0.name_.text = GetI18NText(var_11_0.nick)

	if arg_11_0.curRankType_ == var_0_1.ALL then
		local var_11_1 = RankData:GetActivityRank(arg_11_0.activityID_)

		if var_11_1 then
			local var_11_2, var_11_3 = var_11_1:GetCurRankDes()

			arg_11_0.rank_.text = var_11_2
			arg_11_0.score_.text = var_11_3
		else
			arg_11_0.rank_.text = ""
			arg_11_0.score_.text = ""
		end
	else
		local var_11_4 = RankData:GetGuildActivityRank(arg_11_0.activityID_)

		if var_11_4 then
			local var_11_5, var_11_6 = var_11_4:GetCurRankDes()

			arg_11_0.rank_.text = var_11_5
			arg_11_0.score_.text = var_11_6
		else
			arg_11_0.rank_.text = ""
			arg_11_0.score_.text = ""
		end
	end
end

function var_0_0.RefreshNone(arg_12_0)
	arg_12_0.rank_.text = GetTips("MATRIX_RANK_NO_RANK")
	arg_12_0.score_.text = GetTips("MATRIX_RANK_NO_INFO")
end

function var_0_0.RefreshList(arg_13_0)
	if arg_13_0.curRankType_ == var_0_1.ALL then
		local var_13_0 = RankData:GetActivityRank(arg_13_0.activityID_)

		arg_13_0.rankList_ = var_13_0 and var_13_0.rankList or {}
	else
		local var_13_1 = RankData:GetGuildActivityRank(arg_13_0.activityID_)

		arg_13_0.rankList_ = var_13_1 and var_13_1.rankList or {}
	end

	arg_13_0.scrollHelper_:StartScroll(#arg_13_0.rankList_)
end

function var_0_0.OnTop(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()

	arg_15_0.allToggle_.isOn = true
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0:RemoveAllListeners()
	arg_16_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_16_0)
end

function var_0_0.OnRankUpdate(arg_17_0)
	arg_17_0:RefreshUI()
end

return var_0_0
