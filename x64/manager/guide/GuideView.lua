local var_0_0 = class("GuideView")
local var_0_1 = Vector2(50, 40)

function var_0_0.Ctor(arg_1_0)
	arg_1_0._isInit = false
end

function var_0_0.Init(arg_2_0)
	if arg_2_0._isInit then
		return
	end

	arg_2_0.gameObject_ = GameObject.Instantiate(Asset.Load("Widget/System/GuideNewUI/GuideNewUI"), manager.ui.uiTips.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0._isInit = true

	SetActive(arg_2_0.gameObject_, false)
end

function var_0_0.InitUI(arg_3_0)
	ComponentBinder.GetInstance():BindCfgUI(arg_3_0, arg_3_0.gameObject_)

	arg_3_0.breakGuideTrs_ = arg_3_0.btnBreakGuide_.gameObject:GetComponent(typeof(RectTransform))
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0.btnMaskBtn_.onClick:AddListener(function()
		manager.guide:OnComponentClick()
	end)
	arg_4_0.btnBreakGuide_.onClick:AddListener(function()
		local var_6_0 = {
			content = GetTips("SKIP_GUIDE"),
			OkCallback = function()
				manager.guide:SkipGuide(arg_4_0.skipGuide_)
				manager.guide.view:Hide()
			end
		}

		JumpTools.OpenPageByJump("guideStuckPopView", var_6_0)
	end)
	arg_4_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function(arg_8_0, arg_8_1)
		manager.guide:OnEventTrigger("pointerClick", arg_8_1)
	end))
	arg_4_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
		manager.guide:OnEventTrigger("pointerUp", arg_9_1)
	end))
	arg_4_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_10_0, arg_10_1)
		manager.guide:OnEventTrigger("pointerDown", arg_10_1)
	end))
	arg_4_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_11_0, arg_11_1)
		manager.guide:OnEventTrigger("beginDrag", arg_11_1)
	end))
	arg_4_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_12_0, arg_12_1)
		manager.guide:OnEventTrigger("drag", arg_12_1)
	end))
	arg_4_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_13_0, arg_13_1)
		manager.guide:OnEventTrigger("endDrag", arg_13_1)
	end))
end

function var_0_0.RemoveUIListener(arg_14_0)
	arg_14_0.btnMaskBtn_.onClick:RemoveAllListeners()
	arg_14_0.eventTrigger_:RemoveAllListeners()
end

function var_0_0.ShowTalk(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6)
	if not arg_15_1 or arg_15_1 == "" then
		SetActive(arg_15_0.textPanel_, false)

		return
	end

	arg_15_0.scrollrect_.normalizedPosition = Vector2(0, 1)

	SetActive(arg_15_0.textPanel_, true)

	arg_15_0.textCom_.text = arg_15_1
	arg_15_0.dialogNameText_.text = arg_15_4
	arg_15_0.dialogHeadImg_.sprite = getSpriteViaConfig("StoryHeadIcon", string.format("story_%s", arg_15_5))

	if arg_15_2 == 1 then
		arg_15_0.textRect_.anchorMax = Vector2.New(0, 1)
		arg_15_0.textRect_.anchorMin = Vector2.New(0, 1)
	elseif arg_15_2 == 2 then
		arg_15_0.textRect_.anchorMax = Vector2.New(1, 1)
		arg_15_0.textRect_.anchorMin = Vector2.New(1, 1)
	elseif arg_15_2 == 3 then
		arg_15_0.textRect_.anchorMax = Vector2.New(1, 0)
		arg_15_0.textRect_.anchorMin = Vector2.New(1, 0)
	elseif arg_15_2 == 4 then
		arg_15_0.textRect_.anchorMax = Vector2.New(0, 0)
		arg_15_0.textRect_.anchorMin = Vector2.New(0, 0)
	else
		arg_15_0.textRect_.anchorMax = Vector2.New(0.5, 0.5)
		arg_15_0.textRect_.anchorMin = Vector2.New(0.5, 0.5)
	end

	if arg_15_6 == 1 then
		arg_15_0.textRect_.anchoredPosition = Vector2.New((arg_15_3[1] or 0) + ReduxView.VIEW_ADAPT_DISTANCE, arg_15_3[2] or 0)
	elseif arg_15_6 == 2 then
		arg_15_0.textRect_.anchoredPosition = Vector2.New((arg_15_3[1] or 0) - ReduxView.VIEW_ADAPT_DISTANCE, arg_15_3[2] or 0)
	else
		arg_15_0.textRect_.anchoredPosition = Vector2.New(arg_15_3[1] or 0, arg_15_3[2] or 0)
	end
