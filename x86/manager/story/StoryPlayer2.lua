local var_0_0 = class("StoryPlayer2", import("game.extend.ReduxView"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.isPlay_ = false
	arg_1_0.auto_time = 0
	arg_1_0.time_ = 0
	arg_1_0.frameCnt_ = 0
	arg_1_0.duration_ = 0
	arg_1_0.gameObject_ = nil
	arg_1_0.stage_ = arg_1_1
	arg_1_0.stage_.name = "StoryStage"
	arg_1_0.state_ = ""
	arg_1_0.auto_ = false
	arg_1_0.curStory_ = nil
	arg_1_0.curStoryInstance_ = nil
	arg_1_0.curTalkId_ = nil
	arg_1_0.onSingleLineFinish_ = nil
	arg_1_0.onSingleLineUpdate_ = nil
	arg_1_0.onStoryFinished_ = nil
	arg_1_0.playNext_ = nil
	arg_1_0.bgs_ = {}
	arg_1_0.actors_ = {}
	arg_1_0.spriteActors_ = {}
	arg_1_0.CriAtomExPlaybacks_ = {}
	arg_1_0.timelineDirector = {}
	arg_1_0.marker = ""
	arg_1_0.keyword = {}
	arg_1_0.keyword.nickname = PlayerData:GetPlayerInfo().nick
	arg_1_0.talkMaxDuration = 0
	arg_1_0.typewritterCharCountI18N = 0

	arg_1_0:InitUI()
	arg_1_0:InitUIEvents()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Story/StoryUI"), manager.ui.uiStory.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	ComponentBinder.GetInstance():BindCfgUI(arg_2_0, arg_2_0.gameObject_)
	arg_2_0:AdaptScreen()

	arg_2_0.iconController_ = ControllerUtil.GetController(arg_2_0.iconTrs_, "conName")
	arg_2_0.choices_ = {}

	for iter_2_0 = 1, 3 do
		arg_2_0.choices_[iter_2_0] = {
			isShow = true,
			go = arg_2_0["itemGo" .. iter_2_0 .. "_"],
			txt = arg_2_0["itemText" .. iter_2_0 .. "_"]
		}
	end

	arg_2_0.fswtw_ = arg_2_0.typeWritterGo_:GetComponent("UITypewriterEffect")

	arg_2_0.fswbg_:SetActive(false)
	SetActive(arg_2_0.locationGo_, false)
	SetActive(arg_2_0.dialog_, false)

	if SceneSetting.Current then
		arg_2_0.sceneSettingEffect_ = SceneSetting.Current

		arg_2_0.sceneSettingGo_:SetActive(false)
	else
		arg_2_0.sceneSettingGo_:SetActive(true)
	end

	arg_2_0.screenFilterGo_:SetActive(false)

	arg_2_0.screenFilterEffect_ = arg_2_0.screenFilterGo_:GetComponent("Volume")
	arg_2_0.typewritter = arg_2_0.text_.gameObject:GetComponent("UITypewriterEffect")
	arg_2_0.dialogCg_.alpha = 0
	arg_2_0.blackMask_.alpha = 0
	arg_2_0.blackMask_.blocksRaycasts = false

	arg_2_0:ShowNextGo(false)

	arg_2_0.autoplayController_ = arg_2_0.controller_:GetController("autoplay")
	arg_2_0.hideBtnsController_ = arg_2_0.controller_:GetController("hideBtns")
	arg_2_0.callingController_ = arg_2_0.controller_:GetController("Calling")
	arg_2_0.historyItems_ = {}
	arg_2_0.lastHistoryVoiceIdx_ = nil
	arg_2_0.curHistoryItem_ = nil

	SetActive(arg_2_0.talkGo_, false)
	arg_2_0.autoplayController_:SetSelectedState("manual")
end

function var_0_0.InitUIEvents(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.allBtn_, nil, function()
		arg_3_0:OnClickBtnAll()
	end)
	arg_3_0:AddBtnListener(arg_3_0.hideBtn_, nil, function()
		if arg_3_0.auto_ then
			arg_3_0.auto_ = false

			arg_3_0.autoplayController_:SetSelectedState("manual")
		end

		SetActive(arg_3_0.dialog_, false)
		arg_3_0.hideBtnsController_:SetSelectedState("hide")

		arg_3_0.allBtnState = arg_3_0.allBtn_.enabled
		arg_3_0.fullScreenWordFlag_ = arg_3_0.fswbg_.activeSelf

		SetActive(arg_3_0.fswbg_, false)

		arg_3_0.state_ = "hiding"
		arg_3_0.isPlay_ = false

		local var_5_0 = PlayerData:GetStoryList()
		local var_5_1
		local var_5_2 = var_5_0[arg_3_0.curStory_.id] and 0 or 1

		SDKTools.SendMessageToSDK("story_oper", {
			oper = StoryOperDefine.HIDE,
			is_first = var_5_2,
			story_id = arg_3_0.curStory_.id
		})
	end)
	arg_3_0:AddBtnListener(arg_3_0.autoBtn_, nil, function()
		arg_3_0.auto_ = true

		arg_3_0.autoplayController_:SetSelectedState("auto")

		local var_6_0 = PlayerData:GetStoryList()
		local var_6_1
		local var_6_2 = var_6_0[arg_3_0.curStory_.id] and 0 or 1

		SDKTools.SendMessageToSDK("story_oper", {
			oper = StoryOperDefine.AUTO,
			is_first = var_6_2,
			story_id = string.format(arg_3_0.curStory_.id)
		})
	end)
	arg_3_0:AddBtnListener(arg_3_0.manualBtn_, nil, function()
		arg_3_0.auto_ = false

		arg_3_0.autoplayController_:SetSelectedState("manual")
	end)
	SetActive(arg_3_0.history_, true)
	SetActive(arg_3_0.history_, false)
	arg_3_0:AddBtnListener(arg_3_0.lastBtn_, nil, function()
		if SDKTools.GetIsOverSea() then
			arg_3_0:JumpToEnd()
		end

		arg_3_0.isPlay_ = false

		SetActive(arg_3_0.history_, true)
		arg_3_0.hideBtnsController_:SetSelectedState("hide")
		manager.ui:SetUISeparateRender(true)

		arg_3_0.historyRect_.verticalNormalizedPosition = 0

		local var_8_0 = PlayerData:GetStoryList()
		local var_8_1
		local var_8_2 = var_8_0[arg_3_0.curStory_.id] and 0 or 1

		SDKTools.SendMessageToSDK("story_oper", {
			oper = StoryOperDefine.REPLAY,
			is_first = var_8_2,
			story_id = string.format(arg_3_0.curStory_.id)
		})
	end)
	arg_3_0:AddBtnListener(arg_3_0.historyBtn_, nil, function()
		arg_3_0.isPlay_ = true

		SetActive(arg_3_0.history_, false)
		arg_3_0.hideBtnsController_:SetSelectedState("show")
		manager.ui:SetUISeparateRender(false)
	end)

	for iter_3_0 = 1, 3 do
		arg_3_0:AddBtnListener(arg_3_0["itemBtn" .. iter_3_0 .. "_"], nil, function()
			manager.story:SetStoryChoice(iter_3_0)
			arg_3_0.playNext_(iter_3_0)
			SetActive(arg_3_0.choicesGo_, false)
		end)
	end

	arg_3_0:AddBtnListener(arg_3_0.skipBtn_, nil, function()
		local var_11_0, var_11_1 = arg_3_0:CheckCanSkipToEnd()

		if var_11_0 then
			arg_3_0:Skip()
		else
			arg_3_0:JumpToMarker(var_11_1)
		end

		SetActive(arg_3_0.choicesGo_, false)
	end)
	arg_3_0:AddBtnListener(arg_3_0.narrativeSkipBtn_, nil, function()
		arg_3_0.onStoryFinished_(true)
	end)
	arg_3_0:AddBtnListener(arg_3_0.narrativeExitBtn_, nil, function()
		arg_3_0.onStoryFinished_(true)
	end)
	arg_3_0:AddBtnListener(arg_3_0.narrativeContinueBtn_, nil, function()
		arg_3_0.onStoryFinished_(true)
	end)
end

function var_0_0.OnClickBtnAll(arg_15_0)
	if arg_15_0.state_ == "hiding" then
		arg_15_0.state_ = "waiting"
		arg_15_0.isPlay_ = true

		SetActive(arg_15_0.dialog_, true)
		arg_15_0.hideBtnsController_:SetSelectedState("show")

		arg_15_0.allBtn_.enabled = arg_15_0.allBtnState

		SetActive(arg_15_0.fswbg_, arg_15_0.fullScreenWordFlag_ and true)

		if arg_15_0.fullScreenWordFlag_ == true then
			SetActive(arg_15_0.dialog_, false)
		end
	elseif arg_15_0.state_ == "waiting" and not arg_15_0.choicesGo_.activeSelf then
		arg_15_0.playNext_(1)
	elseif arg_15_0.dialogNext_.activeSelf and arg_15_0.typewriterNext_.activeSelf and not arg_15_0.choicesGo_.activeSelf then
		arg_15_0:JumpToEnd()

		if not arg_15_0.choicesGo_.activeSelf then
			arg_15_0.playNext_(1)
		end
	elseif arg_15_0.state_ == "playing" then
		arg_15_0:JumpToEnd()
	end
end

function var_0_0.JumpToEnd(arg_16_0)
	local var_16_0 = (arg_16_0.duration_ - arg_16_0.time_) / 0.033 + 1

	for iter_16_0 = 1, var_16_0 do
		arg_16_0:Update(0.033)
	end

	if arg_16_0.dialogScrollRect_ then
		arg_16_0.dialogScrollRect_.normalizedPosition = Vector2(0, 0)
	end
end

function var_0_0.JumpToMarker(arg_17_0, arg_17_1)
	while arg_17_1 > arg_17_0.curTalkId_ do
		arg_17_0:JumpToEnd()
		arg_17_0.playNext_(1)
	end

	if arg_17_1 == arg_17_0.curTalkId_ then
		local var_17_0 = (arg_17_0.duration_ - arg_17_0.time_) / 0.033 + 1

		for iter_17_0 = 1, var_17_0 do
			arg_17_0:Update(0.033)

			if arg_17_0.marker ~= "" then
				return
			end
		end
	end

	arg_17_0:Skip()
end

function var_0_0.StopAllVoice(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.CriAtomExPlaybacks_) do
		if iter_18_1 then
			iter_18_1:Stop()
		end
	end

	arg_18_0.CriAtomExPlaybacks_ = {}
end

function var_0_0.Skip(arg_19_0, arg_19_1)
	arg_19_1 = arg_19_1 or StoryOperDefine.PASS

	local var_19_0 = arg_19_0.curStory_.name
	local var_19_1 = arg_19_0.curStory_.desc

	arg_19_0.isPlay_ = false
	arg_19_0.auto_ = false

	arg_19_0.autoplayController_:SetSelectedState("manual")

	if var_19_1 and var_19_1 ~= "" then
		for iter_19_0, iter_19_1 in pairs(arg_19_0.CriAtomExPlaybacks_) do
			if iter_19_1 then
				iter_19_1:Pause()
			end
		end

		manager.audio:ClearBGMFlag()

		if arg_19_0.skipView_ == nil then
			if manager.story:IsStoryPlayed(arg_19_0.curStory_.id) then
				local var_19_2 = Asset.Load("Widget/System/Story/StorySkipUI")
				local var_19_3 = Object.Instantiate(var_19_2, manager.ui.uiStory.transform)

				arg_19_0.skipView_ = StoryForceSkipView.New(var_19_3)
			else
				local var_19_4 = Asset.Load("Widget/System/Story/StorySkip2UI")
				local var_19_5 = Object.Instantiate(var_19_4, manager.ui.uiStory.transform)

				arg_19_0.skipView_ = StorySkip2View.New(var_19_5)
			end
		else
			SetActive(arg_19_0.skipView_.gameObject_, true)
		end

		arg_19_0.skipView_:SetContentTitle(var_19_0, var_19_1)
		arg_19_0.skipView_:SetCallback(handler(arg_19_0, function(arg_20_0, arg_20_1)
			if arg_20_1 then
				arg_19_0.isPlay_ = true

				for iter_20_0, iter_20_1 in pairs(arg_19_0.CriAtomExPlaybacks_) do
					if iter_20_1 then
						iter_20_1:Resume(CriAtomEx.ResumeMode.PausedPlayback)
					end
				end

				return
			end

			local var_20_0 = PlayerData:GetStoryList()
			local var_20_1
			local var_20_2 = var_20_0[arg_19_0.curStory_.id] and 0 or 1

			SDKTools.SendMessageToSDK("story_oper", {
				oper = arg_19_1,
				is_first = var_20_2,
				story_id = string.format(arg_19_0.curStory_.id)
			})

			if BirthdayCfg.get_id_list_by_story_id[arg_19_0.curStory_.id] and var_20_2 == 1 then
				SDKTools.SendMessageToSDK("birthday_viewed", {
					story_skip = 1
				})
			end

			arg_19_0.onStoryFinished_(true)
		end))
	else
		local var_19_6 = PlayerData:GetStoryList()
		local var_19_7
		local var_19_8 = var_19_6[arg_19_0.curStory_.id] and 0 or 1

		SDKTools.SendMessageToSDK("story_oper", {
			oper = arg_19_1,
			is_first = var_19_8,
			story_id = string.format(arg_19_0.curStory_.id)
		})

		if BirthdayCfg.get_id_list_by_story_id[arg_19_0.curStory_.id] and var_19_8 == 1 then
			SDKTools.SendMessageToSDK("birthday_viewed", {
				story_skip = 1
			})
		end

		arg_19_0.onStoryFinished_(true)
	end
end

function var_0_0.SetGaussion(arg_21_0, arg_21_1)
	arg_21_0:SetGaussionBg(arg_21_1)
	manager.ui:SetUISeparateRender(arg_21_1)
	SetActive(arg_21_0.gaussionBgGo_, arg_21_1)
end

function var_0_0.ShowNextGo(arg_22_0, arg_22_1)
	SetActive(arg_22_0.dialogNext_, arg_22_1)
	SetActive(arg_22_0.dialogNextBtnGo_, not arg_22_1)
	SetActive(arg_22_0.typewriterNext_, arg_22_1)
end

function var_0_0.Update(arg_23_0, arg_23_1)
	if not arg_23_0.isPlay_ then
		if arg_23_0.state_ == "hiding" then
			if Input.anyKey then
				arg_23_0.__isAnyKey = true
			elseif arg_23_0.__isAnyKey then
				arg_23_0.__isAnyKey = false

				if not Input.GetMouseButtonUp(0) then
					arg_23_0:OnClickBtnAll()
				end
			end

			arg_23_0.allBtn_.enabled = true
		end

		return
	end

	if arg_23_0.state_ ~= "pause" then
		arg_23_0.time_ = arg_23_0.time_ + arg_23_1
		arg_23_0.frameCnt_ = arg_23_0.frameCnt_ + 1
	end

	if arg_23_0.onSingleLineUpdate_ then
		arg_23_0.onSingleLineUpdate_(arg_23_1)
	end

	if arg_23_0.time_ > arg_23_0.duration_ and arg_23_0.onSingleLineFinish_ then
		arg_23_0.onSingleLineFinish_()

		if arg_23_0.duration_ < 2 then
			arg_23_0.auto_time = 2 - arg_23_0.duration_
		end

		if arg_23_0.auto_time <= 0 then
			arg_23_0.auto_time = 1
		end
	end

	if arg_23_0.state_ == "waiting" and arg_23_0.playNext_ and arg_23_0.auto_ then
		if arg_23_0.auto_time <= 0 and not arg_23_0.choicesGo_.activeSelf then
			arg_23_0.playNext_(1)

			arg_23_0.auto_time = 0
		else
			arg_23_0.auto_time = arg_23_0.auto_time - arg_23_1
		end
	end
end

function var_0_0.FormatText(arg_24_0, arg_24_1)
	arg_24_1 = GetI18NText(arg_24_1)

	local var_24_0 = string.gsub(arg_24_1, "#{(%w+)}#", function(arg_25_0)
		local var_25_0 = arg_24_0.keyword[arg_25_0]

		if var_25_0 then
			return var_25_0
		else
			return arg_25_0
		end
	end)

	return (arg_24_0:ReplaceSpace(var_24_0))
end

function var_0_0.ReplaceSpace(arg_26_0, arg_26_1)
	return arg_26_1
end

function var_0_0.RecordName(arg_27_0, arg_27_1)
	local var_27_0 = "\n<size=32><color=#2ea9f6>【" .. arg_27_1 .. "】</color></size>\n"

	if SettingData:GetCurrentLanguage() == "kr" then
		local var_27_1 = "\n<size=32><color=#2ea9f6>[" .. arg_27_1 .. "]</color></size>\n"
	end

	local var_27_2 = Object.Instantiate(arg_27_0.historyItemGo_, arg_27_0.historyContentTrans_)
	local var_27_3 = StoryHistoryItem.New(var_27_2)

	table.insert(arg_27_0.historyItems_, var_27_3)

	arg_27_0.curHistoryItem_ = var_27_3

	var_27_3:SetTitle(arg_27_1)
end

function var_0_0.RecordContent(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1 .. "\n"

	arg_28_0.curHistoryItem_:SetContent(var_28_0)
end

function var_0_0.RecordHistoryTalkVoice(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_0.curHistoryItem_:SetVoiceCallback(function(arg_30_0)
		if arg_29_0.voicePlaybackTimer_ == nil then
			arg_29_0.voicePlaybackTimer_ = {}
		end

		if arg_29_0.voicePlaybackTimer_[arg_29_2] then
			return
		end

		arg_29_0:AudioAction("play", "voice", arg_29_1, arg_29_2, arg_29_3)

		local var_30_0 = arg_29_0.CriAtomExPlaybacks_[arg_29_2]

		if var_30_0 then
			local var_30_1

			var_30_1 = FrameTimer.New(function()
				if tonumber(tostring(var_30_0.time)) < 0 then
					arg_30_0:StopVoiceAni()
					var_30_1:Stop()

					arg_29_0.voicePlaybackTimer_[arg_29_2] = nil
				else
					arg_30_0:PlayVoiceAni()
				end
			end, 1, -1)

			var_30_1:Start()

			arg_29_0.voicePlaybackTimer_[arg_29_2] = var_30_1
		end
	end)
end

function var_0_0.GetFullAwbName(arg_32_0, arg_32_1)
	if arg_32_1 ~= "" then
		arg_32_1 = string.format("%s.awb", tostring(arg_32_1))
	end

	return arg_32_1
end

function var_0_0.AudioAction(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5)
	if arg_33_1 == "play" then
		if arg_33_2 == "voice" then
			arg_33_0.CriAtomExPlaybacks_[arg_33_4] = manager.audio:PlayVoice(arg_33_3, arg_33_4, arg_33_0:GetFullAwbName(arg_33_5))
		elseif arg_33_2 == "music" then
			arg_33_0.CriAtomExPlaybacks_[arg_33_4] = manager.audio:PlayBGM(arg_33_3, arg_33_4, arg_33_0:GetFullAwbName(arg_33_5))
		elseif arg_33_2 == "effect" then
			arg_33_0.CriAtomExPlaybacks_[arg_33_4] = manager.audio:PlayEffect(arg_33_3, arg_33_4, arg_33_0:GetFullAwbName(arg_33_5))
		end
	end

	local var_33_0 = arg_33_0.CriAtomExPlaybacks_[arg_33_4]

	if var_33_0 then
		if arg_33_1 == "pause" then
			var_33_0:Pause()
		elseif arg_33_1 == "resume" then
			var_33_0:Resume(CriAtomEx.ResumeMode.AllPlayback)
		elseif arg_33_1 == "stop" then
			var_33_0:Stop()
		elseif arg_33_1 == "forcestop" then
			var_33_0:Stop(true)
		end
	end
end

function var_0_0.ShowWeapon(arg_34_0, arg_34_1, arg_34_2)
	LuaForUtil.ShowWeapon(arg_34_1, arg_34_2)
end

function var_0_0.CheckSpriteTmpPos(arg_35_0, arg_35_1, arg_35_2)
	arg_35_0.spriteActors_[arg_35_1] = arg_35_2

	for iter_35_0, iter_35_1 in pairs(arg_35_0.spriteActors_) do
		if iter_35_0 ~= arg_35_1 and iter_35_1 == arg_35_2 and not isNil(arg_35_0.actors_[iter_35_0]) then
			arg_35_0.actors_[iter_35_0]:SetActive(false)
		end
	end

	if not isNil(arg_35_0.actors_[arg_35_1]) then
		arg_35_0.actors_[arg_35_1]:SetActive(true)
	end
end

function var_0_0.PlayTimeline(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_0.actors_[arg_36_1] == nil then
		local var_36_0 = Object.Instantiate(Asset.Load("Char/" .. arg_36_1), arg_36_0.stage_.transform)

		var_36_0.name = arg_36_1
		var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
		arg_36_0.actors_[arg_36_1] = var_36_0

		local var_36_1 = var_36_0.transform:Find("Directional Light")

		if var_36_1 then
			SetActive(var_36_1.gameObject, false)
		end

		local var_36_2 = var_36_0:GetComponentInChildren(typeof(CharacterEffect))

		var_36_2.enabled = true

		local var_36_3 = GameObjectTools.GetOrAddComponent(var_36_0, typeof(DynamicBoneHelper))

		if var_36_3 then
			var_36_3:EnableDynamicBone(false)
		end

		arg_36_0:ShowWeapon(var_36_2.transform, false)

		arg_36_0.var_[arg_36_1 .. "Animator"] = var_36_2.gameObject:GetComponent(typeof(UnityEngine.Animator))

		if var_36_1 then
			-- block empty
		end

		arg_36_0.var_[arg_36_1 .. "Animator"].applyRootMotion = true
		arg_36_0.var_[arg_36_1 .. "LipSync"] = var_36_2.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
	end

	local var_36_4 = arg_36_0.actors_[arg_36_1]
	local var_36_5 = Asset.InstantiateWithoutCache(arg_36_2)

	var_36_5.transform:SetParent(var_36_4.transform)

	local var_36_6 = var_36_5.transform:Find("Timeline").gameObject
	local var_36_7 = var_36_6:GetComponent("PlayableDirector")
	local var_36_8 = arg_36_0.var_[arg_36_1 .. "Animator"]
	local var_36_9 = arg_36_0.var_[arg_36_1 .. "LipSync"]

	if var_36_7 then
		local var_36_10 = var_36_7.playableAsset
		local var_36_11 = var_36_10.outputTrackCount

		for iter_36_0 = 0, var_36_11 - 1 do
			local var_36_12 = var_36_10:GetOutputTrack(iter_36_0)
			local var_36_13 = var_36_12.name

			if (var_36_13 == "Animator" or var_36_13 == "Animator Track") and var_36_8 then
				var_36_7:SetGenericBinding(var_36_12, var_36_8)

				if arg_36_0.var_[arg_36_1 .. "timelineAnimator"] then
					Object.Destroy(arg_36_0.var_[arg_36_1 .. "timelineAnimator"])
				end

				arg_36_0.var_[arg_36_1 .. "timelineAnimator"] = var_36_6
			elseif var_36_13 == "LipSync" and var_36_9 then
				var_36_7:SetGenericBinding(var_36_12, var_36_9)
			elseif var_36_13 == "Story Timeline Enable Render Track" then
				var_36_7:SetGenericBinding(var_36_12, var_36_4)
			end
		end

		var_36_7.time = 0

		var_36_7:Play()

		var_36_7.stopped = var_36_7.stopped + function(arg_37_0)
			Object.Destroy(arg_37_0.transform.parent.gameObject, 0.1)
		end

		table.insert(arg_36_0.timelineDirector, var_36_7)
	end
end

function var_0_0.Dispose(arg_38_0)
	if not isNil(arg_38_0.sceneSettingEffect_) then
		arg_38_0.sceneSettingEffect_.enabled = true
	end

	for iter_38_0, iter_38_1 in pairs(arg_38_0.timelineDirector) do
		if not isNil(iter_38_1) then
			iter_38_1:Stop()
		end
	end

	arg_38_0.timelineDirector = {}

	if arg_38_0.gameObject_ then
		Object.Destroy(arg_38_0.gameObject_)

		arg_38_0.gameObject_ = nil
	end

	for iter_38_2, iter_38_3 in pairs(arg_38_0.bgs_) do
		if iter_38_3 then
			Object.Destroy(iter_38_3)
		end
	end

	for iter_38_4, iter_38_5 in pairs(arg_38_0.actors_) do
		if iter_38_5 then
			Object.Destroy(iter_38_5)
		end
	end

	if arg_38_0.stage_ then
		Object.Destroy(arg_38_0.stage_, 1)

		arg_38_0.stage_ = nil
	end

	for iter_38_6, iter_38_7 in pairs(arg_38_0.CriAtomExPlaybacks_) do
		if iter_38_7 then
			iter_38_7:Stop()
		end
	end

	if arg_38_0.voicePlaybackTimer_ then
		for iter_38_8, iter_38_9 in pairs(arg_38_0.voicePlaybackTimer_) do
			if iter_38_9 then
				iter_38_9:Stop()
			end
		end
	end

	manager.audio:ClearBGMFlag()

	for iter_38_10, iter_38_11 in pairs(arg_38_0.var_) do
		if iter_38_11 and type(iter_38_11) == "userdata" and string.find(iter_38_10, "effect") then
			Object.Destroy(iter_38_11)
		end
	end

	if arg_38_0.skipView_ then
		arg_38_0.skipView_:Dispose()

		arg_38_0.skipView_ = nil
	end

	for iter_38_12, iter_38_13 in ipairs(arg_38_0.historyItems_) do
		iter_38_13:Dispose()
	end

	arg_38_0.curHistoryItem_ = nil
	arg_38_0.CriAtomExPlaybacks_ = {}
	arg_38_0.isPlay_ = false
	arg_38_0.auto_ = false
	arg_38_0.time_ = 0
	arg_38_0.duration_ = 0
	arg_38_0.state_ = ""
	arg_38_0.curStory_ = nil
	arg_38_0.onSingleLineFinish_ = nil
	arg_38_0.onSingleLineUpdate_ = nil
	arg_38_0.onStoryFinished_ = nil
	arg_38_0.playNext_ = nil
	arg_38_0.bgs_ = {}
	arg_38_0.actors_ = {}
	arg_38_0.var_ = {}
	arg_38_0.spriteActors_ = {}

	var_0_0.super.Dispose(arg_38_0)
	arg_38_0:AudioAction("play", "voice", "story_v_empty", "empty", "")
end

function var_0_0.HideSkipBtn(arg_39_0, arg_39_1)
	SetActive(arg_39_0.skipBtn_.gameObject, not arg_39_1)
end

function var_0_0.Play(arg_40_0, arg_40_1)
	manager.guide.weakView:Hide()

	arg_40_0.var_ = {}

	local var_40_0 = _G["Story" .. arg_40_1]

	local function var_40_1()
		arg_40_0.curStory_ = StoryCfg[arg_40_1]

		local var_41_0 = arg_40_0.curStory_.start

		arg_40_0.curStoryInstance_ = var_40_0

		var_40_0["Play" .. var_41_0](var_40_0, arg_40_0)

		arg_40_0.isPlay_ = true

		manager.story:ResetStoryChoice()
		print("开始播放 " .. arg_40_1 .. ", " .. var_41_0)
	end

	arg_40_0:CheckNeedDownloadAssets(var_40_0, var_40_1)
end

function var_0_0.CheckNeedDownloadAssets(arg_42_0, arg_42_1, arg_42_2)
	if AssetDownloadManager.CheckResourcesNeedDownload(arg_42_1.assets) or AssetDownloadManager.CheckVoiceNeedDownload(arg_42_1.voices) then
		SetForceShowQuanquan(true)
		AssetDownloadManager.Create()
		AssetDownloadManager.Instance:AddResourceToDownloadQueue(arg_42_1.assets)
		AssetDownloadManager.Instance:AddVoiceToDownloadQueue(arg_42_1.voices)
		AssetDownloadManager.Instance:Run(nil, function()
			AssetDownloadManager.Destroy()
			arg_42_2()
			SetForceShowQuanquan(false)
		end, function()
			AssetDownloadManager.Destroy()
			SetForceShowQuanquan(false)
			arg_42_0.onStoryFinished_(true)
		end)
	else
		arg_42_2()
	end
end

function var_0_0.RecordAudio(arg_45_0, arg_45_1, arg_45_2)
	arg_45_0.CriAtomExPlaybacks_[arg_45_1] = arg_45_2
end

function var_0_0.GetPercentByPara(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = 0
	local var_46_1 = string.split(arg_46_1, "\n\n")

	if table.length(var_46_1) <= 1 then
		var_46_1 = string.split(arg_46_1, "\n")
	end

	arg_46_1 = string.gsub(string.gsub(string.gsub(arg_46_1, "\n\n", ""), "\n", ""), " ", "")

	for iter_46_0 = 1, arg_46_2 do
		local var_46_2 = var_46_1[iter_46_0]
		local var_46_3 = string.gsub(string.gsub(string.gsub(var_46_2, "\n\n", ""), "\n", ""), " ", "")

		var_46_0 = var_46_0 + utf8.len(var_46_3)
	end

	return var_46_0 / utf8.len(arg_46_1), var_46_0
end

function var_0_0.CheckCanSkipToEnd(arg_47_0)
	if arg_47_0.curStoryInstance_.skipMarkers then
		for iter_47_0 = 1, #arg_47_0.curStoryInstance_.skipMarkers do
			if arg_47_0.curStoryInstance_.skipMarkers[iter_47_0] > arg_47_0.curTalkId_ then
				return false, arg_47_0.curStoryInstance_.skipMarkers[iter_47_0]
			end
		end
	end

	return true, nil
end

function var_0_0.GetWordFromCfg(arg_48_0, arg_48_1)
	if StoryWordCfg[arg_48_1] ~= nil then
		return StoryWordCfg[arg_48_1]
	elseif StoryWordCfg2[arg_48_1] ~= nil then
		return StoryWordCfg2[arg_48_1]
	elseif StoryWordCfg3[arg_48_1] ~= nil then
		return StoryWordCfg3[arg_48_1]
	elseif StoryWordCfg4[arg_48_1] ~= nil then
		return StoryWordCfg4[arg_48_1]
	elseif StoryWordCfg5 and StoryWordCfg5[arg_48_1] ~= nil then
		return StoryWordCfg5[arg_48_1]
	end

	error("无法在StoryWordCfg表中找到 " .. arg_48_1)

	return nil
end

return var_0_0
