slot0 = singletonClass("DanceGame")
slot1 = 1
slot2 = 2
slot3 = DormCharacterInteractBehaviour
slot4 = Dorm.DormEntityManager

function slot5(slot0, slot1)
	slot2 = slot1.round

	print("Round:", slot2, "Start")
	manager.notify:Invoke(BACKHOME_CRICKET_ROUND_START, slot2)
end

function slot6(slot0, slot1)
	slot2 = slot1.round

	print("Round:", slot2, "End")
	manager.notify:Invoke(BACKHOME_CRICKET_ROUND_END, slot2)
end

function slot7(slot0)
	if slot0 == nil then
		return nil
	end

	for slot5 = 2, #slot0 do
		slot1 = slot0[1] .. slot0[slot5]
	end

	return slot1
end

function slot8()
	DormMinigame.Launch("WT_RK")
end

function slot9(slot0, slot1)
	manager.notify:Invoke(BACKHOME_CRICKET_REFRESH_BUFF, slot1.round)
end

function slot10(slot0)
	return slot0 ~= nil and slot0 ~= 0
end

function slot11(slot0)
	slot3 = math.random()
	slot6, slot7 = nil

	if uv0(slot0.myAction.skillID) and uv0(slot0.enemyAction.skillID) then
		slot7 = BOTH_USING_SKILL_CHANCE
	elseif slot4 then
		slot6 = uv1
		slot7 = ONE_USING_SKILL_CHANCE
	elseif slot5 then
		slot6 = uv2
		slot7 = ONE_USING_SKILL_CHANCE
	else
		slot6 = uv1
		slot7 = ADVANCE_NORMAL_ACTION_CHANCE
	end

	if slot3 < (slot7 or 0) then
		return nil
	end

	return slot6
end

