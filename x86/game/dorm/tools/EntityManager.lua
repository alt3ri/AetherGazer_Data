slot0 = class("EntityManager")
slot1 = class("EntityManager.SpawnImpl")

function slot1.OnSpawn(slot0, slot1)
end

function slot1.OnRemove(slot0, slot1)
	Dorm.DormEntityManager.Instance:RemoveEntity(slot1)
end

function slot2()
	return nil
end

slot3 = class("EntityManager.CreateModel", slot1)

function slot3.Ctor(slot0, slot1, slot2, slot3)
	slot0.modelPathGetter = slot1
	slot0.spawnPosGetter = slot2 or uv0
	slot0.delay = slot3 or 0
end

function slot3.OnSpawn(slot0, slot1)
	return Dorm.DormEntityManager.Instance:SpawnEntity(slot0.modelPathGetter(slot1), slot0.spawnPosGetter(slot1), slot1.complex or false, slot1.pooled or false)
end

function slot3.OnRemove(slot0, slot1, slot2)
	if slot0.delay == nil or slot0.delay == 0 or slot2 then
		Dorm.DormEntityManager.Instance:RemoveEntity(slot1)
	else
		if type(slot0.delay) == "function" then
			slot3 = slot3()
		end

		Dorm.DormEntityManager.Instance:RemoveEntity(slot1, slot3)
	end
end

slot0.CreateModel = slot3
slot4 = class("EntityManager.CreatePlayer", slot1)

function slot4.Ctor(slot0, slot1, slot2)
	slot0.modelPathGetter = slot1
	slot0.spawnPosGetter = slot2 or uv0
end

function slot4.OnSpawn(slot0, slot1)
	return Dorm.DormEntityManager.Instance:SpawnPlayerEntity(slot0.modelPathGetter(slot1), slot0.spawnPosGetter(slot1))
end

slot0.CreatePlayer = slot4
slot5 = class("EntityManager.CreateFurniture", slot1)

function slot5.OnSpawn(slot0, slot1)
	slot2 = slot1.cfgID
	slot3 = slot1.state or 0
	slot4 = nullable(BackHomeFurnitureSubtype, nullable(BackHomeFurnitureSubtype, "get_id_list_by_furniture_cfg", slot2, slot3)) or BackHomeFurniture[slot2]
	slot5 = slot3 ~= 0 and slot4.tile_size or slot4.title
	slot6 = DormLuaBridge.GenerateFurniture(slot2, slot3, slot4.model, slot5[1], slot5[2], slot5[3], slot4.sub_type ~= 0)

	if slot4.display_type ~= 0 then
		DormLuaBridge.SnapWallMountFurniture(slot6)
	end

	return slot6
end

function slot5.OnRemove(slot0, slot1)
	slot3 = false

	if DormUtils.GetEntityData(slot1) then
		slot3 = slot2.noOccupy or false
	end

	DormLuaBridge.RemoveFurniture(slot1, not slot3)
end

slot0.CreateFurniture = slot5
slot6 = class("EntityManager.AttachToModel", slot1)

function slot6.Ctor(slot0, slot1)
	slot0.attachRootGetter = slot1
end

function slot6.OnSpawn(slot0, slot1)
	return Dorm.DormEntityManager.Instance:MakeModelEntity(slot0.attachRootGetter(slot1))
end

slot0.AttachToModel = slot6
slot0.all = {}

setmetatable(slot0.all, {
	__mode = "v"
})

function slot0.Ctor(slot0, slot1, slot2)
	slot0.managedEntityNum = 0
	slot0.managed = {}
	slot0.reverseQuery = {}
	slot0.spawnImpl = slot1
	slot0.dataCtor = slot2

	table.insert(uv0.all, slot0)
end

function slot0.Create(slot0, slot1, slot2, slot3)
	slot4 = slot0.spawnImpl:OnSpawn(slot2)
	slot0.managed[slot1] = slot4
	slot0.reverseQuery[slot4] = slot1
	slot0.managedEntityNum = slot0.managedEntityNum + 1

	if slot0.OnCreate then
		slot0.OnCreate(slot1, slot4, slot2, slot0:RecordNewEntityData(slot1, slot4, slot3 or slot2))
	end

	return slot4
end

function slot0.Reload(slot0, slot1, slot2, slot3)
	if slot0.reverseQuery[slot2] == nil then
		slot0.managedEntityNum = slot0.managedEntityNum + 1
	else
		slot1 = slot4
	end

	slot0.managed[slot1] = slot2
	slot0.reverseQuery[slot2] = slot1

	slot0:RecordNewEntityData(slot1, slot2, slot3)
end

function slot0.Remove(slot0, slot1)
	if slot0.managed[slot1] then
		if slot0.OnRemove then
			slot0.OnRemove(slot1, slot2)
		end

		slot0.spawnImpl:OnRemove(slot2)
		slot0:RemoveEntityData(slot2)

		slot0.managed[slot1] = nil
		slot0.reverseQuery[slot2] = nil
		slot0.managedEntityNum = slot0.managedEntityNum - 1
	end

	return slot2
end

function slot0.Update(slot0, slot1, slot2, slot3)
	slot5 = nil

	if slot0.managed[slot1] then
		slot0:Remove(slot1)
	end

	if slot2 then
		slot5 = slot0:Create(slot1, slot2, slot3)
	end

	return slot5, slot4
end

function slot0.GetEntityID(slot0, slot1)
	return slot0.managed[slot1]
end

function slot0.Find(slot0, slot1)
	return slot0.reverseQuery[slot1]
end

function slot0.Clear(slot0, slot1)
	for slot5, slot6 in pairs(slot0.managed) do
		if slot0.OnRemove then
			slot0.OnRemove(slot5, slot6)
		end

		slot0:RemoveEntityData(slot6)
		slot0.spawnImpl:OnRemove(slot6, slot1)

		slot0.managed[slot5] = nil
		slot0.reverseQuery[slot6] = nil
	end

	slot0.managedEntityNum = 0
end

function slot0.EntityNum(slot0)
	return slot0.managedEntityNum
end

function slot0.RecordNewEntityData(slot0, slot1, slot2, slot3)
	slot4 = DormEnum.Namespace.EntityData

	if slot0.dataCtor then
		slot3 = slot0.dataCtor(slot1, slot2, slot3)
	end

	Dorm.storage:RecordData(slot4, slot2, slot3 or {})

	return slot3
end

function slot0.RemoveAllEntityData(slot0)
	for slot4, slot5 in pairs(slot0.managed) do
		slot0:RemoveEntityData(slot5)
	end
end

function slot0.RemoveEntityData(slot0, slot1)
	Dorm.storage:RecordData(DormEnum.Namespace.EntityData, slot1, nil)
end

function slot0.MapToDormStorageData(slot0, slot1, slot2)
	if slot1 then
		Dorm.storage:MapToData(slot1, slot0.managed)
	end

	if slot2 then
		Dorm.storage:MapToData(slot2, slot0.reverseQuery)
	end
end

function slot0.FindAndRemoveEntity(slot0, slot1)
	for slot5, slot6 in pairs(slot0) do
		if slot6:Find(slot1) then
			return slot6:Remove(slot7)
		end
	end
end

function slot0.ValidateEntity(slot0, slot1)
	for slot5, slot6 in pairs(slot0) do
		if slot6:Find(slot1) then
			return slot7, slot6
		end
	end
end

return slot0
