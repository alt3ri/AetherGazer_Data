local var_0_0 = class("EnchantmentInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Stage/EnchantmentStageUI"
end

local function var_0_1(arg_2_0, arg_2_1)
	local var_2_0 = GameSetting.fm_stage_unlock.value[arg_2_0]

	if var_2_0 <= PlayerData:GetPlayerInfo().userLevel then
		return false
	end

	if arg_2_1 then
		ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_2_0))
	end

	return true
end

local var_0_2 = GameSetting.fm_free_refresh_limit_count.value[1]
local var_0_3 = GameSetting.fm_item_refresh_limit_count.value[1]
local var_0_4 = GameSetting.fm_item_refresh_cost.value
local var_0_5 = GameSetting.fm_stage_unlock.value[1]
local var_0_6 = GameSetting.fm_get_refresh_count.value[1]

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0.selectedDifficulty_ = 1
	arg_4_0.itemS = {}
	arg_4_0.isBtnActive_ = false

	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.btnCon_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "btnCon")
	arg_5_0.diffCon_ = ControllerUtil.GetController(arg_5_0.selectdifficultbtnBtn_.transform, "conName")
	arg_5_0.diffCon1 = ControllerUtil.GetController(arg_5_0.levelbtn1.transform, "conName")
	arg_5_0.diffCon2 = ControllerUtil.GetController(arg_5_0.levelbtn2.transform, "conName")
	arg_5_0.diffCon3 = ControllerUtil.GetController(arg_5_0.levelbtn3.transform, "conName")

	for iter_5_0 = 1, 3 do
		arg_5_0.itemS[iter_5_0] = EnchantmentItemView.New(arg_5_0["item" .. iter_5_0 .. "Go_"], arg_5_0.commonitemsmallGo_, handler(arg_5_0, arg_5_0.ShowAffixInfo))
	end
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.buyBtn_, nil, function()
		local var_7_0 = BattleEnchantmentData:GetData()
		local var_7_1 = GameSetting.fm_item_refresh_cost.value[var_7_0.allRefreshedTimes + 1][2]

		if not checkMoney(var_7_1) then
			return
		end

		if _G.SkipTip.SkipEnchantmentRefreshTip then
			BattleEnchantAction.EnchantmentRefresh(2, GameSetting.fm_item_refresh_cost.value[var_7_0.allRefreshedTimes + 1])

			return
		end

		local var_7_2 = false

		ShowMessageBox({
			title = "Warning!",
			content = {
				GetTips("WHETHER_TO_CONSUME"),
				{
					CurrencyConst.CURRENCY_TYPE_DIAMOND,
					var_7_1
				},
				(GetTips("ENCHANTMENT_STAGE_REFRESH_ONCE"))
			},
			OkCallback = function()
				BattleEnchantAction.EnchantmentRefresh(2, GameSetting.fm_item_refresh_cost.value[var_7_0.allRefreshedTimes + 1])

				_G.SkipTip.SkipEnchantmentRefreshTip = var_7_2
			end,
			ToggleCallback = function(arg_9_0)
				var_7_2 = arg_9_0
			end
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.freeBtn_, nil, function()
		local var_10_0 = SettingData:GetRemindSettingData()

		if not _G.SkipTip.SkipRefreshEnchantmentTimesTip and var_10_0.refresh_enchantment_times_reminder == 1 then
			local var_10_1 = false
			local var_10_2 = BattleEnchantmentData:GetData().enchantmentBattleList

			for iter_10_0, iter_10_1 in ipairs(var_10_2) do
				if StageGroupCfg[iter_10_1].level >= 3 then
					var_10_1 = true

					break
				end
			end

			if var_10_1 then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("EQUIP_STAGE_REFRESH"),
					OkCallback = function()
						_G.SkipTip.SkipRefreshEnchantmentTimesTip = arg_6_0.SkipRefreshEnchantmentTimesTip_

						BattleEnchantAction.EnchantmentRefresh(1)
					end,
					ToggleCallback = function(arg_12_0)
						arg_6_0.SkipRefreshEnchantmentTimesTip_ = arg_12_0
					end
				})

				return
			end
		end

		BattleEnchantAction.EnchantmentRefresh(1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:RefreshDifficultButton()
	end)
	arg_6_0:AddBtnListener(arg_6_0.selectdifficultbtnBtn_, nil, function()
		arg_6_0:RefreshDifficultButton()
	end)
	arg_6_0:AddBtnListener(arg_6_0.levelbtn1, nil, function()
		if var_0_1(1, true) then
			arg_6_0:RefreshDifficultButton()

			return
		end

		BattleEnchantAction.SetSelectLevel(1)

		arg_6_0.selectedDifficulty_ = 1

		arg_6_0:RefreshDifficultButton()
		arg_6_0:RefreshContent()
	end)
	arg_6_0:AddBtnListener(arg_6_0.levelbtn2, nil, function()
		if var_0_1(2, true) then
			arg_6_0:RefreshDifficultButton()

			return
		end

		BattleEnchantAction.SetSelectLevel(2)

		arg_6_0.selectedDifficulty_ = 2

		arg_6_0:RefreshDifficultButton()
		arg_6_0:RefreshContent()
	end)
	arg_6_0:AddBtnListener(arg_6_0.levelbtn3, nil, function()
		if var_0_1(3, true) then
			arg_6_0:RefreshDifficultButton()

			return
		end

		BattleEnchantAction.SetSelectLevel(3)

		arg_6_0.selectedDifficulty_ = 3

		arg_6_0:RefreshDifficultButton()
		arg_6_0:RefreshContent()
	end)
