function slot1(slot0, slot1, slot2, slot3, slot4)
	_G.isLogining = true
	TMP_TIMESTAMP = os.time()
	_G.TMP_ACCOUNT_ID = tostring(slot0)
	_G.TMP_CHANNELID = slot2 or 0

	if _G.deviceInfo and _G.deviceInfo.androidId then
		_G.TMP_MAC_ADDRESS = tostring(_G.deviceInfo.androidId)
		_G.BRAND = _G.deviceInfo.brand
		_G.MODEL = _G.deviceInfo.model
		_G.SYSTEM = _G.deviceInfo.system
	elseif _G.deviceInfo then
		if _G.deviceInfo.uuid ~= nil then
			_G.TMP_MAC_ADDRESS = tostring(_G.deviceInfo.uuid)
		elseif _G.deviceInfo.idfa ~= nil then
			_G.TMP_MAC_ADDRESS = tostring(_G.deviceInfo.idfa)
		else
			_G.TMP_MAC_ADDRESS = "unknown"
		end

		_G.MODEL = _G.deviceInfo.model
		_G.BRAND = _G.deviceInfo.brand
		_G.SYSTEM = _G.deviceInfo.system
	else
		_G.TMP_MAC_ADDRESS = "unknown"
		_G.BRAND = "unknown"
		_G.SYSTEM = "unknown"
	end

	print("#gs_login# , 10038 _G.TMP_MAC_ADDRESS = " .. tostring(_G.TMP_MAC_ADDRESS))
	manager.net:GateWaySend(10038, {
		channel_id = slot2 or 0,
		account = _G.TMP_ACCOUNT_ID,
		token = slot1,
		timestamp = TMP_TIMESTAMP,
		device_id = _G.TMP_MAC_ADDRESS,
		app_id = slot3 or "channel_internal_app_id",
		platform_type = GameToSDK.PLATFORM_ID
	}, 10039, slot4, false, false)
end

function slot2(slot0)
	if slot0.countdown_info and slot0.countdown_info.is_countdown then
		JumpTools.OpenPageByJump("serveropencountdown", {
			countdown = slot0.countdown_info.open_time,
			content = slot0.countdown_info.content,
			now = slot0.countdown_info.timestamp
		})
	elseif _G.CHANNEL_MASTER_ID ~= 1 then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("SERVER_MAINTENANCE"),
			OkCallback = function ()
			end
		})
	else
		ShowMessageBox({
			isTop = true,
			content = GetTips("SERVER_MAINTENANCE"),
			BtnText = {
				[2] = GetTips("OPEN_FORUM")
			},
			OkCallback = function ()
			end,
			CancelCallback = function ()
				if _G.ChannelLoginInfo and _G.ChannelLoginInfo.channelToken then
					OperationAction.OpenOperationUrl("FORUM_URL", {
						gameAppId = _G.ChannelLoginInfo.channelAppId,
						token = _G.ChannelLoginInfo.channelToken
					})
				else
					OperationAction.OpenOperationUrl("FORUM_URL_HOME")
				end

				SDKTools.SendMessageToSDK("direction", {
					direction_type = 8,
					direction_channel = 2
				})
			end
		})
	end
end

function slot3(slot0)
	slot1 = SettingData:GetCurrentLanguage()

	for slot6, slot7 in ipairs(slot0.i18n_info) do
		-- Nothing
	end

	JumpTools.OpenPageByJump("banAccount", {
		banReason = ({
			[slot7.language] = slot7.string
		})[slot1] or slot0.ban_reason,
		banTimestamp = slot0.unblocking_time
	})
end

