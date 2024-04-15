slot0 = class("ShowTransitionMgr", import("game.extend.BaseView"))

function slot0.Ctor(slot0)
	if not slot0.gameObject_ then
		slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/Common/switch"), manager.ui.uiMessage.transform)

		SetActive(slot0.gameObject_, false)

		slot0.image_ = slot0.gameObject_.transform:GetComponentInChildren(typeof(Image))
		slot0.color_ = slot0.image_.color
		slot0.color_.a = 0
		slot0.image_.color = slot0.color_
		slot0.animator_ = slot0.gameObject_:GetComponent("Animator")
	end

	gameContext:SetActions(handler(slot0, slot0.Show), handler(slot0, slot0.Hide))
end

function slot0.RegistCanEndFunc(slot0, slot1)
	slot0.canEndFunc_ = slot1
end

function slot0.Show(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6 = nil

	if slot3 then
		slot5, slot9 = manager.loadScene:GetNeedLoadSceneName(gameContext:GetAllOpenRoute())

		if not slot9 then
			manager.loadScene:StopSceneSoundEffect()
		else
			manager.loadScene:TryStopSceneSoundEffect(slot6)
		end
	end

	slot0:DoCallBack()
	slot0:ClearTimer()

	slot0.callBackFun_ = slot1

	if gameContext ~= nil and (not ViewConst.PLAY_TRANSITION_URL_LIST[gameContext:GetLastOpenPage()] or not slot2) and (not slot3 or not slot5) then
		if not slot3 or not gameContext:IsOpenRoute("home") then
			slot0:ClearTimer()
			slot0:DoCallBack()

			return
		end
	end

	SetActive(slot0.gameObject_, true)
	slot0:PlayAnimator("enter")

	if slot3 and slot5 then
		slot4 = slot5
	end

	if slot4 then
		manager.loadScene:SetShouldLoadSceneName(slot4)
	end

	slot0.waitNextFrameToCallback = false
	slot0.timer_ = FrameTimer.New(function ()
		slot0 = true

		if uv0.canEndFunc_ then
			slot0 = uv0.canEndFunc_() and manager.loadScene:CanEnd()
		end

		if not uv0.animator_:GetCurrentAnimatorStateInfo(0):IsName("enter") then
			uv0:PlayAnimator("enter")
		end

		if slot1.normalizedTime > 1 and slot1:IsName("enter") and slot0 then
			if not uv0.waitNextFrameToCallback then
				uv0.waitNextFrameToCallback = true
			else
				LoadingUIManager.inst:CloseLoadUI()
				uv0:ClearTimer()
				uv0:DoCallBack()

				uv0.waitNextFrameToCallback = false
			end
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.Hide(slot0, slot1, slot2)
	if gameContext ~= nil and (not ViewConst.PLAY_TRANSITION_URL_LIST[gameContext:GetLastOpenPage()] or not slot2) and not gameContext:IsOpenRoute("home") then
		slot0:DoCallBack()
		slot0:ClearTimer()
		SetActive(slot0.gameObject_, false)

		if slot1 then
			slot1()
		end

		return
	end

	slot0:PlayAnimator("out")
	slot0:DoCallBack()
	slot0:ClearTimer()

	slot0.callBackFun_ = slot1
	slot0.timer_ = FrameTimer.New(function ()
		if not uv0.animator_:GetCurrentAnimatorStateInfo(0):IsName("out") then
			uv0:PlayAnimator("out")
		end

		if slot0.normalizedTime > 1 and slot0:IsName("out") then
			uv0:ClearTimer()
			uv0:DoCallBack()
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.OnlyShowEffect(slot0, slot1, slot2)
	if isNil(slot0.animator_) then
		return
	end

	slot0:DoCallBack()
	slot0:ClearTimer()

	slot0.callBackFun_ = slot2

	if slot1 then
		slot0.color_.a = 0
		slot0.image_.color = slot0.color_
	else
		slot0.color_.a = 1
		slot0.image_.color = slot0.color_
	end

	SetActive(slot0.gameObject_, true)

	if not slot0.animator_:GetCurrentAnimatorStateInfo(0):IsName(slot1 and "enter" or "out") then
		slot0:PlayAnimator(slot3)
	end

	slot0.timer_ = FrameTimer.New(function ()
		if not uv0.animator_:GetCurrentAnimatorStateInfo(0):IsName(uv1) then
			uv0:PlayAnimator(uv1)
		end

		if slot0.normalizedTime > 1 and slot0:IsName(uv1) then
			uv0:ClearTimer()
			uv0:DoCallBack()
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.Dispose(slot0)
	gameContext:SetActions(nil, )

	if slot0.gameObject_ ~= nil then
		Object.Destroy(slot0.gameObject_)

		slot0.gameObject_ = nil
	end

	slot0:ClearTimer()

	slot0.image_ = nil
	slot0.canEndFunc_ = nil
	slot0.animator_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.ClearTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.DoCallBack(slot0)
	if slot0.callBackFun_ then
		slot0.callBackFun_()

		slot0.callBackFun_ = nil
	end
end

function slot0.PlayAnimator(slot0, slot1)
	if slot0.gameObject_.activeSelf then
		slot0.animator_:Play(slot1, -1, 0)
		slot0.animator_:Update(0)
	end
end

return slot0