end

function var_0_0.OnTop(arg_18_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetGameHelpKey("ENCHANTMENT_DESCRIPE")
end

function var_0_0.OnEnter(arg_19_0)
	arg_19_0.isBtnActive_ = true
	arg_19_0.tipText_.text = string.format(GetTips("TIME_DISPLAY_2"), TimeMgr:DescCDTime(arg_19_0:during()))
	arg_19_0.selectedDifficulty_ = BattleEnchantAction.GetSelectLevel()

	if arg_19_0.selectedDifficulty_ == 0 then
		for iter_19_0 = 1, 3 do
			if not var_0_1(iter_19_0) and iter_19_0 > arg_19_0.selectedDifficulty_ then
				arg_19_0.selectedDifficulty_ = iter_19_0
			end
		end

		BattleEnchantAction.SetSelectLevel(arg_19_0.selectedDifficulty_)
	end

	arg_19_0:RefreshDiffBtn()
	arg_19_0:RefreshDifficultButton()
	arg_19_0:RefreshUI()
end

function var_0_0.OnExit(arg_20_0)
	if arg_20_0.timer_ then
		arg_20_0.timer_:Stop()

		arg_20_0.timer_ = nil
	end

	if arg_20_0.countdownTimer_ then
		arg_20_0.countdownTimer_:Stop()

		arg_20_0.countdownTimer_ = nil
	end

	manager.windowBar:HideBar()
end

function var_0_0.OnEnchantmentRefresh(arg_21_0)
	arg_21_0:RefreshUI()
end

function var_0_0.OnEnchantmentInit(arg_22_0)
	arg_22_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_23_0)
	arg_23_0:RefreshTip()
	arg_23_0:RefreshTimePanel()
	arg_23_0:RefreshContent()
end

function var_0_0.RefreshTimePanel(arg_24_0)
	arg_24_0:RefreshCoundown()
	arg_24_0:RefreshBtn()
end

function var_0_0.during(arg_25_0)
	return _G.gameTimer:GetNextDayFreshTime() - manager.time:GetServerTime()
end

function var_0_0.RefreshCoundown(arg_26_0)
	if arg_26_0.timer_ then
		arg_26_0.timer_:Stop()

		arg_26_0.timer_ = nil
	end

	local var_26_0

	arg_26_0.timer_ = Timer.New(function()
		var_26_0 = arg_26_0:during()
		arg_26_0.tipText_.text = string.format(GetTips("TIME_DISPLAY_2"), TimeMgr:DescCDTime(var_26_0))

		if var_26_0 <= 0 then
			arg_26_0.timer_:Stop()

			arg_26_0.timer_ = nil
		end
	end, 1, -1)

	arg_26_0.timer_:Start()
