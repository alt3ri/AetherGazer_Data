slot0 = class("StickerBubbleView", ReduxView)

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

	slot0.bubbles_ = {}
end

function slot0.AddUIListeners(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshBubbleView(slot0, slot1, slot2)
	slot0:GetBubble(slot1):SetData(slot1, slot2)
end

function slot0.GetBubble(slot0, slot1)
	if not slot0.bubbles_[slot1] then
		slot0.bubbles_[slot1] = StickerBubbleItem.New(GameObject.Instantiate(slot0.bubbleTemplate_, slot0.transform_))
	end

	return slot2
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()

	for slot4, slot5 in pairs(slot0.bubbles_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in pairs(slot0.bubbles_) do
		slot5:Dispose()
	end

	slot0.bubbles_ = {}

	slot0.super.Dispose(slot0)
end

return slot0
