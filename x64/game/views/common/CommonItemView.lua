slot0 = class("CommonItemView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.info_ = {}
	slot0.oldInfo_ = {}

	slot0:InitUI(slot2)
end

function slot0.InitUI(slot0, slot1)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.emptyController_ = slot0.controllerExCollection_:GetController("empty")
	slot0.typeController_ = slot0.controllerExCollection_:GetController("type")
	slot0.rareController_ = slot0.controllerExCollection_:GetController("quality")
	slot0.starController_ = slot0.controllerExCollection_:GetController("star")
	slot0.grayController_ = slot0.controllerExCollection_:GetController("gray")
	slot0.bottomAmountController_ = slot0.controllerExCollection_:GetController("textcom")
	slot0.raceController_ = slot0.controllerExCollection_:GetController("camp")
	slot0.lockController_ = slot0.controllerExCollection_:GetController("notunlock")
	slot0.lockEquipController_ = slot0.controllerExCollection_:GetController("lock")
	slot0.leftHeroController_ = slot0.controllerExCollection_:GetController("heroHead")
	slot0.selectController_ = slot0.controllerExCollection_:GetController("select")
	slot0.selectController2_ = slot0.controllerExCollection_:GetController("select2")
	slot0.highLightController_ = slot0.controllerExCollection_:GetController("award")
	slot0.completedController_ = slot0.controllerExCollection_:GetController("completed")
	slot0.rightHeroController_ = slot0.controllerExCollection_:GetController("using")
	slot0.countdownController_ = slot0.controllerExCollection_:GetController("time")
	slot0.favouriteController_ = slot0.controllerExCollection_:GetController("like")
	slot0.topAmountController_ = slot0.controllerExCollection_:GetController("btnamount")
	slot0.infoBtnController_ = slot0.controllerExCollection_:GetController("btnlook")
	slot0.gradeController_ = slot0.controllerExCollection_:GetController("grade")
	slot0.surpassController_ = slot0.controllerExCollection_:GetController("surpass")
	slot0.bottomTextController_ = slot0.controllerExCollection_:GetController("deplete")
	slot0.ownedController_ = slot0.controllerExCollection_:GetController("owned")
	slot0.equipPosController_ = slot0.controllerExCollection_:GetController("bgequip")

	if not slot1 then
		slot0:ResetTransform()
	end

	slot0:AddDragEvent()
end

function slot1(slot0)
	if not slot0 then
		return nil
	end

	if slot0[1] ~= nil and slot0.id == nil then
		return cfgToItemTemplate(slot0)
	end

	if slot0.num ~= nil and slot0.number == nil then
		return rewardToItemTemplate(slot0)
	end

	return slot0
end

function slot0.SetData(slot0, slot1)
	slot0.oldInfo_ = slot0.info_
	slot0.info_ = clone(uv0(slot1))

	slot0:RefreshUI()
end

function slot0.GetData(slot0)
	return slot0.info_
end

function slot0.RefreshUI(slot0)
	slot0:RefreshEmptyState()

	if slot0.info_ == nil then
		return
	end

	if slot0.info_.id == nil then
		return
	end

	slot0:RefreshRace(slot0.info_.race or 0)
	slot0:RefreshLeftHeroHead(slot0.info_.bindHeroID or 0)
	slot0:RefreshEquipLock(slot0.info_.equipedLocked)
	slot0:RefreshFavourite(slot0.info_.favouriteFlag)
	slot0:RefreshLock(slot0.info_.locked)
	slot0:RefreshRightHeroHead(slot0.info_.equipedHeroID)
	slot0:RefreshInfoBtn(slot0.info_.infoBtnFlag)
	slot0:RefreshTopAmount(slot0.info_.topAmountValue)
	slot0:RefreshCountdown(slot0.info_)

	if not slot0.oldInfo_ or slot0.oldInfo_.id ~= slot0.info_.id then
		slot0:RefreshGrade()
		slot0:RefreshStar()
		slot0:RefreshType()
		slot0:RefreshEquipPos()
		slot0:RefreshIcon()
		slot0:RefreshRareBg()
	end

	slot0:RefreshHighLight(slot0.info_.highLight)
	slot0:RefreshSelectState(slot0.info_.selectStyle)
	slot0:RefreshSelectState2(slot0.info_.selectStyle2)
	slot0:RefreshCompleted(slot0.info_.completedFlag)
	slot0:RefreshOwned(slot0.info_.ownedFlag)
	slot0:RefreshGray(slot0.info_.grayFlag)
	slot0:RefreshBottomAmountText()
	slot0:RefreshBottomText(slot0.info_.bottomText)
	slot0:RefreshSurpass(slot0.info_.addLevel)
	slot0:RefreshBottomRightText(slot0.info_.hideBottomRightTextFlag)
	slot0:RefreshClickBtn()
	slot0:RefreshAnimator(slot0.info_.animatorType)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.clickBtn_, nil, function ()
		if uv0.info_.clickFun then
			uv0.info_.clickFun(uv0.info_)
		end
	end)
	slot0:AddPressingByTimeListener(slot0.longClickGo_, 3, 0.5, 0.2, function (slot0, slot1)
		if uv0.info_.longClickFun then
			return uv0.info_.longClickFun(uv0.info_, slot0, slot1)
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.topAmountGo_, 3, 0.5, 0.2, function (slot0, slot1)
		if uv0.info_.clickAmountFun then
			return uv0.info_.clickAmountFun(uv0.info_, slot0, slot1)
		end

		return false
	end)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function (slot0, slot1)
		if uv0.info_.clickInfoFun then
			return uv0.info_.clickInfoFun(uv0.info_, slot0, slot1)
		end
	end)
