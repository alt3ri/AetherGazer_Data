local var_0_0 = class("PopNeedCostItemView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/PopUp/PopupCostUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_cancelBtn, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_maskBtn, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_okBtn, nil, function()
		arg_5_0:Back()

		if arg_5_0.params_.popCostCallBack then
			arg_5_0.params_.popCostCallBack()
		end
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.text1Text_.text = arg_9_0.params_.text1
	arg_9_0.text2Text_.text = arg_9_0.params_.text2

	local var_9_0 = arg_9_0.params_.costId or 0
	local var_9_1 = arg_9_0.params_.costCount or 0

	arg_9_0.m_costCountText.text = "x" .. var_9_1
	arg_9_0.m_costIcon.sprite = ItemTools.getItemSprite(var_9_0)

	local var_9_2 = arg_9_0.params_.itemId

	if var_9_2 then
		SetActive(arg_9_0.m_currency, true)

		arg_9_0.m_numText.text = ItemTools.getItemNum(var_9_2)
		arg_9_0.m_itemIcon.sprite = ItemTools.getItemSprite(var_9_2)
	else
		SetActive(arg_9_0.m_currency, false)
	end
end

return var_0_0
