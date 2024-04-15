local var_0_0 = class("ChapterSelectSubChapterView", ReduxView)

var_0_0.MAX_DRAG_LENGTH = 1500
var_0_0.MIN_DRAG_LENGTH = 200
var_0_0.SWITCH_STAGE_TIME = 0.8

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/OperationSideUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.chapterSelectTitleView_ = ChapterSelectTitleView.New(arg_3_0.titleGo_)
	arg_3_0.changeSelectChapterHandler_ = handler(arg_3_0, arg_3_0.ChangeSelectChapterID)
	arg_3_0.lockController_ = arg_3_0.controllerEx_:GetController("lock")
	arg_3_0.chapterToggleItemList_ = {}
	arg_3_0.groupDataList_ = ChapterTools.GetChapterGroupList(BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT))
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INVITE_BAR
	})
	arg_4_0:RefreshData()
	arg_4_0:InitImage()
	arg_4_0:RefreshUI()
	arg_4_0.chapterSelectTitleView_:OnEnter(arg_4_0.selectChapterClientID_)
	manager.notify:RegistListener(CHANGE_PLOT_SELECT_CHAPTER, arg_4_0.changeSelectChapterHandler_)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.chapterToggleItemList_) do
		iter_4_1:OnEnter()
	end
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:HideBar()
	arg_5_0.chapterSelectTitleView_:OnExit()
	manager.notify:RemoveListener(CHANGE_PLOT_SELECT_CHAPTER, arg_5_0.changeSelectChapterHandler_)
	arg_5_0:StopAllTimer()
	arg_5_0:StopLeanTween()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.chapterToggleItemList_) do
		iter_5_1:OnExit()
	end
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.changeSelectChapterHandler_ = nil
	arg_6_0.chapterBehindImage_ = nil

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.chapterToggleItemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.chapterToggleItemList_ = nil

	arg_6_0.chapterSelectTitleView_:Dispose()

	arg_6_0.chapterSelectTitleView_ = nil

	arg_6_0:RemoveListeners()
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_7_0, arg_7_0.BeginDragFun)))
	arg_7_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(arg_7_0, arg_7_0.DragFun)))
	arg_7_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_7_0, arg_7_0.EndDragFun)))
	arg_7_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(handler(arg_7_0, arg_7_0.PointerUpFun)))
	arg_7_0.toggleEventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_7_0, arg_7_0.BeginToggleDragFun)))
end

