NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")
slot0 = class("BattleResultChapterView", NewBattleSettlementView)

function slot0.NeedAddExp(slot0)
	return BattleInstance.NeedAddExp(slot0.stageData)
end

function slot0.RefreshBottomBtn(slot0)
	slot1 = slot0.stageData:GetStageId()
	slot4 = StageTools.GetChapterNextStageID(getChapterIDByStageID(slot1), slot1) ~= nil and not StageTools.IsLockStage(slot2, slot3)
	slot5 = BattleStageData:GetStageData()[slot1]

	if manager.guide:IsPlaying() and table.keyof(GameSetting.guide_use_old_result_stage.value, slot1) and slot5 and slot5.clear_times == 1 then
		slot4 = false
	end

	if ChapterCfg[slot2].clientID == ChapterConst.CHAPTER_CLIENT_19 then
		slot4 = false
	end

	SetActive(slot0.nextStageBtn_.gameObject, slot4)

	if slot3 then
		slot7 = BattleStageData:GetStageData()[slot3]

		if type(BattleStageTools.GetStageCfg(slot0.stageData:GetType(), slot3).extra_cost) == "table" and slot9.extra_cost[1] then
			slot0.costImage_.sprite = ItemTools.getItemLittleSprite(slot9.extra_cost[1])
		else
			slot0.costImage_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_VITALITY)
		end

		if slot7 == nil or slot7.clear_times <= 0 then
			if type(slot9.extra_cost) == "table" and slot9.extra_cost[1] then
				slot10 = slot9.extra_cost[1]
				slot0.vitalityCostText_.text = slot9.extra_cost[2]
			else
				slot0.vitalityCostText_.text = slot9.cost
			end
		else
			slot0.vitalityCostText_.text = 0
		end
	end
end

function slot0.OnAddListner(slot0)
	slot0:AddBtnListener(slot0.nextStageBtn_, nil, function ()
		slot0 = uv0.stageData:GetStageId()
		slot1 = getChapterIDByStageID(slot0)
		slot3 = uv0.stageData:GetType()

		if StageTools.IsLockSubChapterStage(slot1, StageTools.GetChapterNextStageID(slot1, slot0)) then
			if slot1 == 6010106 then
				ShowTips("ACTIVITY_FINISH_ALL_SUMMER_CHESS")
			end

			return
		end

		slot4 = BattleStageTools.GetStageCfg(slot3, slot2)
		slot6 = 0
		slot7 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)

		if BattleStageData:GetStageData()[slot2] == nil or slot5.clear_times <= 0 then
			if type(slot4.extra_cost) == "table" and slot4.extra_cost[1] then
				if ItemTools.getItemNum(slot4.extra_cost[1]) < slot4.extra_cost[2] then
					uv0:PopCurrencyWindow()

					return
				end
			elseif slot7 < slot4.cost then
				if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
					JumpTools.OpenPopUp("currencyBuyFatigue", uv0.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
				else
					ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
				end

				return
			end
		end

		function slot8()
			if BattleConst.BATTLE_TAG.STORY == uv0.tag then
				BattleController.GetInstance():LaunchStoryBattle(uv1, uv2)
			else
				BattleInstance.GotoBattleReadyPage(uv3, uv2, uv1)
			end
		end

		if StageTools.NeedShowContinueBattleWindow(slot3, slot2) then
			JumpTools.OpenPopUp("continueBattleCostPop", {
				stageType = slot3,
				stageID = slot2,
				callback = function ()
					uv0()
				end
			})
		else
			slot8()
		end
	end)
end

function slot0.PopCurrencyWindow(slot0)
	slot1 = slot0.stageData:GetStageId()
	slot2 = getChapterIDByStageID(slot1)

	if ActivityTools.GetActivityStatus(ItemExchangeCfg[ChapterCfg[slot2].cost_exchange_id].activity_id) == 1 then
		ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(BattleStageTools.GetStageCfg(slot0.stageData:GetType(), StageTools.GetChapterNextStageID(slot2, slot1)).extra_cost[1])))
	else
		JumpTools.OpenPageByJump("itemExchange", {
			exchangeID = slot6,
			maxCnt = ChapterTools.GetUnclearStageCnt(slot2)
		})
	end
end

return slot0
