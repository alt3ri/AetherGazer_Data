slot0 = require("cjson")
slot1 = class("profiler")
slot2 = {}
slot3 = nil

function slot1.Start()
	for slot3, slot4 in pairs(_G) do
		slot5, slot6 = string.find(slot3, "Tools")

		if type(slot4) == "table" and rawget(slot4, "__ctype") ~= nil and slot4.__ctype == 2 then
			if uv0.InstanceOf(slot4, "BaseView") then
				slot4.New = uv0.OverrideConstructor(slot4.New)
			end
		elseif type(slot4) == "table" and rawget(slot4, "_singletonInstance") ~= nil and slot4._singletonInstance ~= nil then
			slot4.GetInstance = uv0.OverrideConstructor(slot4.GetInstance)
		elseif slot5 and type(slot4) == "table" then
			for slot11, slot12 in pairs(slot4) do
				if type(slot12) == "function" then
					slot7[slot11] = uv0.ProfilerDecorator(slot7[slot11], slot3 .. ":" .. slot11)
				end
			end
		elseif type(slot4) == "function" and slot3 ~= "unpack" and slot3 ~= "import" and slot3 ~= "require" and slot3 ~= "module" and slot3 ~= "setmetatable" and slot3 ~= "getmetatable" and slot3 ~= "clone" then
			_G[slot3] = uv0.ProfilerDecorator(slot4, slot3)
		end
	end

	uv1 = os.clock()
end

function slot1.GetStatJson()
	slot0 = {}
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		table.insert(slot1, slot6)
	end

	return uv2.encode({
		infos = slot1,
		seconds = math.floor(os.clock() - (uv1 or 0))
	})
end

function slot1.Reset()
	uv0 = {}
	uv1 = os.clock()
end

function slot1.OverrideConstructor(slot0)
	return function (...)
		slot5 = uv0(...)

		for slot4, slot5 in pairs(getmetatable(slot5).__index) do
			if type(slot5) == "function" then
				slot0[slot4] = uv1.ProfilerDecorator(slot0[slot4], slot0.class.__cname .. ":" .. slot4)
			end
		end

		return slot0
	end
end

function slot1.ProfilerDecorator(slot0, slot1)
	return function (...)
		slot1 = {
			uv0(...)
		}
		slot3 = (os.clock() - os.clock()) * 1000

		if not uv1[uv2] then
			uv1[uv2] = {
				time = 0,
				count = 0,
				name = uv2,
				firstTime = slot3
			}
		end

		uv1[uv2].count = uv1[uv2].count + 1
		uv1[uv2].time = uv1[uv2].time + slot3

		return unpack(slot1)
	end
end

function slot1.InstanceOf(slot0, slot1)
	while slot0 do
		if slot0.__cname == slot1 then
			return true
		end

		slot0 = slot0.super
	end

	return false
end

return slot1
