local var_0_0 = class("SectionSelectHeroEquipBreakThroughView", SectionSelectHeroBaseView)

function var_0_0.GetComboSkillView(arg_1_0)
	return SectionComboSkillEquipBreakThroughView
end

function var_0_0.OnEnter(arg_2_0)
	var_0_0.super.OnEnter(arg_2_0)

	arg_2_0.updateHandler_ = handler(arg_2_0, arg_2_0.UpdateBreakThroughData)

	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_MATERIAL_UPDATE, arg_2_0.updateHandler_)
end

function var_0_0.OnExit(arg_3_0)
	var_0_0.super.OnExit(arg_3_0)
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_MATERIAL_UPDATE, arg_3_0.updateHandler_)

	arg_3_0.updateHandler_ = nil
end

function var_0_0.OnTop(arg_4_0)
	var_0_0.super.OnTop(arg_4_0)
	EquipBreakThroughMaterialAction.CheckTimeout()
end

function var_0_0.RefreshAddBtn(arg_5_0)
	var_0_0.super.RefreshAddBtn(arg_5_0)

	for iter_5_0 = 1, 3 do
		SetActive(arg_5_0["hp" .. iter_5_0 .. "Go_"], false)
	end

	arg_5_0:RefreshEquipBTMaterialHP()
end

function var_0_0.RefreshEquipBTMaterialHP(arg_6_0)
	local var_6_0 = EquipBreakThroughMaterialData:GetHeroState()
	local var_6_1 = {}

	if #var_6_0 > 0 then
		for iter_6_0, iter_6_1 in pairs(var_6_0) do
			var_6_1[iter_6_0] = {
				heroID = iter_6_1.heroID,
				rate = iter_6_1.rate
			}
		end
	else
		for iter_6_2, iter_6_3 in pairs(EquipBreakThroughMaterialData:GetCacheHero()) do
			var_6_1[iter_6_2] = {
				rate = 10000,
				heroID = iter_6_3
			}
		end
	end

	for iter_6_4, iter_6_5 in pairs(var_6_1) do
		if iter_6_5.heroID ~= 0 then
			arg_6_0.hpImg_[iter_6_4].fillAmount = iter_6_5.rate / 10000

			local var_6_2 = math.ceil(iter_6_5.rate / 100)

			if iter_6_5.rate > 0 and var_6_2 < 1 then
				var_6_2 = 1
			end

			arg_6_0.hpText_[iter_6_4].text = var_6_2 .. "%"

			if iter_6_5.rate ~= 0 then
				SetActive(arg_6_0["hp" .. iter_6_4 .. "Go_"], true)
			end
		end
	end
end

function var_0_0.UpdateBreakThroughData(arg_7_0)
	EquipBreakThroughMaterialAction.EquipBTMaterialBackEntrace()
end

function var_0_0.GetSkinCfg(arg_8_0, arg_8_1, arg_8_2)
	return arg_8_0:GetHeroCfg(arg_8_2)
end

function var_0_0.GetHeroCfg(arg_9_0, arg_9_1)
	return HeroTools.HeroUsingSkinInfo(arg_9_1)
end

function var_0_0.GoHeroInfoUI(arg_10_0, arg_10_1)
	local var_10_0 = BattleStageTools.GetRestrictHeroList(arg_10_0.stageType_, arg_10_0.stageID_)

	if type(var_10_0) == "table" then
		local var_10_1 = var_10_0[arg_10_1]

		if var_10_1[1] == 0 or var_10_1[1] ~= 0 and HeroCfg[var_10_1[1]] and not table.keyof(HeroCfg.get_id_list_by_private[0], var_10_1[1]) then
			ShowTips("CAN_NOT_CHANGE_HERO")

			return
		end
	end

	if arg_10_0.cacheHeroTeam_[arg_10_1] == 0 and arg_10_0.lockStateList_[arg_10_1] == true then
		ShowTips("CAN_NOT_CHANGE_HERO")

		return
	end

	arg_10_0:Go("/heroTeamInfo", {
		isEnter = true,
		selectHeroPos = arg_10_1,
		stageID = arg_10_0.stageID_,
		activityID = arg_10_0.params_.activityID,
		stageType = arg_10_0.stageType_
	})
end

function var_0_0.RefreshReservesBtn(arg_11_0)
	SetActive(arg_11_0.reservesBtn_.gameObject, false)
end

function var_0_0.ChangeHeroTeam(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_2 = table.keyof(arg_12_0.cacheHeroTeam_, iter_12_1)

		var_12_1[iter_12_0] = arg_12_0.heroTrialList_[var_12_2]
	end

	if var_12_0[1] ~= arg_12_0.cacheHeroTeam_[1] then
		arg_12_0:PlayHeroTalk(var_12_0[1])
	end

	EquipBreakThroughMaterialData:SetHeroTeam(var_12_0)
end

function var_0_0.StartBattle(arg_13_0)
	if EquipBreakThroughMaterialData:GetComboSkillID() == -1 then
		local var_13_0 = ComboSkillData:GetComboSkillID(arg_13_0.stageType_, arg_13_0.activityID_, 1)

		EquipBreakThroughMaterialAction.SaveComboSkillID(var_13_0, function()
			var_0_0.super.StartBattle(arg_13_0)
		end)
	else
		var_0_0.super.StartBattle(arg_13_0)
	end
end

function var_0_0.GetChipView(arg_15_0)
	return SectionChipEquipBreakThroughView
end

return var_0_0
