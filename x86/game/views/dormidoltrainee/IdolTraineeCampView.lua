slot0 = class("IdolTraineeCampView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/IdolTrainee/IdolTraineeCampView"
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

	slot0.quickView = BackHomeQuickJumpView.New(slot0.quickJumpSubView_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.taskBtn_, nil, function ()
		JumpTools.OpenPageByJump("/idolTraineeQuest")
	end)
	slot0:AddBtnListener(slot0.changeHeroBtn_, nil, function ()
		JumpTools.OpenPageByJump("/idolTraineeDepolyChara")
	end)
	slot0:AddBtnListener(slot0.heroPropBtn_, nil, function ()
		JumpTools.OpenPageByJump("/idolTraineeTrain")
	end)
	slot0:AddBtnListener(slot0.pvpBtn_, nil, function ()
		JumpTools.OpenPageByJump("/idolTraineeEnterBattleView", {
			pvpBattle = true
		})
	end)
	slot0:AddBtnListener(slot0.challengeBtn_, nil, function ()
		JumpTools.OpenPageByJump("/idolTraineeChapterMain")
	end)
	slot0.quickView:AddClickCallBack(function ()
		manager.windowBar:HideBar()
	end)
	slot0.quickView:CloseCallBack(function ()
		uv0:RefreshBar()
	end)
end

slot1 = {
	"CamShootAtPos1",
	"CamShootAtPos2",
	"CamShootAtPos3",
	"CamShootAtPos4",
	"CamShootAtPos5"
}

function slot0.RestoreVCam(slot0)
	for slot4, slot5 in ipairs(uv0) do
		IdolTraineeCampBridge.SetVCamActive(slot5, false)
	end

	if IdolTraineeCampBridge.cinemachineBrain.IsBlending then
		slot0:StartWaitCamBlend()
	end
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_CLICK_ENTITY, function (slot0)
		manager.windowBar:HideBar()
		IdolTraineeCampBridge.SetVCamActive(uv0[IdolTraineeCampBridge.GetPosByCharacter(slot0)], true)
		uv1:StartWaitCamBlend(function ()
			JumpTools.OpenPageByJump("/heroInteractView", {
				heroEID = uv0,
				camPos = uv1[uv2]
			})
		end)
		DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.InteractCam)
	end)
end

function slot0.StartWaitCamBlend(slot0, slot1)
	slot0:StopWaitCamBlend()
	SetActive(slot0.gameObject_, false)

	slot0.timer = Timer.New(function ()
		if not IdolTraineeCampBridge.cinemachineBrain.IsBlending then
			uv0:StopWaitCamBlend()
			SetActive(uv0.gameObject_, true)

			if uv1 then
				uv1()
			end
		end
	end, 0.34, -1)

	slot0.timer:Start()
end

function slot0.StopWaitCamBlend(slot0)
	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end
end

function slot0.OnEnter(slot0)
	slot0:RefreshBar()
	slot0:RegisterEvents()
	slot0.quickView:OnEnter()
	slot0.quickView:ShowView(false)
	slot0:RestoreVCam()
	manager.redPoint:bindUIandKey(slot0.taskBtn_.transform, RedPointConst.IDOL_TRAINEE_DAY_AND_WEEK_TASK)
	BackHomeCricketBattleData:InvokeDanceBackCB()
end

function slot0.RefreshBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
	manager.windowBar:RegistHomeCallBack(function ()
		BackHomeTools:BackHomeGotoMain()
	end)

	if #GameSetting.idol_dance_info_describe.value > 0 then
		manager.windowBar:SetGameHelpKey({
			view = "/gameHelpPro",
			type = "jump",
			params = {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = slot1
			}
		})
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
	slot0:StopWaitCamBlend()
	slot0.quickView:OnExit()
	manager.redPoint:unbindUIandKey(slot0.taskBtn_.transform, RedPointConst.IDOL_TRAINEE_DAY_AND_WEEK_TASK)
end

function slot0.Dispose(slot0)
	slot0.quickView:Dispose()
	slot0:StopWaitCamBlend()
	uv0.super.Dispose(slot0)
end

return slot0
