ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("DormLinkGameDailyView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return DormLinkGameTools:GetMainUIName(arg_1_0.activityID_)
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.indexDailyItemList), arg_3_0.uilistUilist_, DormLinkGameDailyItem)
	arg_3_0.clearCon_ = ControllerUtil.GetController(arg_3_0.transform_, "oneclick")
end

function var_0_0.indexDailyItemList(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:RefreshUI(arg_4_0.list_[arg_4_1], arg_4_0.activityID_)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListenerScale(arg_5_0.btnstartBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormLinkGameLevelView", {
			activityID_ = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListenerScale(arg_5_0.receiveBtn_, nil, function()
		local var_7_0 = {}
		local var_7_1 = DormLinkGameTools:GetTaskActivityID(arg_5_0.activityID_)

		for iter_7_0, iter_7_1 in ipairs(arg_5_0.list_) do
			local var_7_2 = AssignmentCfg[iter_7_1]
			local var_7_3 = TaskData2:GetTask(iter_7_1)

			if var_7_3.complete_flag < 1 and var_7_3.progress >= var_7_2.need then
				table.insert(var_7_0, iter_7_1)
			end
		end

		TaskAction:SubmitTaskList(var_7_0)
	end)
	arg_5_0:AddBtnListener(arg_5_0.tipBtn_, nil, function()
		local var_8_0 = "gameHelpPro"
		local var_8_1 = {
			hideHomeBtn = 1,
			pages = GameSetting.linkgame_describe.value
		}

		JumpTools.OpenPageByJump(var_8_0, var_8_1)
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:RefreshView()
	arg_9_0:RegisterEvents()
	manager.redPoint:setTip(RedPointConst.ACTIVITY_2_1_LINKGAME_UNCOMPLETE_LEVEL, 0)
end

function var_0_0.UpdateBar(arg_10_0)
	local var_10_0 = DormLinkGameTools:GetCurrencyID(arg_10_0.activityID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_10_0
	})
	manager.windowBar:SetBarCanAdd(var_10_0, true)
end

function var_0_0.UpdataLastTime(arg_11_0)
	local var_11_0 = true
	local var_11_1 = ActivityData:GetActivityData(arg_11_0.activityID_)
	local var_11_2 = var_11_1.startTime
	local var_11_3 = var_11_1.stopTime
	local var_11_4 = manager.time:GetServerTime()

	if var_11_3 < var_11_4 then
		var_11_0 = false
	end

	if not var_11_0 then
		arg_11_0.clearCon_:SetSelectedState("off")
	end

	if var_11_4 < var_11_2 then
		arg_11_0.lastTimeText_.text = GetTips("SOLO_NOT_OPEN")
	elseif var_11_4 < var_11_3 then
		arg_11_0.lastTimeText_.text = manager.time:GetLostTimeStrWith2Unit(var_11_3)
	else
		arg_11_0.lastTimeText_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.RegisterEvents(arg_12_0)
	arg_12_0:RegistEventListener(OSIRIS_TASK_UPDATE, function()
		arg_12_0:RefreshTask()
	end)
end

function var_0_0.RefreshView(arg_14_0)
	arg_14_0:RefreshTask()
	arg_14_0:UpdataLastTime()
end

function var_0_0.RefreshTask(arg_15_0)
	local var_15_0 = DormLinkGameTools:GetTaskActivityID(arg_15_0.activityID_)

	arg_15_0.list_ = {}

	local var_15_1 = TaskTools:GetActivityTaskList(var_15_0) or {}

	local function var_15_2(arg_16_0, arg_16_1)
		local var_16_0 = AssignmentCfg[arg_16_0]
		local var_16_1 = AssignmentCfg[arg_16_1]

		if var_16_0.type ~= var_16_1.type then
			return var_16_0.type < var_16_1.type
		end

		return arg_16_0 < arg_16_1
	end

	local var_15_3 = {}
	local var_15_4 = {}
	local var_15_5 = {}

	for iter_15_0, iter_15_1 in pairs(var_15_1) do
		local var_15_6 = iter_15_1.id
		local var_15_7 = AssignmentCfg[var_15_6]

		if var_15_7.activity_id == var_15_0 then
			if iter_15_1.complete_flag >= 1 then
				table.insert(var_15_5, var_15_6)
			elseif iter_15_1.progress >= var_15_7.need then
				table.insert(var_15_3, var_15_6)
			else
				table.insert(var_15_4, var_15_6)
			end
		end
	end

	table.sort(var_15_3, var_15_2)
	table.sort(var_15_4, var_15_2)
	table.sort(var_15_5, var_15_2)
	table.insertto(arg_15_0.list_, var_15_3)
	table.insertto(arg_15_0.list_, var_15_4)
	table.insertto(arg_15_0.list_, var_15_5)
	arg_15_0.scrollHelper_:StartScroll(#arg_15_0.list_)

	if #var_15_3 > 0 then
		arg_15_0.clearCon_:SetSelectedState("on")
	else
		arg_15_0.clearCon_:SetSelectedState("off")
	end
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_18_0)
	if arg_18_0.scrollHelper_ then
		arg_18_0.scrollHelper_:Dispose()

		arg_18_0.scrollHelper_ = nil
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
