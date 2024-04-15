local var_0_0 = class("PopularEventItem", CommonItem)

function var_0_0.ShowPresent(arg_1_0, arg_1_1)
	SetActive(arg_1_0.presentGo_, arg_1_1)
end

function var_0_0.ShowSelect(arg_2_0, arg_2_1)
	SetActive(arg_2_0.selectGo_, arg_2_1)
end

return var_0_0
