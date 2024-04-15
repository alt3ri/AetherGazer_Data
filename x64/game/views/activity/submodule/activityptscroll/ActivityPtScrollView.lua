slot0 = class("ActivityPtScrollView", ReduxView)

function slot0.UIName(slot0)
	return ActivityPtScrollTools.GetMainUIName(slot0.params_.mainActivityID)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:RefreshShop()

	slot0.normalBtn_ = {}
	slot0.challengeBtn_ = {}
	slot0.normalCon_ = {}
	slot0.challengeCon_ = {}
	slot0.normalLevel_ = {}
	slot0.challengeLevel_ = {}

	for slot5, slot6 in ipairs(ActivityPtRouletteStageCfg.get_id_list_by_activity_id[slot0.params_.mainActivityID]) do
		if ActivityPtRouletteStageCfg[slot6].mode == 1 then
			table.insert(slot0.normalLevel_, ActivityPtRouletteStageCfg[slot6].stage_id)
		else
			table.insert(slot0.challengeLevel_, ActivityPtRouletteStageCfg[slot6].stage_id)
		end
	end

	for slot5, slot6 in ipairs(slot0.normalLevel_) do
		table.insert(slot0.normalBtn_, slot0["normalBtn_" .. slot5])
		table.insert(slot0.normalCon_, ControllerUtil.GetController(slot0["normalBtn_" .. slot5].transform, "status"))
	end

	for slot5, slot6 in ipairs(slot0.challengeLevel_) do
		table.insert(slot0.challengeBtn_, slot0["challengeBtn_" .. slot5])
		table.insert(slot0.challengeCon_, ControllerUtil.GetController(slot0["challengeBtn_" .. slot5].transform, "status"))
	end

	slot0.tgl_ = {
		slot0.tgl_1,
		slot0.tgl_2
	}
	slot0.typeCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "type")
	slot0.indexCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "index")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		if uv0:IsOpenSectionView() then
			JumpTools.Back()
			uv0.indexCon_:SetSelectedIndex(0)

			uv0.selectLevel_ = 0
		end

		slot6 = ActivityShopCfg[ActivityPtScrollTools.GetShopActivityID(uv0.mainActivityID_)].activity_theme

		for slot6, slot7 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[slot6]) do
			if ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[slot7].shop_id].activity_id) and slot9:IsActivitying() then
				table.insert({}, ActivityShopCfg[slot7].shop_id)
			end
		end

		slot3, slot4 = ShopTools.IsShopOpen(slot1.shop_id)

		if slot3 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = slot1.shop_id,
				showShops = slot2
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif slot4 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif slot4 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	slot0:AddBtnListener(slot0.buffBtn_, nil, function ()
		JumpTools.OpenPageByJump("activityPtScrollPop", {
			isScroll = false,
			mainActivityID = uv0.mainActivityID_
		})
	end)
	slot0:AddBtnListener(slot0.affixBtn_, nil, function ()
		JumpTools.OpenPageByJump("activityPtScrollAffixSelect", {
			mainActivityID = uv0.mainActivityID_
		})
	end)

	slot4 = slot0.bgBtn_
	slot5 = nil

	slot0:AddBtnListener(slot4, slot5, function ()
		if uv0:IsOpenSectionView() then
			JumpTools.Back()
			uv0.indexCon_:SetSelectedIndex(0)

			uv0.selectLevel_ = 0
		end
	end)

	for slot4, slot5 in ipairs(slot0.tgl_) do
		slot0:AddToggleListener(slot5, function (slot0)
			if slot0 then
				if uv0:IsOpenSectionView() then
					uv0.tgl_[uv0.index_].isOn = true

					return
				end

				if uv1 ~= uv0.index_ then
					uv0.index_ = uv1
				end

				if uv0.index_ == 2 then
					uv0:CheckScroll()
				end

				uv0.indexCon_:SetSelectedState(0)
				uv0.typeCon_:SetSelectedState(uv1)
				ActivityPtScrollData:SetLastStage(uv0.mainActivityID_, uv1, 1)
			end
		end)
	end

	for slot4, slot5 in ipairs(slot0.normalBtn_) do
		slot0:AddBtnListener(slot5, nil, function ()
			if uv0.stopTime_ <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")

				return
			end

			uv0:EnterLevel(1, uv1)
		end)
	end

	for slot4, slot5 in ipairs(slot0.challengeBtn_) do
		slot0:AddBtnListener(slot5, nil, function ()
			if uv0.stopTime_ <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")

				return
			end

			uv0:EnterLevel(2, uv1)
		end)
	end

	if slot0.eventTrigger_ then
		slot0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
			if uv0:IsOpenSectionView() then
				JumpTools.Back()
			end

			uv0.drag_ = true
		end))
		slot0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
			uv0.drag_ = false
		end))
	end
