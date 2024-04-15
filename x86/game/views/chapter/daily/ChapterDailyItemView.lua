local var_0_0 = class("ChapterDailyItemView", import("..ChapterBaseItemView"))

function var_0_0.OnEnter(arg_1_0)
	var_0_0.super.OnEnter(arg_1_0)
	arg_1_0:AddRedPoint()
end

function var_0_0.OnExit(arg_2_0)
	var_0_0.super.OnExit(arg_2_0)
	arg_2_0:RemoveRedPoint()
end

function var_0_0.RefreshCustomItem(arg_3_0, arg_3_1)
	if arg_3_0.oldCfgID_ ~= arg_3_1.id then
		arg_3_0.nameText_.text = GetI18NText(arg_3_1.name)

		SetSpriteWithoutAtlasAsync(arg_3_0.icon_, arg_3_1.drop_icon)

		arg_3_0.oldCfgID_ = arg_3_1.id
	end
end

function var_0_0.ClickItem(arg_4_0, arg_4_1)
	if arg_4_0.isLock_ then
		ShowTips(arg_4_0.lockTips_)

		return
	end

	local var_4_0 = ChapterClientCfg[arg_4_1].chapter_list[1]
	local var_4_1 = BattleFieldData:GetStageByClientID(arg_4_1)

	if var_4_1 then
		var_4_0 = getChapterIDByStageID(var_4_1)
	end

	JumpTools.OpenPageByJump("/daily", {
		chapterID = var_4_0
	})
end

function var_0_0.AddRedPoint(arg_5_0)
	manager.redPoint:bindUIandKey(arg_5_0.panelTf_, ChapterTools.GetRedPoint(arg_5_0.chapterClientID_))
end

function var_0_0.RemoveRedPoint(arg_6_0)
	manager.redPoint:unbindUIandKey(arg_6_0.panelTf_, ChapterTools.GetRedPoint(arg_6_0.chapterClientID_))
end

return var_0_0
