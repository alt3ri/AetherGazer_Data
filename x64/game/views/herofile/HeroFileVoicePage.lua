slot0 = class("HeroFileVoicePage", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.curHeroID_ = 0
	slot0.voiceList_ = {}
	slot0.playingVoiceIndex_ = 0
	slot0.voiceLuaUiList_ = LuaList.New(handler(slot0, slot0.IndexVoiceItem), slot0.voiceUilist_, HeroFileVoiceItem)
end

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		3
	})
end

function slot0.AddUIListener(slot0)
end

function slot0.IndexVoiceItem(slot0, slot1, slot2)
	slot2:SetData(slot0.curHeroID_, slot0.voiceList_[slot1], function ()
		PlayerAction.CheckHeroVoice(uv0.curHeroID_, function ()
			if uv0.playingVoiceIndex_ == uv1 then
				uv0:StopVoice()
			else
				uv0:PlayVoice(uv1, uv0.voiceList_[uv1].id)
			end
		end)
	end)

	if slot1 == slot0.playingVoiceIndex_ then
		slot2:StartPlay()
	else
		slot2:StopPlay()
	end
end

function slot0.Show(slot0, slot1, slot2)
	slot0:UpdateView(slot1, slot2)
	slot0.voiceLuaUiList_:StartScroll(#slot0.voiceList_)
	SetActive(slot0.dialogBoxGo_, false)
	SetActive(slot0.gameObject_, true)
end

function slot0.Hide(slot0)
	slot0:StopVoice()
	SetActive(slot0.gameObject_, false)
end

function slot0.UpdateVoiceData(slot0)
	slot0.voiceList_ = {}
	slot1 = 1

	for slot5, slot6 in ipairs(HeroVoiceCfg.all) do
		if HeroVoiceDescCfg.Get(slot0.curHeroID_, slot6) ~= nil and slot8 ~= "" then
			slot0.voiceList_[slot1] = {
				id = slot6,
				unlock = HeroTools:IsUnlockVoice(slot0.curHeroID_, slot6)
			}
			slot1 = slot1 + 1
		end
	end

	table.sort(slot0.voiceList_, function (slot0, slot1)
		if (slot0.unlock or slot1.unlock) and slot0.unlock ~= slot1.unlock then
			return slot0.unlock
		end

		return slot0.id < slot1.id
	end)
end

function slot0.PlayVoice(slot0, slot1, slot2)
	SDKTools.SendMessageToSDK("hero_sound", {
		hero_id = slot0.curHeroID_,
		sound_id = slot2
	})
	slot0:StopVoice()

	slot0.dialogText_.text = HeroVoiceDescCfg.Get(slot0.curHeroID_, slot2)

	SetActive(slot0.dialogBoxGo_, true)
	slot0.dialogAni_:Play("HeroFileVoicePageUI", 0)
	slot0.dialogAni_:Update(0)

	slot0.delayPlayTimer_ = Timer.New(function ()
		if manager.audio:IsStoppedOfVoice() then
			uv0.delayPlayTimer_:Stop()

			uv0.delayPlayTimer_ = nil
			slot0 = uv0.curHeroID_

			if HeroVoiceCfg[uv1].use_skin_id and HeroVoiceCfg[uv1].use_skin_id ~= 0 then
				slot0 = HeroVoiceCfg[uv1].use_skin_id
			end

			HeroTools.PlayVoice(slot0, HeroVoiceCfg[uv1].file, HeroVoiceCfg[uv1].type)

			uv0.timer_ = TimeTools.StartAfterSeconds(math.max(HeroTools.GetTalkLength(slot0, HeroVoiceCfg[uv1].file, HeroVoiceCfg[uv1].type), 0.017) / 1000, function ()
				uv0:StopVoice()
			end, {})
		end
	end, 0.033, -1)

	slot0.delayPlayTimer_:Start()

	slot0.playingVoiceIndex_ = slot1

	if slot0.voiceLuaUiList_:GetItemByIndex(slot1) then
		slot3:StartPlay()
	end
end

function slot0.StopVoice(slot0)
	SetActive(slot0.dialogBoxGo_, false)

	if slot0.delayPlayTimer_ then
		slot0.delayPlayTimer_:Stop()

		slot0.delayPlayTimer_ = nil
	end

	manager.audio:StopVoiceImmediate()

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	if slot0.playingVoiceIndex_ ~= 0 then
		if slot0.voiceLuaUiList_:GetItemByIndex(slot0.playingVoiceIndex_) then
			slot1:StopPlay()
		end

		slot0.playingVoiceIndex_ = 0
	end
end

function slot0.UpdateView(slot0, slot1, slot2)
	slot0.curHeroID_ = slot2

	slot0:UpdateVoiceData()
end

function slot0.Dispose(slot0)
	slot0.voiceLuaUiList_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
