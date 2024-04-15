local var_0_0 = singletonClass("LianLianKanGameManager")
local var_0_1 = {
	previewItemRemove = "Dorm/Effect/lianliankan/Fx_daoju_cx",
	itemNotMatch = "Dorm/Effect/lianliankan/Fx_effect_cuowu",
	itemEnter = "Dorm/Effect/lianliankan/Fx_effect_cai_xinzeng",
	itemRemove = "Dorm/Effect/lianliankan/Fx_gezi_effect"
}
local var_0_2 = "minigame_activity_2_1"
local var_0_3 = {
	ItemNotMatch = "minigame_activity_2_1_connect_fail",
	ItemPreviewClear = "minigame_activity_2_1_connect_tool02",
	Select = "minigame_activity_2_1_connect_choose",
	ItemMatch = "minigame_activity_2_1_connect_link",
	CancelSelect = "minigame_activity_2_1_connect_cancel"
}

local function var_0_4(arg_1_0)
	return arg_1_0.model
end

local function var_0_5(arg_2_0)
	if arg_2_0.type ~= nil then
		local var_2_0 = "lianliankan.pos." .. arg_2_0.type
		local var_2_1 = Dorm.storage:GetData(var_2_0, "#") or 0

		if var_2_1 ~= 0 then
			local var_2_2 = ((arg_2_0.spawnAt or 1) - 1) % var_2_1 + 1
			local var_2_3 = Dorm.storage:GetData(var_2_0, var_2_2) or Dorm.storage:PickData(var_2_0)

			return nullable(var_2_3, "transform")
		end
	end
end

