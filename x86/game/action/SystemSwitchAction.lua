local var_0_0 = {}

manager.net:Bind(12041, function(arg_1_0)
	SystemSwitchData:SetData(arg_1_0)
	WarChessAction.UpdateWarChessRedPoint()
end)
manager.net:Bind(12043, function(arg_2_0)
	SystemSwitchData:UpdateData(arg_2_0)
	manager.notify:Invoke(SYSTEM_SWITCH_UPDATE)
end)

return var_0_0
