manager.net:Bind(16015, function (slot0)
	DrawData:InitPool(slot0)
end)

return {
	GoToDraw = function (slot0, slot1, slot2, slot3)
		manager.net:SendWithLoadingNew(16010, {
			type = slot1,
			pool = slot0,
			cost = {
				id = slot2,
				num = slot3
			}
		}, 16011, uv0.OnGoToDraw)
	end,
	OnGoToDraw = function (slot0, slot1)
		if slot0.result == 0 then
			slot2 = 0

			if DrawConst.DRAW_TYPE.ONE == slot1.type then
				slot2 = 1

				SendMessageManagerToSDK("roll_complete_1")
			elseif DrawConst.DRAW_TYPE.TEN == slot1.type then
				slot2 = 10

				SendMessageManagerToSDK("roll_complete_10")
			end

			DrawData:UpdatePool(slot1.pool, slot0.ssr_draw_times, slot0.first_ssr_draw_flag, slot0.newbie_choose_draw_flag)
			AchievementAction.SendMessageForDrawAction(slot0, slot1)
		end

		DrawData:SetDrawRecord(slot1.pool, nil)
		manager.notify:CallUpdateFunc(GO_TO_DRAW, slot0, slot1)
	end,
	RequestRecord = function (slot0)
		manager.net:SendWithLoadingNew(16012, {
			id = slot0
		}, 16013, uv0.OnRequestRecord)
	end,
	OnRequestRecord = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DrawData:SetDrawRecord(slot1.id, slot0)
			manager.notify:CallUpdateFunc(REQUEST_RECORD, slot0, slot1)
		end
	end,
	SetPollUpID = function (slot0, slot1)
		manager.net:SendWithLoadingNew(16016, {
			id = slot0,
			up = DrawData:ConvertUpId(slot0, slot1, 0)
		}, 16017, uv0.OnSetPollUpID)
	end,
	OnSetPollUpID = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot1.up = DrawData:ConvertUpId(slot1.id, slot1.up, 1)

			DrawData:SetPollUpID(slot1.id, slot1.up)
			manager.notify:CallUpdateFunc(SET_POLL_UP_ID, slot0, slot1)
		else
			ShowTips(slot0.result)
			JumpTools.GoToSystem("/draw", nil, ViewConst.SYSTEM_ID.DRAW)
		end
	end,
	SetPollUpIDIgnoreFail = function (slot0, slot1)
		manager.net:SendWithLoadingNew(16016, {
			id = slot0,
			up = slot1
		}, 16017, uv0.JumpToPool)
	end,
	JumpToPool = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot1.up = DrawData:ConvertUpId(slot1.id, slot1.up, 1)

			DrawData:SetPollUpID(slot1.id, slot1.up)
			manager.notify:CallUpdateFunc(SET_POLL_UP_ID, slot0, slot1)
			JumpTools.GoToSystem("/draw", {
				poolId = slot1.id
			}, ViewConst.SYSTEM_ID.DRAW)
		end
	end,
	GetPoolData = function (slot0)
		if DrawData:GetPoolData(slot0) and not DrawData:GetPollUpID(slot0) then
			JumpTools.OpenPageByJump("drawInfoPopView", {
				poolId = slot0
			})

			return
		end

		manager.net:SendWithLoadingNew(16018, {
			id = slot0
		}, 16019, uv0.OnGetPoolData)
	end,
	OnGetPoolData = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DrawData:SetPoolData(slot1.id, slot0.pool_details)
			JumpTools.OpenPageByJump("drawInfoPopView", {
				poolId = slot1.id
			})
		else
			ShowTips(slot0.result)
		end
	end,
	HidePoolNewTag = function (slot0, slot1)
		if DrawData:GetPoolIsNew(slot0) == 1 then
			manager.net:SendWithLoadingNew(16020, {
				pool_id = slot0
			}, 16021, uv0.OnHidePoolNewTag)

			uv0.redPointCallback_ = slot1
		end
	end,
	OnHidePoolNewTag = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = slot1.pool_id

			DrawData:SetPoolIsNew(slot2, 0)
			uv0.redPointCallback_(false, slot2)
		end
	end
}
