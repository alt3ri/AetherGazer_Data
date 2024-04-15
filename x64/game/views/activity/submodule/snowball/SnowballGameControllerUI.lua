slot0 = class("SnowballGameControllerUI", ReduxView)

function slot1(slot0)
	manager.audio:PlayEffect("minigame_activity_2_6_snowball", slot0, "")
end

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/JapanRegionSnowballGameUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot2()
	gameContext:Go("/snowballGameLevelUI", nil, true, true)
end

function slot3(slot0)
	if slot0:IsGameStarted() and not slot0.pause then
		slot0.pause = true

		JumpTools.OpenPageByJump("snowballPausePopup", {
			OkCallback = function ()
				uv0:EndGame(false)
			end,
			CancelCallback = function ()
				uv0.pause = false
			end
		})
	end
end

function slot0.RefreshWindowBar(slot0)
	if slot0:IsGameStarted() then
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
		manager.windowBar:RegistBackCallBack(handler(slot0, uv0))
	else
		manager.windowBar:HideBar()
	end
end

function slot0.OnTop(slot0)
	slot0:RefreshWindowBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	DormLuaBridge.InitJoystick(slot0.joystick_)

	slot0.modeController = ControllerUtil.GetController(slot0.transform_, "mode")
	slot0.movingDirIndicator = ControllerUtil.GetController(slot0.transform_, "moveDir")
	slot0.crosshire = ControllerUtil.GetController(slot0.transform_, "crosshire")
	slot0.shoot = ControllerUtil.GetController(slot0.transform_, "shoot")
	slot0.shootTipsController = ControllerUtil.GetController(slot0.transform_, "showShootTips")
	slot0.moveTipsController = ControllerUtil.GetController(slot0.transform_, "showMoveTips")

	if SnowballGameData:CheckAlreadyShowInGameTip(SnowballGameData.InGameTips.Shoot) then
		slot0.shootTipsController:SetSelectedState("hide")
	end

	if SnowballGameData:CheckAlreadyShowInGameTip(SnowballGameData.InGameTips.Move) then
		slot0.moveTipsController:SetSelectedState("hide")
	end

	slot0:InitBtnListeners()
	slot0:InitSubViews()
end

function slot0.NewSubView(slot0, slot1, ...)
	slot2 = slot1.New(...)

	table.insert(slot0.subViews, slot2)

	return slot2
end

function slot0.InitSubViews(slot0)
	slot0.subViews = {}
	slot0.buffSubView = slot0:NewSubView(SnowballGameBuffSubView, slot0.buffSubView_)

	function slot0.buffSubView.OnBuffFinished(slot0, slot1)
		SnowballGameBuff.buff[slot1].OnRemove(uv0.playerEID)
		manager.notify:Invoke(SNOWBALL_GAME_BUFF_FINISH, uv0.playerEID, slot1)
		uv0:OnBuffRemoved(slot1)
	end

	function slot0.buffSubView.OnBuffExtended(slot0, slot1)
		if SnowballGameBuff.buff[slot1].OnExtended then
			slot2(uv0.playerEID)
		end
	end

	slot0.gameInfoSubView = slot0:NewSubView(SnowballGameInfoSubView, slot0.gameInfoSubView_)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.subViews) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.AddJob(slot0, slot1, slot2, slot3)
	if slot3 then
		slot0.jobs[slot3] = {
			time = slot0.time + slot1,
			task = slot2
		}

		return slot3
	else
		table.insert(slot0.jobs, slot4)

		return #slot0.jobs
	end
end

function slot0.RemoveJob(slot0, slot1)
	if slot0.nextRemove == nil then
		slot0.nextRemove = {}
	end

	if slot0.jobs[slot1] then
		table.insert(slot0.nextRemove, slot1)
	end
end

