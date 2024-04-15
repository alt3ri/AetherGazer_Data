slot0 = singletonClass("LianLianKanGameManager")
slot1 = {
	previewItemRemove = "Dorm/Effect/lianliankan/Fx_daoju_cx",
	itemNotMatch = "Dorm/Effect/lianliankan/Fx_effect_cuowu",
	itemEnter = "Dorm/Effect/lianliankan/Fx_effect_cai_xinzeng",
	itemRemove = "Dorm/Effect/lianliankan/Fx_gezi_effect"
}
slot2 = "minigame_activity_2_1"
slot3 = {
	ItemNotMatch = "minigame_activity_2_1_connect_fail",
	ItemPreviewClear = "minigame_activity_2_1_connect_tool02",
	Select = "minigame_activity_2_1_connect_choose",
	ItemMatch = "minigame_activity_2_1_connect_link",
	CancelSelect = "minigame_activity_2_1_connect_cancel"
}

function slot4(slot0)
	return slot0.model
end

function slot5(slot0)
	if slot0.type ~= nil and (Dorm.storage:GetData("lianliankan.pos." .. slot0.type, "#") or 0) ~= 0 then
		return nullable(Dorm.storage:GetData(slot1, ((slot0.spawnAt or 1) - 1) % slot2 + 1) or Dorm.storage:PickData(slot1), "transform")
	end
end

function slot0.Ctor(slot0)
	slot0.previewItemQueueCap = 10
	slot0.entityManagers = {}
	slot1 = EntityManager.CreateModel.New(uv0, uv1)
	slot0.placeholderEntityManager = EntityManager.New(slot1)
	slot0.itemEntityManager = EntityManager.New(slot1)
	slot0.customerFoodEntityManager = EntityManager.New(slot1)
	slot0.previewEntityManager = EntityManager.New(EntityManager.CreateModel.New(uv0, uv1, 0.4))
	slot0.customerEntityManager = EntityManager.New(slot1)
	slot0.workerEntityManager = EntityManager.New(slot1)

	table.insert(slot0.entityManagers, slot0.placeholderEntityManager)
	table.insert(slot0.entityManagers, slot0.itemEntityManager)
	table.insert(slot0.entityManagers, slot0.customerFoodEntityManager)
	table.insert(slot0.entityManagers, slot0.previewEntityManager)
	table.insert(slot0.entityManagers, slot0.customerEntityManager)
	table.insert(slot0.entityManagers, slot0.workerEntityManager)

	slot0.itemEntityManager.OnCreate = handler(slot0, slot0.OnItemCreate)
	slot0.itemEntityManager.OnRemove = handler(slot0, slot0.OnItemRemoved)

	function slot0.customerFoodEntityManager.OnCreate(slot0)
		DormCharacterActionManager.taskRunner:NewTask():WaitForSec(5):Then(function ()
			uv0.customerFoodEntityManager:Remove(uv1)
		end):Start()
	end

	function slot0.previewEntityManager.OnCreate(slot0, slot1, slot2, slot3)
		Dorm.DormEntityManager.SetEntitySpeed(slot1, 0.5)
		DormUtils.MoveByPath(slot1, Dorm.storage:GetData("lianliankan.path.preview", slot0), true)

		slot5 = ActivityLinkGameCellCfg[slot3.itemID]

		Dorm.LuaBridge.MiniGameBridge.SetupItemSprite(slot1, slot5.path .. "/" .. slot5.album_id)
	end

	function slot0.customerEntityManager.OnCreate(slot0, slot1)
		Dorm.DormEntityManager.ChangeEntityAnimeScheme(slot1, "sit")
	end

	slot0.listener = EventListener.New()
	slot0.placeholder = "Dorm/Dormitory/HZ07_placeholder"
	slot0.itemModel = "Dorm/Dormitory/HZ07_xuheng1_gezi"
	slot0.itemPreview = "Dorm/Dormitory/HZ07_item_preview"
	slot0.foodModel = "Dorm/Food/120"
	slot0.turn = 2
end

slot0.ItemQueueNamespace = "lianliankan.itemQueue"

function slot0.RegForwardAIEvent(slot0, slot1, slot2)
	slot0.listener:Register(slot1, function (...)
		uv0.ForwardToAI(uv1, ...)

		if uv2 then
			uv2(...)
		end
	end)
end

