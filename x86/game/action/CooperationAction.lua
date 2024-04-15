manager.net:Bind(54101, function (slot0)
	CooperationData:InitRoomData(slot0.room_info)
	manager.notify:CallUpdateFunc(COOPERATION_ROOM_INIT)
end)
manager.net:Bind(54103, function (slot0)
	CooperationData:UpdateRoomData(slot0.room_info)
	manager.notify:CallUpdateFunc(COOPERATION_ROOM_UPDATE)
end)

slot1 = "0"

manager.net:Bind(54201, function (slot0)
	slot1 = CooperationData:GetRoomData()

	if whereami ~= "home" then
		if slot0.room_info and uv0 ~= slot0.room_info.room_id then
			CooperationData:InitRoomData(slot0.room_info)
		else
			CooperationData:ClearRoomData()
		end
	elseif slot0.room_info == nil or uv0 == slot0.room_info.room_id then
		if slot1 ~= nil then
			CooperationData:ClearRoomData()
			CooperationTools.GotoCooperationEntry(slot1.type, slot1.dest, slot1.activity_id)
		else
			CooperationData:ClearRoomData()
		end
	else
		CooperationData:InitRoomData(slot0.room_info)
		manager.notify:CallUpdateFunc(COOPERATION_ROOM_INIT)
	end
end)
manager.net:Bind(37097, function (slot0)
	CooperationData:SetIsMatching(false)
	manager.notify:CallUpdateFunc(COOPERATION_IS_MATCHING_CHANGE)

	if isSuccess(slot0.result) then
		ChatCooperationData:RemoveChatData()
		CooperationTools.GotoCooperation()
	else
		ShowTips(slot0.result)
	end
end)
manager.net:Bind(37099, function (slot0)
	if CooperationData:GetRoomData() == nil then
		return
	end

	slot2 = slot1.type
	slot3 = slot1.dest
	slot4 = slot1.activity_id

	CooperationData:ClearRoomData()

	if whereami ~= "home" then
		return
	end

	CooperationTools.GotoCooperationEntry(slot2, slot3, slot4)

	slot5 = slot0.reason

	ShowTips("COOPERATION_LEAVE_ROOM")
end)
manager.net:Bind(37101, function (slot0)
	CooperationData:InitInviteInfo(slot0)
	manager.notify:CallUpdateFunc(COOPERATION_INVIT_UPDATE)

	if CooperationData:CheckInviteEntryShow() then
		manager.redPoint:setTip(RedPointConst.COOPERATION_INVIT, 1)
	end
end)
manager.net:Bind(37103, function (slot0)
	if uv0.CheckCooperationApplyLimit() then
		return
	end

	CooperationData:AddInviteInfo(slot0)
	manager.notify:CallUpdateFunc(COOPERATION_INVIT_UPDATE)
	manager.redPoint:setTip(RedPointConst.COOPERATION_INVIT, 1)
end)