function slot0.OnEnter(slot0)
	slot0.aim = 0
	slot0.wave = nil
	slot0.pause = false
	slot0.playerEID = slot0.params_.playerEID
	slot0.level = slot0.params_.level
	slot2 = SnowballGameUnitCfg[DormUtils.GetEntityData(slot0.playerEID).cfgID]
	slot0.beamRadius = slot2.none_area
	slot0.shootCooldown = slot2.skill_cooldown
	slot0.crossireSpeed = slot2.ready_speed
	slot0.time = 0
	slot0.jobs = {}

	for slot7 = 1, 3 do
		slot0:AddJob(slot7 - 1, handlerArg1(slot0, slot0.StartCountdown, slot3 - slot7 + 1))
	end

	slot0:AddJob(slot3, handler(slot0, slot0.StartGame))
	slot0:AddJob(20, handler(slot0, slot0.NotifyGuestTalk))
	slot0.modeController:SetSelectedState("countdown")

	slot7 = handler(slot0, slot0.Update)
	slot8 = -1
	slot0.updateTicker = FuncTimerManager.inst:CreateFuncFrameTimer(slot7, slot8, true)

	slot0:InitEventListeners()

	for slot7, slot8 in pairs(slot0.subViews) do
		slot8:OnEnter(slot0)
	end

	Dorm.DormEntityManager.PutEntityAt(slot0.playerEID, nullable(Dorm.storage:PickData("snowball.pos.gameStart"), "transform"))
	Dorm.DormEntityManager.StopAllCmd(slot0.playerEID)
	uv0("minigame_activity_2_6_snowball_time")
end

slot4 = {}

function slot0.StartCountdown(slot0, slot1)
	slot0.startCountdown_.text = GetTipsF(nullable(uv0, slot1) or "%d", slot1)
end

function slot0.OnExit(slot0)
	for slot4, slot5 in pairs(slot0.subViews) do
		slot5:OnExit()
	end

	slot0:RemoveAllEventListener()

	if slot0.updateTicker then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.updateTicker)

		slot0.updateTicker = nil
	end

	slot0.jobs = nil

	if slot0.waitAfterShoot then
		slot0.waitAfterShoot:Abort()

		slot0.waitAfterShoot = nil

		slot0.shoot:SetSelectedState("throw")
	end

	manager.windowBar:HideBar()
end

function slot0.IsGameStarted(slot0)
	return slot0.wave ~= nil
end

function slot0.StartGame(slot0)
	slot0.modeController:SetSelectedState("game")
	slot0.gameInfoSubView:OnGameStart()

	slot0.shootEnabled = true
	slot0.noMoreTarget = false

	SnowballGameMgr.GetInstance():SetLevel(slot0.level)
	slot0:StartGenWaveJob()
	slot0:RefreshWindowBar()
end

function slot0.EndGame(slot0, slot1)
	Dorm.DormEntityManager.PutEntityAt(slot0.playerEID, SnowballGameMgr.GetInstance().playerSpawnPos)
	Dorm.DormEntityManager.StopAllCmd(slot0.playerEID)
	SnowballGameMgr.ClearVfxOnEntity(slot0.playerEID)
	SnowballGameMgr.CreateHoldSnowballVfx(slot0.playerEID)

	slot3 = slot0.gameInfoSubView

	if slot0:IsGameStarted() then
		slot2:ClearAllTargets()
	end

	slot0:CancelAim()

	slot3.started = false

	if slot1 then
		JumpTools.OpenPageByJump("snowballGameResult", {
			finish = slot1,
			level = slot0.level,
			score = slot3.score,
			enemyList = slot3.hitList,
			extraTime = slot3:CalcRestTimeAfterFinish(),
			hitGuestCount = slot3.hitGuest,
			OkCallback = uv0
		})
		uv1("minigame_activity_2_6_snowball_end")
		Dorm.DormEntityManager.SendDoActionCMD(slot0.playerEID, "happy", false)
	else
		uv0()
	end

	slot2:RemoveGuest()

	slot0.wave = nil
	slot0.shootEnabled = false

	slot0.buffSubView:ClearAllBuff()
end

function slot0.IsLastWave(slot0)
	return SnowballGameCfg[slot0.level].refresh_enemy[(slot0.wave or 0) + 1] == nil
end

function slot0.StartGenWaveJob(slot0)
	if slot0.noMoreTarget or slot0:IsLastWave() then
		slot0:EndGame(true)

		return
	end

	slot0.wave = slot0.wave and slot0.wave + 1 or 0

	manager.notify:Invoke(SNOWBALL_GAME_TARGET_NEW_WAVE, slot0.wave)
end

slot5 = {
	[0] = "none",
	"right",
	[-1.0] = "left"
}

function slot6(slot0)
	if slot0.x > 0 then
		return 1
	elseif slot0.x < 0 then
		return -1
	end

	return 0
end

function slot0.IsChangeDir(slot0, slot1)
	if uv0(slot1) ~= 0 and uv0(slot0.lastMovingVec) ~= slot2 then
		return true, slot2
	end

	return false, slot2
end

slot7 = {
	[1.0] = "snowball_move_R",
	[-1.0] = "snowball_move_L"
}
slot8 = 0.4

