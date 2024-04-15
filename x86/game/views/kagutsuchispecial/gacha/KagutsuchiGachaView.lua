slot0 = import("manager.windowBar.WindowCurrencyItem")
slot1 = class("KagutsuchiGachaView", ReduxView)

function slot1.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionKagutsuchiJackpotUI"
end

function slot1.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot1.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.drawController_ = ControllerUtil.GetController(slot0.transform_, "draw")
	slot0.bigDrawController_ = ControllerUtil.GetController(slot0.transform_, "bigDraw")
	slot0.poolRewardItem_ = {
		KagutsuchiGachaRewardItem.New(slot0.rewardItem1Go_),
		KagutsuchiGachaRewardItem.New(slot0.rewardItem2Go_),
		KagutsuchiGachaRewardItem.New(slot0.rewardItem3Go_)
	}
	slot1 = uv0.New(slot0.token2Go_, CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id)

	slot1:SetActive(true)
	slot1:SetCanAdd(false)
	slot1:SetCanClick(true)

	slot0.token2_ = slot1
end

function slot1.OnEnter(slot0)
	slot0:InitBar()

	slot0.isAniPlaying_ = false

	slot0:RefreshUI()
	slot0:AddTimer()

	slot1 = ActivityConst.KAGUTSUCHI_ACTIVITY
	slot2 = ActivityTools.GetRedPointKey(slot1) .. slot1

	manager.redPoint:bindUIandKey(slot0.oneDrawBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA_ONE, slot2))
	manager.redPoint:bindUIandKey(slot0.bigDrawBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA_MULTI, slot2))
	KagutsuchiWorkAction:UpdateRedPoint(ActivityConst.KAGUTSUCHI_ACTIVITY)
end

function slot1.InitBar(slot0)
end

function slot1.OnExit(slot0)
	for slot4, slot5 in ipairs(slot0.poolRewardItem_) do
		slot0.poolRewardItem_[slot4]:OnExit()
	end

	AnimatorTools.Stop()
	slot0:StopTimer()

	slot1 = ActivityConst.KAGUTSUCHI_ACTIVITY
	slot2 = ActivityTools.GetRedPointKey(slot1) .. slot1

	manager.redPoint:unbindUIandKey(slot0.oneDrawBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA_ONE, slot2))
	manager.redPoint:unbindUIandKey(slot0.bigDrawBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA_MULTI, slot2))
end

function slot1.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.poolRewardItem_) do
		slot0.poolRewardItem_[slot4]:Dispose()
	end

	slot0.token2_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.previewBtn_, nil, function ()
		JumpTools.OpenPageByJump("kagutsuchiGachaPreview", {
			activityId = uv0:GetActivityID(),
			poolId = uv0:GetPoolId()
		})
	end)
	slot0:AddBtnListener(slot0.oneDrawBtn_, nil, function ()
		uv0:TryStartDraw(1)
	end)
	slot0:AddBtnListener(slot0.bigDrawBtn_, nil, function ()
		uv0:TryStartDraw(uv0.bigDrawTimes)
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		if uv0.isAniPlaying_ then
			return
		end

		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.homeBtn_, nil, function ()
		if uv0.isAniPlaying_ then
			return
		end

		gameContext:Go("/home", nil, , true)
	end)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		if uv0.isAniPlaying_ then
			return
		end

		slot0 = "ACTIVITY_KAGUTSUCHI_REWARD_DESCRIBE"

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips(slot0),
			key = slot0
		})
	end)
end

