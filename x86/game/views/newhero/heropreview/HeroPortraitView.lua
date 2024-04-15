slot0 = class("HeroPortraitView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/ObtainUI/HeroMovie/PortraitPanel"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scaleImage_ = slot0:FindCom("UIScaleImage", nil, slot0.portriatTrans_)
	slot0.scaleMax_ = slot0.scaleImage_.maxScale
	slot0.scaleMin_ = slot0.scaleImage_.minScale
	slot0.scaleLength_ = slot0.scaleMax_ - slot0.scaleMin_
	slot0.timer_ = Timer.New(function ()
		uv0:OnHidenTimerReached()
	end, 2, -1)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.addBtn_, nil, function ()
		uv0:ChangeSliderValue(0.05)
	end)
	slot0:AddBtnListener(slot0.subBtn_, nil, function ()
		uv0:ChangeSliderValue(-0.05)
	end)
	slot0.slider_.onValueChanged:AddListener(function (slot0)
		uv0:OnSliderValueChanged(slot0)
	end)
	slot0.scaleImage_.onScaleEvent:AddListener(function (slot0)
		uv0:OnImageScaled(slot0)
	end)
	slot0.scaleImage_.onValueChanged:AddListener(function ()
		uv0:RestartAvatarBar()
	end)
end

function slot0.OnEnter(slot0)
	slot0.scaleImage_.enabled = true
	slot0.heroID_ = slot0.params_.heroID
	slot0.skinID_ = slot0.params_.skinID
	slot1 = nil
	slot0.portriatImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. ((slot0.skinID_ == nil or SkinCfg[slot0.skinID_].picture_id) and HeroTools.HeroUsingSkinInfo(slot0.heroID_).picture_id))

	slot0:OnImageScaled(1)
end

function slot0.ChangeSliderValue(slot0, slot1)
	if slot0.slider_.value + slot1 > 1 then
		slot3 = 1
	end

	if slot3 < 0 then
		slot3 = 0
	end

	slot0.slider_.value = slot3
end

function slot0.OnSliderValueChanged(slot0, slot1)
	slot0.scaleImage_:SetScale(slot1 * slot0.scaleLength_ + slot0.scaleMin_)
	slot0:RestartTimer()
end

function slot0.OnImageScaled(slot0, slot1)
	slot0:RestartAvatarBar()

	slot0.slider_.value = (slot1 - slot0.scaleMin_) / slot0.scaleLength_
end

function slot0.RestartAvatarBar(slot0)
	SetActive(slot0.sliderGo_, true)
	slot0:RestartTimer()
end

function slot0.RestartTimer(slot0)
	slot0.timer_:Stop()

	slot0.timer_ = Timer.New(function ()
		uv0:OnHidenTimerReached()
	end, 2, -1)

	slot0.timer_:Start()
end

function slot0.OnHidenTimerReached(slot0)
	SetActive(slot0.sliderGo_, false)
	slot0.timer_:Stop()
end

function slot0.OnTop(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()
	end

	slot0.scaleImage_:ResetContent()

	slot0.scaleImage_.enabled = false
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.slider_.onValueChanged:RemoveAllListeners()
	slot0.scaleImage_.onScaleEvent:RemoveAllListeners()
	slot0.scaleImage_.onValueChanged:RemoveAllListeners()

	slot0.scaleImage_ = nil

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
