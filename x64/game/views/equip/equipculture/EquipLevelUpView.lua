slot0 = class("EquipLevelUpView", EquipBaseView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.params_ = slot3

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	uv0.super.Init(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot4 = slot0.listGo_
	slot0.scrollHelper = LuaList.New(handler(slot0, slot0.indexItem), slot4, CommonItemView)
	slot0.attrs = {}

	for slot4 = 1, 2 do
		slot5 = {}

		ComponentBinder.GetInstance():BindCfgUI(slot5, slot0["property_" .. slot4])
		table.insert(slot0.attrs, slot5)
	end

	slot0.maxAttrs = {}

	for slot4 = 1, 2 do
		slot5 = {}

		ComponentBinder.GetInstance():BindCfgUI(slot5, slot0["maxAttr_" .. slot4])
		table.insert(slot0.maxAttrs, slot5)
	end

	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
	slot0.maxLvController_ = slot0.transCon_:GetController("levelMax")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnAutoSelect_, nil, function ()
		if uv0.equipMaxLv_ <= uv0.nextLv_ then
			return
		end

		slot0 = EquipCfg[uv0.equip_.prefab_id]
		slot3 = {}

		table.insert(slot3, uv0.equipId_)

		uv0.usedMaterialList_, uv0.usedEquipList_ = EquipTools.QuickSelectList(EquipTools.CountNeedExp(uv0.equip_, uv0.equipMaxLv_, uv0.equip_.now_break_level) - uv0.equip_.exp, slot3)

		uv0:RefreshListSelect()
	end)
	slot0:AddBtnListener(slot0.btnLevelup_, nil, function ()
		slot0 = false

		for slot4, slot5 in pairs(uv0.usedMaterialList_) do
			if slot5 > 0 then
				slot0 = true
			end
		end

		if not slot0 and next(uv0.usedEquipList_) == nil then
			ShowTips(GetTips("PLEASE_SELECT_ITEM"))

			return
		end

		if not checkGold(uv0.cost_) then
			return
		end

		slot1 = false

		for slot5, slot6 in pairs(uv0.usedEquipList_) do
			if slot6.equip_star >= 5 then
				slot1 = true

				break
			end
		end

		slot2 = false
		slot6 = MaterialTools.materialGiveBack(uv0.equip_.exp + EquipTools.CountAddExp(uv0.usedMaterialList_, uv0.usedEquipList_) - EquipTools.CountNeedExp(uv0.equip_, uv0.equipMaxLv_, uv0.equip_.now_break_level), ItemConst.STR_ITEM.EQUIP)

		for slot11, slot12 in pairs(uv0.usedEquipList_) do
			function (slot0, slot1)
				for slot5, slot6 in pairs(slot1) do
					slot0[#slot0 + 1] = slot6
				end
			end(slot6, EquipData:GetEquipData(slot11):GetBreakCostReturn())
		end

		if #unformatRewardCfgList(sortReward(mergeReward(formatRewardCfgList(slot6)))) > 0 then
			slot2 = true
		end

		slot8 = ""

		if slot1 and slot2 then
			slot8 = string.format(GetTips("EQUIP_STRENGTH_EXP_OVERFLOW_AND_RARE"))
		elseif slot1 and not slot2 then
			slot8 = GetTips("EQUIP_STRENGTH_COST_RARE")
		elseif not slot1 and slot2 then
			slot8 = string.format(GetTips("EQUIP_STRENGTH_EXP_OVERFLOW"))
		else
			EquipAction.ApplyStrengthEquip(tonumber(uv0.equipId_), uv0.usedEquipList_, uv0.usedMaterialList_, uv0.cost_, slot5)

			return
		end

		if slot1 and not slot2 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = slot8,
				OkCallback = function ()
					EquipAction.ApplyStrengthEquip(tonumber(uv0.equipId_), uv0.usedEquipList_, uv0.usedMaterialList_, uv0.cost_)
				end
			})

			return
		end

		JumpTools.OpenPageByJump("materialPreview", {
			content = slot8,
			OkCallback = function ()
				EquipAction.ApplyStrengthEquip(tonumber(uv0.equipId_), uv0.usedEquipList_, uv0.usedMaterialList_, uv0.cost_, uv1)
			end,
			itemList = slot6
		})
	end)
	slot0:AddBtnListener(slot0.btnFilter_, nil, function ()
		JumpTools.OpenPageByJump("commonFilterView", {
			filterGroup = Filter_Root_Define.Equip_Filter_List
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0:OnEquipChange(slot0.params_.equipId)
	slot0:RegistEventListener(COMMON_FILTER_OK, handler(slot0, slot0.OnFilterChange))
	slot0:RegistEventListener(CURRENCY_UPDATE, handler(slot0, slot0.OnGoldChange))
	slot0:RegistEventListener(EQUIP_STRENGTH_SUCCESS, handler(slot0, slot0.OnEquipStrengthSuccess))
end

function slot0.OnEquipChange(slot0, slot1)
	slot0.usedMaterialList_ = {}
	slot0.usedEquipList_ = {}
	slot0.equipId_ = slot1
	slot0.equip_ = EquipData:GetEquipData(slot0.equipId_)
	slot0.equipMaxLv_ = EquipTools.CountEquipMaxLv(slot0.equip_)
	slot0.equipLv_ = slot0.equip_:GetLevel()

	if slot0.equipLv_ == slot0.equipMaxLv_ then
		slot0.maxLvController_:SetSelectedState("max")
		slot0:RefreshMax()
	else
		slot0.maxLvController_:SetSelectedState("normal")
		slot0:RefreshEquipStrength()
		slot0:ChangeEquipSelectView(EquipConst.EQUIP_SORT.LEVEL, ItemConst.SORT_TYPE.UP)
	end

	slot0:ChangeBar()
end

function slot0.OnTop(slot0)
	slot0:ChangeBar()
end

function slot0.ChangeBar(slot0)
	if slot0.equipLv_ == slot0.equipMaxLv_ then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
	else
		table.insert(slot1, CurrencyConst.CURRENCY_TYPE_GOLD)
		manager.windowBar:SwitchBar(slot1)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	end
end

function slot0.RefreshMax(slot0)
	slot0.maxLv_.text = slot0.equipMaxLv_
	slot2 = 1

	for slot6, slot7 in pairs(EquipTools.CountEquipAttribute(slot0.equip_)) do
		slot9 = slot0.maxAttrs[slot2]
		slot10 = math.floor(slot7)

		if PublicAttrCfg[slot6].percent and slot8.percent == 1 then
			slot10 = slot7 / 10 .. "%"
		end

		slot9.name_.text = GetI18NText(slot8.name)
		slot9.icon_.sprite = getSprite("Atlas/SystemCommonAtlas", slot8.icon)
		slot9.num_.text = slot10
		slot2 = slot2 + 1
	end
end

function slot0.RefreshEquipStrength(slot0)
	slot1 = EquipTools.CountAddExp(slot0.usedMaterialList_, slot0.usedEquipList_)
	slot2 = slot0.equip_
	slot3 = slot2.exp + slot1
	slot4 = deepClone(slot2)
	slot4.exp = slot3

	slot0:RefreshExp(slot1, slot3, slot2, slot4)
	slot0:RefreshAttr(slot2, slot4)
	slot0:RefreshCost()
end

function slot0.RefreshExp(slot0, slot1, slot2, slot3, slot4)
	slot5 = EquipTools.CountEquipLevel(slot3)
	slot6 = EquipTools.CountEquipLevel(slot4)
	slot0.nextLv_ = slot6
	slot0.oldLv_.text = "" .. slot5
	slot0.newLv_.text = "" .. slot6

	SetActive(slot0.btnAutoSelectGo_, slot5 < slot0.equipMaxLv_)
	SetActive(slot0.btnStrengthGo_, slot5 < slot7)
	SetActive(slot0.btnAutoSelectNullGo_, slot5 == slot7)
	SetActive(slot0.newLevelContent_, slot1 ~= 0)

	slot0.addExpText_.text = "+" .. slot1
	slot9 = slot2 - EquipTools.CountNeedExp(slot3, slot6, slot3.now_break_level)
	slot0.cost_ = 0

	if slot7 <= slot6 then
		slot0.cost_ = math.floor((slot8 - slot3.exp < 0 and 0 or slot10) * GameSetting.equip_strengthen_gold_cost.value[1])
		slot0.expNum_.text = "-/-"
		slot0.expProg_.fillAmount = 0
		slot0.newExpProg_.fillAmount = 1

		SetActive(slot0.maxGo_, true)
	else
		slot0.cost_ = math.floor(slot1 * GameSetting.equip_strengthen_gold_cost.value[1])
		slot0.expNum_.text = slot9 .. "/" .. EquipExpCfg[slot6]["exp" .. slot3.equipConfig.starlevel]

		if slot6 == slot5 then
			slot0.expProg_.fillAmount = (slot9 - slot1) / slot10
		else
			slot0.expProg_.fillAmount = 0
		end

		slot0.newExpProg_.fillAmount = slot9 / slot10

		SetActive(slot0.maxGo_, false)
	end
end

function slot0.RefreshAttr(slot0, slot1, slot2)
	slot4 = EquipTools.CountEquipAttribute(slot2)
	slot5 = 1

	for slot9, slot10 in pairs(EquipTools.CountEquipAttribute(slot1)) do
		slot11 = PublicAttrCfg[slot9]

		if not slot0.attrs[slot5] then
			break
		end

		slot13 = math.floor(slot10)
		slot14 = math.floor(slot4[slot9])

		if slot11.percent and slot11.percent == 1 then
			slot13 = slot10 / 10 .. "%"
			slot14 = slot4[slot9] / 10 .. "%"
		end

		slot12.name_.text = GetI18NText(slot11.name)
		slot12.icon_.sprite = getSprite("Atlas/SystemCommonAtlas", slot11.icon)
		slot12.oldVal_.text = slot13

		if slot10 ~= slot4[slot9] then
			slot12.newVal_.text = string.format("<color='#E28000'>%s</color>", slot14)
			slot12.arrow_.color = Color.New(0.8941176, 0.5058823, 0, 1)
		else
			slot12.newVal_.text = string.format("<color='#3D4045'>%s</color>", slot14)
			slot12.arrow_.color = Color.New(0.2392156, 0.2509803, 0.2705882, 1)
		end

		slot5 = slot5 + 1
	end
end

function slot0.RefreshCost(slot0)
	if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < slot0.cost_ then
		slot2 = "<color='#FF0000'>" .. tostring(slot0.cost_) .. "</color>"
	end

	slot0.costNum_.text = slot2
end

function slot0.ChangeEquipSelectView(slot0, slot1, slot2)
	slot0.priority_ = slot1
	slot0.order_ = slot2
	slot0.itemList = slot0:GetItemList()

	slot0:RefreshList()
end

function slot0.RefreshList(slot0)
	slot0.scrollHelper:StartScroll(#slot0.itemList)
end

function slot0.RefreshListSelect(slot0)
	slot3 = slot0.scrollHelper
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		if slot5:GetData().type == ItemConst.ITEM_TYPE.MATERIAL then
			slot5:RefreshTopAmount(slot0.usedMaterialList_[slot6.id] or 0)
		elseif slot6.type == ItemConst.ITEM_TYPE.EQUIP then
			slot5:RefreshSelectState(slot0.usedEquipList_[slot6.equip_id] and true or false)
		end
	end

	slot0:RefreshEquipStrength()
end

function slot0.indexItem(slot0, slot1, slot2)
	slot4 = clone(ItemTemplateData)

	if slot0.itemList[slot1].type == ItemConst.ITEM_TYPE.EQUIP then
		slot4.equip_info = slot3
		slot4.id = slot3.prefab_id
		slot4.equip_id = slot3.equip_id
		slot4.equip_star = getItemStar(slot3.prefab_id)
		slot4.equipLevel = EquipTools.CountEquipLevel(slot3)
		slot4.isEquiped = false
		slot4.equipedLocked = slot3.is_lock
		slot4.type = slot3.type

		function slot4.clickFun(slot0)
			uv0:EquipClickFunc(uv1, slot0)
		end

		slot4.selectStyle = slot0.usedEquipList_[slot3.equip_id] ~= nil
	elseif slot3.type == ItemConst.ITEM_TYPE.MATERIAL then
		slot4.id = slot3.id
		slot4.number = slot3.number
		slot4.type = slot3.type

		function slot4.longClickFun(slot0)
			return uv0:MaterialLongClickFunc(uv1, slot0)
		end

		function slot4.clickAmountFun(slot0)
			return uv0:MaterialAmountClickFunc(uv1, slot0)
		end

		if slot0.usedMaterialList_[slot3.id] and slot0.usedMaterialList_[slot3.id] ~= 0 then
			slot4.topAmountValue = slot0.usedMaterialList_[slot3.id]
		end
	end

	slot2:SetData(slot4)
end

function slot0.EquipClickFunc(slot0, slot1, slot2)
	if slot0.usedEquipList_[slot2.equip_id] then
		slot0.usedEquipList_[slot3] = nil
		slot0.handler_.equipCommonItem_ = slot1

		slot0.handler_:HidePop()
	else
		slot4 = slot2.equip_id

		if slot0.equipMaxLv_ <= slot0.nextLv_ then
			ShowTips("ERROR_USER_MAX_LV")

			return
		end

		if slot2.equipedLocked then
			ShowTips("REMOVE_LOCK")
			slot0:ShowEquipInfo(slot4, slot1)

			return
		end

		slot0:ShowEquipInfo(slot4, slot1)
		slot1:RefreshSelectState(true)

		slot0.usedEquipList_[slot4] = slot2
	end

	slot0:RefreshEquipStrength()
end

function slot0.MaterialLongClickFunc(slot0, slot1, slot2)
	if slot0.equipMaxLv_ <= slot0.nextLv_ then
		ShowTips("ERROR_USER_MAX_LV")

		return false
	end

	slot0.usedMaterialList_[slot2.id] = slot0.usedMaterialList_[slot2.id] or 0

	if slot2.number <= slot0.usedMaterialList_[slot2.id] then
		return false
	end

	slot0.usedMaterialList_[slot2.id] = slot0.usedMaterialList_[slot2.id] + 1

	slot1:RefreshTopAmount(slot0.usedMaterialList_[slot2.id])
	slot0:RefreshEquipStrength()
	manager.audio:PlayUIAudio(2)

	return true
end

function slot0.MaterialAmountClickFunc(slot0, slot1, slot2)
	slot0.usedMaterialList_[slot2.id] = slot0.usedMaterialList_[slot2.id] or 0

	if slot0.usedMaterialList_[slot2.id] <= 0 then
		return false
	end

	slot0.usedMaterialList_[slot2.id] = slot0.usedMaterialList_[slot2.id] - 1

	slot1:RefreshTopAmount(slot0.usedMaterialList_[slot2.id])
	slot0:RefreshEquipStrength()
	manager.audio:PlayUIAudio(2)

	return true
end

function slot0.GetEquip(slot0)
	return EquipData:GetEquipData(slot0.equipId_)
end

function slot0.GetItemList(slot0)
	slot1 = EquipData:GetEquipListComplex(slot0.order_, slot0.priority_)
	slot6 = ItemConst.ITEM_TYPE.MATERIAL

	for slot6, slot7 in ipairs(ItemCfg.get_id_list_by_type[slot6]) do
		slot8 = ItemTools.getItemNum(slot7)

		if ItemCfg[slot7].sub_type == MaterialConst.MATERIAL_TYPE.EQUIP_LEVEL_UP and slot8 > 0 then
			table.insert({}, {
				type = ItemCfg[slot7].type,
				id = slot7,
				number = slot8
			})
		end
	end

	slot4 = ProposalData:GetEquipMap()

	for slot8 = #slot1, 1, -1 do
		if HeroData:GetEquipMap()[slot1[slot8].equip_id] or slot1[slot8].equip_id == slot0.equipId_ then
			table.remove(slot1, slot8)
		end
	end

	for slot8, slot9 in ipairs(slot1) do
		if not slot9.is_lock and not slot4[slot9.equip_id] then
			slot9.type = ItemCfg[slot9.prefab_id].type

			table.insert(slot2, slot9)
		end
	end

	return slot2 or {}
end

function slot0.ShowEquipInfo(slot0, slot1, slot2)
	slot0.handler_:RefreshEquipInfo(EquipData:GetEquipData(slot1), slot2, function (slot0)
		if slot0 then
			uv0:RefreshSelectState(false)

			uv1.usedEquipList_[uv2] = nil

			uv1:RefreshEquipStrength()
		end

		uv0:RefreshLock(slot0)
	end)
end

function slot0.OnEquipStrengthSuccess(slot0, slot1, slot2, slot3)
	if slot1 then
		slot0.handler_:RefreshSideBar(slot0.equipId_)
	end

	if slot2 then
		JumpTools.OpenPageByJump("equipCulturePopView", slot3)
	end

	slot0.handler_:HidePop()

	slot0.usedMaterialList_ = {}
	slot0.usedEquipList_ = {}
	slot0.itemList = slot0:GetItemList()

	slot0:RefreshListSelect()
	slot0:RefreshList()
end

function slot0.OnGoldChange(slot0, slot1)
	if slot1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		slot0:RefreshEquipStrength()
	end
end

function slot0.OnExit(slot0)
	slot0.isOnIndex = nil

	CommonFilterData:ClearFilter(Filter_Root_Define.Equip_Filter_List.filter_id)
	slot0:RemoveAllEventListener()
end

function slot0.OnFilterChange(slot0)
	slot1 = CommonFilterData:HasIndexFlag(2, 4, 13)
	slot3 = CommonFilterData:HasIndexFlag(2, 5, 15)

	slot0:ChangeEquipSelectView(CommonFilterData:HasIndexFlag(2, 4, 14) and EquipConst.EQUIP_SORT.RARE or EquipConst.EQUIP_SORT.LEVEL, CommonFilterData:HasIndexFlag(2, 5, 16) and 0 or 1)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.scrollHelper then
		slot0.scrollHelper:Dispose()

		slot0.scrollHelper = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
