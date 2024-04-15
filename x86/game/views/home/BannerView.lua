slot0 = class("BannerView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.info_ = slot3

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.info_ = slot2

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.judgeSize_ = slot0.listTrs_.sizeDelta
	slot0.calSliderWidth_ = 0
	slot0.gridTrs_ = slot0.grid_.transform
end

function slot0.AddUIListener(slot0)
	slot0:AddDragListener(slot0.listGo_, function ()
		uv0.timer_:Stop()
	end, function (slot0, slot1)
	end, function (slot0, slot1)
		OperationRecorder.Record("home", "activity_slide")

		slot2 = uv0.space_ or 0

		uv0:RemoveTween2()

		if (slot3 and uv0.judgeSize_.y or uv0.judgeSize_.x) / 2 < (uv0.info_.vertical and uv0.gridTrs_.localPosition.y or -uv0.gridTrs_.localPosition.x) then
			uv0.tween2_ = LeanTween.moveLocal(uv0.grid_, uv0:GetDragVector(-1), 0.25):setOnComplete(LuaHelper.VoidAction(function ()
				uv0.index_ = uv0:GetRealIndex(uv0.index_ + 1)

				uv0:RefreshBanner()
			end))
		elseif slot4 < -1 * slot5 then
			uv0.tween2_ = LeanTween.moveLocal(uv0.grid_, uv0:GetDragVector(1), 0.25):setOnComplete(LuaHelper.VoidAction(function ()
				uv0.index_ = uv0:GetRealIndex(uv0.index_ - 1)

				uv0:RefreshBanner()
			end))
		else
			uv0.tween2_ = LeanTween.moveLocal(uv0.grid_, Vector3(0, 0, 0), 0.25)
		end

		uv0:StartTimer()
	end)
	slot0:AddBtnListener(slot0.itembtn_, nil, function ()
		if uv0.info_.onclick then
			uv0.info_.onclick(uv0.info_.data[uv0.index_])
		end
	end)
end

function slot0.Render(slot0)
	slot0.index_ = 1
	slot0.dataNum_ = #slot0.info_.data

	slot0:InitBannerBar()
	slot0:RefreshBanner()
	slot0:StartTimer()
end

function slot0.RefreshBanner(slot0)
	slot0.grid_.transform.localPosition = Vector3(0, 0, 0)
	slot0.item2_.sprite = slot0.info_.data[slot0.index_].image
	slot0.item1_.sprite = slot0.info_.data[slot0:GetRealIndex(slot0.index_ - 1)].image
	slot0.item3_.sprite = slot0.info_.data[slot0:GetRealIndex(slot0.index_ + 1)].image

	slot0:SetBarPosition(slot0.index_ - 1)
end

function slot0.InitBannerBar(slot0)
	slot0.bar_.transform:SetSiblingIndex(0)

	for slot5 = slot0.sliderBg_.transform.childCount, slot0.dataNum_ + 1, -1 do
		Object.Destroy(slot0.sliderBg_.transform:GetChild(slot5 - 1).gameObject)
	end

	for slot5 = slot1 + 1, slot0.dataNum_ do
		SetActive(Object.Instantiate(slot0.barItem_, slot0.sliderBg_.transform), true)
	end
end

function slot0.StartTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()
	end

	slot0.timer_ = Timer.New(function ()
		uv0:RemoveTween()

		uv0.tween_ = LeanTween.moveLocal(uv0.grid_, uv0:GetDragVector(-1), 0.25):setOnComplete(LuaHelper.VoidAction(function ()
			uv0.index_ = uv0:GetRealIndex(uv0.index_ + 1)

			uv0:RefreshBanner()
			uv0:RemoveTween()
		end))
	end, 5, -1)

	slot0.timer_:Start()
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnComplete(nil)
		LeanTween.cancel(slot0.tween_.id)

		slot0.tween_ = nil
	end
end

function slot0.RemoveTween2(slot0)
	if slot0.tween2_ then
		slot0.tween2_:setOnComplete(nil)
		LeanTween.cancel(slot0.tween2_.id)

		slot0.tween2_ = nil
	end
end

function slot0.Init(slot0)
	slot0:Render()
end

function slot0.Dispose(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0:RemoveTween()
	slot0:RemoveTween2()

	slot0.info_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.GetRealIndex(slot0, slot1)
	if slot0.dataNum_ < slot1 then
		return 1
	elseif slot1 < 1 then
		return slot0.dataNum_
	else
		return slot1
	end
end

function slot0.SetBarPosition(slot0, slot1)
	slot0.bar_.transform:SetSiblingIndex(slot1)
end

function slot0.GetDragVector(slot0, slot1)
	if slot0.info_.vertical then
		return Vector3(0, -1 * slot1 * ((slot0.space_ or 0) + slot0.judgeSize_.y), 0)
	else
		return Vector3(slot1 * (slot2 + slot0.judgeSize_.x), 0, 0)
	end
end

return slot0
