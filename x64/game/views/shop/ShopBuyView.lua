slot0 = class("ShopBuyView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Common/Pop/showpopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.useNumTriggerListener_ = slot0.useNumSliderGo_.transform:GetComponent(typeof(EventTriggerListener))
	slot0.bgController = slot0.controller_:GetController("bg")
	slot0.groupController = slot0.controller_:GetController("group")
	slot0.timeController = slot0.controller_:GetController("time")
	slot0.viewController = slot0.controller_:GetController("view")
	slot0.starController = slot0.controller_:GetController("star")
	slot0.ndtabController = slot0.controller_:GetController("ndtab")
	slot0.consumeController = slot0.controller_:GetController("consume")
	slot0.furnitureController = slot0.controller_:GetController("Furniture")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.tipGo_, nil, function ()
		if ItemCfg[uv0.shopCfg.give_id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
			JumpTools.OpenPageByJump("/showServantView", {
				state = "onlydetail",
				id = uv0.shopCfg.give_id
			})
			OperationRecorder.Record("ShopItemView", "ExplaintBut")
		elseif slot1 == ItemConst.ITEM_TYPE.EQUIP then
			ShowPopItem(POP_SOURCE_ITEM, {
				uv0.shopCfg.give_id,
				1
			}, nil)
			OperationRecorder.Record("ShopItemView", "ExplaintBut")
		elseif slot1 == ItemConst.ITEM_TYPE.SCENE then
			JumpTools.OpenPageByJump("/skinDlcShow", {
				goodId = uv0.goodID
			})
		end
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddPressingByTimeListener(slot0.addBtn_.gameObject, 3, 0.5, 0.2, function ()
		uv0.selectNum_ = math.min(uv0.selectNum_ + 1, uv0:GetMaxBuyNum())

		uv0:RefreshNum()

		uv0.useNumSlider_.value = uv0.selectNum_
	end)
	slot0:AddPressingByTimeListener(slot0.delBtn_.gameObject, 3, 0.5, 0.2, function ()
		uv0.selectNum_ = math.max(uv0.selectNum_ - 1, 1)

		uv0:RefreshNum()

		uv0.useNumSlider_.value = uv0.selectNum_
	end)
	slot0.useNumSlider_.onValueChanged:AddListener(function ()
		uv0.selectNum_ = uv0.useNumSlider_.value
		uv0.selectNum_ = Mathf.Clamp(uv0.selectNum_, 1, uv0:GetMaxBuyNum())
		uv0.useNumSlider_.value = uv0.selectNum_

		uv0:RefreshNum()
	end)
	slot0.useNumTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0:RefreshNum()

		uv0.useNumSlider_.value = uv0.selectNum_

		OperationRecorder.Record("shop", "shop_number_slide")
	end))
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		slot0 = uv0.goodInfo

		if OperationData:IsFunctionStoped(ShopListCfg[uv0.shopCfg.shop_id].operation_stop_id) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		if ItemCfg[slot1.give_id].type == ItemConst.ITEM_TYPE.HERO_PIECE or slot3.type == ItemConst.ITEM_TYPE.HERO then
			slot5 = HeroData:GetHeroOmegaNeedPiece(slot3.id % 10000)

			if slot1.shop_id == ShopConst.SHOP_ID.REPORT_SHOP and slot5 <= 0 then
				ShowTips("OMEGA_ENOUGH_TIP")

				return
			end

			if not _G.SkipTip.ShopOmega and slot5 < uv0.selectNum_ then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("SHOP_OMEGA_CONFIRMATION"),
					OkCallback = function ()
						_G.SkipTip.ShopOmega = uv0.ShopOmega_

						ShopAction.BuyItem({
							{
								goodID = uv1.id,
								buyNum = uv0.selectNum_
							}
						})
					end,
					ToggleCallback = function (slot0)
						uv0.ShopOmega_ = slot0
					end
				})

				return
			end
		end

		slot4 = SettingData:GetRemindSettingData()
		slot5 = slot1.cost_id

		if not _G.SkipTip.SkipDiamondBuyItemTip and slot5 == CurrencyIdMapCfg.CURRENCY_TYPE_DIAMOND.item_id and slot4.diamond_buy_item_reminder == 1 or not _G.SkipTip.SkipCoreEquipBuyItemTip and slot5 == CurrencyIdMapCfg.CURRENCY_TYPE_SIX_STAR_EQUIP_RESOLVE.item_id and slot4.core_equip_buy_item_reminder == 1 or not _G.SkipTip.SkipInfoBadageTopBuyItemTip and slot5 == CurrencyIdMapCfg.CURRENCY_TYPE_INFO_BADGE_TOP.item_id and slot4.info_badge_top_buy_item_reminder == 1 or not _G.SkipTip.SkipBossChangeSBuyItemTip and slot5 == CurrencyIdMapCfg.CURRENCY_TYPE_BOSS_CHALLENGE_S.item_id and slot4.boss_challenge_s_buy_item_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("SHOP_SECONDARY_CONFIRMATION"), ItemTools.getItemName(slot5), uv0.cost_, ItemTools.getItemName(slot3.id), uv0.selectNum_),
				OkCallback = function ()
					if uv0 == CurrencyIdMapCfg.CURRENCY_TYPE_DIAMOND.item_id then
						_G.SkipTip.SkipDiamondBuyItemTip = uv1.SkipDiamondBuyItemTip_
					elseif uv0 == CurrencyIdMapCfg.CURRENCY_TYPE_SIX_STAR_EQUIP_RESOLVE.item_id then
						_G.SkipTip.SkipCoreEquipBuyItemTip = uv1.SkipCoreEquipBuyItemTip_
					elseif uv0 == CurrencyIdMapCfg.CURRENCY_TYPE_INFO_BADGE_TOP.item_id then
						_G.SkipTip.SkipInfoBadageTopBuyItemTip = uv1.SkipInfoBadageTopBuyItemTip_
					elseif uv0 == CurrencyIdMapCfg.CURRENCY_TYPE_BOSS_CHALLENGE_S.item_id then
						_G.SkipTip.SkipBossChangeSBuyItemTip = uv1.SkipBossChangeSBuyItemTip_
					end

					ShopAction.BuyItem({
						{
							goodID = uv2.id,
							buyNum = uv1.selectNum_
						}
					})
				end,
				ToggleCallback = function (slot0)
					if uv0 == CurrencyIdMapCfg.CURRENCY_TYPE_DIAMOND.item_id then
						uv1.SkipDiamondBuyItemTip_ = slot0
					elseif uv0 == CurrencyIdMapCfg.CURRENCY_TYPE_SIX_STAR_EQUIP_RESOLVE.item_id then
						uv1.SkipCoreEquipBuyItemTip_ = slot0
					elseif uv0 == CurrencyIdMapCfg.CURRENCY_TYPE_INFO_BADGE_TOP.item_id then
						uv1.SkipInfoBadageTopBuyItemTip_ = slot0
					elseif uv0 == CurrencyIdMapCfg.CURRENCY_TYPE_BOSS_CHALLENGE_S.item_id then
						uv1.SkipBossChangeSBuyItemTip_ = slot0
					end
				end
			})
		elseif slot5 == CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE.item_id then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("SHOP_SECONDARY_CONFIRMATION"), ItemTools.getItemName(slot5), uv0.cost_, ItemTools.getItemName(slot3.id), uv0.selectNum_),
				OkCallback = function ()
					ShopAction.BuyItem({
						{
							goodID = uv0.id,
							buyNum = uv1.selectNum_
						}
					})
				end
			})
		elseif slot3.type == ItemConst.ITEM_TYPE.SCENE and HomeSceneSettingCfg[slot3.param[1]].limit_display == 0 then
			slot6 = true
			slot7 = nil

			for slot11, slot12 in ipairs(SkinSceneActionCfg.all) do
				if SkinSceneActionCfg[slot12].special_scene_id == slot3.param[1] then
					if ShopTools.HaveSkin(slot13.skin_id) or HeroTools.CanChangeSkin(slot7) then
						slot6 = true

						break
					end

					slot6 = false

					break
				end
			end

			if slot6 then
				ShopAction.BuyItem({
					{
						goodID = slot0.id,
						buyNum = uv0.selectNum_
					}
				})
			else
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTipsF("BUY_SCENE_NOT_HAVE_HERO_SKIN_CONFIRM", SkinCfg[slot7].name, ItemTools.getItemName(slot3.id)),
					OkCallback = function ()
						ShopAction.BuyItem({
							{
								goodID = uv0.id,
								buyNum = uv1.selectNum_
							}
						})
					end
				})
			end
		else
			ShopAction.BuyItem({
				{
					goodID = slot0.id,
					buyNum = uv0.selectNum_
				}
			})
		end
	end)