function slot0.Init(slot0, slot1)
	slot0.level = slot1
	slot0.gridMap = GridMap.New(8, 7)

	slot0:RegisterEvents()

	slot0.gridCoordOrigin = Dorm.storage:PickData("lianliankan.pos.origin").transform
	slot0.pan = Dorm.DormEntityManager.Instance:MakeModelEntity(Dorm.storage:PickData("lianliankan.pos.Pan").transform)
	slot0.chuansongdai = Dorm.DormEntityManager.Instance:MakeModelEntity(Dorm.storage:PickData("lianliankan.pos.chuansongdai").transform)

	Dorm.storage:RecordData(uv0.ItemEidNameSpace(DormEnum.ItemType.Pan), 1, slot0.pan)
	slot0.previewEntityManager:MapToDormStorageData(slot0.ItemQueueNamespace, nil)

	slot9 = nil

	slot0.customerEntityManager:MapToDormStorageData(DormUtils.EIdNamespace(DormEnum.CharacterType.RestaurantNormalCustomer), slot9)
	slot0:GenWorkerEntity(slot1)
	slot0:GenCustomerEntity(slot1)
	slot0.placeholderEntityManager:Clear()

	for slot9, slot10 in ipairs(ActivityLinkGameCfg[slot1].blank_pos) do
		slot0:AddPlaceHolder(Vector2(unpack(slot10)))
	end
end

function slot0.Reset(slot0)
	manager.audio:StopAll()

	slot0.lastSelect = nil
	slot0.itemGenDistribution = nil

	Dorm.DormEntityManager.Instance:RemoveEntity(slot0.pan)
	Dorm.DormEntityManager.Instance:RemoveEntity(slot0.chuansongdai)

	slot0.pan = nil
	slot0.chuansongdai = nil

	LianLianKan.AI[DormEnum.CharacterType.RestaurantNormalCustomer].Clear()

	slot4 = uv0.ItemEidNameSpace

	Dorm.storage:ClearData(slot4(DormEnum.ItemType.Pan))

	for slot4, slot5 in ipairs(slot0.entityManagers) do
		slot5:Clear()
	end

	slot0.listener:RemoveAll()
end

function slot0.Start(slot0)
	slot0:GenItemOnStart(slot0.level)
end

function slot0.ResetCurLevel(slot0)
	manager.audio:StopAll()

	slot0.lastSelect = nil
	slot1 = slot0.level

	slot0.previewEntityManager:Clear()
	slot0.itemEntityManager:Clear()
	slot0:GenWorkerEntity(slot1)
	slot0:GenCustomerEntity(slot1)
end

function slot0.RegisterEvents(slot0)
	slot0.listener:Register(DORM_CLICK_ENTITY, handler(slot0, slot0.OnClickEntity))
	slot0.listener:Register(LIANLIANKAN_PREVIEW_APPEAR, handler(slot0, slot0.OnPreviewItemCreate))
	slot0.listener:Register(LIANLIANKAN_AUTO_MATCH, handler(slot0, slot0.AutoMatch))
	slot0.listener:Register(LIANLIANKAN_SHUFFLE, handler(slot0, slot0.Shuffle))
	slot0.listener:Register(LIANLIANKAN_GAME_START, handler(slot0, slot0.Start))
	slot0.listener:Register(LIANLIANKAN_GAME_RESET, handler(slot0, slot0.ResetCurLevel))
	slot0:RegForwardAIEvent(ON_DORM_CHARACTER_WAIT_CMD)
	slot0:RegForwardAIEvent(ON_DORM_CHARACTER_INTERACT)
	slot0:RegForwardAIEvent(LIANLIANKAN_USE_ITEM)
	slot0:RegForwardAIEvent(LIANLIANKAN_ITEM_OVERFLOW)
	slot0:RegForwardAIEvent(LIANLIANKAN_CUSTOMER_EAT, handler(slot0, slot0.GenFoodForCustomer))
	slot0:RegForwardAIEvent(LIANLIANKAN_PREVIEW_REMOVE_ALL, handler(slot0, slot0.ClearItemQueue))
end

function slot0.PlaySoundEffect(slot0, slot1)
	manager.audio:PlayEffect(uv0, slot1)
end

function slot6(slot0, slot1, slot2, slot3)
	slot4 = nil

	if slot3 then
		slot4 = slot0.gridMap:Put(slot3.x, slot3.y, slot2)
		slot2.gridCoord = slot3
	else
		slot5, slot6 = slot0.gridMap:ToCoord(slot0.gridMap:RndPut(slot2))
		slot2.gridCoord = Vector2(slot5, slot6)
	end

	if slot4 then
		slot2.idx = slot4

		return (slot2.isPlaceholder and slot0.placeholderEntityManager or slot0.itemEntityManager):Update(slot4, slot1, slot2), slot4
	end
