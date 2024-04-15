slot15 = {
	m_cMethods = {},
	m_cHelpers = {},
	m_cBases = {},
	m_cConfig = {
		m_bComparedMemoryRefFileAddTime = true,
		m_bSingleMemoryRefFileAddTime = true,
		m_bAllMemoryRefFileAddTime = true
	}
}

function slot15.m_cMethods.DumpMemorySnapshot(slot0, slot1, slot2, slot3, slot4)
	slot5 = uv0()

	if slot4 then
		if not slot3 or string.len(slot3) == 0 then
			slot3 = tostring(slot4)
		end
	else
		slot4 = debug.getregistry()
		slot3 = "registry"
	end

	slot6 = uv1()

	if debug.getinfo(2, "Sl") then
		slot6.m_strShortSrc = slot7.short_src
		slot6.m_nCurrentLine = slot7.currentline
	end

	uv2(slot3, slot4, slot6)
	uv3(slot0, slot1, slot2, slot3, slot4, nil, slot6)
end

function slot15.m_cMethods.DumpMemorySnapshotCompared(slot0, slot1, slot2, slot3, slot4)
	uv0(slot0, slot1, slot2, nil, , slot3, slot4)
end

function slot15.m_cMethods.DumpMemorySnapshotComparedFile(slot0, slot1, slot2, slot3, slot4)
	uv1(slot0, slot1, slot2, nil, , uv0(slot3), uv0(slot4))
end

function slot15.m_cMethods.DumpMemorySnapshotSingleObject(slot0, slot1, slot2, slot3, slot4)
	if not slot4 then
		return
	end

	if not slot3 or string.len(slot3) == 0 then
		slot3 = uv0(slot4)
	end

	slot5 = uv1()
	slot6 = uv2(slot3, slot4)

	if debug.getinfo(2, "Sl") then
		slot6.m_strShortSrc = slot7.short_src
		slot6.m_nCurrentLine = slot7.currentline
	end

	uv3("registry", debug.getregistry(), slot6)
	uv4(slot0, slot1, slot2, slot6)
end

function slot15.m_cHelpers.FormatDateTimeNow()
	slot0 = os.date("*t")

	return string.format("%04d%02d%02d-%02d%02d%02d", tostring(slot0.year), tostring(slot0.month), tostring(slot0.day), tostring(slot0.hour), tostring(slot0.min), tostring(slot0.sec))
end

function slot15.m_cHelpers.GetOriginalToStringResult(slot0)
	if not slot0 then
		return ""
	end

	if not getmetatable(slot0) then
		return tostring(slot0)
	end

	slot2 = ""

	if rawget(slot1, "__tostring") then
		rawset(slot1, "__tostring", nil)

		slot2 = tostring(slot0)

		rawset(slot1, "__tostring", slot3)
	else
		slot2 = tostring(slot0)
	end

	return slot2
end

function slot15.m_cBases.CreateObjectReferenceInfoContainer()
	slot1 = {}

	setmetatable(slot1, {
		__mode = "k"
	})

	slot2 = {}

	setmetatable(slot2, {
		__mode = "k"
	})

	return {
		m_cObjectReferenceCount = slot1,
		m_cObjectAddressToName = slot2,
		m_nStackLevel = -1,
		m_strShortSrc = "None",
		m_nCurrentLine = -1
	}
end

function slot15.m_cBases.CreateObjectReferenceInfoContainerFromFile(slot0)
	slot1 = uv0()
	slot1.m_strShortSrc = slot0

	for slot8 in assert(io.open(slot0, "rb")):lines() do
		if string.sub(slot8, 1, 2) ~= "--" then
			slot10, slot11, slot12, slot1.m_cObjectAddressToName[slot12], slot1.m_cObjectReferenceCount[slot12] = string.find(slot8, "(.+)\t(.*)\t(%d+)")

			if slot12 then
				-- Nothing
			end
		end
	end

	io.close(slot4)

	slot4 = nil

	return slot1
