slot0 = class("CanteenManualRewardView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/canteen/EmptyDreamManualModeEndPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.materialItemScroll_ = LuaList.New(handler(slot0, slot0.refreshItem), slot0.listUilist_, FoodMaterialItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.okbtnBtn_, nil, function ()
		CanteenManualData:ExitManualState()
		JumpTools.OpenPageByJump("/restaurantMain")
	end)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		CanteenManualData:ExitManualState()
		JumpTools.OpenPageByJump("/restaurantMain")
	end)
end

function slot0.refreshItem(slot0, slot1, slot2)
	slot2:RefreshItem(slot0.materialList[slot1], nil, , DormEnum.FoodSellType.SignFood)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	for slot6, slot7 in pairs(CanteenManualData:GetManualInfo().manualSettlementList) do
		slot2 = 0 + 1
	end

	slot0.foodnumText_.text = slot2
	slot0.totalcustomernumText_.text = slot1.manualGenCusNum
	slot0.servercustomernumText_.text = slot1.manualSerCusNum
	slot0.rewardnumText_.text = slot1.manualTotalIncome
	slot0.maxpopnumText_.text = slot1.hightPopularityNum
	slot0.addpopnumText_.text = CanteenManualData:CalculateRemainPopularity()
	slot3, slot4 = nil
	slot5, slot6 = CanteenManualData:MostPopFoodIdAndNum()
	slot0.foodnameText_.text = GetI18NText(slot5)

	if slot6 > 0 then
		slot0.foodpopnumText_.text = string.format(GetTips("CANTEEN_SELL_INFO"), slot3)
	end

	slot0.materialList = CanteenManualData:ManualConsumeMaterial()

	slot0.materialItemScroll_:StartScroll(#slot0.materialList)
end

function slot0.Dispose(slot0)
	if slot0.materialItemScroll_ then
		slot0.materialItemScroll_:Dispose()

		slot0.materialItemScroll_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
