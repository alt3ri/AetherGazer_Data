slot0 = class("GuideView")
slot1 = Vector2(50, 40)

function slot0.Ctor(slot0)
	slot0._isInit = false
end

function slot0.Init(slot0)
	if slot0._isInit then
		return
	end

	slot0.gameObject_ = GameObject.Instantiate(Asset.Load("Widget/System/GuideNewUI/GuideNewUI"), manager.ui.uiTips.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddUIListener()

	slot0._isInit = true

	SetActive(slot0.gameObject_, false)
end

function slot0.InitUI(slot0)
	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.gameObject_)

	slot0.breakGuideTrs_ = slot0.btnBreakGuide_.gameObject:GetComponent(typeof(RectTransform))
end

function slot0.AddUIListener(slot0)
	slot0.btnMaskBtn_.onClick:AddListener(function ()
		manager.guide:OnComponentClick()
	end)
	slot0.btnBreakGuide_.onClick:AddListener(function ()
		JumpTools.OpenPageByJump("guideStuckPopView", {
			content = GetTips("SKIP_GUIDE"),
			OkCallback = function ()
				manager.guide:SkipGuide(uv0.skipGuide_)
				manager.guide.view:Hide()
			end
		})
	end)
	slot0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		manager.guide:OnEventTrigger("pointerClick", slot1)
	end))
	slot0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		manager.guide:OnEventTrigger("pointerUp", slot1)
	end))
	slot0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		manager.guide:OnEventTrigger("pointerDown", slot1)
	end))
	slot0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		manager.guide:OnEventTrigger("beginDrag", slot1)
	end))
	slot0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		manager.guide:OnEventTrigger("drag", slot1)
	end))
	slot0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		manager.guide:OnEventTrigger("endDrag", slot1)
	end))
end

function slot0.RemoveUIListener(slot0)
	slot0.btnMaskBtn_.onClick:RemoveAllListeners()
	slot0.eventTrigger_:RemoveAllListeners()
end

function slot0.ShowTalk(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not slot1 or slot1 == "" then
		SetActive(slot0.textPanel_, false)

		return
	end

	slot0.scrollrect_.normalizedPosition = Vector2(0, 1)

	SetActive(slot0.textPanel_, true)

	slot0.textCom_.text = slot1
	slot0.dialogNameText_.text = slot4
	slot0.dialogHeadImg_.sprite = getSpriteViaConfig("StoryHeadIcon", string.format("story_%s", slot5))

	if slot2 == 1 then
		slot0.textRect_.anchorMax = Vector2.New(0, 1)
		slot0.textRect_.anchorMin = Vector2.New(0, 1)
	elseif slot2 == 2 then
		slot0.textRect_.anchorMax = Vector2.New(1, 1)
		slot0.textRect_.anchorMin = Vector2.New(1, 1)
	elseif slot2 == 3 then
		slot0.textRect_.anchorMax = Vector2.New(1, 0)
		slot0.textRect_.anchorMin = Vector2.New(1, 0)
	elseif slot2 == 4 then
		slot0.textRect_.anchorMax = Vector2.New(0, 0)
		slot0.textRect_.anchorMin = Vector2.New(0, 0)
	else
		slot0.textRect_.anchorMax = Vector2.New(0.5, 0.5)
		slot0.textRect_.anchorMin = Vector2.New(0.5, 0.5)
	end

	if slot6 == 1 then
		slot0.textRect_.anchoredPosition = Vector2.New((slot3[1] or 0) + ReduxView.VIEW_ADAPT_DISTANCE, slot3[2] or 0)
	elseif slot6 == 2 then
		slot0.textRect_.anchoredPosition = Vector2.New((slot3[1] or 0) - ReduxView.VIEW_ADAPT_DISTANCE, slot3[2] or 0)
	else
		slot0.textRect_.anchoredPosition = Vector2.New(slot3[1] or 0, slot3[2] or 0)
	end
end

function slot0.ShowHoldMask(slot0, slot1, slot2)
	slot3 = slot1:GetComponent("RectTransform")

	SetActive(slot0.gameObject_, true)
	SetActive(slot0.btnMaskGo_, true)

	slot4 = Vector3(0, 0, 0)
	slot5 = Vector3(0, 0, 0)
	slot6 = Vector2(0, 0)
	slot7 = Vector2(0, 0)

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot3)

	slot8 = Vector3((0.5 - slot3.pivot.x) * slot3.rect.width, (0.5 - slot3.pivot.y) * slot3.rect.height, 0)
	slot0.maskImgCom1_.pivot = slot3.pivot
	slot0.maskImgCom2_.pivot = slot3.pivot

	if slot1:GetComponent(typeof(Image)) and slot9.enabled then
		slot0.maskImage1_.sprite = slot9.sprite
		slot0.maskImage2_.sprite = slot9.sprite
	else
		slot0.maskImage1_.sprite = nil
		slot0.maskImage2_.sprite = nil
	end

	if slot0.timer_ then
		slot0.timer_:Stop()
	end

	slot0.timer_ = Timer.New(function ()
		if isNil(uv0) then
			uv1.timer_:Stop()

			uv1.timer_ = nil

			return
		end

		uv1.maskImgCom1_.sizeDelta = Vector2(uv2.rect.width, uv2.rect.height) + uv3
		uv1.maskImgCom2_.sizeDelta = Vector2(uv2.rect.width, uv2.rect.height) + uv3
		uv1.maskImgCom1_.position = uv2.position
		uv1.maskImgCom2_.position = uv2.position
		uv1.maskImgCom1_.eulerAngles = uv2.eulerAngles
		uv1.maskImgCom2_.eulerAngles = uv2.eulerAngles
		uv1.maskImgCom1_.localScale = uv4
		uv1.maskImgCom2_.localScale = uv4
		uv1.btnMaskCom_.sizeDelta = Vector2(uv2.rect.width, uv2.rect.height) + uv5 + uv6
		uv1.btnMaskCom_.position = uv2.position
		uv1.btnMaskCom_.anchoredPosition = uv1.btnMaskCom_.anchoredPosition + uv7
		uv1.btnMaskCom_.eulerAngles = uv2.eulerAngles
		uv1.btnMaskCom_.localScale = uv4
	end, 0.033, -1)

	slot0.timer_:Start()
end

function slot0.ShowBreakStuck(slot0, slot1, slot2)
	slot0:AdaptBreakGuide()

	slot0.skipGuide_ = slot1

	SetActive(slot0.btnBreakGuide_, slot2)
end

function slot0.AdaptBreakGuide(slot0)
	if not isNil(slot0.breakGuideTrs_) then
		slot0.breakGuideTrs_.anchoredPosition = Vector3(-ReduxView.VIEW_ADAPT_DISTANCE, -53.7, 0)
	end
end

function slot0.Hide(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()
	end

	SetActive(slot0.gameObject_, false)
end

function slot0.HideButton(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()
	end

	SetActive(slot0.btnMaskGo_, false)
end

function slot0.Dispose(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()
	end

	slot0.timer_ = nil

	if slot0._isInit then
		slot0:RemoveUIListener()
		Object.Destroy(slot0.gameObject_)
	end

	slot0._isInit = false
end

return slot0
