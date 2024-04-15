slot0 = class("AdvanceTestMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/AdvancetestingUI/AtestingMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.mainActivityID = AdvanceTestData:GetMainActivityID()

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.stageEasyItem_ = AdvanceTestMainItem.New(slot0.stageEasyGo_, 1)
	slot0.stageNormalItem_ = AdvanceTestMainItem.New(slot0.stageNormalGo_, 2)
	slot0.stageHardItem_ = AdvanceTestMainItem.New(slot0.stageHardGo_, 3)
	slot0.stageItem_ = {
		slot0.stageEasyItem_,
		slot0.stageNormalItem_,
		slot0.stageHardItem_
	}
	slot0.bossItem_ = AdvanceTestBossItem.New(slot0.bossItem_)
	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.clickItemHandler = handler(slot0, slot0.ChooseItemMode)

	slot0.stageEasyItem_:RegistClickFunc(slot0.clickItemHandler)
	slot0.stageNormalItem_:RegistClickFunc(slot0.clickItemHandler)
	slot0.stageHardItem_:RegistClickFunc(slot0.clickItemHandler)

	slot0.clickBossBtnHandler = handler(slot0, slot0.ClickBtn)

	slot0.bossItem_:RegistClickFunc(slot0.clickBossBtnHandler)
end

function slot0.ChooseItemMode(slot0, slot1)
	slot0.chooseIndex_ = slot1

	slot0:RefreshUI()
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	slot1 = ActivityData:GetActivityData(slot0.mainActivityID)
	slot0.startTime_ = slot1.startTime
	slot0.stopTime_ = slot1.stopTime
	slot0.chooseIndex_ = AdvanceTestData:GetLastSelectIndex()
	slot0.goBtn_.enabled = false

	AdvanceTestData:InitDefalutHeroList()
	manager.windowBar:RegistBackCallBack(function ()
		if uv0.selectController_:GetSelectedState() == "detail" then
			uv0.selectController_:SetSelectedState("list")
		else
			JumpTools.Back()
		end
	end)
	manager.windowBar:RegistHomeCallBack(function ()
		uv0.selectController_:SetSelectedState("list")
		gameContext:Go("/home", nil, , true)
	end)
	manager.windowBar:SetGameHelpKey(GetTips("TEST_CHALLENGE_DESCRIBE"))

	slot2 = AdvanceTestCfg.get_id_list_by_activity_id[slot0.mainActivityID]

	for slot6 = 1, 3 do
		SetActive(slot0.stageItem_[slot6].gameObject_, false)
	end

	for slot6 = 1, 3 do
		if slot2[slot6] then
			SetActive(slot0.stageItem_[AdvanceTestCfg[slot2[slot6]].stage_type].gameObject_, true)
		end
	end

	slot0:RefreshUI()
	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	slot0.chooseIndex_ = nil

	slot0.selectController_:SetSelectedState("list")

	slot0.panelAni_.enabled = true

	slot0:StopTimer()
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.clickItemHandler = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		uv0.selectController_:SetSelectedState("detail")
	end)
	slot0:AddBtnListener(slot0.rankBtn_, nil, function ()
		slot1 = manager.time:GetServerTime()

		if AdvanceTestData:GetCurActivityID() ~= 0 then
			slot2 = ActivityData:GetActivityData(slot0)

			if slot2.startTime < slot1 and slot1 < slot2.stopTime then
				gameContext:Go("/advanceTestRank", {
					activityID = slot0,
					stageType = uv0.chooseIndex_
				})

				return
			end
		end

		ShowTips("SOLO_NOT_OPEN")
	end)
end

function slot0.ClickBtn(slot0)
	AdvanceTestData:SetLastSelectIndex(slot0.chooseIndex_)

	slot1 = AdvanceTestData:GetCurCfgByIndex(slot0.chooseIndex_)

	AdvanceTestData:SetHeroListByDifficult(slot1.stage_type)
	gameContext:Go("/sectionSelectHero", {
		section = slot1.stage_id,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST,
		stageDifficult = slot1.stage_type,
		activityID = slot0.mainActivityID,
		dest = slot1.id
	})
end

function slot0.RefreshUI(slot0)
	SetActive(slot0.panelGo_, true)

	if string.split(GetTips("TEST_CHALLENGE_TIPS_1"), ",") ~= nil then
		slot0.tipTopText_.text = string.format(slot1[1], slot0:GetStrByIndex(slot0.chooseIndex_))
		slot0.tipBottomText_.text = string.format(slot1[2], AdvanceTestData:GetCurCfgByIndex(slot0.chooseIndex_).weapon)
	end

	slot0.chooseIndex_ = slot0.chooseIndex_

	slot0.stageEasyItem_:RefreshUI(slot0.chooseIndex_)
	slot0.stageNormalItem_:RefreshUI(slot0.chooseIndex_)
	slot0.stageHardItem_:RefreshUI(slot0.chooseIndex_)
	slot0.bossItem_:RefreshUI(slot0.chooseIndex_)
end

function slot0.GetStrByIndex(slot0, slot1)
	slot2 = nil

	if slot1 == 1 then
		slot2 = "SS"
	elseif slot1 == 2 then
		slot2 = "SSS"
	elseif slot1 == 3 then
		slot2 = "Ω"
	end

	return slot2
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot0.leftTimeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(slot0.stopTime_, nil, true)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ < manager.time:GetServerTime() then
			return
		end

		uv0.leftTimeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(uv0.stopTime_, nil, true)
	end, 1, -1)

	slot0.timer_:Start()

	slot0.aniTimer_ = Timer.New(function ()
		uv0.panelAni_.enabled = false
		uv0.goBtn_.enabled = true
	end, 0.5, 1)

	slot0.aniTimer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
