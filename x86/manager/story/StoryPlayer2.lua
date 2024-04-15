slot0 = class("StoryPlayer2", import("game.extend.ReduxView"))

function slot0.Ctor(slot0, slot1)
	slot0.isPlay_ = false
	slot0.auto_time = 0
	slot0.time_ = 0
	slot0.frameCnt_ = 0
	slot0.duration_ = 0
	slot0.gameObject_ = nil
	slot0.stage_ = slot1
	slot0.stage_.name = "StoryStage"
	slot0.state_ = ""
	slot0.auto_ = false
	slot0.curStory_ = nil
	slot0.curStoryInstance_ = nil
	slot0.curTalkId_ = nil
	slot0.onSingleLineFinish_ = nil
	slot0.onSingleLineUpdate_ = nil
	slot0.onStoryFinished_ = nil
	slot0.playNext_ = nil
	slot0.bgs_ = {}
	slot0.actors_ = {}
	slot0.spriteActors_ = {}
	slot0.CriAtomExPlaybacks_ = {}
	slot0.timelineDirector = {}
	slot0.marker = ""
	slot0.keyword = {
		nickname = PlayerData:GetPlayerInfo().nick
	}
	slot0.talkMaxDuration = 0
	slot0.typewritterCharCountI18N = 0

	slot0:InitUI()
	slot0:InitUIEvents()
end

function slot0.InitUI(slot0)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Story/StoryUI"), manager.ui.uiStory.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot4 = slot0.gameObject_

	ComponentBinder.GetInstance():BindCfgUI(slot0, slot4)
	slot0:AdaptScreen()

	slot0.iconController_ = ControllerUtil.GetController(slot0.iconTrs_, "conName")
	slot0.choices_ = {}

	for slot4 = 1, 3 do
		slot0.choices_[slot4] = {
			isShow = true,
			go = slot0["itemGo" .. slot4 .. "_"],
			txt = slot0["itemText" .. slot4 .. "_"]
		}
	end

	slot0.fswtw_ = slot0.typeWritterGo_:GetComponent("UITypewriterEffect")

	slot0.fswbg_:SetActive(false)
	SetActive(slot0.locationGo_, false)
	SetActive(slot0.dialog_, false)

	if SceneSetting.Current then
		slot0.sceneSettingEffect_ = SceneSetting.Current

		slot0.sceneSettingGo_:SetActive(false)
	else
		slot0.sceneSettingGo_:SetActive(true)
	end

	slot0.screenFilterGo_:SetActive(false)

	slot0.screenFilterEffect_ = slot0.screenFilterGo_:GetComponent("Volume")
	slot0.typewritter = slot0.text_.gameObject:GetComponent("UITypewriterEffect")
	slot0.dialogCg_.alpha = 0
	slot0.blackMask_.alpha = 0
	slot0.blackMask_.blocksRaycasts = false

	slot0:ShowNextGo(false)

	slot0.autoplayController_ = slot0.controller_:GetController("autoplay")
	slot0.hideBtnsController_ = slot0.controller_:GetController("hideBtns")
	slot0.callingController_ = slot0.controller_:GetController("Calling")
	slot0.historyItems_ = {}
	slot0.lastHistoryVoiceIdx_ = nil
	slot0.curHistoryItem_ = nil

	SetActive(slot0.talkGo_, false)
	slot0.autoplayController_:SetSelectedState("manual")
end

