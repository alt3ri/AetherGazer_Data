slot1 = class("RechargeRechargeItemView", import("game.views.shop.base.ShopItemBase"))

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:RegistEventListener(RECHARGE_UPDATE, function (slot0)
		if slot0 == uv0.Cfg.id then
			uv0:UpdateView()
		end
	end)
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.firstController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "first")
	slot0.picController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "pic")
	slot0.firstChargeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "firstCharge")
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_recharge_id = uv0.Cfg.id
		})
		PayAction.RequestGSPay(uv0.Cfg.id, 1)
	end)
end

function slot1.SetData(slot0, slot1)
	slot0.Cfg = slot1

	slot0:UpdateView()
end

function slot1.UpdateView(slot0)
	slot1 = CurrencyConst.GetPlatformDiamondId()
	slot0.addIcon_.sprite = ItemTools.getItemSprite(slot1)
	slot0.rewardIcon_.sprite = ItemTools.getItemSprite(slot1)

	if SettingData:GetCurrentLanguage() == "fr" or slot4 == "de" then
		slot3 = string.gsub(tostring(PaymentCfg[slot0.Cfg.id].cost / 100), "%.", ",")
	end

	slot0.costLabel_.text = slot2.currency_symbol .. slot3
	slot0.rewardValueLabel_.text = string.format(GetTips("DIAMOND_AMOUNT"), tostring(slot0.Cfg.charge_num))

	slot0.picController_:SetSelectedIndex(slot0.Cfg.id - 1)

	if slot0:IsFirstRecharge() then
		slot0.firstController_:SetSelectedState("true")

		slot0.addValueLabel_.text = slot0.Cfg.first_charge

		slot0.firstChargeController_:SetSelectedState(slot0.Cfg.first_charge > 0 and "true" or "false")
	else
		slot0.firstController_:SetSelectedState("false")

		slot0.addValueLabel_.text = slot0.Cfg.not_first_charge

		slot0.firstChargeController_:SetSelectedState(slot0.Cfg.not_first_charge > 0 and "true" or "false")
		slot0.firstController_:SetSelectedState(slot0.Cfg.not_first_charge > 0 and "reback" or "false")
	end
end

function slot1.IsFirstRecharge(slot0)
	return not RechargeData:HaveRecharged(slot0.Cfg.id)
end

function slot1.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot1