end

function slot0.OnEnter(slot0)
	if slot0.mainActivityID_ and slot0.mainActivityID_ ~= slot0.params_.mainActivityID then
		slot0.mainActivityID_ = slot0.params_.mainActivityID

		slot0:ReLoad()
	end

	slot0:RefreshUI()
end

function slot0.ReLoad(slot0)
	if slot0.gameObject_ then
		slot0:Dispose()
		Object.Destroy(slot0.gameObject_)
	end

	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot0:UIName()), slot0:UIParent())
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshData()
	slot0:RefreshTime()
	slot0:RefreshState()
	slot0:BindRedPointUI()
end

function slot0.RefreshData(slot0)
	slot0.mainActivityID_ = slot0.params_.mainActivityID
	slot0.activityID_ = ActivityPtScrollTools.GetLevelActivityID(slot0.mainActivityID_)
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
end

function slot0.RefreshTime(slot0)
	slot2 = ActivityData:GetActivityData(slot0.mainActivityID_).stopTime

	slot0:StopTimer()

	if manager.time:GetServerTime() < slot0.startTime_ then
		SetActive(slot0.shopTimeGo_, false)

		slot0.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		slot0.timer_ = Timer.New(function ()
			if uv0.startTime_ <= manager.time:GetServerTime() then
				uv0:StopTimer()
				uv0:RefreshTime()

				return
			end
		end, 1, -1)

		slot0.timer_:Start()
	elseif slot3 < slot2 then
		if slot3 < slot0.stopTime_ then
			slot0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(slot0.stopTime_)
		else
			slot0.timeLable_.text = GetTips("TIME_OVER")
		end

		if GameSetting.time_remaining_show.value[1] * 86400 > slot2 - slot3 then
			slot0.shopTimeLable_.text = manager.time:GetLostTimeStrWith2Unit(slot2)

			SetActive(slot0.shopTimeGo_, true)
		else
			SetActive(slot0.shopTimeGo_, false)
		end

		slot0.timer_ = Timer.New(function ()
			uv0 = manager.time:GetServerTime()

			if uv1 <= uv0 then
				uv2:StopTimer()
				uv2:RefreshTime()

				return
			end

			if uv0 < uv2.stopTime_ then
				uv2.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(uv2.stopTime_)
			else
				uv2.timeLable_.text = GetTips("TIME_OVER")
			end

			if GameSetting.time_remaining_show.value[1] * 86400 > uv1 - uv0 then
				uv2.shopTimeLable_.text = manager.time:GetLostTimeStrWith2Unit(uv1)

				SetActive(uv2.shopTimeGo_, true)
			else
				SetActive(uv2.shopTimeGo_, false)
			end
		end, 1, -1)

		slot0.timer_:Start()
	else
		SetActive(slot0.shopTimeGo_, true)

		slot0.timeLable_.text = GetTips("TIME_OVER")
		slot0.shopTimeLable_.text = GetTips("TIME_OVER")
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshState(slot0)
	slot0:RefreshLevel()
	slot0:RefreshReward()
	slot0:RefreshBuff()
	slot0:RefreshServant()
end

function slot0.RefreshLevel(slot0)
	slot0.index_ = ActivityPtScrollData:GetLastStage(slot0.mainActivityID_) and slot1.type or 1

	slot0.typeCon_:SetSelectedState(slot0.index_)

	slot0.tgl_[slot0.index_].isOn = true
	slot0.selectLevel_ = 0

	if slot0:IsOpenSectionView() and slot1 then
		slot0.indexCon_:SetSelectedState(slot1.type .. "_" .. slot1.index)
	else
		slot0.indexCon_:SetSelectedState(0)
	end

	if slot0.index_ == 2 then
		slot0:CheckScroll()
	end
end

