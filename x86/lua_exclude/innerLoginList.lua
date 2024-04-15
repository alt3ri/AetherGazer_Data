slot0 = require("cjson")

return {
	GetLoginList = function (slot0)
		for slot8, slot9 in pairs(uv0.decode(tostring(Resources.Load("innerLoginInfo")))) do
			-- Nothing
		end

		return {
			[tonumber(slot8)] = slot9
		}
	end
}
