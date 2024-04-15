slot0 = class("HeroFileArchivePage", ReduxView)

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
	slot0.curRecordID_ = 0
	slot0.linkTabItems_ = {}
	slot0.curTabIndex_ = 0
	slot0.curTabLockState_ = {}
	slot0.voiceCoolDown_ = false
	slot0.lockController = slot0.lockControllerEx_:GetController("lock")
	slot0.contentSizeFitter_ = slot0.detailTrs_:GetComponent("ContentSizeFitter")
end

function slot0.AddUIListener(slot0)
end

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		3
	})
end

function slot0.SwitchTab(slot0, slot1, slot2)
	if slot1 == slot0.curTabIndex_ then
		return
	end

	if slot0.linkTabItems_[slot0.curTabIndex_] then
		slot0.linkTabItems_[slot0.curTabIndex_]:SetSelectState(false)
	end

	slot0.linkTabItems_[slot1]:SetSelectState(true)
	slot0.detailTrs_:SetAnchoredPositionY(0)

	slot0.contentSizeFitter_.verticalFit = ContentSizeFitter.FitMode.Unconstrained
	slot0.contentSizeTimer_ = Timer.New(function ()
		uv0.contentSizeFitter_.verticalFit = ContentSizeFitter.FitMode.PreferredSize

		if uv0.contentSizeTimer_ then
			uv0.contentSizeTimer_:Stop()

			uv0.contentSizeTimer_ = nil
		end
	end, 0.2, 1)

	slot0.contentSizeTimer_:Start()

	slot0.titleText_.text = string.format(GetTips("HERO_RECORD_HEART_CHAIN"), slot1)

	if slot0.curTabLockState_[slot1] then
		slot0.lockController:SetSelectedState("lock")

		slot0.lockTipsText_.text = string.format(GetTips("HERO_HEART_CHAIN_PLOT_UNLOCK_LOVE"), slot1)
	else
		slot0.lockController:SetSelectedState("unlock")

		slot0.detailText_.text = HeroRecordCfg[slot0.curRecordID_]["heart_chain" .. slot1]

		if slot2 then
			slot0:PlayVoice(slot1)
		end

		if not ArchiveData:IsHeartRead(slot0.curRecordID_, slot1) then
			HeroAction.ReadHeartLink(slot0.curRecordID_, slot1)
			manager.redPoint:setTip(RedPointConst.HERO_HEARTLINK_ID .. slot0.curRecordID_ .. "_" .. slot1, 0)
		end
	end

	slot0.curTabIndex_ = slot1
end

function slot0.Show(slot0, slot1, slot2)
	slot0:UpdateView(slot1, slot2)
	SetActive(slot0.gameObject_, true)
end

function slot0.BindRedPoint(slot0, slot1, slot2)
	manager.redPoint:bindUIandKey(slot1.transform_, RedPointConst.HERO_HEARTLINK_ID .. slot0.curRecordID_ .. "_" .. slot2)
end

function slot0.Hide(slot0)
	for slot4 = 1, #slot0.linkTabItems_ do
		manager.redPoint:unbindUIandKey(slot0.linkTabItems_[slot4].transform_)
	end

	slot0:StopVoice()

	if slot0.contentSizeTimer_ then
		slot0.contentSizeTimer_:Stop()

		slot0.contentSizeTimer_ = nil
	end

	SetActive(slot0.gameObject_, false)
end

function slot0.PlayVoice(slot0, slot1)
	if slot0.voiceCoolDown_ then
		return
	end

	slot0.voiceCoolDown_ = true

	SDKTools.SendMessageToSDK("hero_sound", {
		hero_id = slot0.curHeroID_,
		sound_id = HeroVoiceCfg.get_id_list_by_file["trust" .. slot1][1]
	})
	slot0:StopVoice()

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
end

function slot0.UpdateView(slot0, slot1, slot2)
	slot0.curHeroID_ = slot2
	slot0.curRecordID_ = slot1

	if #slot0.linkTabItems_ == 0 then
		for slot6 = 1, HeroConst.HERO_HEARTLINK_STORY_MAX_COUNT do
			slot7 = Object.Instantiate(slot0.linktabitemGo_, slot0.linktabTrs_)

			SetActive(slot7, true)

			slot0.linkTabItems_[slot6] = HeroFileArchiveTabItem.New(slot7, slot6, function ()
				uv0:SwitchTab(uv1, true)
			end)
		end
	end

	for slot6 = 1, HeroConst.HERO_HEARTLINK_STORY_MAX_COUNT do
		slot8 = not IsConditionAchieved(GameSetting.heart_chain_unlock_condition.value[slot6], {
			heroId = slot0.curRecordID_
		})
		slot0.curTabLockState_[slot6] = slot8

		slot0.linkTabItems_[slot6]:SetLockState(slot8)
		slot0.linkTabItems_[slot6]:SetSelectState(false)
		slot0:BindRedPoint(slot0.linkTabItems_[slot6], slot6)
	end

	slot0.curTabIndex_ = 0

	slot0:SwitchTab(1)
end

function slot0.StopVoice(slot0)
	if slot0.delayPlayTimer_ then
		slot0.delayPlayTimer_:Stop()

		slot0.delayPlayTimer_ = nil
	end

	manager.audio:StopVoiceImmediate()

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
		slot0.voiceCoolDown_ = false
	end
end

function slot0.Dispose(slot0)
	for slot4 = 1, #slot0.linkTabItems_ do
		slot0.linkTabItems_[slot4]:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
