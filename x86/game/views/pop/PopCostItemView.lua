slot0 = class("PopCostItemView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Common/Pop/PopupCostConfirmationUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.tipsController_ = slot0.controllerEx_:GetController("tips")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_cancelBtn, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.m_maskBtn, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.m_okBtn, nil, function ()
		uv0:Back()

		if uv0.params_.ToggleCallback then
			slot0(uv0.tipsFlag_)
		end

		if uv0.params_.popCostCallBack then
			uv0.params_.popCostCallBack()
		end
	end)
	slot0:AddBtnListener(slot0.m_tipsBtn_, nil, function ()
		uv0.tipsFlag_ = not uv0.tipsFlag_

		uv0.tipsController_:SetSelectedState(tostring(uv0.tipsFlag_))
	end)
end

function slot0.OnEnter(slot0)
	slot0.m_costCountText.text = slot0.params_.content

	SetActive(slot0.m_tips, slot0.params_.ToggleCallback ~= nil)

	slot0.tipsTxt_.text = slot0.params_.ToggleText or GetTips("LOGIN_MUTE_TIP")
	slot0.tipsFlag_ = false

	slot0.tipsController_:SetSelectedState(tostring(slot0.tipsFlag_))
end

function slot0.OnTop(slot0)
	slot0.lastBarList_ = manager.windowBar:GetLastBarList() or {}
	slot0.lastAddBarList_ = manager.windowBar:GetLastAddBarList()
	slot0.lastCanClickBarList_ = manager.windowBar:GetLastCanClickBarList()
	slot1 = slot0.params_.costId or 0

	manager.windowBar:SwitchBar({
		slot1
	})
	manager.windowBar:SetBarCanAdd(slot1, slot0:IsItemCanAdd(slot1))
	manager.windowBar:SetBarCanClick(slot1, true)
	manager.windowBar:SetAsLastSibling()
end

function slot0.OnExit(slot0)
	if slot0.lastBarList_ then
		manager.windowBar:SwitchBar(slot0.lastBarList_)
	end

	if slot0.lastAddBarList_ then
		for slot4, slot5 in ipairs(slot0.lastAddBarList_) do
			manager.windowBar:SetBarCanAdd(slot5, true)
		end
	end

	if slot0.lastCanClickBarList_ then
		for slot4, slot5 in ipairs(slot0.lastCanClickBarList_) do
			manager.windowBar:SetBarCanClick(slot5, true)
		end
	end
end

function slot0.IsItemCanAdd(slot0, slot1)
	if slot1 == CurrencyConst.CURRENCY_TYPE_DIAMOND then
		return true
	end

	return false
end

return slot0
