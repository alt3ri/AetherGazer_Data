slot0 = class("WindowCurrencyItem", import("game.extend.ReduxView"))

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.currencyType_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
	slot0:RefreshUI()

	slot0.isCanAdd_ = true
	slot0.isCanClick_ = false
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(nil, , "OnClick")
	slot0:AddBtnListener(slot0.buttonIcon_, nil, function ()
		manager.notify:Invoke(WINDOW_BAR_INFO, uv0.currencyType_, uv0.gameObject_)

		if uv0.currencyType_ == CurrencyConst.GetPlatformDiamondId() then
			if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].flower_tips == 1 then
				JumpTools.OpenPageByJump("totalRecharge")
			end
		elseif slot0 == CurrencyConst.CURRENCY_TYPE_VITALITY and uv0.OnClickCurrencyFunc_ then
			uv0.OnClickCurrencyFunc_()
		end
	end)
end

function slot0.OnClick(slot0)
	if slot0.isCanAdd_ or slot0.isCanClick_ then
		if slot0.currencyType_ == CurrencyConst.CURRENCY_TYPE_GOLD then
			slot2 = false

			for slot7, slot8 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND] or {}) do
				if ItemTools.getItemNum(slot8) > 0 then
					slot2 = true

					break
				end
			end

			if CurrencyData:GetGoldBuyTimes() < GameSetting.coin_max_buy_time.value[1] or slot2 then
				JumpTools.OpenPopUp("currencyBuyGold", slot0.params_, ViewConst.SYSTEM_ID.BUY_GOLD)
			else
				ShowTips("ERROR_SHOP_BUY_TIMES_LIMIT")
			end
		elseif slot1 == CurrencyConst.CURRENCY_TYPE_DIAMOND then
			if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 1 then
				OperationRecorder.Record(gameContext:GetLastOpenPage() .. "_" .. slot0.class.__cname, "hongjing")
				ShopTools.DefaultOpenPopUp(0)
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")
			end
		elseif slot1 == CurrencyConst.GetPlatformDiamondId() then
			if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 0 then
				ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")
			else
				JumpTools.GoToSystem("/rechargeMain", {
					childShopIndex = 2,
					page = 3
				}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
				OperationRecorder.RecordButtonTouch("homepage_flower")
			end
		elseif slot1 == CurrencyConst.CURRENCY_TYPE_SKIN then
			if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 0 then
				ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")
			else
				JumpTools.GoToSystem("/rechargeMain", {
					childShopIndex = 4,
					page = 2
				}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
			end
		elseif slot1 == CurrencyConst.CURRENCY_TYPE_VITALITY then
			OperationRecorder.Record(gameContext:GetLastOpenPage() .. "_" .. slot0.class.__cname, "dundunzhi")
			JumpTools.OpenPopUp("currencyBuyFatigue", slot0.params_ or {
				page = 0
			}, ViewConst.SYSTEM_ID.BUY_FATIGUE)
		elseif slot1 == CurrencyConst.CURRENCY_TYPE_R_FRAGMENT or slot1 == CurrencyConst.CURRENCY_TYPE_SR_FRAGMENT or slot1 == CurrencyConst.CURRENCY_TYPE_SSR_FRAGMENT then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot1,
				0
			})
		elseif slot1 == CurrencyConst.CURRENCY_TYPE_EQUIP_PIECE or slot1 == CurrencyConst.CURRENCY_TYPE_EQUIP_CHIP_FIVESTAR or slot1 == CurrencyConst.CURRENCY_TYPE_EQUIP_CHIP_SIXSTAR then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot1,
				0
			})
		elseif slot1 == CurrencyConst.CURRENCY_TYPE_MYTHIC then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot1,
				0
			})
		elseif slot1 == CurrencyConst.CURRENCY_TYPE_MATRIX_COIN or slot1 == CurrencyConst.CURRENCY_TYPE_MATRIX_RING or slot1 == CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION or slot1 == CurrencyConst.CURRENCY_TYPE_MATRIX_PT or slot1 == CurrencyConst.CURRENCY_TYPE_BOSS_CHALLENGE then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot1,
				0
			})
		elseif slot1 == CurrencyConst.CURRENCY_TYPE_CLUB_A or slot1 == CurrencyConst.CURRENCY_TYPE_CLUB_B then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot1,
				0
			})
		else
			ShowPopItem(POP_SOURCE_ITEM, {
				slot1,
				0
			})
		end
	end