function slot4(slot0, slot1, slot2, slot3)
	if _G.deviceInfo and _G.deviceInfo.system then
		_G.deviceInfo.system = string.gsub(_G.deviceInfo.system, "[^0-9.]", "")
	end

	return manager.net:SendSyncNoEnqueue(10042, {
		b_game_base_id = 109036,
		channel_id = _G.TMP_CHANNELID,
		server_id = _G.TMP_SERVER_ID,
		account = _G.TMP_ACCOUNT_ID,
		user_id = slot0,
		b_sdk_udid = _G.CHANNEL_UDID,
		b_sdk_uid = _G.CHANNEL_USERID,
		b_tour_indicator = tonumber(_G.LOGIN_TYPE),
		b_game_id = tonumber(_G.B_SDK_ID),
		timestamp = TMP_TIMESTAMP,
		gstoken = slot1,
		platform_type = GameToSDK.PLATFORM_ID,
		device_id = _G.TMP_MAC_ADDRESS,
		client_vs = tostring(LuaForUtil.GetClientVersion()),
		os_vs = _G.deviceInfo and _G.deviceInfo.system or nil,
		phone = _G.AnalyticsPresetProperties["#manufacturer"],
		mac = _G.deviceInfo and _G.deviceInfo.mac or nil,
		imei = _G.deviceInfo and _G.deviceInfo.imei or nil,
		idfa = _G.deviceInfo and _G.deviceInfo.idfa or nil,
		distinct_id = _G.AnalyticsPresetProperties.distinctId,
		oaid = _G.deviceInfo and _G.deviceInfo.gaid or nil,
		master_channel_id = _G.CHANNEL_MASTER_ID,
		app_id = _G.APP_ID or "channel_internal_app_id",
		sub_id = _G.deviceInfo and tostring(_G.deviceInfo.subId) or nil,
		type = slot3 or LoginConst.LOGIN_TYPE.LOGIN,
		resource_vs = tostring(LuaForUtil.GetResourceVersion()),
		device_model = tostring(_G.MODEL),
		zone_offset = _G.AnalyticsPresetProperties["#zone_offset"] or 8,
		ram = tostring(UnityEngine.SystemInfo.systemMemorySize),
		rom = tostring(LuaForUtil.GetFreeDiskSpace()),
		cpu_hardware = tostring(_G.CPUINFO),
		network = tostring(_G.NETTYPE),
		language = SettingData:GetCurrentLanguage(),
		graph_device_id = tostring(UnityEngine.SystemInfo.graphicsDeviceID),
		graph_device_name = tostring(UnityEngine.SystemInfo.graphicsDeviceName),
		graph_memory_size = UnityEngine.SystemInfo.graphicsMemorySize,
		graph_device_vendor = tostring(UnityEngine.SystemInfo.graphicsDeviceVendor),
		graph_device_vendor_id = tostring(UnityEngine.SystemInfo.graphicsDeviceVendorID),
		graph_device_version = tostring(UnityEngine.SystemInfo.graphicsDeviceVersion)
	}, 10043, slot2, false, false)
end

slot5 = nil