end

function slot15.m_cBases.CreateSingleObjectReferenceInfoContainer(slot0, slot1)
	slot2 = {
		m_cObjectExistTag = slot3,
		m_cObjectAliasName = {},
		m_cObjectAccessTag = slot5,
		m_nStackLevel = -1,
		m_strShortSrc = "None",
		m_nCurrentLine = -1,
		m_strObjectName = slot0,
		m_strAddressName = type(slot1) == "string" and "\"" .. tostring(slot1) .. "\"" or uv0(slot1)
	}

	setmetatable({}, {
		__mode = "k"
	})
	setmetatable({}, {
		__mode = "k"
	})

	slot2.m_cObjectExistTag[slot1] = true

	return slot2
end

function slot15.m_cBases.CollectObjectReferenceInMemory(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot0 = slot0 or ""

	if (slot2 or uv0()).m_nStackLevel > 0 then
		if debug.getinfo(slot2.m_nStackLevel, "Sl") then
			slot2.m_strShortSrc = slot3.short_src
			slot2.m_nCurrentLine = slot3.currentline
		end

		slot2.m_nStackLevel = -1
	end

	slot3 = slot2.m_cObjectReferenceCount
	slot4 = slot2.m_cObjectAddressToName

	if type(slot1) == "table" then
		if rawget(slot1, "__cname") then
			if type(slot1.__cname) == "string" then
				slot0 = slot0 .. "[class:" .. slot1.__cname .. "]"
			end
		elseif rawget(slot1, "class") then
			if type(slot1.class) == "string" then
				slot0 = slot0 .. "[class:" .. slot1.class .. "]"
			end
		elseif rawget(slot1, "_className") and type(slot1._className) == "string" then
			slot0 = slot0 .. "[class:" .. slot1._className .. "]"
		end

		if slot1 == _G then
			slot0 = slot0 .. "[_G]"
		end

		slot6 = false
		slot7 = false

		if getmetatable(slot1) and rawget(slot8, "__mode") then
			if string.find(slot9, "k") then
				slot6 = true
			end

			if string.find(slot9, "v") then
				slot7 = true
			end
		end

		slot3[slot1] = slot3[slot1] and slot3[slot1] + 1 or 1

		if slot4[slot1] then
			return
		end

		slot4[slot1] = slot0

		for slot12, slot13 in pairs(slot1) do
			if type(slot12) == "table" then
				if not slot6 then
					uv1(slot0 .. ".[table:key.table]", slot12, slot2)
				end

				if not slot7 then
					uv1(slot0 .. ".[table:value]", slot13, slot2)
				end
			elseif slot14 == "function" then
				if not slot6 then
					uv1(slot0 .. ".[table:key.function]", slot12, slot2)
				end

				if not slot7 then
					uv1(slot0 .. ".[table:value]", slot13, slot2)
				end
			elseif slot14 == "thread" then
				if not slot6 then
					uv1(slot0 .. ".[table:key.thread]", slot12, slot2)
				end

				if not slot7 then
					uv1(slot0 .. ".[table:value]", slot13, slot2)
				end
			elseif slot14 == "userdata" then
				if not slot6 then
					uv1(slot0 .. ".[table:key.userdata]", slot12, slot2)
				end

				if not slot7 then
					uv1(slot0 .. ".[table:value]", slot13, slot2)
				end
			else
				uv1(slot0 .. "." .. tostring(slot12), slot13, slot2)
			end
		end

		if slot8 then
			uv1(slot0 .. ".[metatable]", slot8, slot2)
		end
	elseif slot5 == "function" then
		slot6 = debug.getinfo(slot1, "Su")
		slot3[slot1] = slot3[slot1] and slot3[slot1] + 1 or 1

		if slot4[slot1] then
			return
		end

		slot11 = slot6.short_src
		slot4[slot1] = slot0 .. "[line:" .. tostring(slot6.linedefined) .. "@file:" .. slot11 .. "]"

		for slot11 = 1, slot6.nups do
			slot12, slot13 = debug.getupvalue(slot1, slot11)

			if type(slot13) == "table" then
				uv1(slot0 .. ".[ups:table:" .. slot12 .. "]", slot13, slot2)
			elseif slot14 == "function" then
				uv1(slot0 .. ".[ups:function:" .. slot12 .. "]", slot13, slot2)
			elseif slot14 == "thread" then
				uv1(slot0 .. ".[ups:thread:" .. slot12 .. "]", slot13, slot2)
			elseif slot14 == "userdata" then
				uv1(slot0 .. ".[ups:userdata:" .. slot12 .. "]", slot13, slot2)
			end
		end

		if debug.getfenv and slot8(slot1) then
			uv1(slot0 .. ".[function:environment]", slot9, slot2)
		end
	elseif slot5 == "thread" then
		slot3[slot1] = slot3[slot1] and slot3[slot1] + 1 or 1

		if slot4[slot1] then
			return
		end

		slot4[slot1] = slot0

		if debug.getfenv and slot6(slot1) then
			uv1(slot0 .. ".[thread:environment]", slot7, slot2)
		end

		if getmetatable(slot1) then
			uv1(slot0 .. ".[thread:metatable]", slot7, slot2)
		end
	elseif slot5 == "userdata" then
		slot3[slot1] = slot3[slot1] and slot3[slot1] + 1 or 1

		if slot4[slot1] then
			return
		end

		slot4[slot1] = slot0

		if debug.getfenv and slot6(slot1) then
			uv1(slot0 .. ".[userdata:environment]", slot7, slot2)
		end

		if getmetatable(slot1) then
			uv1(slot0 .. ".[userdata:metatable]", slot7, slot2)
		end
	elseif slot5 == "string" then
		slot3[slot1] = slot3[slot1] and slot3[slot1] + 1 or 1

		if slot4[slot1] then
			return
		end

		slot4[slot1] = slot0 .. "[" .. slot5 .. "]"
	end
end

function slot15.m_cBases.CollectSingleObjectReferenceInMemory(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot0 = slot0 or ""

	if (slot2 or uv0()).m_nStackLevel > 0 then
		if debug.getinfo(slot2.m_nStackLevel, "Sl") then
			slot2.m_strShortSrc = slot3.short_src
			slot2.m_nCurrentLine = slot3.currentline
		end

		slot2.m_nStackLevel = -1
	end

	slot3 = slot2.m_cObjectExistTag
	slot4 = slot2.m_cObjectAliasName
	slot5 = slot2.m_cObjectAccessTag

	if type(slot1) == "table" then
		if rawget(slot1, "__cname") then
			if type(slot1.__cname) == "string" then
				slot0 = slot0 .. "[class:" .. slot1.__cname .. "]"
			end
		elseif rawget(slot1, "class") then
			if type(slot1.class) == "string" then
				slot0 = slot0 .. "[class:" .. slot1.class .. "]"
			end
		elseif rawget(slot1, "_className") and type(slot1._className) == "string" then
			slot0 = slot0 .. "[class:" .. slot1._className .. "]"
		end

		if slot1 == _G then
			slot0 = slot0 .. "[_G]"
		end

		slot7 = false
		slot8 = false

		if getmetatable(slot1) and rawget(slot9, "__mode") then
			if slot10 == "k" then
				slot7 = true
			elseif slot10 == "v" then
				slot8 = true
			elseif slot10 == "kv" then
				slot7 = true
				slot8 = true
			end
		end

		if slot3[slot1] and not slot4[slot0] then
			slot4[slot0] = true
		end

		if slot5[slot1] then
			return
		end

		slot5[slot1] = true

		for slot13, slot14 in pairs(slot1) do
			if type(slot13) == "table" then
				if not slot7 then
					uv1(slot0 .. ".[table:key.table]", slot13, slot2)
				end

				if not slot8 then
					uv1(slot0 .. ".[table:value]", slot14, slot2)
				end
			elseif slot15 == "function" then
				slot16 = debug.getinfo(slot13, "Su")

				if not slot7 then
					uv1(slot0 .. ".[table:key.function" .. ("{line:" .. tostring(slot16.linedefined) .. "@file:" .. slot16.short_src .. "}") .. "]", slot13, slot2)
				end

				if not slot8 then
					uv1(slot0 .. ".[table:value]", slot14, slot2)
				end
			elseif slot15 == "thread" then
				if not slot7 then
					uv1(slot0 .. ".[table:key.thread]", slot13, slot2)
				end

				if not slot8 then
					uv1(slot0 .. ".[table:value]", slot14, slot2)
				end
			elseif slot15 == "userdata" then
				if not slot7 then
					uv1(slot0 .. ".[table:key.userdata]", slot13, slot2)
				end

				if not slot8 then
					uv1(slot0 .. ".[table:value]", slot14, slot2)
				end
			else
				uv1(slot0 .. "." .. tostring(slot13), slot14, slot2)
			end
		end

		if slot9 then
			uv1(slot0 .. ".[metatable]", slot9, slot2)
		end
	elseif slot6 == "function" then
		slot7 = debug.getinfo(slot1, "Su")
		slot8 = slot0 .. "[line:" .. tostring(slot7.linedefined) .. "@file:" .. slot7.short_src .. "]"

		if slot3[slot1] and not slot4[slot8] then
			slot4[slot8] = true
		end

		if slot5[slot1] then
			return
		end

		slot5[slot1] = true

		for slot13 = 1, slot7.nups do
			slot14, slot15 = debug.getupvalue(slot1, slot13)

			if type(slot15) == "table" then
				uv1(slot0 .. ".[ups:" .. uv2(slot15) .. ":" .. slot14 .. "]", slot15, slot2)
			elseif slot16 == "function" then
				slot17 = debug.getinfo(slot15, "Su")

				uv1(slot0 .. ".[ups:function:" .. slot14 .. ("{line:" .. tostring(slot17.linedefined) .. "@file:" .. slot17.short_src .. "}") .. "]", slot15, slot2)
			elseif slot16 == "thread" then
				uv1(slot0 .. ".[ups:thread:" .. slot14 .. "]", slot15, slot2)
			elseif slot16 == "userdata" then
				uv1(slot0 .. ".[ups:userdata:" .. slot14 .. "]", slot15, slot2)
			end
		end

		if debug.getfenv and slot10(slot1) then
			uv1(slot0 .. ".[function:environment]", slot11, slot2)
		end
	elseif slot6 == "thread" then
		if slot3[slot1] and not slot4[slot0] then
			slot4[slot0] = true
		end

		if slot5[slot1] then
			return
		end

		slot5[slot1] = true

		if debug.getfenv and slot7(slot1) then
			uv1(slot0 .. ".[thread:environment]", slot8, slot2)
		end

		if getmetatable(slot1) then
			uv1(slot0 .. ".[thread:metatable]", slot8, slot2)
		end
	elseif slot6 == "userdata" then
		if slot3[slot1] and not slot4[slot0] then
			slot4[slot0] = true
		end

		if slot5[slot1] then
			return
		end

		slot5[slot1] = true

		if debug.getfenv and slot7(slot1) then
			uv1(slot0 .. ".[userdata:environment]", slot8, slot2)
		end

		if getmetatable(slot1) then
			uv1(slot0 .. ".[userdata:metatable]", slot8, slot2)
		end
	elseif slot6 == "string" then
		if slot3[slot1] and not slot4[slot0] then
			slot4[slot0] = true
		end

		if slot5[slot1] then
			return
		end

		slot5[slot1] = true
	end
end

function slot15.m_cBases.OutputMemorySnapshot(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not slot6 then
		return
	end

	slot7 = uv0()
	slot8 = slot5 and slot5.m_cObjectReferenceCount or nil
	slot9 = slot5 and slot5.m_cObjectAddressToName or nil
	slot11 = slot6.m_cObjectAddressToName

	for slot17 in pairs(slot6.m_cObjectReferenceCount) do
		-- Nothing
	end

	table.sort({
		[0 + 1] = slot17
	}, function (slot0, slot1)
		return uv0[slot1] < uv0[slot0]
	end)

	slot15 = nil
	slot16 = print

	if slot0 and string.len(slot0) > 0 then
		if string.sub(slot0, -1) ~= "/" and slot17 ~= "\\" then
			slot0 = slot0 .. "/"
		end

		slot18 = slot0 .. "LuaMemRefInfo-All"
		slot19 = assert(io.open(slot18, "w"))
		slot15 = slot19
		slot16 = slot19.write
	end

	function slot17(slot0)
		if uv0 then
			uv1(uv0, slot0)
		else
			uv1(slot0)
		end
	end

	if slot5 then
		slot17("--------------------------------------------------------\n")
		slot17("-- This is compared memory information.\n")
		slot17("--------------------------------------------------------\n")
		slot17("-- Collect base memory reference at line:" .. tostring(slot5.m_nCurrentLine) .. "@file:" .. slot5.m_strShortSrc .. "\n")
		slot17("-- Collect compared memory reference at line:" .. tostring(slot6.m_nCurrentLine) .. "@file:" .. slot6.m_strShortSrc .. "\n")
	else
		slot17("--------------------------------------------------------\n")
		slot17("-- Collect memory reference at line:" .. tostring(slot6.m_nCurrentLine) .. "@file:" .. slot6.m_strShortSrc .. "\n")
	end

	slot17("--------------------------------------------------------\n")
	slot17("-- [Table/Function/String Address/Name]\t[Reference Path]\t[Reference Count]\n")
	slot17("--------------------------------------------------------\n")

	if slot3 and slot4 then
		if type(slot4) == "string" then
			slot17("-- From Root Object: \"" .. tostring(slot4) .. "\" (" .. slot3 .. ")\n")
		else
			slot17("-- From Root Object: " .. uv2(slot4) .. " (" .. slot3 .. ")\n")
		end
	end

	for slot21, slot22 in ipairs(slot12) do
		if not slot5 or not slot8[slot22] then
			if slot2 > 0 then
				if slot21 <= slot2 then
					if type(slot22) == "string" then
						slot24, slot25 = string.find(tostring(slot22), "string: \".*\"")

						if not slot5 and (slot24 == nil or slot25 == nil) then
							slot17("string: \"" .. string.gsub(slot23, "([\n\r])", "\\n") .. "\"\t" .. slot11[slot22] .. "\t" .. tostring(slot10[slot22]) .. "\n")
						else
							slot17(tostring(slot22) .. "\t" .. slot11[slot22] .. "\t" .. tostring(slot10[slot22]) .. "\n")
						end
					else
						slot17(uv2(slot22) .. "\t" .. slot11[slot22] .. "\t" .. tostring(slot10[slot22]) .. "\n")
					end
				end
			elseif type(slot22) == "string" then
				slot24, slot25 = string.find(tostring(slot22), "string: \".*\"")

				if not slot5 and (slot24 == nil or slot25 == nil) then
					slot17("string: \"" .. string.gsub(slot23, "([\n\r])", "\\n") .. "\"\t" .. slot11[slot22] .. "\t" .. tostring(slot10[slot22]) .. "\n")
				else
					slot17(tostring(slot22) .. "\t" .. slot11[slot22] .. "\t" .. tostring(slot10[slot22]) .. "\n")
				end
			else
				slot17(uv2(slot22) .. "\t" .. slot11[slot22] .. "\t" .. tostring(slot10[slot22]) .. "\n")
			end
		end
	end

	if slot14 then
		io.close(slot15)

		slot15 = nil
	end
end

function slot15.m_cBases.OutputMemorySnapshotSingleObject(slot0, slot1, slot2, slot3)
	if not slot3 then
		return
	end

	slot4 = uv0()
	slot5 = slot3.m_cObjectAliasName
	slot7 = nil
	slot8 = print

	if slot0 and string.len(slot0) > 0 then
		if string.sub(slot0, -1) ~= "/" and slot9 ~= "\\" then
			slot0 = slot0 .. "/"
		end

		slot10 = slot0 .. "LuaMemRefInfo-Single"
		slot11 = assert(io.open((not slot1 or string.len(slot1) == 0) and (uv1.m_bSingleMemoryRefFileAddTime and slot10 .. "-[" .. slot4 .. "].txt" or slot10 .. ".txt") or uv1.m_bSingleMemoryRefFileAddTime and slot10 .. "-[" .. slot4 .. "]-[" .. slot1 .. "].txt" or slot10 .. "-[" .. slot1 .. "].txt", "w"))
		slot7 = slot11
		slot8 = slot11.write
	end

	function slot9(slot0)
		if uv0 then
			uv1(uv0, slot0)
		else
			uv1(slot0)
		end
	end

	slot9("--------------------------------------------------------\n")

	slot14 = slot3.m_strShortSrc

	slot9("-- Collect single object memory reference at line:" .. tostring(slot3.m_nCurrentLine) .. "@file:" .. slot14 .. "\n")
	slot9("--------------------------------------------------------\n")

	for slot14 in pairs(slot5) do
		slot10 = 0 + 1
	end

	slot14 = " ("
	slot15 = slot3.m_strObjectName

	slot9("-- For Object: " .. slot3.m_strAddressName .. slot14 .. slot15 .. "), have " .. tostring(slot10) .. " reference in total.\n")
	slot9("--------------------------------------------------------\n")

	for slot14, slot15 in pairs(slot5) do
		slot9(tostring(slot14) .. "\n")
	end

	if slot6 then
		io.close(slot7)

		slot7 = nil
	end
end

function slot15.m_cBases.OutputFilteredResult(slot0, slot1, slot2, slot3)
	if not slot0 or string.len(slot0) == 0 then
		print("You need to specify a file path.")

		return
	end

	if not slot1 or string.len(slot1) == 0 then
		print("You need to specify a filter string.")

		return
	end

	for slot9 in assert(io.open(slot0, "rb")):lines() do
		slot10, slot11 = string.find(slot9, slot1)

		if slot10 and slot11 then
			if slot2 then
				slot12, slot11 = string.find(slot9, "[\r\n]")

				if slot12 and slot11 and string.len(slot9) == slot11 then
					table.insert({}, string.sub(slot9, 1, slot10 - 1))
				else
					table.insert(slot4, slot9)
				end
			end
		elseif not slot2 then
			slot12, slot11 = string.find(slot9, "[\r\n]")

			if slot12 and slot11 and string.len(slot9) == slot11 then
				table.insert(slot4, string.sub(slot9, 1, slot10 - 1))
			else
				table.insert(slot4, slot9)
			end
		end
	end

	io.close(slot5)

	slot5, slot6 = nil
	slot7 = print

	if slot3 then
		slot8, slot9, slot11 = string.find(slot0, "(.*)%.txt")
		slot11 = assert(io.open(slot11 .. "-Filter-" .. (slot2 and "I" or "E") .. "-[" .. slot1 .. "].txt", "w"))
		slot6 = slot11
		slot7 = slot11.write
	end

	for slot12, slot13 in ipairs(slot4) do
		function (slot0)
			if uv0 then
				uv1(uv0, slot0)
			else
				uv1(slot0)
			end
		end(slot13 .. "\n")
	end

	if slot3 then
		io.close(slot6)

		slot6 = nil
	end
end

return slot15