function var_0_0.BeginDragFun(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:StopLeanTween()
end

function var_0_0.DragFun(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2.position.x - arg_9_2.pressPosition.x
	local var_9_1 = ChapterTools.GetNeighborClientID(arg_9_0.selectChapterClientID_, var_9_0 < 0)

	if var_9_1 == arg_9_0.selectChapterClientID_ then
		return
	end

	if arg_9_0.nextChapterClientID_ ~= var_9_1 then
		local var_9_2 = ChapterClientCfg[var_9_1]
		local var_9_3 = SpritePathCfg.ChapterPaint.path .. var_9_2.chapter_paint

		getSpriteWithoutAtlasAsync(var_9_3, function(arg_10_0)
			if arg_9_0.chapterBehindImage_ then
				arg_9_0.chapterBehindImage_.sprite = arg_10_0
			end
		end)

		arg_9_0.nextChapterClientID_ = var_9_1
	end

	local var_9_4 = math.min(math.max(0, math.abs(var_9_0)), var_0_0.MAX_DRAG_LENGTH) / var_0_0.MAX_DRAG_LENGTH

	arg_9_0.chapterFrontCanvasGroup_.alpha = 1 - var_9_4
	arg_9_0.chapterBehindCanvasGroup_.alpha = var_9_4
end

function var_0_0.EndDragFun(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2.position.x - arg_11_2.pressPosition.x

	if ChapterTools.GetNeighborClientID(arg_11_0.selectChapterClientID_, var_11_0 < 0) == arg_11_0.selectChapterClientID_ then
		return
	end

	if math.abs(var_11_0) > var_0_0.MIN_DRAG_LENGTH then
		arg_11_0.selectChapterClientID_ = arg_11_0.nextChapterClientID_
		arg_11_0.nextChapterClientID_ = nil

		BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT, arg_11_0.selectChapterClientID_)
		arg_11_0:RefreshData()

		if math.abs(var_11_0) > var_0_0.MAX_DRAG_LENGTH then
			arg_11_0:RefreshChapterUI()
			arg_11_0:SwitchImageOver()
		else
			local var_11_1 = (var_0_0.MAX_DRAG_LENGTH - math.abs(var_11_0)) / var_0_0.MAX_DRAG_LENGTH * var_0_0.SWITCH_STAGE_TIME

			arg_11_0.leanTweenHandler_ = LeanTween.value(arg_11_0.chapterFrontImage_.gameObject, arg_11_0.chapterFrontCanvasGroup_.alpha, 0, var_11_1)

			arg_11_0.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_12_0)
				arg_11_0.chapterFrontCanvasGroup_.alpha = arg_12_0
				arg_11_0.chapterBehindCanvasGroup_.alpha = 1 - arg_12_0
			end))
			arg_11_0.leanTweenHandler_:setOnComplete(System.Action(function()
				arg_11_0:RefreshChapterUI()
				arg_11_0:SwitchImageOver()
				LeanTween.cancel(arg_11_0.chapterFrontImage_.gameObject)
				arg_11_0.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

				arg_11_0.leanTweenHandler_ = nil
			end))
		end
	else
		local var_11_2 = (1 - (var_0_0.MIN_DRAG_LENGTH - math.abs(var_11_0)) / var_0_0.MIN_DRAG_LENGTH) * 0.8

		arg_11_0.leanTweenHandler_ = LeanTween.value(arg_11_0.chapterFrontImage_.gameObject, arg_11_0.chapterFrontCanvasGroup_.alpha, 1, var_11_2)

		arg_11_0.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_14_0)
			arg_11_0.chapterFrontCanvasGroup_.alpha = arg_14_0
			arg_11_0.chapterBehindCanvasGroup_.alpha = 1 - arg_14_0
		end))
		arg_11_0.leanTweenHandler_:setOnComplete(System.Action(function()
			LeanTween.cancel(arg_11_0.chapterFrontImage_.gameObject)
			arg_11_0.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

			arg_11_0.leanTweenHandler_ = nil
		end))
	end
end

function var_0_0.PointerUpFun(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2.dragging then
		return
	end

	if arg_16_0.isLock_ then
		local var_16_0 = arg_16_0:GetActivityID()
		local var_16_1 = ActivityData:GetActivityRefreshTime(var_16_0)

		if var_16_1 > manager.time:GetServerTime() then
			local var_16_2 = GetTips("OPEN_TIME")

			ShowTips(string.format(var_16_2, manager.time:GetLostTimeStr(var_16_1)))

			return
		end
	end

	JumpTools.Jump2SubPlot(arg_16_0.selectChapterClientID_, false, true)
end

function var_0_0.BeginToggleDragFun(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:StopMoveTimer()
	arg_17_0.scrollView_:OnBeginDrag(arg_17_2)
end

function var_0_0.RemoveListeners(arg_18_0)
	arg_18_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_18_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	arg_18_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	arg_18_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	arg_18_0.toggleEventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
end

function var_0_0.SwitchImageOver(arg_19_0)
	arg_19_0.chapterBehindImage_, arg_19_0.chapterFrontImage_ = arg_19_0.chapterFrontImage_, arg_19_0.chapterBehindImage_
	arg_19_0.chapterBehindCanvasGroup_, arg_19_0.chapterFrontCanvasGroup_ = arg_19_0.chapterFrontCanvasGroup_, arg_19_0.chapterBehindCanvasGroup_
end

function var_0_0.AutoSwitchImage(arg_20_0)
	local var_20_0 = arg_20_0.selectChapterClientID_
	local var_20_1 = ChapterClientCfg[var_20_0]
	local var_20_2 = SpritePathCfg.ChapterPaint.path .. var_20_1.chapter_paint

	getSpriteWithoutAtlasAsync(var_20_2, function(arg_21_0)
		if arg_20_0.chapterBehindImage_ then
			arg_20_0.chapterBehindImage_.sprite = arg_21_0
		end
	end)

	local var_20_3 = var_0_0.SWITCH_STAGE_TIME

	arg_20_0.leanTweenHandler_ = LeanTween.value(arg_20_0.chapterFrontImage_.gameObject, arg_20_0.chapterFrontCanvasGroup_.alpha, 0, var_20_3)

	arg_20_0.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
		arg_20_0.chapterFrontCanvasGroup_.alpha = arg_22_0
		arg_20_0.chapterBehindCanvasGroup_.alpha = 1 - arg_22_0
	end))
	arg_20_0.leanTweenHandler_:setOnComplete(System.Action(function()
		arg_20_0:SwitchImageOver()
		LeanTween.cancel(arg_20_0.chapterFrontImage_.gameObject)
		arg_20_0.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

		arg_20_0.leanTweenHandler_ = nil
	end))
