slot0 = class("MessageBoxItem")
slot1 = import("game.tools.ItemTools")
slot2 = import("game.tools.JumpTools")

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = Object.Instantiate(slot1, manager.ui.uiMessage.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.isFree_ = true

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.gameObject_)

	slot0.typeController_ = slot0.controllerEx_:GetController("type")
	slot0.singleController_ = slot0.controllerEx_:GetController("single")
	slot0.tipsController_ = slot0.controllerEx_:GetController("tips")
end

function slot0.AddListeners(slot0)
	slot0.okBtn_.onClick:AddListener(function ()
		OperationRecorder.Record(gameContext:GetLastOpenPage() .. "MessageBox", "okBtn")
		uv0:OnClickOk()
	end)
	slot0.cancelBtn_.onClick:AddListener(function ()
		OperationRecorder.Record(gameContext:GetLastOpenPage() .. "MessageBox", "cancelBtn")
		uv0:OnClickCancel()
	end)
	slot0.tipsBtn_.onClick:AddListener(function ()
		uv0.tipsFlag_ = not uv0.tipsFlag_

		uv0.tipsController_:SetSelectedState(tostring(uv0.tipsFlag_))
	end)
	slot0.maskBtn_.onClick:AddListener(function ()
		uv0:OnClickMask()
	end)
end

function slot0.OnClickOk(slot0)
	if slot0.gameObject_ then
		slot0:RevertSeparate()

		if slot0.info_.OkCallback then
			if slot0.info_.ToggleCallback then
				slot0.info_.ToggleCallback(slot0.tipsFlag_)
			end

			if slot0.info_.Param then
				slot0.info_.OkCallback(slot0.info_.Param)
			else
				slot0.info_.OkCallback()
			end
		end

		slot0:SetGameObjectInActive(true)
	end

	slot0:CloseWindow()
end

function slot0.OnClickCancel(slot0)
	if slot0.gameObject_ then
		slot0:RevertSeparate()

		if slot0.info_.ButtonType == "SingleBtn" then
			if slot0.info_.OkCallback then
				if slot0.info_.Param then
					slot0.info_.OkCallback(slot0.info_.Param)
				else
					slot0.info_.OkCallback()
				end
			end
		elseif slot0.info_.CancelCallback then
			slot0.info_.CancelCallback()
		end

		slot0:SetGameObjectInActive(false)
	end

	slot0:CloseWindow()
end

function slot0.OnClickMask(slot0)
	if slot0.info_.ButtonType == "SingleBtn" then
		return
	end

	if slot0.gameObject_ then
		slot0:RevertSeparate()

		if slot0.info_.MaskCallback then
			slot0.info_.MaskCallback()
		else
			slot0:OnClickCancel()
		end

		slot0:SetGameObjectInActive(false)
	end

	slot0:CloseWindow()
end

function slot0.RemoveListeners(slot0)
	slot0.okBtn_.onClick:RemoveAllListeners()
	slot0.cancelBtn_.onClick:RemoveAllListeners()
	slot0.tipsBtn_.onClick:RemoveAllListeners()
end

function slot0.IsFree(slot0)
	return slot0.isFree_
end

function slot0.SetData(slot0, slot1)
	slot0.info_ = slot1
	slot0.isFree_ = false

	manager.notify:Invoke(SHOW_MESSAGE_BOX)
	SetActive(slot0.gameObject_, true)

	if slot1.isTop then
		slot0.transform_:SetParent(manager.ui.uiTips.transform, false)
		slot0.transform_:SetAsLastSibling()
	else
		slot0.transform_:SetParent(manager.ui.uiMessage.transform, false)
	end

	slot0.singleController_:SetSelectedState(slot1.ButtonType == "SingleBtn" and "true" or "false")

	if slot0.info_.BtnText then
		slot0.leftBtnTxt_.text = slot0.info_.BtnText[2] or GetTips("CANCEL")
		slot0.rightBtnTxt_.text = slot0.info_.BtnText[3] or GetTips("CONFIRM")
	else
		slot0.leftBtnTxt_.text = GetTips("CANCEL")
		slot0.rightBtnTxt_.text = GetTips("CONFIRM")
	end

	if type(slot1.content) == "table" then
		slot0.typeController_:SetSelectedState("consume")
		slot0:ShowItemBox()
	else
		slot0.typeController_:SetSelectedState("tip")
		slot0:ShowNormalBox()
	end

	if slot1.toggleText then
		slot0.toggleTxt_.text = slot1.toggleText
	end

	slot2 = slot0.info_.ToggleCallback ~= nil

	SetActive(slot0.tipsGo_, slot2)

	if slot2 then
		SetActive(slot0.secondTextGo_, false)
	elseif slot0.info_.SecondTip then
		SetActive(slot0.secondTextGo_, true)

		slot0.secondText_.text = slot0.info_.SecondTip

		if slot0.info_.SecondValue then
			SetActive(slot0.secondValueGo_, true)

			slot0.secondValueText_.text = slot0.info_.SecondValue
		else
			SetActive(slot0.secondValueGo_, false)
		end
	else
		SetActive(slot0.secondTextGo_, false)
	end
