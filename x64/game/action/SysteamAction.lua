manager.net:Bind(10600, function(arg_1_0)
	SystemData:InitData(arg_1_0)
	SystemRedPoint:InitSystemUnlockDispatch()
	DrawData:RefreshNewDraw()
end)
manager.net:Bind(10602, function(arg_2_0)
	SystemData:ModifyData(arg_2_0)
	DrawData:RefreshNewDraw()
end)