local var_0_0 = require("cjson")

return {
	GetLoginList = function(arg_1_0)
		local var_1_0 = Resources.Load("innerLoginInfo")
		local var_1_1 = tostring(var_1_0)
		local var_1_2 = var_0_0.decode(var_1_1)
		local var_1_3 = {}

		for iter_1_0, iter_1_1 in pairs(var_1_2) do
			var_1_3[tonumber(iter_1_0)] = iter_1_1
		end

		return var_1_3
	end
}