end

function slot0.ResetTransform(slot0)
	slot0.transform_.localPosition = Vector3.zero
	slot0.transform_.localScale = Vector3(1, 1, 1)
	slot0.transform_.localEulerAngles = Vector3.zero
end

function slot0.RefreshEmptyState(slot0)
	if slot0.info_ == nil then
		slot0.emptyController_:SetSelectedState("on")
	else
		slot0.emptyController_:SetSelectedState("off")
	end
end

function slot0.RefreshType(slot0)
	slot2 = "material"

	if ItemCfg[slot0.info_.id].type == ItemConst.ITEM_TYPE.CURRENCY or slot1 == ItemConst.ITEM_TYPE.MATERIAL or slot1 == ItemConst.ITEM_TYPE.PROPS or slot1 == ItemConst.ITEM_TYPE.GIFT or slot1 == ItemConst.ITEM_TYPE.ARCHIVE_GIFT or slot1 == ItemConst.ITEM_TYPE.DYNAMIC_STICKER or slot1 == ItemConst.ITEM_TYPE.DORM_FURNITURE or slot1 == ItemConst.ITEM_TYPE.CANTEEN_INGREDIENTS then
		slot2 = "material"
	elseif slot1 == ItemConst.ITEM_TYPE.HERO_PIECE then
		slot2 = "heroPiece"
	elseif slot1 == ItemConst.ITEM_TYPE.EQUIP then
		slot2 = "equip"
	elseif slot1 == ItemConst.ITEM_TYPE.HERO then
		slot2 = "hero"
	elseif slot1 == ItemConst.ITEM_TYPE.HERO_SKIN then
		slot2 = "heroSkin"
	elseif slot1 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		slot2 = "weaponServant"
	end

	slot0.typeController_:SetSelectedState(slot2)
end

function slot0.RefreshIcon(slot0)
	slot1 = false

	if ItemCfg[slot0.info_.id].type == ItemConst.ITEM_TYPE.EQUIP then
		slot1 = true
	end

	ItemTools.GetItemSpriteAsync(slot0.info_.id, function (slot0, slot1)
		if uv0.gameObject_ == nil then
			return
		end

		if uv0.info_ and slot0 == uv0.info_.id then
			uv0.iconImage_.sprite = slot1
		end
	end, nil, slot1)