end

function slot0.SetGaussionBg(slot0)
	if not manager.ui:GetUISeparateRender() then
		manager.ui:SetUISeparateRender(true)

		slot0.separateFlag_ = true
	end
end

function slot0.ShowNormalBox(slot0)
	slot0:SetGaussionBg()

	slot0.tipContent_.text = slot0.info_.content or ""
end

function slot0.ShowItemBox(slot0)
	for slot5 = 0, slot0.consumeBox_.transform.childCount - 1 do
		slot0.consumeBox_.transform:GetChild(slot5).gameObject:SetActive(false)
	end

	slot0.panelTrs_ = slot0.consumeBox_.transform:Find("typePanelMiddle")

	if slot0:GetIsFrontShow() then
		slot0.panelTrs_ = slot0.consumeBox_.transform:Find("typePanelFront")
	elseif slot0:GetIsMiddleShow() then
		slot0.panelTrs_ = slot0.consumeBox_.transform:Find("typePanelMiddle")
	else
		slot0.panelTrs_ = slot0.consumeBox_.transform:Find("typePanelBehind")
	end

	slot0.panelTrs_.gameObject:SetActive(true)

	slot0.frontTrs_ = slot0.panelTrs_:Find("frontText")
	slot0.cntTrs_ = slot0.panelTrs_:Find("cntText")
	slot0.behindTrs_ = slot0.panelTrs_:Find("behindText")
	slot0.frontText_ = slot0.frontTrs_:GetComponent("Text")
	slot0.sonsumeIcon_ = slot0.panelTrs_:Find("icon"):GetComponent("Image")
	slot0.cntText_ = slot0.cntTrs_:GetComponent("Text")
	slot0.behindText_ = slot0.behindTrs_:GetComponent("Text")

	slot0:SetGaussionBg()

	slot2 = slot0.info_.content
	slot0.frontText_.text = slot2[1]
	slot0.sonsumeIcon_.sprite = uv0.getItemSprite(slot2[2][1])
	slot0.cntText_.text = slot2[2][2]
	slot0.behindText_.text = slot2[3]

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.frontTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.cntTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.behindTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.panelTrs_)
end

function slot0.Hide(slot0)
	if slot0.gameObject_ then
		slot0:SetGameObjectInActive()
	end

	slot0:RevertSeparate()
	slot0:CloseWindow()
end

function slot0.CloseWindow(slot0)
	slot0.isFree_ = true
end

function slot0.RevertSeparate(slot0)
	if slot0.separateFlag_ then
		manager.ui:SetUISeparateRender(false)

		slot0.separateFlag_ = false
	end
end

function slot0.SetGameObjectInActive(slot0, slot1)
	if slot1 then
		function slot0.info_.ToggleCallback()
		end

		manager.notify:Invoke(CLOSE_MESSAGE_BOX)
	end

	slot0.tipsFlag_ = false

	slot0.tipsController_:SetSelectedState(tostring(slot0.tipsFlag_))
	SetActive(slot0.gameObject_, false)
end

function slot0.GetIsFrontShow(slot0)
	return slot0:CheckLanguage({
		"kr",
		"jp"
	})
end

function slot0.GetIsMiddleShow(slot0)
	return slot0:CheckLanguage({
		"en",
		"zh_cn",
		"tc",
		"de",
		"fr"
	})
end

function slot0.GetIsBehindShow(slot0)
	return false
end

function slot0.CheckLanguage(slot0, slot1)
	return table.indexof(slot1, SettingData:GetSettingData().sound.text_language)
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
