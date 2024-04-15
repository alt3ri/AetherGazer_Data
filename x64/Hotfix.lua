function hotfix(slot0)
	slot1 = nil

	if package.loaded[slot0] then
		slot1 = package.loaded[slot0]
		package.loaded[slot0] = nil
	else
		return
	end

	slot2, slot3 = pcall(require, slot0)

	if not slot2 then
		package.loaded[slot0] = slot1

		return
	end

	update_table(package.loaded[slot0], slot1, {})

	if type(slot1) == "table" and slot1.OnReload ~= nil then
		slot1:OnReload()
	end

	package.loaded[slot0] = slot1
end

function update_func(slot0, slot1)
	slot2 = {}

	for slot6 = 1, math.huge do
		slot7, slot8 = debug.getupvalue(slot1, slot6)

		if not slot7 then
			break
		end

		slot2[slot7] = slot8
	end

	for slot6 = 1, math.huge do
		slot7, slot8 = debug.getupvalue(slot0, slot6)

		if not slot7 then
			break
		end

		if slot2[slot7] then
			debug.setupvalue(slot0, slot6, slot9)
		end
	end
end

function update_table(slot0, slot1, slot2)
	if type(slot0) ~= "table" or type(slot1) ~= "table" then
		return
	end

	for slot6, slot7 in pairs(slot0) do
		if type(slot7) == "function" then
			update_func(slot7, slot1[slot6])

			slot1[slot6] = slot7
		elseif slot9 == "table" and slot2[slot7] == nil then
			slot2[slot7] = true

			update_table(slot7, slot8, slot2)
		end
	end

	slot4 = debug.getmetatable(slot0)

	if type(debug.getmetatable(slot1)) == "table" and type(slot4) == "table" then
		update_table(slot4, slot3, slot2)
	end
end
