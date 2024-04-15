local var_0_0 = class("SequentialBattleFactoryView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/MardukUI/continuousBattle/MardukContinuousBattleMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.selectChapterHandler_ = handler(arg_3_0, arg_3_0.Update)
	arg_3_0.difficultItemList_ = {}

	for iter_3_0, iter_3_1 in ipairs(ActivityCfg[arg_3_0:GetActivityID()].sub_activity_list) do
		arg_3_0.difficultItemList_[iter_3_0] = SequentialBattleChapterItem.New(arg_3_0.difficultItem_, arg_3_0.difficultParent_, iter_3_1)
	end

	arg_3_0.adaptImg_ = arg_3_0:FindCom("AdaptImage", nil, arg_3_0.portraitImage_.transform)
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("SEQUENTIAL_BATTLE_DESC")
	arg_4_0:Update()
	manager.notify:RegistListener(SEQUENTIAL_BATTLE_SELECT_CHAPTER, arg_4_0.selectChapterHandler_)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.difficultItemList_) do
		iter_4_1:OnEnter()
	end

	arg_4_0:AddTimer()
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(SEQUENTIAL_BATTLE_SELECT_CHAPTER, arg_5_0.selectChapterHandler_)
	manager.redPoint:unbindUIandKey(arg_5_0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_REWARD, arg_5_0.selectID_))

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.difficultItemList_) do
		iter_5_1:OnExit()
	end

	arg_5_0.selectID_ = nil

	arg_5_0:StopTimer()
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.difficultItemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.difficultItemList_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.buffBtn_, nil, function()
		JumpTools.OpenPageByJump("sequentialBattleBuffInfo", {
			activityID = arg_7_0.selectID_
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("sequentialBattleReward", {
			activityID = arg_7_0.selectID_
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.battleBtn_, nil, function()
		if ActivityData:GetActivityData(arg_7_0.selectID_).stopTime <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		arg_7_0:Go("/sequentialBattleFactoryTeam", {
			activityID = arg_7_0.selectID_
		})
	end)
end

function var_0_0.Update(arg_11_0)
	arg_11_0:RefreshData()
	arg_11_0:RefreshUI()
	SequentialBattleAction.ClickDayRedPoint(arg_11_0.selectID_)
end

function var_0_0.RefreshData(arg_12_0)
	local var_12_0 = arg_12_0:GetActivityID()
	local var_12_1 = SequentialBattleData:GetSelectChapterID(var_12_0)

	if arg_12_0.selectID_ ~= var_12_1 then
		if arg_12_0.selectID_ then
			manager.redPoint:unbindUIandKey(arg_12_0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_REWARD, arg_12_0.selectID_))
		end

		manager.redPoint:bindUIandKey(arg_12_0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_REWARD, var_12_1))
	end

	arg_12_0.selectID_ = var_12_1
end

function var_0_0.RefreshUI(arg_13_0)
	arg_13_0:RefreshSelectChapter()
	arg_13_0:RefreshReward()
	arg_13_0:RefreshRightPanel()
end

function var_0_0.RefreshRightPanel(arg_14_0)
	local var_14_0 = SequentialBattleChapterCfg[arg_14_0.selectID_]

	arg_14_0.portraitImage_.sprite = getSpriteWithoutAtlas("TextureConfig/MardukUI/boss/Portrait/" .. var_14_0.portrait)

	arg_14_0.adaptImg_:AdaptImg()

	arg_14_0.nameText_.text = GetI18NText(var_14_0.stage_name)
	arg_14_0.descText_.text = GetI18NText(var_14_0.stage_desc)
end

function var_0_0.RefreshSelectChapter(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.difficultItemList_) do
		iter_15_1:RefreshSelect(arg_15_0.selectID_)
	end
end

function var_0_0.RefreshReward(arg_16_0)
	return
end

function var_0_0.GetActivityID(arg_17_0)
	return ActivityConst.FACTORY_SEQUENTIAL_BATTLE
end

function var_0_0.AddTimer(arg_18_0)
	local var_18_0 = arg_18_0:GetActivityID()
	local var_18_1 = ActivityData:GetActivityData(var_18_0).stopTime

	arg_18_0:StopTimer()

	if var_18_1 <= manager.time:GetServerTime() then
		arg_18_0.timeText_.text = GetTips("TIME_OVER")

		return
	end

	arg_18_0.timeText_.text = manager.time:GetLostTimeStr(var_18_1)
	arg_18_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= var_18_1 then
			arg_18_0:StopTimer()

			arg_18_0.timeText_.text = GetTips("TIME_OVER")

			return
		end

		arg_18_0.timeText_.text = manager.time:GetLostTimeStr(var_18_1)
	end, 1, -1)

	arg_18_0.timer_:Start()
end

function var_0_0.StopTimer(arg_20_0)
	if arg_20_0.timer_ then
		arg_20_0.timer_:Stop()

		arg_20_0.timer_ = nil
	end
end

return var_0_0