return {
	GateWayLogin = function (slot0, slot1, slot2, slot3)
		if _G.isLogining then
			return
		end

		slot4 = manager.net:GetTCPState("gateway")
		slot5, slot6 = manager.net:GetConnectHostAndPort("gateway")

		if slot5 ~= GATEWAY_ADDR or GATEWAY_PORT ~= slot6 then
			manager.net:Disconnect()

			slot4 = "init"
		end

		if slot4 == "init" or slot4 == "none" then
			manager.net:GateWayConnect(GATEWAY_ADDR, GATEWAY_PORT, function (slot0)
				if slot0 == SocketError.Success then
					uv0(uv1, uv2, uv3, uv4, uv5.OnGateWayLogin)
				else
					ShowTips("ERROR_CONNECT_SERVER")
				end
			end)
		elseif slot4 == "disconnected" then
			manager.net:GateWayReconnect(function (slot0)
				if slot0 == SocketError.Success then
					uv0(uv1, uv2, uv3, uv4, uv5.OnGateWayLogin)
				else
					ShowTips("ERROR_CONNECT_SERVER")
				end
			end)
		elseif slot4 == "connected" then
			uv0(slot0, slot1, slot2, slot3, uv1.OnGateWayLogin)
		end
	end,
	OnGateWayLogin = function (slot0)
		if isSuccess(slot0.result) then
			print("data.ip, data.port", slot0.ip, slot0.port, slot0.server_id, slot0.user_id)

			_G.TCP_ADDR = slot0.ip
			_G.TCP_PORT = slot0.port
			_G.TMP_SERVER_ID = slot0.server_id
			_G.TMP_TIMESTAMP = slot0.timestamp

			uv0.Login(slot0.user_id, slot0.gstoken)

			_G.TMP_IS_NEW_PLAYER = slot0.is_new_player

			print("_G.TMP_IS_NEW_PLAYER", _G.TMP_IS_NEW_PLAYER)
			LuaForUtil.OnLoginSuccess(_G.TMP_CHANNELID, tostring(slot0.user_id), tostring(slot0.user_id), 0)
			NeedGameUserInfo()
			GameToSDK.UpUserInfo(string.format("{\"dataType\" : \"SelectServer\",\"serverId\" : %d}", _G.TMP_SERVER_ID))
		else
			_G.isLogining = false

			if slot0.result == LoginConst.ACCOUNT_BAN then
				uv1(slot0)
			elseif slot0.result == LoginConst.SERVER_MAINTAIN then
				uv2(slot0)
			else
				ShowTips(slot0.result)
			end
		end
	end,
	Login = function (slot0, slot1)
		slot2 = manager.net:GetTCPState("game")
		slot3, slot4 = manager.net:GetConnectHostAndPort("game")

		if slot3 ~= _G.TCP_ADDR or _G.TCP_PORT ~= slot4 then
			manager.net:Disconnect()

			slot2 = "init"
		end

		print(slot3, slot4, slot2)

		if slot2 == "init" or slot2 == "none" then
			manager.net:Connect(_G.TCP_ADDR, _G.TCP_PORT, function (slot0)
				if slot0 == SocketError.Success then
					uv0(uv1, uv2, uv3.OnLogin, LoginConst.LOGIN_TYPE.LOGIN)
				end
			end)
		elseif slot2 == "disconnected" then
			manager.net:Reconnect(function (slot0)
				if slot0 == SocketError.Success then
					uv0(uv1, uv2, uv3.OnLogin, LoginConst.LOGIN_TYPE.LOGIN)
				end
			end)
		elseif slot2 == "connected" then
			uv0(slot0, slot1, uv1.OnLogin, LoginConst.LOGIN_TYPE.LOGIN)
		end
	end,
	OnLogin = function (slot0, slot1)
		PlayerPrefs.SetString("UserID", slot1.user_id)
		PlayerPrefs.SetString("UserPwd", slot1.gstoken)

		USER_ID = slot1.user_id

		if isSuccess(slot0.result) then
			manager.time:SetServerTime(slot0.timestamp, slot0.verify_timestamp)
			manager.redPoint:InitData()
			InitData()
			PlayerAction.UserBaseInfoInit({
				userID = slot1.user_id,
				register_timestamp = slot0.register_timestamp,
				uid_sign = slot0.uid_sign
			})
			uv0.RequestGameData(LoginConst.LOGIN_TYPE.LOGIN)
			manager.net:SetIsPauseSendPacket(true)
		else
			_G.isLogining = false

			ShowTips(slot0.result)
		end

		uv0.LoginForSDK(slot0.register_timestamp)
	end,
	Reconnect = function ()
		slot0 = PlayerPrefs.GetString("UserID")
		slot1 = PlayerPrefs.GetString("UserPwd")

		if manager.net:GetTCPState("game") == "init" or slot2 == "none" then
			manager.net:Connect(_G.TCP_ADDR, _G.TCP_PORT, function ()
				uv0(uv1, uv2, uv3.OnReconnect, LoginConst.LOGIN_TYPE.RECONNECT)
			end)
		elseif slot2 == "disconnected" then
			manager.net:Reconnect(function (slot0)
				if slot0 == SocketError.Success then
					uv0(uv1, uv2, uv3.OnReconnect, LoginConst.LOGIN_TYPE.RECONNECT)
				end
			end)
		elseif slot2 == "connected" then
			uv0(slot0, slot1, uv1.OnReconnect, LoginConst.LOGIN_TYPE.RECONNECT)
		end
	end,
	OnReconnect = function (slot0)
		if isSuccess(slot0.result) then
			uv0.RequestGameData(LoginConst.LOGIN_TYPE.RECONNECT)
			manager.net:SetIsPauseSendPacket(true)
		else
			ConnectionHelper.ShowReturnToLoginTip(slot0.result)
		end
	end,
	RequestGameData = function (slot0)
		uv0 = slot0

		manager.net:SendSyncNoEnqueue(10200, {}, 10201, uv1.OnRequestGameData, false, false)
	end,
	OnRequestGameData = function (slot0, slot1)
		manager.net:SetIsPauseSendPacket(false)
		manager.net:AutoDequeueOn()
		PlayerAction.UserLoginTimestampInit({
			timestamp = slot0.timestamp
		})
		GameToSDK.UpUserEvent("{\"eventType\" : \"Begin\"}")
		SDKTools.SetSignInAttribute()

		slot2 = PlayerData:GetPlayerInfo().userID

		manager.ui:SetUIDText("ID:" .. slot2, slot2)
		GameToSDK.SendMessage(string.format("{\"messageType\" : \"SetPushNotificationAlias\", \"alias\" : \"%s\"}", PlayerData:GetPlayerInfo().userID))

		if uv0 == LoginConst.LOGIN_TYPE.RECONNECT then
			ActivityAction.OnLogin()

			return
		end

		slot4 = PlayerPrefs.GetString("UserID")

		GameLocalData:SaveUserInfoToUserData(slot4, {
			account = slot4,
			pwd = GodessPass
		})
		gameContext:SetSystemLayer("home")

		BattleCallLuaCallBackWait = false

		LateInitData()
		_G.gameListener:StartListen()
		PlayerAction.LevelUpFinish()
		HeroAction.RefreshHeroRedPointAfterSeverSendData()
		NeedGameUserInfo()

		if _G.TMP_IS_NEW_PLAYER and _G.TMP_IS_NEW_PLAYER == 1 then
			GameLocalData:ClearTargetUser(slot4)
			GameToSDK.UpUserInfo(PlayerTools.PackUserData("CreateRole"))
		end

		GameToSDK.UpUserInfo(PlayerTools.PackUserData("EnterGame"))

		if GameToSDK.CURRENT_SERVER == "zh_cn" then
			OperationAction.GetUnreadMsgResult()
		end

		if gameContext:GetOpenPageHandler("login") then
			slot7:PlayOut()
		end
	end,
	LoginForSDK = function (slot0)
		if _G.TMP_IS_NEW_PLAYER and _G.TMP_IS_NEW_PLAYER == 1 then
			SendMessageManagerToSDK("account_create_ys")
		end

		saveData("SDK", "register_timestamp", slot0)

		if manager.time:DiffDay2(slot0, manager.time:GetServerTime()) == 1 or slot1 == 6 or slot1 == 13 then
			SendMessageManagerToSDK("day_retention", {
				diff = slot1
			})
		end

		if getData("SDK", "lastTime") == nil then
			slot2 = 0
		end

		if getData("SDK", "continueTime") == nil then
			slot3 = 0
		end

		if slot2 and manager.time:DiffDay2(slot2, manager.time:GetServerTime()) == 1 then
			slot3 = slot3 + 1

			saveData("SDK", "continueTime", slot3)

			if slot3 == 1 or slot3 == 6 or slot3 == 13 then
				SendMessageManagerToSDK("day_retention_return")
			end
		elseif slot2 and manager.time:DiffDay2(slot2, manager.time:GetServerTime()) > 1 then
			saveData("SDK", "continueTime", 0)
		end

		saveData("SDK", "lastTime", manager.time:GetInstance():GetServerTime())
		SendMessageManagerToSDK("role_login")
	end
}
