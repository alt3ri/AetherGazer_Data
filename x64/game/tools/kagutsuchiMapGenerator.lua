slot0 = import("game.tools.KagutsuchiMap")

return {
	Ctor = function (slot0)
		slot0.dirty_ = true
	end,
	SetMapSize = function (slot0, slot1, slot2)
		if slot0.width_ == slot1 and slot0.height_ == slot2 then
			return
		end

		slot0.width_ = slot1
		slot0.height_ = slot2
		slot0.dirty_ = true
	end,
	SetMapSeed = function (slot0, slot1)
		if slot0.seed_ == slot1 then
			return
		end

		slot0.seed_ = slot1
		slot0.dirty_ = true
	end,
	SetMapGrids = function (slot0, slot1, slot2, slot3)
		if slot0.transformList_ == slot1 then
			return
		end

		slot0.transformList_ = slot1
		slot4 = uv0.New(slot0.width_, slot0.height_)

		for slot8, slot9 in ipairs(slot1) do
			slot10, slot11 = slot3(slot9)
			slot12 = {
				x = slot10,
				y = slot11,
				transform = slot9,
				idx = slot8
			}

			if slot4:IsOverbound(slot10, slot11) then
				Debug.LogError(string.format("(%d,%d)超出范围", slot10, slot11))
			end

			slot4:PutGrid(slot10, slot11, slot2(slot12))
		end

		slot0.map_ = slot4
		slot0.dirty_ = true
	end,
	GeneratePlaceableGrids = function (slot0, slot1, slot2)
		if not slot0.dirty_ and #slot0.placeableGrids_ == slot1 then
			return slot0.placeableGrids_
		end

		if slot0.map_:GetGridCount() < slot1 then
			Debug.LogError("超出格子数目")
		end

		slot5 = RandomUtil.GenRandom(slot0.seed_)
		slot6 = {}
		slot7 = 0

		for slot11 = 1, slot1 do
			while not slot0:CheckGrid(slot5:NextInt(slot4) + 1) do
				slot12 = slot5:NextInt(slot4) + 1

				if slot7 + 1 > 1000 then
					Debug.LogError("无法生成放置格子")
				end
			end

			slot2({
				grid = slot0.map_:GetGridByIndex(slot12),
				index = slot11
			})
			table.insert(slot6, slot12)
		end

		slot0.placeableGrids_ = slot6
		slot0.dirty_ = false

		return slot6
	end,
	CheckGrid = function (slot0, slot1)
		slot3, slot4 = slot0.map_:GetGridXY(slot1)

		return not slot0:IsGridOccupied(slot3, slot4) and not slot0:IsGridOccupied(slot3 - 1, slot4) and not slot0:IsGridOccupied(slot3 + 1, slot4) and not slot0:IsGridOccupied(slot3, slot4 - 1) and not slot0:IsGridOccupied(slot3, slot4 + 1)
	end,
	IsGridOccupied = function (slot0, slot1, slot2)
		return slot0.map_:GetGrid(slot1, slot2) and slot3.playGrid
	end,
	Clear = function (slot0)
		slot0.transformList_ = nil
		slot0.dirty_ = true
	end
}
