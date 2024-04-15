slot0 = class("IdolTraineeEnterBattleView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/IdolTrainee/IdolBattleEnterView"
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

	slot0.raceData_ = {}
	slot0.styleData_ = {}
	slot0.selectHeroPage_ = EnterBattleSelectHeroPage.New(slot0.selectHeroGo_)

	slot0.selectHeroPage_:ShowPage(false)

	slot0.selectOpponentPage_ = EnterBattleSelectOpponentPage.New(slot0.selectOpponentGo_)

	slot0.selectOpponentPage_:ShowPage(false)

	slot0.stageInfoPage = IdolTraineeStageInfoPage.New(slot0.stageInfo)

	slot0.stageInfoPage:ShowPage(true)

	slot0.showHistoryController = slot0.mainControllerEx_:GetController("showHistory")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.historyBtn_, nil, function ()
		if uv0.pvpBattle_ then
			IdolTraineeAction.AskHistoryBattleData(function ()
				JumpTools.OpenPageByJump("idolTraineeBattleHistoryPop")
			end)
		end
	end)
	slot0:AddBtnListener(slot0.enterBtn_, nil, function ()
		if uv0.selectOpponentPage_.showFlag and uv0.pvpBattle_ then
			return
		end

		slot1 = nil

		for slot5, slot6 in pairs(IdolTraineeData:GetCurAttackHero()) do
			if slot6 == true then
				slot1 = slot5
			end
		end

		if slot1 then
			if uv0.pvpBattle_ then
				uv0.selectOpponentPage_:ShowPage(true)
				SetActive(uv0.maskImg_.gameObject, true)
			elseif uv0.stageID_ then
				BackHomeCricketAction:AskPvEBattleData(uv0.stageID_)
			end
		end
	end)
	slot0:AddBtnListener(slot0.heroBtn, nil, function ()
		uv0.selectHeroPage_:ShowPage(true)
		SetActive(uv0.maskImg_.gameObject, true)
	end)
end

function slot0.RefreshBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		if uv0.selectOpponentPage_.showFlag then
			uv0.selectOpponentPage_:ShowPage(false)

			if not uv0.selectHeroPage_.showFlag then
				SetActive(uv0.maskImg_.gameObject, false)
			end

			return
		end

		if uv0.selectHeroPage_.showFlag then
			uv0.selectHeroPage_:ShowPage(false)
			SetActive(uv0.maskImg_.gameObject, false)

			uv0.selectHeroPage_.curHeroID_ = nil

			uv0.showHistoryController:SetSelectedState("open")

			if uv0.pvpBattle_ then
				uv0.showHistoryController:SetSelectedState("open")
			else
				uv0.showHistoryController:SetSelectedState("close")
			end

			return
		end

		IdolTraineeCampBridge.SetVCamActive("CamShootAtTrainningPos", false)
		uv0:Back()
	end)
	manager.windowBar:RegistHomeCallBack(function ()
		uv0.selectOpponentPage_:ShowPage(false)
		SetActive(uv0.maskImg_.gameObject, false)
		uv0.selectHeroPage_:ShowPage(false)

		uv0.selectHeroPage_.curHeroID_ = nil

		IdolTraineeCampBridge.SetVCamActive("CamShootAtTrainningPos", false)
		JumpTools.OpenPageByJump("/idolTraineeCamp")
	end)
end

function slot0.OnEnter(slot0)
	IdolTraineeCampBridge.SetVCamActive("CamShootAtTrainningPos", true)
	slot0:RefreshBar()

	slot0.pvpBattle_ = slot0.params_.pvpBattle
	slot0.stageID_ = slot0.params_.stageID

	if slot0.pvpBattle_ then
		slot0.stageID_ = IdolTraineeData:GetCurPVPStage()

		slot0.showHistoryController:SetSelectedState("open")
	else
		slot0.showHistoryController:SetSelectedState("close")
	end

	slot0.stageInfoPage:SetParams(slot0.params_)
	slot0.stageInfoPage:OnEnter()
	slot0.selectHeroPage_:OnEnter()
	slot0.selectHeroPage_:RefreshUI()
	slot0.selectOpponentPage_:OnEnter()
end

function slot0.StopWaitCamBlend(slot0)
	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0.selectHeroPage_:OnExit()
	slot0.selectOpponentPage_:OnExit()
	slot0:StopWaitCamBlend()
end

function slot0.Dispose(slot0)
	slot0:StopWaitCamBlend()
	slot0.selectHeroPage_:Dispose()
	slot0.selectOpponentPage_:Dispose()
	slot0.stageInfoPage:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnTop(slot0)
	slot0.gameObject_.layer = 18
	slot0.maskImg_.enabled = true
end

function slot0.OnBehind(slot0)
	slot0.gameObject_.layer = 5
	slot0.maskImg_.enabled = false
end

return slot0
