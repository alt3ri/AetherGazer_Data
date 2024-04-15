slot0 = singletonClass("LazyLoad")

function slot0.Ctor(slot0)
	_G.globleDefine = {}
	_G.globleModulesRegister = {}

	setmetatable(_G, {
		__index = function (slot0, slot1)
			if slot0.globleDefine[slot1] == nil then
				if slot0.globleModulesRegister[slot1] then
					if import(slot3) == nil then
						print(debug.traceback("create a nil module moduleName = " .. slot1))
					end

					slot0.globleDefine[slot1] = slot2
				end

				rawset(slot0, slot1, slot2)
			end

			return slot2
		end
	})
end

function slot0.registerModules(slot0, slot1, slot2)
	if slot1 == nil or slot2 == nil then
		print("LazyLoad:registerModules fail " .. tostring(slot1) .. " : " .. tostring(slot2))

		return
	end

	if _G.globleModulesRegister[slot1] then
		print("LazyLoad moduleName is exist :" .. slot1)
	end

	_G.globleModulesRegister[slot1] = slot2
end

return slot0
