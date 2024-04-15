local var_0_0 = class("WeaponModuleLevelUpView", ReduxView)
local var_0_1 = "F6302F"

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_module/HeroModuleUpgradeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.attributeItems_ = {}
	arg_4_0.conditionItems_ = {}
	arg_4_0.costItems_ = {}

	for iter_4_0 = 1, 3 do
		arg_4_0.costItems_[iter_4_0] = CommonItemView.New(arg_4_0["itemGo" .. iter_4_0 .. "_"])
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.unlockBtn_, nil, function()
		if arg_5_0.conditionList_ and arg_5_0.conditionList_[1] then
			for iter_6_0, iter_6_1 in pairs(arg_5_0.conditionList_) do
				if not IsConditionAchieved(iter_6_1, {
					heroId = arg_5_0.heroID_
				}) then
					ShowTips("WEAPON_MODULE_UNLOCK_CONDITION_NOT_FINISH")

					return
				end
			end
		end

		local var_6_0 = WeaponModuleCfg[arg_5_0.heroID_].cost[HeroData:GetCurModuleLevel(arg_5_0.heroID_) + 1]
		local var_6_1 = {}

		for iter_6_2, iter_6_3 in pairs(var_6_0) do
			if iter_6_3[1] ~= 2 then
				table.insert(var_6_1, iter_6_3)
			end
		end

		for iter_6_4, iter_6_5 in pairs(var_6_1) do
			if iter_6_5[2] > ItemTools.getItemNum(iter_6_5[1]) then
				ShowTips("WEAPON_MODULE_UNLOCK_NOT_ENOUGH")

				return
			end
		end

		if not checkGold(arg_5_0.cost_, true) then
			return
		end

		HeroAction.TryToLevelUpModule(arg_5_0.heroID_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.astrolabeinfoBtn_, nil, function()
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in pairs(arg_5_0.effects_) do
			if WeaponModuleEffectCfg[iter_7_1].type == 3 then
				table.insert(var_7_0, iter_7_1)
			end
		end

		JumpTools.OpenPageByJump("weaponModuleGodInfoView", {
			effectList = var_7_0,
			heroID = arg_5_0.heroID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.servantinfoBtn_, nil, function()
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs(arg_5_0.effects_) do
			if WeaponModuleEffectCfg[iter_8_1].type == 3 then
				table.insert(var_8_0, iter_8_1)
			end
		end

		JumpTools.OpenPageByJump("weaponModuleServantInfoView", {
			effectList = var_8_0,
			heroID = arg_5_0.heroID_
		})
	end)
end

function var_0_0.OnEnter(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetGameHelpKey("WEAPON_MODULE_DESCRIPE")

	arg_9_0.lockController_ = arg_9_0.controllerEx_:GetController("lock")
	arg_9_0.heroID_ = arg_9_0.params_.heroID

	arg_9_0:RefreshUI()
end

function var_0_0.OnTop(arg_10_0)
	local var_10_0

	if checkGold(arg_10_0.cost_, false) then
		var_10_0 = "<color=#D2D9E1>" .. arg_10_0.cost_ .. "</color>"
	else
		var_10_0 = "<color=#F6302F>" .. arg_10_0.cost_ .. "</color>"
	end

	arg_10_0.goldNum_.text = var_10_0
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = WeaponModuleCfg[arg_11_0.params_.heroID]

	arg_11_0.nameText_.text = GetI18NText(var_11_0.name)

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.titleTrans_)

	arg_11_0.moduleImage_.sprite = getSpriteWithoutAtlas("TextureConfig/WeaponModule/" .. arg_11_0.heroID_)

	local var_11_1 = HeroData:GetCurModuleLevel(arg_11_0.heroID_)

	arg_11_0.curLevelText_.text = var_11_1
	arg_11_0.nextLevelText_.text = var_11_1 + 1

	arg_11_0:RefreshDes()

	arg_11_0.conditionList_ = var_11_0.condition[HeroData:GetCurModuleLevel(arg_11_0.heroID_) + 1]
	arg_11_0.conditionSourceList_ = var_11_0.condition_source[HeroData:GetCurModuleLevel(arg_11_0.heroID_) + 1]

	arg_11_0:RefreshCondition()
	arg_11_0:RefreshCost()
	arg_11_0:RefreshBtn()
end

function var_0_0.RefreshDes(arg_12_0)
	arg_12_0.effects_ = WeaponModuleCfg[arg_12_0.params_.heroID].skill[HeroData:GetCurModuleLevel(arg_12_0.heroID_) + 1]

	local var_12_0, var_12_1, var_12_2, var_12_3 = HeroTools.GetModuleAllDes(arg_12_0.effects_, arg_12_0.heroID_)

	if var_12_0 == nil then
		SetActive(arg_12_0.attrGo_, false)
	else
		SetActive(arg_12_0.attrGo_, true)
		arg_12_0:RefreshAttriItems(var_12_0)
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.attrGo_.transform)
	end

	if var_12_1 == nil then
		SetActive(arg_12_0.skillGo_, false)
	else
		SetActive(arg_12_0.skillGo_, true)

		arg_12_0.skillText_.text = var_12_1

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.skillGo_.transform)
	end

	if var_12_2 == nil then
		SetActive(arg_12_0.astrolabeGo_, false)
	else
		SetActive(arg_12_0.astrolabeGo_, true)

		arg_12_0.astrolabeText_.text = var_12_2

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.astrolabeGo_.transform)
	end

	if var_12_3 == nil then
		SetActive(arg_12_0.servantGo_, false)
	else
		SetActive(arg_12_0.servantGo_, true)

		arg_12_0.servantText_.text = var_12_3

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.servantGo_.transform)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.contentTrans_)

	arg_12_0.contentTrans_.localPosition = Vector3.New(0, 0, 0)
