slot0 = class("BattlePushSnowBallTeamBossResultView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballResultBossModeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListener()

	slot0.resultController_ = ControllerUtil.GetController(slot0.transform_, "result")
	slot0.killController_ = ControllerUtil.GetController(slot0.transform_, "killNum")
	slot0.teamController_ = ControllerUtil.GetController(slot0.transform_, "mode")
	slot0.enemyUiList_ = LuaList.New(handler(slot0, slot0.IndexBossItem), slot0.enemyUiListGo_, PushSnowBallTeamResultItem)
	slot0.teammateUiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.teammateUiListGo_, PushSnowBallTeamResultItem)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:CloseFunc()
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
end

function slot0.RecoverAllUI(slot0)
	SetActive(slot0.backBtn_.gameObject, true)
	SetActive(slot0.shareBtn_.gameObject, true)
end

function slot0.OnEnter(slot0)
	slot0.stageData = slot0.params_.stageData
	slot0.resultInfo = slot0.params_.resultInfo
	slot0.stageId = slot0.stageData:GetStageId()
	slot0.stageType = slot0.stageData:GetType()
	slot0.playerID = tostring(PlayerData:GetPlayerInfo().userID)
	slot0.otherPlayerInfoList = {}

	table.sort(slot0.resultInfo, function (slot0, slot1)
		return slot1.score < slot0.score
	end)

	for slot4, slot5 in ipairs(slot0.resultInfo) do
		slot5.rank = slot4

		if slot5.user_id == slot0.playerID then
			slot0.info = slot5
		else
			table.insert(slot0.otherPlayerInfoList, slot5)
		end
	end

	slot0.teammatePlayerInfoList = {}
	slot0.bossPlayerInfoList = {}

	for slot4, slot5 in ipairs(slot0.otherPlayerInfoList) do
		if slot5.type == 1 then
			table.insert(slot0.bossPlayerInfoList, slot5)
		elseif slot5.type == 0 then
			table.insert(slot0.teammatePlayerInfoList, slot5)
		end
	end

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
	slot0.scoreText_.text = slot0.info.score
	slot0.nameText_.text = slot0.stageData:GetName()
	slot0.playerNameText_.text = PlayerData:GetPlayerInfo().nick
	slot0.heroImg_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/snowballPortrait2/" .. PushSnowBallData:GetSelectedHeroID())

	if slot0.info.type == 1 then
		slot0.teamController_:SetSelectedState("boss")

		if slot0.info.result == 1 then
			slot0.enemyUiList_:StartScroll(#slot0.otherPlayerInfoList)
		end
	elseif slot0.info.type == 0 then
		slot0.teamController_:SetSelectedState("team")

		if slot0.info.result == 1 then
			slot0.enemyUiList_:StartScroll(#slot0.bossPlayerInfoList)
		end

		slot0.teammateUiList_:StartScroll(#slot0.teammatePlayerInfoList)
	end

	if slot0.info.result == 1 then
		slot0.resultController_:SetSelectedState("win")
	else
		slot0.resultController_:SetSelectedState("lose")
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.teammatePlayerInfoList[slot1])
end

function slot0.IndexBossItem(slot0, slot1, slot2)
	if slot0.info.type == 1 then
		slot2:SetData(slot1, slot0.otherPlayerInfoList[slot1])
	elseif slot0.info.type == 0 then
		slot2:SetData(slot1, slot0.bossPlayerInfoList[slot1])
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	if slot0.enemyUiList_ then
		slot0.enemyUiList_:Dispose()

		slot0.enemyUiList_ = nil
	end

	if slot0.teammateUiList_ then
		slot0.teammateUiList_:Dispose()

		slot0.teammateUiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