end

function slot0.RefreshEquipPos(slot0)
	slot2 = "material"

	if ItemCfg[slot0.info_.id].type == ItemConst.ITEM_TYPE.EQUIP then
		slot0.equipPosController_:SetSelectedState(tostring(EquipCfg[slot0.info_.id].pos))
	else
		slot0.equipPosController_:SetSelectedState("off")
	end
end

function slot0.RefreshRareBg(slot0)
	slot0.rareController_:SetSelectedState(ItemCfg[slot0.info_.id].display_rare)
end

function slot0.RefreshStar(slot0)
	if ItemCfg[slot0.info_.id].type == ItemConst.ITEM_TYPE.EQUIP or slot1.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		slot0.starController_:SetSelectedState("0" .. tostring(slot1.display_rare))
	else
		slot0.starController_:SetSelectedState("off")
	end
end

function slot0.RefreshGrade(slot0)
	if ItemCfg[slot0.info_.id].type == ItemConst.ITEM_TYPE.HERO then
		slot0.gradeController_:SetSelectedState("on")

		slot0.gradeImage_.sprite = getSprite("Atlas/SystemHeroGradeAtlas", "com_grade_" .. HeroStarCfg[HeroCfg[slot0.info_.id].unlock_star].star)
	else
		slot0.gradeController_:SetSelectedState("off")
	end
end

function slot0.RefreshTopAmount(slot0, slot1)
	if slot1 and slot1 > 0 then
		slot0.topAmountController_:SetSelectedState("on")
	else
		slot0.topAmountController_:SetSelectedState("off")
		slot0:StopLongClickTimer()
	end

	slot0.topAmountText_.text = slot1
	slot0.info_.topAmountValue = slot1

	slot0:RefreshGrayInner()
end

function slot0.RefreshBottomAmountText(slot0)
	slot0:RefreshBottomRightText()

	if ItemCfg[slot0.info_.id].type == ItemConst.ITEM_TYPE.EQUIP then
		if slot0.info_.equipLevel then
			slot0:SetBottomAmountText(GetTips("LEVEL") .. slot0.info_.equipLevel)
		end
	elseif slot1 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		-- Nothing
	elseif slot0.info_.number ~= nil then
		slot0:SetBottomAmountText(slot0.info_.number)
	end
end

function slot0.SetBottomAmountText(slot0, slot1)
	slot0.info_.number = slot1

	if type(slot1) == "number" then
		slot1 = formatNumber(slot1)
	end

	slot0.bottomAmountText_.text = slot1

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.bottomAmountText_.transform)
end

function slot0.RefreshBottomRightText(slot0, slot1)
	slot0.bottomAmountController_:SetSelectedState((ItemCfg[slot0.info_.id].type == ItemConst.ITEM_TYPE.EQUIP and (slot0.info_.equipLevel and (slot1 or false) or true) or slot2 == ItemConst.ITEM_TYPE.WEAPON_SERVANT and true or slot1 or slot0.info_.number == nil) and "off" or "on")
end

function slot0.RefreshBottomText(slot0, slot1)
	if type(slot1) == "table" and #slot1 > 0 then
		if slot1[2] == nil or slot3 == 0 then
			slot0.bottomText_.text = slot1[1]
		elseif slot2 < slot3 then
			slot0.bottomText_.text = string.format("<color=#%s>%s</color>/%s", slot1[3] and slot1[3] or ColorConst.RED_HEX, formatNumber(slot2), formatNumber(slot3))
		else
			slot0.bottomText_.text = string.format("%s/%s", formatNumber(slot2), formatNumber(slot3))
		end
	elseif type(slot1) == "number" then
		slot0.bottomText_.text = formatNumber(slot1)
	elseif type(slot1) == "string" then
		slot0.bottomText_.text = slot1
	else
		slot0.bottomTextController_:SetSelectedState("off")

		return
	end

	slot0.bottomTextController_:SetSelectedState("on")
