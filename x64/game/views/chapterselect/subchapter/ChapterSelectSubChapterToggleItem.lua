local var_0_0 = class("ChapterSelectSubChapterToggleItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.selectController_ = arg_1_0.controllerEx_:GetController("select")
	arg_1_0.lockController_ = arg_1_0.controllerEx_:GetController("lock")
	arg_1_0.isCompleteController_ = arg_1_0.controllerEx_:GetController("clear")

	arg_1_0:SetData(arg_1_3)
	arg_1_0:OnEnter()
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	arg_2_0.chapterClientID_ = arg_2_1

	local var_2_0 = ChapterClientCfg[arg_2_1]
	local var_2_1 = SpritePathCfg.ChapterPaint.path .. var_2_0.chapter_paint

	getSpriteWithoutAtlasAsync(var_2_1, function(arg_3_0)
		if arg_2_0.paintImage_ then
			arg_2_0.paintImage_.sprite = arg_3_0
		end
	end)
	arg_2_0:Show(true)
end

function var_0_0.OnEnter(arg_4_0)
	manager.redPoint:bindUIandKey(arg_4_0.redRoot_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, arg_4_0.chapterClientID_))
end

function var_0_0.OnExit(arg_5_0)
	manager.redPoint:unbindUIandKey(arg_5_0.redRoot_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, arg_5_0.chapterClientID_))
end

function var_0_0.SetSelect(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.chapterClientID_
	local var_6_1 = ChapterTools.GetChapterClientFinishPercentage(var_6_0)

	arg_6_0.isCompleteController_:SetSelectedState(tostring(var_6_1 == 1))
	arg_6_0.selectController_:SetSelectedState(tostring(arg_6_1))
	arg_6_0.transform_:SetAsLastSibling()
end

function var_0_0.RefreshLock(arg_7_0)
	local var_7_0 = arg_7_0.chapterClientID_
	local var_7_1 = ChapterClientCfg[var_7_0].chapter_list[1]

	arg_7_0.isLock_ = not ChapterTools.IsUnlockSubPlotClient(var_7_1)

	arg_7_0.lockController_:SetSelectedState(tostring(arg_7_0.isLock_))
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)

	arg_8_0.paintImage_ = nil

	Object.Destroy(arg_8_0.gameObject_)

	arg_8_0.gameObject_ = nil
	arg_8_0.transform_ = nil
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.btn_, nil, function()
		local var_10_0 = arg_9_0.chapterClientID_
		local var_10_1 = BattleFieldData:GetCacheChapter(var_10_0)
		local var_10_2 = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT)

		if ChapterClientCfg[var_10_2].id ~= var_10_0 then
			BattleFieldAction.ChangeSelectChapterID(var_10_1)

			return
		end
	end)
end

function var_0_0.GetLocalPosition(arg_11_0)
	return arg_11_0.transform_.localPosition
end

function var_0_0.Show(arg_12_0, arg_12_1)
	SetActive(arg_12_0.gameObject_, arg_12_1)
end

return var_0_0
