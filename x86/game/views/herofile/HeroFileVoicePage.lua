local var_0_0 = class("HeroFileVoicePage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.curHeroID_ = 0
	arg_3_0.voiceList_ = {}
	arg_3_0.playingVoiceIndex_ = 0
	arg_3_0.voiceLuaUiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexVoiceItem), arg_3_0.voiceUilist_, HeroFileVoiceItem)
end

function var_0_0.CameraEnter(arg_4_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		3
	})
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.IndexVoiceItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_0.curHeroID_, arg_6_0.voiceList_[arg_6_1], function()
		PlayerAction.CheckHeroVoice(arg_6_0.curHeroID_, function()
			if arg_6_0.playingVoiceIndex_ == arg_6_1 then
				arg_6_0:StopVoice()
			else
				arg_6_0:PlayVoice(arg_6_1, arg_6_0.voiceList_[arg_6_1].id)
			end
		end)
	end)

	if arg_6_1 == arg_6_0.playingVoiceIndex_ then
		arg_6_2:StartPlay()
	else
		arg_6_2:StopPlay()
	end
end

function var_0_0.Show(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:UpdateView(arg_9_1, arg_9_2)
	arg_9_0.voiceLuaUiList_:StartScroll(#arg_9_0.voiceList_)
	SetActive(arg_9_0.dialogBoxGo_, false)
	SetActive(arg_9_0.gameObject_, true)
end

function var_0_0.Hide(arg_10_0)
	arg_10_0:StopVoice()
	SetActive(arg_10_0.gameObject_, false)
end

function var_0_0.UpdateVoiceData(arg_11_0)
	arg_11_0.voiceList_ = {}

	local var_11_0 = 1

	for iter_11_0, iter_11_1 in ipairs(HeroVoiceCfg.all) do
		local var_11_1 = HeroTools:IsUnlockVoice(arg_11_0.curHeroID_, iter_11_1)
		local var_11_2 = HeroVoiceDescCfg.Get(arg_11_0.curHeroID_, iter_11_1)

		if var_11_2 ~= nil and var_11_2 ~= "" then
			arg_11_0.voiceList_[var_11_0] = {
				id = iter_11_1,
				unlock = var_11_1
			}
			var_11_0 = var_11_0 + 1
		end
	end

	table.sort(arg_11_0.voiceList_, function(arg_12_0, arg_12_1)
		if (arg_12_0.unlock or arg_12_1.unlock) and arg_12_0.unlock ~= arg_12_1.unlock then
			return arg_12_0.unlock
		end

		return arg_12_0.id < arg_12_1.id
	end)
end

function var_0_0.PlayVoice(arg_13_0, arg_13_1, arg_13_2)
	SDKTools.SendMessageToSDK("hero_sound", {
		hero_id = arg_13_0.curHeroID_,
		sound_id = arg_13_2
	})
	arg_13_0:StopVoice()

	arg_13_0.dialogText_.text = HeroVoiceDescCfg.Get(arg_13_0.curHeroID_, arg_13_2)

	SetActive(arg_13_0.dialogBoxGo_, true)
	arg_13_0.dialogAni_:Play("HeroFileVoicePageUI", 0)
	arg_13_0.dialogAni_:Update(0)

	arg_13_0.delayPlayTimer_ = Timer.New(function()
		if manager.audio:IsStoppedOfVoice() then
			arg_13_0.delayPlayTimer_:Stop()

			arg_13_0.delayPlayTimer_ = nil

			local var_14_0 = arg_13_0.curHeroID_

			if HeroVoiceCfg[arg_13_2].use_skin_id and HeroVoiceCfg[arg_13_2].use_skin_id ~= 0 then
				var_14_0 = HeroVoiceCfg[arg_13_2].use_skin_id
			end

			HeroTools.PlayVoice(var_14_0, HeroVoiceCfg[arg_13_2].file, HeroVoiceCfg[arg_13_2].type)

			local var_14_1 = HeroTools.GetTalkLength(var_14_0, HeroVoiceCfg[arg_13_2].file, HeroVoiceCfg[arg_13_2].type)
			local var_14_2 = math.max(var_14_1, 0.017)

			arg_13_0.timer_ = TimeTools.StartAfterSeconds(var_14_2 / 1000, function()
				arg_13_0:StopVoice()
			end, {})
		end
	end, 0.033, -1)

	arg_13_0.delayPlayTimer_:Start()

	arg_13_0.playingVoiceIndex_ = arg_13_1

	local var_13_0 = arg_13_0.voiceLuaUiList_:GetItemByIndex(arg_13_1)

	if var_13_0 then
		var_13_0:StartPlay()
	end
end

function var_0_0.StopVoice(arg_16_0)
	SetActive(arg_16_0.dialogBoxGo_, false)

	if arg_16_0.delayPlayTimer_ then
		arg_16_0.delayPlayTimer_:Stop()

		arg_16_0.delayPlayTimer_ = nil
	end

	manager.audio:StopVoiceImmediate()

	if arg_16_0.timer_ then
		arg_16_0.timer_:Stop()

		arg_16_0.timer_ = nil
	end

	if arg_16_0.playingVoiceIndex_ ~= 0 then
		local var_16_0 = arg_16_0.voiceLuaUiList_:GetItemByIndex(arg_16_0.playingVoiceIndex_)

		if var_16_0 then
			var_16_0:StopPlay()
		end

		arg_16_0.playingVoiceIndex_ = 0
	end
end

function var_0_0.UpdateView(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.curHeroID_ = arg_17_2

	arg_17_0:UpdateVoiceData()
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.voiceLuaUiList_:Dispose()
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
