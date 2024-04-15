local var_0_0 = class("ChapterEquipBreakThroughMaterialItemView", import(".ChapterEquipItemView"))

function var_0_0.OnEnter(arg_1_0)
	var_0_0.super.OnEnter(arg_1_0)
	manager.redPoint:bindUIandKey(arg_1_0.transform_, RedPointConst.EQUIP_BREAK_THROUGH_MATERIAL, {
		x = 195.4,
		y = 296
	})

	if arg_1_0.isLock_ then
		SetActive(arg_1_0.timeGo_, false)
	else
		SetActive(arg_1_0.timeGo_, true)
	end

	arg_1_0:AddRefreshTimer()
end

function var_0_0.OnExit(arg_2_0)
	var_0_0.super.OnExit(arg_2_0)
	manager.redPoint:unbindUIandKey(arg_2_0.transform_, RedPointConst.EQUIP_BREAK_THROUGH_MATERIAL)
	arg_2_0:StopRefreshTimer()
end

function var_0_0.IsLock(arg_3_0)
	arg_3_0.isLock_ = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_EQUIP_BREAK_THROUGH_MATERIAL) and true or false
end

function var_0_0.GetIconPath(arg_4_0, arg_4_1)
	return SpritePathCfg.ItemIcon.path
end

function var_0_0.ClickItemListener(arg_5_0)
	local var_5_0 = arg_5_0.chapterClientID_

	if arg_5_0.isLock_ then
		local var_5_1 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_EQUIP_BREAK_THROUGH_MATERIAL)

		ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.BATTLE_EQUIP_BREAK_THROUGH_MATERIAL, var_5_1))

		return
	end

	arg_5_0:ClickItem(var_5_0)
end

function var_0_0.AddRefreshTimer(arg_6_0)
	arg_6_0:StopRefreshTimer()

	local var_6_0 = EquipBreakThroughMaterialData:GetRefreshTimestamp()

	arg_6_0.timeText_.text = string.format(GetTips("REFRESH_LOST_TIME"), manager.time:GetLostTimeStr(var_6_0, nil, true))
	arg_6_0.timer_ = Timer.New(function()
		local var_7_0 = EquipBreakThroughMaterialData:GetRefreshTimestamp()

		arg_6_0.timeText_.text = string.format(GetTips("REFRESH_LOST_TIME"), manager.time:GetLostTimeStr(var_7_0, nil, true))
	end, 1, -1)

	arg_6_0.timer_:Start()
end

function var_0_0.StopRefreshTimer(arg_8_0)
	if arg_8_0.timer_ then
		arg_8_0.timer_:Stop()

		arg_8_0.timer_ = nil
	end
end

return var_0_0
