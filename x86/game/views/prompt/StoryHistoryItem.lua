slot0 = class("StoryHistoryItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
	SetActive(slot0.voiceBtn_.gameObject, false)
	SetActive(slot0.gameObject_, true)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.voiceController_ = slot0.controller_:GetController("voice")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.voiceBtn_, nil, function ()
		if uv0.callback_ then
			uv0:callback_()
		end
	end)
end

function slot0.SetTitle(slot0, slot1)
	slot0.titleText_.text = slot1
end

function slot0.SetContent(slot0, slot1)
	slot0.contentText_.text = slot1
end

function slot0.SetVoiceCallback(slot0, slot1)
	slot0.callback_ = slot1

	if slot1 then
		SetActive(slot0.voiceBtn_.gameObject, true)
	else
		SetActive(slot0.voiceBtn_.gameObject, false)
	end
end

function slot0.PlayVoiceAni(slot0)
	slot0.voiceController_:SetSelectedState("play")
end

function slot0.StopVoiceAni(slot0)
	slot0.voiceController_:SetSelectedState("stop")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
