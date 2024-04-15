local var_0_0 = class("NewWarChessSectionSelectHeroView", SectionSelectHeroBaseView)

function var_0_0.OnEnter(arg_1_0)
	arg_1_0.super.OnEnter(arg_1_0)
	SetActive(arg_1_0.reservesBtn_.gameObject, false)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()
		manager.NewChessManager:ClearBattleData()
	end)
	SetActive(arg_1_0.chipPanel_, false)
	arg_1_0:CheckNewWarChessTeamRedPoint()
	arg_1_0:BindRedPoint()
end

function var_0_0.CheckNewWarChessTeamRedPoint(arg_3_0)
	local var_3_0 = NewWarChessData:GetHeroInfoList()
	local var_3_1 = {}
	local var_3_2 = false
	local var_3_3 = false

	for iter_3_0, iter_3_1 in pairs(arg_3_0.cacheHeroTeam_) do
		if iter_3_1 == 0 then
			var_3_2 = true
		else
			table.insert(var_3_1, iter_3_1)
		end
	end

	if var_3_2 then
		for iter_3_2, iter_3_3 in pairs(var_3_0) do
			if iter_3_3[2] > 0 and table.keyof(var_3_1, NewWarChessHeroCfg[iter_3_3[1]].hero_id) == nil then
				var_3_3 = true
			end
		end
	else
		var_3_3 = false
	end

	if var_3_3 then
		for iter_3_4, iter_3_5 in pairs(arg_3_0.cacheHeroTeam_) do
			if iter_3_5 == 0 then
				manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_HERO_USE .. iter_3_4, 1)
			else
				manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_HERO_USE .. iter_3_4, 0)
			end
		end
	else
		for iter_3_6, iter_3_7 in pairs(arg_3_0.cacheHeroTeam_) do
			manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_HERO_USE .. iter_3_6, 0)
		end
	end
end

function var_0_0.BindRedPoint(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.addBtnImg_) do
		manager.redPoint:bindUIandKey(iter_4_1.transform, RedPointConst.NEW_WARCHESS_HERO_USE .. iter_4_0)
	end
end

function var_0_0.UnBindRedPoint(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.addBtnImg_) do
		manager.redPoint:unbindUIandKey(iter_5_1.transform, RedPointConst.NEW_WARCHESS_HERO_USE .. iter_5_0)
	end
end

function var_0_0.GetHeroTeamInfoRoute(arg_6_0)
	return "/newWarChessHeroTeamInfoView"
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0.super.OnExit(arg_7_0)
	arg_7_0:UnBindRedPoint()
end

return var_0_0
