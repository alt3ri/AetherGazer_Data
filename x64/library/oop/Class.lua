function clone(slot0)
	slot1 = {}

	return function (slot0)
		if type(slot0) ~= "table" then
			return slot0
		elseif uv0[slot0] then
			return uv0[slot0]
		end

		uv0[slot0] = {}

		for slot5, slot6 in pairs(slot0) do
			slot1[uv1(slot5)] = uv1(slot6)
		end

		return setmetatable(slot1, getmetatable(slot0))
	end(slot0)
end

function class(slot0, slot1)
	slot3 = nil

	if type(slot1) ~= "function" and slot2 ~= "table" then
		slot2 = nil
		slot1 = nil
	end

	if slot2 == "function" or slot1 and slot1.__ctype == 1 then
		slot3 = {}

		if slot2 == "table" then
			for slot7, slot8 in pairs(slot1) do
				slot3[slot7] = slot8
			end

			slot3.__create = slot1.__create
			slot3.super = slot1
		else
			slot3.__create = slot1
		end

		function slot3.Ctor()
		end

		slot3.__cname = slot0
		slot3.__ctype = 1

		function slot3.New(...)
			slot0 = uv0.__create(...)

			for slot4, slot5 in pairs(uv0) do
				slot0[slot4] = slot5
			end

			slot0.class = uv0

			slot0:Ctor(...)

			return slot0
		end
	else
		if slot1 then
			setmetatable({}, slot1).super = slot1
		else
			slot3 = {
				Ctor = function ()
				end
			}
		end

		slot3.__cname = slot0
		slot3.__ctype = 2
		slot3.__index = slot3

		function slot3.New(...)
			slot0 = setmetatable({}, uv0)
			slot0.class = uv0

			slot0:Ctor(...)

			return slot0
		end
	end

	return slot3
end

function partialClass(slot0, slot1, slot2)
	return slot2 or _G[slot0] or class(slot0, slot1)
end

function isa(slot0, slot1)
	slot2 = getmetatable(slot0)

	while slot2 ~= nil do
		if slot2 == slot1 then
			return true
		else
			slot2 = getmetatable(slot2)
		end
	end

	return false
end

function singletonClass(slot0, slot1)
	slot2 = class(slot0, slot1)
	slot2._new = slot2.New

	rawset(slot2, "_singletonInstance", nil)

	function slot2.New()
		if not uv0._singletonInstance then
			return uv0.GetInstance()
		end

		error("singleton class can not new. Please use " .. uv1 .. ".GetInstance() to get it", 2)
	end

	function slot2.GetInstance()
		if rawget(uv0, "_singletonInstance") == nil then
			rawset(uv0, "_singletonInstance", uv0._new())
		end

		return uv0._singletonInstance
	end

	return slot2
end

function removeSingletonInstance(slot0)
	if slot0 and rawget(slot0, "_singletonInstance") then
		slot0.New = slot0._new
		slot0._new = nil

		rawset(slot0, "_singletonInstance", nil)

		return true
	end

	return false
end

function tracebackex()
	slot1 = 2
	slot0 = "" .. "stack traceback:\n"

	while true do
		if not debug.getinfo(slot1, "Sln") then
			break
		end

		slot0 = slot2.what == "C" and slot0 .. tostring(slot1) .. "\tC function\n" or slot0 .. string.format("\t[%s]:%d in function `%s`\n", slot2.short_src, slot2.currentline, slot2.name or "")
		slot1 = slot1 + 1
	end

	return slot0
end

function tostringex(slot0, slot1)
	if slot1 == nil then
		slot1 = 0
	end

	slot2 = string.rep("\t", slot1)
	slot3 = ""

	if type(slot0) == "table" then
		if slot1 > 5 then
			return "\t{ ... }"
		end

		for slot8, slot9 in pairs(slot0) do
			slot4 = "" .. "\n\t" .. slot2 .. tostring(slot8) .. ":" .. tostringex(slot9, slot1 + 1)
		end

		if slot4 == "" then
			slot3 = slot3 .. slot2 .. "{ }\t(" .. tostring(slot0) .. ")"
		else
			if slot1 > 0 then
				slot3 = slot3 .. "\t(" .. tostring(slot0) .. ")\n"
			end

			slot3 = slot3 .. slot2 .. "{" .. slot4 .. "\n" .. slot2 .. "}"
		end
	else
		slot3 = slot3 .. slot2 .. tostring(slot0) .. "\t(" .. type(slot0) .. ")"
	end

	return slot3
end
