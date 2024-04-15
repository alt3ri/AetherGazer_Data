manager.net:Bind(61047, function (slot0)
	MusicData:InitMusicData(slot0)

	if MusicData:CheckIsHaveNewMusicData(slot0) then
		for slot6, slot7 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_MUSIC]) do
			if ActivityData:GetActivityIsOpen(slot7) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MUSIC_OPEN, slot7), 1)
			end
		end
	else
		MusicAction.CheckRedPoint()
	end
end)
manager.notify:RegistListener(ACTIVITY_UPDATE, function (slot0)
	if ActivityTools.GetActivityType(slot0) == ActivityTemplateConst.ACTIVITY_MUSIC or slot1 == ActivityTemplateConst.ACTIVITY_MUSIC_GAME then
		MusicAction.CheckRedPoint()
	end
end)

return {
	QueryCompelet = function (slot0, slot1)
		slot2 = ActivityMusicCfg[slot0]
		slot5 = MusicData:GetScore(slot2.activity_id, slot2.difficult)

		manager.net:SendWithLoadingNew(61048, {
			id = slot0,
			score = slot1,
			other_data = MusicData:GetSpectralSendData()
		}, 61049, uv0.OnCampeletCallBack)
	end,
	OnCampeletCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot3 = ActivityMusicCfg[slot1.id]

			if MusicData:GetScore(slot3.activity_id, slot3.difficult) <= slot1.score or slot6 == 0 then
				MusicData:SetScore(slot4, slot5, slot1.score)
				MusicAction.CheckRedPoint()
				uv0.OpenSettlement(slot4, slot1.score, slot1.score, true)
			else
				uv0.OpenSettlement(slot4, slot1.score, slot6, false)
			end
		else
			MusicLuaBridge.EndMusicGame()
			ShowTips(slot0.result)
		end
	end,
	OpenSettlement = function (slot0, slot1, slot2, slot3)
		gameContext:Go(MusicData:GetMusicViewPathList(slot0).settlement, {
			cur = slot1,
			max = slot2,
			new = slot3
		})
	end,
	QueryReward = function (slot0)
		manager.net:SendWithLoadingNew(61050, {
			id = slot0
		}, 61051, uv0.OnRewardCallBack)
	end,
	OnRewardCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = slot1.id
			slot3 = slot0.reward_list

			getReward2(slot3)
			MusicData:SetRewardState(slot3.activity_id, slot3.difficult)
			MusicAction.CheckRedPoint()
			manager.notify:CallUpdateFunc(MUSIC_REWARD_UPDATE)
		else
			ShowTips(slot0.result)
		end
	end,
	CheckRedPoint = function (slot0)
		for slot5, slot6 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_MUSIC]) do
			MusicAction.CheckOpenRedPoint(slot6)
			MusicAction.CheckRewardRedPoint(slot6)
		end
	end,
	CheckOpenRedPoint = function (slot0)
		if not ActivityData:GetActivityIsOpen(slot0) or MusicData:GetRead(slot0) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MUSIC_OPEN, slot0), 0)

			return
		end

		for slot6, slot7 in ipairs(ActivityCfg[slot0] and slot1.sub_activity_list or {}) do
			if ActivityData:GetActivityIsOpen(slot7) then
				slot9 = true

				for slot13, slot14 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[slot7]) do
					if MusicData:GetScore(slot7, ActivityMusicCfg[slot14].difficult) and slot16 ~= 0 then
						slot9 = false

						break
					end
				end

				if slot9 then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MUSIC_OPEN, slot0), 1)

					return
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MUSIC_OPEN, slot0), 0)
	end,
	CheckRewardRedPoint = function (slot0)
		if not ActivityData:GetActivityIsOpen(slot0) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MUSIC_REWARD, slot0), 0)

			return
		end

		for slot6, slot7 in ipairs(ActivityCfg[slot0] and slot1.sub_activity_list or {}) do
			for slot12, slot13 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[slot7]) do
				slot14 = ActivityMusicCfg[slot13]

				if ActivityData:GetActivityIsOpen(slot7) and (slot14.difficult == 1 or slot14.difficult == 2) and MusicData:GetRewardState(slot13) == 1 then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MUSIC_REWARD, slot0), 1)

					return
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MUSIC_REWARD, slot0), 0)
	end,
	SetMusicRead = function (slot0)
		MusicData:SetRead(slot0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MUSIC_OPEN, slot0), 0)
	end,
	Play = function (slot0)
		if not ActivityMusicCfg[slot0] then
			error("can not find ActivityMusicCfg")

			return
		end

		slot2 = GetMusicDataForExchange()
		slot2.musicPath = slot1.path
		slot2.cueSheetName = slot1.cueSheetName
		slot2.cueName = slot1.cueName
		slot2.awbFile = slot1.awbFile
		slot2.aisacKey = slot1.aisacKey
		slot2.aisacValue = slot1.aisacValue
		slot2.isVertical = MusicData:GetVerical()
		slot2.latency = MusicData:GetJudgeData()
		slot2.stayTime = MusicData:GetSpeedData(slot2.isVertical)
		slot2.judgeLatency = MusicData:GetScreanData()
		slot2.goodArea = GameSetting.attach_music_judgment_good.value[1]
		slot2.prefectArea = GameSetting.attach_music_judgment_perfect.value[1]
		slot2.perfectPlusArea = GameSetting.attach_music_judgment_perfect_plus.value[1]
		slot2.longStartArea = GameSetting.attach_music_judgment_good.value[1]
		slot2.longEndArea = GameSetting.attach_music_judgment_good.value[1]
		slot2.interval = GameSetting.attach_music_longnote.value[1]
		slot2.preparationTime = 2000
		slot2.spectralType = MusicData:GetSpectralType()

		SDKTools.SendMessageToSDK("activity_music_start", {
			is_restart = false,
			activity_id = slot1.activity_id,
			difficulty_id = slot1.difficult,
			other_data = MusicData:GetSpectralAndVercialSDKKey()
		})
		MusicData:SetGameId(slot0)
		DestroyLua()
		MusicLuaBridge.Launcher(slot2)
	end,
	GoToMusicMain = function ()
		DestroyLua()
		LuaExchangeHelper.GoToMain()

		slot2 = MusicData:GetMusicViewPathList(ActivityMusicCfg[MusicData:GetGameId()].activity_id)

		OpenPageUntilLoaded(slot2.musicMain, {
			activity_id = slot2.activityID
		})
	end
}
