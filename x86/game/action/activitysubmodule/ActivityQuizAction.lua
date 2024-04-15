slot1 = false

return {
	Init = function ()
		if uv0 then
			return
		end

		uv0 = true

		manager.net:Bind(77001, function (slot0)
			if slot0.phase == 1 then
				manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_START_GAME)
				QuizSetGameStartArgs(slot0)
				QuizPendingAddPlayers(slot0.player_list)
				LoadQuizScene()
			elseif slot0.phase == 2 then
				QuizGameManager:OnShowPrologue(slot0)
			elseif slot0.phase == 3 then
				QuizGameManager:OnShowQuestion(slot0)
			elseif slot0.phase == 4 then
				QuizGameManager:OnQuestionResult(slot0)
			elseif slot0.phase == 5 then
				QuizGameManager:OnGameEnd(slot0)
			end
		end)
		manager.net:Bind(77003, function (slot0)
			for slot4, slot5 in ipairs(slot0.player_list) do
				if slot5.gesture_id ~= 0 then
					QuizGameManager:SyncRemoteGesture(slot5.uid, slot5.gesture_id)
				elseif slot5.role_id ~= 0 then
					QuizGameManager:SyncRemoteRole(slot5.uid, slot5.role_id)
				elseif slot5.emoji_id ~= 0 then
					QuizGameManager:SyncRemoteEmoji(slot5.uid, slot5.emoji_id)
				else
					QuizGameManager:SyncRemotePlayerPos(slot5.uid, slot5.pos)
				end
			end
		end)
		manager.net:Bind(77005, function (slot0)
			if GetQuizSceneLoaded() ~= 2 then
				QuizPendingAddPlayers(slot0.infos)
			else
				QuizGameManager:AddPlayers(slot0.infos)
			end
		end)
		manager.net:Bind(77007, function (slot0)
			QuizGameManager:RemovePlayers(slot0.uids)
		end)
	end,
	InitRedPointKey = function (slot0)
		slot1 = {}

		for slot7, slot8 in ipairs(ActivityCfg[ActivityQuizTools.GetTaskActivityID(slot0)].sub_activity_list) do
			table.insert(slot1, RedPointConst.ACTIVITY_TASK .. "_" .. slot8)
		end

		manager.redPoint:addGroup(RedPointConst.ACTIVITY_TASK .. "_" .. slot2, slot1)
		manager.redPoint:addGroup(RedPointConst.ACTIVITY_QUIZ .. "_" .. slot0, {
			RedPointConst.ACTIVITY_QUIZ_OPEN .. "_" .. slot0,
			RedPointConst.ACTIVITY_TASK .. "_" .. slot2
		})
		ActivityQuizAction.RefreshRedPoint(slot0)
	end,
	StartMarch = function ()
		manager.net:SendWithLoadingNew(77100, {}, 77101, uv0.OnStartMarch)
	end,
	OnStartMarch = function (slot0, slot1)
		if isSuccess(slot0.result) then
			manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_START_MATCH)
		else
			ShowTips(slot0.result)
		end
	end,
	CancelMarch = function ()
		manager.net:SendWithLoadingNew(77102, {}, 77103, uv0.OnCancelMarch)
	end,
	OnCancelMarch = function (slot0, slot1)
		if isSuccess(slot0.result) then
			manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_CANCEL_MATCH)
		else
			ShowTips(slot0.result)
		end
	end,
	ExitRoom = function ()
		manager.net:SendWithLoadingNew(77104, {}, 77105, uv0.OnExitRoom)
	end,
	OnExitRoom = function (slot0, slot1)
		if isSuccess(slot0.result) then
			QuitQuizScene()
		else
			ShowTips(slot0.result)
		end
	end,
	ChangeHero = function (slot0)
		manager.net:SendWithLoadingNew(77106, {
			role_id = slot0
		}, 77107, uv0.OnChangeHero)
	end,
	OnChangeHero = function (slot0, slot1)
		if isSuccess(slot0.result) then
			QuizGameManager:ChangePlayerModel(QuizGameManager.localPlayerId, slot1.role_id)
			manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_CHANGE_HERO)
		else
			ShowTips(slot0.result)
		end
	end,
	PushPosition = function (slot0, slot1, slot2)
		manager.net:Push(77108, {
			pos = {
				x = slot0,
				z = slot1,
				choose = slot2
			}
		})
	end,
	OnPushPosition = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	RefreshRedPoint = function (slot0)
		if not ActivityData:GetActivityData(slot0) or not slot1:IsActivitying() then
			return
		end

		if manager.time:IsToday(getData("activity_quiz_enter", tostring(slot0)) or 0) then
			return
		end

		ActivityTools.ClearActivityTimer(slot0)
		ActivityTools.CreateActivityTimer(slot0, function ()
			if manager.time:IsToday(getData("activity_quiz_enter", tostring(uv0)) or 0) then
				ActivityTools.ClearActivityTimer(uv0)

				return
			end

			slot2 = GameSetting.activity_quiz_open_time.value
			slot3 = slot2[1]
			slot4 = slot2[2]
			slot5 = manager.time:GetServerTime()
			slot7 = string.split(manager.time:DescCTime(slot5, "!%Y %m %d"), " ")

			manager.redPoint:setTip(RedPointConst.ACTIVITY_QUIZ_OPEN .. "_" .. uv0, manager.time:Table2ServerTime({
				year = tonumber(slot7[1]),
				month = tonumber(slot7[2]),
				day = tonumber(slot7[3]),
				hour = slot3[1],
				min = slot3[2],
				sec = slot3[3]
			}) <= slot5 and slot5 < manager.time:Table2ServerTime({
				year = tonumber(slot7[1]),
				month = tonumber(slot7[2]),
				day = tonumber(slot7[3]),
				hour = slot4[1],
				min = slot4[2],
				sec = slot4[3]
			}) and 1 or 0)
		end)
	end
}