end

function var_0_0.RefreshData(arg_24_0)
	arg_24_0.selectChapterClientID_ = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT)

	local var_24_0 = ChapterClientCfg[arg_24_0.selectChapterClientID_].chapter_list[1]

	arg_24_0.isLock_ = not ChapterTools.IsUnlockSubPlotClient(var_24_0)
end

function var_0_0.InitImage(arg_25_0)
	local var_25_0 = ChapterClientCfg[arg_25_0.selectChapterClientID_]
	local var_25_1 = SpritePathCfg.ChapterPaint.path .. var_25_0.chapter_paint

	getSpriteWithoutAtlasAsync(var_25_1, function(arg_26_0)
		if arg_25_0.chapterBehindImage_ then
			arg_25_0.chapterBehindImage_.sprite = arg_26_0
		end

		if arg_25_0.chapterFrontImage_ then
			arg_25_0.chapterFrontImage_.sprite = arg_26_0
		end
	end)
end

function var_0_0.RefreshUI(arg_27_0)
	arg_27_0:RefreshChapterUI()
	arg_27_0:AutoSwitchImage()
end

function var_0_0.RefreshChapterUI(arg_28_0)
	arg_28_0.chapterSelectTitleView_:OnEnter(arg_28_0.selectChapterClientID_)
	arg_28_0:RefreshGroupToggle()
	arg_28_0:AddActivityTimer()
	arg_28_0:RefreshActivity()
	arg_28_0:RefreshLock()
end

function var_0_0.RefreshGroupToggle(arg_29_0)
	local var_29_0

	for iter_29_0, iter_29_1 in ipairs(arg_29_0.groupDataList_) do
		if arg_29_0.chapterToggleItemList_[iter_29_0] == nil then
			arg_29_0.chapterToggleItemList_[iter_29_0] = ChapterSelectSubChapterToggleItem.New(arg_29_0.chapterToggleItem_, arg_29_0.chapterParentTf_, iter_29_1[2])
		end

		local var_29_1 = arg_29_0.selectChapterClientID_ == iter_29_1[2]

		arg_29_0.chapterToggleItemList_[iter_29_0]:SetSelect(var_29_1)

		if var_29_1 then
			var_29_0 = arg_29_0.chapterToggleItemList_[iter_29_0]
		end
	end

	if var_29_0 then
		arg_29_0:AddMoveTimer(var_29_0)
	end
end

function var_0_0.RefreshActivity(arg_30_0)
	return
end

function var_0_0.RefreshLock(arg_31_0)
	arg_31_0.lockController_:SetSelectedState(tostring(arg_31_0.isLock_))

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.chapterToggleItemList_) do
		iter_31_1:RefreshLock()
	end
