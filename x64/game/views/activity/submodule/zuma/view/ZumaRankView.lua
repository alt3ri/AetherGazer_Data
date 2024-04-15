local var_0_0 = class("ZumaRankView", ReduxView)
local var_0_1 = {
	ALL = 1,
	GUILD = 2
}

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaRankUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.curRankType_ = var_0_1.ALL

	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, ActivityAttributeArenaRankItem)
	arg_4_0.tabController_ = arg_4_0.toggleConEx:GetController("tab")
	arg_4_0.tabNumController_ = arg_4_0.toggleConEx:GetController("num")
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(arg_5_0.rankList_[arg_5_1])
end

function var_0_0.QueryRankData(arg_6_0)
	RankAction.QueryActivityRank(arg_6_0.activityID_)
	arg_6_0.tabNumController_:SetSelectedState("01")
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.activityID_ = arg_7_0.params_.rank_activity_id

	arg_7_0:QueryRankData()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0:RefreshSelfRank()
	arg_8_0:RefreshList()
end

function var_0_0.RefreshSelfRank(arg_9_0)
	local var_9_0 = PlayerData:GetPlayerInfo()

	arg_9_0.icon_.sprite = ItemTools.getItemSprite(var_9_0 and var_9_0.portrait)
	arg_9_0.frame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. var_9_0.icon_frame)
	arg_9_0.name_.text = var_9_0.nick

	if arg_9_0.curRankType_ == var_0_1.ALL then
		local var_9_1 = RankData:GetActivityRank(arg_9_0.activityID_)

		if var_9_1 then
			local var_9_2, var_9_3 = var_9_1:GetCurRankDes()

			arg_9_0.rank_.text = var_9_2
			arg_9_0.score_.text = var_9_3
		else
			arg_9_0.rank_.text = ""
			arg_9_0.score_.text = ""
		end

		arg_9_0.tabController_:SetSelectedState("all")
	else
		local var_9_4 = RankData:GetGuildActivityRank(arg_9_0.activityID_)

		if var_9_4 then
			local var_9_5, var_9_6 = var_9_4:GetCurRankDes()

			arg_9_0.rank_.text = var_9_5
			arg_9_0.score_.text = var_9_6
		else
			arg_9_0.rank_.text = ""
			arg_9_0.score_.text = ""
		end

		arg_9_0.tabController_:SetSelectedState("club")
	end
end

function var_0_0.RefreshNone(arg_10_0)
	arg_10_0.rank_.text = GetTips("MATRIX_RANK_NO_RANK")
	arg_10_0.score_.text = GetTips("MATRIX_RANK_NO_INFO")
end

function var_0_0.RefreshList(arg_11_0)
	if arg_11_0.curRankType_ == var_0_1.ALL then
		local var_11_0 = RankData:GetActivityRank(arg_11_0.activityID_)

		arg_11_0.rankList_ = var_11_0 and var_11_0.rankList or {}
	else
		local var_11_1 = RankData:GetGuildActivityRank(arg_11_0.activityID_)

		arg_11_0.rankList_ = var_11_1 and var_11_1.rankList or {}
	end

	arg_11_0.scrollHelper_:StartScroll(#arg_11_0.rankList_)
end

function var_0_0.OnTop(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0.scrollHelper_:StartScroll(0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllListeners()
	arg_14_0.scrollHelper_:Dispose()

	arg_14_0.scrollHelper_ = nil

	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.OnRankUpdate(arg_15_0)
	arg_15_0:RefreshUI()
end

return var_0_0
