slot0 = class("EquipUpgradeView", EquipBaseView)

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
	slot0.super.Init(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.attrs = {}

	for slot4 = 1, 2 do
		slot5 = {}

		ComponentBinder.GetInstance():BindCfgUI(slot5, slot0["property_" .. slot4])
		table.insert(slot0.attrs, slot5)
	end

	slot0.costScroller_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.costListGo_, CommonItemView)
	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
	slot0.conditionController_ = slot0.transCon_:GetController("condition")
	slot0.clearController_ = slot0.conditionCon_:GetController("clear")
	slot0.btnStateController_ = slot0.transCon_:GetController("btnState")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.upgradeBtn_, nil, function ()
		EquipAction.ApplyUpgradeEquip(tonumber(uv0.equipId))
	end)
	slot0:AddBtnListener(slot0.noBtn_, nil, function ()
		if uv0.showTips_ then
			ShowTips(GetTips("EQUIP_BREAK_LIMITED"))
		else
			EquipAction.ApplyUpgradeEquip(tonumber(uv0.equipId))
		end
	end)
	slot0:RegistEventListener(EQUIP_UPGRADE_SUCCESS, handler(slot0, slot0.OnEquipUpgradeSuccess))
end

function slot0.OnEquipUpgradeSuccess(slot0, slot1)
	slot0.handler_:RefreshSideBar(slot1.equipId)
	JumpTools.OpenPageByJump("equipCulturePopView", slot1)
end

function slot0.OnEnter(slot0)
	slot0:OnEquipChange(slot0.params_.equipId)
end

function slot0.OnTop(slot0)
	slot0:ChangeBar()
	slot0:RefreshEquipUpCost()
	slot0:RefreshEquipUpLimit()
	slot0.btnStateController_:SetSelectedIndex((slot0.isLack_ or slot0.showTips_) and 1 or 0)
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

function slot0.OnEquipChange(slot0, slot1)
	slot0.equipId = slot1
	slot0.equip = EquipData:GetEquipData(slot0.equipId)

	slot0:RefreshEquipUpgrade()
	slot0:ChangeBar()
end

function slot0.RefreshEquipUpgrade(slot0)
	slot0:RefreshEquipUpInfo()
	slot0:RefreshEquipUpCost()
	slot0:RefreshEquipUpLimit()
	slot0.btnStateController_:SetSelectedIndex((slot0.isLack_ or slot0.showTips_) and 1 or 0)
end

function slot0.RefreshEquipUpInfo(slot0)
	slot1 = EquipCfg[slot0.equip.prefab_id]
	slot2 = slot0.equip.now_break_level
	slot0.oldLv_.text = slot1.max_level[slot2 + 1]
	slot0.newLv_.text = slot1.max_level[slot2 + 2]

	for slot6 = 1, 2 do
		slot7 = slot1.fixed_attributes[slot2 + 1]
		slot8 = PublicAttrCfg[slot7[slot6][1]]
		slot9 = slot0.attrs[slot6]
		slot9.icon_.sprite = getSprite("Atlas/SystemCommonAtlas", slot8.icon)
		slot9.name_.text = string.format(GetTips("EQUIP_UPGRADE_ATTR_DES"), GetI18NText(slot8.name))
		slot9.oldVal_.text = slot7[slot6][3]
		slot9.newVal_.text = slot1.fixed_attributes[slot2 + 2][slot6][3]
	end
end

function slot0.RefreshEquipUpCost(slot0)
	if not slot0.equip:GetUpgradeCost() then
		return
	end

	slot0.isLack_ = false
	slot0.moneyCost_ = slot1.money

	if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < slot1.money then
		slot0.isLack_ = true
		slot3 = "<color='#EB0000'>" .. tostring(slot0.moneyCost_) .. "</color>"
	end

	slot0.costNum_.text = slot3

	for slot7, slot8 in ipairs(slot1.item_list) do
		if ItemTools.getItemNum(slot8[1]) < slot8[2] then
			slot0.isLack_ = true

			break
		end
	end

	slot0.costMaterialList_ = slot1.item_list

	slot0.costScroller_:StartScroll(#slot0.costMaterialList_)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot3 = clone(ItemTemplateData)
	slot4 = slot0.costMaterialList_[slot1]
	slot3.id = slot4[1]

	function slot3.clickFun(slot0)
		ShowPopItem(POP_SOURCE_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	slot3.bottomText = {
		ItemTools.getItemNum(slot4[1]),
		slot4[2]
	}
	slot3.hideBottomRightTextFlag = true

	slot2:SetData(slot3)
end

function slot0.RefreshEquipUpLimit(slot0)
	slot1 = EquipCfg[slot0.equip.prefab_id]

	if slot1.hero_slot_open_level[1] and slot1.max_level[slot0.equip.now_break_level + 2] == slot4 then
		slot0.conditionController_:SetSelectedState("show")

		slot0.conditionDesc_.text = GetTips("EQUIP_BREAK_LIMITED")

		if slot0.equip.race ~= 0 and table.keyof(RaceEffectCfg.all, slot0.equip.race) == nil then
			slot0.showTips_ = false

			slot0.clearController_:SetSelectedState("clear")
		else
			slot0.showTips_ = true

			slot0.clearController_:SetSelectedState("notclear")
		end
	else
		slot0.showTips_ = false

		slot0.conditionController_:SetSelectedState("hide")
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.costScroller_ then
		slot0.costScroller_:Dispose()

		slot0.costScroller_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
