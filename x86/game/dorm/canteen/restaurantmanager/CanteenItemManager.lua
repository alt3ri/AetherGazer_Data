function slot0(slot0)
	return Dorm.storage:GetData(DormEnum.Namespace.EntityData, slot0)
end

function slot1(slot0)
	return slot0.tag.transform
end

function slot2(slot0, slot1)
	slot2 = nil

	if CanteenItemCfg.get_id_list_by_combination[slot0] then
		for slot7, slot8 in ipairs(slot3) do
			if CanteenItemCfg[slot8].level <= slot1 then
				slot2 = slot8
			else
				break
			end
		end
	end

	return slot2
end

slot3 = "HZ04_placeholder"

function slot4(slot0)
	if (nullable(CanteenItemCfg, uv0(slot0.type, slot0.level or 0), "model") or uv1) == "" then
		slot4 = uv1
	end

	return "Dorm/Restaurant/" .. slot4
end

slot5 = CanteenManager.PosNamespace(DormEnum.Points.RestaurantFoodSpawn)

function slot6()
	return Dorm.storage:RndPickData(uv0).transform
end

function slot7(slot0)
	return "Dorm/Food/" .. slot0.prefab
end

function slot8(slot0, slot1, slot2)
	slot2 = slot2 or {}
	slot2.available = true
	slot2.type = DormEnum.EntityType.FoodItem

	return slot2
end

slot9 = singletonClass("DormItemManager")

function slot9.Ctor(slot0)
	slot0.listener = EventListener.New()
	slot0.staticItemEntityManager = EntityManager.New(EntityManager.AttachToModel.New(uv0))
	slot0.itemEntityManager = EntityManager.New(EntityManager.CreateModel.New(uv1, uv0))
	slot0.foodEntityManager = EntityManager.New(EntityManager.CreateModel.New(uv2, uv3, 1), uv4)

	function slot4(slot0, slot1, slot2)
		slot3 = Dorm.storage:GetData(uv0.TypeNamespace, slot0)

		uv1.RecordItemInfo(slot0, slot1, slot3)
		uv1.RecordInteractPoints(slot0, slot1, slot3)
	end

	slot0.staticItemEntityManager.OnCreate = slot4
	slot0.itemEntityManager.OnCreate = slot4

	function slot0.foodEntityManager.OnCreate(slot0, slot1, slot2)
		Dorm.DormEntityManager.SetFadeCMD(slot1, 1)
		uv0.RecordItemInfo(slot0, slot1, DormEnum.ItemType.Food)
	end

	slot0.staticItemEntityManager.OnRemove = slot0.RemoveItemInfo
	slot0.itemEntityManager.OnRemove = slot0.RemoveItemInfo

	function slot0.foodEntityManager.OnRemove(slot0, slot1, slot2)
		Dorm.DormEntityManager.StartFadeOutCMD(slot1, 1)
		uv0.RemoveItemInfo(slot0, slot1, slot2)
	end
end

function slot9.Init(slot0)
	slot0:RegisterEvents()
	slot0:GenerateAllSceneItem()
	slot0.foodEntityManager:MapToDormStorageData(uv0.ItemEIdNamespace(DormEnum.ItemType.Food), uv0.ItemIdxNamespace(DormEnum.ItemType.Food))
end

function slot9.Reset(slot0)
	slot0.staticItemEntityManager:Clear()
	slot0.itemEntityManager:Clear()

	slot0.foodID = nil

	slot0.foodEntityManager:Clear(true)
	slot0:RemoveEvents()
end

function slot9.RegisterEvents(slot0)
	slot0.listener:Register(DORM_RESTAURANT_UPDATE_SCENE_ITEM, function ()
		uv0:ClearAllSenenItem()
		uv0:GenerateAllSceneItem()
	end)
end

function slot9.RemoveEvents(slot0)
	slot0.listener:RemoveAll()
end

slot9.ItemEIdNamespace = DormUtils.EIdNamespace
slot9.ItemIdxNamespace = DormUtils.IdxNamespace
slot9.ItemCountNamespace = "restaurant.item.count"

function slot9.GetItemCount(slot0)
	return Dorm.storage:GetData(uv0.ItemCountNamespace, slot0) or 0
end

function slot10(slot0)
	slot1 = {}

	for slot5 = 0, slot0.Length - 1 do
		table.insert(slot1, slot0[slot5])
	end

	return slot1
end

function slot9.RecordItemInfo(slot0, slot1, slot2)
	slot3 = Dorm.storage

	slot3:RecordData(DormEnum.Namespace.EntityType, slot1, slot2)
	slot3:RecordData(uv0.ItemEIdNamespace(slot2), slot0, slot1)
	slot3:RecordData(uv0.ItemIdxNamespace(slot2), slot1, slot0)
	slot3:RecordData(uv0.ItemCountNamespace, slot2, uv0.GetItemCount(slot2) + 1)
end

