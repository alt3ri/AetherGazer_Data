slot0 = singletonClass("QuizGameManager")
slot1 = import("game.quiz.QuizFunction")
slot2 = UnityEngine.Input
slot3 = UnityEngine.Time
slot4 = P08.Quiz.QuizPlayerInfo
slot5 = P08.Quiz.PlayerManager.Instance

function slot0.Init(slot0)
	slot0.questionResultDic = {}
	slot0.gestureCd = uv0:Cfg_GetGestureCd()
	slot0.gestureTs = 0
	slot0.emojiCd = uv0:Cfg_GetEmojiCd()
	slot0.emojiTs = 0
	slot0.pos_divide = 100
	slot0.syncPosInterval = uv0:GetSyncPosInterval()
	slot0.syncPosTimer = 0
	slot0.localPlayerId = USER_ID

	slot0:RegsiterModelChange()
	slot0:RegisterGestureChanged()
end

function slot0.StartGame(slot0, slot1, slot2)
	uv0:OnGameStart(slot1)
	slot0:AddPlayers(slot2)

	slot0._timer = FrameTimer.New(handler(slot0, slot0.Update), 1, -1)

	slot0._timer:Start()
end

function slot0.InitSticker(slot0, slot1)
	P08.Quiz.QuizLuaBridge.InitJoystick(slot1)
end

function slot0.Destroy(slot0)
	if slot0._timer then
		slot0._timer:Stop()

		slot0._timer = nil
	end

	slot0:UnregisterModelChange()
	slot0:UnregisterGestureChanged()
end

function slot0.Update(slot0)
	slot0:SyncLocalPlayerPosInterval()
end

function slot0.AddPlayers(slot0, slot1)
	slot2 = uv0:Cfg_GetDefaultModelId()

	for slot6, slot7 in ipairs(slot1) do
		if slot7.role_id ~= 0 then
			slot2 = slot7.role_id
		end

		slot0:LoadPlayer(slot7.uid, slot2, slot7.nickname)
	end

	uv0:AddPlayers(slot1)
	slot0:RandomInitPos(slot1)
end

