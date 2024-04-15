slot0 = class("EquipInheritView", EquipBaseView)

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

	slot0.costItemList_ = LuaList.New(handler(slot0, slot0.IndexCostItem), slot0.materialListGo_, CommonItemView)
	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
	slot0.stateController_ = slot0.transCon_:GetController("state")
	slot0.costController_ = ControllerUtil.GetController(slot0.transform_, "costState")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnTips_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("EQUIP_INHERIT_DESC")
		})
	end)
	slot0:AddBtnListener(slot0.btnAdd_, nil, function ()
		JumpTools.OpenPageByJump("equipInheritPrefabSelect", {
			equipID = uv0.equipID_,
			suitId = uv0.selectSuitID_,
			currentSuitId = uv0.selectSuitID_,
			selectSuitHandler = handler(uv0, uv0.OnSelectSuit)
		})
	end)
	slot0:AddBtnListener(slot0.btnInherit_, nil, function ()
		if uv0.selectSuitID_ == nil then
			ShowTips("EQUIP_INHERIT_SELECT")
		elseif uv0.selectSuitID_ == uv0.equipCfg_.suit then
			ShowTips("ERROR_EQUIP_SAME_ID")
		elseif uv0.materialEnough_ == false then
			ShowTips("ERROR_ITEM_NO_ENOUGH_MATERIAL")
		elseif uv0.goldEnough_ == false then
			slot0 = false

			for slot5, slot6 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND] or {}) do
				if ItemTools.getItemNum(slot6) > 0 then
					slot0 = true

					break
				end
			end

			if CurrencyData:GetGoldBuyTimes() < GameSetting.coin_max_buy_time.value[1] or slot0 then
				JumpTools.OpenPopUp("currencyBuyGold", nil, ViewConst.SYSTEM_ID.BUY_GOLD)
			else
				ShowTips(GetTips("ERROR_ITEM_NOT_ENOUGH_GOLD"))
			end
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EQUIP_INHERIT_CONFIRM"),
				OkCallback = function ()
					EquipAction.InheritEquip(uv0.equipID_, uv0.selectPrefabID_)
				end
			})
		end
	end)
	slot0:AddBtnListener(slot0.btnInfo_, nil, function ()
		uv0.handler_:RefreshEquipInfo(uv0.selectInfo_)
	end)
end

function slot0.IndexCostItem(slot0, slot1, slot2)
	slot3 = slot0.materialList_[slot1]
	slot4 = clone(ItemTemplateData)
	slot4.id = slot3.id

	function slot4.clickFun(slot0)
		ShowPopItem(POP_SOURCE_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	slot4.bottomText = {
		ItemTools.getItemNum(slot3.id),
		slot3.number
	}

	slot2:SetData(slot4)

	if slot0.materialEnough_ == true then
		slot0.materialEnough_ = slot3.number <= slot5
	end
end

function slot0.OnEnter(slot0)
	slot0:OnEquipChange(slot0.params_.equipId)
	slot0:RegistEventListener(CURRENCY_UPDATE, handler(slot0, slot0.OnGoldChange))
end

function slot0.OnEquipChange(slot0, slot1)
	slot0.equipID_ = slot1
	slot0.equipData_ = EquipData:GetEquipData(slot0.equipID_)
	slot0.equipCfg_ = EquipCfg[slot0.equipData_.prefab_id]
	slot0.selectSuitID_ = nil

	slot0:OnSelectSuit()
end

function slot0.RefreshMoney(slot0)
	slot1 = slot0.moneyCost_ or 0

	if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < slot1 then
		slot3 = "<color='#FF0000'>" .. tostring(slot1) .. "</color>"
	end

	slot0.goldEnough_ = slot1 <= slot2
	slot0.costNum_.text = slot3
end

function slot0.RefreshMaterial(slot0)
	slot0.materialEnough_ = true

	slot0.costItemList_:StartScroll(#slot0.materialList_)
end

function slot0.OnGoldChange(slot0, slot1)
	if slot0.selectSuitID_ and slot1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		slot0:RefreshMoney()
	end
end

function slot0.ChangeBar(slot0)
	slot1 = {
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	}

	if slot0.selectSuitID_ then
		table.insert(slot1, CurrencyConst.CURRENCY_TYPE_GOLD)
		manager.windowBar:SwitchBar(slot1)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	else
		manager.windowBar:SwitchBar(slot1)
	end
end

function slot0.OnTop(slot0)
	slot0:ChangeBar()
end

function slot0.OnSelectSuit(slot0, slot1)
	slot2 = nil

	if slot1 ~= nil then
		slot0.stateController_:SetSelectedIndex(1)

		slot0.selectSuitID_ = slot1
		slot0.materialList_, slot0.moneyCost_ = EquipData:GetInheritCost(slot0.selectSuitID_)

		slot0:RefreshMaterial()
		slot0:RefreshMoney()
		slot0:RefreshSelect()
		slot0:ChangeBar(true)
	else
		slot0.stateController_:SetSelectedIndex(0)
		slot0:ChangeBar(false)
	end
end

function slot0.RefreshSelect(slot0)
	slot5 = slot0.selectSuitID_
	slot0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Equip/icon_s/" .. slot5)

	for slot5 = #EquipCfg.get_id_list_by_suit[slot0.selectSuitID_], 1, -1 do
		if EquipCfg[slot1[slot5]].pos == slot0.equipCfg_.pos and slot6.starlevel >= 5 then
			slot0.selectPrefabID_ = slot1[slot5]

			break
		end
	end

	slot0.name_.text = ItemTools.getItemName(slot0.selectPrefabID_)
	slot0.selectInfo_ = deepClone(slot0.equipData_)
	slot0.selectInfo_.prefab_id = slot0.selectPrefabID_
	slot0.selectInfo_.equipConfig = EquipCfg[slot0.selectPrefabID_]
end

function slot0.ResetInherit(slot0)
	slot0.selectSuitID_ = nil
	slot0.equipData_ = EquipData:GetEquipData(slot0.equipID_)
	slot0.equipCfg_ = EquipCfg[slot0.equipData_.prefab_id]

	slot0.stateController_:SetSelectedIndex(0)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	if slot0.costItemList_ then
		slot0.costItemList_:Dispose()

		slot0.costItemList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
