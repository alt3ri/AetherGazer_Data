slot0 = class("KagutsuchiWorkPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionWorkUI/JapanRegionWorkDispatchUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
	slot0:RegistEventListener(NEW_DAY, handler(slot0, slot0.OnNewDay))

	slot0.winController_ = ControllerUtil.GetController(slot0.transform_, "window")
	slot0.entrustingController_ = ControllerUtil.GetController(slot0.transform_, "entrusting")
	slot0.heroScroll = LuaList.New(handler(slot0, slot0.IndexItem), slot0.heroUiList_, KagutsuchiWorkEntrustHeroItem)
	slot0.commonItem_ = CommonItem.New(slot0.rewardGo_)
end

function slot0.OnEnter(slot0)
	slot0.isEntrusting = true

	slot0:RefreshHeroList()
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	slot0.isEntrusting = false
	slot0.isEntrustFinished = false
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.bgmask_, nil, function ()
		uv0.isEntrusting = false
		uv0.isEntrustFinished = false

		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.entrustCancelBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.finishBtn_, nil, function ()
		uv0.isEntrusting = false
		uv0.isEntrustFinished = false

		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.entrustStartBtn_, nil, function ()
		if uv0.heroselectedNum < KagutsuchiWorkData:GetMinEntrustHeroNum() then
			ShowTips("ACTIVITY_KAGUTSUCHI_BATTLE_ENTRUST_FAIL_TIPS")

			return
		end

		uv0:StartEntrust()
	end)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetHeroData(slot0.heroIdList[slot1])
	slot2:TrySetSelected(slot0.heroSelected[slot1])
	slot2:RefreshUI()
	slot2:SetClickHandler(function (slot0, slot1)
		if uv0.heroSelected[uv1] then
			uv2:TrySetSelected(false)

			uv0.heroSelected[uv1] = false
			uv0.heroselectedNum = uv0.heroselectedNum - 1

			uv2:RefreshUI()
			uv0:RefreshUI()
		elseif KagutsuchiWorkData:GetMinEntrustHeroNum() <= uv0.heroselectedNum then
			return
		elseif uv2:TrySetSelected(true) then
			uv0.heroSelected[uv1] = true
			uv0.heroselectedNum = uv0.heroselectedNum + 1

			uv2:RefreshUI()
			uv0:RefreshUI()
		end
	end)
end

function slot0.RefreshHeroList(slot0)
	if slot0.params_.isBattle then
		return
	end

	slot0.heroIdList = KagutsuchiWorkData:GetEntrustHeroIdList()

	slot0:SortHeroIdList()

	slot0.heroSelected = {}

	for slot4 = 1, #slot0.heroIdList do
		slot0.heroSelected[slot4] = false
	end

	slot0.heroselectedNum = 0

	slot0.heroScroll:StartScroll(#slot0.heroIdList)
end

function slot0.JumpToBattlePage(slot0)
	gameContext:Go("/sectionSelectHero", {
		section = slot0.params_.stageId,
		sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME,
		activityID = slot0.params_.activityId
	})
end

function slot0.StartEntrust(slot0)
	slot1 = {}

	for slot5 = 1, #slot0.heroIdList do
		if slot0.heroSelected[slot5] then
			table.insert(slot1, slot0.heroIdList[slot5])
		end
	end

	KagutsuchiWorkAction:StartEntrust(slot0.params_.gridId, slot1, handler(slot0, slot0.FinishEntrust))
end

function slot0.FinishEntrust(slot0, slot1)
	slot0.isEntrustFinished = true
	slot0.entrustReward = slot0.params_.entrustReward

	slot0:RefreshUI()

	if slot0.params_.entrustFinishHandler_ then
		slot0.params_.entrustFinishHandler_(slot1)
	end
end

function slot0.RefreshUI(slot0)
	if slot0.params_.isBattle then
		slot0:RefreshBattleUI()
	else
		slot0:RefreshEntrustUI()
	end
end

function slot0.RefreshBattleUI(slot0)
	slot0.battleTitleText_.text = slot0.params_.battleName
	slot0.battleLevelText_.text = "Lv." .. slot0.params_.battleLevel
	slot0.battleSummaryText_.text = slot0.params_.battleSummary
	slot0.battleRewardText_.text = "x" .. slot0.params_.battleReward
	slot0.battleCostText_.text = "x" .. slot0.params_.battleCost

	slot0.winController_:SetSelectedState("battle")
end

function slot0.RefreshEntrustUI(slot0)
	if slot0.isEntrustFinished then
		slot1 = ItemCfg[CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id]

		slot0.commonItem_:RefreshData({
			id = slot1.id,
			type = slot1.type,
			number = slot0.params_.entrustReward
		})

		slot0.finishText_.text = slot0.params_.entrustCompleteText

		slot0.winController_:SetSelectedState("finish")
	elseif slot0.isEntrusting then
		slot1 = KagutsuchiWorkData:GetMinEntrustHeroNum()
		slot0.entrustingNumText_.text = string.format("%d/%d", slot0.heroselectedNum, slot1)

		if slot0.heroselectedNum == slot1 then
			slot0.entrustingController_:SetSelectedState("valid")
		else
			slot0.entrustingController_:SetSelectedState("invalid")
		end

		slot0.winController_:SetSelectedState("entrusting")
	end
end

function slot0.Dispose(slot0)
	slot0.commonItem_:Dispose()

	slot0.commonItem_ = nil

	if slot0.heroScroll then
		slot0.heroScroll:Dispose()

		slot0.heroScroll = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.OnNewDay(slot0)
	if gameContext:IsOpenRoute("kagutsuchiWorkPop") then
		slot0:Back()
	end
end

function slot0.OnKagutsuchiWorkDataInit(slot0)
	slot0:OnNewDay()
end

function slot0.SortHeroIdList(slot0)
	table.sort(slot0.heroIdList, function (slot0, slot1)
		return uv0:GetHeroPriority(slot1) < uv0:GetHeroPriority(slot0)
	end)
end

function slot0.GetHeroPriority(slot0, slot1)
	if HeroData:GetHeroData(slot1).unlock == 0 then
		return 1
	end

	if slot2.level < KagutsuchiWorkData:GetMinEntrustHeroLevel() then
		return 2
	end

	if KagutsuchiWorkData:IsEntrusted(slot1) then
		return 3
	end

	return 4
end

return slot0
