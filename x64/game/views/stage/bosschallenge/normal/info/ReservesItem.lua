local var_0_0 = class("ReservesItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.heroGo_ = {}
	arg_3_0.heroImg_ = {}
	arg_3_0.heroBtn_ = {}
	arg_3_0.campCon_ = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.heroGo_[iter_3_0] = arg_3_0["heroGo_" .. iter_3_0]
		arg_3_0.heroImg_[iter_3_0] = arg_3_0["heroImg_" .. iter_3_0]
		arg_3_0.heroBtn_[iter_3_0] = arg_3_0["heroBtn_" .. iter_3_0]
		arg_3_0.campCon_[iter_3_0] = ControllerUtil.GetController(arg_3_0.heroBtn_[iter_3_0].transform, "name")
	end

	arg_3_0.curCon_ = ControllerUtil.GetController(arg_3_0.transform_, "cur")
	arg_3_0.btnCon_ = ControllerUtil.GetController(arg_3_0.transform_, "btn")
	arg_3_0.nameCon_ = ControllerUtil.GetController(arg_3_0.transform_, "name")
	arg_3_0.chipCon_ = ControllerUtil.GetController(arg_3_0.transform_, "chip")
	arg_3_0.comboSkillCon_ = ControllerUtil.GetController(arg_3_0.transform_, "combo")
	arg_3_0.inputHandler_ = handler(arg_3_0, arg_3_0.OnInput)
	arg_3_0.inputCancelHandler_ = handler(arg_3_0, arg_3_0.OnInputCancel)

	manager.notify:RegistListener(INPUT_POP_CLICK_OK, arg_3_0.inputHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CLOSE, arg_3_0.inputCancelHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CANCEL, arg_3_0.inputCancelHandler_)

	arg_3_0.handler_ = handler(arg_3_0, arg_3_0.OnComboSkillSelect)

	manager.notify:RegistListener(COMBO_SKILL_SELECT, arg_3_0.handler_)
end

function var_0_0.AddUIListeners(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.heroBtn_) do
		arg_4_0:AddBtnListener(iter_4_1, nil, function()
			JumpTools.OpenPageByJump("/heroTeam", {
				index = arg_4_0.info_.index,
				pos = iter_4_0,
				hero_list = arg_4_0.info_.hero_list,
				combo = arg_4_0.info_.comboSkill
			})
		end)
	end

	arg_4_0:AddBtnListener(arg_4_0.saveBtn_, nil, function()
		if arg_4_0.info_.hero_list[1] == 0 then
			for iter_6_0, iter_6_1 in ipairs(arg_4_0.info_.hero_list) do
				if iter_6_1 ~= 0 then
					ShowTips("CAPTAIN_ROLE_MISSING")

					return
				end
			end

			ShowTips("TEAM_SET_NEEDED")
		elseif BattleTeamData:IsInList(arg_4_0.info_.index, arg_4_0.info_) then
			ShowTips("SAME_TEAM_PROHIBITED")
		elseif arg_4_0.info_.name ~= "" then
			BattleFieldAction.SaveReservesTeam(arg_4_0.info_.index, arg_4_0.info_.name, arg_4_0.info_.hero_list, arg_4_0.info_.comboSkill, arg_4_0.info_.chipInfo, "FORMATION_PLAN_SAVED")
		else
			arg_4_0.saveFlag_ = true

			JumpTools.OpenPageByJump("ProposalPopup")
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.renameBtn_, nil, function()
		arg_4_0.inputPopFlag_ = true

		JumpTools.OpenPageByJump("ProposalPopup")
	end)
	arg_4_0:AddBtnListener(arg_4_0.useBtn_, nil, function()
		if arg_4_0.changeFunc_ then
			arg_4_0.changeFunc_(arg_4_0.info_.index)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.delBtn_, nil, function()
		ShowMessageBox({
			content = string.format(GetTips("FORMATION_PLAN_DELETE_CONFIRM"), arg_4_0.info_.name),
			OkCallback = function()
				BattleFieldAction.DelectReservesTeam(arg_4_0.info_.index)
			end
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.chipBtn_, nil, function()
		JumpTools.GoToSystem("/reservesChipManager", {
			index = arg_4_0.info_.index
		}, ViewConst.SYSTEM_ID.CHIP_MANAGER)
	end)
	arg_4_0:AddBtnListener(arg_4_0.comboBtn_, nil, function()
		local var_12_0 = arg_4_0.info_.hero_list

		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			if iter_12_1 and iter_12_1 ~= 0 then
				JumpTools.OpenPageByJump("reservesComboSkillSelect", {
					heroList = arg_4_0.info_.hero_list,
					comboSkillID = arg_4_0.info_.comboSkill,
					index = arg_4_0.info_.index
				})

				return
			end
		end

		ShowTips("SKILL_WITHOUT_MEMBER")
	end)
end

function var_0_0.OnEnter(arg_13_0)
	return
end

function var_0_0.RefreshUI(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	arg_14_0.info_ = arg_14_1
	arg_14_0.indexText_.text = arg_14_1.index

	if arg_14_3 and arg_14_0.info_.hero_list[1] ~= 0 then
		if arg_14_2 then
			arg_14_0.btnCon_:SetSelectedState("cur")
		else
			arg_14_0.btnCon_:SetSelectedState("change")
		end

		arg_14_0.curCon_:SetSelectedState("false")
		SetActive(arg_14_0.btnPanel_, true)
	else
		local var_14_0 = true

		for iter_14_0, iter_14_1 in ipairs(arg_14_0.info_.hero_list) do
			if iter_14_1 ~= 0 then
				var_14_0 = false

				break
			end
		end

		if var_14_0 and arg_14_0.info_.chipInfo.id == 0 then
			SetActive(arg_14_0.btnPanel_, false)
		else
			arg_14_0.btnCon_:SetSelectedState("save")
			SetActive(arg_14_0.btnPanel_, true)
		end

		arg_14_0.curCon_:SetSelectedState(arg_14_2 and arg_14_4 and "true" or "false")
	end

	if arg_14_0.info_.name ~= "" then
		arg_14_0.title_.text = GetI18NText(arg_14_0.info_.name)

		arg_14_0.nameCon_:SetSelectedState("true")
	else
		if arg_14_2 then
			arg_14_0.curTitle_.text = GetTips("CURRENT_SCHEME")
		else
			arg_14_0.curTitle_.text = GetTips("NIL_NAME")
		end

		arg_14_0.nameCon_:SetSelectedState("false")
	end

	local var_14_1 = arg_14_0.info_.hero_list

	for iter_14_2, iter_14_3 in ipairs(var_14_1) do
		if iter_14_3 ~= 0 then
			local var_14_2 = HeroTools.HeroUsingSkinInfo(iter_14_3).id

			arg_14_0.heroImg_[iter_14_2].sprite = ItemTools.getItemSprite(var_14_2)

			SetActive(arg_14_0.heroGo_[iter_14_2], true)
			arg_14_0.campCon_[iter_14_2]:SetSelectedState(HeroCfg[iter_14_3].race)
		else
			SetActive(arg_14_0.heroGo_[iter_14_2], false)
		end
	end

	arg_14_0:RefreshChip()
	arg_14_0:RefreshComSkill()
end

function var_0_0.RefreshChip(arg_15_0)
	local var_15_0 = arg_15_0.info_.chipInfo.id

	if var_15_0 == 0 then
		arg_15_0.chipCon_:SetSelectedState(-1)
	else
		arg_15_0.chipIcon_.sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[var_15_0].picture_id)

		local var_15_1 = arg_15_0.info_.chipInfo.list

		arg_15_0.chipCon_:SetSelectedState(#var_15_1)
	end
end

function var_0_0.RefreshComSkill(arg_16_0)
	local var_16_0 = arg_16_0.info_.comboSkill

	if var_16_0 == 0 then
		arg_16_0.comboSkillCon_:SetSelectedState(0)
	else
		local var_16_1 = ComboSkillCfg[var_16_0]

		arg_16_0.comboImg_.sprite = getSpriteViaConfig("ComboSkill", var_16_1.skill_id)

		if #var_16_1.cooperate_role_ids == 3 then
			arg_16_0.comboSkillCon_:SetSelectedState("all")
		else
			local var_16_2 = {}
			local var_16_3 = arg_16_0.info_.hero_list

			for iter_16_0, iter_16_1 in ipairs(var_16_1.cooperate_role_ids) do
				table.insert(var_16_2, table.indexof(var_16_3, iter_16_1))
			end

			if not var_16_2[1] or not var_16_2[2] then
				return
			end

			if var_16_2[1] < var_16_2[2] then
				arg_16_0.comboSkillCon_:SetSelectedState(var_16_2[1] .. "_" .. var_16_2[2])
			else
				arg_16_0.comboSkillCon_:SetSelectedState(var_16_2[2] .. "_" .. var_16_2[1])
			end
		end
	end
end

function var_0_0.OnInput(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0.inputPopFlag_ and not arg_17_0.saveFlag_ then
		return
	end

	if not arg_17_0.gameObject_.activeInHierarchy then
		return
	end

	if arg_17_1 == "" then
		ShowTips("INPUT_EQUIP_PROPOSAL_NAME")

		return
	end

	if IsAllSpace(arg_17_1) then
		ShowTips("INPUT_CHAT_CONTENT")

		arg_17_2.text = ""

		return
	end

	local var_17_0, var_17_1 = textLimit(arg_17_1, GameSetting.user_name_max.value[1])

	arg_17_2.text = var_17_0
	arg_17_1 = var_17_0

	if not nameRule(arg_17_1) then
		ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

		arg_17_2.text = ""

		return
	end

	WordVerifyBySDK(arg_17_1, function(arg_18_0)
		if not arg_18_0 then
			ShowTips("SENSITIVE_WORD")

			arg_17_2.text = ""

			return
		else
			if not var_17_1 then
				return
			end

			if arg_17_0.saveFlag_ then
				BattleFieldAction.SaveReservesTeam(arg_17_0.info_.index, arg_17_1, arg_17_0.info_.hero_list, arg_17_0.info_.comboSkill, arg_17_0.info_.chipInfo, "FORMATION_PLAN_SAVED")
			else
				BattleFieldAction.SaveReservesTeam(arg_17_0.info_.index, arg_17_1, arg_17_0.info_.hero_list, arg_17_0.info_.comboSkill, arg_17_0.info_.chipInfo, "FORMATION_PLAN_NAME_CHANGED")
			end

			arg_17_0.inputPopFlag_ = false
			arg_17_0.saveFlag_ = false

			manager.notify:Invoke(INPUT_POP_BACK)
		end
	end, JUDGE_MESSAGE_TYPE.OTHER)
end

function var_0_0.RegistChangeBtn(arg_19_0, arg_19_1)
	arg_19_0.changeFunc_ = arg_19_1
end

function var_0_0.OnInputCancel(arg_20_0)
	arg_20_0.inputPopFlag_ = false
	arg_20_0.saveFlag_ = false
end

function var_0_0.OnComboSkillSelect(arg_21_0)
	arg_21_0.curCon_:SetSelectedState("false")
	arg_21_0:RefreshComSkill()
end

function var_0_0.OnExit(arg_22_0)
	return
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0:RemoveAllListeners()

	arg_23_0.inputPopFlag_ = false
	arg_23_0.saveFlag_ = false

	manager.notify:RemoveListener(INPUT_POP_CLICK_OK, arg_23_0.inputHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CLOSE, arg_23_0.inputCancelHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CANCEL, arg_23_0.inputCancelHandler_)
	manager.notify:RemoveListener(COMBO_SKILL_SELECT, arg_23_0.handler_)

	arg_23_0.inputHandler_ = nil
	arg_23_0.inputCancelHandler_ = nil

	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
