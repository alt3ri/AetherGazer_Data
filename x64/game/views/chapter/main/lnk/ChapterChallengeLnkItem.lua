local var_0_0 = class("ChapterChallengeLnkItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.lockController_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")
end

function var_0_0.OnEnter(arg_2_0)
	return
end

function var_0_0.OnExit(arg_3_0)
	manager.redPoint:unbindUIandKey(arg_3_0.transform_)
	arg_3_0:StopTimer()
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	arg_4_0.gameObject_ = nil
	arg_4_0.transform_ = nil
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.chapterClientID_ = arg_5_1

	local var_5_0 = ChapterClientCfg[arg_5_1]

	arg_5_0.isLock_ = JumpTools.GetLinkIsLocked(var_5_0.jump_system)

	SetSpriteWithoutAtlasAsync(arg_5_0.image_, SpritePathCfg.ChapterPaint.path .. var_5_0.chapter_paint_2)

	arg_5_0.nameText_.text = var_5_0.name

	arg_5_0:RefreshLockState()
	arg_5_0:AddTimer()
	manager.redPoint:bindUIandKey(arg_5_0.transform_, ChapterTools.GetRedPoint(arg_5_1))
	arg_5_0:Show(true)
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.button_, nil, function()
		local var_7_0 = ChapterClientCfg[arg_6_0.chapterClientID_]

		if not arg_6_0.isLock_ then
			SystemRedPoint:CancelNewTagByChapterId(arg_6_0.chapterClientID_)
		end

		JumpTools.JumpToPage2(var_7_0.jump_system)
	end)
end

function var_0_0.AddTimer(arg_8_0)
	arg_8_0:StopTimer()
	arg_8_0:RefreshTimeStamp(true)

	arg_8_0.timer_ = Timer.New(function()
		arg_8_0:RefreshTimeStamp()
	end, 1, -1)

	arg_8_0.timer_:Start()
end

function var_0_0.StopTimer(arg_10_0)
	if arg_10_0.timer_ then
		arg_10_0.timer_:Stop()

		arg_10_0.timer_ = nil
	end
end

function var_0_0.RefreshTimeStamp(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.chapterClientID_
	local var_11_1 = ChapterTools.GetChallengeNextRefreshTimeStamp(var_11_0)

	if arg_11_1 then
		if var_11_1 == 0 or arg_11_0.isLock_ then
			SetActive(arg_11_0.timeGo_, false)
		else
			SetActive(arg_11_0.timeGo_, true)
		end
	end

	if var_11_1 ~= 0 then
		arg_11_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_11_1, true)
	end
end

function var_0_0.RefreshLockState(arg_12_0)
	if arg_12_0.isLock_ then
		arg_12_0.lockController_:SetSelectedState("true")
	else
		arg_12_0.lockController_:SetSelectedState("false")
	end
end

function var_0_0.Show(arg_13_0, arg_13_1)
	SetActive(arg_13_0.gameObject_, arg_13_1)
end

return var_0_0