function slot9(slot0)
	return nullable(uv0, slot0)
end

function slot0.Update(slot0)
	slot1 = slot0.pause and 0 or Time.deltaTime
	slot0.time = slot0.time + slot1

	slot0:UpdateGameLogic(slot1)
	slot0:UpdateMove()
	slot0:UpdateAim(slot1)
	slot0:ExecuteJobs()

	for slot5, slot6 in pairs(slot0.subViews) do
		slot6:Update(slot1, slot0.time)
	end
end

function slot0.UpdateGameLogic(slot0, slot1)
	slot2 = SnowballGameMgr.GetInstance()

	if not slot0:IsGameStarted() then
		return
	end

	slot4 = slot2:GetNormalTargetCount() + slot2:GetRewardTargetCount()
	slot5 = false

	if slot0.gameInfoSubView.totalTime <= 0 then
		slot5 = true
	elseif slot4 == 0 then
		if slot0.gameInfoSubView.countdown > 5 then
			slot0.gameInfoSubView.countdown = 5
		end

		if slot0.noMoreTarget or slot0:IsLastWave() then
			slot5 = true
		end
	end

	if slot5 then
		slot0.gameInfoSubView:RecordFinishTime()
		slot0:EndGame(true)
	elseif slot0.gameInfoSubView.countdown <= 0 then
		slot0:StartGenWaveJob()
	end
end

function slot0.ExecuteJobs(slot0)
	if slot0.nextRemove then
		for slot4, slot5 in ipairs(slot0.nextRemove) do
			slot0.jobs[slot5] = nil
		end

		slot0.nextRemove = nil
	end

	for slot4 = #slot0.jobs, 1, -1 do
		if slot0.jobs[slot4].time <= slot0.time then
			slot5.task()
			table.remove(slot0.jobs, slot4)
		end
	end
end

function slot0.UpdateMove(slot0)
	slot2, slot3 = slot0:IsChangeDir(DormLuaBridge.TryGetJoytickInput())

	if slot2 then
		slot4 = slot0.playerEID

		Dorm.DormEntityManager.ChangeEntityAnimeScheme(slot4, uv0(slot3))
		Dorm.DormEntityManager.TryTriggerResetAnimeDuringMove(slot4)

		if slot0.moveTipsController:GetSelectedState() == "show" then
			slot0.moveTipsController:SetSelectedState("hide")
			SnowballGameData:InGameTipClose(SnowballGameData.InGameTips.Move)
		end
	end

	slot0.movingDirIndicator:SetSelectedState(uv1[slot3] or "none")

	slot0.lastMovingVec = slot1
end

function slot10(slot0)
	if slot0 % 1 < 0 then
		slot1 = slot1 + 1
	end

	return slot1
end

function slot11(slot0)
	if slot0 % 2 < 0 then
		slot1 = slot1 + 2
	end

	if slot1 > 1 then
		slot1 = 2 - slot1
	end

	return slot1
end

function slot0.UpdateAim(slot0, slot1)
	if slot0.crosshire:GetSelectedState() ~= "move" then
		return
	end

	slot0.aim = slot0.aim + (slot0.crossireSpeed or GameSetting.activity_snowball_crosshair_speed.value[1] or 1) * (slot1 or Time.deltaTime)
	slot3 = uv0(slot0.aim)
	slot6 = slot0.crosshire_.parent
	slot7 = slot6.rect
	slot9 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	slot11 = UnityEngine.RectTransformUtility.WorldToScreenPoint(slot9, slot6:TransformPoint(Vector2.Lerp(Vector2(0, slot7.yMin), Vector2(0, slot7.yMax), slot3)))
	slot11.x = UnityEngine.RectTransformUtility.WorldToScreenPoint(UnityEngine.Camera.main, Dorm.DormEntityManager.QueryEntityAttachPointWorldPos(slot0.playerEID, "gua_Hit")).x
	slot0.crosshirePos = slot11
	slot12, slot0.crosshire_.localPosition = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(slot0.crosshire_.parent, slot11, slot9, nil)
	slot0.chargeKnot_.localRotation = Quaternion.Euler(0, 0, slot3 * -120)
end

function slot0.InitBtnListeners(slot0)
	slot1 = slot0:GetOrAddComponent(slot0.shootBtn_, typeof(EventTriggerListener))

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0:Shoot()
	end))
	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0:BeginAim()
	end))

	slot0.shootLongHoldBtn = slot1
end