return {
	CreateRoom = function (slot0, slot1, slot2, slot3, slot4)
		if slot4 == nil then
			slot4 = 2
		end

		if slot3 == nil then
			slot3 = 0
		end

		manager.net:SendWithLoadingNew(37010, {
			dest = slot0,
			type = slot1,
			available = slot4,
			hero_list = slot2,
			battle_vs = LuaForUtil.GetBattleVersion(),
			activity_id = slot3
		}, 37011, uv0.OnCreateRoomBack)
	end,
	OnCreateRoomBack = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	JoinRoom = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(37012, {
			room_id = slot0,
			hero_list = slot1 or {},
			battle_vs = LuaForUtil.GetBattleVersion(),
			source = slot2
		}, 37013, uv0.OnJoinRoomBack)
	end,
	OnJoinRoomBack = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	StartMatching = function (slot0, slot1, slot2, slot3)
		if not CooperationData:GetIsMatching() then
			manager.net:SendWithLoadingNew(37036, {
				dest = slot0,
				type = slot1,
				hero_list = slot2,
				activity_id = slot3,
				battle_vs = LuaForUtil.GetBattleVersion()
			}, 37037, uv0.OnStartMatchingBack)
		end
	end,
	OnStartMatchingBack = function (slot0)
		if isSuccess(slot0.result) then
			CooperationData:SetIsMatching(true)
			manager.notify:CallUpdateFunc(COOPERATION_IS_MATCHING_CHANGE)
		else
			ShowTips(slot0.result)
		end
	end,
	CancelMatching = function ()
		if CooperationData:GetIsMatching() then
			manager.net:SendWithLoadingNew(37038, {}, 37039, uv0.OnCancelMatchingBack)
		end
	end,
	OnCancelMatchingBack = function (slot0)
		if isSuccess(slot0.result) then
			CooperationData:SetIsMatching(false)
			manager.notify:CallUpdateFunc(COOPERATION_IS_MATCHING_CHANGE)
			ShowTips("COOPERATION_CANCEL_MATCH_TIP")
		else
			ShowTips(slot0.result)
		end
	end,
	ChangeHero = function (slot0)
		manager.net:SendWithLoadingNew(37016, {
			hero_list = slot0
		}, 37017, uv0.OnChangeHeroBack)
	end,
	OnChangeHeroBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			CooperationData:SetCooperationHero(slot1.hero_list[1])
			CooperationTools.GotoCooperation()
		else
			ShowTips(slot0.result)
		end
	end,
	LeaveRoom = function ()
		manager.net:SendWithLoadingNew(37018, {}, 37019, uv0.OnLeaveRoomBack)
	end,
	OnLeaveRoomBack = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	LeaveCooperationBattle = function (slot0, slot1)
		if CooperationData:GetRoomData() then
			manager.net:SendWithLoadingNew(37018, {
				battle_id = slot1
			}, 37019, function (slot0)
				uv0()
			end)
		else
			slot0()
		end
	end,
	KickOutRoom = function (slot0)
		manager.net:SendWithLoadingNew(37020, {
			uid = slot0
		}, 37021, uv0.OnKickOutRoomBack)
	end,
	OnKickOutRoomBack = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	ChangeRoomMaster = function (slot0)
		manager.net:SendWithLoadingNew(37022, {
			uid = slot0
		}, 37023, uv0.OnChangeRoomMasterBack)
	end,
	OnChangeRoomMasterBack = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	GetReady = function ()
		manager.net:SendWithLoadingNew(37024, {}, 37025, uv0.OnGetReadyBack)
	end,
	OnGetReadyBack = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	CancelReay = function ()
		manager.net:SendWithLoadingNew(37026, {}, 37027, uv0.OnCancelReadyBack)
	end,
	OnCancelReadyBack = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	ChangeRoomAvailable = function (slot0)
		manager.net:SendWithLoadingNew(37028, {
			available = slot0
		}, 37029, uv0.OnRoomAvailableBack)
	end,
	OnRoomAvailableBack = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	SendMsg = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(37030, {
			type = ChatConst.CHAT_CONTENT_TYPE.TEXT,
			content = slot0
		}, 37031, function (slot0)
			uv0(slot0)
		end)
	end,
	SendSticker = function (slot0, slot1)
		manager.net:SendWithLoadingNew(37030, {
			type = ChatConst.CHAT_CONTENT_TYPE.STICKER,
			content = tostring(slot0)
		}, 37031, function (slot0)
			uv0(slot0)
		end)
	end,
	ThumbsUp = function (slot0)
		manager.net:SendWithLoadingNew(37034, {
			uid = slot0
		}, 37035, uv0.OnThumbsUpBack)
	end,
	OnThumbsUpBack = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	CooperationReport = function (slot0, slot1)
		manager.net:SendWithLoadingNew(57006, {
			user_id = slot0,
			battle_id = slot1
		}, 57007, uv0.OnCooperationReportBack)
	end,
	OnCooperationReportBack = function (slot0)
		if isSuccess(slot0.result) then
			-- Nothing
		end
	end,
	InvitePlayer = function (slot0, slot1)
		manager.net:SendWithLoadingNew(37110, {
			uid = slot0,
			type = slot1
		}, 37111, uv0.OnInvitePlayerBack)
	end,
	OnInvitePlayerBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			CooperationData:SetHadInvited(slot1.uid, slot1.type)
			manager.notify:CallUpdateFunc(COOPERATION_INVIT_SUCCESS)
		else
			ShowTips(slot0.result)
		end
	end,
	DelectInvite = function (slot0)
		manager.net:SendWithLoadingNew(37112, {
			uid_list = slot0
		}, 37113, uv0.OnDelectInviteBack)
	end,
	OnDelectInviteBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			for slot5, slot6 in ipairs(slot1.uid_list) do
				CooperationData:DelectInvite(slot6)
			end

			manager.notify:CallUpdateFunc(COOPERATION_INVIT_REFUSE, slot1.uid_list)
		else
			ShowTips(slot0.result)
		end
	end,
	ClearInvite = function ()
		slot0 = {}

		if table.length(CooperationData:GetAllInviteList()) <= 0 then
			CooperationData:ClearInvite()
			manager.notify:CallUpdateFunc(COOPERATION_INVIT_CLEAR)

			return
		end

		for slot5, slot6 in pairs(slot1) do
			table.insert(slot0, slot6.uid)
		end

		manager.net:SendWithLoadingNew(37112, {
			uid_list = slot0
		}, 37113, uv0.OnClearInviteBack)
	end,
	OnClearInviteBack = function (slot0)
		if isSuccess(slot0.result) then
			CooperationData:ClearInvite()
			manager.notify:CallUpdateFunc(COOPERATION_INVIT_CLEAR)
		else
			ShowTips(slot0.result)
		end
	end,
	ReceiveInvite = function (slot0)
		manager.net:SendWithLoadingNew(37120, {
			uid = slot0
		}, 37121, uv0.OnReceiveInviteBack)
	end,
	OnReceiveInviteBack = function (slot0, slot1)
		slot2 = slot1.uid

		if isSuccess(slot0.result) then
			if CooperationData:GetInvite(slot2) then
				if slot3:IsOverdue() then
					ShowTips("COOPERATION_INVITE_OVERDUE")
				elseif slot3.activity_id == 0 or ActivityTools.GetActivityIsOpenWithTip(slot3.activity_id, true) then
					uv0.JoinRoom(slot3.room_id, {
						CooperationData:GetCooperationHero(slot3.battle_type, slot3.dest, slot3.activity_id)
					}, CooperationConst.JOIN_ROOM_SOURCE.INVET)
				end
			end

			CooperationData:DelectInvite(slot2)
			manager.notify:CallUpdateFunc(COOPERATION_INVIT_CLEAR)
		else
			ShowTips(slot0.result)
			CooperationData:DelectInvite(slot2)
			manager.notify:CallUpdateFunc(COOPERATION_INVIT_CLEAR)
		end
	end,
	SetInviteRestrict = function (slot0, slot1)
		manager.net:SendWithLoadingNew(37114, {
			type = slot0,
			op = slot1
		}, 37115, uv0.OnSetInvitRestrictBack)
	end,
	OnSetInvitRestrictBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			CooperationData:SetInviteRestrict(slot1.type, slot1.op)
			manager.notify:CallUpdateFunc(COOPERATION_INVIT_RESTRICT_UPDATE)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryRecentVisit = function ()
		manager.net:SendWithLoadingNew(37116, {}, 37117, uv0.OnQueryRecentVisitBack)
	end,
	OnQueryRecentVisitBack = function (slot0)
		if isSuccess(slot0.result) then
			CooperationData:InitVisiteList(slot0)
			manager.notify:CallUpdateFunc(COOPERATION_RECENT_VISIT_UPDATE)
		else
			ShowTips(slot0.result)
		end
	end,
	RequestInviteList = function (slot0)
		manager.net:SendWithLoadingNew(37118, {
			type = slot0
		}, 37119, uv0.OnRequestInviteListCallback)
	end,
	OnRequestInviteListCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			for slot6, slot7 in ipairs(slot0.invite_list) do
				for slot11, slot12 in ipairs(slot7.player_list) do
					slot13 = {
						uid = slot12.uid,
						nick = slot12.user_base_info.nick,
						icon = slot12.user_base_info.icon,
						icon_frame = slot12.user_base_info.icon_frame,
						level = slot12.level,
						timestamp = slot12.timestamp,
						activity_data_list = {}
					}

					for slot17, slot18 in ipairs(slot12.activity_data_list) do
						table.insert(slot13.activity_data_list, {
							enum = slot18.enum,
							data = slot18.data
						})
					end

					table.insert(slot2[slot7.type], slot13)
				end
			end

			manager.notify:CallUpdateFunc(COOPERATION_INVITE_LIST_UPDATE, {
				[slot7.type] = {}
			})
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	CheckCooperationApplyLimit = function (slot0)
		if PlayerData:GetPlayerInfo().userLevel < GameSetting.activity_main_plot_unlock_level.value[1] then
			if slot0 then
				ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot1))
			end

			return true
		end

		return false
	end
}
