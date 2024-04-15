slot0 = class("SectionInfoBaseView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Operation/ChapterSectionInfoUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.rewardItems_ = {}

	slot0:InitUI()
	slot0:AddListeners()

	slot0.multiple_ = 1
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.RefreshRewardItem), slot0.rewardUIListGo_, CommonItemView)
	slot0.hideStageNumController_ = slot0.controllerEx_:GetController("hideStageNum")
	slot0.hideThreeStarController_ = slot0.controllerEx_:GetController("hideThreeStar")
	slot0.hideDropPanelController_ = slot0.controllerEx_:GetController("hideDropPanel")
	slot0.hideStageDescController_ = slot0.controllerEx_:GetController("hideStageDesc")
	slot0.hideMultiplePanelController_ = slot0.controllerEx_:GetController("hideMultiplePanel")
	slot0.hideAffixController_ = slot0.controllerEx_:GetController("hideAffixPanel")
	slot0.hideBattleAffixController_ = slot0.controllerEx_:GetController("hideBattleAffixPanel")
	slot0.guildStateController_ = slot0.controllerEx_:GetController("guildstate")
	slot0.hideSmallAffixController_ = slot0.controllerEx_:GetController("hideSmallAffix")
	slot0.hideFatigueController_ = slot0.controllerEx_:GetController("hideFatigue")
	slot0.challengeTimeController_ = slot0.controllerEx_:GetController("challengeTime")
	slot0.refreshTimeController_ = slot0.controllerEx_:GetController("refreshTime")
	slot0.btnWebController_ = slot0.controllerEx_:GetController("btnWeb")
	slot0.btnController_ = slot0.btnControllerEx_:GetController("lock")
	slot0.showTipsController_ = slot0.controllerEx_:GetController("showTips")
	slot0.titleDesController_ = slot0.describeControllerexcollection_:GetController("text")

	slot0.hideStageNumController_:SetSelectedState("true")
	slot0.hideThreeStarController_:SetSelectedState("true")
	slot0.hideDropPanelController_:SetSelectedState("true")
	slot0.hideStageDescController_:SetSelectedState("true")
	slot0.hideMultiplePanelController_:SetSelectedState("true")
	slot0.hideAffixController_:SetSelectedState("true")
	slot0.hideBattleAffixController_:SetSelectedState("true")
	slot0.guildStateController_:SetSelectedState("common")
	slot0.hideSmallAffixController_:SetSelectedState("true")

	slot0.btnController_ = slot0.btnControllerEx_:GetController("lock")

	slot0.hideFatigueController_:SetSelectedState("show")
	slot0.challengeTimeController_:SetSelectedState("close")
	slot0.refreshTimeController_:SetSelectedState("close")
	slot0.btnWebController_:SetSelectedState("notshow")
	slot0.showTipsController_:SetSelectedState("false")

	slot0.currencyUpdateHandle_ = handler(slot0, slot0.OnCurrencyChange)
end

function slot0.OnEnter(slot0)
	slot0.stageID_ = slot0.params_.section
	slot0.stageType_ = slot0.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED

	manager.notify:RegistListener(CURRENCY_UPDATE, slot0.currencyUpdateHandle_)
	slot0:RefreshData()
	slot0:RefreshUI()
	slot0:RefreshTitleDesc()
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
	if type(BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).extra_cost) == "table" and slot1.extra_cost[1] then
		slot2 = slot1.extra_cost[1]

		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			slot2,
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			CurrencyConst.CURRENCY_TYPE_GOLD,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
		manager.windowBar:SetBarCanClick(slot2, true)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			CurrencyConst.CURRENCY_TYPE_GOLD,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
	end

	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function slot0.OnUpdate(slot0)
	if slot0.stageID_ == slot0.params_.section then
		return
	end

	slot0.stageID_ = slot0.params_.section

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.notify:RemoveListener(CURRENCY_UPDATE, slot0.currencyUpdateHandle_)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.battleBtn_, nil, function ()
		slot0 = uv0.stageID_
		slot1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
		slot2 = BattleStageTools.GetStageCfg(uv0.stageType_, uv0.stageID_)

		if uv0.lock_ then
			ShowTips(uv0.lockTips_)
		elseif type(slot2.extra_cost) == "table" and slot2.extra_cost[1] then
			slot3 = slot2.extra_cost[1]

			if ItemTools.getItemNum(slot2.extra_cost[1]) < uv0.cost_ then
				uv0:PopCurrencyWindow()
			else
				uv0:OnClickBtn()
			end
		elseif slot1 < uv0.cost_ * uv0.multiple_ then
			if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
				JumpTools.OpenPopUp("currencyBuyFatigue", uv0.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
			end
		else
			uv0:OnClickBtn()
		end
	end)
end

