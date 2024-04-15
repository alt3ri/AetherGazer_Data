slot0 = {
	STATION = 961103,
	STRIGHT_RAIL = 961104,
	TURN_RAIL = 961105,
	STRIGHT_RAIL_APPROACH_SPAN = 961106,
	STRIGHT_RAIL_APPROACH_SPAN_2 = 961108,
	STRIGHT_RAIL_HIGH_BRIDGE = 961107
}
slot1 = {
	slot0.STATION,
	slot0.STRIGHT_RAIL,
	slot0.TURN_RAIL,
	slot0.STRIGHT_RAIL_APPROACH_SPAN,
	slot0.STRIGHT_RAIL_APPROACH_SPAN_2,
	slot0.STRIGHT_RAIL_HIGH_BRIDGE
}
slot2 = class("RailController")
slot3 = "CharDorm/prop/huochetou"
slot4 = "CharDorm/prop/huochexiang"

function slot2.Ctor(slot0, slot1)
	slot0.path = slot1
	slot0.trainMgr = EntityManager.New(EntityManager.CreateModel.New(uv0.TrainModelGetter))
end

function slot2.TrainModelGetter(slot0)
	if slot0.cartID == 1 then
		return uv0
	end

	return uv1
end

function slot2.HasTrainStarted(slot0)
	return slot0.trainMgr:EntityNum() > 0
end

function slot2.GenerateTrain(slot0, slot1)
	for slot5 = 1, slot1 do
		slot6 = slot0.trainMgr:Update(slot5, {
			complex = true,
			cartID = slot5
		}, {
			interactEntities = {}
		})
	end

	return slot0.trainMgr.managed
end

function slot2.ClearTrain(slot0)
	slot0.trainMgr:Clear()
end

function slot2.GetTrainEID(slot0, slot1)
	return slot0.trainMgr:GetEntityID(slot1)
end

function slot2.GetTrainCartNum(slot0)
	return slot0.trainMgr:EntityNum()
end

function slot2.FindClosestPointOnRail(slot0, slot1)
	return DormLuaBridge.FindClosestPointOnPath(slot1, slot0.path)
end

function slot0.Match(slot0, slot1, slot2)
	slot4 = DormUtils.GetEntityData(slot0)

	for slot8, slot9 in pairs(slot1) do
		if uv0.RailMatchSuccess(slot0, slot9, function (slot0)
			return slot0 == uv0
		end, slot2, {}) then
			for slot16, slot17 in ipairs(slot10) do
				if DormUtils.GetEntityData(slot17).cfgID == uv0.STATION then
					slot18.rail = uv1.New(DormLuaBridge.MergeConnectFurniturePath(slot0, slot10, true, "rail"))
				end
			end

			return slot10
		end
	end

	slot4.rail = nil
end

function slot0.RailMatchSuccess(slot0, slot1, slot2, slot3, slot4)
	if slot2(slot1) then
		return {
			slot1
		}
	end

	if slot3[slot1] or slot4[slot1] then
		return nil
	end

	if DormUtils.GetEntityData(slot1).connect then
		slot4[slot1] = true

		for slot9, slot10 in pairs(slot5) do
			if slot10 ~= slot0 and uv0.IsRailNode(slot10) and uv0.RailMatchSuccess(slot1, slot10, slot2, slot3, slot4) then
				table.insert(slot11, slot1)

				return slot11
			end
		end

		slot4[slot1] = false
	end
end

function slot0.IsRailNode(slot0)
	return table.keyof(uv0, nullable(DormUtils.GetEntityData(slot0), "cfgID")) ~= nil
end

return slot0
