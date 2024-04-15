slot0 = class("BattlePushSnowBallSingleResultView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballResultSingleModeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:CloseFunc()
	end)
	slot0:AddBtnListener(slot0.restartBtn_, nil, function ()
		uv0:OnClickRestart()
	end)
	slot0:AddBtnListener(slot0.shareBtn_, nil, function ()
		manager.share:Share(function ()
			uv0:HideAllUI()
		end, function ()
			uv0:RecoverAllUI()
		end, function ()
		end)
	end)
end

function slot0.HideAllUI(slot0)
	SetActive(slot0.backBtn_.gameObject, false)
	SetActive(slot0.shareBtn_.gameObject, false)
	SetActive(slot0.restartBtn_.gameObject, false)
end

function slot0.RecoverAllUI(slot0)
	SetActive(slot0.backBtn_.gameObject, true)
	SetActive(slot0.shareBtn_.gameObject, true)
	SetActive(slot0.restartBtn_.gameObject, true)
end

function slot0.OnEnter(slot0)
	slot0.stageData = slot0.params_.stageData
	slot0.score = slot0.params_.score
	slot0.useSecond = slot0.params_.useSecond
	slot0.stageId = slot0.stageData:GetStageId()
	slot0.stageType = slot0.stageData:GetType()

	BattleInstance.hideBattlePanel()
	slot0:RefreshUI()

	if slot0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function ()
				uv0:CloseFunc()
			end
		})
	end
end

function slot0.CloseFunc(slot0)
	OperationRecorder.Record(slot0.class.__cname, "closeCombat")
	BattleInstance.QuitBattle(slot0.stageData)
end

function slot0.OnClickRestart(slot0)
	if slot0.params_.condition then
		slot1, slot2 = slot0.params_.condition()

		if slot1 then
			BattleController.GetInstance():LaunchBattle(slot0.params_.stageData)
		else
			ShowTips(slot2)
		end
	else
		BattleController.GetInstance():LaunchBattle(slot0.params_.stageData)
	end
end

function slot0.RefreshUI(slot0)
	slot0.scoreText_.text = slot0.score
	slot0.useSecondText_.text = slot0.useSecond
	slot0.nameText_.text = slot0.stageData:GetName()
	slot0.playerNameText_.text = PlayerData:GetPlayerInfo().nick
	slot0.heroImg_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/snowballPortrait2/" .. PushSnowBallData:GetSelectedHeroID())
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
