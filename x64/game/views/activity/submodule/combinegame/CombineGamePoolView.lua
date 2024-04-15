slot0 = class("CombineGamePoolView", ReduxView)
slot1 = 2

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfEggUI"
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

	slot0.poolRewardItem_ = {
		KagutsuchiGachaRewardItem.New(slot0.rewardItem1Go_),
		KagutsuchiGachaRewardItem.New(slot0.rewardItem2Go_),
		KagutsuchiGachaRewardItem.New(slot0.rewardItem3Go_)
	}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.draw10Btn_, nil, function ()
		uv0:TryStartDraw(uv0.bigDrawTimes)
	end)
	slot0:AddBtnListener(slot0.draw1Btn_, nil, function ()
		uv0:TryStartDraw(1)
	end)
	slot0:AddBtnListener(slot0.poolBtn_, nil, function ()
		JumpTools.GoToSystem("CombineGamePoolPopView", {
			activityId = ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL,
			poolId = KagutsuchiGachaData:GetPoolIds(ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL)[1]
		})
	end)
end

function slot0.OnEnter(slot0)
	if not ActivityData:GetActivityIsOpen(CombineGameData:GetDataByPara("activityId")) then
		gameContext:Go("/home", nil, , true)
		ShowTips("TIME_OVER")

		return
	end

	slot0:UpdateView()
	slot0:BindRedPoint()
end

function slot0.UpdateView(slot0)
	slot1 = KagutsuchiGachaData:GetPoolIds(ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL)[1]
	slot2 = KagutsuchiGachaData:GetMaxDrawTimes(slot1)
	slot3 = math.max(slot2, uv0)
	slot4, slot5 = KagutsuchiGachaData:GetDrawCost(slot1, 1)
	slot6, slot7 = KagutsuchiGachaData:GetDrawCost(slot1, slot3)
	slot8, slot9 = KagutsuchiGachaData:GetDrawCost(slot1, 1)
	slot0.bigDrawText_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_POOL_TIPS"), slot3)
	slot0.drawCostText_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_POOL_TIPS"), 1)
	slot0.bigDrawCostText_.text = "<color=#" .. (slot2 < uv0 and "CC0013" or "F3E7C3") .. ">x" .. slot7 .. "</color>"
	slot0.drawText_.text = "<color=#" .. (slot2 == 0 and "CC0013" or "F3E7C3") .. ">x" .. slot9 .. "</color>"
	slot0.bigDrawTimes = slot3
	slot0.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_POOL_NAME")
	slot0.getText_.text = GetTips("ACTIVITY_COMBINE_GAME_DRAW_POOL_FINISH")
	slot0.draw1Img_.sprite = ItemTools.getItemSprite(slot4)
	slot0.draw2Img_.sprite = ItemTools.getItemSprite(slot4)

	for slot14, slot15 in ipairs(KagutsuchiGachaData:GetDisplayDrawItemIds(slot1)) do
		slot0.poolRewardItem_[slot14]:SetData(ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL, slot1, slot15)
	end
end

function slot0.TryStartDraw(slot0, slot1)
	slot2 = KagutsuchiGachaData:GetPoolIds(ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL)[1]
	slot3 = KagutsuchiGachaData:GetMaxDrawTimes(slot2)

	if KagutsuchiGachaData:GetPoolRemains(slot2) == 0 then
		ShowTips("ACTIVITY_COMBINE_GAME_DRAW_POOL_FINISH")

		return
	end

	if slot3 < slot1 then
		ShowTips("ACTIVITY_COMBINE_GAME_DRAW_POOL_COST_NOT_ENOUGH")

		return
	end

	KagutsuchiGachaAction:StartDraw(slot1, ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL, slot2, handler(slot0, slot0.OnFinishDraw))
end

function slot0.OnFinishDraw(slot0, slot1, slot2)
	slot0:UpdateView()

	slot4 = {}

	for slot8, slot9 in ipairs(slot1.reward_list) do
		slot10, slot11 = KagutsuchiGachaData:GetDrawItemReward(slot1.pool_id, slot9)

		table.insert(slot4, {
			id = slot10,
			num = slot11
		})
	end

	getReward(slot4)
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.draw1Btn_.transform, RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL .. "ONE", {
		x = 150,
		y = 35
	})
	manager.redPoint:bindUIandKey(slot0.draw10Btn_.transform, RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL .. "TEN", {
		x = 150,
		y = 35
	})
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.draw10Btn_.transform, RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL .. "TEN")
	manager.redPoint:unbindUIandKey(slot0.draw1Btn_.transform, RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL .. "ONE")
end

function slot0.OnExit(slot0)
	for slot4, slot5 in ipairs(slot0.poolRewardItem_) do
		slot0.poolRewardItem_[slot4]:OnExit()
	end

	slot0:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function slot0.OnTop(slot0)
	slot2, slot3 = KagutsuchiGachaData:GetDrawCost(KagutsuchiGachaData:GetPoolIds(ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL)[1], 1)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		slot2
	})
	manager.windowBar:SetBarCanAdd(slot2, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_COMBINE_GAME_DRAW_POOL_DESC")
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.poolRewardItem_) do
		slot0.poolRewardItem_[slot4]:Dispose()
	end

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