end

function var_0_0.ShowHoldMask(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1:GetComponent("RectTransform")

	SetActive(arg_16_0.gameObject_, true)
	SetActive(arg_16_0.btnMaskGo_, true)

	local var_16_1 = Vector3(0, 0, 0)
	local var_16_2 = Vector3(0, 0, 0)
	local var_16_3 = Vector2(0, 0)
	local var_16_4 = Vector2(0, 0)

	LayoutRebuilder.ForceRebuildLayoutImmediate(var_16_0)

	local var_16_5 = Vector3((0.5 - var_16_0.pivot.x) * var_16_0.rect.width, (0.5 - var_16_0.pivot.y) * var_16_0.rect.height, 0)

	arg_16_0.maskImgCom1_.pivot = var_16_0.pivot
	arg_16_0.maskImgCom2_.pivot = var_16_0.pivot

	local var_16_6 = arg_16_1:GetComponent(typeof(Image))

	if var_16_6 and var_16_6.enabled then
		arg_16_0.maskImage1_.sprite = var_16_6.sprite
		arg_16_0.maskImage2_.sprite = var_16_6.sprite
	else
		arg_16_0.maskImage1_.sprite = nil
		arg_16_0.maskImage2_.sprite = nil
	end

	if arg_16_0.timer_ then
		arg_16_0.timer_:Stop()
	end

	arg_16_0.timer_ = Timer.New(function()
		if isNil(arg_16_1) then
			arg_16_0.timer_:Stop()

			arg_16_0.timer_ = nil

			return
		end

		arg_16_0.maskImgCom1_.sizeDelta = Vector2(var_16_0.rect.width, var_16_0.rect.height) + var_16_4
		arg_16_0.maskImgCom2_.sizeDelta = Vector2(var_16_0.rect.width, var_16_0.rect.height) + var_16_4
		arg_16_0.maskImgCom1_.position = var_16_0.position
		arg_16_0.maskImgCom2_.position = var_16_0.position
		arg_16_0.maskImgCom1_.eulerAngles = var_16_0.eulerAngles
		arg_16_0.maskImgCom2_.eulerAngles = var_16_0.eulerAngles
		arg_16_0.maskImgCom1_.localScale = arg_16_2
		arg_16_0.maskImgCom2_.localScale = arg_16_2
		arg_16_0.btnMaskCom_.sizeDelta = Vector2(var_16_0.rect.width, var_16_0.rect.height) + var_0_1 + var_16_3
		arg_16_0.btnMaskCom_.position = var_16_0.position
		arg_16_0.btnMaskCom_.anchoredPosition = arg_16_0.btnMaskCom_.anchoredPosition + var_16_5
		arg_16_0.btnMaskCom_.eulerAngles = var_16_0.eulerAngles
		arg_16_0.btnMaskCom_.localScale = arg_16_2
	end, 0.033, -1)

	arg_16_0.timer_:Start()
end

function var_0_0.ShowBreakStuck(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:AdaptBreakGuide()

	arg_18_0.skipGuide_ = arg_18_1

	SetActive(arg_18_0.btnBreakGuide_, arg_18_2)
end

function var_0_0.AdaptBreakGuide(arg_19_0)
	if not isNil(arg_19_0.breakGuideTrs_) then
		arg_19_0.breakGuideTrs_.anchoredPosition = Vector3(-ReduxView.VIEW_ADAPT_DISTANCE, -53.7, 0)
	end
end

function var_0_0.Hide(arg_20_0)
	if arg_20_0.timer_ then
		arg_20_0.timer_:Stop()
	end

	SetActive(arg_20_0.gameObject_, false)
end

function var_0_0.HideButton(arg_21_0)
	if arg_21_0.timer_ then
		arg_21_0.timer_:Stop()
	end

	SetActive(arg_21_0.btnMaskGo_, false)
end

function var_0_0.Dispose(arg_22_0)
	if arg_22_0.timer_ then
		arg_22_0.timer_:Stop()
	end

	arg_22_0.timer_ = nil

	if arg_22_0._isInit then
		arg_22_0:RemoveUIListener()
		Object.Destroy(arg_22_0.gameObject_)
	end

	arg_22_0._isInit = false
end

return var_0_0