function slot0.InitUIEvents(slot0)
	slot0:AddBtnListener(slot0.allBtn_, nil, function ()
		uv0:OnClickBtnAll()
	end)
	slot0:AddBtnListener(slot0.hideBtn_, nil, function ()
		if uv0.auto_ then
			uv0.auto_ = false

			uv0.autoplayController_:SetSelectedState("manual")
		end

		SetActive(uv0.dialog_, false)
		uv0.hideBtnsController_:SetSelectedState("hide")

		uv0.allBtnState = uv0.allBtn_.enabled
		uv0.fullScreenWordFlag_ = uv0.fswbg_.activeSelf

		SetActive(uv0.fswbg_, false)

		uv0.state_ = "hiding"
		uv0.isPlay_ = false
		slot1 = nil

		SDKTools.SendMessageToSDK("story_oper", {
			oper = StoryOperDefine.HIDE,
			is_first = PlayerData:GetStoryList()[uv0.curStory_.id] and 0 or 1,
			story_id = uv0.curStory_.id
		})
	end)
	slot0:AddBtnListener(slot0.autoBtn_, nil, function ()
		uv0.auto_ = true

		uv0.autoplayController_:SetSelectedState("auto")

		slot1 = nil

		SDKTools.SendMessageToSDK("story_oper", {
			oper = StoryOperDefine.AUTO,
			is_first = PlayerData:GetStoryList()[uv0.curStory_.id] and 0 or 1,
			story_id = string.format(uv0.curStory_.id)
		})
	end)
	slot0:AddBtnListener(slot0.manualBtn_, nil, function ()
		uv0.auto_ = false

		uv0.autoplayController_:SetSelectedState("manual")
	end)
	SetActive(slot0.history_, true)
	SetActive(slot0.history_, false)
	slot0:AddBtnListener(slot0.lastBtn_, nil, function ()
		if SDKTools.GetIsOverSea() then
			uv0:JumpToEnd()
		end

		uv0.isPlay_ = false

		SetActive(uv0.history_, true)
		uv0.hideBtnsController_:SetSelectedState("hide")
		manager.ui:SetUISeparateRender(true)

		uv0.historyRect_.verticalNormalizedPosition = 0
		slot1 = nil

		SDKTools.SendMessageToSDK("story_oper", {
			oper = StoryOperDefine.REPLAY,
			is_first = PlayerData:GetStoryList()[uv0.curStory_.id] and 0 or 1,
			story_id = string.format(uv0.curStory_.id)
		})
	end)

	slot4 = nil

	slot0:AddBtnListener(slot0.historyBtn_, slot4, function ()
		uv0.isPlay_ = true

		SetActive(uv0.history_, false)
		uv0.hideBtnsController_:SetSelectedState("show")
		manager.ui:SetUISeparateRender(false)
	end)

	for slot4 = 1, 3 do
		slot0:AddBtnListener(slot0["itemBtn" .. slot4 .. "_"], nil, function ()
			manager.story:SetStoryChoice(uv0)
			uv1.playNext_(uv0)
			SetActive(uv1.choicesGo_, false)
		end)
	end

	slot0:AddBtnListener(slot0.skipBtn_, nil, function ()
		slot0, slot1 = uv0:CheckCanSkipToEnd()

		if slot0 then
			uv0:Skip()
		else
			uv0:JumpToMarker(slot1)
		end

		SetActive(uv0.choicesGo_, false)
	end)
	slot0:AddBtnListener(slot0.narrativeSkipBtn_, nil, function ()
		uv0.onStoryFinished_(true)
	end)
	slot0:AddBtnListener(slot0.narrativeExitBtn_, nil, function ()
		uv0.onStoryFinished_(true)
	end)
	slot0:AddBtnListener(slot0.narrativeContinueBtn_, nil, function ()
		uv0.onStoryFinished_(true)
	end)
end

function slot0.OnClickBtnAll(slot0)
	if slot0.state_ == "hiding" then
		slot0.state_ = "waiting"
		slot0.isPlay_ = true

		SetActive(slot0.dialog_, true)
		slot0.hideBtnsController_:SetSelectedState("show")

		slot0.allBtn_.enabled = slot0.allBtnState

		SetActive(slot0.fswbg_, slot0.fullScreenWordFlag_ and true)

		if slot0.fullScreenWordFlag_ == true then
			SetActive(slot0.dialog_, false)
		end
	elseif slot0.state_ == "waiting" and not slot0.choicesGo_.activeSelf then
		slot0.playNext_(1)
	elseif slot0.dialogNext_.activeSelf and slot0.typewriterNext_.activeSelf and not slot0.choicesGo_.activeSelf then
		slot0:JumpToEnd()

		if not slot0.choicesGo_.activeSelf then
			slot0.playNext_(1)
		end
	elseif slot0.state_ == "playing" then
		slot0:JumpToEnd()
	end
end

function slot0.JumpToEnd(slot0)
	for slot5 = 1, (slot0.duration_ - slot0.time_) / 0.033 + 1 do
		slot0:Update(0.033)
	end

	if slot0.dialogScrollRect_ then
		slot0.dialogScrollRect_.normalizedPosition = Vector2(0, 0)
	end
end

