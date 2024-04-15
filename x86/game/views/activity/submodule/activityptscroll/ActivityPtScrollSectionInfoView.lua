SectionBaseView = import("game.views.sectionInfo.SectionInfoMultipleBaseView")
slot0 = class("ActivityPtScrollSectionInfoView", SectionBaseView)
slot1 = #GameSetting.challenge_multiple_count_unlock_level.value

function slot0.AddListeners(slot0)
	uv0.super.AddListeners(slot0)
	slot0:RemoveBtnListener(nil, slot0.battleBtn_.transform)
	slot0:AddBtnListener(slot0.battleBtn_, nil, function ()
		if uv0.lock_ then
			ShowTips(uv0.lockTips_)
		elseif uv0.costID_ ~= 0 and ItemTools.getItemNum(uv0.costID_) < uv0.cost_ * uv0.multiple_ then
			if uv0.costID_ == CurrencyConst.CURRENCY_TYPE_VITALITY then
				if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
					JumpTools.OpenPopUp("currencyBuyFatigue", uv0.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
				else
					ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
				end
			else
				ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(uv0.costID_)))
			end
		else
			uv0:OnClickBtn()
		end
	end)
end

function slot0.UpdateBar(slot0)
	slot1 = ActivityPtScrollTools.GetChallengeCurrencyID(slot0.params_.activityId)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		slot1,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanClick(slot1, true)
	manager.windowBar:RegistBackCallBack(function ()
		if uv0.params_.backCall then
			uv0.params_.backCall()
		end

		uv0:Back()
	end)
end

function slot0.RefreshData(slot0)
	slot0.cfg_ = BattleStageTools.GetStageCfg(slot0.params_.sectionType, slot0.params_.section)

	slot0.hideStageDescController_:SetSelectedState("false")

	slot0.storyText_.text = slot0.cfg_.tips

	slot0:RefreshCostInfo()

	slot1 = 1

	for slot5 = uv0, 1, -1 do
		if ItemTools.getItemNum(slot0.costID_) >= slot0.cost_ * slot5 then
			slot1 = slot5

			break
		end
	end

	slot0.maxMultiple_ = slot1
	slot0.multiple_ = slot0.multiple_ or 1
	slot0.challengeCnt_ = slot0:GetUnlockChallengeCnt()
	slot0.lock_ = false
	slot0.lockTips_ = ""
	slot0.isFirstClear_ = (table.indexof(ActivityPtScrollData:GetClearList(slot0.params_.activityId), slot0.params_.section) ~= false and 1 or 0) == 0
	slot0.dropLibID_ = slot0.cfg_.drop_lib_id
end

function slot0.RefreshCostInfo(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(ActivityPtRouletteStageCfg.get_id_list_by_activity_id[slot0.params_.activityId]) do
		if ActivityPtRouletteStageCfg[slot7].stage_id == slot0.params_.section then
			slot1 = ActivityPtRouletteStageCfg[slot7].cost

			break
		end
	end

	slot0.costID_ = slot1[1]
	slot0.cost_ = slot1[2]
	slot0.costImage_.sprite = ItemTools.getItemLittleSprite(slot0.costID_)
end

function slot0.HaveCostCntFlag(slot0)
	slot0.costImage_.sprite = ItemTools.getItemLittleSprite(slot0.costID_)

	return slot0.cost_ * slot0.multiple_ <= ItemTools.getItemNum(slot0.costID_)
end

function slot0.OnClickBtn(slot0)
	slot0:Go("/sectionSelectHero", {
		section = slot0.params_.section,
		sectionType = slot0.params_.sectionType,
		activityID = slot0.params_.activityId,
		multiple = slot0.multiple_
	})
end

function slot0.GetUnlockChallengeCnt(slot0)
	if (table.indexof(ActivityPtScrollData:GetClearList(slot0.params_.activityId), slot0.params_.section) ~= false and 1 or 0) > 0 then
		return uv0.super.GetUnlockChallengeCnt(slot0)
	end

	return slot2
end

function slot0.GetChallengeCntMaxTip(slot0)
	if (table.indexof(ActivityPtScrollData:GetClearList(slot0.params_.activityId), slot0.params_.section) ~= false and 1 or 0) > 0 then
		return uv0.super.GetChallengeCntMaxTip(slot0)
	end

	return GetTips("ACTIVITY_PT_REPEAT_MULTIPLE_UNLOCK")
end

function slot0.RefreshStageInfo(slot0)
	if slot0.oldCfgID_ ~= BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).id then
		slot2, slot3 = BattleStageTools.GetChapterSectionIndex(slot0.stageType_, slot0.stageID_)
		slot0.sectionText_.text = string.format("%s-%s", GetI18NText(slot2), GetI18NText(slot3))
		slot0.sectionName_.text = GetI18NText(slot1.name)
		slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot1.background_1))
		slot0.oldCfgID_ = slot1.id
		slot0.multiple_ = 1
	end
end

return slot0