end

function var_0_0.RefreshSelectDifficult(arg_32_0)
	arg_32_0.hardLevelView_:SetData(arg_32_0.hardLevel_)
end

function var_0_0.ChangeSelectChapterID(arg_33_0)
	arg_33_0:StopLeanTween()
	arg_33_0:RefreshData()
	arg_33_0:RefreshUI()
end

function var_0_0.GetActivityID(arg_34_0)
	local var_34_0 = arg_34_0.selectChapterClientID_
	local var_34_1 = ChapterClientCfg[var_34_0].chapter_list[1]

	return ChapterCfg[var_34_1].activity_id or 0
end

function var_0_0.AddActivityTimer(arg_35_0)
	arg_35_0:RemoveActivityTimer()

	local var_35_0 = arg_35_0.selectChapterClientID_
	local var_35_1 = ChapterClientCfg[var_35_0].chapter_list[1]
	local var_35_2 = arg_35_0:GetActivityID()

	if var_35_2 == 0 then
		return
	end

	local var_35_3 = ActivityData:GetActivityData(var_35_2):IsActivitying()

	arg_35_0.activityTimer_ = Timer.New(function()
		local var_36_0 = ActivityData:GetActivityData(var_35_2):IsActivitying()

		if var_36_0 ~= var_35_3 then
			var_35_3 = var_36_0
			arg_35_0.isLock_ = not ChapterTools.IsUnlockSubPlotClient(var_35_1)

			arg_35_0:RefreshLock()
			arg_35_0:RefreshActivity()
		end
	end, 1, -1)

	arg_35_0.activityTimer_:Start()
end

function var_0_0.RemoveActivityTimer(arg_37_0)
	if arg_37_0.activityTimer_ then
		arg_37_0.activityTimer_:Stop()

		arg_37_0.activityTimer_ = nil
	end
end

function var_0_0.AddMoveTimer(arg_38_0, arg_38_1)
	arg_38_0:StopMoveTimer()

	arg_38_0.moveTimer_ = FrameTimer.New(function()
		local var_39_0 = arg_38_0.chapterParentTf_.rect.width / 2
		local var_39_1 = arg_38_0.scrollTf_.rect.width / 2
		local var_39_2 = arg_38_0.chapterParentTf_.anchoredPosition
		local var_39_3 = arg_38_1:GetLocalPosition().x * -1

		if var_39_1 >= var_39_0 + var_39_3 then
			var_39_3 = var_39_1 - var_39_0
		elseif var_39_1 >= var_39_0 - var_39_3 then
			var_39_3 = var_39_0 - var_39_1
		end

		local var_39_4 = 3 * math.pow(arg_38_0.scrollView_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime

		arg_38_0.chapterParentTf_.anchoredPosition = Vector2.Lerp(var_39_2, Vector2.New(var_39_3, var_39_2.y), var_39_4)

		if math.abs(var_39_2.x - var_39_3) <= 1 then
			arg_38_0.chapterParentTf_.anchoredPosition = Vector2(var_39_3, var_39_2.y)

			arg_38_0:StopMoveTimer()
		end
	end, 1, -1)

	arg_38_0.moveTimer_:Start()
end

function var_0_0.StopMoveTimer(arg_40_0)
	if arg_40_0.moveTimer_ then
		arg_40_0.moveTimer_:Stop()

		arg_40_0.moveTimer_ = nil
	end
end

function var_0_0.StopLeanTween(arg_41_0)
	if arg_41_0.leanTweenHandler_ then
		LeanTween.cancel(arg_41_0.chapterFrontImage_.gameObject)
		arg_41_0.leanTweenHandler_:callOnCompletes()
	end
end

function var_0_0.StopAllTimer(arg_42_0)
	arg_42_0:StopMoveTimer()
	arg_42_0:RemoveActivityTimer()
end

return var_0_0