end

function slot0.OnShopBuyResult(slot0, slot1, slot2, slot3, slot4)
	if slot1 == 0 then
		slot5 = getShopCfg(slot2)
		slot7 = slot5.give

		slot0:Back()

		if ItemCfg[slot5.give_id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			getReward({
				{
					num = 1,
					id = slot6
				}
			}, {
				ItemConst.ITEM_TYPE.HERO_SKIN
			})
		elseif slot8 == ItemConst.ITEM_TYPE.EQUIP and EquipData:GetEquipBagFull() then
			showEquipSendMail(nil)
			EquipAction.EquipBagFull(false)
		end
	end
end

function slot0.RefreshUI(slot0)
	slot0.useNumSlider_.minValue = 0
	slot0.useNumSlider_.maxValue = slot0:GetMaxBuyNum()

	slot0.groupController:SetSelectedState("false")
	SetActive(slot0.heroIcon_, false)
	SetActive(slot0.commonIconGo_, true)

	if ItemCfg[slot0.shopCfg.give_id].type == ItemConst.ITEM_TYPE.EQUIP or slot2.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		slot0.starController:SetSelectedState(slot2.rare)
	elseif slot2.type == ItemConst.ITEM_TYPE.HERO then
		slot0.starController:SetSelectedState("0")
		slot0.groupController:SetSelectedState("true")

		slot0.campIcon_.sprite = HeroTools.GetHeroRaceIcon(slot1.give_id)
		slot0.itemIcon_.sprite = ItemTools.getItemSprite(slot1.give_id)

		SetActive(slot0.heroIcon_, true)
		SetActive(slot0.commonIconGo_, false)
	else
		slot0.starController:SetSelectedState("0")
	end

	slot0.bgController:SetSelectedState(tostring(slot2.display_rare))
	slot0.ndtabController:SetSelectedState("off")
	slot0.viewController:SetSelectedState(tostring(slot2.type == ItemConst.ITEM_TYPE.EQUIP or slot2.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT or slot2.type == ItemConst.ITEM_TYPE.SCENE))

	if slot2.type == ItemConst.ITEM_TYPE.EQUIP then
		slot0.haveNumText_.text = NumberTools.RetractNumber(#EquipTools.GetEquipListByEquipid(slot1.give_id))
	elseif slot2.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		slot0.haveNumText_.text = NumberTools.RetractNumber(#(WeaponServantData:GetWeaponServantById(slot1.give_id) or {}))
	else
		slot0.haveNumText_.text = NumberTools.RetractNumber(ItemTools.getItemNum(slot1.give_id))
	end

	slot0.commonIcon_.sprite = ItemTools.getItemSprite(slot1.give_id)
	slot0.discountTxt_.text = ShopTools.GetDiscountLabel(slot0.goodID)

	if ShopTools.GetDiscount(slot0.goodID) ~= 100 then
		slot0.ndtabController:SetSelectedState("discount")
	end

	if slot0.shopCfg.tag == ShopConst.TAGS.NEW then
		slot0.ndtabController:SetSelectedState("new")
	end

	if ShopTools.GetDiscount(slot0.goodID) ~= 100 and slot0.shopCfg.tag == ShopConst.TAGS.NEW then
		slot0.ndtabController:SetSelectedState("all")
	end

	slot0.nameText_.text = ItemTools.getItemName(slot2.id)
	slot0.descText_.text = ItemTools.getItemDesc(slot2.id)

	slot0:RefreshNum()

	slot0.useNumSlider_.value = slot0.selectNum_
	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(slot1.cost_id)

	SetActive(slot0.limitGo_, slot0:IsLimit())

	if slot0:IsLimit() then
		if slot0.shopCfg.shop_refresh == 1 then
			slot0.limitText_.text = GetTips(ShopConst.SHOP_LIMIT_TEXT[slot1.refresh_cycle]) .. slot0:GetRestNum() .. "/" .. slot0:GetLimitNum()
		else
			slot0.limitText_.text = GetTips("PURCHASE_LIMIT") .. slot0:GetRestNum() .. "/" .. slot0:GetLimitNum()
		end
	end

	slot0:CheckNeedLabel()
end

function slot0.CheckNeedLabel(slot0)
	if DormFurnitureTools:CheckFurShowExtendLable(slot0.shopCfg.give_id) then
		slot0.furnitureController:SetSelectedState("true")
		slot0:UpdateDormLabel()
	else
		slot0.furnitureController:SetSelectedState("false")
	end
end

function slot0.UpdateDormLabel(slot0)
	if BackHomeFurniture[slot0.shopCfg.give_id] then
		for slot6, slot7 in ipairs(BackHomeFurniture[slot0.shopCfg.give_id].scene_id) do
			slot1 = "" .. DormTools:GetRoomTypeName(slot7) .. " "
		end

		slot0.dormRangeTxt_.text = slot1
		slot0.dormLimitTxt_.text = DormTools:GetFurGiftMaxDesc(slot0.shopCfg.give_id)
		slot0.comfortableTxt_.text = DormTools:GetFurComfortDesc(slot0.shopCfg.give_id)
		slot0.dormTypeTxt_.text = DormTools:GetFurGiftTypeDesc(slot0.shopCfg.give_id)
	else
		slot0.dormTypeTxt_.text = ""
		slot0.dormRangeTxt_.text = ""
		slot0.dormLimitTxt_.text = ""
		slot0.comfortableTxt_.text = ""
	end
end

function slot0.GetLabelList(slot0, slot1)
	if BackHomeFurniture[slot1] then
		return DormTools:GetFurLable(slot1)
	end
end

function slot0.RefreshNum(slot0)
	slot0.useNumText_.text = GetTips("DORM_CAN_BUY_NUM") .. "：" .. slot0.selectNum_
	slot1, slot2 = ShopTools.GetPrice(slot0.goodInfo.id)

	if slot1 == 0 then
		slot0.consumeController:SetSelectedState("free")
	else
		slot0.originPriceTxt_.text = slot2 * slot0.selectNum_

		slot0.consumeController:SetSelectedState(slot2 == slot1 and "normal" or "discount")
	end

	slot0.cost_ = slot1 * slot0.selectNum_
	slot0.totalCostText_.text = slot0.cost_
	slot0.addBtn_.interactable = slot0.selectNum_ < slot0:GetMaxBuyNum()
	slot0.delBtn_.interactable = slot0.selectNum_ > 1
end

function slot0.GetLimitNum(slot0)
	if slot0.shopCfg.limit_num and slot0.shopCfg.limit_num ~= -1 then
		return slot0.shopCfg.limit_num
	end

	return -1
end

function slot0.GetRestNum(slot0)
	if slot0:IsLimit() then
		return slot0:GetLimitNum() - slot0.goodInfo.buyTime
	end

	return -1
end

function slot0.IsLimit(slot0)
	if slot0.shopCfg.limit_num and slot0.shopCfg.limit_num ~= -1 then
		return true
	end

	return false
end

function slot0.GetMaxBuyNum(slot0)
	slot1 = slot0.shopCfg
	slot3 = ItemCfg[slot1.give_id]
	slot4 = -1

	if slot1.limit_num and slot1.limit_num ~= -1 then
		return math.min(slot1.limit_num - slot0.goodInfo.buyTime, math.max(math.floor(ItemTools.getItemNum(slot0.shopCfg.cost_id) / ShopTools.GetPrice(slot0.goodInfo.id)), 1))
	end

	slot5 = 99999

	if slot3.type == ItemConst.ITEM_TYPE.HERO_PIECE and slot1.shop_id == ShopConst.SHOP_ID.REPORT_SHOP then
		slot4 = math.max(HeroData:GetHeroOmegaNeedPiece(slot3.id - 10000), 1)
	end

	if slot4 < math.max(math.floor(ItemTools.getItemNum(slot0.shopCfg.cost_id) / slot2), 1) and slot4 ~= -1 then
		return slot4
	else
		return slot7 < 1 and 1 or slot7
	end
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnTop(slot0)
	slot0:RefreshUI()
	slot0:UpdateBarByGoodId()
	manager.windowBar:SetAsLastSibling()
end

function slot0.OnEnter(slot0)
	slot0.goodInfo = slot0.params_.goodInfo
	slot0.shopId = slot0.goodInfo.shopId
	slot0.goodID = slot0.goodInfo.id
	slot0.shopCfg = getShopCfg(slot0.goodInfo.id)
	slot0.useNumSlider_.value = 1
	slot0.selectNum_ = 1
end

function slot0.UpdateBarByGoodId(slot0)
	slot1 = {}

	if slot0.shopCfg.cost_id then
		table.insert(slot1, slot0.shopCfg.cost_id)
	end

	slot5 = slot1

	manager.windowBar:SwitchBar(slot5)

	for slot5 = 1, #slot1 do
		manager.windowBar:SetBarCanAdd(slot1[slot5], ShopConst.ADD_CURRENCY[slot1[slot5]] == true)
	end
end

function slot0.Dispose(slot0)
	slot0.useNumSlider_.onValueChanged:RemoveAllListeners()
	slot0.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	uv0.super.Dispose(slot0)
end

function slot0.OnExitInput(slot0)
	JumpTools.Back()

	return true
end

return slot0
