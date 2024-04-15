slot0 = class("StickerBubbleItem", ReduxView)
slot1 = import("game.quiz.QuizFunction")

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.isPlaying_ = false
	slot0.sticker_ = ChatStickerItem.New(slot0.stickerGo_)
	slot0.uiFollow_ = slot0.transform_:GetComponent("UIFollow")
end

function slot0.AddUIListeners(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.sticker_:RefreshData(slot2)
	slot0:SetSticker(slot1)
	SetActive(slot0.gameObject_, true)

	slot0.uiFollow_.enabled = true
	slot0.isPlaying_ = true

	slot0:SetTimer()
end

function slot0.SetSticker(slot0, slot1)
	if not uv0:GetPlyerModel(slot1):GetAttachEmoji() then
		return
	end

	slot0.uiFollow_.origin = slot3

	slot0.uiFollow_:UpdatePos()
end

function slot0.SetTimer(slot0)
	slot0:StopTimer()

	slot1 = 0
	slot0.timer_ = Timer.New(function ()
		uv0 = uv0 + 1

		if uv0 >= 3 then
			SetActive(uv1.gameObject_, false)

			uv1.uiFollow_.enabled = false
			uv1.isPlaying_ = false

			uv1:StopTimer()
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	slot0.sticker_:OnExit()

	slot0.isPlaying_ = false

	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.sticker_:Dispose()

	slot0.sticker_ = nil

	slot0.super.Dispose(slot0)
end

return slot0
