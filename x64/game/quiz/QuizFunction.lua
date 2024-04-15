slot0 = P08.Quiz.PlayerManager.Instance
slot2 = 0
slot3 = {}
slot4 = 0
slot5 = 0
slot6 = 0
slot7 = 0
slot8 = 1
slot9 = os.time()
slot10 = {}

return {
	Cfg_GetGestureCd = function (slot0)
		return GameSetting.action_time.value[1]
	end,
	Cfg_GetEmojiCd = function (slot0)
		return GameSetting.talk_time.value[1]
	end,
	Cfg_GetMaxQuestionCount = function (slot0)
		slot2 = ActivityQuizCfg[ActivityQuizCfg.get_id_list_by_activity_id[ActivityQuizTools.GetCurActivityID()][1]]

		return slot2.quiz_zone[table.length(slot2.quiz_zone)][1]
	end,
	Cfg_GetSeqOfScoreBonus = function (slot0)
		return slot0:Cfg_GetMaxQuestionCount() - 3
	end,
	Cfg_GetScore = function (slot0, slot1)
		return ActivityQuizTableCfg[slot1].point
	end,
	Cfg_GetScoreMulti = function (slot0)
		return 1
	end,
	Cfg_GetDefaultModelId = function (slot0)
		return ActivityQuizCfg[ActivityQuizCfg.get_id_list_by_activity_id[ActivityQuizTools.GetCurActivityID()][1]].character_list[1]
	end,
	Cfg_GetPigModelId = function (slot0)
		return ActivityQuizCfg[ActivityQuizCfg.get_id_list_by_activity_id[ActivityQuizTools.GetCurActivityID()][1]].punish_character
	end,
	Cfg_GetMaxModelScale = function (slot0)
		return GameSetting.max_percent.value[1]
	end,
	Cfg_GetModelScaleMulti = function (slot0)
		return GameSetting.add_percent.value[1]
	end,
	PlayEmoji = function (slot0, slot1, slot2)
		manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_PLAY_STICKER, slot1, slot2)
	end,
	ShowScoreBonusEffect = function (slot0)
	end,
	OnGameStart = function (slot0, slot1)
		slot0:InitData()

		uv0 = 1
		uv1 = slot1.timestamp
	end,
	AddPlayers = function (slot0, slot1)
		slot3 = ActivityQuizCfg[ActivityQuizCfg.get_id_list_by_activity_id[ActivityQuizTools.GetCurActivityID()][1]]

		for slot7, slot8 in ipairs(slot1) do
			if not uv0[slot8.uid] then
				uv0[slot9] = {}

				table.insert(uv0.all, slot9)
			end

			uv0[slot9] = {
				score = 0,
				id = slot9,
				nick = slot8.nickname
			}

			if slot9 == USER_ID then
				curHeroID_ = slot8.role_id == 0 and 1084 or slot3.character_list[1]
			end
		end
	end,
	OnShowPrologue = function (slot0, slot1)
		uv0 = 2
		uv1 = slot1.timestamp

		manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_START_PROLOGUE)
	end,
	ShowQuestion = function (slot0, slot1)
		uv0 = 3
		uv1 = slot1.timestamp
		uv2 = slot1.seq
		uv3 = slot1.question
		seed_ = slot1.send

		manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_QUESTION_REFRESH)
	end,
	OnQuestionResult = function (slot0, slot1, slot2, slot3)
		uv0 = 4
		uv1 = slot3.timestamp

		for slot7, slot8 in pairs(slot2) do
			uv2[slot7].score = slot8.score
		end

		for slot7, slot8 in ipairs(slot1) do
			if slot8.uid == USER_ID then
				slot10 = slot8.history[#slot8.history]
				uv3 = slot10.is_right
				curChoose_ = slot10.choose
			end
		end

		manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_ANSWER_REFRESH)
	end,
	OnEndGame = function (slot0, slot1)
		uv0 = 5

		manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_FINISH_GAME)
	end,
	ShowModels = function (slot0, slot1, slot2)
		GameObject.Find("vfx_scene").gameObject:SetActive(false)

		if not isNil(GameObject.Find("GameEndObjs").transform:Find("VCam_GameEnd")) then
			slot5.gameObject:SetActive(true)
			UnityEngine.Camera.main.transform:SetPositionAndRotation(slot5.position, slot5.rotation)
		end

		slot6 = {}

		for slot10, slot11 in ipairs(slot1) do
			table.insert(slot6, uv0:FindByPlayerId(slot11))
		end

		for slot11, slot12 in ipairs(slot6) do
			if not isNil(GameObject.Find("GameEndObjs/pos" .. slot11)) then
				if slot12.curRoleId == slot0:Cfg_GetPigModelId() then
					slot14 = slot12.lastRoleId
				end

				slot16 = Asset.Instantiate("CharDorm/quiz/" .. slot14 .. "_tpose")

				slot16.transform:SetPositionAndRotation(slot13.transform.position, slot13.transform.rotation)
				slot16:GetComponent(typeof(Animator)):CrossFade(Animator.StringToHash("pose"), 0.1)
				slot0:CreateResultNameUI(slot13.transform.position + Vector3.up * 1.2, slot12.nickName, slot2[slot11], slot12.isLocalPlayer)
			end
		end

		for slot12 = 0, uv0.PlayerList.Count - 1 do
			slot8[slot12]:DestroyPlayerRoot()
		end
	end,
	OnModelChanged = function (slot0, slot1, slot2, slot3)
		manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_CHANGE_HERO)
	end,
	OnPlayerRemoved = function (slot0, slot1)
		if table.indexof(uv0.all, slot1) then
			table.remove(uv0.all, slot2)

			uv0[slot1] = nil
		end

		manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_QUIT_PLAYER)
	end,
	CreateQNickName = function (slot0, slot1, slot2, slot3)
		slot5 = uv0:FindByPlayerId(slot1):CreateNickName("UI/VersionUI/IndiaUI_2_8/IndiaAnswerUI/AnswerRoleNameUI", slot2)

		slot5.transform:SetSiblingIndex(0)

		if not isNil(slot5) then
			if slot3 then
				ControllerUtil.GetController(slot5.transform, "name"):SetSelectedState("me", true)
			else
				slot6:SetSelectedState("other", true)
			end
		end
	end,
	CreateResultNameUI = function (slot0, slot1, slot2, slot3, slot4)
		slot5 = Asset.Instantiate("UI/VersionUI/IndiaUI_2_8/IndiaAnswerUI/AnswerResultRoleRankUI")

		slot5.transform:SetParent(manager.ui.canvas.transform, false)

		slot5.transform:Find("nametext"):GetComponent(typeof(Text)).text = slot2

		slot5.transform:SetSiblingIndex(0)

		slot5.transform.localPosition = slot0:ConvertWorldToUIPos(slot1)
		slot5.transform.localScale = Vector3.one

		if slot4 then
			ControllerUtil.GetController(slot5.transform, "name"):SetSelectedState("me", true)
		else
			slot7:SetSelectedState("other", true)
		end

		ControllerUtil.GetController(slot5.transform, "rank"):SetSelectedState(slot3, true)
	end,
	ConvertWorldToUIPos = function (slot0, slot1)
		slot2 = manager.ui.canvas
		slot5, slot6 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(slot2.transform, UnityEngine.Camera.main:WorldToScreenPoint(slot1), slot2:GetComponent(typeof(Canvas)).worldCamera, nil)

		if slot6 == nil then
			print("未找到对应的视口坐标")
		end

		return slot6
	end,
	CreatePlayerShadow = function (slot0, slot1)
		slot4 = Asset.Instantiate("Effect/Battle/HeroIndicatorBase")

		slot4.transform:SetParent(uv0:FindByPlayerId(slot1):GetPlayerModelGo().transform.parent)

		slot4.transform.localPosition = Vector3.up * 0.05
		slot4.transform.localScale = Vector3.one * 0.6
	end,
	GetSyncPosInterval = function (slot0)
		return 0.125
	end,
	InitData = function (slot0)
		uv0 = 0
		uv1 = {
			all = {}
		}
		uv2 = 0
		curHeroID_ = 0
		curChoose_ = 0
		uv3 = 0
		uv4 = 0
		seed_ = 0
		uv5 = 1
	end,
	GetCurStateEndTime = function (slot0)
		return uv0
	end,
	GetPlayerList = function (slot0)
		return uv0.all
	end,
	GetRankData = function (slot0, slot1)
		return uv0[slot1]
	end,
	GetCurQuizID = function (slot0)
		return uv0
	end,
	GetCurQuizIndex = function (slot0)
		return uv0
	end,
	GetCurResult = function (slot0)
		return uv0
	end,
	GetState = function (slot0)
		return uv0
	end,
	GetCurChoose = function (slot0)
		return curChoose_
	end,
	SetCurChoose = function (slot0, slot1)
		curChoose_ = slot1

		manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_CHOOSE_CHANGE, slot1)
	end,
	SetCurHeroID = function (slot0, slot1)
		curHeroID_ = slot1
	end,
	GetCurHeroID = function (slot0)
		return curHeroID_
	end,
	GetPlyerModel = function (slot0, slot1)
		return uv0:FindByPlayerId(slot1)
	end,
	ResetRandSeed = function (slot0, slot1)
		uv0 = slot1

		DRandom.ResetSeed(slot1)
	end,
	SetRandList = function (slot0, slot1)
		uv0 = {}

		for slot5 = 1, slot1 do
			table.insert(uv0, slot5)
		end

		for slot5 = slot1, 2, -1 do
			table.insert(uv0, table.remove(uv0, DRandom.Random(slot5) + 1))
		end
	end,
	GetAnsList = function (slot0)
		return uv0
	end,
	GetRandSeed = function (slot0)
		return seed_
	end,
	CreateVfx_AnswerRight = function (slot0, slot1)
		slot0:CreateVfx(slot1, "Dorm/Effect/houzhai/fx_chunjie_yanhua", 1)
	end,
	CreateVfx_AnswerError = function (slot0, slot1)
		slot0:CreateVfx(slot1, "Dorm/Effect/houzhai/fx_chunjie_smk", 1)
	end,
	CreateVfx = function (slot0, slot1, slot2, slot3)
		slot6 = Asset.Instantiate(slot2)

		slot6.transform:SetParent(uv0:FindByPlayerId(slot1):GetPlayerModelGo().transform)

		slot6.transform.localPosition = Vector3.zero
		slot6.transform.localScale = Vector3.one

		PooledAsset.DestroyOrReturn(slot6, slot3)
	end
}
