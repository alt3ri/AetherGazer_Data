local var_0_0 = class("HeroSkillPropertyView", HeroPageBase)
local var_0_1 = {
	showState = {
		max = "max",
		up = "up",
		notup = "notup",
		none = "none"
	}
}

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:CreateCostList()
	arg_2_0:AddUIListener()

	arg_2_0.stateController_ = arg_2_0.controllerexcollection_:GetController("state")
end

function var_0_0.CreateCostList(arg_3_0)
	arg_3_0.costItem = {}

	for iter_3_0 = 1, 4 do
		local var_3_0 = arg_3_0["costitem" .. iter_3_0 .. "Go_"]

		arg_3_0.costItem[iter_3_0] = CommonItemView.New(var_3_0)
	end

	arg_3_0.attrItemList = {}

	for iter_3_1 = 1, 4 do
		local var_3_1 = arg_3_0["attr" .. iter_3_1 .. "Go_"]

		arg_3_0.attrItemList[iter_3_1] = HeroSkillAttrItem.New(var_3_1)
	end
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddPressingByTimeListener(arg_4_0.upbtnBtn_.gameObject, 1.4, 0.2, 0.1, function()
		if not arg_4_0:isCanUpSkill() or arg_4_0.level + arg_4_0.tempAddLevel_ == HeroConst.MAX_SKILL_ATTR_LEVEL then
			arg_4_0:SendSkillAttrUpgrade()

			return false
		end

		if not arg_4_0.costEnough then
			arg_4_0:SendSkillAttrUpgrade()
			ShowTips("ERROR_HERO_NO_SKILL_UP_MAT")

			return false
		end

		arg_4_0.tempAddLevel_ = (arg_4_0.tempAddLevel_ or 0) + 1

		arg_4_0:SendSkillAttrUpgrade()
		arg_4_0:RefreshUi()

		return true
	end, handler(arg_4_0, arg_4_0.SendSkillAttrUpgrade))
	arg_4_0:AddBtnListener(arg_4_0.limitBtn_, nil, function()
		ShowTips("NOTE_SKILL_ATTR_LIMIT")
	end)
end

function var_0_0.isCanUpSkill(arg_7_0)
	if SkillTools.GetIsDodgeSkill(arg_7_0.skillId) or not arg_7_0.nextAttrCfg then
		return false
	end

	return true
end

function var_0_0.SendSkillAttrUpgrade(arg_8_0)
	if arg_8_0.tempAddLevel_ and arg_8_0.tempAddLevel_ > 0 then
		HeroAction.HeroSkillAttrUpgrade(arg_8_0.heroId, arg_8_0.skillIndex, arg_8_0.tempAddLevel_)
	end
end

function var_0_0.OnHeroSkillAttrUpgradeInView(arg_9_0, arg_9_1, arg_9_2)
	if isSuccess(arg_9_1.result) then
		ShowTips("SKILL_ATTR_UPGRATE_SUCCESS", string.format("LEVEL\n<size=60>%s</size>", arg_9_0.level))
		SetActive(arg_9_0.lvbgGo_, false)
		SetActive(arg_9_0.lvbgGo_, true)
		arg_9_0.switchIconAnimator_:Play("Fx_right_huan_change", -1, 0)
	else
		ShowTips(arg_9_1.result)
	end

	arg_9_0.tempAddLevel_ = 0

	arg_9_0:RefreshUi()
end