function slot0.JumpToMarker(slot0, slot1)
	while slot0.curTalkId_ < slot1 do
		slot0:JumpToEnd()
		slot0.playNext_(1)
	end

	if slot1 == slot0.curTalkId_ then
		for slot6 = 1, (slot0.duration_ - slot0.time_) / 0.033 + 1 do
			slot0:Update(0.033)

			if slot0.marker ~= "" then
				return
			end
		end
	end

	slot0:Skip()
end

function slot0.StopAllVoice(slot0)
	for slot4, slot5 in pairs(slot0.CriAtomExPlaybacks_) do
		if slot5 then
			slot5:Stop()
		end
	end

	slot0.CriAtomExPlaybacks_ = {}
end

function slot0.Skip(slot0, slot1)
	slot1 = slot1 or StoryOperDefine.PASS
	slot2 = slot0.curStory_.name
	slot0.isPlay_ = false
	slot0.auto_ = false

	slot0.autoplayController_:SetSelectedState("manual")

	if slot0.curStory_.desc and slot3 ~= "" then
		for slot7, slot8 in pairs(slot0.CriAtomExPlaybacks_) do
			if slot8 then
				slot8:Pause()
			end
		end

		manager.audio:ClearBGMFlag()

		if slot0.skipView_ == nil then
			if manager.story:IsStoryPlayed(slot0.curStory_.id) then
				slot0.skipView_ = StoryForceSkipView.New(Object.Instantiate(Asset.Load("Widget/System/Story/StorySkipUI"), manager.ui.uiStory.transform))
			else
				slot0.skipView_ = StorySkip2View.New(Object.Instantiate(Asset.Load("Widget/System/Story/StorySkip2UI"), manager.ui.uiStory.transform))
			end
		else
			SetActive(slot0.skipView_.gameObject_, true)
		end

		slot0.skipView_:SetContentTitle(slot2, slot3)
		slot0.skipView_:SetCallback(handler(slot0, function (slot0, slot1)
			if slot1 then
				uv0.isPlay_ = true

				for slot5, slot6 in pairs(uv0.CriAtomExPlaybacks_) do
					if slot6 then
						slot6:Resume(CriAtomEx.ResumeMode.PausedPlayback)
					end
				end

				return
			end

			slot3 = nil

			SDKTools.SendMessageToSDK("story_oper", {
				oper = uv1,
				is_first = PlayerData:GetStoryList()[uv0.curStory_.id] and 0 or 1,
				story_id = string.format(uv0.curStory_.id)
			})

			if BirthdayCfg.get_id_list_by_story_id[uv0.curStory_.id] and slot3 == 1 then
				SDKTools.SendMessageToSDK("birthday_viewed", {
					story_skip = 1
				})
			end

			uv0.onStoryFinished_(true)
		end))
	else
		slot5 = nil

		SDKTools.SendMessageToSDK("story_oper", {
			oper = slot1,
			is_first = PlayerData:GetStoryList()[slot0.curStory_.id] and 0 or 1,
			story_id = string.format(slot0.curStory_.id)
		})

		if BirthdayCfg.get_id_list_by_story_id[slot0.curStory_.id] and slot5 == 1 then
			SDKTools.SendMessageToSDK("birthday_viewed", {
				story_skip = 1
			})
		end

		slot0.onStoryFinished_(true)
	end
end

function slot0.SetGaussion(slot0, slot1)
	slot0:SetGaussionBg(slot1)
	manager.ui:SetUISeparateRender(slot1)
	SetActive(slot0.gaussionBgGo_, slot1)
end

function slot0.ShowNextGo(slot0, slot1)
	SetActive(slot0.dialogNext_, slot1)
	SetActive(slot0.dialogNextBtnGo_, not slot1)
	SetActive(slot0.typewriterNext_, slot1)
end