function slot9.RecordInteractPoints(slot0, slot1, slot2)
	if slot2 == DormEnum.ItemType.Food then
		return
	end

	slot3 = Dorm.storage

	if slot3:GetData(uv0.ItemInteractPointsNamespace, slot0) then
		slot4 = uv1(slot4)
		slot3:GetData(DormEnum.Namespace.EntityData, slot1).interactPoints = slot4

		for slot9, slot10 in ipairs(slot4) do
			CanteenManager.RecordInteractPointInfo(slot10, slot1, nil)
		end
	end
end

function slot9.RemoveItemInfo(slot0, slot1)
	if Dorm.storage:GetData(DormEnum.Namespace.EntityType, slot1) == nil then
		return
	end

	slot2:RecordData(DormEnum.Namespace.EntityType, slot1, nil)
	slot2:RecordData(uv0.ItemEIdNamespace(slot3), slot0, nil)
	slot2:RecordData(uv0.ItemIdxNamespace(slot3), slot1, nil)
	slot2:RecordData(uv0.ItemCountNamespace, slot3, uv0.GetItemCount(slot3) - 1)

	if slot2:GetData(uv0.ItemInteractPointsNamespace, slot0) then
		CanteenManager.RemoveInteractPointInfo(slot1)
	end
end

slot9.PosNamespace = DormTagConst.DORM_RESTAURANT_ITEM_NAMESPACE
slot9.StaticItemPosNamespace = DormTagConst.DORM_RESTAURANT_STATIC_ITEM_NAMESPACE
slot9.GroupNamespace = DormTagConst.DORM_RESTAURANT_ITEM_GROUP_NAMESPACE
slot9.TypeNamespace = DormTagConst.DORM_RESTAURANT_ITEM_TYPE_NAMESPACE
slot9.ItemInteractPointsNamespace = DormTagConst.DORM_RESTAURANT_ITEM_INTERACT_POINTS_NAMESPACE

function slot9.GetGroupID(slot0)
	return nullable(BackHomeCanteenFurnitureIDCfg.get_id_list_by_item_tag, slot0, 1)
end

function slot9.GetGroupFromStaticInfo(slot0)
	return Dorm.sceneItemInfo[uv0.GroupNamespace][slot0]
end

function slot9.GenerateSceneItem(slot0, slot1, slot2, slot3)
	slot6 = uv0.GetGroupID(Dorm.storage:GetData(uv0.GroupNamespace, slot1)) or -1

	if Dorm.storage:GetData(uv0.TypeNamespace, slot1) then
		slot7 = CanteenData:GetFurnitureLevel(slot6)
		slot9 = {
			available = true,
			category = DormEnum.EntityType.Furniture,
			type = slot4,
			tag = slot2,
			group = slot5,
			groupID = slot6,
			level = slot7,
			complex = nullable(CanteenItemCfg, uv1(slot4, slot7), "complex")
		}

		manager.notify:Invoke(DORM_RESTAURANT_NEW_ITEM, slot4, (slot3 and slot0.staticItemEntityManager or slot0.itemEntityManager):Create(slot1, slot9, slot9))
	end
end

function slot9.ClearAllSenenItem(slot0)
	slot0.staticItemEntityManager:Clear()
	slot0.itemEntityManager:Clear()
end

function slot9.GenerateAllSceneItem(slot0)
	slot4 = pairs

	for slot4, slot5 in Dorm.storage:ForeachData(uv0.PosNamespace, slot4) do
		slot0:GenerateSceneItem(slot4, slot5, false)
	end

	slot4 = pairs

	for slot4, slot5 in Dorm.storage:ForeachData(uv0.StaticItemPosNamespace, slot4) do
		slot0:GenerateSceneItem(slot4, slot5, true)
	end

	manager.notify:Invoke(DORM_ITEM_RECORD_FIN)
end

function slot9.GetNextFoodID(slot0)
	slot0.foodID = (slot0.foodID or 0) + 1

	return slot0.foodID
end

function slot9.GenerateFood(slot0, slot1, slot2)
	slot5 = slot0.foodEntityManager:Create(slot0:GetNextFoodID(), {
		pooled = true,
		prefab = nullable(BackHomeCanteenFoodCfg, slot1).prefab
	}, slot2)

	manager.notify:Invoke(DORM_RESTAURANT_NEW_ITEM, DormEnum.ItemType.Food, slot5)

	return slot5
end

function slot9.FindAndRemoveEntity(slot0)
	slot1 = uv0.GetInstance()

	EntityManager.FindAndRemoveEntity({
		slot1.foodEntityManager,
		slot1.staticItemEntityManager,
		slot1.itemEntityManager
	}, slot0)
end

function slot9.GetItemInteractPositions(slot0)
	if uv0(slot0).interactPoints then
		slot3 = {}

		for slot7, slot8 in pairs(slot2) do
			table.insert(slot3, slot8)
		end

		return slot3
	end

	return {
		Dorm.DormEntityManager.QueryPosition(slot0)
	}
end

function slot9.GetItemsInItemGroup(slot0, slot1)
	slot3 = {}
	slot7 = pairs

	for slot7, slot8 in Dorm.storage:ForeachData(uv0.ItemEIdNamespace(slot0), slot7) do
		if uv1(slot8).group == slot1 then
			table.insert(slot3, slot8)
		end
	end

	return slot3
end

return slot9
