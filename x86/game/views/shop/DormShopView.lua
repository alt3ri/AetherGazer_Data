slot0 = class("ShopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Shop/BHShopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot1(slot0)
	return nullable(ShopListCfg, slot0, "display_group")
end

function slot2(slot0)
	return nullable(ShopListCfg.get_id_list_by_system_and_group, 1, slot0, 1, "group_name")
end

function slot0.OnCtor(slot0)
	slot0.curShop = nil
	slot0.contentViewDic = {}
end

function slot3(...)
	print("group", ...)
end

function slot4(...)
	print("item", ...)
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.tree = LuaTree.New(slot0.treeGo_)

	slot0.tree:OverrideRenderer(nil, handler(slot0, slot0.ShopItemRenderer))
	slot0.tree:SetSelectedHandler(handler(slot0, slot0.OnShopGroupSelect), handler(slot0, slot0.OnShopItemSelect))

	slot0.displayModeController = slot0.controllerExCollection_:GetController("displayMode")
end

function slot5(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0) do
		if slot2[slot1(slot7)] == nil then
			slot2[slot8] = {}
		end

		table.insert(slot9, slot7)
	end

	return slot2
end

function slot6(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0) do
		table.insert(slot2, slot6)
	end

	table.sort(slot2, slot1)

	return function (slot0, slot1)
		if slot1 < slot0 then
			slot1 = slot1 + 1
			slot2 = uv0[slot1]

			return slot1, {
				key = slot2,
				value = uv1[slot2]
			}
		end
	end, #slot2, 0
end

function slot0.UpdateShopCatagoryTreeData(slot0, slot1)
	if next(slot1) == nil then
		return
	end

	slot0.catagoryInfo = slot1
	slot0.shopComList = {}
	slot2 = UITreeData.New()

	for slot6, slot7 in uv0(slot1, slot0.params_.groupSortingFunc) do
		slot8 = slot7.key
		slot9 = slot7.value

		table.sort(slot9, slot0.params_.shopInGroupSortFunc)

		slot10 = UITreeGroupData.New()

		for slot14, slot15 in ipairs(slot9) do
			slot16 = UITreeItemData.New()
			slot17 = ShopListCfg[slot15]
			slot16.id = slot17.id
			slot16.text = GetI18NText(slot17.remark)

			slot10.itemDatas:Add(slot16)
		end

		slot10.text = GetI18NText(slot0.params_.groupNameMappingFunc or uv1(slot8))
		slot10.id = slot8

		slot2.groupDatas:Add(slot10)
	end

	slot0.tree:SetData(slot2)
	slot0:ClearAllRegisteredRedPoints()
	slot0:RegisterRedPoints()
end

function slot0.SetData(slot0, slot1)
	slot0.displayModeController:SetSelectedState(#slot1 > 1 and "multiple" or "single")
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.middleTrs_)
	slot0:UpdateShopCatagoryTreeData(uv0(slot1, slot0.params_.groupingFunc or uv1))
	slot0:SelectTreeByShopId(slot0.params_.shop or slot1[1])
end

slot7 = nil
slot8 = 8

function slot9(slot0)
	if uv0 == nil then
		uv0 = {
			[50] = {
				CLASS = ShopCanteenMaterialContentView
			}
		}
	end

	slot1 = import("game.views.shop.contentViews.ShopFurnitureContentView")

	if uv0[slot0] then
		return slot2.CLASS
	else
		if ShopListCfg[slot0].display_group == uv1 then
			return slot1
		end

		if slot3.system == "2" then
			return ShopExchangeContentView
		else
			return ShopContentView
		end
	end
end

function slot0.GetContentViewByShopId(slot0, slot1, slot2)
	if slot1 == nil then
		return nil
	end

	slot3 = uv0(slot1)

	if slot0.curShop and uv0(slot0.curShop) ~= slot3 then
		SetActive(slot0.contentViewDic[slot4.__cname].gameObject_, false)
	end

	if not slot0.contentViewDic[slot3.__cname] then
		slot0.contentViewDic[slot4] = slot3.New(slot0.contentContainer_)
	elseif not slot2 then
		SetActive(slot5.gameObject_, true)
	end

	slot5:SetShopHideHome(slot0.params_.hideHomeBtn)

	if not slot2 then
		slot5:SetShopId(slot1)
	end

	return slot5
end

function slot0.GetCurContentView(slot0)
	return slot0:GetContentViewByShopId(slot0.curShop)
end

function slot0.RefreshShopGoodInfo(slot0, slot1, slot2)
	if slot0.curShop ~= slot1 then
		return
	end

	slot0:GetContentViewByShopId(slot1):RefreshShopGoodInfo(slot2)
end

function slot0.RefreshList(slot0, slot1)
	slot0:GetCurContentView():RefreshList(slot1)
end

function slot0.UpdateShopList(slot0, slot1, slot2)
	slot0.curShop = slot1
	slot0.params_.shop = slot1

	slot0:RefreshList(slot2 or slot0.curShop == slot1)
end

function slot0.UpdateBarByShopId(slot0, slot1)
	if slot0:GetContentViewByShopId(slot1) then
		slot2:UpdateBarByShopId()
	end

	manager.windowBar:RegistHomeCallBack(function ()
		gameContext:Go("/home", nil, , true)
	end)
	manager.windowBar:RegistBackCallBack(function ()
		uv0.params_.scrollPosition = nil

		JumpTools.Back()
	end)
end

function slot0.OnTop(slot0)
	if slot0.params_.shop ~= slot0.curShop then
		slot0.curShop = slot0.params_.shop
	end

	if slot0.curShop then
		slot0:UpdateShopList(slot0.curShop, true)
		slot0:UpdateBarByShopId(slot0.curShop)
	end
end

function slot0.OnEnter(slot0)
	slot0:EnterShopPage()
	slot0:SetData(slot0.params_.shopList)
end

function slot0.OnExit(slot0)
	slot0:ClearAllRegisteredRedPoints()
	slot0:ExitShopPage()
end

function slot0.ShopItemRenderer(slot0, slot1, slot2)
	if slot0.shopComList[slot1] == nil then
		slot3 = {}

		slot0:BindCfgUI(slot2, slot3)

		slot0.shopComList[slot1] = slot3
	end

	slot4 = ShopListCfg[slot1]

	if slot3.icon_ then
		slot3.icon_.sprite = getSpriteViaConfig("ShopPreviewSmall", slot1)
	end
end

function slot0.OnShopItemSelect(slot0, slot1, slot2, slot3, slot4)
	if not ShopTools.CheckShopIsUnLock(slot2) and not string.isNullOrEmpty(ShopTools.GetShopIsUnLockDesc(slot2)) then
		ShowTips(slot5)
	end

	if slot2 ~= slot0.curShop then
		slot0:ExitShopPage()

		slot0.curShop = slot2

		slot0:EnterShopPage(slot0:GetContentViewByShopId(slot2))
		slot0:UpdateShopList(slot2)
	end
end

function slot0.ExitShopPage(slot0)
	if slot0:GetCurContentView() then
		slot1:OnExit()
	end
end

function slot0.EnterShopPage(slot0, slot1)
	if slot1 or slot0:GetCurContentView() then
		slot2:OnEnter()
	end
end

function slot0.OnShopGroupSelect(slot0, slot1, slot2, slot3, slot4)
end

function slot0.Dispose(slot0)
	slot0.tree:Dispose()

	for slot4, slot5 in pairs(slot0.contentViewDic) do
		slot5:Dispose()
	end

	slot0.contentViewDic = nil
	slot0.curShop = nil

	uv0.super.Dispose(slot0)
end

slot11 = require("game.tools.ShopTools").GetShopRedPointKey

function slot12(slot0)
	return "SHOP_GROUP_" .. slot0
end

function slot0.RegisterRedPoints(slot0)
	for slot4, slot5 in pairs(slot0.catagoryInfo) do
		slot6 = {}
		slot7 = slot0.tree:GetGroupRedPointContainerById(slot4)

		for slot11, slot12 in ipairs(slot5) do
			if slot0.tree:GetItemRedPointContainerById(slot4, slot12) then
				slot14 = uv0(slot12)

				manager.redPoint:bindUIandKey(slot13, slot14)
				table.insert(slot6, slot14)
			end
		end

		if slot7 and next(slot6) then
			slot8 = uv1(slot4)

			manager.redPoint:addGroup(slot8, slot6, true)
			manager.redPoint:bindUIandKey(slot7, slot8)
		end
	end
end

function slot0.ClearAllRegisteredRedPoints(slot0)
	if slot0.catagoryInfo == nil then
		return
	end

	for slot4, slot5 in pairs(slot0.catagoryInfo) do
		slot7 = slot0.tree:GetGroupRedPointContainerById(slot4)

		for slot11, slot12 in ipairs(slot5) do
			if slot0.tree:GetItemRedPointContainerById(slot4, slot12) then
				slot14 = uv0(slot12)

				manager.redPoint:unbindUIandKey(slot13, slot14)
				table.insert({}, slot14)
			end
		end

		if slot7 then
			slot8 = uv1(slot4)

			manager.redPoint:unbindUIandKey(slot7, slot8)
			manager.redPoint:delGroup(slot8, slot6)
		end
	end
end

function slot13(slot0, slot1)
	for slot5, slot6 in uv0(slot0) do
		if table.indexof(slot6.value, slot1) then
			return slot5, slot8
		end
	end
end

function slot0.SelectTreeByShopId(slot0, slot1)
	if next(slot0.catagoryInfo) == nil then
		return
	end

	slot2, slot3 = uv0(slot0.catagoryInfo, slot1)

	if slot2 and slot3 then
		slot0.tree:SelectItem(slot2, slot3)
	end
end

return slot0
