slot0 = class("EquipResetView", EquipBaseView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.params_ = slot3

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.toggles_ = {
		slot0.raceRebuildToggle_,
		slot0.heroRebuildToggle_
	}

	slot0:InitUI()
	slot0:AddUIListener()
	uv0.super.Init(slot0)
end

function slot0.InitUI(slot0)
	slot0.materialList_ = {}
	slot0.itemList_ = {}

	for slot4 = 1, 2 do
		slot5 = EquipData:GetRaceMaterial(slot4)
		slot0.materialList_[slot4] = slot5

		if slot5 then
			slot6 = CommonItemView.New(slot0["commonItem_" .. slot4])
			slot7 = clone(ItemTemplateData)
			slot7.id = slot5.id

			function slot7.clickFun(slot0)
				ShowPopItem(POP_SOURCE_ITEM, {
					slot0.id,
					slot0.number
				})
			end

			slot6:SetData(slot7)

			slot0.itemList_[slot4] = slot6
		end
	end

	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
	slot0.selectController = slot0.selectCon_:GetController("select")
	slot0.raceController_ = slot0.transCon_:GetController("race")
	slot0.costContrller_ = slot0.transCon_:GetController("cost")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnRace_, nil, function ()
		uv0:OnRaceClick()
	end)
	slot0:AddBtnListener(slot0.clickBtn_1, nil, function ()
		if uv0.heroID_ ~= 0 then
			ShowTips("EQUIP_HERO_HAD_REBUILT")

			return
		end

		EquipData:SetRaceIndex(1)
		uv0.selectController:SetSelectedState("race")

		uv0.selectType_ = 1

		uv0:RefreshMoney()
	end)
	slot0:AddBtnListener(slot0.clickBtn_2, nil, function ()
		if uv0.heroID_ ~= 0 then
			ShowTips("EQUIP_HERO_HAD_REBUILT")

			return
		end

		if uv0.race_ == 0 then
			ShowTips("EQUIP_RACE_REBUILD_FIRST")

			return
		end

		EquipData:SetRaceIndex(2)
		uv0.selectController:SetSelectedState("hero")

		uv0.selectType_ = 2

		uv0:RefreshMoney()
	end)
end

function slot0.OnTop(slot0)
	slot0:ChangeBar()
end

function slot0.ChangeBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
end

function slot0.OnEnter(slot0)
	slot0.equipHeroId = slot0.params_.heroId

	slot0:OnEquipChange(slot0.params_.equipId)
	slot0:RegistEventListener(CURRENCY_UPDATE, handler(slot0, slot0.OnGoldChange))
end

function slot0.OnEquipChange(slot0, slot1)
	slot0.equipId = slot1

	slot0:RefreshUI()
	slot0:RefreshSelectType()
	slot0:RefreshMoney()
	slot0:RefreshMaterial()
	slot0:ChangeBar()
end

function slot0.RefreshUI(slot0)
	if not EquipData:GetEquipData(slot0.equipId) then
		return
	end

	slot0.race_ = 0
	slot0.heroID_ = 0
	slot2 = RaceEffectCfg.all

	if slot1.race == 0 then
		slot0.costContrller_:SetSelectedState("on")
	elseif table.keyof(slot2, slot1.race) ~= nil then
		slot0.race_ = slot1.race

		slot0.costContrller_:SetSelectedState("on")
	else
		slot0.heroID_ = slot1.race

		slot0.costContrller_:SetSelectedState("off")
	end

	slot3 = nil

	if slot0.heroID_ ~= 0 then
		if HeroCfg[slot0.heroID_] then
			slot0.raceController_:SetSelectedIndex(2)

			slot4 = string.format("%s·%s", GetI18NText(slot3.name), GetI18NText(slot3.suffix))

			if SettingData:GetCurrentLanguage() == "fr" or slot5 == "de" then
				slot4 = string.format("%s-%s", GetI18NText(slot3.name), GetI18NText(slot3.suffix))
			end

			slot0.heroText_.text = string.format(GetTips("EQUIP_HERO_ATTRIBUTE_UP"), GetI18NText(slot4))
			slot0.imgHeroIcon_.sprite = HeroTools.GetSmallHeadSprite(slot0.heroID_)
		end
	elseif slot0.race_ ~= 0 then
		if RaceEffectCfg[slot0.race_] then
			slot0.raceController_:SetSelectedIndex(1)

			slot0.groupText_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(slot3.name))
			slot0.imgGroup_.sprite = getSprite("Atlas/SystemGroupAtlas", slot3.icon2)
		end
	else
		slot0.raceController_:SetSelectedIndex(0)
	end

	slot0.btnRace_.interactable = slot0.heroID_ == 0
end

function slot0.RefreshSelectType(slot0)
	if slot0.heroID_ ~= 0 then
		if slot0.selectType_ and slot0.selectType_ ~= 0 then
			slot0.selectController:SetSelectedState("noselect")
		end

		slot0.selectType_ = 1
	elseif slot0.race_ ~= 0 then
		slot1 = EquipData:GetRaceIndex()

		slot0.selectController:SetSelectedIndex(slot1 - 1)

		slot0.selectType_ = slot1
	else
		slot0.selectController:SetSelectedState("race")

		slot0.selectType_ = 1

		EquipData:SetRaceIndex(1)
	end
end

function slot0.RefreshMoney(slot0)
	if slot0.selectType_ ~= nil and slot0.selectType_ ~= 0 then
		slot1 = slot0.materialList_[slot0.selectType_].money

		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < slot1 then
			slot3 = "<color='#FF0000'>" .. tostring(slot1) .. "</color>"
		end

		slot0.costNum_.text = slot3
	end
end

function slot0.RefreshMaterial(slot0)
	for slot4, slot5 in ipairs(slot0.materialList_) do
		slot6 = ItemTools.getItemNum(slot5.id)

		if slot6 < slot5.number then
			slot7 = "<color='#FF0000'>" .. tostring(slot6) .. "</color>"
		end

		slot0.itemList_[slot4]:SetBottomAmountText(slot7 .. "/" .. slot5.number)
	end
end

function slot0.OnRaceClick(slot0)
	if slot0.selectType_ == 1 then
		EquipAction.QueryEquipRace(slot0.equipId, slot0.selectType_, slot0.equipHeroId)
	else
		slot0:Go("/equipHeroRebuild", {
			equipId = slot0.equipId,
			proxy = slot0.params_.proxy
		})
	end
end

function slot0.OnEquipRaceConfirm(slot0)
	slot0:RefreshUI()
	slot0:RefreshMoney()
	slot0:RefreshMaterial()
end

function slot0.OnExit(slot0)
	slot0.selectController:SetSelectedState("noselect")
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	if slot0.itemList_ then
		for slot4, slot5 in ipairs(slot0.itemList_) do
			slot5:Dispose()
		end

		slot0.itemList_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.OnGoldChange(slot0, slot1)
	if slot1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		slot0:RefreshMoney()
	end
end

return slot0
