slot0 = class("NewHeroChipView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_chip/HeroChipEditUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.chipClickCallBack_ = handler(slot0, slot0.OnChipClick)
	slot0.chipListList_ = {}
	slot0.chipControllers_ = {}

	for slot4 = 1, 4 do
		slot0.chipListList_[slot4] = NewHeroChipListItem.New(slot0["chiplistGo_" .. slot4], slot0.chipItemGo_)

		slot0.chipListList_[slot4]:SetChipClickCallBack(slot0.chipClickCallBack_)

		slot0.chipControllers_[slot4] = slot0["chipCon_" .. slot4]:GetController("state")
	end

	slot0.chipTypeController_ = slot0.typeTrans_:GetComponent("ControllerExCollection"):GetController("type")
	slot0.conditionController_ = slot0.conditionTrans_:GetComponent("ControllerExCollection"):GetController("clear")
	slot0.enoughController_ = slot0.gameObject_.transform:GetComponent("ControllerExCollection"):GetController("enough")
	slot0.btnController_ = slot0.btnTrans_:GetComponent("ControllerExCollection"):GetController("btnState")

	slot0:AddListeners()
end

function slot0.OnChipClick(slot0, slot1)
	slot0.curChipID_ = slot1

	slot0:RefreshUI(false)
end

function slot0.OnTop(slot0)
	slot0:RefreshChipInfo()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_CHIP_COST
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_CHIP_COST, true)
end

function slot0.OnChipStatusUpdate(slot0)
	slot0:RefreshUI(false)
end

function slot0.OnEnter(slot0)
	slot0.heroID_ = slot0.params_.heroID
	slot0.curHeroChipInfo_ = {}

	for slot4, slot5 in pairs(ChipCfg.get_id_list_by_spec_char[slot0.heroID_]) do
		if slot0.curHeroChipInfo_[ChipCfg[slot5].role_type_id] then
			table.insert(slot0.curHeroChipInfo_[slot6], slot5)
		else
			slot0.curHeroChipInfo_[slot6] = {
				slot5
			}
		end
	end

	slot0.curType_ = slot0.params_.type

	if slot0.params_.chipID > 0 then
		slot0.curChipID_ = slot0.params_.chipID
	else
		slot0.curChipID_ = slot0.curHeroChipInfo_[slot0.curType_][1]
	end

	slot0:RefreshUI(true)
end

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		6,
		1
	}, false)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.btnController_.selectedIndex == 0 or uv0.btnController_.selectedIndex == 3 then
			ChipAction.EnabledHeroChip(uv0.heroID_, uv0.curChipID_, ChipCfg[uv0.curChipID_].role_type_id)
		elseif uv0.btnController_.selectedIndex == 1 then
			ChipAction.EnabledHeroChip(uv0.heroID_, 0, slot0)
		elseif uv0.btnController_.selectedIndex == 2 then
			ChipAction.UnlockHeroChip(uv0.curChipID_)
		end
	end)
end

function slot0.RefreshUI(slot0, slot1)
	slot2 = ChipData:GetEnableHeroChipIdByHeroId(slot0.heroID_)

	if slot1 then
		for slot6, slot7 in pairs(slot0.curHeroChipInfo_) do
			slot0.curHeroChipInfo_[slot6] = ChipTools.SortChipList(slot2[slot6], slot0.curHeroChipInfo_[slot6], nil, true)
		end
	end

	for slot6 = 1, 4 do
		if slot0.curHeroChipInfo_[slot6] then
			slot0.chipListList_[slot6]:SetIsShow(true)
			slot0.chipListList_[slot6]:SetData(slot0.heroID_, slot0.curHeroChipInfo_[slot6], slot0.curChipID_)
			slot0.chipControllers_[slot6]:SetSelectedState(slot2[slot6] > 0 and "equip" or "normal")
		else
			slot0.chipListList_[slot6]:SetIsShow(false)
			slot0.chipControllers_[slot6]:SetSelectedState("lock")
		end
	end

	slot0:RefreshChipInfo()
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.chipContent_)
end

function slot0.RefreshChipInfo(slot0)
	slot1 = ChipCfg[slot0.curChipID_]
	slot0.nameText_.text = slot1.suit_name
	slot0.iconImage_.sprite = getSpriteViaConfig("ChipSkillIcon", slot1.picture_id)

	slot0.chipTypeController_:SetSelectedState(slot1.role_type_id)

	slot0.desText_.text = slot1.desc
	slot0.typeText_.text = GetTips("CHIP_HERO_TYPE_" .. slot1.role_type_id)
	slot0.grayText_.text = slot1.title

	if ChipData:GetIsUnlockHeroChip(slot0.curChipID_) then
		SetActive(slot0.conditionTrans_.gameObject, false)
		SetActive(slot0.costImage_.gameObject, false)

		slot2, slot3 = ChipData:GetHeroChipIsEnableByChipId(slot0.curChipID_)

		if slot2 then
			slot0.btnText_.text = GetTips("CHIP_UNLOAD")

			slot0.btnController_:SetSelectedState("unequip")
		elseif slot3 > 0 then
			slot0.btnText_.text = GetTips("TIP_CHANGE")

			slot0.btnController_:SetSelectedState("exchange")
		else
			slot0.btnText_.text = GetTips("TIP_EQUIP")

			slot0.btnController_:SetSelectedState("equip")
		end
	else
		if slot1.new_condition ~= 0 then
			SetActive(slot0.conditionTrans_.gameObject, true)
			SetActive(slot0.costImage_.gameObject, false)

			slot0.conditionText_.text = ConditionCfg[slot1.new_condition].desc
			slot2, slot3, slot4 = nil

			if slot1.spec_char > 0 then
				slot2, slot3, slot4 = IsConditionAchieved(slot1.new_condition, {
					heroId = slot1.spec_char
				})
			else
				slot2, slot3, slot4 = IsConditionAchieved(slot1.new_condition)
			end

			for slot8, slot9 in ipairs(GameSetting.hero_trust_unlock_condition.value) do
				if slot1.new_condition == slot9 then
					slot3 = slot2 and 1 or 0
					slot4 = 1
					slot0.conditionText_.text = HeroCfg[slot1.spec_char].name .. "·" .. HeroCfg[slot1.spec_char].suffix .. ConditionCfg[slot1.new_condition].desc

					break
				end
			end

			if slot2 then
				slot0.conditionController_:SetSelectedState("clear")
			else
				slot0.conditionController_:SetSelectedState("notclear")

				slot3 = string.format("<color=#eb0000>%s</color>", slot3)
			end

			slot0.conditionNumText_.text = slot3 .. "/" .. slot4
		else
			SetActive(slot0.conditionTrans_.gameObject, false)
			SetActive(slot0.costImage_.gameObject, true)

			slot0.costText_.text = slot1.cost_condition[1][2]
			slot0.costImage_.sprite = ItemTools.getItemSprite(slot1.cost_condition[1][1])

			if slot1.cost_condition[1][2] <= ItemTools.getItemNum(slot1.cost_condition[1][1]) then
				slot0.enoughController_:SetSelectedState("true")
			else
				slot0.enoughController_:SetSelectedState("false")
			end
		end

		slot0.btnText_.text = GetTips("TIP_UNLOCK")

		slot0.btnController_:SetSelectedState("unlock")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4 = 1, 4 do
		slot0.chipListList_[slot4]:Dispose()

		slot0.chipListList_[slot4] = nil
	end

	slot0.chipListList_ = nil
	slot0.chipClickCallBack_ = nil
end

return slot0