end

function slot0.RefreshSurpass(slot0, slot1)
	if slot1 and slot1 > 0 then
		slot0.surpassController_:SetSelectedState("on")

		slot0.surpassText_.text = slot1
	else
		slot0.surpassController_:SetSelectedState("off")
	end

	slot0.info_.addLevel = slot1
end

function slot0.RefreshRace(slot0, slot1)
	if ItemCfg[slot0.info_.id].type == ItemConst.ITEM_TYPE.HERO then
		slot1 = HeroCfg[slot0.info_.id].race
	elseif slot2 == ItemConst.ITEM_TYPE.HERO_PIECE then
		slot1 = HeroCfg[ItemCfg[slot0.info_.id].hero_id].race
	elseif slot2 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		slot1 = WeaponServantCfg[slot0.info_.id].race
	end

	if slot1 == 0 then
		slot0.raceController_:SetSelectedState("off")
	else
		slot0.raceController_:SetSelectedState("on")

		slot0.raceImage_.sprite = getSprite("Atlas/SystemGroupAtlas", RaceEffectCfg[slot1].icon2)
	end

	slot0.info_.race = slot1
end

function slot0.RefreshRightHeroHead(slot0, slot1)
	if slot1 and slot1 ~= 0 then
		slot0.rightHeroController_:SetSelectedState("true")

		slot0.rightHeroImage_.sprite = HeroTools.GetSmallHeadSprite(slot1)
	else
		slot0.rightHeroController_:SetSelectedState("false")
	end

	slot0.info_.equipedHeroID = slot1
end

function slot0.RefreshLeftHeroHead(slot0, slot1)
	if slot1 ~= 0 then
		slot0.leftHeroController_:SetSelectedState("on")

		slot0.leftHeroImage_.sprite = HeroTools.GetSmallHeadSprite(slot1)

		if slot0.info_.race ~= 0 and ItemCfg[slot0.info_.id].type == ItemConst.ITEM_TYPE.EQUIP then
			slot0.raceController_:SetSelectedState("off")
		end
	else
		slot0.leftHeroController_:SetSelectedState("off")
	end

	slot0.info_.bindHeroID = slot1
end

function slot0.RefreshLock(slot0, slot1)
	slot0.lockController_:SetSelectedState(slot1 and "on" or "off")

	slot0.info_.locked = slot1

	slot0:RefreshGrayInner()
end

function slot0.RefreshEquipLock(slot0, slot1)
	slot0.lockEquipController_:SetSelectedState(slot1 and "on" or "off")

	slot0.info_.equipedLocked = slot1
end

function slot0.RefreshCountdown(slot0, slot1)
	if ItemTools.GetItemExpiredTimeByInfo(slot1) and slot2 > 0 and slot1.need_count_down then
		slot0.countdownController_:SetSelectedState("on")

		slot0.timeText_.text = ItemTools.GetItemCountdownText(slot2)
	else
		slot0.countdownController_:SetSelectedState("false")
	end
end

function slot0.RefreshFavourite(slot0, slot1)
	slot0.favouriteController_:SetSelectedState(slot1 and "on" or "off")

	slot0.info_.favouriteFlag = slot1
end

function slot0.RefreshInfoBtn(slot0, slot1)
	slot0.infoBtnController_:SetSelectedState(slot1 and "on" or "off")

	slot0.info_.infoBtnFlag = slot1
end

function slot0.RefreshGray(slot0, slot1)
	slot0.grayController_:SetSelectedState(slot1 and "on" or "off")

	slot0.info_.grayFlag = slot1
end