end

function var_0_0.RefreshAttriItems(arg_13_0, arg_13_1)
	local var_13_0 = HeroTools.MergeModuleAttribute(arg_13_1)
	local var_13_1 = 1

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		if arg_13_0.attributeItems_[var_13_1] == nil then
			local var_13_2 = GameObject.Instantiate(arg_13_0.attriItemGo_, arg_13_0.attriItemTrans_)

			arg_13_0.attributeItems_[var_13_1] = WeaponModuleAttributeItem.New(var_13_2)
		end

		arg_13_0.attributeItems_[var_13_1]:SetData(iter_13_0, iter_13_1)

		var_13_1 = var_13_1 + 1
	end

	for iter_13_2, iter_13_3 in pairs(arg_13_0.attributeItems_) do
		if iter_13_2 < var_13_1 then
			arg_13_0.attributeItems_[iter_13_2]:SetIsShow(true)
		else
			arg_13_0.attributeItems_[iter_13_2]:SetIsShow(false)
		end
	end
end

function var_0_0.RefreshCondition(arg_14_0)
	if arg_14_0.conditionList_ and arg_14_0.conditionList_[1] then
		SetActive(arg_14_0.conditonParent_.gameObject, true)

		for iter_14_0, iter_14_1 in pairs(arg_14_0.conditionList_) do
			if arg_14_0.conditionItems_[iter_14_0] then
				arg_14_0.conditionItems_[iter_14_0]:SetData(iter_14_1, arg_14_0.heroID_, arg_14_0.conditionSourceList_[iter_14_0])
			else
				local var_14_0 = GameObject.Instantiate(arg_14_0.conditonGo_, arg_14_0.conditonParent_)

				arg_14_0.conditionItems_[iter_14_0] = WeaponModuleConditionItem.New(var_14_0)

				arg_14_0.conditionItems_[iter_14_0]:SetData(iter_14_1, arg_14_0.heroID_, arg_14_0.conditionSourceList_[iter_14_0])
			end
		end

		local var_14_1 = #arg_14_0.conditionList_

		for iter_14_2, iter_14_3 in pairs(arg_14_0.conditionItems_) do
			if var_14_1 < iter_14_2 then
				iter_14_3:SetIsShow(false)
			else
				iter_14_3:SetIsShow(true)
			end
		end
	else
		SetActive(arg_14_0.conditonParent_.gameObject, false)
	end
