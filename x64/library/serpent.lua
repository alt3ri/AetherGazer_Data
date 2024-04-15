slot0 = "serpent"
slot1 = "0.302"
slot2 = "Paul Kulchenko"
slot3 = "Lua serializer and pretty printer"
slot4 = {
	[tostring(inf)] = "1/0 --[[math.huge]]",
	[tostring(-inf)] = "-1/0 --[[-math.huge]]",
	[tostring(0 / 0)] = "0/0"
}
slot5 = {
	userdata = true,
	cdata = true,
	thread = true
}
slot6 = debug and debug.getmetatable or getmetatable

function slot7(slot0)
	return next, slot0
end

slot8 = {
	[slot15] = true
}
slot9 = {}
slot10 = _G or _ENV

for slot14, slot15 in ipairs({
	"and",
	"break",
	"do",
	"else",
	"elseif",
	"end",
	"false",
	"for",
	"function",
	"goto",
	"if",
	"in",
	"local",
	"nil",
	"not",
	"or",
	"repeat",
	"return",
	"then",
	"true",
	"until",
	"while"
}) do
	-- Nothing
end

for slot14, slot15 in slot7(slot10) do
	slot9[slot15] = slot14
end

for slot14, slot15 in ipairs({
	"coroutine",
	"debug",
	"io",
	"math",
	"string",
	"table",
	"os"
}) do
	for slot19, slot20 in slot7(type(slot10[slot15]) == "table" and slot10[slot15] or {}) do
		slot9[slot20] = slot15 .. "." .. slot19
	end
end

function slot13(slot0, slot1)
	if slot1 then
		for slot5, slot6 in uv0(slot1) do
			slot0[slot5] = slot6
		end
	end

	return slot0
end