end

function slot0.SetCanAdd(slot0, slot1)
	if slot0.isCanAdd_ == slot1 then
		return
	end

	slot0.isCanAdd_ = slot1

	SetActive(slot0.add_, slot1)
end

function slot0.SetCanClick(slot0, slot1)
	slot0.isCanClick_ = slot1
end

function slot0.RefreshUI(slot0)
	if slot0.currencyType_ == CurrencyConst.CURRENCY_TYPE_VITALITY then
		slot0.text_.text = NumberTools.RetractNumberForWindBar(slot0:GetCnt(slot0.currencyType_)) .. "/" .. GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max
	elseif slot1 == CurrencyConst.GetPlatformDiamondId() then
		slot0.text_.text = NumberTools.RetractNumberForWindBar(CurrencyData:GetRechargeDiamond())
	else
		slot0.text_.text = NumberTools.RetractNumberForWindBar(slot0:GetCnt(slot0.currencyType_))
	end

	slot0.icon_.sprite = ItemTools.getItemLittleSprite(slot1)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 then
		slot0:RegistEventListener(CURRENCY_UPDATE, handler(slot0, slot0.UpdateCurrencyNum))
		slot0:RefreshUI()
		slot0.transform_:SetAsLastSibling()

		if slot0.currencyType_ == CurrencyConst.CURRENCY_TYPE_VITALITY then
			slot0:BindDailyFatigueRedPoint()
		end
	else
		slot0:RemoveAllEventListener()

		if slot0.currencyType_ == CurrencyConst.CURRENCY_TYPE_VITALITY then
			slot0:UnbindDailyFatigueRedPoint()
		end
	end
end

function slot0.UpdateCurrencyNum(slot0, slot1)
	if slot1 == 0 or slot1 == slot0.currencyType_ or CurrencyData:IsRechargeDiamond(slot1) and CurrencyData:IsRechargeDiamond(slot0.currencyType_) then
		slot0:RefreshUI()

		if slot1 == CurrencyConst.CURRENCY_TYPE_VITALITY and GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max <= slot0:GetCnt(slot0.currencyType_) and slot0.OnStopTimerFunc_ then
			slot0.OnStopTimerFunc_()
		end
	end
end

function slot0.GetCnt(slot0, slot1)
	if slot1 == CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A then
		return CommunityData:GetCurrenyA()
	elseif slot1 == CurrencyConst.CURRENCY_TYPE_ACTIVITY_REFORGE then
		return ActivityReforgeData:GetCurCanUseGold()
	else
		return ItemTools.getItemNum(slot1)
	end
end

function slot0.HaveVitalityMaterial(slot0)
	slot1 = false

	return #StoreTools.GetMaterialListBySubTypes({
		ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY,
		ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY_TIME_VALID
	}) > 0
end

function slot0.UnBindListener(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.RegistClickFunc(slot0, slot1)
	slot0.OnClickCurrencyFunc_ = slot1
end

function slot0.RegistTimeFunc(slot0, slot1)
	slot0.OnStopTimerFunc_ = slot1
end

function slot0.BindDailyFatigueRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.icon_.transform, RedPointConst.DAILY_FATIGUE, {
		x = 49,
		y = 39
	})
	manager.redPoint:updateKey(RedPointConst.DAILY_FATIGUE)
end

function slot0.UnbindDailyFatigueRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.icon_.transform, RedPointConst.DAILY_FATIGUE)
end

function slot0.Dispose(slot0)
	if slot0.currencyType_ == CurrencyConst.CURRENCY_TYPE_VITALITY then
		slot0:UnbindDailyFatigueRedPoint()
	end

	uv0.super.Dispose(slot0)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