function var_0_0.Ctor(arg_3_0)
	arg_3_0.previewItemQueueCap = 10
	arg_3_0.entityManagers = {}

	local var_3_0 = EntityManager.CreateModel.New(var_0_4, var_0_5)
	local var_3_1 = EntityManager.CreateModel.New(var_0_4, var_0_5, 0.4)

	arg_3_0.placeholderEntityManager = EntityManager.New(var_3_0)
	arg_3_0.itemEntityManager = EntityManager.New(var_3_0)
	arg_3_0.customerFoodEntityManager = EntityManager.New(var_3_0)
	arg_3_0.previewEntityManager = EntityManager.New(var_3_1)
	arg_3_0.customerEntityManager = EntityManager.New(var_3_0)
	arg_3_0.workerEntityManager = EntityManager.New(var_3_0)

	table.insert(arg_3_0.entityManagers, arg_3_0.placeholderEntityManager)
	table.insert(arg_3_0.entityManagers, arg_3_0.itemEntityManager)
	table.insert(arg_3_0.entityManagers, arg_3_0.customerFoodEntityManager)
	table.insert(arg_3_0.entityManagers, arg_3_0.previewEntityManager)
	table.insert(arg_3_0.entityManagers, arg_3_0.customerEntityManager)
	table.insert(arg_3_0.entityManagers, arg_3_0.workerEntityManager)

	arg_3_0.itemEntityManager.OnCreate = handler(arg_3_0, arg_3_0.OnItemCreate)
	arg_3_0.itemEntityManager.OnRemove = handler(arg_3_0, arg_3_0.OnItemRemoved)

	function arg_3_0.customerFoodEntityManager.OnCreate(arg_4_0)
		DormCharacterActionManager.taskRunner:NewTask():WaitForSec(5):Then(function()
			arg_3_0.customerFoodEntityManager:Remove(arg_4_0)
		end):Start()
	end

	function arg_3_0.previewEntityManager.OnCreate(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		local var_6_0 = Dorm.storage:GetData("lianliankan.path.preview", arg_6_0)

		Dorm.DormEntityManager.SetEntitySpeed(arg_6_1, 0.5)
		DormUtils.MoveByPath(arg_6_1, var_6_0, true)

		local var_6_1 = ActivityLinkGameCellCfg[arg_6_3.itemID]

		Dorm.LuaBridge.MiniGameBridge.SetupItemSprite(arg_6_1, var_6_1.path .. "/" .. var_6_1.album_id)
	end

	function arg_3_0.customerEntityManager.OnCreate(arg_7_0, arg_7_1)
		Dorm.DormEntityManager.ChangeEntityAnimeScheme(arg_7_1, "sit")
	end

	arg_3_0.listener = EventListener.New()
	arg_3_0.placeholder = "Dorm/Dormitory/HZ07_placeholder"
	arg_3_0.itemModel = "Dorm/Dormitory/HZ07_xuheng1_gezi"
	arg_3_0.itemPreview = "Dorm/Dormitory/HZ07_item_preview"
	arg_3_0.foodModel = "Dorm/Food/120"
	arg_3_0.turn = 2
end

var_0_0.ItemQueueNamespace = "lianliankan.itemQueue"

function var_0_0.RegForwardAIEvent(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.listener:Register(arg_8_1, function(...)
		arg_8_0.ForwardToAI(arg_8_1, ...)

		if arg_8_2 then
			arg_8_2(...)
		end
	end)
end

function var_0_0.Init(arg_10_0, arg_10_1)
	arg_10_0.level = arg_10_1
	arg_10_0.gridMap = GridMap.New(8, 7)

	arg_10_0:RegisterEvents()

	arg_10_0.gridCoordOrigin = Dorm.storage:PickData("lianliankan.pos.origin").transform

	local var_10_0 = Dorm.storage:PickData("lianliankan.pos.Pan").transform
	local var_10_1 = Dorm.storage:PickData("lianliankan.pos.chuansongdai").transform

	arg_10_0.pan = Dorm.DormEntityManager.Instance:MakeModelEntity(var_10_0)
	arg_10_0.chuansongdai = Dorm.DormEntityManager.Instance:MakeModelEntity(var_10_1)

	Dorm.storage:RecordData(var_0_0.ItemEidNameSpace(DormEnum.ItemType.Pan), 1, arg_10_0.pan)
	arg_10_0.previewEntityManager:MapToDormStorageData(arg_10_0.ItemQueueNamespace, nil)

	local var_10_2 = DormUtils.EIdNamespace(DormEnum.CharacterType.RestaurantNormalCustomer)

	arg_10_0.customerEntityManager:MapToDormStorageData(var_10_2, nil)
	arg_10_0:GenWorkerEntity(arg_10_1)
	arg_10_0:GenCustomerEntity(arg_10_1)

	local var_10_3 = ActivityLinkGameCfg[arg_10_1]

	arg_10_0.placeholderEntityManager:Clear()

	for iter_10_0, iter_10_1 in ipairs(var_10_3.blank_pos) do
		local var_10_4 = Vector2(unpack(iter_10_1))

		arg_10_0:AddPlaceHolder(var_10_4)
	end
end

function var_0_0.Reset(arg_11_0)
	manager.audio:StopAll()

	arg_11_0.lastSelect = nil
	arg_11_0.itemGenDistribution = nil

	Dorm.DormEntityManager.Instance:RemoveEntity(arg_11_0.pan)
	Dorm.DormEntityManager.Instance:RemoveEntity(arg_11_0.chuansongdai)

	arg_11_0.pan = nil
	arg_11_0.chuansongdai = nil

	LianLianKan.AI[DormEnum.CharacterType.RestaurantNormalCustomer].Clear()
	Dorm.storage:ClearData(var_0_0.ItemEidNameSpace(DormEnum.ItemType.Pan))

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.entityManagers) do
		iter_11_1:Clear()
	end

	arg_11_0.listener:RemoveAll()
end

function var_0_0.Start(arg_12_0)
	arg_12_0:GenItemOnStart(arg_12_0.level)
end

function var_0_0.ResetCurLevel(arg_13_0)
	manager.audio:StopAll()

	arg_13_0.lastSelect = nil

	local var_13_0 = arg_13_0.level

	arg_13_0.previewEntityManager:Clear()
	arg_13_0.itemEntityManager:Clear()
	arg_13_0:GenWorkerEntity(var_13_0)
	arg_13_0:GenCustomerEntity(var_13_0)
end

function var_0_0.RegisterEvents(arg_14_0)
	arg_14_0.listener:Register(DORM_CLICK_ENTITY, handler(arg_14_0, arg_14_0.OnClickEntity))
	arg_14_0.listener:Register(LIANLIANKAN_PREVIEW_APPEAR, handler(arg_14_0, arg_14_0.OnPreviewItemCreate))
	arg_14_0.listener:Register(LIANLIANKAN_AUTO_MATCH, handler(arg_14_0, arg_14_0.AutoMatch))
	arg_14_0.listener:Register(LIANLIANKAN_SHUFFLE, handler(arg_14_0, arg_14_0.Shuffle))
	arg_14_0.listener:Register(LIANLIANKAN_GAME_START, handler(arg_14_0, arg_14_0.Start))
	arg_14_0.listener:Register(LIANLIANKAN_GAME_RESET, handler(arg_14_0, arg_14_0.ResetCurLevel))
	arg_14_0:RegForwardAIEvent(ON_DORM_CHARACTER_WAIT_CMD)
	arg_14_0:RegForwardAIEvent(ON_DORM_CHARACTER_INTERACT)
	arg_14_0:RegForwardAIEvent(LIANLIANKAN_USE_ITEM)
	arg_14_0:RegForwardAIEvent(LIANLIANKAN_ITEM_OVERFLOW)
	arg_14_0:RegForwardAIEvent(LIANLIANKAN_CUSTOMER_EAT, handler(arg_14_0, arg_14_0.GenFoodForCustomer))
	arg_14_0:RegForwardAIEvent(LIANLIANKAN_PREVIEW_REMOVE_ALL, handler(arg_14_0, arg_14_0.ClearItemQueue))
end

function var_0_0.PlaySoundEffect(arg_15_0, arg_15_1)
	manager.audio:PlayEffect(var_0_2, arg_15_1)
end

local function var_0_6(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0

	if arg_16_3 then
		var_16_0 = arg_16_0.gridMap:Put(arg_16_3.x, arg_16_3.y, arg_16_2)
		arg_16_2.gridCoord = arg_16_3
	else
		var_16_0 = arg_16_0.gridMap:RndPut(arg_16_2)

		local var_16_1, var_16_2 = arg_16_0.gridMap:ToCoord(var_16_0)

		arg_16_2.gridCoord = Vector2(var_16_1, var_16_2)
	end

	if var_16_0 then
		arg_16_2.idx = var_16_0

		return (arg_16_2.isPlaceholder and arg_16_0.placeholderEntityManager or arg_16_0.itemEntityManager):Update(var_16_0, arg_16_1, arg_16_2), var_16_0
	end
end

function var_0_0.AddPlaceHolder(arg_17_0, arg_17_1)
	local var_17_0 = {
		model = arg_17_0.placeholder
	}
	local var_17_1, var_17_2 = var_0_6(arg_17_0, var_17_0, {
		itemID = "placeholder",
		isPlaceholder = true
	}, arg_17_1)

	Dorm.DormEntityManager.PutEntityLookToDir(var_17_1, arg_17_0:GridCoordToPos(Vector2(arg_17_0.gridMap:ToCoord(var_17_2))), Vector3.forward)
end

local function var_0_7(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = {
		Vector2.left,
		Vector2.up,
		Vector2.right,
		Vector2.down
	}
	local var_18_1 = {
		{
			arg_18_1
		}
	}

	while next(var_18_1) do
		local var_18_2 = table.remove(var_18_1)
		local var_18_3 = var_18_2[2]
		local var_18_4 = var_18_2[3] or 0

		for iter_18_0, iter_18_1 in pairs(var_18_0) do
			local var_18_5 = var_18_3 and var_18_3 ~= iter_18_1 and var_18_3 + iter_18_1 ~= Vector2.zero

			if not var_18_5 or not (var_18_4 < arg_18_2) then
				local var_18_6 = var_18_2[1] + iter_18_1

				if arg_18_0:IsGridInMap(var_18_6.x, var_18_6.y) then
					if arg_18_0:IsGridEmpty(var_18_6.x, var_18_6.y) then
						return var_18_6
					elseif arg_18_0:Get(var_18_6.x, var_18_6.y).isPlaceholder then
						table.insert(var_18_1, {
							var_18_6,
							iter_18_1,
							var_18_5 and var_18_4 + 1 or var_18_4
						})
					end
				end
			end
		end
	end
end

function var_0_0.Add2Item(arg_19_0, arg_19_1)
	local var_19_0 = {
		pooled = true,
		model = arg_19_0.itemModel
	}
	local var_19_1 = arg_19_0.itemEntityManager.managedEntityNum == 0
	local var_19_2 = {
		itemID = arg_19_1
	}
	local var_19_3 = var_0_6(arg_19_0, var_19_0, var_19_2)
	local var_19_4

	if var_19_1 then
		var_19_4 = var_0_7(arg_19_0.gridMap, var_19_2.gridCoord, 2)
	end

	local var_19_5 = var_0_6(arg_19_0, var_19_0, {
		itemID = arg_19_1
	}, var_19_4)
end

function var_0_0.OnPreviewItemCreate(arg_20_0)
	if arg_20_0.previewEntityManager.managedEntityNum >= arg_20_0.previewItemQueueCap then
		arg_20_0:FlushPreviewItem()

		if arg_20_0:Find() == nil then
			arg_20_0:Shuffle()
		end
	end

	arg_20_0:GenPreviewItem()
end

function var_0_0.FlushPreviewItem(arg_21_0)
	while arg_21_0.gridMap:HasGridEmpty(2) and #arg_21_0.itemQueue > 0 do
		local var_21_0 = table.remove(arg_21_0.itemQueue, 1)

		arg_21_0.itemGenDistribution:Pop(var_21_0, 2)
		arg_21_0:Add2Item(var_21_0)
	end

	local var_21_1 = arg_21_0.itemQueue

	arg_21_0:ClearItemQueue(true)

	if #var_21_1 > 0 then
		manager.notify:Invoke(LIANLIANKAN_ITEM_OVERFLOW, var_21_1)
	end
end

function var_0_0.PrepareNextGenQueue(arg_22_0)
	arg_22_0.itemQueue = arg_22_0.itemGenDistribution:Peek(arg_22_0.previewItemQueueCap, 2)
end

function var_0_0.GenFoodForCustomer(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.customerFoodEntityManager

	if var_23_0:GetEntityID(arg_23_1) == nil then
		var_23_0:Create(arg_23_1, {
			pooled = true,
			model = arg_23_0.foodModel,
			type = DormEnum.ItemType.Food,
			spawnAt = arg_23_1
		})
	end
end

function var_0_0.GenPreviewItem(arg_24_0)
	local var_24_0 = {
		complex = true,
		pooled = true,
		model = arg_24_0.itemPreview
	}
	local var_24_1 = arg_24_0.previewEntityManager.managedEntityNum + 1

	arg_24_0.previewEntityManager:Update(var_24_1, var_24_0, {
		itemID = arg_24_0.itemQueue[var_24_1]
	})
end

local var_0_8 = 1

function var_0_0.GridCoordToPos(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1.x
	local var_25_1 = arg_25_1.y
	local var_25_2 = arg_25_0.gridCoordOrigin.position
	local var_25_3 = arg_25_0.gridMap.width
	local var_25_4 = arg_25_0.gridMap.height
	local var_25_5 = var_0_8 * 0.5

	return var_25_2 - Vector3(var_25_0 - 0.5 * var_25_3, 0, var_25_1 - 0.5 * var_25_4) * var_25_5 - Vector3(var_25_5 * 0.5, 0, var_25_5 * 0.5)
end

function var_0_0.ItemEidNameSpace(arg_26_0)
	return "lianliankan.item." .. arg_26_0 .. ".eid"
end

function var_0_0.OnItemCreate(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = arg_27_4.itemID
	local var_27_1 = var_0_0.ItemEidNameSpace(var_27_0)

	Dorm.storage:RecordData(var_27_1, arg_27_1, arg_27_2)
	Dorm.LuaBridge.MiniGameBridge.SetupClickTriggerForEntity(arg_27_2, var_0_8)

	local var_27_2 = ActivityLinkGameCellCfg[var_27_0]

	Dorm.LuaBridge.MiniGameBridge.SetupItemSprite(arg_27_2, var_27_2.path .. "/" .. var_27_2.album_id)
	arg_27_0:SetItemHighlight(arg_27_2, false)
	Dorm.DormEntityManager.PutEntityLookToDir(arg_27_2, arg_27_0:GridCoordToPos(arg_27_4.gridCoord), Vector3.forward)
	Dorm.DormEntityManager.PlayEffectDetached(arg_27_2, "root", var_0_1.itemEnter, 0.7)
end

function var_0_0.OnItemRemoved(arg_28_0, arg_28_1, arg_28_2)
	Dorm.LuaBridge.MiniGameBridge.MuteClickTriggerForEntity(arg_28_2)

	local var_28_0 = DormUtils.GetEntityData(arg_28_2).itemID
	local var_28_1 = var_0_0.ItemEidNameSpace(var_28_0)

	Dorm.storage:RecordData(var_28_1, arg_28_1, nil)
	arg_28_0.gridMap:RemoveByIdx(arg_28_1)
end

function var_0_0.SetItemHighlight(arg_29_0, arg_29_1, arg_29_2)
	Dorm.DormEntityManager.SetHighlighted(arg_29_1, arg_29_2)

	if arg_29_2 then
		Dorm.DormEntityManager.GrabItemPartCMD(arg_29_1, arg_29_1, "gezi_normal", "gua_hide")
		Dorm.DormEntityManager.GrabItemPartCMD(arg_29_1, arg_29_1, "gezi_highlight", "root")
	else
		Dorm.DormEntityManager.RestoreItemPartCMD(arg_29_1, "gezi_normal")
		Dorm.DormEntityManager.RestoreItemPartCMD(arg_29_1, "gezi_highlight")
	end
end

function var_0_0.Find(arg_30_0)
	for iter_30_0, iter_30_1 in pairs(arg_30_0.itemGenDistribution.weights) do
		local var_30_0 = {}

		for iter_30_2, iter_30_3 in Dorm.storage:ForeachData(arg_30_0.ItemEidNameSpace(iter_30_0), pairs) do
			table.insert(var_30_0, iter_30_3)
		end

		for iter_30_4 = 1, #var_30_0 - 1 do
			for iter_30_5 = iter_30_4 + 1, #var_30_0 do
				local var_30_1 = var_30_0[iter_30_4]
				local var_30_2 = var_30_0[iter_30_5]
				local var_30_3 = DormUtils.GetEntityData(var_30_1)
				local var_30_4 = DormUtils.GetEntityData(var_30_2)
				local var_30_5 = var_30_3.gridCoord
				local var_30_6 = var_30_4.gridCoord
				local var_30_7 = arg_30_0:TestConnectivity(var_30_5, var_30_6)

				if var_30_7 then
					return var_30_7, var_30_5, var_30_6
				end
			end
		end
	end

	return nil
end

function var_0_0.Shuffle(arg_31_0)
	ShowTips("LIANLIANKAN_NO_SOLUTION_SHUFFLE")

	local var_31_0 = {}

	for iter_31_0, iter_31_1 in pairs(arg_31_0.itemEntityManager.managed) do
		local var_31_1 = DormUtils.GetEntityData(iter_31_1)
		local var_31_2 = (var_31_0[var_31_1.itemID] or 0) + 1

		var_31_0[var_31_1.itemID] = var_31_2
	end

	for iter_31_2, iter_31_3 in pairs(var_31_0) do
		-- block empty
	end

	arg_31_0.itemEntityManager:Clear()

	while next(var_31_0) do
		for iter_31_4, iter_31_5 in pairs(var_31_0) do
			arg_31_0:Add2Item(iter_31_4)

			if iter_31_5 > 2 then
				var_31_0[iter_31_4] = iter_31_5 - 2
			else
				var_31_0[iter_31_4] = nil
			end
		end
	end
end

function var_0_0.QueryEntityID(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0.gridMap:ToIdx(arg_32_1, arg_32_2)

	return arg_32_0.itemEntityManager:GetEntityID(var_32_0)
end

function var_0_0.AutoMatch(arg_33_0)
	local var_33_0, var_33_1, var_33_2 = arg_33_0:Find()
	local var_33_3 = arg_33_0.gridMap:Get(var_33_1.x, var_33_1.y)
	local var_33_4 = arg_33_0.gridMap:Get(var_33_2.x, var_33_2.y)
	local var_33_5 = arg_33_0:QueryEntityID(var_33_1.x, var_33_1.y)
	local var_33_6 = arg_33_0:QueryEntityID(var_33_2.x, var_33_2.y)

	arg_33_0:OnConnectItemSuccess(var_33_0, var_33_5, var_33_6, var_33_3, var_33_4)
end

function var_0_0.TestConnectivity(arg_34_0, arg_34_1, arg_34_2)
	return LianLianKanUtil.TestConnectivity(arg_34_0.gridMap, arg_34_1.x, arg_34_1.y, arg_34_2.x, arg_34_2.y, arg_34_0.turn)
end

function var_0_0.OnClickEntity(arg_35_0, arg_35_1)
	if arg_35_0.lastSelect == nil then
		arg_35_0:SetItemHighlight(arg_35_1, true)

		arg_35_0.lastSelect = arg_35_1

		arg_35_0:PlaySoundEffect(var_0_3.Select)
	elseif arg_35_1 == arg_35_0.lastSelect then
		arg_35_0:SetItemHighlight(arg_35_1, false)

		arg_35_0.lastSelect = nil

		arg_35_0:PlaySoundEffect(var_0_3.CancelSelect)
	else
		local var_35_0 = DormUtils.GetEntityData(arg_35_0.lastSelect)
		local var_35_1 = DormUtils.GetEntityData(arg_35_1)
		local var_35_2 = var_35_0.itemID
		local var_35_3 = var_35_1.itemID
		local var_35_4

		if var_35_2 == var_35_3 then
			local var_35_5 = var_35_0.gridCoord
			local var_35_6 = var_35_1.gridCoord

			var_35_4 = arg_35_0:TestConnectivity(var_35_5, var_35_6)
		end

		if var_35_4 then
			arg_35_0:OnConnectItemSuccess(var_35_4, arg_35_0.lastSelect, arg_35_1, var_35_0, var_35_1)
		else
			Dorm.DormEntityManager.PlayEffect(arg_35_0.lastSelect, "root", var_0_1.itemNotMatch, 0.6)
			Dorm.DormEntityManager.PlayEffect(arg_35_1, "root", var_0_1.itemNotMatch, 0.6)
			arg_35_0:SetItemHighlight(arg_35_0.lastSelect, false)
			arg_35_0:PlaySoundEffect(var_0_3.ItemNotMatch)
		end

		arg_35_0.lastSelect = nil
	end
end

local var_0_9 = Vector3(0, 0.25, 0)

function var_0_0.OnConnectItemSuccess(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5)
	local var_36_0 = arg_36_4.gridCoord
	local var_36_1 = arg_36_5.gridCoord
	local var_36_2 = {}

	table.insert(var_36_2, arg_36_0:GridCoordToPos(var_36_0) + var_0_9)

	for iter_36_0, iter_36_1 in ipairs(arg_36_1) do
		table.insert(var_36_2, arg_36_0:GridCoordToPos(iter_36_1) + var_0_9)
	end

	table.insert(var_36_2, arg_36_0:GridCoordToPos(var_36_1) + var_0_9)
	Dorm.LuaBridge.MiniGameBridge.ShowConnectLine(var_36_2, 0.3)
	arg_36_0.itemGenDistribution:Return(arg_36_4.itemID, 2)
	manager.notify:Invoke(LIANLIANKAN_ITEM_MATCH, arg_36_4.itemID)
	Dorm.DormEntityManager.PlayEffectDetached(arg_36_2, "gua_fx", var_0_1.itemRemove, 0.5)
	Dorm.DormEntityManager.PlayEffectDetached(arg_36_3, "gua_fx", var_0_1.itemRemove, 0.5)
	arg_36_0:PlaySoundEffect(var_0_3.ItemMatch)
	arg_36_0.itemEntityManager:Remove(arg_36_4.idx)
	arg_36_0.itemEntityManager:Remove(arg_36_5.idx)

	if arg_36_0.itemEntityManager.managedEntityNum == 0 then
		manager.notify:Invoke(LIANLIANKAN_GAME_CLEAR)
	elseif arg_36_0:Find() == nil then
		arg_36_0:Shuffle()
	end
end

function var_0_0.ClearItemQueue(arg_37_0, arg_37_1)
	if arg_37_1 then
		arg_37_0:PrepareNextGenQueue()
	end

	if arg_37_0.previewEntityManager.managedEntityNum > 0 then
		Dorm.DormEntityManager.PlayEffectDetached(arg_37_0.chuansongdai, "gua_flush_fx", var_0_1.previewItemRemove, 1)
		arg_37_0:PlaySoundEffect(var_0_3.ItemPreviewClear)
	end

	arg_37_0.previewEntityManager:Clear()
end

local var_0_10 = {
	DormEnum.CharacterType.RestaurantCook,
	DormEnum.CharacterType.RestaurantWaiter,
	DormEnum.CharacterType.RestaurantCashier
}

function var_0_0.GenItemOnStart(arg_38_0, arg_38_1)
	arg_38_0.itemGenDistribution = arg_38_0:PrepareGenDistribution(arg_38_1)

	arg_38_0:ClearItemQueue(true)
	arg_38_0.itemEntityManager:Clear()

	while arg_38_0.gridMap:HasGridEmpty(2) do
		local var_38_0 = arg_38_0.itemGenDistribution:Take(2)

		arg_38_0:Add2Item(var_38_0)
	end
end

function var_0_0.GenWorkerEntity(arg_39_0, arg_39_1)
	local var_39_0 = ActivityLinkGameCfg[arg_39_1]

	for iter_39_0, iter_39_1 in ipairs(var_0_10) do
		local var_39_1 = var_39_0.hero_id[iter_39_0]
		local var_39_2 = arg_39_0.workerEntityManager:Update(iter_39_0, {
			spawnAt = 1,
			complex = true,
			model = "CharDorm/" .. BackHomeHeroSkinCfg[var_39_1].model,
			type = iter_39_1
		}, {
			cfgID = var_39_1
		})
		local var_39_3 = LianLianKan.AI[iter_39_1]

		if var_39_3 then
			var_39_3.SetEntity(var_39_2)
		end
	end
end

function var_0_0.GenCustomerEntity(arg_40_0, arg_40_1)
	local var_40_0 = ActivityLinkGameCfg[arg_40_1]

	for iter_40_0, iter_40_1 in ipairs(var_40_0.customer_id) do
		local var_40_1 = DormEnum.CharacterType.RestaurantNormalCustomer
		local var_40_2 = arg_40_0.customerEntityManager:Update(iter_40_0, {
			complex = true,
			model = "CharDorm/" .. BackHomeHeroSkinCfg[iter_40_1].model,
			type = var_40_1,
			spawnAt = iter_40_0
		}, {
			cfgID = iter_40_1
		})

		LianLianKan.AI[var_40_1].SetEntity(iter_40_0, var_40_2)
	end
end

function var_0_0.PrepareGenDistribution(arg_41_0, arg_41_1)
	local var_41_0 = ActivityLinkGameCfg[arg_41_1]
	local var_41_1 = arg_41_0.gridMap.width * arg_41_0.gridMap.height

	return LianLianKanItemGen.New(var_41_1, var_41_0.food_weight)
end

function var_0_0.ForwardToAI(arg_42_0, ...)
	for iter_42_0, iter_42_1 in pairs(LianLianKan.AI) do
		local var_42_0 = nullable(iter_42_1, "events", arg_42_0)

		if var_42_0 then
			var_42_0(...)
		end
	end
end

return var_0_0
