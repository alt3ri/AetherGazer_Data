slot0 = class("HeroFileVoiceItem", ReduxView)

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

	slot0.lockController_ = slot0.voiceControllerEx_:GetController("lock")
	slot0.playController_ = slot0.voiceControllerEx_:GetController("playing")
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.unlock_ = slot2.unlock
	slot0.onClick_ = slot3

	if slot2.unlock then
		slot0.lockController_:SetSelectedState("unlock")

		slot0.voiceNameText_.text = HeroVoiceCfg[slot2.id].title
	else
		slot0.lockController_:SetSelectedState("lock")

		slot0.voiceNameText_.text = HeroVoiceCfg[slot2.id].title

		if DormHeroTools:IsVoiceNeedUnlock(slot2.id, slot1) then
			slot0.voiceLockText_.text = string.format(GetTips("DORM_VOICE_UNLOCK_TIP"), DormHeroTools:GetVoiceUnlockLevel(slot1, slot2.id))
		else
			slot0.voiceLockText_.text = ConditionCfg[HeroVoiceCfg[slot2.id].unlock_condition].desc
		end
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.voiceBtn_, nil, function ()
		if uv0.onClick_ and uv0.unlock_ then
			uv0.onClick_()
		end
	end)
end

function slot0.StopPlay(slot0)
	slot0.playController_:SetSelectedState("stop")
end

function slot0.StartPlay(slot0)
	slot0.playController_:SetSelectedState("play")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