end

function var_0_0.RefreshCost(arg_15_0)
	local var_15_0 = WeaponModuleCfg[arg_15_0.heroID_].cost[HeroData:GetCurModuleLevel(arg_15_0.heroID_) + 1]
	local var_15_1 = {}

	arg_15_0.cost_ = 0

	for iter_15_0, iter_15_1 in pairs(var_15_0) do
		if iter_15_1[1] == 2 then
			arg_15_0.cost_ = iter_15_1[2]

			local var_15_2

			if checkGold(arg_15_0.cost_, false) then
				var_15_2 = "<color=#D2D9E1>" .. iter_15_1[2] .. "</color>"
			else
				var_15_2 = "<color=#F6302F>" .. iter_15_1[2] .. "</color>"
			end

			arg_15_0.goldNum_.text = var_15_2
		else
			table.insert(var_15_1, iter_15_1)
		end
	end

	for iter_15_2, iter_15_3 in pairs(var_15_1) do
		local var_15_3 = iter_15_3[2]
		local var_15_4 = ItemTools.getItemNum(iter_15_3[1])
		local var_15_5 = clone(ItemTemplateData)

		var_15_5.id = iter_15_3[1]
		var_15_5.bottomText = {
			var_15_4,
			var_15_3,
			var_15_4 < var_15_3 and var_0_1 or nil
		}
		var_15_5.hideBottomRightTextFlag = true

		function var_15_5.clickFun()
			ShowPopItem(POP_SOURCE_ITEM, {
				iter_15_3[1],
				iter_15_3[2]
			})
		end

		arg_15_0.costItems_[iter_15_2]:SetData(var_15_5)
	end

	for iter_15_4 = 1, 3 do
		if iter_15_4 > #var_15_1 then
			arg_15_0.costItems_[iter_15_4]:Show(false)
		else
			arg_15_0.costItems_[iter_15_4]:Show(true)
		end
	end
end

function var_0_0.RefreshBtn(arg_17_0)
	arg_17_0.lockController_:SetSelectedIndex(1)

	if not HeroData:GetModuleAssignmentIsFinish(arg_17_0.heroID_) then
		return
	end

	if arg_17_0.conditionList_ and arg_17_0.conditionList_[1] then
		for iter_17_0, iter_17_1 in pairs(arg_17_0.conditionList_) do
			if not IsConditionAchieved(iter_17_1, {
				heroId = arg_17_0.heroID_
			}) then
				return
			end
		end
	end

	local var_17_0 = WeaponModuleCfg[arg_17_0.heroID_].cost[HeroData:GetCurModuleLevel(arg_17_0.heroID_) + 1]
	local var_17_1 = {}

	for iter_17_2, iter_17_3 in pairs(var_17_0) do
		if iter_17_3[1] ~= 2 then
			table.insert(var_17_1, iter_17_3)
		end
	end

	for iter_17_4, iter_17_5 in pairs(var_17_1) do
		if iter_17_5[2] > ItemTools.getItemNum(iter_17_5[1]) then
			return
		end
	end

	arg_17_0.lockController_:SetSelectedIndex(0)
end

function var_0_0.OnExit(arg_18_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.attributeItems_) do
		iter_19_1:Dispose()
	end

	for iter_19_2, iter_19_3 in pairs(arg_19_0.conditionItems_) do
		iter_19_3:Dispose()
	end

	for iter_19_4, iter_19_5 in pairs(arg_19_0.costItems_) do
		iter_19_5:Dispose()
	end

	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
