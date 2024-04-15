manager.net:Bind(76201, function (slot0)
	InviteData:InitInviteData(slot0)
	uv0.UpdateRedPoint()
	manager.notify:CallUpdateFunc(INVITE_PLOT_READ_REFRESH, plot_id)
end)
manager.notify:RegistListener(NEW_DAY, function ()
	if InviteData:GetDataByPara("drawItemId") == 0 or slot0 == nil then
		return
	end

	manager.redPoint:setTip(RedPointConst.INVITE_DRAW, 0)
end)
manager.notify:RegistListener(CURRENCY_UPDATE, function (slot0)
	if InviteData:GetDataByPara("drawItemId") == slot0 then
		manager.redPoint:setTip(RedPointConst.INVITE_DRAW, ItemTools.getItemNum(slot1) > 0 and 1 or 0)
	end
end)

return {
	CompletePlot = function (slot0, slot1)
		manager.net:SendWithLoadingNew(76202, {
			activity_id = slot0,
			plot_id = slot1
		}, 76203, function (slot0)
			if isSuccess(slot0.result) then
				InviteData:UpdateCompletePlotData(uv0)
				manager.notify:CallUpdateFunc(INVITE_PLOT_READ_REFRESH, uv1)
				uv2.UpdateRedPoint()
			else
				ShowTips(GetTips(slot0.result))
			end
		end)
	end,
	InitRedPointKey = function (slot0)
		manager.redPoint:addGroup(string.format("%s%s", ActivityTools.GetRedPointKey(slot0), slot0), {
			RedPointConst.INVITE_MAIN
		})
		manager.redPoint:addGroup(RedPointConst.DRAW, {
			RedPointConst.INVITE_DRAW
		})
	end,
	UpdateRedPoint = function ()
		manager.redPoint:setTip(RedPointConst.INVITE_DRAW, ItemTools.getItemNum(InviteData:GetDataByPara("drawItemId")) > 0 and 1 or 0)
		manager.redPoint:setTip(RedPointConst.INVITE_PLOT, InviteData:GetDataByPara("inviteTimes") > 0 and not InviteData:GetDataByPara("allComplete") and 1 or 0)
	end
}
