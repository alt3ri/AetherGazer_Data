slot0 = class("FishItem", ReduxView)

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

	slot0.oriX_ = slot0.transform_.localPosition.x
	slot0.direct_ = -1
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.data_ = slot1
	slot0.fishCfg_ = GameFishCfg[slot1.fishId]

	slot0:UpdateView()
end

function slot0.GetData(slot0)
	return slot0.data_
end

function slot0.UpdateView(slot0)
	slot0.hitArea_.sizeDelta = Vector2(slot0.data_.hitWidth, slot0.data_.hitHeight)

	slot0:DrawDebug()
end

function slot0.DrawDebug(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Update(slot0, slot1)
	if slot0.data_.moveable == 1 and FishGameManager.GetInstance():GetBuff() ~= 3 then
		slot2 = slot0.transform_.localPosition
		slot2.x = slot2.x + slot1 * slot0.direct_ * slot0.fishCfg_.speed / 10 * 60

		if slot2.x < slot0.oriX_ - slot0.data_.radius then
			slot2.x = slot0.oriX_ - slot0.data_.radius
			slot0.direct_ = 1

			if slot0.imageTransform_.localScale == nil then
				CustomLog.Log(string.format("scale is nil"))
			end

			slot3.x = -1
			slot0.imageTransform_.localScale = slot3
		elseif slot2.x > slot0.oriX_ + slot0.data_.radius then
			slot2.x = slot0.oriX_ + slot0.data_.radius
			slot0.direct_ = -1
			slot3 = slot0.imageTransform_.localScale
			slot3.x = 1
			slot0.imageTransform_.localScale = slot3
		end

		slot0.transform_.localPosition = slot2
	end
end

function slot0.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
	uv0.super.Dispose(slot0)
end

return slot0
