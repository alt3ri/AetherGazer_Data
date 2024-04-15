slot0 = class("ExchangeGlodByCurrency", ReduxView)

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
	if CurrencyData:GetGoldBuyTimes() < GameSetting.coin_max_buy_time.value[1] then
		slot3 = GameCurrencyBuySetting[slot1 + 1].diamond_to_money

		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) < GameCurrencyBuySetting[slot1 + 1].cost_diamond_to_money then
			ShopTools.DefaultOpenPopUp(slot2 - slot4)

			return
		end

		if not _G.SkipTip.SkipDiamondBuyGoldTip and SettingData:GetRemindSettingData().diamond_buy_gold_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("PAY_FOR_POWER"), slot2, ItemTools.getItemName(CurrencyIdMapCfg.CURRENCY_TYPE_GOLD.item_id), slot3),
				OkCallback = function ()
					_G.SkipTip.SkipDiamondBuyGoldTip = uv0.SkipDiamondBuyGoldTip_

					CurrencyAction.BuyCoin()
				end,
				ToggleCallback = function (slot0)
					uv0.SkipDiamondBuyGoldTip_ = slot0
				end
			})
		else
			CurrencyAction.BuyCoin()
		end
	else
		ShowTips("ERROR_SHOP_BUY_TIMES_LIMIT")
	end
end

function slot0.RefreshUI(slot0)
	slot1 = CurrencyData:GetGoldBuyTimes()
	slot2 = GameCurrencyBuySetting[slot1 + 1].cost_diamond_to_money
	slot3 = formatNumber(GameCurrencyBuySetting[slot1 + 1].diamond_to_money)
	slot4 = GameSetting.coin_max_buy_time.value[1]
	slot0.limitCntText_.text = string.format(GetTips("ITEM_REMAIN"), slot4 - CurrencyData:GetGoldBuyTimes(), slot4)
	slot0.useNumText_.text = slot2
	slot0.getNumText_.text = slot3
	slot0.tipsText_.text = string.format(GetTips("SELECT_MATERIAL_EXCHANGE"), slot2, ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_DIAMOND), slot3, ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_GOLD))
end

return slot0
