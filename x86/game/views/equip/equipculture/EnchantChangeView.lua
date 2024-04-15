local var_0_0 = import("game.views.equip.equipCulture.EquipBaseView")
local var_0_1 = class("EnchantChangeView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Hero_equip/Develop/HeroEquipEnchant"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_1.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
	var_0_1.super.Init(arg_3_0)

	arg_3_0.max = GameSetting.equip_enchant_save_num.value[1] or 0
	arg_3_0.isLockedSkill_ = false
	arg_3_0.lockedIndex_ = nil
	arg_3_0.standardRatio_ = 0.09270833333333334
end

function var_0_1.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.skillPreItems_ = {}
	arg_4_0.items_ = {}
	arg_4_0.materialIndex = 1
	arg_4_0.skillPopView_ = EquipNewSkillInfoView.New(arg_4_0.equipSkillPopGo_)
	arg_4_0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
	arg_4_0.enchantScroller_ = LuaList.New(handler(arg_4_0, arg_4_0.indexPreviewItem), arg_4_0.enchantListGo_, EquipEnchantPreviewItem)
	arg_4_0.giveupController_ = arg_4_0.transCon_:GetController("allGiveup")
	arg_4_0.popController_ = arg_4_0.transCon_:GetController("pop")

	arg_4_0:InitFixedSkill()
	arg_4_0:InitMaterial()
end

function var_0_1.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnEnchant_, nil, function()
		arg_5_0:OnEnchantClick()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnGiveUp_, nil, function()
		if arg_5_0.enchantPreviewList and #arg_5_0.enchantPreviewList > 0 then
			EquipAction.QueryEquipGiveUpAllEnchant(arg_5_0.equipId, arg_5_0.enchatPos)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnHidePopMask_, nil, function()
		arg_5_0:HidePop()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnAccess_, nil, function()
		local var_9_0 = arg_5_0.materials_[arg_5_0.materialIndex]
		local var_9_1 = var_9_0.id
		local var_9_2 = ItemTools.getItemNum(var_9_0.id)

		ShowPopItem(POP_SOURCE_ITEM, {
			var_9_1,
			var_9_2
		})
	end)
end

function var_0_1.OnEnter(arg_10_0)
	arg_10_0.equipId = arg_10_0.params_.equipId
	arg_10_0.enchatPos = arg_10_0.params_.enchatPos
	arg_10_0.equipData = EquipData:GetEquipData(arg_10_0.equipId)
	arg_10_0.heroID_ = arg_10_0.equipData:GetEquipHero()
	arg_10_0.heroViewDataProxy_ = arg_10_0.params_.proxy

	arg_10_0:RefreshSkillData()
	arg_10_0:RefreshSelect()
	arg_10_0:RefreshUI()
	arg_10_0:ShowBar()
	arg_10_0:RegistEventListener(CURRENCY_UPDATE, handler(arg_10_0, arg_10_0.OnGoldChange))
	arg_10_0:RegistEventListener(MATERIAL_MODIFY, handler(arg_10_0, arg_10_0.OnMaterialModify))
end

function var_0_1.ShowBar(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
end

function var_0_1.RefreshSkillData(arg_12_0)
	arg_12_0.skillList_ = {}

	if arg_12_0.heroID_ and arg_12_0.heroViewDataProxy_ then
		local var_12_0 = arg_12_0.heroViewDataProxy_:GetEquipDataList(arg_12_0.heroID_)
		local var_12_1 = HeroData:GetHeroData(arg_12_0.heroID_)
		local var_12_2, var_12_3, var_12_4 = EquipTools.CountHeroTotalSkill(var_12_0, var_12_1, true)

		for iter_12_0, iter_12_1 in pairs(var_12_2) do
			arg_12_0.skillList_[iter_12_0] = {
				id = iter_12_0,
				num = iter_12_1,
				isAdd = var_12_3,
				location = var_12_4[iter_12_0]
			}
		end
	end
end

function var_0_1.InitFixedSkill(arg_13_0)
	arg_13_0.fixedSkills = {}

	for iter_13_0 = 1, 2 do
		local var_13_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_13_0, arg_13_0["enchantSkill_" .. iter_13_0])

		var_13_0.selectController_ = var_13_0.transCon_:GetController("select")
		var_13_0.lockController_ = var_13_0.transCon_:GetController("lock")
		var_13_0.nullController_ = var_13_0.transCon_:GetController("null")

		arg_13_0:AddBtnListener(var_13_0.btnLock_, nil, function()
			arg_13_0:OnLockClick(iter_13_0)
		end)
		arg_13_0:AddBtnListener(var_13_0.btnInfo_, nil, function()
			if var_13_0.isSkill then
				arg_13_0:OnSkillClick(var_13_0, arg_13_0.skillList_[var_13_0.id], iter_13_0)
			end
		end)
		table.insert(arg_13_0.fixedSkills, var_13_0)
	end