function slot1.RefreshUI(slot0)
	slot1 = slot0:GetPoolId()
	slot3 = math.max(KagutsuchiGachaData:GetMaxDrawTimes(slot1), 2)

	if KagutsuchiGachaData:GetPoolRemains(slot1) == 0 then
		slot0.drawController_:SetSelectedState("empty")
	elseif slot4 == 1 then
		slot0.bigDrawController_:SetSelectedState("lack")
	end

	slot5, slot6 = KagutsuchiGachaData:GetDrawCost(slot1, slot3)
	slot0.bigDrawText_.text = slot3

	if slot2 < 2 then
		slot0.bigDrawCostText_.text = "x<color=#CC0013>" .. slot6 .. "</color>"
	else
		slot0.bigDrawCostText_.text = "x" .. slot6
	end

	slot7, slot8 = KagutsuchiGachaData:GetDrawCost(slot1, 1)
	slot0.oneDrawText_.text = 1

	if slot2 == 0 then
		slot0.oneDrawCostText_.text = "x<color=#CC0013>" .. slot8 .. "</color>"
	else
		slot0.oneDrawCostText_.text = "x" .. slot8
	end

	slot0.bigDrawTimes = slot3

	slot0:RefreshPoolDisplayItems(slot1)

	slot0.coinText_.text = KagutsuchiWorkData:GetCoins()
	slot9 = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id)
	slot0.coinImage_.sprite = slot9
	slot0.oneDrawImage_.sprite = slot9
	slot0.bigDrawImage_.sprite = slot9
end

function slot1.RefreshPoolDisplayItems(slot0, slot1)
	for slot6, slot7 in ipairs(KagutsuchiGachaData:GetDisplayDrawItemIds(slot1)) do
		if not slot0.poolRewardItem_[slot6] then
			slot0.poolRewardItem_[slot6] = KagutsuchiGachaRewardItem.New(Object.Instantiate(slot0.templateItem_, slot0.poolRewardContent_))
		end

		slot0.poolRewardItem_[slot6]:SetData(slot0:GetActivityID(), slot1, slot7)
	end
end

function slot1.RefreshTimeUI(slot0)
	slot0.timeText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(slot0:GetActivityID()).stopTime, nil)
end

function slot1.AddTimer(slot0)
	slot0:StopTimer()
	slot0:RefreshTimeUI()

	slot0.timer_ = Timer.New(function ()
		uv0:RefreshTimeUI()
	end, 1, -1)

	slot0.timer_:Start()
end

function slot1.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot1.TryStartDraw(slot0, slot1)
	if slot0.isAniPlaying_ then
		return
	end

	slot2 = slot0:GetPoolId()
	slot4, slot5 = KagutsuchiGachaData:GetDrawCost(slot2, slot1)

	if KagutsuchiGachaData:GetMaxDrawTimes(slot2) < slot1 then
		ShowTips("ACTIVITY_KAGUTSUCHI_POLL_COST_NOTE_ENOUGH")

		return
	end

	KagutsuchiGachaAction:StartDraw(slot1, slot0:GetActivityID(), slot2, handler(slot0, slot0.OnFinishDraw))
end

function slot1.OnFinishDraw(slot0, slot1, slot2)
	slot0:PlayEffects(function ()
		uv0:RefreshUI()

		slot1 = {}

		for slot5, slot6 in ipairs(uv1.reward_list) do
			slot7, slot8 = KagutsuchiGachaData:GetDrawItemReward(uv1.pool_id, slot6)

			table.insert(slot1, {
				id = slot7,
				num = slot8
			})
		end

		getReward(slot1)
		KagutsuchiWorkAction:UpdateRedPoint(ActivityConst.KAGUTSUCHI_ACTIVITY)
	end)
end

function slot1.GetActivityID(slot0)
	return ActivityConst.KAGUTSUCHI_ACTIVITY_REWARD
end

function slot1.GetPoolId(slot0)
	return KagutsuchiGachaData:GetPoolIds(slot0:GetActivityID())[1]
end

function slot1.PlayEffects(slot0, slot1)
	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_toy", "")

	slot0.isAniPlaying_ = true

	slot0.gachaDrawAni_:Play("JapanRegionKagutsuchiJackpotUI_roll", -1, 0)
	slot0.gachaDrawAni_:Update(0)
	AnimatorTools.PlayAnimationWithCallback(slot0.gachaDrawAni_, "JapanRegionKagutsuchiJackpotUI_roll", function ()
		uv0.isAniPlaying_ = false

		uv1()
	end)
end

return slot1
