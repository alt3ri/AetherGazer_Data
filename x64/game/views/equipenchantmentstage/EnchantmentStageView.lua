slot0 = class("EnchantmentStageView", ReduxView)

function slot1(slot0, slot1)
	if GameSetting.fm_stage_unlock.value[slot0] <= PlayerData:GetPlayerInfo().userLevel then
		return false
	end

	if slot1 then
		ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot2))
	end

	return true
end

slot2 = GameSetting.fm_free_refresh_limit_count.value[1]
slot3 = GameSetting.fm_item_refresh_limit_count.value[1]
slot4 = GameSetting.fm_item_refresh_cost.value
slot5 = GameSetting.fm_stage_unlock.value[1]
slot6 = GameSetting.fm_get_refresh_count.value[1]

function slot0.UIName(slot0)
	return "Widget/System/EnchantmentStage/EnchantmentStageUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stageLuaItem_ = {}
	slot0.diffButtonList_ = {}
	slot0.curStageIDList_ = {}
	slot0.selectingDifficult = false
	slot0.selectStageController_ = slot0.mainControllerEx_:GetController("selectStageState")
	slot0.refreshController_ = slot0.mainControllerEx_:GetController("refreshState")
	slot0.diffSelectController_ = slot0.mainControllerEx_:GetController("diffSelectState")
	slot0.diffLockController_ = slot0.mainControllerEx_:GetController("diffLockState")
	slot4 = "name"
	slot0.panelController_ = ControllerUtil.GetController(slot0.panelTrs_, slot4)

	for slot4 = 1, 3 do
		slot0.stageLuaItem_[slot4] = EnchantmentStageItem.New(slot0["stageItem" .. slot4 .. "Go_"], function ()
			if uv0.selectingDifficult then
				SetActive(uv0.diffPanelGo_, false)

				uv0.selectingDifficult = false

				return
			end

			uv0:Go("enchantmentSectionInfo", {
				sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY,
				section = uv0.curStageIDList_[uv1]
			})
			SetActive(uv0.closeSectionBtn_.gameObject, true)
			uv0.selectStageController_:SetSelectedState(uv1)
			uv0.panelController_:SetSelectedState(uv1)
		end)
		slot0.diffButtonList_[slot4] = slot0["diff" .. slot4 .. "Btn_"]
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.buyBtn_, nil, function ()
		if uv0.selectingDifficult then
			SetActive(uv0.diffPanelGo_, false)

			uv0.selectingDifficult = false

			return
		end

		if GameSetting.fm_item_refresh_cost.value[BattleEnchantmentData:GetData().allRefreshedTimes + 1][2] - CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) > 0 then
			ShopTools.DefaultOpenPopUp(slot2)

			return
		end

		if _G.SkipTip.SkipEnchantmentRefreshTip then
			BattleEnchantAction.EnchantmentRefresh(2, GameSetting.fm_item_refresh_cost.value[slot0.allRefreshedTimes + 1])

			return
		end

		slot3 = false

		JumpTools.OpenPageByJump("popCostItem", {
			costId = CurrencyConst.CURRENCY_TYPE_DIAMOND,
			costCount = slot1,
			content = GetTipsF("ENCHANTMENT_STAGE_REFRESH_CHECK", ItemCfg[CurrencyConst.CURRENCY_TYPE_DIAMOND].name, slot1),
			popCostCallBack = function ()
				BattleEnchantAction.EnchantmentRefresh(2, GameSetting.fm_item_refresh_cost.value[uv0.allRefreshedTimes + 1])

				_G.SkipTip.SkipEnchantmentRefreshTip = uv1
			end,
			ToggleCallback = function (slot0)
				uv0 = slot0
			end
		})
	end)
	slot0:AddBtnListener(slot0.freeBtn_, nil, function ()
		if uv0.selectingDifficult then
			SetActive(uv0.diffPanelGo_, false)

			uv0.selectingDifficult = false

			return
		end

		if not _G.SkipTip.SkipRefreshEnchantmentTimesTip and SettingData:GetRemindSettingData().refresh_enchantment_times_reminder == 1 then
			slot1 = false

			for slot6, slot7 in ipairs(BattleEnchantmentData:GetData().enchantmentBattleList) do
				if StageGroupCfg[slot7].level >= 3 then
					slot1 = true

					break
				end
			end

			if slot1 then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("EQUIP_STAGE_REFRESH"),
					OkCallback = function ()
						_G.SkipTip.SkipRefreshEnchantmentTimesTip = uv0.SkipRefreshEnchantmentTimesTip_

						BattleEnchantAction.EnchantmentRefresh(1)
					end,
					ToggleCallback = function (slot0)
						uv0.SkipRefreshEnchantmentTimesTip_ = slot0
					end
				})

				return
			end
		end

		BattleEnchantAction.EnchantmentRefresh(1)
	end)
	slot0:AddBtnListener(slot0.noneBtn_, nil, function ()
		ShowTips("JM_REFRESH_NONE")
	end)

	slot4 = slot0.closeSectionBtn_

	slot0:AddBtnListener(slot4, nil, function ()
		SetActive(uv0.closeSectionBtn_.gameObject, false)

		if uv0:IsOpenRoute("enchantmentSectionInfo") then
			JumpTools.Back()
		end
	end)

	for slot4 = 1, 3 do
		slot0:AddBtnListener(slot0.diffButtonList_[slot4], nil, function ()
			if uv0(uv1, true) then
				return
			end

			uv2.diffSelectController_:SetSelectedState(uv1)
			BattleEnchantAction.SetSelectLevel(uv1)

			uv2.selectedDifficulty_ = uv1

			uv2:RefreshContent()
		end)
	end

	slot0:AddBtnListener(slot0.diffSelectBtn_, nil, function ()
		SetActive(uv0.diffPanelGo_, true)

		uv0.selectingDifficult = true
	end)
	slot0:AddBtnListener(slot0.diffCloseBtn_, nil, function ()
		SetActive(uv0.diffPanelGo_, false)

		uv0.selectingDifficult = false
	end)
