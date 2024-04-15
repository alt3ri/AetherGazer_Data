slot0 = class("ContinueBattleCostPopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Operation/OperationContinuousPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.rewardController_ = slot0.controllerEx_:GetController("item")
	slot0.btnController_ = slot0.controllerEx_:GetController("btn")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListGo_, CommonItemView)
end

function slot0.OnEnter(slot0)
	slot0.stageType_ = slot0.params_.stageType
	slot0.stageID_ = slot0.params_.stageID
	slot0.callBack_ = slot0.params_.callback
	slot0.costList_, slot0.nextStageCnt_ = StageTools.GetContinueBattleCost(slot0.stageType_, slot0.stageID_)
	slot1 = slot0.costList_[1].id
	slot2 = ItemCfg[slot1]
	slot0.descText_.text = string.format(GetTips("CONTINUE_BATTLE_COST_TIP"), slot0.nextStageCnt_, ItemTools.getItemName(slot1), slot0.costList_[1].num)

	if BattleStageData:GetStageData()[slot0.stageID_] and slot3.clear_times > 0 then
		slot0.btnController_:SetSelectedState("single")
	else
		slot0.btnController_:SetSelectedState("out")
	end

	slot0.stageList_ = StageTools.GetContinueBattleStageList(slot0.stageType_, slot0.stageID_)

	slot0:RefreshReward()
	manager.windowBar:SwitchBar({
		slot1
	})
	manager.windowBar:SetBarCanAdd(slot1, true)
	manager.windowBar:SetAsLastSibling()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.singleBtn_, nil, function ()
		uv0:Back()

		if BattleStageData:GetStageData()[uv0.stageID_] and slot0.clear_times > 0 then
			BattleStageData:SetAutoNextBattle(false)
			uv0.callBack_()
		end
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		BattleStageData:SetAutoNextBattle(true)
		uv0:Back()
		uv0.callBack_()
	end)
end

function slot0.RefreshReward(slot0)
	slot1 = slot0.stageList_

	if ChapterTools.IsClearStage(slot1[#slot1]) then
		slot0.rewardController_:SetSelectedState("none")
	else
		slot0.rewardIDList_ = getRewardFromDropCfg(BattleStageTools.GetStageCfg(slot0.stageType_, slot2).drop_lib_id, true)

		slot0.uiList_:StartScroll(#slot0.rewardIDList_)

		slot4, slot5 = BattleStageTools.GetChapterSectionIndex(slot0.stageType_, slot2)
		slot0.clearTipsText_.text = string.format(GetTips("CLEAR_STAGE_DROP_REWARD"), string.format("%s-%s", GetI18NText(slot4), slot5))

		slot0.rewardController_:SetSelectedState("have")
	end
end

function slot0.OnTop(slot0)
	slot0.canvasGroup_.alpha = 1
	slot0.canvasGroup_.blocksRaycasts = true
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = rewardToItemTemplate(slot0.rewardIDList_[slot1])

	function slot3.clickFun(slot0)
		ShowPopItem(POP_OTHER_ITEM, slot0)

		uv0.canvasGroup_.alpha = 0
		uv0.canvasGroup_.blocksRaycasts = false
	end

	slot2:SetData(slot3)
end

return slot0
