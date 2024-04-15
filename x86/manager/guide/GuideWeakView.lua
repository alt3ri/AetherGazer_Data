slot0 = class("GuideWeakView")
slot1 = Vector2(40, 30)

function slot0.Ctor(slot0)
	slot0._isInit = false
end

function slot0.Init(slot0)
	if slot0._isInit then
		return
	end

	slot0.gameObject_ = GameObject.Instantiate(Asset.Load("Widget/System/GuideNewUI/GuideWeakUI"), manager.ui.uiStory.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddUIListener()

	slot0._isInit = true

	SetActive(slot0.gameObject_, false)
end

function slot0.InitUI(slot0)
	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.gameObject_)
end

function slot0.AddUIListener(slot0)
	slot0.btnTextPanel_.onClick:AddListener(function ()
		uv0:Hide()
	end)
	slot0.btnIcon_.onClick:AddListener(function ()
		uv0:Hide()
	end)
	slot0.btnMaskBtn_.onClick:AddListener(function ()
		uv0:Hide()
	end)
end

function slot0.RemoveUIListener(slot0)
	if isNil(slot0.btnTextPanel_) or isNil(slot0.btnIcon_) or isNil(slot0.btnMaskBtn_) then
		return
	end

	slot0.btnTextPanel_.onClick:RemoveAllListeners()
	slot0.btnIcon_.onClick:RemoveAllListeners()
	slot0.btnMaskBtn_.onClick:RemoveAllListeners()
end

function slot0.UpdateView(slot0, slot1, slot2, slot3)
	slot0.id_ = slot1.id

	slot0:ShowTalk(slot1.talk_content, slot1.talk_anchors, slot1.talk_position, slot1.narrator_name, slot1.narrator_icon, slot1.talk_adapt)
	slot0:ShowHoldMask(slot3 or slot2)
	slot0:SetCloseTime(slot1.closetime)
end

function slot0.ShowTalk(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not slot1 or slot1 == "" then
		SetActive(slot0.textPanel_, false)

		return
	end

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

function slot0.ShowHoldMask(slot0, slot1)
	slot2 = slot1:GetComponent("RectTransform")
	slot0.isHide_ = false

	SetActive(slot0.gameObject_, not slot0.isHide_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot2)

	slot3 = Vector3((0.5 - slot2.pivot.x) * slot2.rect.width, (0.5 - slot2.pivot.y) * slot2.rect.height, 0)

	if slot0.timer_ then
		slot0.timer_:Stop()
	end

	slot0.timer_ = Timer.New(function ()
		if isNil(uv0) then
			uv1.timer_:Stop()

			uv1.timer_ = nil

			return
		end

		uv1.btnMaskCom_.sizeDelta = Vector2(uv2.rect.width, uv2.rect.height) + uv3
		uv1.btnMaskCom_.position = uv2.position
		uv1.btnMaskCom_.anchoredPosition = uv1.btnMaskCom_.anchoredPosition + uv4
		uv1.btnMaskCom_.eulerAngles = uv2.eulerAngles
	end, 0.033, -1)

	slot0.timer_:Start()
end

function slot0.SetCloseTime(slot0, slot1)
	if slot1 == 0 then
		return
	end

	slot0.closeTimer = Timer.New(function ()
		uv0:Hide()
	end, slot1, 0)

	slot0.closeTimer:Start()
end

function slot0.GetIsInWeakGuide(slot0)
	return not slot0.isHide_
end

function slot0.Hide(slot0, slot1)
	if slot0.isHide_ then
		return
	end

	if slot0.id_ and not slot1 then
		NewPlayerGuideAction.FinishWeakGuide(slot0.id_)

		slot0.id_ = nil
	end

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	if slot0.closeTimer then
		slot0.closeTimer:Stop()

		slot0.closeTimer = nil
	end

	slot0.isHide_ = true

	SetActive(slot0.gameObject_, not slot0.isHide_)
end

function slot0.Dispose(slot0)
	if slot0.id_ then
		NewPlayerGuideAction.FinishWeakGuide(slot0.id_)

		slot0.id_ = nil
	end

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	if slot0.closeTimer then
		slot0.closeTimer:Stop()

		slot0.closeTimer = nil
	end

	if slot0._isInit then
		slot0:RemoveUIListener()
		Object.Destroy(slot0.gameObject_)
	end

	slot0._isInit = false
end

return slot0