function var_0_0.UpdatePropertyData(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:InitData(arg_10_1)

	if arg_10_2 then
		arg_10_0.switchIconAnimator_:Play("Fx_right_huan_change", -1, 0)
	end

	arg_10_0.skilliconImg_.sprite = getSprite("Atlas/" .. arg_10_0.heroId, arg_10_0.realSkillId)

	if SkillTools.GetIsDodgeSkill(arg_10_0.skillId) then
		arg_10_0:RefreshAttrList()
		arg_10_0.stateController_:SetSelectedState(var_0_1.showState.none)
	else
		arg_10_0:RefreshUi()
	end
end

function var_0_0.InitData(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.id
	local var_11_1 = arg_11_1.heroId
	local var_11_2 = arg_11_0.heroViewDataProxy:GetRealSkillId(var_11_1, var_11_0)
	local var_11_3 = SkillTools.GetSkillIdIndex(var_11_0)

	arg_11_0.skillId = var_11_0
	arg_11_0.heroId = var_11_1
	arg_11_0.realSkillId = var_11_2
	arg_11_0.skillIndex = var_11_3
end

function var_0_0.OnEnter(arg_12_0, arg_12_1)
	arg_12_0.heroViewDataProxy = arg_12_1
	arg_12_0.tempAddLevel_ = 0
end

function var_0_0.RefreshUi(arg_13_0)
	local var_13_0 = arg_13_0.heroViewDataProxy:GetSkillAttrLv(arg_13_0.heroId, arg_13_0.skillIndex) + arg_13_0.tempAddLevel_

	arg_13_0.level = var_13_0
	arg_13_0.attrCfg = SkillTools.GetSkillAttrCfg(arg_13_0.heroId, arg_13_0.skillIndex, var_13_0)
	arg_13_0.nextAttrCfg = SkillTools.GetSkillAttrCfg(arg_13_0.heroId, arg_13_0.skillIndex, var_13_0 + 1)

	arg_13_0:RefreshCost()
	arg_13_0:RefreshAttrList()
	arg_13_0:UpdateUpStateController()

	arg_13_0.lvNowText_.text = arg_13_0.level
	arg_13_0.lvLaterText_.text = arg_13_0.level + 1
	arg_13_0.sliderSlr_.value = arg_13_0.heroViewDataProxy:GetSkillAtrrProgressValue(arg_13_0.heroId, arg_13_0.skillIndex, arg_13_0.level)
end

function var_0_0.UpdateUpStateController(arg_14_0)
	if not arg_14_0.heroViewDataProxy:CheckIsSelf() then
		arg_14_0.stateController_:SetSelectedState(var_0_1.showState.none)

		return
	end

	if arg_14_0:RefreshCondition() then
		arg_14_0.stateController_:SetSelectedState(var_0_1.showState.notup)
	elseif not arg_14_0.nextAttrCfg then
		arg_14_0.stateController_:SetSelectedState(var_0_1.showState.max)
	else
		arg_14_0.stateController_:SetSelectedState(var_0_1.showState.up)
	end
end

function var_0_0.RefreshCondition(arg_15_0)
	local var_15_0 = arg_15_0.skillIndex
	local var_15_1 = arg_15_0.heroViewDataProxy:GetHeroData(arg_15_0.heroId)
	local var_15_2 = arg_15_0.heroViewDataProxy:GetSkillLv(arg_15_0.heroId, arg_15_0.skillId)
	local var_15_3 = false

	if var_15_2 < HeroConst.MAX_SKILL_LEVEL then
		arg_15_0.conditiondescireText_.text = GetTips("NOTE_SKILL_ATTR_LIMIT")
		arg_15_0.conditionvalueText_.text = string.format("%s/%s", var_15_2, HeroConst.MAX_SKILL_LEVEL)
		var_15_3 = true
	end

	return var_15_3
end

function var_0_0.RefreshCost(arg_16_0)
	arg_16_0.costCfg = arg_16_0.nextAttrCfg and arg_16_0.nextAttrCfg.cost or nil
	arg_16_0.costEnough = true

	for iter_16_0 = 1, 4 do
		if arg_16_0.costCfg and arg_16_0.costCfg[iter_16_0] then
			arg_16_0.costItem[iter_16_0].gameObject_:SetActive(true)

			local var_16_0 = arg_16_0.costCfg[iter_16_0][1]
			local var_16_1 = arg_16_0.costCfg[iter_16_0][2]
			local var_16_2 = ItemTools.getItemNum(var_16_0)
			local var_16_3 = clone(ItemTemplateData)

			var_16_3.id = var_16_0
			var_16_3.number = var_16_1

			function var_16_3.clickFun(arg_17_0)
				ShowPopItem(POP_SOURCE_ITEM, {
					arg_17_0.id,
					arg_17_0.number
				})
			end

			arg_16_0.costItem[iter_16_0]:SetData(var_16_3)
			arg_16_0.costItem[iter_16_0]:RefreshBottomText({
				var_16_2,
				var_16_1
			})
			arg_16_0.costItem[iter_16_0]:RefreshBottomRightText(true)

			if var_16_2 < var_16_1 then
				arg_16_0.costEnough = false
			end
		else
			arg_16_0.costItem[iter_16_0].gameObject_:SetActive(false)
		end
	end
end

function var_0_0.RefreshAttrList(arg_18_0)
	local var_18_0 = {}
	local var_18_1 = arg_18_0:GetAttrDataList(var_18_0, true)
	local var_18_2 = arg_18_0:GetAttrDataList(var_18_1, false)
	local var_18_3 = {}

	for iter_18_0, iter_18_1 in pairs(var_18_2) do
		table.insert(var_18_3, iter_18_1)
	end

	table.sort(var_18_3, function(arg_19_0, arg_19_1)
		return arg_19_0.attrType < arg_19_1.attrType
	end)

	for iter_18_2, iter_18_3 in pairs(arg_18_0.attrItemList) do
		local var_18_4 = var_18_3[iter_18_2]

		if var_18_4 then
			SetActive(iter_18_3.gameObject_, true)
			iter_18_3:RefreshUI(var_18_4, arg_18_0.heroViewDataProxy:CheckIsSelf())
		else
			SetActive(iter_18_3.gameObject_, false)
		end
	end
end

function var_0_0.GetAttrDataList(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0

	if arg_20_2 then
		var_20_0 = arg_20_0.attrCfg
	else
		var_20_0 = arg_20_0.nextAttrCfg
	end

	if var_20_0 then
		for iter_20_0, iter_20_1 in pairs(var_20_0.attr) do
			local var_20_1 = iter_20_1[1]
			local var_20_2 = iter_20_1[2]

			if not arg_20_1[var_20_1] then
				arg_20_1[var_20_1] = {}
				arg_20_1[var_20_1].nowValue = 0
				arg_20_1[var_20_1].nextValue = 0
				arg_20_1[var_20_1].attrType = var_20_1
			end

			if arg_20_2 then
				arg_20_1[var_20_1].nowValue = var_20_2
			else
				arg_20_1[var_20_1].nextValue = var_20_2
			end
		end
	end

	return arg_20_1
end

function var_0_0.Dispose(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(arg_21_0.attrItemList or {}) do
		if iter_21_1 then
			iter_21_1:Dispose()
		end
	end

	for iter_21_2, iter_21_3 in pairs(arg_21_0.costItem or {}) do
		if iter_21_3 then
			iter_21_3:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
