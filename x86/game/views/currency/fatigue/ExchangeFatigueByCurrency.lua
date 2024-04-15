slot0 = class("ExchangeFatigueByCurrency", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.OnExchange(slot0)
	if GameCurrencyBuySetting[CurrencyData:GetFatigueBuyTimes() + 1].diamond_to_fatigue + ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) > 999 then
		ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

		return false
	end

	if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] then
		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) < GameCurrencyBuySetting[CurrencyData:GetFatigueBuyTimes() + 1].cost_diamond_to_fatigue then
			ShopTools.DefaultOpenPopUp(slot2 - CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND))

			return
		end

		if not _G.SkipTip.SkipDiamondBuyFatigueTip and SettingData:GetRemindSettingData().diamond_buy_fatigue_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("PAY_FOR_POWER"), slot2, ItemTools.getItemName(CurrencyIdMapCfg.CURRENCY_TYPE_FATIGUE.item_id), slot1),
				OkCallback = function ()
					_G.SkipTip.SkipDiamondBuyFatigueTip = uv0.SkipDiamondBuyFatigueTip_

					CurrencyAction.BuyFatigue()
				end,
				ToggleCallback = function (slot0)
					uv0.SkipDiamondBuyFatigueTip_ = slot0
				end
			})
		else
			CurrencyAction.BuyFatigue()
		end
	else
		ShowTips("ERROR_SHOP_BUY_TIMES_LIMIT")
	end
end

function slot0.RefreshUI(slot0)
	slot1 = GameCurrencyBuySetting[CurrencyData:GetFatigueBuyTimes() + 1].cost_diamond_to_fatigue
	slot2 = GameCurrencyBuySetting[CurrencyData:GetFatigueBuyTimes() + 1].diamond_to_fatigue
	slot3 = GameSetting.fatigue_max_buy_time.value[1]
	slot0.limitCntText_.text = string.format(GetTips("ITEM_REMAIN"), slot3 - CurrencyData:GetFatigueBuyTimes(), slot3)
	slot0.useNumText_.text = slot1
	slot0.getNumText_.text = slot2
	slot0.tipsText_.text = string.format(GetTips("SELECT_MATERIAL_EXCHANGE"), slot1, ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_DIAMOND), slot2, ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_VITALITY))
end

return slot0
