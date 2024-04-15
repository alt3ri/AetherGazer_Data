slot0 = class("ValentineGameV2HeroInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineStageUI"
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

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.rewardList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, ValentineGameV2RewardItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.cfg_.reward_item_list[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		if ActivityData:GetActivityIsOpen(uv0.activityID_) then
			if ValentineGameData:GetData(uv0.activityID_).isClear and type(ActivityValentineCfg[uv0.activityID_].cost_item) == "table" and not checkGold(ActivityValentineCfg[uv0.activityID_].cost_item[1][2], true) then
				return
			end

			JumpTools.OpenPageByJump("/valentineGameV2GameStartView", {
				activityID = uv0.activityID_
			})
		elseif manager.time:GetServerTime() < ActivityData:GetActivityData(uv0.activityID_).startTime then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(uv0.activityID_).startTime)))
		else
			ShowTips(GetTips("TIME_OVER"))
		end
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		ValentineGameAction:GetReward(uv0.activityID_)
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.cfg_ = ActivityValentineCfg[slot0.activityID_]

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.nameText_.text = slot0.cfg_.name
	slot0.desText_.text = slot0.cfg_.desc
	slot0.finishNumText_.text = #ValentineGameData:GetData(slot0.activityID_).selectQuestionID .. "/" .. #slot0.cfg_.hero_qa_id
	slot0.heroImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. slot0.cfg_.hero_id .. "_split_1")

	slot0.heroImage_:SetNativeSize()
	slot0.rewardList_:StartScroll(#slot0.cfg_.reward_item_list)

	if ValentineGameData:GetData(slot0.activityID_) and slot2.isReward then
		slot0.stateController_:SetSelectedState("received")
	elseif slot2 and slot2.isClear then
		slot0.stateController_:SetSelectedState("complete")
	else
		slot0.stateController_:SetSelectedState("test")
	end

	if slot2 and slot2.isClear then
		SetActive(slot0.costGo_, true)

		slot0.costIcon_.sprite = getSprite("Atlas/Currency", slot0.cfg_.cost_item[1][1])
		slot0.costText_.text = slot0.cfg_.cost_item[1][2]
	else
		SetActive(slot0.costGo_, false)
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_VALENTINE_DESCRIBE")
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnValentineGameReward(slot0)
	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	if slot0.rewardList_ then
		slot0.rewardList_:Dispose()

		slot0.rewardList_ = nil
	end

	slot0.super.Dispose(slot0)
end

return slot0