function slot0.RemovePlayers(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0:RemovePlayer(slot6)
		slot0:RemoveQuestionResult(slot6)
	end
end

function slot0.OnShowPrologue(slot0, slot1)
	uv0:OnShowPrologue(slot1)
end

function slot0.OnShowQuestion(slot0, slot1)
	uv0:ShowQuestion(slot1)
end

function slot0.OnQuestionResult(slot0, slot1)
	slot3 = slot1.seq
	slot4 = slot1.question
	slot5 = slot1.answer

	for slot9, slot10 in ipairs(slot1.player_list) do
		slot11 = slot10.uid
		slot12 = slot10.pos.choose

		if slot10.history[slot3] == nil then
			Debug.LogError("===> OnQuestionResult error: questionSeq=" .. slot3 .. "  player.history.length=" .. #slot10.history)

			return
		end

		if slot0.questionResultDic[slot11] == nil then
			slot0.questionResultDic[slot11] = {
				score = 0,
				correctCounter = 0,
				seq = 0,
				errorCounter = 0
			}
		end

		slot0.questionResultDic[slot11].seq = slot3

		if slot3 == uv0:Cfg_GetSeqOfScoreBonus() then
			uv0:ShowScoreBonusEffect()
		end

		if slot13.is_right == 1 then
			if slot15 <= slot3 then
				slot16 = uv0:Cfg_GetScore(slot4) * uv0:Cfg_GetScoreMulti()
			end

			slot17 = 0

			if slot14.correctCounter > 0 then
				slot17 = GameSetting.combo_reward.value[slot14.correctCounter] or slot18[#slot18]
			end

			slot14.score = slot14.score + slot16 + slot17
			slot14.correctCounter = slot14.correctCounter + 1

			if slot14.errorCounter ~= 0 then
				slot14.errorCounter = 0

				slot0:RestoreLastModel(slot11)
				slot0:ScalePlayerModel(slot11, 1)
			end

			uv0:CreateVfx_AnswerRight(slot11)
		else
			slot14.correctCounter = 0
			slot14.errorCounter = slot14.errorCounter + 1

			slot0:ChangePlayerModel(slot11, uv0:Cfg_GetPigModelId())
			slot0:ScalePlayerModel(slot11, math.min(uv0:Cfg_GetMaxModelScale(), 1 + (slot14.errorCounter - 1) * uv0:Cfg_GetModelScaleMulti()))
			uv0:CreateVfx_AnswerError(slot11)
		end
	end

	uv0:OnQuestionResult(slot2, slot0.questionResultDic, slot1)
end

function slot0.OnGameEnd(slot0, slot1)
	slot0.syncPosInterval = 99999

	uv0:OnEndGame(slot1)
end

function slot0.SyncRemoteRole(slot0, slot1, slot2)
	slot0:ChangePlayerModel(slot1, slot2)
end

function slot0.SyncLocalPlayerPosInterval(slot0)
	if slot0.syncPosTimer <= 0 then
		slot0.syncPosTimer = slot0.syncPosInterval

		slot0:SyncLocalPlayerPos()
	else
		slot0.syncPosTimer = slot0.syncPosTimer - uv0.deltaTime
	end
end

function slot0.SyncLocalPlayerPos(slot0)
	if isNil(uv0.LocalPlayer) then
		Debug.LogError("[Quiz] PlayerManager.LocalPlayer is nil")

		return
	end

	slot1 = uv0.LocalPlayer:GetLocalPlayerPos()
	slot2 = uv0.LocalPlayer:GetChoose()

	if uv1:GetState() == 3 then
		uv1:SetCurChoose(slot2)
	end

	ActivityQuizAction.PushPosition(math.floor(slot1.x * slot0.pos_divide), math.floor(slot1.y * slot0.pos_divide), uv1:GetAnsList()[slot2] or 1)
end

function slot0.SyncRemotePlayerPosList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot8 = slot6.pos

		uv0:SetRemotePlayerPos(slot6.uid, slot8.x / slot0.pos_divide, slot8.z / slot0.pos_divide)
	end
end

function slot0.SyncRemotePlayerPos(slot0, slot1, slot2)
	uv0:SetRemotePlayerPos(slot1, slot2.x / slot0.pos_divide, slot2.z / slot0.pos_divide)
end

function slot0.RandomInitPos(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		DRandom.ResetSeed(slot6.seed)

		slot11 = 10
		slot12 = 6

		uv0:FindByPlayerId(slot6.uid):SetPlayerPosForce(Vector2.New(DRandom.Random(100) / 100 * slot11 - slot11 * 0.5, DRandom.Random(100) / 100 * slot12 - slot12 * 0.5), Quaternion.identity)
	end
end

function slot0.PlayLocalGesture(slot0, slot1)
	if manager.time:GetServerTime() < slot0.gestureTs then
		return
	end

	slot0.gestureTs = slot2 + slot0.gestureCd
	slot3 = UnityEngine.Animator.StringToHash(slot1)

	uv0.LocalPlayer:PlayLocalGesture(slot3)
	manager.net:Push(77110, {
		gesture_id = slot3
	})
end

function slot0.SyncRemoteGesture(slot0, slot1, slot2)
	uv0:FindByPlayerId(slot1):SyncRemoteGesture(slot2, 0.05)
end

function slot0.PlayLocalEmoji(slot0, slot1)
	if manager.time:GetServerTime() < slot0.emojiTs then
		return
	end

	slot0.emojiTs = slot2 + slot0.emojiCd

	uv0:PlayEmoji(slot0.localPlayerId, slot1)
	manager.net:Push(77112, {
		emoji_id = slot1
	})
end

function slot0.SyncRemoteEmoji(slot0, slot1, slot2)
	uv0:PlayEmoji(slot1, slot2)
end

function slot0.GetRemainGestureCd(slot0)
	return math.max(0, slot0.gestureTs - manager.time:GetServerTime())
end

function slot0.GetRemainEmojiCd(slot0)
	return math.max(0, slot0.emojiTs - manager.time:GetServerTime())
end

function slot0.LoadPlayer(slot0, slot1, slot2, slot3)
	if slot0.localPlayerId == slot1 then
		slot0:LoadPlayerInternal(slot1, slot2, slot3, true)
	else
		slot0:LoadPlayerInternal(slot1, slot2, slot3, false)
	end
end

function slot0.LoadPlayerInternal(slot0, slot1, slot2, slot3, slot4)
	slot5 = uv0()
	slot5.playerUid = slot1
	slot5.roleId = slot2
	slot5.nickName = slot3

	if slot4 == true then
		uv1:AddLocalPlayer(slot5)
		uv2:CreateQNickName(slot1, slot3, true)
		uv2:CreatePlayerShadow(slot1)
	else
		uv1:AddRemotePlayer(slot5)
		uv2:CreateQNickName(slot1, slot3, false)
	end
end

function slot0.RemovePlayer(slot0, slot1)
	uv0:RemovePlayerById(slot1)
	uv1:OnPlayerRemoved(slot1)
end

function slot0.RemoveQuestionResult(slot0, slot1)
	for slot5, slot6 in pairs(slot0.questionResultDic) do
		if slot5 == slot1 then
			slot0.questionResultDic[slot5] = nil
		end
	end
end

function slot0.ChangeLocalPlayerModel(slot0, slot1)
	slot0:ChangePlayerModel(slot0.localPlayerId, slot1)
	manager.net:Push(77106, {
		role_id = slot1
	})
end

function slot0.ChangePlayerModel(slot0, slot1, slot2)
	uv0:ChangeModel(slot1, slot2)

	if slot0.localPlayerId == slot1 then
		uv1:SetCurHeroID(slot2)
	end
end

function slot0.ScalePlayerModel(slot0, slot1, slot2)
	uv0:ScaleModel(slot1, slot2)
end

function slot0.RestoreLastModel(slot0, slot1)
	uv0:RestoreLastModel(slot1)
end

function slot0.RegsiterModelChange(slot0)
	if isNil(P08.Quiz.QuizLuaBridge.OnQuizPlayerModelChanged) then
		slot1.OnQuizPlayerModelChanged = handler(slot0, slot0.OnModelChanged)
	else
		slot1.OnQuizPlayerModelChanged = slot1.OnQuizPlayerModelChanged + handler(slot0, slot0.OnModelChanged)
	end
end

function slot0.UnregisterModelChange(slot0)
	P08.Quiz.QuizLuaBridge.OnQuizPlayerModelChanged = nil
end

function slot0.OnModelChanged(slot0, slot1, slot2, slot3)
	uv0:OnModelChanged(tostring(slot1), slot2, slot3)
end

function slot0.RegisterGestureChanged(slot0)
	if isNil(P08.Quiz.QuizLuaBridge.OnQuizPlayerGestureChanged) then
		slot1.OnQuizPlayerGestureChanged = handler(slot0, slot0.OnGestureChanged)
	else
		slot1.OnQuizPlayerGestureChanged = slot1.OnQuizPlayerGestureChanged + handler(slot0, slot0.OnGestureChanged)
	end
end

function slot0.UnregisterGestureChanged(slot0)
	P08.Quiz.QuizLuaBridge.OnQuizPlayerGestureChanged = nil
end

function slot0.OnGestureChanged(slot0, slot1, slot2)
	if tostring(slot1) ~= slot0.localPlayerId then
		return
	end

	if slot2 == -1 then
		manager.net:Push(77110, {
			gesture_id = -1
		})
	end
end

function slot0.IsMultiPlayer(slot0)
	return uv0.PlayerList.Count > 1
end

return slot0