end

function slot0.OnTop(slot0)
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
	slot0.selectStageController_:SetSelectedState("none")
	slot0.panelController_:SetSelectedState("0")
end

function slot0.OnEnter(slot0)
	slot0.timeText_.text = TimeMgr:DescCDTime(slot0:during())
	slot1 = 3

	while slot1 > 1 do
		if uv0(slot1) then
			slot1 = slot1 - 1
		else
			break
		end
	end

	slot0.diffLockController_:SetSelectedState(slot1)

	slot0.selectedDifficulty_ = BattleEnchantAction.GetSelectLevel()

	if slot0.selectedDifficulty_ == 0 then
		slot0.selectedDifficulty_ = slot1

		BattleEnchantAction.SetSelectLevel(slot0.selectedDifficulty_)
	end

	slot0.diffSelectController_:SetSelectedState(slot0.selectedDifficulty_)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshTimePanel()
	slot0:RefreshContent()
end

function slot0.during(slot0)
	return _G.gameTimer:GetNextDayFreshTime() - manager.time:GetServerTime()
end

function slot0.RefreshTimePanel(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot1 = nil
	slot0.timer_ = Timer.New(function ()
		uv0 = uv1:during()
		uv1.timeText_.text = TimeMgr:DescCDTime(uv0)

		if uv0 <= 0 then
			uv1.timer_:Stop()

			uv1.timer_ = nil
		end
	end, 1, -1)

	slot0.timer_:Start()

	if BattleEnchantmentData:GetData().freeRefreshTimes > 0 then
		slot0.refreshController_:SetSelectedState("free")

		slot0.freeText_.text = string.format("%d/%d", slot2.freeRefreshTimes, uv0)
	elseif slot2.allRefreshedTimes < uv1 then
		slot0.refreshController_:SetSelectedState("buy")

		slot0.butImg_.sprite = ItemTools.getItemSprite(uv2[slot2.allRefreshedTimes + 1][1])
		slot0.buyText_.text = string.format("(%d/%d)", uv1 - slot2.allRefreshedTimes, uv1)
		slot0.butCostText_.text = uv2[slot2.allRefreshedTimes + 1][2]
	else
		slot0.refreshController_:SetSelectedState("none")

		slot0.noneText_.text = string.format("/%d", uv1)
	end
end

function slot0.RefreshContent(slot0)
	slot0.itempanelAni1_:Play("BossSwitchUI1", 0, 0)
	slot0.itempanelAni2_:Play("BossSwitchUI1", 0, 0)

	slot5 = 0

	slot0.itempanelAni3_:Play("BossSwitchUI1", slot5, 0)
	SetActive(slot0.diffPanelGo_, false)

	slot0.selectingDifficult = false

	for slot5 = 1, 3 do
		slot6 = BattleEnchantmentData:GetData().enchantmentBattleList[slot5]
		slot7 = StageGroupCfg[slot6].stage_list[slot0.selectedDifficulty_]
		slot0.curStageIDList_[slot5] = slot7

		slot0.stageLuaItem_[slot5]:SetData(slot7, StageGroupCfg[slot6].level)
	end
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	if slot0.countdownTimer_ then
		slot0.countdownTimer_:Stop()

		slot0.countdownTimer_ = nil
	end

	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	if slot0.countdownTimer_ then
		slot0.countdownTimer_:Stop()

		slot0.countdownTimer_ = nil
	end

	for slot4 = 1, 3 do
		slot0.stageLuaItem_[slot4]:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.OnEnchantmentRefresh(slot0)
	slot0:RefreshUI()
end

function slot0.OnEnchantmentInit(slot0)
	slot0:RefreshUI()
end

return slot0
