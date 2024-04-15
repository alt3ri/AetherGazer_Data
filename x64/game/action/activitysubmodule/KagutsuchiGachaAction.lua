manager.net:Bind(76101, function (slot0)
	KagutsuchiGachaData:InitDrawData(slot0)
end)

return {
	StartDraw = function (slot0, slot1, slot2, slot3, slot4)
		manager.net:SendWithLoadingNew(76102, {
			activity_id = slot2,
			draw_num = slot1,
			pool_id = slot3
		}, 76103, function (slot0, slot1)
			uv0:OnGetDrawReward(slot0, slot1, uv1)
		end)
	end,
	OnGetDrawReward = function (slot0, slot1, slot2, slot3)
		if not isSuccess(slot1.result) then
			ShowTips(slot1.result)

			return
		end

		KagutsuchiGachaData:RefreshData(slot2.pool_id, slot1.reward_list)

		if slot2.activity_id == ActivityConst.KAGUTSUCHI_ACTIVITY then
			KagutsuchiWorkAction:UpdateRedPoint(slot4)
		end

		slot3(slot1, slot2)
	end
}
