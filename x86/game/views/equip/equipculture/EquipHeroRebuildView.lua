slot0 = class("EquipHeroRebuildView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_equip/Develop/HeroEquipHeroReset"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.heroIdList_ = {}
	slot0.heroList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListGo_, HeroLongHead)

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.currentController_ = slot0.currentCon_:GetController("state")
	slot0.targetController_ = slot0.targetCon_:GetController("state")
end

function slot0.InitUI(slot0)
	slot0.material_ = EquipData:GetRaceMaterial(2)

	if slot0.material_ then
		slot0.itemView_ = CommonItemView.New(slot0.commonItem_, true)
		slot1 = clone(ItemTemplateData)
		slot1.id = slot0.material_.id
		slot1.number = nil
		slot1.bottomText = {
			ItemTools.getItemNum(slot0.material_.id),
			slot0.material_.number
		}

		function slot1.clickFun(slot0)
			ShowPopItem(POP_SOURCE_ITEM, {
				slot0.id,
				slot0.number
			})
		end

		slot0.itemView_:SetData(slot1)
	end

	slot0.cost_ = slot0.material_ and slot0.material_.money or 0
	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.heroIdList_[slot1]
	slot2.gameObject_.name = tostring(slot3)

	slot2:SetProxy(slot0.params_.proxy)
	slot2:SetHeroId(slot3, HeroConst.HERO_DATA_TYPE.DEFAULT)
	slot2:SetSelected(slot3 == slot0.curHeroID_)
	slot2:RegisterClickListener(function ()
		uv0:SelectHero(uv1.heroId_)
	end)
end

function slot0.SelectHero(slot0, slot1)
	for slot5, slot6 in pairs(slot0.heroList_:GetItemList()) do
		slot6:SetSelected(slot6.heroId_ == slot1)
	end

	slot0.curHeroID_ = slot1

	slot0:RefreshUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.rebuildBtn_, nil, function ()
		slot2 = ItemTools.getItemNum(uv0.material_.id)

		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < uv0.cost_ then
			slot3 = false

			for slot8, slot9 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND] or {}) do
				if ItemTools.getItemNum(slot9) > 0 then
					slot3 = true

					break
				end
			end

			if CurrencyData:GetGoldBuyTimes() < GameSetting.coin_max_buy_time.value[1] or slot3 then
				JumpTools.OpenPopUp("currencyBuyGold", nil, ViewConst.SYSTEM_ID.BUY_GOLD)

				return
			else
				ShowTips(GetTips("ERROR_ITEM_NOT_ENOUGH_GOLD"))
			end
		elseif uv0.material_ and slot2 < uv0.material_.number then
			ShowPopItem(POP_SOURCE_ITEM, {
				uv0.material_.id,
				uv0.material_.number
			})
		else
			if _G.SkipTip.EquipHeroRebuildSkip or SettingData:GetRemindSettingData().rebuild_hero_equip_reminder ~= 1 then
				EquipAction.QueryEquipRace(uv0.equipID_, 2, uv0.curHeroID_)

				return
			end

			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("EQUIP_HERO_REBUILD_WARNING"), HeroTools.GetHeroFullName(uv0.curHeroID_)),
				OkCallback = function ()
					EquipAction.QueryEquipRace(uv0.equipID_, 2, uv0.curHeroID_)
				end,
				ToggleCallback = function (slot0)
					_G.SkipTip.EquipHeroRebuildSkip = slot0
				end
			})
		end
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.curHeroID_ = nil
	slot0.equipID_ = slot0.params_.equipId

	if not EquipData:GetEquipData(slot0.equipID_) then
		return
	end

	slot0.race_ = slot1.race

	if EquipTools.GetEquipedHeroId(slot0.equipID_) ~= 0 and HeroCfg[slot2].race == slot0.race_ then
		slot0.curHeroID_ = slot2
	end

	slot0:RefreshHeroList()
	slot0:RefreshMoney()
	slot0:RefreshMaterial()
	slot0:RefreshUI()
	slot0:RegistEventListener(CURRENCY_UPDATE, handler(slot0, slot0.OnGoldChange))
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
end

function slot0.RefreshHeroList(slot0)
	slot2 = {}
	slot3 = nil

	for slot7, slot8 in pairs(HeroData:GetHeroList()) do
		if HeroCfg[slot8.id].race == slot0.race_ and slot8.unlock ~= 0 then
			slot2[#slot2 + 1] = slot8.id
		end
	end

	slot0.heroIdList_ = slot2

	slot0.heroList_:StartScroll(#slot0.heroIdList_)
end

function slot0.RefreshMoney(slot0)
	slot1 = slot0.cost_

	if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < slot1 then
		slot3 = "<color='#FF0000'>" .. tostring(slot1) .. "</color>"
	end

	slot0.costNum_.text = slot3
	slot0.material_ = EquipData:GetRaceMaterial(2)

	slot0.itemView_:RefreshBottomText({
		ItemTools.getItemNum(slot0.material_.id),
		slot0.material_.number
	})
end

function slot0.RefreshMaterial(slot0)
end

function slot0.RefreshUI(slot0)
	slot1 = nil

	if slot0.curHeroID_ ~= nil then
		slot0.targetController_:SetSelectedIndex(1)

		slot1 = HeroCfg[slot0.curHeroID_]
		slot2 = string.format("%s·%s", GetI18NText(slot1.name), GetI18NText(slot1.suffix))

		if SettingData:GetCurrentLanguage() == "fr" or slot3 == "de" then
			slot2 = string.format("%s-%s", GetI18NText(slot1.name), GetI18NText(slot1.suffix))
		end

		slot0.targetText_.text = string.format(GetTips("EQUIP_HERO_ATTRIBUTE_UP"), GetI18NText(slot2))
		slot0.targetHeroIcon_.sprite = HeroTools.GetSmallHeadSprite(slot0.curHeroID_)
	else
		slot0.targetController_:SetSelectedIndex(0)
	end

	if RaceEffectCfg[slot0.race_] then
		slot0.currentController_:SetSelectedIndex(1)

		slot0.currentText_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(slot1.name))
		slot0.currenGroupIcon_.sprite = getSprite("Atlas/SystemGroupAtlas", slot1.icon2)
	end

	slot2 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)
	slot0.rebuildBtn_.interactable = slot0.curHeroID_ ~= nil
end

function slot0.Dispose(slot0)
	if slot0.itemView_ then
		slot0.itemView_:Dispose()

		slot0.itemView_ = nil
	end

	if slot0.filterView_ then
		slot0.filterView_:Dispose()

		slot0.filterView_ = nil
	end

	slot0.heroList_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnGoldChange(slot0, slot1)
	if slot1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		slot0:RefreshMoney()
	end
end

function slot0.OnEquipRace(slot0)
	slot0:Back()
end

return slot0
