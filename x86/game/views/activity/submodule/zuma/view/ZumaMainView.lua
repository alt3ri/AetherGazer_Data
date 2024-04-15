slot0 = class("ZumaGameView", ReduxView)
slot1 = {
	tabState = {
		hard = "state1",
		name = "tab",
		night = "state2",
		easy = "state0"
	},
	tabLockState = {
		onlyNightLock = "state1",
		name = "lock",
		onlyEasyOpen = "state2",
		allOpen = "state0"
	},
	rankShow = {
		noData = "state0",
		name = "ranking",
		showData = "state1"
	}
}

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaUI"
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

	slot0.leftRootTrsCanvas = slot0.leftRootTrs_:GetComponent(typeof(CanvasGroup))
	slot0.tabStateController = slot0.controllerexcollection_:GetController(uv0.tabState.name)
	slot0.tabLockStateController = slot0.controllerexcollection_:GetController(uv0.tabLockState.name)
	slot0.rankShowController = slot0.controllerexcollection_:GetController(uv0.rankShow.name)
	slot0.chapterInfoView = ZumaMainViewChapterInfo.New(slot0.chaptersectioninfouiGo_)

	slot0.chapterInfoView:IsShowPanel(false)

	slot0.stageInfoViewList = {}

	for slot5, slot6 in pairs(ZumaConst.ZUMA_DIFFICULT or {}) do
		slot0.stageInfoViewList[slot6] = ZumaMainStageInfoView.New(slot0[({
			"easystageGo_",
			"hardstageGo_",
			"nightmarestageGo_"
		})[slot6]], slot6)
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.easyBtn_, nil, function ()
		uv0:OnClickStageDifficultChangeBtn(ZumaConst.ZUMA_DIFFICULT.ESAY)
	end)
	slot0:AddBtnListener(slot0.hardBtn_, nil, function ()
		uv0:OnClickStageDifficultChangeBtn(ZumaConst.ZUMA_DIFFICULT.HARD)
	end)
	slot0:AddBtnListener(slot0.nightmareBtn_, nil, function ()
		uv0:OnClickStageDifficultChangeBtn(ZumaConst.ZUMA_DIFFICULT.NIGHT)
	end)
	slot0:AddBtnListener(slot0.taskBtn_, nil, function ()
		JumpTools.OpenPageByJump("ZumaTask")
	end)
	slot0:AddBtnListener(slot0.talentBtn_, nil, function ()
		JumpTools.OpenPageByJump("/ZumaTalent")
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:RefreshZumaChapterInfo()
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:RefreshZumaChapterInfo()
	end)
	slot0:AddBtnListener(slot0.btnrankingBtn_, nil, function ()
		uv0:OnClickRankBtn()
	end)
	slot0:RegistEventListener(ACTIVITY_UPDATE, function (slot0)
		if ActivityTools.GetActivityType(slot0) == ActivityTemplateConst.ACTIVITY_ZUMA_ENTER or slot1 == ActivityTemplateConst.ACTIVITY_ZUMA then
			uv0:UpdateStageList()
			uv0.chapterInfoView:UpdateBtnController()
		end
	end)
end

function slot0.OnClickRankBtn(slot0)
	JumpTools.OpenPageByJump("/ZumaRank", {
		rank_activity_id = 242881
	})
end

function slot0.OnClickStageDifficultChangeBtn(slot0, slot1)
	if slot0.selectDifficultType == slot1 then
		return
	end

	slot2 = nil

	if slot1 == ZumaConst.ZUMA_DIFFICULT.ESAY then
		slot2 = uv0.tabState.easy
	elseif slot1 == ZumaConst.ZUMA_DIFFICULT.HARD then
		slot2 = uv0.tabState.hard
	elseif slot1 == ZumaConst.ZUMA_DIFFICULT.NIGHT then
		slot2 = uv0.tabState.night
	end

	slot0.tabStateController:SetSelectedState(slot2)

	slot0.selectDifficultType = slot1

	if slot0.selectDifficultType == ZumaConst.ZUMA_DIFFICULT.NIGHT then
		if slot0.stageInfoViewList[slot1]:GetAllScore() == 0 then
			slot0.rankShowController:SetSelectedState(uv0.rankShow.noData)
		else
			slot0.rankShowController:SetSelectedState(uv0.rankShow.showData)
		end

		slot0.numText_.text = slot3
	end
end

function slot0.RefreshZumaChapterInfo(slot0, slot1)
	if not slot1 then
		slot0.chapterInfoView:IsShowPanel(false)

		if slot0.selectStageItem then
			slot0.selectStageItem:UpdateSelectState(false)
			slot0.stageInfoViewList[slot0.selectDifficultType]:UpdateMoveView()
		end

		slot0.selectStageItem = nil
		slot0.leftRootTrsCanvas.blocksRaycasts = true

		return
	end

	slot0.chapterInfoView:RefreshUi(slot1)

	slot0.leftRootTrsCanvas.blocksRaycasts = false
end