function slot0.Update(slot0, slot1)
	if not slot0.isPlay_ then
		if slot0.state_ == "hiding" then
			if Input.anyKey then
				slot0.__isAnyKey = true
			elseif slot0.__isAnyKey then
				slot0.__isAnyKey = false

				if not Input.GetMouseButtonUp(0) then
					slot0:OnClickBtnAll()
				end
			end

			slot0.allBtn_.enabled = true
		end

		return
	end

	if slot0.state_ ~= "pause" then
		slot0.time_ = slot0.time_ + slot1
		slot0.frameCnt_ = slot0.frameCnt_ + 1
	end

	if slot0.onSingleLineUpdate_ then
		slot0.onSingleLineUpdate_(slot1)
	end

	if slot0.duration_ < slot0.time_ and slot0.onSingleLineFinish_ then
		slot0.onSingleLineFinish_()

		if slot0.duration_ < 2 then
			slot0.auto_time = 2 - slot0.duration_
		end

		if slot0.auto_time <= 0 then
			slot0.auto_time = 1
		end
	end

	if slot0.state_ == "waiting" and slot0.playNext_ and slot0.auto_ then
		if slot0.auto_time <= 0 and not slot0.choicesGo_.activeSelf then
			slot0.playNext_(1)

			slot0.auto_time = 0
		else
			slot0.auto_time = slot0.auto_time - slot1
		end
	end
end

function slot0.FormatText(slot0, slot1)
	return slot0:ReplaceSpace(string.gsub(GetI18NText(slot1), "#{(%w+)}#", function (slot0)
		if uv0.keyword[slot0] then
			return slot1
		else
			return slot0
		end
	end))
end

function slot0.ReplaceSpace(slot0, slot1)
	return slot1
end

function slot0.RecordName(slot0, slot1)
	slot2 = "\n<size=32><color=#2ea9f6>【" .. slot1 .. "】</color></size>\n"

	if SettingData:GetCurrentLanguage() == "kr" then
		slot2 = "\n<size=32><color=#2ea9f6>[" .. slot1 .. "]</color></size>\n"
	end

	slot4 = StoryHistoryItem.New(Object.Instantiate(slot0.historyItemGo_, slot0.historyContentTrans_))

	table.insert(slot0.historyItems_, slot4)

	slot0.curHistoryItem_ = slot4

	slot4:SetTitle(slot1)
end

function slot0.RecordContent(slot0, slot1)
	slot0.curHistoryItem_:SetContent(slot1 .. "\n")
end

function slot0.RecordHistoryTalkVoice(slot0, slot1, slot2, slot3)
	slot0.curHistoryItem_:SetVoiceCallback(function (slot0)
		if uv0.voicePlaybackTimer_ == nil then
			uv0.voicePlaybackTimer_ = {}
		end

		if uv0.voicePlaybackTimer_[uv1] then
			return
		end

		uv0:AudioAction("play", "voice", uv2, uv1, uv3)

		if uv0.CriAtomExPlaybacks_[uv1] then
			slot2 = nil
			slot2 = FrameTimer.New(function ()
				if tonumber(tostring(uv0.time)) < 0 then
					uv1:StopVoiceAni()
					uv2:Stop()

					uv3.voicePlaybackTimer_[uv4] = nil
				else
					uv1:PlayVoiceAni()
				end
			end, 1, -1)

			slot2:Start()

			uv0.voicePlaybackTimer_[uv1] = slot2
		end
	end)
end

function slot0.GetFullAwbName(slot0, slot1)
	if slot1 ~= "" then
		slot1 = string.format("%s.awb", tostring(slot1))
	end

	return slot1
end

