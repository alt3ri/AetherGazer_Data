local var_0_0 = class("ChapterEquipItemBaseView", import("..ChapterBaseItemView"))

function var_0_0.OnEnter(arg_1_0)
	var_0_0.super.OnEnter(arg_1_0)
	arg_1_0:AddRedPoint()
end

function var_0_0.OnExit(arg_2_0)
	arg_2_0:RemoveRedPoint()
	var_0_0.super.OnExit(arg_2_0)
end

function var_0_0.AddRedPoint(arg_3_0)
	return
end

function var_0_0.RemoveRedPoint(arg_4_0)
	return
end

function var_0_0.RefreshCustomItem(arg_5_0, arg_5_1)
	if arg_5_0.oldCfgID_ ~= arg_5_1.id then
		arg_5_0.nameText_.text = GetI18NText(arg_5_1.name)

		SetSpriteWithoutAtlasAsync(arg_5_0.icon_, arg_5_1.drop_icon)

		arg_5_0.oldCfgID_ = arg_5_1.id
	end
end

function var_0_0.ClickItem(arg_6_0, arg_6_1)
	if arg_6_0.isLock_ then
		ShowTips(arg_6_0.lockTips_)

		return
	end

	local var_6_0 = ChapterClientCfg[arg_6_1].chapter_list[1]
	local var_6_1 = ChapterCfg[var_6_0]

	if var_6_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP then
		JumpTools.OpenPageByJump("/equipSection", {
			chapterID = var_6_0
		}, ViewConst.SYSTEM_ID.BATTLE_EQUIP_SECTION)

		return
	elseif var_6_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT then
		JumpTools.OpenPageByJump("/enchantment")

		return
	elseif var_6_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY then
		JumpTools.OpenPageByJump("/daily", {
			chapterID = var_6_0
		})

		return
	elseif var_6_1.type == BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL then
		EquipBreakThroughMaterialAction.EnterEquipBTMaterial()

		return
	elseif var_6_1.type == BattleConst.STAGE_TYPE_NEW.EQUIP_SEIZURE then
		JumpTools.OpenPageByJump("/equipSeizure", {
			chapterID = var_6_0
		})

		return
	end
end

return var_0_0