function slot0.InitEventListeners(slot0)
	slot0:RegistEventListener(SNOWBALL_GAME_ALL_TARGET_SPAWNED, function ()
		uv0.noMoreTarget = true
	end)
	slot0:RegistEventListener(SNOWBALL_GAME_PLAYER_GET_BUFF, handler(slot0, slot0.AddBuff))
end

function slot0.AddBuff(slot0, slot1, slot2, slot3)
	if not slot0:IsGameStarted() then
		return
	end

	slot0.buffSubView:AddBuff(slot1, slot2, slot3)
	SnowballGameBuff.buff[slot1].OnApply(slot0.playerEID, slot3)

	if slot1 == SnowballGameBuff.buffType.Freeze then
		slot0:CancelAim()

		slot0.shootEnabled = false
	end
end

function slot0.OnBuffRemoved(slot0, slot1)
	if slot1 == SnowballGameBuff.buffType.Freeze then
		slot0.shootEnabled = true
	end
end

function slot0.BeginAim(slot0)
	if not slot0:ReadyToShoot() then
		return
	end

	if slot0.shootTipsController:GetSelectedState() == "show" then
		slot0.shootTipsController:SetSelectedState("hide")
		SnowballGameData:InGameTipClose(SnowballGameData.InGameTips.Shoot)
	end

	uv0("minigame_activity_2_6_snowball_preattack")

	slot0.beginAim = true
	slot0.aim = 0

	slot0.crosshire:SetSelectedState("move")
	slot0:UpdateAim(0)
	slot0.shoot:SetSelectedState("charge")
end

function slot0.CancelAim(slot0)
	slot0.beginAim = false

	slot0.crosshire:SetSelectedState("hide")

	if slot0.shoot:GetSelectedState() == "charge" then
		slot0.shoot:SetSelectedState("throw")
	end
end

slot12 = Dorm.LuaBridge.MiniGameBridge

function slot0.GetCharaShootWait(slot0)
	return slot0.shootCooldown or 1
end

function slot0.UpdateWaitAfterShoot(slot0, slot1)
	slot0.cooldown_.fillAmount = slot1
end

function slot0.CanShoot(slot0)
	return slot0.beginAim and slot0:ReadyToShoot()
end

function slot0.ReadyToShoot(slot0)
	return slot0.shootEnabled and not slot0.isInShootCooldown
end

function slot0.Shoot(slot0)
	if not slot0:CanShoot() then
		return
	end

	slot0.beginAim = false

	slot0.shoot:SetSelectedState("wait")
	slot0.crosshire:SetSelectedState("hide")
	uv0("minigame_activity_2_6_snowball_footstep_stop")

	if slot0.waitAfterShoot then
		slot0.waitAfterShoot:Abort()
	end

	slot1 = slot0:GetCharaShootWait()
	slot0.isInShootCooldown = true
	slot0.waitAfterShoot = DormCharacterActionManager.frameTaskRunner:NewTask():WaitUntil(function (slot0)
		slot0.wait = slot0.wait - (uv0.pause and 0 or DormCharacterActionManager:FrameTaskDeltaTime()) * SnowballGameMgr.GetInstance().shootSpeedFactor

		uv0:UpdateWaitAfterShoot(slot0.wait / slot0.total)

		return slot0.wait <= 0
	end, false, {
		wait = slot1,
		total = slot1
	}):Then(function ()
		uv0.shoot:SetSelectedState("throw")

		uv0.isInShootCooldown = false
	end):Start()
	slot2, slot3, slot4 = uv1.BeamcastEntity(slot0.crosshirePos, slot0.beamRadius, nil, )

	manager.notify:Invoke(SNOWBALL_GAME_AIM_FINISH, slot2, slot3, slot4)
end

slot13 = {
	"ACTIVITY_SNOWBALL_STAND_TALK01",
	"ACTIVITY_SNOWBALL_STAND_TALK02",
	"ACTIVITY_SNOWBALL_STAND_TALK03",
	"ACTIVITY_SNOWBALL_STAND_TALK04"
}

function slot14(slot0)
	return slot0[math.random(#slot0)]
end

function slot0.NotifyGuestTalk(slot0)
	if slot0:IsGameStarted() then
		manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, SnowballGameMgr.GetInstance():GetGuestEID(), GetTips(uv0(uv1)), true)
		slot0:AddJob(20, handler(slot0, slot0.NotifyGuestTalk))
	end
end

function slot0.OnGameFocusChange(slot0, slot1, slot2)
	if slot2 then
		uv0(slot0)
	end
end

return slot0
