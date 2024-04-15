slot0 = singletonClass("DormFurnitureManager")
slot0.FurnitureState = {
	Placed = 1,
	Editing = 2,
	Hanging = 0
}
slot1 = 0

function slot0.Ctor(slot0)
	slot0.listener = EventListener.New()
	slot0.entityManager = EntityManager.New(EntityManager.CreateFurniture.New(), uv0.dataCtor)
	slot0.nextIdx = uv1
end

function slot0.Init(slot0)
	slot0:RegisterEvent()
end

function slot0.Reset(slot0)
	slot0:RemoveEvent()
end

function slot0.RegisterEvent(slot0)
end

function slot0.RemoveEvent(slot0)
	slot0.listener:RemoveAll()
end

function slot0.OnBeginStory(slot0, slot1)
	if DormEnum.HasFlag(slot1, DormEnum.BeginStoryFlag.HideFurniture) then
		slot0:Clear()
	end
end

function slot0.OnFinishStory(slot0, slot1)
	if DormEnum.HasFlag(slot1, DormEnum.BeginStoryFlag.HideFurniture) then
		DormFurnitureTools:GenerateFurnitureWhenEnterScene()
	end
end

function slot0.Generate(slot0, slot1, slot2)
	slot0.nextIdx = slot0.nextIdx + 1

	return slot0.entityManager:Update(slot0.nextIdx, {
		cfgID = slot1,
		state = slot2 or 0
	})
end

function slot0.Remove(slot0, slot1)
	slot0.entityManager:Remove(slot1)
end

function slot0.Clear(slot0)
	slot0.entityManager:Clear()
	DormLuaBridge.ClearFurnitureOccupy()
	DormLuaBridge.UpdateAllWallMountDitherAlphaControl()

	slot0.nextIdx = uv0

	DormLuaBridge.ClearAllSuitEntity()
end

function slot0.dataCtor(slot0, slot1, slot2)
	slot2 = slot2 or {}
	slot2.interactEntities = {}

	return slot2
end

function slot2(slot0, slot1)
	if slot1 + 1 < slot0.Length then
		return slot1, slot0[slot1]
	end
end

function slot0.ClearAndGenByFurList(slot0, slot1, slot2, slot3)
	slot0:Clear()

	if slot1 then
		if not slot2 then
			DormLuaBridge.SyncRoomFurniture(slot1)
		end

		for slot7, slot8 in uv0, slot1, -1 do
			if not slot2 then
				DormLuaBridge.RecoverRoomFurnitureOccupy(slot7, slot0.entityManager:Create(slot7, {
					cfgID = slot8.id,
					state = slot8.state or 0
				}))
			else
				DormLuaBridge.SetFurniturePosition(slot10, slot8.tileType, slot8.pos, slot8.rotation)
			end

			DormLuaBridge.ChangeFurnitureState(slot10, uv1.FurnitureState.Placed)
		end

		slot0.nextIdx = slot1.Length
	else
		slot0.nextIdx = 0
	end

	if slot3 then
		DormSuitTools:GenerateSuitInfoList(slot3, true)
	end

	DormLuaBridge.UpdateAllWallMountDitherAlphaControl()
	DormLuaBridge.UpdateAllFurnitureInteractAreaEnabled()
	slot0:RefreshAllFurnitureConnection()
end

function slot0.FindAndRemove(slot0)
	EntityManager.FindAndRemoveEntity({
		uv0.GetInstance().entityManager
	}, slot0)
end

function slot0.GetAllFurniture(slot0)
	return slot0.entityManager.managed
end

function slot0.RefreshAllFurnitureConnection(slot0)
	slot0.connectInfo = {}
	slot1 = {}

	for slot5, slot6 in pairs(slot0.entityManager.managed) do
		table.insert(slot1, slot6)

		DormUtils.GetEntityData(slot6).connect = {}
	end

	for slot5 = 1, #slot1 do
		for slot9 = slot5 + 1, #slot1 do
			if DormLuaBridge.CheckFurnitureConnectReady(slot1[slot5], slot1[slot9]) then
				table.insert(DormUtils.GetEntityData(slot10).connect, slot11)
				table.insert(DormUtils.GetEntityData(slot11).connect, slot10)
			end
		end
	end

	DormMultiFurnitureStructureManager.GetInstance():RefreshAllMultiFurnitureStructure(slot1)
end

function Dorm.FurnitureReloadData(slot0, slot1, slot2)
	if uv0.GetInstance().entityManager:Find(slot0) == nil then
		slot4 = slot3.nextIdx
		slot3.nextIdx = slot3.nextIdx + 1
	end

	slot3.entityManager:Reload(slot4, slot0, {
		cfgID = slot1,
		state = slot2 or 0
	})
end

function Dorm.TestRefreshFurnitureConnection()
	uv0.GetInstance():RefreshAllFurnitureConnection()
end

return slot0