end

function slot0.AddPlaceHolder(slot0, slot1)
	slot3, slot4 = uv0(slot0, {
		model = slot0.placeholder
	}, {
		itemID = "placeholder",
		isPlaceholder = true
	}, slot1)

	Dorm.DormEntityManager.PutEntityLookToDir(slot3, slot0:GridCoordToPos(Vector2(slot0.gridMap:ToCoord(slot4))), Vector3.forward)
end

function slot7(slot0, slot1, slot2)
	slot3 = {
		Vector2.left,
		Vector2.up,
		Vector2.right,
		Vector2.down
	}
	slot4 = {
		{
			slot1
		}
	}

	while next(slot4) do
		slot5 = table.remove(slot4)
		slot6 = slot5[2]

		for slot11, slot12 in pairs(slot3) do
			if not slot6 or slot6 == slot12 or slot6 + slot12 == Vector2.zero or (slot5[3] or 0) >= slot2 then
				slot14 = slot5[1] + slot12

				if slot0:IsGridInMap(slot14.x, slot14.y) then
					if slot0:IsGridEmpty(slot14.x, slot14.y) then
						return slot14
					elseif slot0:Get(slot14.x, slot14.y).isPlaceholder then
						table.insert(slot4, {
							slot14,
							slot12,
							slot13 and slot7 + 1 or slot7
						})
					end
				end
			end
		end
	end
end

function slot0.Add2Item(slot0, slot1)
	slot5 = uv0(slot0, {
		pooled = true,
		model = slot0.itemModel
	}, {
		itemID = slot1
	})
	slot6 = nil

	if slot0.itemEntityManager.managedEntityNum == 0 then
		slot6 = uv1(slot0.gridMap, slot4.gridCoord, 2)
	end

	slot7 = uv0(slot0, slot2, {
		itemID = slot1
	}, slot6)
end

function slot0.OnPreviewItemCreate(slot0)
	if slot0.previewItemQueueCap <= slot0.previewEntityManager.managedEntityNum then
		slot0:FlushPreviewItem()

		if slot0:Find() == nil then
			slot0:Shuffle()
		end
	end

	slot0:GenPreviewItem()
end

function slot0.FlushPreviewItem(slot0)
	while slot0.gridMap:HasGridEmpty(2) and #slot0.itemQueue > 0 do
		slot1 = table.remove(slot0.itemQueue, 1)

		slot0.itemGenDistribution:Pop(slot1, 2)
		slot0:Add2Item(slot1)
	end

	slot0:ClearItemQueue(true)

	if #slot0.itemQueue > 0 then
		manager.notify:Invoke(LIANLIANKAN_ITEM_OVERFLOW, slot1)
	end
end

function slot0.PrepareNextGenQueue(slot0)
	slot0.itemQueue = slot0.itemGenDistribution:Peek(slot0.previewItemQueueCap, 2)
end

function slot0.GenFoodForCustomer(slot0, slot1)
	if slot0.customerFoodEntityManager:GetEntityID(slot1) == nil then
		slot2:Create(slot1, {
			pooled = true,
			model = slot0.foodModel,
			type = DormEnum.ItemType.Food,
			spawnAt = slot1
		})
	end
end

function slot0.GenPreviewItem(slot0)
	slot2 = slot0.previewEntityManager.managedEntityNum + 1

	slot0.previewEntityManager:Update(slot2, {
		complex = true,
		pooled = true,
		model = slot0.itemPreview
	}, {
		itemID = slot0.itemQueue[slot2]
	})
end

slot8 = 1

function slot0.GridCoordToPos(slot0, slot1)
	slot7 = uv0 * 0.5

	return slot0.gridCoordOrigin.position - Vector3(slot1.x - 0.5 * slot0.gridMap.width, 0, slot1.y - 0.5 * slot0.gridMap.height) * slot7 - Vector3(slot7 * 0.5, 0, slot7 * 0.5)
end

function slot0.ItemEidNameSpace(slot0)
	return "lianliankan.item." .. slot0 .. ".eid"
end

