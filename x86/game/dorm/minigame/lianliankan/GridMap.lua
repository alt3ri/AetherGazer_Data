local var_0_0 = class("GridMap")
local var_0_1 = 1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.map = {}
	arg_1_0.width = arg_1_1
	arg_1_0.height = arg_1_2
	arg_1_0.available = {}

	for iter_1_0 = 0, arg_1_1 - 1 do
		for iter_1_1 = 0, arg_1_2 - 1 do
			table.insert(arg_1_0.available, arg_1_0:ToIdx(iter_1_0, iter_1_1))
		end
	end
end

function var_0_0.ToIdx(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 < 0 or arg_2_1 >= arg_2_0.width or arg_2_2 < 0 or arg_2_2 >= arg_2_0.height then
		return nil
	end

	arg_2_1 = arg_2_1 + var_0_1
	arg_2_2 = arg_2_2 + var_0_1

	return arg_2_2 * (arg_2_0.width + 2 * var_0_1) + arg_2_1
end

function var_0_0.ToCoord(arg_3_0, arg_3_1)
	return arg_3_1 % (arg_3_0.width + 2 * var_0_1) - var_0_1, math.floor(arg_3_1 / (arg_3_0.width + 2 * var_0_1)) - var_0_1
end

function var_0_0.Get(arg_4_0, arg_4_1, arg_4_2)
	return nullable(arg_4_0.map, arg_4_0:ToIdx(arg_4_1, arg_4_2))
end

function var_0_0.IsGridInMap(arg_5_0, arg_5_1, arg_5_2)
	return arg_5_1 >= 0 and arg_5_1 < arg_5_0.width and arg_5_2 >= 0 and arg_5_2 < arg_5_0.height
end

function var_0_0.IsGridEmpty(arg_6_0, arg_6_1, arg_6_2)
	return arg_6_0:Get(arg_6_1, arg_6_2) == nil and arg_6_1 >= -1 and arg_6_1 <= arg_6_0.width and arg_6_2 >= -1 and arg_6_2 <= arg_6_0.height
end

function var_0_0.HasGridEmpty(arg_7_0, arg_7_1)
	if arg_7_1 > #arg_7_0.available then
		return nil
	end

	return unpack(arg_7_0.available, 1, arg_7_1)
end

function var_0_0.Put(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_0:ToIdx(arg_8_1, arg_8_2)

	if var_8_0 then
		local var_8_1 = arg_8_0.map[var_8_0]

		if var_8_1 == nil and arg_8_3 ~= nil then
			table.removebyvalue(arg_8_0.available, var_8_0)
		elseif var_8_1 ~= nil and arg_8_3 == nil then
			table.insert(arg_8_0.available, var_8_0)
		end

		arg_8_0.map[var_8_0] = arg_8_3
	end

	return var_8_0
end

function var_0_0.RndPut(arg_9_0, arg_9_1)
	if next(arg_9_0.available) == nil then
		return nil
	end

	local var_9_0 = math.random(#arg_9_0.available)

	arg_9_0.available[#arg_9_0.available], arg_9_0.available[var_9_0] = arg_9_0.available[var_9_0], arg_9_0.available[#arg_9_0.available]

	local var_9_1 = table.remove(arg_9_0.available)

	arg_9_0.map[var_9_1] = arg_9_1

	return var_9_1
end

function var_0_0.RemoveByIdx(arg_10_0, arg_10_1)
	if arg_10_0.map[arg_10_1] ~= nil then
		table.insert(arg_10_0.available, arg_10_1)

		arg_10_0.map[arg_10_1] = nil
	end
end

return var_0_0
