local var_0_0 = singletonClass("ComponentBinder")

function var_0_0.BindCfgUI(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_2:GetComponent("ComponentCfger")

	if var_1_0 then
		local var_1_1 = var_1_0:GetLuaNames()
		local var_1_2 = var_1_0:GetComponentValues()

		for iter_1_0 = 0, var_1_1.Length - 1 do
			arg_1_1[var_1_1[iter_1_0]] = var_1_2[iter_1_0]
		end

		arg_1_1.guideComponents = {}

		local var_1_3 = var_1_0:GetGuideLuaNames()
		local var_1_4 = var_1_0:GetGuideComponentValues()

		for iter_1_1 = 0, var_1_3.Length - 1 do
			local var_1_5 = var_1_3[iter_1_1]
			local var_1_6 = var_1_4[iter_1_1]

			arg_1_1.guideComponents[var_1_5] = var_1_6
		end
	end
end

return var_0_0