function slot0.OnItemCreate(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot4.itemID

	Dorm.storage:RecordData(uv0.ItemEidNameSpace(slot5), slot1, slot2)
	Dorm.LuaBridge.MiniGameBridge.SetupClickTriggerForEntity(slot2, uv1)

	slot7 = ActivityLinkGameCellCfg[slot5]

	Dorm.LuaBridge.MiniGameBridge.SetupItemSprite(slot2, slot7.path .. "/" .. slot7.album_id)
	slot0:SetItemHighlight(slot2, false)
	Dorm.DormEntityManager.PutEntityLookToDir(slot2, slot0:GridCoordToPos(slot4.gridCoord), Vector3.forward)
	Dorm.DormEntityManager.PlayEffectDetached(slot2, "root", uv2.itemEnter, 0.7)
end

function slot0.OnItemRemoved(slot0, slot1, slot2)
	Dorm.LuaBridge.MiniGameBridge.MuteClickTriggerForEntity(slot2)
	Dorm.storage:RecordData(uv0.ItemEidNameSpace(DormUtils.GetEntityData(slot2).itemID), slot1, nil)
	slot0.gridMap:RemoveByIdx(slot1)
end

function slot0.SetItemHighlight(slot0, slot1, slot2)
	Dorm.DormEntityManager.SetHighlighted(slot1, slot2)

	if slot2 then
		Dorm.DormEntityManager.GrabItemPartCMD(slot1, slot1, "gezi_normal", "gua_hide")
		Dorm.DormEntityManager.GrabItemPartCMD(slot1, slot1, "gezi_highlight", "root")
	else
		Dorm.DormEntityManager.RestoreItemPartCMD(slot1, "gezi_normal")
		Dorm.DormEntityManager.RestoreItemPartCMD(slot1, "gezi_highlight")
	end
end

function slot0.Find(slot0)
	for slot4, slot5 in pairs(slot0.itemGenDistribution.weights) do
		slot6 = {}
		slot10 = slot0.ItemEidNameSpace(slot4)
		slot11 = pairs

		for slot10, slot11 in Dorm.storage:ForeachData(slot10, slot11) do
			table.insert(slot6, slot11)
		end

		for slot10 = 1, #slot6 - 1 do
			for slot14 = slot10 + 1, #slot6 do
				if slot0:TestConnectivity(DormUtils.GetEntityData(slot6[slot10]).gridCoord, DormUtils.GetEntityData(slot6[slot14]).gridCoord) then
					return slot21, slot19, slot20
				end
			end
		end
	end

	return nil
end

function slot0.Shuffle(slot0)
	ShowTips("LIANLIANKAN_NO_SOLUTION_SHUFFLE")

	slot1 = {}

	for slot5, slot6 in pairs(slot0.itemEntityManager.managed) do
		slot1[slot7.itemID] = (slot1[DormUtils.GetEntityData(slot6).itemID] or 0) + 1
	end

	for slot5, slot6 in pairs(slot1) do
		-- Nothing
	end

	slot0.itemEntityManager:Clear()

	while next(slot1) do
		for slot5, slot6 in pairs(slot1) do
			slot0:Add2Item(slot5)

			if slot6 > 2 then
				slot1[slot5] = slot6 - 2
			else
				slot1[slot5] = nil
			end
		end
	end
end

function slot0.QueryEntityID(slot0, slot1, slot2)
	return slot0.itemEntityManager:GetEntityID(slot0.gridMap:ToIdx(slot1, slot2))
end

function slot0.AutoMatch(slot0)
	slot1, slot2, slot3 = slot0:Find()

	slot0:OnConnectItemSuccess(slot1, slot0:QueryEntityID(slot2.x, slot2.y), slot0:QueryEntityID(slot3.x, slot3.y), slot0.gridMap:Get(slot2.x, slot2.y), slot0.gridMap:Get(slot3.x, slot3.y))
end

function slot0.TestConnectivity(slot0, slot1, slot2)
	return LianLianKanUtil.TestConnectivity(slot0.gridMap, slot1.x, slot1.y, slot2.x, slot2.y, slot0.turn)
end

function slot0.OnClickEntity(slot0, slot1)
	if slot0.lastSelect == nil then
		slot0:SetItemHighlight(slot1, true)

		slot0.lastSelect = slot1

		slot0:PlaySoundEffect(uv0.Select)
	elseif slot1 == slot0.lastSelect then
		slot0:SetItemHighlight(slot1, false)

		slot0.lastSelect = nil

		slot0:PlaySoundEffect(uv0.CancelSelect)
	else
		slot6 = nil

		if DormUtils.GetEntityData(slot0.lastSelect).itemID == DormUtils.GetEntityData(slot1).itemID then
			slot6 = slot0:TestConnectivity(slot2.gridCoord, slot3.gridCoord)
		end

		if slot6 then
			slot0:OnConnectItemSuccess(slot6, slot0.lastSelect, slot1, slot2, slot3)
		else
			Dorm.DormEntityManager.PlayEffect(slot0.lastSelect, "root", uv1.itemNotMatch, 0.6)
			Dorm.DormEntityManager.PlayEffect(slot1, "root", uv1.itemNotMatch, 0.6)
			slot0:SetItemHighlight(slot0.lastSelect, false)
			slot0:PlaySoundEffect(uv0.ItemNotMatch)
		end

		slot0.lastSelect = nil
	end
end

slot9 = Vector3(0, 0.25, 0)

function slot0.OnConnectItemSuccess(slot0, slot1, slot2, slot3, slot4, slot5)
	slot7 = slot5.gridCoord
	slot13 = uv0
	slot12 = slot0:GridCoordToPos(slot4.gridCoord) + slot13

	table.insert({}, slot12)

	for slot12, slot13 in ipairs(slot1) do
		table.insert(slot8, slot0:GridCoordToPos(slot13) + uv0)
	end

	table.insert(slot8, slot0:GridCoordToPos(slot7) + uv0)
	Dorm.LuaBridge.MiniGameBridge.ShowConnectLine(slot8, 0.3)
	slot0.itemGenDistribution:Return(slot4.itemID, 2)
	manager.notify:Invoke(LIANLIANKAN_ITEM_MATCH, slot4.itemID)
	Dorm.DormEntityManager.PlayEffectDetached(slot2, "gua_fx", uv1.itemRemove, 0.5)
	Dorm.DormEntityManager.PlayEffectDetached(slot3, "gua_fx", uv1.itemRemove, 0.5)
	slot0:PlaySoundEffect(uv2.ItemMatch)
	slot0.itemEntityManager:Remove(slot4.idx)
	slot0.itemEntityManager:Remove(slot5.idx)

	if slot0.itemEntityManager.managedEntityNum == 0 then
		manager.notify:Invoke(LIANLIANKAN_GAME_CLEAR)
	elseif slot0:Find() == nil then
		slot0:Shuffle()
	end
end

function slot0.ClearItemQueue(slot0, slot1)
	if slot1 then
		slot0:PrepareNextGenQueue()
	end

	if slot0.previewEntityManager.managedEntityNum > 0 then
		Dorm.DormEntityManager.PlayEffectDetached(slot0.chuansongdai, "gua_flush_fx", uv0.previewItemRemove, 1)
		slot0:PlaySoundEffect(uv1.ItemPreviewClear)
	end

	slot0.previewEntityManager:Clear()
end

slot10 = {
	DormEnum.CharacterType.RestaurantCook,
	DormEnum.CharacterType.RestaurantWaiter,
	DormEnum.CharacterType.RestaurantCashier
}

function slot0.GenItemOnStart(slot0, slot1)
	slot0.itemGenDistribution = slot0:PrepareGenDistribution(slot1)

	slot0:ClearItemQueue(true)
	slot0.itemEntityManager:Clear()

	while slot0.gridMap:HasGridEmpty(2) do
		slot0:Add2Item(slot0.itemGenDistribution:Take(2))
	end
end

function slot0.GenWorkerEntity(slot0, slot1)
	for slot6, slot7 in ipairs(uv0) do
		slot8 = ActivityLinkGameCfg[slot1].hero_id[slot6]

		if LianLianKan.AI[slot7] then
			slot10.SetEntity(slot0.workerEntityManager:Update(slot6, {
				spawnAt = 1,
				complex = true,
				model = "CharDorm/" .. BackHomeHeroSkinCfg[slot8].model,
				type = slot7
			}, {
				cfgID = slot8
			}))
		end
	end
end

function slot0.GenCustomerEntity(slot0, slot1)
	for slot6, slot7 in ipairs(ActivityLinkGameCfg[slot1].customer_id) do
		slot8 = DormEnum.CharacterType.RestaurantNormalCustomer

		LianLianKan.AI[slot8].SetEntity(slot6, slot0.customerEntityManager:Update(slot6, {
			complex = true,
			model = "CharDorm/" .. BackHomeHeroSkinCfg[slot7].model,
			type = slot8,
			spawnAt = slot6
		}, {
			cfgID = slot7
		}))
	end
end

function slot0.PrepareGenDistribution(slot0, slot1)
	return LianLianKanItemGen.New(slot0.gridMap.width * slot0.gridMap.height, ActivityLinkGameCfg[slot1].food_weight)
end

function slot0.ForwardToAI(slot0, ...)
	for slot4, slot5 in pairs(LianLianKan.AI) do
		if nullable(slot5, "events", slot0) then
			slot6(...)
		end
	end
end

return slot0
