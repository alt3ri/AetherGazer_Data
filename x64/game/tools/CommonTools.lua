local var_0_0 = {
	UniversalSort = function(arg_1_0, arg_1_1, ...)
		local var_1_0 = {
			...
		}

		local function var_1_1(arg_2_0, arg_2_1)
			for iter_2_0, iter_2_1 in ipairs(var_1_0) do
				if arg_2_0[iter_2_1] ~= arg_2_1[iter_2_1] then
					if arg_1_1 then
						return arg_2_0[iter_2_1] < arg_2_1[iter_2_1]
					else
						return arg_2_1[iter_2_1] < arg_2_0[iter_2_1]
					end
				end
			end
		end

		return table.sort(arg_1_0, var_1_1)
	end
}

local function var_0_1(arg_3_0, arg_3_1)
	return arg_3_0 < arg_3_1
end

local function var_0_2(arg_4_0)
	return arg_4_0
end

function var_0_0.UniversalSortEx(arg_5_0, ...)
	local var_5_0 = {
		...
	}

	local function var_5_1(arg_6_0, arg_6_1)
		for iter_6_0, iter_6_1 in pairs(var_5_0) do
			local var_6_0 = iter_6_1.map or var_0_2
			local var_6_1 = var_6_0(arg_6_0)
			local var_6_2 = var_6_0(arg_6_1)
			local var_6_3 = iter_6_1.ascend
			local var_6_4 = iter_6_1.lessOp or var_0_1

			if var_6_1 ~= var_6_2 then
				if var_6_3 then
					return var_6_4(var_6_1, var_6_2)
				else
					return var_6_4(var_6_2, var_6_1)
				end
			end
		end

		return false
	end

	return table.sort(arg_5_0, var_5_1)
end

function var_0_0.Convert2SamePosition(arg_7_0, arg_7_1)
	arg_7_0.position = arg_7_1.position
end

function var_0_0.GenerateItems(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	if not arg_8_0.pool then
		arg_8_0.pool = {}
	end

	local var_8_0 = #arg_8_0.pool
	local var_8_1 = #arg_8_1

	while var_8_1 < arg_8_2 do
		if var_8_0 > 0 then
			local var_8_2 = arg_8_0.pool[var_8_0]

			var_8_2.transform_:SetParent(arg_8_5)
			table.insert(arg_8_1, var_8_2)
			table.remove(arg_8_0.pool, var_8_0)

			var_8_0 = var_8_0 - 1
		else
			local var_8_3 = Object.Instantiate(arg_8_4, arg_8_5)
			local var_8_4 = arg_8_3.New(var_8_3)

			table.insert(arg_8_1, var_8_4)
		end

		var_8_1 = var_8_1 + 1
	end

	while arg_8_2 < var_8_1 do
		arg_8_1[var_8_1].gameObject_:SetActive(false)
		table.insert(arg_8_0.pool, arg_8_1[var_8_1])
		table.remove(arg_8_1, var_8_1)

		var_8_1 = var_8_1 - 1
	end

	for iter_8_0 = 1, var_8_1 do
		arg_8_1[iter_8_0].gameObject_:SetActive(true)
	end
end

function var_0_0.SetCommonData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2 = arg_9_2 or clone(ItemTemplateData)
	arg_9_2.number = nil

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		arg_9_2[iter_9_0] = iter_9_1
	end

	arg_9_0:SetData(arg_9_2)
end

return var_0_0