function slot12(slot0, slot1, slot2, slot3)
	slot4 = {
		targetCfg = nullable(DormUtils.GetEntityData(slot1), "cfgID"),
		entityCfg = nullable(DormUtils.GetEntityData(slot0), "cfgID")
	}
	slot7 = nil

	if slot3 == nil then
		slot7 = uv0.GetSequence(slot5, slot6, slot2, "game.dorm.interacts.dance")
	else
		slot8 = uv0.GetSequenceGroup(slot5, slot6, slot2, "game.dorm.interacts.dance")
		slot7 = slot8[(slot3 - 1) % #slot8 + 1]
	end

	return uv0.MakeCtx(slot0, slot1, slot4), slot7
end

function slot13(slot0, slot1)
	if slot1 == nil then
		return slot0
	end

	slot3 = {
		duration = slot1,
		sequence = {
			[0] = {
				function (slot0)
					DanceGameController.SetEntityAnimeSpeed(slot0.entityID, uv0)
				end
			}
		}
	}

	for slot7, slot8 in pairs(slot0.sequence) do
		if type(slot8) == "function" then
			table.insert(slot3.sequence[slot7 / (slot0.duration / slot1)] or {}, slot8)
		elseif type(slot8) == "table" then
			for slot14, slot15 in ipairs(slot8) do
				table.insert(slot10, slot15)
			end
		end

		slot3.sequence[slot9] = slot10
	end

	return slot3
end

function slot14(slot0, slot1, slot2, slot3, slot4)
	if slot2 == nil then
		print("No action, no wait", slot0)

		return nil
	end

	slot5, slot6 = uv0(slot0, slot1, slot2, slot3)

	if slot6 then
		slot5.curActionTask = uv2.MakeInteractTask(uv1(slot6, slot4), slot5)
	else
		slot5.curActionTask = uv3.DebugAction(slot2, slot5)
	end

	uv4.StopAllCmd(slot0)
	DormUtils.SetEntityInteractContext(slot0, slot5)
	uv4.SendInteractToEntityCMD(slot0, slot1, true)

	return slot5.curActionTask
end

function slot15(slot0, slot1, slot2, ...)
	slot3 = {
		...
	}
	slot4 = uv0.StartActionTurn
	slot5 = uv0.TurnSettlement
	slot6 = slot0.actionRound[slot1]
	slot9 = {
		round = slot1,
		player = slot0:GetPlayerCharaEID(),
		opponent = slot0:GetOpponentCharaEID(),
		roundMusicInfo = slot6,
		duration = slot6.finish - slot6.start,
		removedBuff = {}
	}
	slot10 = uv1(slot2)
	slot11 = slot0.taskRunner:NewTask()

	slot11:WaitUntil(function ()
		return uv0.bgmPlayback and uv1 <= uv0.taskRunner:Now()
	end):Then(function ()
		if uv0 then
			uv1:ActiveShootToCharaCam(uv0)
		end

		uv1.curRound = uv2

		uv3(uv1, uv4)

		uv4.playerTask, uv4.opponentTask = uv5(uv1, uv4, uv6, unpack(uv7))
	end):WaitUntil(function ()
		return uv1 <= uv0.taskRunner:Now()
	end):Then(function ()
		if uv0 then
			uv1:RestoreCam()
		end

		uv2(uv1, uv3, uv4, unpack(uv5))
		uv6(uv1, uv3)
		DanceGameController.SetEntityAnimeSpeed(uv3.player, 1)
		DanceGameController.SetEntityAnimeSpeed(uv3.opponent, 1)
	end)
	slot11:Start(true)

	return slot11
end

function slot16(slot0, slot1)
	slot2 = uv0.StartPrepareTurn

	function slot3(slot0, slot1)
		uv0(slot0, slot1)
	end

	slot4 = DormCharacterActionManager.frameTaskRunner:NewTask()
	slot6 = {
		round = 0,
		player = slot0:GetPlayerCharaEID(),
		opponent = slot0:GetOpponentCharaEID(),
		removedBuff = {}
	}

	Dorm.storage:RecordData("dance.flags", "start", false)
	slot4:Then(function ()
		manager.notify:CallUpdateFunc("OnDanceGameStart")
	end):WaitUntil(function ()
		return Dorm.storage:GetData("dance.flags", "start")
	end):Then(function ()
		uv0.curRound = uv1

		uv2(uv0, uv3)

		uv3.playerTask, uv3.opponentTask = uv4(uv0, uv3, uv5)
	end):WaitUntil(function ()
		if uv0.playerTask and not uv0.playerTask:IsFinished() then
			return false
		end

		if uv0.opponentTask and not uv0.opponentTask:IsFinished() then
			return false
		end

		return true
	end):Then(function ()
		uv0(uv1, uv2, uv3)
		uv4(uv1, uv2)
		print("准备阶段结束")

		uv1.bgmPlayback = uv1.bgmPlayer:Play()

		uv1.taskRunner:SetPlayback(uv1.bgmPlayback)
		uv1:StartMainCamDirector()
		manager.notify:CallUpdateFunc("OnStartCountDownTimer")
	end)
	slot4:Start(true)

	return slot4
end

function slot17(slot0, slot1, slot2)
	slot3 = DormCharacterActionManager.frameTaskRunner:NewTask()
	slot5 = "curtain_call_"
	slot6 = 1.25

	slot3:WaitTask(slot1):Then(function ()
		manager.notify:CallUpdateFunc("OnDanceGameFinish")
		manager.audio:PlayEffect("ui_battle", "ui_battle_stopbgm")
	end):WaitUntil(function (slot0)
		if slot0.startTime == nil then
			slot0.startTime = uv0.taskRunner:Now()
		end

		if not slot0.alreadyShowResult and uv1 <= uv0.taskRunner:Now() - slot0.startTime then
			slot0.alreadyShowResult = true

			if uv2 then
				uv2()
			end
		end

		if slot0.playerTask == nil or slot0.playerTask:IsFinished() then
			slot0.playerTask = uv3(slot0.player, slot0.opponent, uv4)
		end

		if slot0.opponentTask == nil or slot0.opponentTask:IsFinished() then
			slot0.opponentTask = uv3(slot3, slot2, uv4)
		end

		return false
	end, false, {
		player = slot0:GetPlayerCharaEID(),
		opponent = slot0:GetOpponentCharaEID(),
		removedBuff = {}
	})
	slot3:Start(true)
end

function slot0.GotoResultView(slot0)
	if not slot0.isGotoResult then
		slot0.isGotoResult = true

		if BackHomeCricketBattleData:GetSingleBattleData().settleType == BackHomeCricketConst.ROOM_TYPE.Video then
			JumpTools.OpenPageByJump("/backHomeCricketBattleResuleView", {
				data = slot1
			})
		else
			BackHomeCricketAction.SendBattleComplete(slot0.battleType, function (slot0, slot1)
				JumpTools.OpenPageByJump("/backHomeCricketBattleResuleView", {
					data = slot1
				})
			end)
		end
	end
end

function slot0.ProcessDanceSeq(slot0, slot1, slot2, slot3)
	DanceGameController.SetEntityAnimeSpeed(slot0:GetPlayerCharaEID(), 1)
	DanceGameController.SetEntityAnimeSpeed(slot0:GetOpponentCharaEID(), 1)
	uv0(slot0, slot1)

	slot6 = nil
	slot0.totalRound = slot3

	for slot10 = 1, slot3 do
		slot6 = uv1(slot0, slot10, slot2[slot10])
	end

	uv2(slot0, slot6, function ()
		uv0:GotoResultView()
	end)
end

function slot0.SkipShow(slot0)
	slot0:GotoResultView()
end

function slot0.DebugAction(slot0, slot1)
	return uv0.MakeInteractTask({
		duration = 1,
		sequence = {
			[0] = function ()
				print("普通动作", uv0, 0)
			end,
			function ()
				print("普通动作", uv0, 1, "Finish")
			end,
			[0.5] = function ()
				print("普通动作", uv0, 0.5, "InProgress")
			end
		}
	}, slot1)
end

function slot18(slot0)
	return slot0 and slot0 ~= "" and not IsAllSpace(slot0)
end

function slot19(slot0)
	return uv0(IdolTraineeSkillCfg[slot0].action)
end

function slot20(slot0)
	return uv0(IdolTraineeSkillCfg[slot0].counter_action)
end

slot21 = 0
slot22 = 1
slot23 = {
	"type1",
	"type2",
	"type3",
	"type4",
	"type5"
}
slot24 = {
	"b8",
	"b16"
}

function slot25(slot0, slot1)
	slot2 = nullable(DormUtils.GetEntityData(slot0), "cfgID")
	slot3 = nil

	for slot7, slot8 in ipairs(slot1) do
		if (slot3 == nil or slot8 < slot3) and uv0(slot8) then
			slot3 = slot8
		end
	end

	return nullable(IdolTraineeSkillCfg, slot3, "action")
end

function slot26(slot0, slot1, slot2, slot3)
	slot4 = nullable(DormUtils.GetEntityData(slot0), "cfgID")
	slot5, slot6 = nil

	if slot2 and uv0(slot2.skillID) then
		slot5 = slot2.skillID
	end

	if slot3 and uv0(slot3.skillID) then
		slot6 = slot3.skillID
	end

	slot7 = nil

	if slot5 then
		slot7 = IdolTraineeSkillCfg[slot5].action
	elseif slot6 then
		slot7 = IdolTraineeSkillCfg[slot6].counter_action
	end

	slot8 = true

	if not uv1(slot7) then
		slot7 = uv2[slot2.actionID]
		slot8 = false
	end

	return string.format("%s_%s_", slot7, uv3[slot1.roundMusicInfo.type]), slot8
end

slot27 = 1
slot28 = 2

function slot29(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot8, slot9 = nil

	if IdolTraineeSkillEffectCfg[slot0].object == uv0 then
		slot8 = slot2
		slot9 = slot3
	elseif slot7.object == uv1 then
		slot8 = slot4
		slot9 = slot5
	end

	table.insert(slot9.buff, {
		id = slot0,
		skill = slot1,
		duration = slot7.round,
		triggerRound = slot7.trigger_time + slot6.round
	})
end

function slot30(slot0, slot1, slot2, slot3)
	slot4 = DormUtils.GetEntityData(slot0)
	slot5 = DormUtils.GetEntityData(slot1)

	if slot3.action then
		for slot10, slot11 in ipairs(slot3.action.effectList) do
			if nullable(IdolTraineeSkillCfg, slot6.actionID, "skill_effect", slot11) then
				uv0(slot12, slot6, slot0, slot4, slot1, slot5, slot2)
			end
		end
	else
		for slot9, slot10 in ipairs(slot3.passive) do
			uv0(slot10, action, slot0, slot4, slot1, slot5, slot2)
		end
	end
end

function slot31(slot0)
	slot1 = {}

	if nullable(BackHomeHeroCfg, slot0, "idol_passive_skill_list") then
		for slot6, slot7 in ipairs(slot2) do
			table.insert(slot1, slot7[1])
		end
	elseif nullable(IdolPveNpcCfg, slot0, "idol_passive_skill_list") then
		for slot6, slot7 in ipairs(slot2) do
			table.insert(slot1, slot7)
		end
	end

	return slot1
end

function slot0.StartPrepareTurn(slot0, slot1, slot2)
	slot3 = slot1.player
	slot4 = slot1.opponent

	uv1(slot3, slot4, slot1, {
		passive = slot2.myActiveBuffList
	})
	uv1(slot4, slot3, slot1, {
		passive = slot2.enemyActiveBuffList
	})
	uv2(slot0, slot1)

	return uv3(slot3, slot4, uv4(slot3, slot1, uv0(DormUtils.GetEntityData(slot3).heroID))), uv3(slot4, slot3, uv4(slot4, slot1, uv0(DormUtils.GetEntityData(slot4).heroID)))
end

function slot0.StartActionTurn(slot0, slot1, slot2)
	print("回合开始：", slot1.round)

	slot3 = slot1.player
	slot4 = slot1.opponent

	uv0(slot3, slot4, slot1, {
		action = slot2.myAction,
		score = slot2.myScore
	})
	uv0(slot4, slot3, slot1, {
		action = slot2.enemyAction,
		score = slot2.enemyScore
	})
	uv1(slot0, slot1)

	if slot1.round == 1 then
		slot13, slot14 = nil
		slot10, slot16 = uv2(slot3, slot1, slot5.action, slot6.action)
		slot10, slot14 = uv2(slot4, slot1, slot6.action, slot5.action)

		if not slot16 and not slot14 then
			slot16 = math.random(#uv3.GetSequenceGroup(nullable(DormUtils.GetEntityData(slot3), "cfgID"), nullable(DormUtils.GetEntityData(slot4), "cfgID"), nil, "game.dorm.interacts.dance"))
			slot12 = slot16
			slot11 = slot16
		end
	elseif slot1.round == slot0.totalRound then
		slot13, slot14 = nil
		slot9, slot16 = uv2(slot3, slot1, slot5.action, slot6.action)
		slot9, slot14 = uv2(slot4, slot1, slot6.action, slot5.action)

		if not slot16 and not slot14 then
			slot16 = math.random(#uv3.GetSequenceGroup(slot8, slot7, slot10, "game.dorm.interacts.dance"))
			slot12 = slot16
			slot11 = slot16
		end
	else
		slot9 = uv2(slot3, slot1, slot5.action, slot6.action)
		slot10 = uv2(slot4, slot1, slot6.action, slot5.action)
	end

	return uv4(slot3, slot4, slot9, slot11, slot1.duration), uv4(slot4, slot3, slot10, slot12, slot1.duration)
end

function slot32(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in pairs(DormUtils.GetEntityData(slot0).buff) do
		slot9 = slot8.id
		slot10 = slot8.duration

		if slot8.triggerRound <= slot1.round then
			if slot10 > 0 then
				if not slot8.activated then
					slot8.activated = true
				end

				slot8.duration = slot10 - 1
			end

			if slot8.duration <= 0 then
				table.insert(slot3, slot7)
			end
		end
	end

	for slot7 = #slot3, 1, -1 do
		slot3[slot7] = table.remove(slot2.buff, slot3[slot7]).id
	end

	slot1.removedBuff[slot0] = slot3
end

function slot0.TurnSettlement(slot0, slot1, slot2)
	uv0(slot1.player, slot1)
	uv0(slot1.opponent, slot1)
	uv1(slot0, slot1)
end

function slot33(slot0)
	return "CharDorm/dance/" .. slot0.model
end

function slot34(slot0)
	return Dorm.storage:GetData("dance.pos." .. slot0.spawnAt, 1).transform
end

function slot0.Ctor(slot0)
	slot0.charaMgr = EntityManager.New(EntityManager.CreateModel.New(uv0, uv1))
	slot0.taskRunner = DanceGameTaskRunner.New()
end

function slot0.Init(slot0, slot1)
	slot0:InitGame(slot1)

	slot2 = slot1.stageID

	slot0:InitScene(slot1.battleType == BackHomeCricketConst.ROOM_TYPE.PVE_STAGE and IdolTraineePveBattleCfg[slot2] or IdolTraineePvpBattleCfg[slot2])
	DormCharacterActionManager:RegisterTaskRunner(slot0.taskRunner, 2, 1)
	slot0:ProcessDanceSeq(slot1.prepareInfo, slot1.roundList, slot1.lastRound)
end

slot0.actionCountNamespace = "dance.action.cnt"

function slot0.InitGame(slot0, slot1)
	slot0.battleType = slot1.battleType

	slot0:SetCharacter(uv0, slot1.mySkinID)
	slot0:SetCharacter(uv1, slot1.enemySkinID)

	slot0.isGotoResult = nil

	Dorm.storage:ClearData(uv2.actionCountNamespace)
end

function slot0.SetCharacter(slot0, slot1, slot2)
	slot3 = BackHomeHeroSkinCfg[slot2] or IdolPveNpcCfg[slot2]

	slot0.charaMgr:Update(slot1, {
		complex = true,
		model = nullable(slot3, "model"),
		spawnAt = slot1
	}, {
		cfgID = slot2,
		heroID = nullable(slot3, "hero_id") or slot2,
		buff = {}
	})
end

function slot0.GetPlayerCharaEID(slot0)
	return slot0.charaMgr:GetEntityID(uv0)
end

function slot0.GetOpponentCharaEID(slot0)
	return slot0.charaMgr:GetEntityID(uv0)
end

function slot0.Reset(slot0, slot1, slot2)
	slot0.charaMgr:Clear(true)
	slot0.taskRunner:Reset()

	slot0.bgmPlayback = nil
	slot0.totalRound = nil

	if not slot2 then
		slot0.actionRound = nil
	end

	if slot1 then
		slot0.danceGameController = nil
		slot0.shootCam = nil
		slot0.cinemachineBrain = nil
	end
end

function slot0.InitBgmPlayer(slot0, slot1, slot2, slot3)
	slot4 = GameObject.Find("bgmPlayer"):GetComponent("CriAtomSource")

	DanceGameController.AddCue(slot1, slot3)

	slot4.cueSheet = slot1
	slot4.cueName = slot2
	slot0.bgmPlayer = slot4
end

slot35 = 2

function slot0.InitScene(slot0, slot1)
	if slot0.danceGameController == nil then
		slot0.danceGameController = DanceGameController.Load("IdolTrainee/Stage/" .. slot1.cam_director_prefab)

		slot0:InitCam()
	end

	slot2 = slot1.scene_name
	slot3 = IdolStageMusicCfg[slot1.bgm]

	if slot0.actionRound == nil then
		slot6 = require("cjson").decode(AssetEx.LoadText(slot3.music_json))
		slot7 = {}

		for slot11 = 1, uv0 do
			for slot17, slot18 in pairs(slot6["track" .. slot11]) do
				table.insert(slot7, {
					type = slot11,
					start = slot18[1] / 1000,
					finish = slot18[2] / 1000
				})
			end
		end

		table.sort(slot7, function (slot0, slot1)
			return slot0.start < slot1.start
		end)

		slot0.actionRound = slot7
	end

	slot0:InitBgmPlayer(slot3.cue_sheet, slot3.cue_name, slot3.awb_name)
end

function slot0.InitCam(slot0)
	slot0.danceGameController:InitCinemachineBrain()

	slot0.cinemachineBrain = slot0.danceGameController.brain
	slot0.cinemachineBrain.m_DefaultBlend = DanceGameController.cut
	slot0.shootCam = GameObject.Find("shoot"):GetComponent("CinemachineVirtualCamera")

	slot0.danceGameController:SetDummyFollowEntity("player1", slot0:GetPlayerCharaEID())
	slot0.danceGameController:SetDummyFollowEntity("player2", slot0:GetOpponentCharaEID())

	slot0.cinemachineBrain.enabled = true
	slot3 = uv0({
		spawnAt = uv1
	})
	slot4 = uv0({
		spawnAt = uv2
	})
	slot0.shootCamCfg = {
		[uv1] = {
			lookAt = slot0.danceGameController:GetDummy("player1") or slot3,
			pos = slot3:Find("shootPos")
		},
		[uv2] = {
			lookAt = slot0.danceGameController:GetDummy("player2") or slot4,
			pos = slot4:Find("shootPos")
		}
	}
end

function slot0.ActiveShootToCharaCam(slot0, slot1)
	if slot0.shootCamCfg[slot1] then
		slot0.shootCam.Follow = slot2.pos
		slot0.shootCam.LookAt = slot2.lookAt
		slot0.shootCam.enabled = true
	end
end

function slot0.RestoreCam(slot0)
	slot0.shootCam.enabled = false
end

function slot0.StartMainCamDirector(slot0)
	if slot0.danceGameController.director then
		slot1:Play()
	end
end

function slot0.StopMainCamDirector(slot0)
	if slot0.danceGameController.director then
		slot1:Stop()

		slot1.time = slot1.initialTime

		slot1:Evaluate()
	end
end

function slot0.Restart(slot0, slot1)
	slot0:Reset(nil, true)
	slot0:InitGame(slot1)
	slot0.bgmPlayer:Stop()
	DormCharacterActionManager:RegisterTaskRunner(slot0.taskRunner, 2, 1)
	slot0:ProcessDanceSeq(slot1.prepareInfo, slot1.roundList, slot1.lastRound)
end

return slot0