function slot0.RefreshGrayInner(slot0)
	slot1 = nil

	if slot0.info_.locked or slot0.info_.completedFlag or slot0.info_.selectStyle or tonumber(slot0.info_.topAmountValue or 0) > 0 or slot0.info_.ownedFlag then
		slot1 = true
	end

	slot0.info_.grayFlag = slot1 or slot0.info_.grayFlag

	slot0.grayController_:SetSelectedState(slot1 and "on" or "off")
end

function slot0.RefreshHighLight(slot0, slot1)
	slot0.highLightController_:SetSelectedState(slot1 and "on" or "off")

	slot0.info_.highLight = highLight
end

function slot0.RefreshSelectState(slot0, slot1)
	if slot1 == true then
		slot0.selectController_:SetSelectedState("1")
	else
		slot0.selectController_:SetSelectedState("off")
	end

	slot0.info_.selectStyle = slot1

	slot0:RefreshGrayInner()
end

function slot0.RefreshSelectState2(slot0, slot1)
	if slot1 == true then
		slot0.selectController2_:SetSelectedState("true")
	else
		slot0.selectController2_:SetSelectedState("false")
	end

	slot0.info_.selectStyle2 = slot1
end

function slot0.RefreshCompleted(slot0, slot1)
	slot0.completedController_:SetSelectedState(slot1 and "on" or "off")

	slot0.info_.completedFlag = slot1

	slot0:RefreshGrayInner()
end

function slot0.RefreshOwned(slot0, slot1)
	slot0.ownedController_:SetSelectedState(slot1 and "on" or "off")

	slot0.info_.ownedFlag = slot1

	slot0:RefreshGrayInner()
end

function slot0.RefreshClickBtn(slot0)
	if slot0.info_.clickFun then
		SetActive(slot0.clickBtn_.gameObject, true)
	else
		SetActive(slot0.clickBtn_.gameObject, false)
	end

	if slot0.info_.longClickFun then
		SetActive(slot0.longClickGo_, true)
	else
		SetActive(slot0.longClickGo_, false)
	end
end

function slot0.RefreshAnimator(slot0, slot1)
	if slot0.oldAnimatorType_ == slot1 then
		return
	end

	if slot1 == ItemConst.ITEM_ANIMATOR_TYPE.NULL then
		slot0.animator_.enabled = false
	else
		slot0.animator_.enabled = true

		if slot1 == ItemConst.ITEM_ANIMATOR_TYPE.NORMAL then
			slot0.animator_.runtimeAnimatorController = Asset.Load("AnimatorController/CommonItem/CommonItem")

			if slot0.gameObject_.activeInHierarchy == true then
				slot0.animator_:Update(0)
			end
		elseif slot1 == ItemConst.ITEM_ANIMATOR_TYPE.ADVANCED then
			slot0.animator_.runtimeAnimatorController = Asset.Load("AnimatorController/CommonItem/CommonItem2")

			if slot0.gameObject_.activeInHierarchy == true then
				slot0.animator_:Update(0)
			end
		end
	end

	slot0.oldAnimatorType_ = slot1

	if slot0.info_ then
		slot0.info_.animatorType = slot1
	end
end

function slot0.AddDragEvent(slot0)
	slot0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.BeginDragFun)))
	slot0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.DragFun)))
	slot0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.EndDragFun)))
end

function slot0.RemoveDragEvent(slot0)
	slot0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	slot0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	slot0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
end

function slot0.BeginDragFun(slot0, slot1, slot2)
	if slot0.info_.beginDragFun then
		slot0.info_.beginDragFun(slot1, slot2)
	end
end

function slot0.DragFun(slot0, slot1, slot2)
	if slot0.info_.dragFun then
		slot0.info_.dragFun(slot1, slot2)
	end
end

function slot0.EndDragFun(slot0, slot1, slot2)
	if slot0.info_.endDragFun then
		slot0.info_.endDragFun(slot1, slot2)
	end
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	slot0:RemoveDragEvent()
	uv0.super.Dispose(slot0)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