end

function var_0_0.RefreshBtn(arg_28_0)
	local var_28_0 = BattleEnchantmentData:GetData()

	if var_28_0.freeRefreshTimes > 0 then
		local var_28_1 = string.format("<color=#FFFFFF><size=34>%d</size></color>/%d", var_28_0.freeRefreshTimes, var_0_2)

		arg_28_0.freecntText_.text = var_28_1

		arg_28_0.btnCon_:SetSelectedState("free")
	elseif var_28_0.allRefreshedTimes < var_0_3 then
		arg_28_0.numText_.text = string.format("(%d/%d)", var_28_0.allRefreshedTimes, var_0_3)
		arg_28_0.costText_.text = var_0_4[var_28_0.allRefreshedTimes + 1][2]

		arg_28_0.btnCon_:SetSelectedState("buy")
	else
		arg_28_0.btnCon_:SetSelectedState("max")
	end
end

function var_0_0.RefreshTip(arg_29_0)
	return
end

function var_0_0.RefreshDifficultButton(arg_30_0)
	arg_30_0.isBtnActive_ = not arg_30_0.isBtnActive_

	SetActive(arg_30_0.difficultpanelGo_, arg_30_0.isBtnActive_)
	SetActive(arg_30_0.maskGo_, arg_30_0.isBtnActive_)
end

function var_0_0.RefreshDiffBtn(arg_31_0)
	for iter_31_0 = 1, 3 do
		local var_31_0 = var_0_1(iter_31_0)

		arg_31_0["diffCon" .. iter_31_0]:SetSelectedState(var_31_0 and "lock" or "unLock")
	end
end

function var_0_0.RefreshContent(arg_32_0)
	arg_32_0.itempanelAni_:Play("aniEnchantmentStageUI_itemPanel", 0, 0)

	local var_32_0 = BattleEnchantmentData:GetData()

	for iter_32_0 = 1, 3 do
		local var_32_1 = var_32_0.enchantmentBattleList[iter_32_0]
		local var_32_2 = StageGroupCfg[var_32_1].stage_list[arg_32_0.selectedDifficulty_]
		local var_32_3 = StageGroupCfg[var_32_1].level

		arg_32_0.itemS[iter_32_0]:RefreshUI(var_32_2, var_32_3)
	end

	SetActive(arg_32_0.affixinfoTrs_.gameObject, false)
	arg_32_0.diffCon_:SetSelectedState(arg_32_0.selectedDifficulty_)

	arg_32_0.diffText_.text = GetTips("HARD_LEVEL")
end

function var_0_0.ShowAffixInfo(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0.affixinfoTrs_:SetParent(arg_33_1)

	arg_33_0.affixinfoTrs_.localPosition = Vector3(0, 0, 0)

	SetActive(arg_33_0.affixinfoTrs_.gameObject, true)

	if arg_33_2 and arg_33_2 ~= "" then
		arg_33_0.affixcontentText_.text = GetI18NText(getAffixDesc(arg_33_2))
		arg_33_0.affixnameText_.text = GetI18NText(getAffixName(arg_33_2))
	else
		arg_33_0.affixcontentText_.text = ""
		arg_33_0.affixnameText_.text = ""
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_0.affixinfoTrs_)

	if arg_33_0.countdownTimer_ then
		arg_33_0.countdownTimer_:Stop()

		arg_33_0.countdownTimer_ = nil
	end

	arg_33_0.countdownTimer_ = Timer.New(function()
		SetActive(arg_33_0.affixinfoTrs_.gameObject, false)
	end, 2, -1)

	arg_33_0.countdownTimer_:Start()
end

function var_0_0.Dispose(arg_35_0)
	if arg_35_0.timer_ then
		arg_35_0.timer_:Stop()

		arg_35_0.timer_ = nil
	end

	if arg_35_0.countdownTimer_ then
		arg_35_0.countdownTimer_:Stop()

		arg_35_0.countdownTimer_ = nil
	end

	for iter_35_0 = 1, 3 do
		arg_35_0.itemS[iter_35_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_35_0)
end

return var_0_0
