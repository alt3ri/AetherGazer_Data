manager.net:Bind(68001, function (slot0)
	XH3rdFlipCardData:OnReceiveFlipCardData(slot0)
end)

return {
	sendStartFlipCardGameRequest = function (slot0, slot1)
		manager.net:SendWithLoadingNew(68002, {
			activity_id = slot1
		}, 68003, handler(uv0, uv0.handleStartFlipCardGameResult))
	end,
	handleStartFlipCardGameResult = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			XH3rdFlipCardTool:StartGame()
			manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_start", "")
		else
			ShowTips(string.format(GetTips("ACTIVITY_FLIP_CARD_COIN_NOT_ENOUGH"), ItemCfg[FlipCardCfg[XH3rdFlipCardData:GetActivityID()].cost_id].name))
		end

		manager.notify:Invoke(FLIP_CARD_START_GAME_RESULT)
	end,
	sendSettleFlipCardGameRequest = function (slot0, slot1, slot2, slot3, slot4)
		manager.net:SendWithLoadingNew(68004, {
			activity_id = slot1,
			is_success = slot2,
			use_seconds = slot3,
			pairing_times = slot4
		}, 68005, handler(uv0, uv0.handleSettleFlipCardGameResult))
	end,
	handleSettleFlipCardGameResult = function (slot0, slot1, slot2)
		if slot2.is_success then
			XH3rdFlipCardAction.UpdateTokenRedPoint()
		end

		if slot1.clue_id ~= 0 then
			XH3rdFlipCardData:UpdateClueData(slot1.clue_id)
		end

		manager.notify:Invoke(FLIP_CARD_GAME_RESULT, slot1.clue_id)
	end,
	sendViewClueRequest = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(68006, {
			activity_id = slot1,
			clue_id = slot2
		}, 68007, handler(uv0, uv0.handleViewClueResult))
	end,
	handleViewClueResult = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			XH3rdFlipCardData:UpdateClueData(slot2.clue_id)
			manager.notify:Invoke(FLIP_CARD_VIEW_CLUE_RESULT, slot2.clue_id)
		else
			ShowTips(GetTips(slot1.result))
		end
	end,
	InitRedPointKey = function (slot0, slot1)
		uv0.mainActivityId = slot1
		uv0.hasEnterGame = false
		slot2 = string.format
		slot3 = RedPointConst.ACTIVITY_2_2_FLIP_CARD
		slot7 = slot2("%s_%s_challenge", slot3, slot1)

		manager.redPoint:addGroup(slot7, {
			slot2("%s_%s_mainTask", slot3, slot1),
			slot2("%s_%s_token", slot3, slot1),
			slot2("%s_%s_clue", slot3, slot1)
		})
		manager.redPoint:addGroup(slot2("%s_%s", slot3, slot1), {
			slot2("%s_%s_subTask", slot3, slot1),
			slot7
		})

		slot11 = {}

		for slot15, slot16 in pairs(FlipCardCfg[slot1].details) do
			slot11[#slot11 + 1] = string.format("%s_%s_%s_clue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, slot1, slot16)
		end

		manager.redPoint:addGroup(string.format("%s_%s_clue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, slot1), slot11)
		manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function ()
			uv0.UpdateRedPoint()
		end)
		manager.notify:RegistListener(CURRENCY_UPDATE, function ()
			uv0.UpdateTokenRedPoint()
		end)
		uv0.UpdateSubTaskRedPoint()
		uv0.UpdateMainTaskRedPoint()
		uv0.UpdateTokenRedPoint()
	end,
	UpdateRedPoint = function ()
		uv0.UpdateSubTaskRedPoint()
		uv0.UpdateMainTaskRedPoint()
	end,
	UpdateSubTaskRedPoint = function ()
		for slot6, slot7 in ipairs(TaskData2:GetActivityTaskSortList(ActivityCfg[uv0.mainActivityId].sub_activity_list[1])) do
			if AssignmentCfg[slot7.id].need <= slot7.progress and slot7.complete_flag < 1 then
				manager.redPoint:setTip(string.format("%s_%s_subTask", RedPointConst.ACTIVITY_2_2_FLIP_CARD, slot0), 1)

				return
			end
		end

		manager.redPoint:setTip(string.format("%s_%s_subTask", RedPointConst.ACTIVITY_2_2_FLIP_CARD, slot0), 0)
	end,
	UpdateClueRedPoint = function ()
		for slot5, slot6 in pairs(FlipCardCfg[uv0.mainActivityId].details) do
			if XH3rdFlipCardData:CheckClueIsGetted(slot6) and not XH3rdFlipCardData:CheckClueIsViewed(slot6) then
				manager.redPoint:setTip(string.format("%s_%s_%s_clue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, slot0, slot6), 1)
			else
				manager.redPoint:setTip(string.format("%s_%s_%s_clue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, slot0, slot6), 0)
			end
		end
	end,
	UpdateMainTaskRedPoint = function ()
		for slot5, slot6 in ipairs(TaskData2:GetActivityTaskSortList(uv0.mainActivityId)) do
			if AssignmentCfg[slot6.id].need <= slot6.progress and slot6.complete_flag < 1 then
				manager.redPoint:setTip(string.format("%s_%s_mainTask", RedPointConst.ACTIVITY_2_2_FLIP_CARD, slot0), 1)

				return
			end
		end

		manager.redPoint:setTip(string.format("%s_%s_mainTask", RedPointConst.ACTIVITY_2_2_FLIP_CARD, slot0), 0)
	end,
	UpdateTokenRedPoint = function ()
		if ItemTools.getItemNum(FlipCardCfg[uv0.mainActivityId].cost_id) > 0 and not uv0.hasEnterGame then
			manager.redPoint:setTip(string.format("%s_%s_token", RedPointConst.ACTIVITY_2_2_FLIP_CARD, slot0), 1)
		else
			manager.redPoint:setTip(string.format("%s_%s_token", RedPointConst.ACTIVITY_2_2_FLIP_CARD, slot0), 0)
		end
	end
}
