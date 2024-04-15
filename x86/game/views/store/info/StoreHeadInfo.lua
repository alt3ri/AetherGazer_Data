slot0 = class("StoreHeadInfo", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.typeController_ = slot0.controllerEx_:GetController("type")
	slot0.rareController_ = slot0.controllerEx_:GetController("quality")
	slot0.lockController_ = slot0.controllerEx_:GetController("lock")
	slot0.slotController_ = slot0.controllerEx_:GetController("slot")
	slot0.starController_ = slot0.controllerEx_:GetController("star")
	slot0.timeController_ = slot0.controllerEx_:GetController("time")
	slot0.RefreshEquipLockHandler_ = handler(slot0, slot0.RefreshEquipLock)
end

function slot0.OnEnter(slot0)
	manager.notify:RegistListener(EQUIP_LOCK, slot0.RefreshEquipLockHandler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(EQUIP_LOCK, slot0.RefreshEquipLockHandler_)
end

function slot0.Dispose(slot0)
	slot0.RefreshEquipLockHandler_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.lockBtn_, nil, function ()
		EquipAction.ApplyLockEquip(uv0.itemData_.equip_id, not uv0.itemData_.equipedLocked)
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.itemData_ = slot1

	if ItemCfg[slot1.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		slot0.typeController_:SetSelectedState("servant")

		slot0.servantImage_.sprite = ItemTools.getItemSprite(slot2)
		slot0.servantLevelText_.text = slot1.addLevel

		slot0.lockController_:SetSelectedState(tostring(slot1.locked))
		slot0.slotController_:SetSelectedState("0")
	elseif slot4 == ItemConst.ITEM_TYPE.EQUIP then
		slot0.typeController_:SetSelectedState("equip")

		slot0.equipImage_.sprite = ItemTools.getItemLittleSprite(slot2)
		slot0.equipLevelText_.text = string.format("%s%s/%s", GetTips("LEVEL"), slot1.equipLevel, EquipData:GetEquipData(slot1.equip_id):GetMaxLv())

		slot0.lockController_:SetSelectedState(tostring(slot1.equipedLocked))
		slot0.slotController_:SetSelectedState(tostring(slot1.equipEnchantCount))

		slot0.equipPosTf_.localEulerAngles = Vector3.New(0, 0, 60 * EquipCfg[slot1.id].pos)
	elseif slot4 == ItemConst.ITEM_TYPE.HERO_PIECE then
		slot0.typeController_:SetSelectedState("heropiece")

		slot0.itemImage_.sprite = ItemTools.getItemSprite(slot2)
		slot0.raceImage_.sprite = getSprite("Atlas/SystemGroupAtlas", RaceEffectCfg[HeroCfg[ItemCfg[slot2].hero_id].race].icon2)
		slot0.cntText_.text = slot1.number

		slot0.lockController_:SetSelectedState("hide")
		slot0.slotController_:SetSelectedState("0")
	else
		slot0.typeController_:SetSelectedState("material")

		slot0.itemImage_.sprite = ItemTools.getItemSprite(slot2)
		slot0.cntText_.text = slot1.number

		slot0.lockController_:SetSelectedState("hide")
		slot0.slotController_:SetSelectedState("0")
	end

	slot0.nameText_.text = ItemTools.getItemName(slot2)

	if ItemTools.GetItemExpiredTimeByInfo(slot1) == nil or slot5 == 0 then
		slot0.timeController_:SetSelectedState("false")
	else
		slot0.timeController_:SetSelectedState("true")

		slot0.timeText_.text = string.format(GetTips("TIME_DISPLAY_12"), TimeMgr.GetInstance():STimeDescS(slot5, "!%Y/%m/%d %H:%M"))
	end

	slot0.rareController_:SetSelectedState(tostring(slot3.rare))
	slot0.starController_:SetSelectedState(tostring(slot3.rare))
end

function slot0.RefreshEquipLock(slot0, slot1)
	if slot0.itemData_ and slot1.equipID == slot0.itemData_.equip_id and slot0.itemData_.equip_id ~= 0 then
		slot0.itemData_.equipedLocked = slot1.lock

		slot0.lockController_:SetSelectedState(tostring(slot0.itemData_.equipedLocked))
	end
end

return slot0