function slot0.PopCurrencyWindow(slot0)
	if ChapterCfg[slot0.params_.chapterID].cost_exchange_id == 0 then
		return
	end

	if ActivityTools.GetActivityStatus(ItemExchangeCfg[slot2].activity_id) == 1 then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("CURRENCY_NO_ENOUGH_ADN_GOT"), ItemTools.getItemName(BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).extra_cost[1]), ActivityCfg[slot4.activity_id].remark),
			OkCallback = function ()
				JumpTools.JumpToPage2(uv0.jump_system)
			end
		})
	else
		JumpTools.OpenPageByJump("itemExchange", {
			exchangeID = slot2,
			maxCnt = ChapterTools.GetUnclearStageCnt(slot1)
		})
	end
end

function slot0.OnCurrencyChange(slot0)
	slot0:RefreshData()
	slot0:RefreshCost()
end

function slot0.RefreshData(slot0)
	slot0.lock_ = false
	slot0.lockTips_ = ""
	slot0.cost_ = 0
	slot0.isFirstClear_ = false
	slot0.dropLibID_ = 0
end

function slot0.RefreshUI(slot0)
	slot0:RefreshStageInfo()
	slot0:RefreshReward()
	slot0:RefreshCost()
	slot0:RefreshBtn()

	if slot0.lock_ then
		slot0.btnLockText_.text = slot0.lockTips_

		slot0.btnController_:SetSelectedState("true")
	else
		slot0.btnController_:SetSelectedState("false")
	end
end

function slot0.RefreshTitleDesc(slot0)
	if slot0.stageType_ == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING or slot0.stageType_ == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING then
		slot0.titleDesController_:SetSelectedState("state1")
	elseif slot0.stageType_ == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT then
		slot0.titleDesController_:SetSelectedState("state0")
	else
		slot0.titleDesController_:SetSelectedState("state2")
	end
end

function slot0.HaveCostCntFlag(slot0)
	slot3 = true

	if type(BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).extra_cost) == "table" and slot2.extra_cost[1] then
		slot0.costImage_.sprite = ItemTools.getItemLittleSprite(slot2.extra_cost[1])

		if ItemTools.getItemNum(slot2.extra_cost[1]) < slot0.cost_ * slot0.multiple_ then
			slot3 = false
		end
	else
		slot0.costImage_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_VITALITY)

		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) < slot1 then
			slot3 = false
		end
	end

	return slot3
end

function slot0.RefreshCost(slot0)
	if slot0:HaveCostCntFlag() then
		slot0.costText_.text = string.format("<color=#%s>%s</color>", ColorConst.BLACK_HEX, slot0.cost_ * slot0.multiple_)
	else
		slot0.costText_.text = string.format("<color=#%s>%s</color>", ColorConst.RED_HEX, slot2)
	end
end

function slot0.RefreshBtn(slot0)
	slot1 = slot0:HaveCostCntFlag()

	slot0.btnController_:SetSelectedState(tostring(slot0.lock_))
end

function slot0.RefreshStageInfo(slot0)
	if slot0.oldCfgID_ ~= BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).id then
		slot2, slot3 = BattleStageTools.GetChapterSectionIndex(slot0.stageType_, slot0.stageID_)
		slot0.sectionText_.text = string.format("%s-%s", GetI18NText(slot2), GetI18NText(slot3))
		slot0.sectionName_.text = GetI18NText(slot1.name)
		slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot1.background_1))
		slot0.oldCfgID_ = slot1.id
	end
end

function slot0.RefreshReward(slot0)
	slot0.rewardList_ = getRewardFromDropCfg(slot0.dropLibID_, slot0.isFirstClear_)
	slot2 = slot0.rewardList_

	if slot0.isFirstClear_ and DropCfg[slot1] and #DropCfg[slot1].base_drop >= 1 then
		slot0.rewardTitleText_.text = GetTips("FIRST_DROP")
	else
		slot0.rewardTitleText_.text = GetTips("MAYBE_DROP")
	end

	if #slot2 > 0 then
		slot0.hideDropPanelController_:SetSelectedState("false")
	else
		slot0.hideDropPanelController_:SetSelectedState("true")
	end

	slot0.uiList_:StartScroll(#slot2)
end

function slot0.RefreshRewardItem(slot0, slot1, slot2)
	slot4 = nil

	if slot0.rewardList_[slot1] then
		slot4 = rewardToItemTemplate(slot3)
		slot4.number = slot0.isFirstClear_ and slot3.num or nil

		function slot4.clickFun(slot0)
			ShowPopItem(POP_ITEM, slot0)
		end
	end

	slot2:SetData(slot4)
end

function slot0.Dispose(slot0)
	slot0.uiList_:Dispose()

	slot0.uiList_ = nil
	slot0.currencyUpdateHandle_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