end

function var_0_1.InitMaterial(arg_16_0)
	arg_16_0.materials_ = EquipData:GetEnchantMaterial()
	arg_16_0.showLockMaterials_ = EquipData:GetLockEnchantMaterial()
	arg_16_0.materialGoList_ = {}

	for iter_16_0 = 1, #arg_16_0.materials_ do
		local var_16_0 = CommonItemView.New(arg_16_0["material_" .. iter_16_0])
		local var_16_1 = clone(ItemTemplateData)

		var_16_1.id = arg_16_0.materials_[iter_16_0].id
		var_16_1.number = nil

		function var_16_1.clickFun()
			if arg_16_0.isLockedSkill_ then
				-- block empty
			else
				arg_16_0:OnMarerialChange(iter_16_0)
			end
		end

		var_16_0:SetData(var_16_1)

		arg_16_0.materialGoList_[iter_16_0] = var_16_0
	end
end

function var_0_1.RefreshSelect(arg_18_0)
	local var_18_0 = EquipData:GetIsSetLockView(arg_18_0.equipId, arg_18_0.enchatPos)

	if var_18_0 then
		arg_18_0.fixedSkills[var_18_0].lockController_:SetSelectedState("lock")
		arg_18_0:OnMarerialChange(3)

		arg_18_0.isLockedSkill_ = true
		arg_18_0.lockedIndex_ = var_18_0

		arg_18_0:RreshMateriaMoney()
	else
		arg_18_0.fixedSkills[1].lockController_:SetSelectedState("unlock")
		arg_18_0.fixedSkills[2].lockController_:SetSelectedState("unlock")

		arg_18_0.materialIndex = EquipData:GetSelectEnchantMaterialIndex()

		arg_18_0:OnMarerialChange(arg_18_0.materialIndex)
	end
end

function var_0_1.RefreshUI(arg_19_0)
	arg_19_0:RreshMaterialUI()
	arg_19_0:RreshFixedSkill()
	arg_19_0:RefreshBottom()
end

function var_0_1.RreshMaterialUI(arg_20_0)
	local var_20_0 = arg_20_0.materialGoList_

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		local var_20_1 = arg_20_0.materials_[iter_20_0]
		local var_20_2 = arg_20_0.showLockMaterials_[iter_20_0]
		local var_20_3 = ItemTools.getItemNum(var_20_1.id)
		local var_20_4 = arg_20_0.isLockedSkill_ and var_20_2.number or var_20_1.number

		iter_20_1:RefreshBottomText({
			var_20_3,
			var_20_4
		})
		iter_20_1:RefreshLock(arg_20_0.isLockedSkill_ and not var_20_2.lock or false)
	end
end

function var_0_1.RreshFixedSkill(arg_21_0, arg_21_1)
	local var_21_0 = EquipData:GetEquipData(arg_21_0.equipId).enchant[arg_21_0.enchatPos] or {}

	if arg_21_1 then
		arg_21_0.glowAnim_:Play("glow_bg")
	end

	arg_21_0.fixedSkillIds_ = {}

	for iter_21_0 = 1, 2 do
		local var_21_1 = var_21_0[iter_21_0]
		local var_21_2 = arg_21_0.fixedSkills[iter_21_0]

		if var_21_1 then
			var_21_2.id = var_21_1.id

			local var_21_3 = EquipSkillCfg[var_21_1.id]
			local var_21_4 = arg_21_0.skillList_[var_21_1.id] and arg_21_0.skillList_[var_21_1.id].num or var_21_1.num

			arg_21_0.fixedSkillIds_[var_21_1.id] = arg_21_0.fixedSkillIds_[var_21_1.id] and arg_21_0.fixedSkillIds_[var_21_1.id] + 1 or 1

			local var_21_5 = var_21_4 > var_21_3.lvmax and string.format("<color=#FF000B>%s</color>", var_21_4) or var_21_4

			var_21_2.num_.text = string.format("%s/%s", var_21_5, var_21_3.lvmax)

			local var_21_6 = var_21_4 > var_21_3.lvmax and var_21_3.lvmax or var_21_4
			local var_21_7 = var_21_3.upgrade / var_21_3.percent * var_21_6
			local var_21_8 = GetCfgDescriptionWithValue(var_21_3.desc[1], tostring(var_21_7))

			if var_21_3.desc_spec_value ~= nil and var_21_3.desc_spec_value ~= "" then
				var_21_8 = string.gsub(var_21_8, tostring(var_21_7), var_21_3.desc_spec_value[arg_21_0.cfg_.num])
			end

			var_21_2.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. var_21_3.icon)
			var_21_2.name_.text = GetI18NText(var_21_3.name)
			var_21_2.desc_.text = var_21_8

			var_21_2.nullController_:SetSelectedState("skill")

			var_21_2.isSkill = true
		else
			var_21_2.isSkill = false

			var_21_2.nullController_:SetSelectedState("null")
		end
	end
