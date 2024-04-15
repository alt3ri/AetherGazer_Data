slot0 = class("EquipBagView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3, slot4)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.info_ = slot4

	slot0:Init()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.handler_ = slot1

	for slot6, slot7 in pairs(slot2) do
		slot0.info_[slot6] = slot7
	end

	slot0:Render()
end

function slot0.OnEquipFilterConfirm(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		slot0.info_[slot5] = slot6
	end

	slot0.info_.suit = slot0.info_.filterGroup[1]
	slot0.info_.skill = slot0.info_.filterGroup[2]

	slot0.filterController_:SetSelectedState((#slot0.info_.suit > 0 or #slot0.info_.skill > 0) and "orange" or "normal")
	slot0:Render()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:InitDropdownData()
end

function slot0.InitDropdownData(slot0)
	slot0.textDropdown_.text = GetTips("TIP_UPGRADE")
	slot0.textCulture_.text = GetTips("TIP_UPGRADE")
	slot0.textQuality_.text = GetTips("TIP_RARE")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, CommonItemView)
	slot0.orderController_ = ControllerUtil.GetController(slot0.sortBtn_.transform, "order")
	slot0.tabController_ = slot0.tab_:GetController("tab")
	slot0.sortController_ = slot0.dropDown_:GetController("sortby")
	slot0.filterController_ = slot0.filterCon_:GetController("color")
	slot0.emptyController_ = slot0.emptyCon_:GetController("empty")
end

function slot0.AddUIListener(slot0)
	slot0.posTab_ = {}

	for slot4 = 1, 6 do
		slot0.posTab_[slot4] = slot0[string.format("pos%s_", slot4)]

		slot0:AddBtnListener(slot0.posTab_[slot4], nil, function ()
			manager.audio:PlayEffect("ui_system_3_0", "ui_sight_listchange", "")

			uv0.info_.suitPos = uv1

			uv0.handler_:RefreshPos(uv1)
			uv0:Render()
		end)
	end

	slot0:AddBtnListener(slot0.sortBtn_, nil, function ()
		if uv0.info_.order == ItemConst.SORT_TYPE.DOWN then
			uv0.info_.order = ItemConst.SORT_TYPE.UP

			uv0.orderController_:SetSelectedState("up")
		else
			uv0.info_.order = ItemConst.SORT_TYPE.DOWN

			uv0.orderController_:SetSelectedState("down")
		end

		uv0:Render()
	end)
	slot0:AddBtnListener(slot0.btnFilter_, nil, function ()
		JumpTools.OpenPageByJump("equipFilterView", {
			info = uv0.info_
		})
	end)
	slot0:AddBtnListener(slot0.btnDropdown_, nil, function ()
		SetActive(uv0.dropDown_.gameObject, true)
	end)
	slot0:AddBtnListener(slot0.btnDropMask_, nil, function ()
		SetActive(uv0.dropDown_.gameObject, false)
	end)
	slot0:AddBtnListener(slot0.btnCulture_, nil, function ()
		if uv0.info_ == nil then
			return
		end

		uv0.info_.priority = EquipConst.EQUIP_SORT.LEVEL

		uv0.sortController_:SetSelectedState("culture")

		uv0.textDropdown_.text = GetTips("TIP_UPGRADE")

		SetActive(uv0.dropDown_.gameObject, false)
		uv0:Render()
	end)
	slot0:AddBtnListener(slot0.btnQuality_, nil, function ()
		if uv0.info_ == nil then
			return
		end

		uv0.info_.priority = EquipConst.EQUIP_SORT.RARE

		uv0.sortController_:SetSelectedState("quality")

		uv0.textDropdown_.text = GetTips("TIP_RARE")

		SetActive(uv0.dropDown_.gameObject, false)
		uv0:Render()
	end)
end

function slot0.OnEnter(slot0, slot1)
	slot0.suitShow_ = false
	slot0.info_ = slot0.info_ or {}
	slot0.info_.heroId = slot1.heroId
	slot0.info_.suitPos = slot1.suitPos or 1
	slot0.info_.order = slot0.info_.order or ItemConst.SORT_TYPE.DOWN
	slot0.info_.priority = slot0.info_.priority or EquipConst.EQUIP_SORT.LEVEL
	slot0.lastScrollPos_ = slot0.lastScrollPos_

	slot0:Render()

	slot0.equipNum_.text = string.format("%s/%s", #slot0.equipList_, GameSetting.max_equip.value[1])

	slot0:RegistEventListener(EQUIP_FILTER_CONFIRM, handler(slot0, slot0.OnEquipFilterConfirm))
end

function slot0.Render(slot0, slot1)
	slot0:RefreshEquipList()
	slot0:RefreshState()
end

function slot0.RefreshEquipList(slot0)
	if slot0.listGo_.activeSelf == false then
		return
	end

	slot0.equipList_ = slot0:GetEquipList()

	slot0.emptyController_:SetSelectedState(tostring(#slot0.equipList_ == 0))
	slot0.scrollHelper_:StartScrollByPosition(slot1, slot0.lastScrollPos_ or slot0.scrollHelper_:GetScrolledPosition())
end

function slot0.GetEquipList(slot0)
	slot6 = slot0.info_.suit
	slot7 = slot0.info_.skill
	slot2 = {}

	for slot6, slot7 in ipairs(EquipData:GetEquipListComplex(slot0.info_.order, slot0.info_.priority, slot0.info_.suitPos, slot6, slot7)) do
		if slot7.race == 0 or table.keyof(RaceEffectCfg.all, slot9) ~= nil then
			-- Nothing
		else
			slot8.race = HeroCfg[slot9].race or 0
			slot8.bindHeroID = slot10
		end

		table.insert(slot2, {
			number = 1,
			type = ItemCfg[slot7.prefab_id].type,
			id = slot7.prefab_id,
			equip_info = slot7,
			equip_star = getItemStar(slot7.prefab_id),
			equipedHeroID = slot7:GetEquipHero(),
			equip_id = slot7.equip_id,
			equipLevel = EquipTools.CountEquipLevel(slot7),
			equipEnchantCount = #slot7.enchant_preview,
			equipedLocked = slot7.is_lock,
			race = slot9 or 0,
			bindHeroID = 0
		})
	end

	return slot2
end

function slot0.indexItem(slot0, slot1, slot2)
	slot0.equipList_[slot1].clickFun = function (slot0)
		if uv0.selectItem_ then
			uv0.selectItem_:RefreshSelectState2(false)
		end

		uv1:RefreshSelectState2(true)

		uv0.selectItem_ = uv1
		uv0.selectId_ = slot0.equip_id
		uv0.lastScrollPos_ = uv0.scrollHelper_:GetScrolledPosition()

		uv0.BagItemClickFunc(slot0, uv1)
	end

	if slot0.selectId_ and slot3.equip_id == slot0.selectId_ then
		slot3.selectStyle2 = true
		slot0.selectItem_ = slot2

		slot0.BagItemClickFunc(slot3, slot2)
	end

	CommonTools.SetCommonData(slot2, slot3)
end

function slot0.RegisterItemClick(slot0, slot1)
	slot0.BagItemClickFunc = slot1
end

function slot0.RefreshState(slot0)
	slot0.tabController_:SetSelectedState(slot0.info_.suitPos)
end

function slot0.RefreshEquipLock(slot0, slot1, slot2)
	if slot0.scrollHelper_ then
		for slot6, slot7 in pairs(slot0.scrollHelper_:GetItemList()) do
			if slot7:GetData().equip_id == slot2 then
				slot7:RefreshEquipLock(slot1)
			end
		end
	end
end

function slot0.RefreshEquipS(slot0)
	slot2 = HeroData:GetEquipMap()

	for slot6, slot7 in pairs(slot0.scrollHelper_:GetItemList()) do
		slot8 = slot7:GetData()

		if slot8.equipedHeroID ~= slot2[slot8.equip_id] then
			slot8.equipedHeroID = slot2[slot8.equip_id]
			slot0.equipList_[slot6].equipedHeroID = slot2[slot8.equip_id]

			CommonTools.SetCommonData(slot7, slot8)
		end
	end
end

function slot0.ClearSelect(slot0)
	slot0.selectItem_ = nil
	slot0.selectId_ = nil
	slot0.lastScrollPos_ = nil
end

function slot0.GetSelectType(slot0)
	return slot0.selectType_
end

function slot0.OnExit(slot0)
	slot0.info_ = {}

	slot0.filterController_:SetSelectedState("normal")
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