return {
	_NAME = slot0,
	_COPYRIGHT = slot2,
	_DESCRIPTION = slot3,
	_VERSION = slot1,
	serialize = function (slot0, slot1)
		slot2 = slot1.name
		slot3 = slot1.indent
		slot4 = slot1.fatal
		slot5 = slot1.maxnum
		slot6 = slot1.sparse
		slot7 = slot1.custom
		slot8 = not slot1.nohuge
		slot9 = slot1.compact and "" or " "
		slot10 = slot1.maxlevel or math.huge
		slot11 = tonumber(slot1.maxlength)
		slot12 = slot1.metatostring
		slot14 = slot2 or ""
		slot14 = slot1.comment and (tonumber(slot1.comment) or math.huge)
		slot15 = slot1.numformat or "%.17g"
		slot16 = {}
		slot17 = {
			"local " .. ("_" .. slot14) .. "={}"
		}
		slot18 = {}
		slot19 = 0

		function slot20(slot0)
			return "_" .. tostring(tostring(slot0)):gsub("[^%w]", ""):gsub("(%d%w+)", function (slot0)
				if not uv0[slot0] then
					uv1 = uv1 + 1
					uv0[slot0] = uv1
				end

				return tostring(uv0[slot0])
			end)
		end

		function slot21(slot0)
			return type(slot0) == "number" and tostring(uv0 and uv1[tostring(slot0)] or uv2:format(slot0)) or type(slot0) ~= "string" and tostring(slot0) or ("%q"):format(slot0):gsub("\n", "n"):gsub("", "\\026")
		end

		function slot22(slot0, slot1)
			return uv0 and (slot1 or 0) < uv0 and " --[[" .. select(2, pcall(tostring, slot0)) .. "]]" or ""
		end

		function slot23(slot0, slot1)
			return uv0[slot0] and uv0[slot0] .. uv1(slot0, slot1) or not uv2 and uv3(select(2, pcall(tostring, slot0))) or error("Can't serialize " .. tostring(slot0))
		end

		function slot24(slot0, slot1)
			slot2 = slot1 == nil and "" or slot1
			slot3 = type(slot2) == "string" and slot2:match("^[%l%u_][%w_]*$") and not uv0[slot2]
			slot4 = slot3 and slot2 or "[" .. uv1(slot2) .. "]"

			return (slot0 or "") .. (slot3 and slot0 and "." or "") .. slot4, slot4
		end

		slot25 = type(slot1.sortkeys) == "function" and slot1.sortkeys or function (slot0, slot1, slot2)
			slot3 = tonumber(slot2) or 12
			slot4 = {
				string = "b",
				number = "a"
			}

			function slot5(slot0)
				return ("%0" .. tostring(uv0) .. "d"):format(tonumber(slot0))
			end

			table.sort(slot0, function (slot0, slot1)
				return (uv0[slot0] ~= nil and 0 or uv1[type(slot0)] or "z") .. tostring(slot0):gsub("%d+", uv2) < (uv0[slot1] ~= nil and 0 or uv1[type(slot1)] or "z") .. tostring(slot1):gsub("%d+", uv2)
			end)
		end
		slot27 = slot3 and "\n" or ";" .. slot9
		slot28 = function (slot0, slot1, slot2, slot3, slot4, slot5, slot6)
			slot7 = type(slot0)
			slot9 = uv0(slot0)
			slot10, slot11 = uv1(slot4, slot1)

			if uv3[slot0] then
				uv4[#uv4 + 1] = slot10 .. uv2 .. "=" .. uv2 .. uv3[slot0]

				return (slot5 and (type(slot1) == "number" and "" or slot1 .. uv2 .. "=" .. uv2) or slot1 ~= nil and slot11 .. uv2 .. "=" .. uv2 or "") .. "nil" .. uv5("ref", slot6 or 0)
			end

			if type(slot9) == "table" and uv6 ~= false then
				slot13, slot14 = pcall(function ()
					return uv0.__tostring(uv1)
				end)
				slot15, slot16 = pcall(function ()
					return uv0.__serialize(uv1)
				end)

				if slot13 or slot15 then
					uv3[slot0] = slot3 or slot10
					slot7 = type(slot15 and slot16 or slot14)
				end
			end

			if slot7 == "table" then
				if uv7 <= slot8 then
					return slot12 .. "{}" .. uv5("maxlvl", slot8)
				end

				uv3[slot0] = slot3 or slot10

				if next(slot0) == nil then
					return slot12 .. "{}" .. uv5(slot0, slot8)
				end

				if uv8 and uv8 < 0 then
					return slot12 .. "{}" .. uv5("maxlen", slot8)
				end

				slot15 = #slot0
				slot15 = {}

				for slot19 = 1, math.min(slot15, uv9 or #slot0) do
				end

				if not uv9 or #{
					[slot19] = slot19
				} < uv9 then
					for slot20 in uv10(slot0) do
						if slot14[slot20] ~= slot20 then
							slot14[#slot14 + 1] = slot20
						end
					end
				end

				if uv9 and uv9 < #slot14 then
					slot14[uv9 + 1] = nil
				end

				if uv11.sortkeys and slot13 < #slot14 then
					uv12(slot14, slot0, uv11.sortkeys)
				end

				slot16 = uv13 and slot13 < #slot14

				for slot20, slot21 in ipairs(slot14) do
					slot22 = slot0[slot21]
					slot23 = type(slot21)
					slot24 = slot20 <= slot13 and not slot16

					if (not uv11.valignore or not uv11.valignore[slot22]) and (not uv11.keyallow or uv11.keyallow[slot21]) and (not uv11.keyignore or not uv11.keyignore[slot21]) and (not uv11.valtypeignore or not uv11.valtypeignore[type(slot22)]) then
						if slot16 and slot22 == nil then
							-- Nothing
						elseif slot23 == "table" or slot23 == "function" or uv14[slot23] then
							if not uv3[slot21] and not uv15[slot21] then
								uv4[#uv4 + 1] = "placeholder"
								slot25 = uv1(uv16, uv17(slot21))
								uv4[#uv4] = uv18(slot21, slot25, slot2, slot25, uv16, true)
							end

							uv4[#uv4 + 1] = "placeholder"
							uv4[#uv4] = uv3[slot0] .. "[" .. tostring(uv3[slot21] or uv15[slot21] or uv17(slot21)) .. "]" .. uv2 .. "=" .. uv2 .. tostring(uv3[slot22] or uv18(slot22, nil, slot2, slot25))
						else
							slot15[#slot15 + 1] = uv18(slot22, slot21, slot2, nil, uv3[slot0], slot24, slot8 + 1)

							if uv8 then
								uv8 = uv8 - #slot15[#slot15]

								if uv8 < 0 then
									break
								end
							end
						end
					end
				end

				slot17 = string.rep(slot2 or "", slot8)
				slot18 = slot2 and "{\n" .. slot17 .. slot2 or "{"
				slot19 = table.concat(slot15, "," .. (slot2 and "\n" .. slot17 .. slot2 or uv2))
				slot20 = slot2 and "\n" .. slot17 .. "}" or "}"

				return (uv19 and uv19(slot12, slot18, slot19, slot20, slot8) or slot12 .. slot18 .. slot19 .. slot20) .. uv5(slot0, slot8)
			elseif uv14[slot7] then
				uv3[slot0] = slot3 or slot10

				return slot12 .. uv20(slot0, slot8)
			elseif slot7 == "function" then
				uv3[slot0] = slot3 or slot10

				if uv11.nocode then
					return slot12 .. "function() --[[..skipped..]] end" .. uv5(slot0, slot8)
				end

				slot13, slot14 = pcall(string.dump, slot0)

				return slot12 .. (slot13 and "((loadstring or load)(" .. uv21(slot14) .. ",'@serialized'))" .. uv5(slot0, slot8) or uv20(slot0, slot8))
			else
				return slot12 .. uv21(slot0)
			end
		end(slot0, slot2, slot3)

		return not slot2 and slot28 .. (slot1.comment and #slot17 > 1 and slot9 .. "--[[incomplete output with shared/self-references skipped]]" or "") or "do local " .. slot28 .. slot27 .. (#slot17 > 1 and table.concat(slot17, slot27) .. slot27 or "") .. "return " .. slot2 .. slot27 .. "end"
	end,
	load = function (slot0, slot1)
		slot3, slot4 = loadstring or load("return " .. slot0, nil, , slot1 and slot1.safe == false and uv0 or setmetatable({}, {
			__index = function (slot0, slot1)
				return slot0
			end,
			__call = function (slot0, ...)
				error("cannot call functions")
			end
		}))

		if not slot3 then
			slot3, slot4 = loadstring or load(slot0, nil, , slot2)
		end

		if not slot3 then
			return slot3, slot4
		end

		if setfenv then
			setfenv(slot3, slot2)
		end

		return pcall(slot3)
	end,
	dump = function (slot0, slot1)
		return uv0(slot0, uv1({
			sparse = true,
			name = "_",
			compact = true
		}, slot1))
	end,
	line = function (slot0, slot1)
		return uv0(slot0, uv1({
			sortkeys = true,
			comment = true
		}, slot1))
	end,
	block = function (slot0, slot1)
		return uv0(slot0, uv1({
			sortkeys = true,
			indent = "  ",
			comment = true
		}, slot1))
	end
}