function slot0.RefreshReward(slot0)
	for slot5, slot6 in ipairs(slot0.normalLevel_) do
		if table.indexof(ActivityPtScrollData:GetClearList(slot0.mainActivityID_), slot6) then
			slot0.normalCon_[slot5]:SetSelectedState("get")
		else
			slot0.normalCon_[slot5]:SetSelectedState("nor")
		end
	end

	for slot5, slot6 in ipairs(slot0.challengeLevel_) do
		if table.indexof(slot1, slot6) then
			slot0.challengeCon_[slot5]:SetSelectedState("get")
		else
			slot0.challengeCon_[slot5]:SetSelectedState("nor")
		end
	end
end

function slot0.RefreshBuff(slot0)
	if ActivityPtScrollData:GetAffixInfo(slot0.mainActivityID_, ActivityPtScrollData:GetChooseAffixID(slot0.mainActivityID_)).useless then
		slot3 = ActivityPtRouletteTipsCfg[slot2.affix]
		slot0.buffIcon_.sprite = getSpriteWithoutAtlas(SpritePathCfg.AffixIcon.path .. slot3.icon)
		slot0.buffText_.text = slot3.desc
	else
		slot0.buffIcon_.sprite = getAffixSprite({
			slot2.affix
		})
		slot0.buffText_.text = getAffixDesc({
			slot2.affix,
			slot2.level
		})
	end
end

function slot0.RefreshServant(slot0)
	slot1, slot2 = ActivityPtScrollData:GetUpSelect(slot0.mainActivityID_)

	if EquipSuitCfg[slot2] then
		slot0.keyText_.text = slot3.name

		SetSpriteWithoutAtlasAsync(slot0.keyIcon_, SpritePathCfg.EquipIcon_s.path .. slot2)
	end
end

function slot0.CheckScroll(slot0)
	if (getData("activityPtScroll", "last_scroll_time") or 0) < manager.time:GetTodayFreshTime() then
		JumpTools.OpenPageByJump("activityPtScrollPop", {
			isScroll = true,
			mainActivityID = slot0.mainActivityID_
		})
		saveData("activityPtScroll", "last_scroll_time", manager.time:GetServerTime())
	end
end

function slot0.EnterLevel(slot0, slot1, slot2)
	slot0.selectLevel_ = slot2

	ActivityPtScrollData:SetLastStage(slot0.mainActivityID_, slot1, slot2)
	slot0.indexCon_:SetSelectedState(slot1 .. "_" .. slot2)

	slot3 = nil

	if slot1 == 1 then
		slot3 = slot0.normalLevel_[slot2]
	elseif slot1 == 2 then
		slot3 = slot0.challengeLevel_[slot2]
	end

	JumpTools.OpenPageByJump("activityPtScrollSectionInfo", {
		section = slot3,
		sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL,
		mainActivityID = slot0.mainActivityID_,
		activityId = slot0.mainActivityID_,
		repeat_id = repeatID,
		backCall = function ()
			uv0.indexCon_:SetSelectedIndex(0)

			uv0.selectLevel_ = 0
		end
	})

	slot4 = nil
end

function slot0.IsOpenSectionView(slot0)
	return slot0:IsOpenRoute("activityPtScrollSectionInfo")
end

function slot0.OnSetSelectSuit(slot0)
	slot0:RefreshServant()
end

function slot0.RefreshShop(slot0)
	slot0.shopName_.text = ShopListCfg[ActivityShopCfg[ActivityPtScrollTools.GetShopActivityID(slot0.params_.mainActivityID)].shop_id].remark
end

function slot0.BindRedPointUI(slot0)
	manager.redPoint:bindUIandKey(slot0.upRect_, RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. slot0.mainActivityID_)
	manager.redPoint:bindUIandKey(slot0.tgl_2.transform, RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. slot0.mainActivityID_)
end

function slot0.UnbindRedPointUI(slot0)
	manager.redPoint:unbindUIandKey(slot0.upRect_, RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. slot0.mainActivityID_)
	manager.redPoint:unbindUIandKey(slot0.tgl_2.transform, RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. slot0.mainActivityID_)
end

function slot0.OnTop(slot0)
	if ActivityPtScrollTools.GetHelpKey(slot0.mainActivityID_) ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR,
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			ActivityPtScrollTools.GetChallengeCurrencyID(slot0.mainActivityID_),
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
		manager.windowBar:SetGameHelpKey(slot1)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			slot2,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
	end

	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanClick(slot2, true)
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	slot0:UnbindRedPointUI()
	manager.windowBar:HideBar()
	slot0.indexCon_:SetSelectedState(-1)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
