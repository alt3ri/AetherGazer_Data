slot0 = class("ServantAvatarViewModule", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:BuildContext()
	slot0:AddUIListener()
end

function slot0.BuildContext(slot0)
	slot1 = slot0:FindCom("UIScaleImage", nil, slot0.scaleImageObj_)
	slot0.staticVar = {
		sliderIsHiden = true,
		scaleImage = slot1,
		minValue = slot1.minScale,
		maxValue = slot1.maxScale,
		ScaleLen = slot1.maxScale - slot1.minScale,
		hidenTimer = Timer.New(function ()
			uv0:OnHidenTimerReached()
		end, 2, -1)
	}
	slot0.controller = {
		comps = slot0.controller_,
		state = {
			checkView = {
				False = "false",
				name = "checkView",
				True = "true",
				comps = slot0.controller_:GetController("checkView")
			}
		}
	}
	slot0.servantId = nil
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:OnCloseBtnClick()
	end)
	slot0.avatarSlider_.onValueChanged:AddListener(function (slot0)
		uv0:OnAvatarSliderChanged(slot0)
	end)
	slot0.staticVar.scaleImage.onScaleEvent:AddListener(function (slot0)
		uv0:OnAvatarScale(slot0)
	end)
	slot0.staticVar.scaleImage.onValueChanged:AddListener(function ()
		uv0:RestartAvatarBar()
	end)
	slot0:AddBtnListener(slot0.subBtn_, nil, function ()
		uv0:OnSliderBtnChange(-0.05)
	end)
	slot0:AddBtnListener(slot0.addBtn_, nil, function ()
		uv0:OnSliderBtnChange(0.05)
	end)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.staticVar.scaleImage.onScaleEvent:RemoveAllListeners()
	slot0.staticVar.scaleImage.onValueChanged:RemoveAllListeners()

	slot0.staticVar.scaleImage = nil

	slot0.avatarSlider_.onValueChanged:RemoveAllListeners()
	slot0.staticVar.hidenTimer:Stop()

	slot0.staticVar.hidenTimer = nil

	uv0.super.Dispose(slot0)
end

function slot0.RegisterCloseCallback(slot0, slot1)
	slot0.staticVar.closeCallback = slot1
end

function slot0.EnterAvatarView(slot0, slot1)
	if slot1 then
		slot0:SwitchControllerState(slot0.controller.state.checkView.name, slot0.controller.state.checkView.True)

		slot0.staticVar.scaleImage.enabled = true
		slot0.staticVar.sliderIsHiden = true

		slot0:OnAvatarScale(1)
		slot0:RestartTimer()
		SetActive(slot0.gameObject_, true)
	else
		slot0:SwitchControllerState(slot0.controller.state.checkView.name, slot0.controller.state.checkView.False)

		slot0.staticVar.scaleImage.enabled = false

		slot0:ResetAvatar()
		slot0.staticVar.hidenTimer:Stop()
		SetActive(slot0.gameObject_, false)
	end
end

function slot0.OnCloseBtnClick(slot0)
	if slot0.staticVar.closeCallback then
		slot1()
	end
end

function slot0.OnSliderBtnChange(slot0, slot1)
	if slot0.avatarSlider_.value + slot1 > 1 then
		slot3 = 1
	end

	if slot3 < 0 then
		slot3 = 0
	end

	slot0.avatarSlider_.value = slot3
end

function slot0.SetAvatarSprite(slot0, slot1)
	slot0.avatarIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/WeaponServant/Portrait/" .. slot1)
	slot0.servantId = slot1
end

function slot0.ResetAvatar(slot0)
	slot0.staticVar.scaleImage:ResetContent()
end

function slot0.OnAvatarSliderChanged(slot0, slot1)
	slot0.staticVar.scaleImage:SetScale(slot0.staticVar.ScaleLen * slot1 + slot0.staticVar.minValue)
	slot0:RestartTimer()
end

function slot0.OnAvatarScale(slot0, slot1)
	slot0:RestartAvatarBar()

	slot0.avatarSlider_.value = (slot1 - slot0.staticVar.minValue) / slot0.staticVar.ScaleLen
end

function slot0.RestartAvatarBar(slot0)
	SetActive(slot0.sliderObj_, true)

	slot0.staticVar.sliderIsHiden = false

	slot0:RestartTimer()
end

function slot0.SwitchControllerState(slot0, slot1, slot2)
	if slot0.controller.state[slot1] and slot3.comps then
		slot3.comps:SetSelectedState(slot2)
	end
end

function slot0.OnHidenTimerReached(slot0)
	SetActive(slot0.sliderObj_, false)

	slot0.staticVar.sliderIsHiden = true

	slot0.staticVar.hidenTimer:Stop()
end

function slot0.RestartTimer(slot0)
	slot0.staticVar.hidenTimer:Stop()

	slot0.staticVar.hidenTimer = Timer.New(function ()
		uv0:OnHidenTimerReached()
	end, 2, -1)

	slot0.staticVar.hidenTimer:Start()
end

return slot0