end

function var_0_1.RefreshBottom(arg_22_0, arg_22_1)
	arg_22_0.enchantPreviewList = EquipData:GetEquipData(arg_22_0.equipId).enchant_preview[arg_22_0.enchatPos]
	arg_22_0.enchantNum_.text = string.format(GetTips("ENCHANT_PREVIEW_NUM"), #arg_22_0.enchantPreviewList, arg_22_0.max)

	arg_22_0.giveupController_:SetSelectedState(#arg_22_0.enchantPreviewList == 0 and "off" or "on")

	if arg_22_1 then
		if arg_22_1.scrollToIndex then
			local var_22_0 = math.max(0, #arg_22_0.enchantPreviewList)

			arg_22_0:ShowGlowAnim(var_22_0)

			local var_22_1 = math.max(0, var_22_0 - 1)

			arg_22_0.enchantScroller_:ScrollToIndex(var_22_1, true, true)
		elseif arg_22_1.keepScrollPos then
			arg_22_0.enchantScroller_:StartScrollByPosition(arg_22_0.max, arg_22_0.enchantScroller_:GetScrolledPosition())
		end
	else
		arg_22_0.enchantScroller_:StartScroll(arg_22_0.max)
	end
end

function var_0_1.indexPreviewItem(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0.enchantPreviewList[arg_23_1] or {}

	arg_23_2:Refresh(var_23_0, arg_23_0.skillList_, arg_23_0.equipId, arg_23_0.enchatPos, arg_23_1, arg_23_0.fixedSkillIds_)
	arg_23_2:RegistSkillClickCallBck(handler(arg_23_0, arg_23_0.OnSkillClick))
end

function var_0_1.ShowGlowAnim(arg_24_0, arg_24_1)
	local var_24_0
	local var_24_1 = arg_24_1

	var_24_0 = FrameTimer.New(function()
		local var_25_0 = arg_24_0.enchantScroller_:GetItemByIndex(var_24_1)

		if var_25_0 ~= nil then
			var_25_0:ShowAnim()
		end

		var_24_0:Stop()
	end, 20, 1)

	var_24_0:Start()
end

function var_0_1.OnSkillClick(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0.skillPopView_:RefreshData(arg_26_0, arg_26_2, true)

	arg_26_0.selectedSkillItem_ = arg_26_1

	arg_26_0.selectedSkillItem_.selectController_:SetSelectedIndex(1)

	local var_26_0 = arg_26_0.transform:InverseTransformPoint(arg_26_1.transform.position)
	local var_26_1 = var_26_0.x / Screen.width <= arg_26_0.standardRatio_ and var_26_0.x + 500 or var_26_0.x - 500

	arg_26_0.equipSkillPopGo_.transform.localPosition = Vector3(var_26_1, -20, 0)

	arg_26_0.popController_:SetSelectedState("on")
end

function var_0_1.HidePop(arg_27_0)
	if arg_27_0.selectedSkillItem_ then
		arg_27_0.selectedSkillItem_.selectController_:SetSelectedIndex(0)

		arg_27_0.selectedSkillItem_ = nil
	end

	arg_27_0.popController_:SetSelectedState("off")
end

function var_0_1.OnMarerialChange(arg_28_0, arg_28_1)
	if arg_28_0.isLockedSkill_ then
		return
	end

	arg_28_0.materialIndex = arg_28_1

	EquipData:SetSelectEnchantMaterialIndex(arg_28_1)
	arg_28_0:RreshMateriaMoney()

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.materialGoList_) do
		iter_28_1:RefreshSelectState2(iter_28_0 == arg_28_0.materialIndex)
	end
end

function var_0_1.RreshMateriaMoney(arg_29_0)
	local var_29_0 = arg_29_0.isLockedSkill_ and arg_29_0.showLockMaterials_[arg_29_0.materialIndex] or arg_29_0.materials_[arg_29_0.materialIndex]
	local var_29_1 = var_29_0.money
	local var_29_2 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)
	local var_29_3 = tostring(var_29_1)

	if var_29_2 < var_29_1 then
		var_29_3 = "<color='#FF0000'>" .. var_29_3 .. "</color>"
	end

	arg_29_0.costNum_.text = var_29_3

	local var_29_4 = var_29_0.id
	local var_29_5 = ItemCfg[var_29_4]

	if arg_29_0.isLockedSkill_ then
		arg_29_0.materialText_.text = GetTips("EQUIP_SKILL_LOCK_DES")
	else
		arg_29_0.materialText_.text = var_29_5 and ItemTools.getItemDesc(var_29_4) or ""
	end
end

function var_0_1.OnEnchantClick(arg_30_0)
	arg_30_0.enchantPreviewList = EquipData:GetEquipData(arg_30_0.equipId).enchant_preview[arg_30_0.enchatPos]

	if arg_30_0.max <= #arg_30_0.enchantPreviewList then
		ShowTips("EQUIP_ENCHANT_RESULT_NUM_MAX")

		return
	end

	local var_30_0 = arg_30_0.equipId
	local var_30_1 = arg_30_0.enchatPos
	local var_30_2 = arg_30_0.materials_[arg_30_0.materialIndex]
	local var_30_3 = 0

	if arg_30_0.isLockedSkill_ then
		var_30_3 = arg_30_0.lockedIndex_
		var_30_2 = arg_30_0.showLockMaterials_[arg_30_0.materialIndex]
	end

	EquipAction.QueryEquipEnchant(var_30_0, var_30_1, var_30_2, var_30_3)
end

function var_0_1.OnEquipEnchant(arg_31_0)
	arg_31_0:RreshMaterialUI()
	arg_31_0:RreshMateriaMoney()
	arg_31_0:RefreshBottom({
		scrollToIndex = true
	})
end

function var_0_1.OnEquipEnchantConfirm(arg_32_0, arg_32_1)
	arg_32_0:RefreshSkillData()
	arg_32_0:RreshFixedSkill(arg_32_1)

	if arg_32_1 then
		-- block empty
	end

	local var_32_0 = {
		keepScrollPos = true
	}

	arg_32_0:RefreshBottom(var_32_0)
end

function var_0_1.OnEquipEnchantGiveUp(arg_33_0)
	arg_33_0:RefreshBottom()
end

function var_0_1.OnGoldChange(arg_34_0, arg_34_1)
	if arg_34_1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		arg_34_0:RreshMateriaMoney()
	end
end

function var_0_1.OnMaterialModify(arg_35_0, arg_35_1)
	local var_35_0 = 606

	if ItemCfg[arg_35_1].sub_type == var_35_0 then
		arg_35_0:RreshMaterialUI()
	end
end

function var_0_1.OnLockClick(arg_36_0, arg_36_1)
	if arg_36_0.isLockedSkill_ then
		if arg_36_0.lockedIndex_ then
			if arg_36_0.lockedIndex_ == arg_36_1 then
				arg_36_0.fixedSkills[arg_36_0.lockedIndex_].lockController_:SetSelectedState("unlock")

				arg_36_0.isLockedSkill_ = false
				arg_36_0.lockedIndex_ = nil
				arg_36_0.materialIndex = 3

				EquipData:SetEnchatLockIndex(0, 0, 0)
			elseif #arg_36_0.enchantPreviewList > 0 then
				ShowTips(GetTips("EQUIP_SKILL_LOCK_ENCHANT_EMPTY"))
			else
				arg_36_0.fixedSkills[arg_36_0.lockedIndex_].lockController_:SetSelectedState("unlock")
				arg_36_0.fixedSkills[arg_36_1].lockController_:SetSelectedState("lock")

				arg_36_0.lockedIndex_ = arg_36_1

				EquipData:SetEnchatLockIndex(arg_36_0.equipId, arg_36_0.enchatPos, arg_36_0.lockedIndex_)
			end
		end
	elseif #arg_36_0.enchantPreviewList > 0 then
		ShowTips(GetTips("EQUIP_SKILL_LOCK_ENCHANT_EMPTY"))
	else
		arg_36_0.fixedSkills[arg_36_1].lockController_:SetSelectedState("lock")
		arg_36_0:OnMarerialChange(3)

		arg_36_0.isLockedSkill_ = true
		arg_36_0.lockedIndex_ = arg_36_1

		EquipData:SetEnchatLockIndex(arg_36_0.equipId, arg_36_0.enchatPos, arg_36_0.lockedIndex_)
	end

	arg_36_0:RreshMaterialUI()
	arg_36_0:RreshMateriaMoney()
end

function var_0_1.OnExit(arg_37_0)
	manager.windowBar:HideBar()
	arg_37_0:HidePop()
	arg_37_0:RemoveAllEventListener()

	arg_37_0.isLockedSkill_ = false
	arg_37_0.lockedIndex_ = nil

	for iter_37_0, iter_37_1 in pairs(arg_37_0.fixedSkills) do
		iter_37_1.lockController_:SetSelectedState("unlock")
	end
end

function var_0_1.Dispose(arg_38_0)
	arg_38_0.enchantScroller_:Dispose()
	arg_38_0.skillPopView_:Dispose()

	for iter_38_0, iter_38_1 in pairs(arg_38_0.materialGoList_) do
		iter_38_1:Dispose()
	end

	var_0_1.super.Dispose(arg_38_0)
end

return var_0_1
