function trace(slot0, ...)
	printCustom(slot0, ...)
end

function printCustom(slot0, ...)
	slot1 = {
		...
	}
	slot2 = 0

	if type(slot0) == "string" then
		slot0 = string.gsub(slot0, "%%([o,s,d])", function (slot0)
			uv0 = uv0 + 1

			if slot0 == "s" then
				return uv1[uv0]
			else
				return watch(uv1[uv0])
			end
		end)
	end

	print(slot0)
end

function watch(slot0, slot1, slot2)
	slot3 = ""
	slot4 = true
	slot1 = slot1 or "" or ""

	if (slot2 or 0) > 20 then
		return "... ...(duplicate reference)"
	end

	if slot0 == nil then
		slot3 = "<nil>"
	elseif type(slot0) == "table" and type(slot0.is_clone) == "boolean" then
		if is_string(slot0:get_ob_id()) then
			if slot0.destructed == true then
				slot3 = string.format("object(%s<destructed>)", slot5)
			else
				slot3 = string.format("object(%s)", slot5)
			end
		else
			slot3 = string.format("object(%s)", save_string(slot0.class_type))
		end
	elseif type(slot0) == "table" then
		slot5 = sizeof(slot0)

		if string.len(slot1) > 20 then
			slot3 = "<table overflow>"
		else
			slot6 = {
				string.format("<table>   size : %d\r\n%s{\r\n", slot5, slot1)
			}
			slot7 = 1

			for slot11, slot12 in pairs(slot0) do
				slot4 = true

				if type(slot11) == "string" and type(slot12) == "table" and string.len(slot11) > 0 and string.sub(slot13, 1, 1) == "_" then
					table.insert(slot6, string.format("%s\t%s: <table hide>,\r\n", slot1, watch(slot11, slot1 .. "\t", slot2 + 1)))

					slot4 = false
				end

				if slot4 then
					table.insert(slot6, string.format("%s\t%s:%s,\r\n", slot1, watch(slot11, slot1 .. "\t", slot2 + 1), watch(slot12, slot1 .. "\t", slot2 + 1)))
				end

				if slot7 + 1 > 100 then
					table.insert(slot6, "... ...(table too long)")

					break
				end
			end

			table.insert(slot6, string.format("%s}", slot1))

			slot3 = table.concat(slot6, "")
		end
	else
		slot3 = type(slot0) == "function" and "<function>" or (type(slot0) ~= "string" or string.format("\"%s\"", string.gsub(slot0, "\"", "\\\""))) and (type(slot0) ~= "number" or tostring(slot0)) and (type(slot0) ~= "boolean" or tostring(slot0)) and string.format("<%s type>", "unknow")
	end

	return slot3
end

function sizeof(slot0)
	slot1 = 0

	if type(slot0) == "table" then
		for slot5, slot6 in pairs(slot0) do
			slot1 = slot1 + 1
		end
	elseif type(slot0) == "string" then
		slot1 = string.len(slot0)
	end

	return slot1
end