function slot0.UpdateZumaStageSelectItem(slot0, slot1)
	slot0:SelectStageItem(slot1)
end

function slot0.SelectStageItem(slot0, slot1)
	if slot0.selectStageItem == slot0.stageInfoViewList[slot0.selectDifficultType]:GetTragetItem(slot1) then
		return
	end

	if slot0.selectStageItem then
		slot0.selectStageItem:UpdateSelectState(false)
	end

	slot0.selectStageItem = slot2

	slot0.selectStageItem:UpdateSelectState(true)
	slot0:RefreshZumaChapterInfo(slot0.selectStageItem:GetLevelCfg())
	slot0.stageInfoViewList[slot0.selectDifficultType]:UpdateMoveView(slot1)
end

function slot0.DefaultSelectChapter(slot0)
	if slot0.selectDifficultType ~= nil then
		return
	end

	slot0:OnClickStageDifficultChangeBtn(ActivityZumaLevelCfg[ZumaData:GetZumaGameId()] and ActivityZumaLevelCfg[slot1].difficult or ZumaConst.ZUMA_DIFFICULT.ESAY)
	slot0.stageInfoViewList[slot0.selectDifficultType]:DefalutSelect(slot1)
	ZumaData:SetZumaGameId(0)
end

function slot0.UpdateStageList(slot0, slot1, slot2)
	if slot1 then
		slot0.stageInfoViewList[slot1]:RefreshStageUi(slot2)
	else
		for slot6, slot7 in pairs(slot0.stageInfoViewList) do
			slot7:RefreshStageUi()
		end
	end
end

function slot0.GetDiffcultBtnRedTrs(slot0, slot1)
	slot2 = nil

	if slot1 == ZumaConst.ZUMA_DIFFICULT.ESAY then
		slot2 = slot0.easyBtn_.transform
	elseif slot1 == ZumaConst.ZUMA_DIFFICULT.HARD then
		slot2 = slot0.hardBtn_.transform
	elseif slot1 == ZumaConst.ZUMA_DIFFICULT.NIGHT then
		slot2 = slot0.nightmareBtn_.transform
	end

	return slot2
end

function slot0.ShowDiffcultRed(slot0, slot1)
	for slot5, slot6 in pairs(slot0.stageInfoViewList) do
		slot6:SetRedState(slot1)

		for slot11, slot12 in pairs(slot6:GetDifficultCfgList()) do
			slot13 = slot12.activity_id

			if slot1 then
				manager.redPoint:bindUIandKey(slot0:GetDiffcultBtnRedTrs(slot5), string.format("%s_%s", RedPointConst.ZUMA_DIFFICULT, slot5))
			else
				manager.redPoint:unbindUIandKey(slot14, string.format("%s_%s", RedPointConst.ZUMA_DIFFICULT, slot5))
			end
		end
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		if uv0.chapterInfoView and uv0.chapterInfoView.isShow then
			uv0:RefreshZumaChapterInfo()
		else
			JumpTools.Back()
		end
	end)

	slot1 = GameSetting.activity_zuma_describe and GameSetting.activity_zuma_describe.value or {}

	manager.windowBar:RegistInfoCallBack(function ()
		if uv0.chapterInfoView and uv0.chapterInfoView.isShow then
			uv0:RefreshZumaChapterInfo()
		else
			JumpTools.OpenPageByJump("gameHelpPro", {
				isPrefab = true,
				pages = uv1
			})
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0:UpdateStageList()
	slot0:DefaultSelectChapter()
	slot0:ShowDiffcultRed(true)
	manager.redPoint:bindUIandKey(slot0.taskBtn_.transform, RedPointConst.ZUMA_REWARD)
	manager.redPoint:bindUIandKey(slot0.talentBtn_.transform, RedPointConst.ZUMA_TALENT)
	slot0:RefreshTime()
	slot0.chapterInfoView:OnEnter()

	if not getData("ZumaGame", "showHelp") then
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = GameSetting.activity_zuma_describe and GameSetting.activity_zuma_describe.value or {}
		})
		saveData("ZumaGame", "showHelp", 1)
	end
end

function slot0.RefreshTime(slot0)
	slot0.activityData_ = ActivityData:GetActivityData(ZumaData:GetZumaActivityID())
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
	slot0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(slot0.stopTime_, true)
	slot0.timer_ = Timer.New(function ()
		uv0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(uv0.stopTime_, true)
		uv0.stopTime_ = uv0.stopTime_ - 1
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnExit(slot0)
	slot0:RefreshZumaChapterInfo()
	manager.windowBar:HideBar()
	slot0:StopTimer()
	slot0:ShowDiffcultRed(false)
	slot0.chapterInfoView:OnExit()
	manager.redPoint:unbindUIandKey(slot0.taskBtn_.transform, RedPointConst.ZUMA_REWARD)
	manager.redPoint:unbindUIandKey(slot0.talentBtn_.transform, RedPointConst.ZUMA_TALENT)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.stageInfoViewList) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
	slot0.chapterInfoView:Dispose()
end

return slot0