function slot0.AudioAction(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot1 == "play" then
		if slot2 == "voice" then
			slot0.CriAtomExPlaybacks_[slot4] = manager.audio:PlayVoice(slot3, slot4, slot0:GetFullAwbName(slot5))
		elseif slot2 == "music" then
			slot0.CriAtomExPlaybacks_[slot4] = manager.audio:PlayBGM(slot3, slot4, slot0:GetFullAwbName(slot5))
		elseif slot2 == "effect" then
			slot0.CriAtomExPlaybacks_[slot4] = manager.audio:PlayEffect(slot3, slot4, slot0:GetFullAwbName(slot5))
		end
	end

	if slot0.CriAtomExPlaybacks_[slot4] then
		if slot1 == "pause" then
			slot6:Pause()
		elseif slot1 == "resume" then
			slot6:Resume(CriAtomEx.ResumeMode.AllPlayback)
		elseif slot1 == "stop" then
			slot6:Stop()
		elseif slot1 == "forcestop" then
			slot6:Stop(true)
		end
	end
end

function slot0.ShowWeapon(slot0, slot1, slot2)
	LuaForUtil.ShowWeapon(slot1, slot2)
end

function slot0.CheckSpriteTmpPos(slot0, slot1, slot2)
	slot0.spriteActors_[slot1] = slot2

	for slot6, slot7 in pairs(slot0.spriteActors_) do
		if slot6 ~= slot1 and slot7 == slot2 and not isNil(slot0.actors_[slot6]) then
			slot0.actors_[slot6]:SetActive(false)
		end
	end

	if not isNil(slot0.actors_[slot1]) then
		slot0.actors_[slot1]:SetActive(true)
	end
end

function slot0.PlayTimeline(slot0, slot1, slot2)
	if slot0.actors_[slot1] == nil then
		slot3 = Object.Instantiate(Asset.Load("Char/" .. slot1), slot0.stage_.transform)
		slot3.name = slot1
		slot3.transform.localPosition = Vector3.New(0, 100, 0)
		slot0.actors_[slot1] = slot3

		if slot3.transform:Find("Directional Light") then
			SetActive(slot4.gameObject, false)
		end

		slot3:GetComponentInChildren(typeof(CharacterEffect)).enabled = true

		if GameObjectTools.GetOrAddComponent(slot3, typeof(DynamicBoneHelper)) then
			slot6:EnableDynamicBone(false)
		end

		slot0:ShowWeapon(slot5.transform, false)

		slot0.var_[slot1 .. "Animator"] = slot5.gameObject:GetComponent(typeof(UnityEngine.Animator))

		if slot4 then
			-- Nothing
		end

		slot0.var_[slot1 .. "Animator"].applyRootMotion = true
		slot0.var_[slot1 .. "LipSync"] = slot5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
	end

	slot4 = Asset.InstantiateWithoutCache(slot2)

	slot4.transform:SetParent(slot0.actors_[slot1].transform)

	slot6 = slot0.var_[slot1 .. "Animator"]
	slot7 = slot0.var_[slot1 .. "LipSync"]

	if slot4.transform:Find("Timeline").gameObject:GetComponent("PlayableDirector") then
		for slot13 = 0, slot5.playableAsset.outputTrackCount - 1 do
			if (slot8:GetOutputTrack(slot13).name == "Animator" or slot15 == "Animator Track") and slot6 then
				slot5:SetGenericBinding(slot14, slot6)

				if slot0.var_[slot1 .. "timelineAnimator"] then
					Object.Destroy(slot0.var_[slot1 .. "timelineAnimator"])
				end

				slot0.var_[slot1 .. "timelineAnimator"] = slot4
			elseif slot15 == "LipSync" and slot7 then
				slot5:SetGenericBinding(slot14, slot7)
			elseif slot15 == "Story Timeline Enable Render Track" then
				slot5:SetGenericBinding(slot14, slot3)
			end
		end

		slot5.time = 0

		slot5:Play()

		slot5.stopped = slot5.stopped + function (slot0)
			Object.Destroy(slot0.transform.parent.gameObject, 0.1)
		end

		table.insert(slot0.timelineDirector, slot5)
	end
end

function slot0.Dispose(slot0)
	if not isNil(slot0.sceneSettingEffect_) then
		slot0.sceneSettingEffect_.enabled = true
	end

	for slot4, slot5 in pairs(slot0.timelineDirector) do
		if not isNil(slot5) then
			slot5:Stop()
		end
	end

	slot0.timelineDirector = {}

	if slot0.gameObject_ then
		Object.Destroy(slot0.gameObject_)

		slot0.gameObject_ = nil
	end

	for slot4, slot5 in pairs(slot0.bgs_) do
		if slot5 then
			Object.Destroy(slot5)
		end
	end

	for slot4, slot5 in pairs(slot0.actors_) do
		if slot5 then
			Object.Destroy(slot5)
		end
	end

	if slot0.stage_ then
		Object.Destroy(slot0.stage_, 1)

		slot0.stage_ = nil
	end

	for slot4, slot5 in pairs(slot0.CriAtomExPlaybacks_) do
		if slot5 then
			slot5:Stop()
		end
	end

	if slot0.voicePlaybackTimer_ then
		for slot4, slot5 in pairs(slot0.voicePlaybackTimer_) do
			if slot5 then
				slot5:Stop()
			end
		end
	end

	manager.audio:ClearBGMFlag()

	for slot4, slot5 in pairs(slot0.var_) do
		if slot5 and type(slot5) == "userdata" and string.find(slot4, "effect") then
			Object.Destroy(slot5)
		end
	end

	if slot0.skipView_ then
		slot0.skipView_:Dispose()

		slot0.skipView_ = nil
	end

	for slot4, slot5 in ipairs(slot0.historyItems_) do
		slot5:Dispose()
	end

	slot0.curHistoryItem_ = nil
	slot0.CriAtomExPlaybacks_ = {}
	slot0.isPlay_ = false
	slot0.auto_ = false
	slot0.time_ = 0
	slot0.duration_ = 0
	slot0.state_ = ""
	slot0.curStory_ = nil
	slot0.onSingleLineFinish_ = nil
	slot0.onSingleLineUpdate_ = nil
	slot0.onStoryFinished_ = nil
	slot0.playNext_ = nil
	slot0.bgs_ = {}
	slot0.actors_ = {}
	slot0.var_ = {}
	slot0.spriteActors_ = {}

	uv0.super.Dispose(slot0)
	slot0:AudioAction("play", "voice", "story_v_empty", "empty", "")
end

function slot0.HideSkipBtn(slot0, slot1)
	SetActive(slot0.skipBtn_.gameObject, not slot1)
end

function slot0.Play(slot0, slot1)
	manager.guide.weakView:Hide()

	slot0.var_ = {}

	slot0:CheckNeedDownloadAssets(_G["Story" .. slot1], function ()
		uv0.curStory_ = StoryCfg[uv1]
		slot0 = uv0.curStory_.start
		uv0.curStoryInstance_ = uv2

		uv2["Play" .. slot0](uv2, uv0)

		uv0.isPlay_ = true

		manager.story:ResetStoryChoice()
		print("开始播放 " .. uv1 .. ", " .. slot0)
	end)
end

function slot0.CheckNeedDownloadAssets(slot0, slot1, slot2)
	if AssetDownloadManager.CheckResourcesNeedDownload(slot1.assets) or AssetDownloadManager.CheckVoiceNeedDownload(slot1.voices) then
		SetForceShowQuanquan(true)
		AssetDownloadManager.Create()
		AssetDownloadManager.Instance:AddResourceToDownloadQueue(slot1.assets)
		AssetDownloadManager.Instance:AddVoiceToDownloadQueue(slot1.voices)
		AssetDownloadManager.Instance:Run(nil, function ()
			AssetDownloadManager.Destroy()
			uv0()
			SetForceShowQuanquan(false)
		end, function ()
			AssetDownloadManager.Destroy()
			SetForceShowQuanquan(false)
			uv0.onStoryFinished_(true)
		end)
	else
		slot2()
	end
end

function slot0.RecordAudio(slot0, slot1, slot2)
	slot0.CriAtomExPlaybacks_[slot1] = slot2
end

function slot0.GetPercentByPara(slot0, slot1, slot2)
	slot3 = 0

	if table.length(string.split(slot1, "\n\n")) <= 1 then
		slot4 = string.split(slot1, "\n")
	end

	slot8 = ""
	slot1 = string.gsub(string.gsub(string.gsub(slot1, "\n\n", ""), "\n", ""), " ", slot8)

	for slot8 = 1, slot2 do
		slot3 = slot3 + utf8.len(string.gsub(string.gsub(string.gsub(slot4[slot8], "\n\n", ""), "\n", ""), " ", ""))
	end

	return slot3 / utf8.len(slot1), slot3
end

function slot0.CheckCanSkipToEnd(slot0)
	if slot0.curStoryInstance_.skipMarkers then
		for slot4 = 1, #slot0.curStoryInstance_.skipMarkers do
			if slot0.curTalkId_ < slot0.curStoryInstance_.skipMarkers[slot4] then
				return false, slot0.curStoryInstance_.skipMarkers[slot4]
			end
		end
	end

	return true, nil
end

function slot0.GetWordFromCfg(slot0, slot1)
	if StoryWordCfg[slot1] ~= nil then
		return StoryWordCfg[slot1]
	elseif StoryWordCfg2[slot1] ~= nil then
		return StoryWordCfg2[slot1]
	elseif StoryWordCfg3[slot1] ~= nil then
		return StoryWordCfg3[slot1]
	elseif StoryWordCfg4[slot1] ~= nil then
		return StoryWordCfg4[slot1]
	elseif StoryWordCfg5 and StoryWordCfg5[slot1] ~= nil then
		return StoryWordCfg5[slot1]
	end

	error("无法在StoryWordCfg表中找到 " .. slot1)

	return nil
end

return slot0
