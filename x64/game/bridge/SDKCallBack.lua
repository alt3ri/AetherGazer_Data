local var_0_0 = require("cjson")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4

function OnGameSdkCallback(arg_1_0)
	local var_1_0 = var_0_0.decode(arg_1_0) or {}
	local var_1_1 = var_1_0.callbackType

	print("OnGameSdkCallback messageType", var_1_1, var_1_0.code)

	local var_1_2 = var_0_1[var_1_1]

	var_0_1[var_1_1] = nil

	if var_1_1 == "Login" then
		_G.LOGIN_TYPE = var_1_0.channelLoginType

		if tostring(var_1_0.channelLoginType) == "3" then
			_G.LOGIN_TYPE = 1
		else
			_G.LOGIN_TYPE = 0
		end

		_G.APP_ID = var_1_0.appId
		_G.YONGSHI_ID = var_1_0.id

		if Application.identifier == "com.biligamekr.agonestore" then
			_G.B_SDK_ID = 8266
		elseif GameToSDK.PLATFORM_ID == 0 then
			_G.B_SDK_ID = 8264
		elseif GameToSDK.PLATFORM_ID == 1 then
			_G.B_SDK_ID = 8265
		else
			_G.B_SDK_ID = 8264
		end

		print("Application.identifier", Application.identifier, var_1_0.channelLoginType)

		_G.CHANNEL_UDID = var_1_0.channelUdid
		_G.CHANNEL_USERID = var_1_0.channelUserId

		SDKTools.SetPublicAttribute({
			channel_id = var_1_0.channelId,
			yongshi_id = var_1_0.id
		})

		var_0_4 = var_1_0
		_G.CPUINFO = tostring(UnityEngine.SystemInfo.processorType .. "-" .. tostring(UnityEngine.SystemInfo.processorFrequency) .. "-" .. tostring(UnityEngine.SystemInfo.processorCount))
		_G.TMP_ACCOUNT_ID = tostring(var_0_4.id)

		local var_1_3 = "Not Reachable"

		if Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
			var_1_3 = "WIFI"
		elseif Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork then
			var_1_3 = "4G/5G"
		end

		_G.NETTYPE = var_1_3

		SendMessageManagerToSDK("SDKLoginSuccess")

		local var_1_4 = gameContext:GetOpenPageHandler("login")

		if var_1_4 then
			var_1_4:SetSDKId()
		end
	elseif var_1_1 == "Inited" then
		SDKInited()
	elseif var_1_1 == "ReLogin" then
		SDKTools.SetSignOutAttribute()
		ReconnectLogic.ReconnectError()

		var_0_4 = nil

		manager.notify:CallUpdateFunc(LOGIN_SEVER_UPDATE)
	elseif var_1_1 == "Exit" then
		Quit()
	elseif var_1_1 == "AntiAddiction" then
		AntiAddiction(var_1_0)
	elseif var_1_1 == "ShowQuitConfirm" then
		ShowQuitConfirm()
	elseif var_1_1 == "GetBulletin" then
		GetBulletin(var_1_0)
	elseif var_1_1 == "DeviceInfoGet" then
		DeviceInfoGet(var_1_0)
	elseif var_1_1 == "UpdateInfoGet" then
		UpdateInfoGet(var_1_0.info1, var_1_0.info2)
	elseif var_1_1 == "NeedGameUserInfo" then
		NeedGameUserInfo()
	elseif var_1_1 == "ReceivePushNotification" then
		ReceivePushNotification(var_1_0.message)
	elseif var_1_1 == "MarketCommentsNoSupport" then
		MarketCommentsNoSupport(var_1_0)
	elseif var_1_1 == "ChannelLoginInfoGet" then
		ChannelLoginInfoGet(var_1_0)
	elseif var_1_1 == "payResult" then
		manager.notify:Invoke(RECHARGE_SDK_SUCCESS)
	elseif var_1_1 == "payFailed" then
		local var_1_5 = var_1_0.errorMsg or ""

		ShowTips(var_1_5)
		print(string.format("充值失败， errorMsg = %s", var_1_5))
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_stop = gameContext.routes_[#gameContext.routes_]
		})
		manager.notify:Invoke(RECHARGE_FAILED, var_1_5)
	elseif var_1_1 == "LoginFailed" then
		_G.clickCDing_ = false
		_G.isLogining = false

		local var_1_6 = var_1_0.message or ""

		ShowTips(var_1_6)
		print(string.format("Login Failed, messager = %s", var_1_6))

		var_0_4 = nil

		SendMessageManagerToSDK("SDKLoginFailed")
	elseif var_1_1 == "CustomerServiceUnreadMsg" then
		local var_1_7 = var_1_0.num or 0

		print(string.format("CustomerServiceUnreadMsg, callbackInfo.num = %s", tostring(var_1_7)))
		manager.redPoint:setTip(RedPointConst.CUSTOMER_SERVICE_UNREAD, var_1_7 == 0 and 0 or 1)
	elseif var_1_1 == "iosWillPopupPay" then
		manager.notify:Invoke(RECHARGE_WILL_POPUP)
	elseif var_1_1 == "shareCallback" then
		local var_1_8 = var_1_0.code

		manager.notify:Invoke(SHARE_CALLBACK, var_1_8)

		if var_1_8 == 0 then
			ShowTips("SHARE_SUCCESS")
		elseif var_1_8 == 2 then
			ShowTips("SHARE_CANCEL")
		else
			local var_1_9 = GetTips("SHARE_FAIL")

			ShowTips(var_1_9)
		end
	elseif var_1_1 == "GetAgeTipCallback" then
		local var_1_10 = var_1_0.tip or ""

		if var_1_10 ~= nil and var_1_10 ~= "" then
			manager.notify:Invoke(AGE_TIP_CALLBACK, var_1_10)
		end
	elseif var_1_1 == "getPlatformData" then
		manager.notify:Invoke(GET_PLATFORM_DATA_CALLBACK, var_1_0)
	elseif var_1_1 == "SocailDiscordCancelAuth" then
		manager.notify:Invoke(SOCAIL_DISCORD_CANCEL, var_1_0)
	end

	if var_1_2 then
		if var_0_2[var_1_1] then
			var_0_2[var_1_1](var_1_0)

			var_0_2[var_1_1] = nil
		end

		if var_0_3 and var_0_3[var_1_1] and #var_0_3[var_1_1] > 0 then
			local var_1_11 = table.remove(var_0_3[var_1_1], 1)

			SendMessageToSDKWithCallBack(var_1_11.sendString, var_1_11.waitTag, var_1_11.callBack)
		end
	end
end

function SDKInited()
	GameToSDK.IsSDKInited = true
end

function GetBulletin(arg_3_0)
	_G.bulletinInfo = arg_3_0
	_G.bulletinInfoGetted = true
end

function GetSDKLoginInfo()
	return var_0_4
end

local var_0_5 = false

function EvokeGateWayLogin(arg_5_0)
	print("EvokeGateWayLogin selectRegionServerId : " .. (arg_5_0 or "null"))

	if var_0_4 and var_0_4.token then
		if not var_0_5 then
			var_0_5 = true

			RegionServerMgr.instance:UpdateRegionServerInfo(_G.TMP_ACCOUNT_ID or "", function(arg_6_0, arg_6_1)
				var_0_5 = false

				if _G.isLogining then
					return
				end

				local var_6_0 = true
				local var_6_1 = GetTips("SERVER_MAINTENANCE")
				local var_6_2 = RegionServerMgr.instance:GetRegionServerInfo(arg_5_0)

				if arg_6_0 and not isNil(var_6_2) then
					GATEWAY_ADDR = var_6_2.ip
					GATEWAY_PORT = var_6_2.port

					print("EvokeGateWayLogin Info " .. GATEWAY_ADDR .. GATEWAY_PORT)

					var_6_0 = var_6_2.maintain

					local var_6_3 = var_6_2.maintainReason

					if not string.isNullOrEmpty(var_6_3) then
						print(string.format("平台下发维护信息 ：%s", var_6_3))

						local var_6_4, var_6_5 = pcall(var_0_0.decode, var_6_3)

						if var_6_4 then
							local var_6_6 = SettingData:GetCurrentLanguage()

							if var_6_6 == "tc" and var_6_5.tw then
								var_6_1 = var_6_5.tw
							elseif var_6_6 == "zh_cn" and var_6_5.cn then
								var_6_1 = var_6_5.cn
							elseif var_6_5[var_6_6] then
								var_6_1 = var_6_5[var_6_6]
							end
						else
							var_6_1 = var_6_3
						end
					end

					local var_6_7 = gameContext:GetOpenPageHandler("login")

					if var_6_7 then
						var_6_7:SetSDKId()
					end
				else
					print("EvokeGateWayLogin UpdateRegionServerInfo fail")

					var_6_0 = true
				end

				if arg_6_0 then
					manager.notify:CallUpdateFunc(LOGIN_SEVER_UPDATE)
				end

				if var_6_0 then
					print("EvokeGateWayLogin Maintain")
					ShowMessageBox({
						ButtonType = "SingleBtn",
						isTop = true,
						content = var_6_1,
						OkCallback = function()
							return
						end
					})
				else
					print("唤起网关登录")
					PlayerPrefs.SetString("RegionServerId", arg_5_0)
					RegionServerMgr.instance:UpdateClintConfigs(arg_5_0)
					GateWayLogin(var_0_4)
				end
			end)
		end

		return true
	else
		return false
	end
end

function GateWayLogin(arg_8_0)
	SendMessageToSDKWithCallBack("{\"messageType\" : \"GetChannelLoginInfo\"}", "ChannelLoginInfoGet", function()
		print("sdk登录信息返回")

		if _G.ChannelLoginInfo.code == 0 then
			CheckVersion(function()
				print(string.format("请求网关登录: id = %s, token = %s, channelId = %s, appId = %s", arg_8_0.id, arg_8_0.token, arg_8_0.channelId, arg_8_0.appId))
				LoginAction.GateWayLogin(arg_8_0.id, arg_8_0.token, arg_8_0.channelId, arg_8_0.appId)
			end)
		end
	end)
end

local var_0_6 = false

function ShowQuitConfirm()
	if var_0_6 then
		return
	end

	var_0_6 = true

	ShowMessageBox({
		isTop = true,
		content = GetTips("TIP_QUIT_GAME"),
		OkCallback = function()
			var_0_6 = false

			Quit()
		end,
		CancelCallback = function()
			var_0_6 = false
		end,
		MaskCallback = function()
			var_0_6 = false
		end
	})
end

function AntiAddiction(arg_15_0)
	local var_15_0 = arg_15_0.sdkTip ~= nil and arg_15_0.sdkTip or GetTips("ANTIADDICTION_ONLINE_TIME_LIMIT")

	ShowMessageBox({
		isTop = true,
		ButtonType = "SingleBtn",
		content = var_15_0,
		OkCallback = function()
			ReconnectLogic.ReconnectError()
		end,
		CancelCallback = function()
			return
		end
	})
end

function DeviceInfoGet(arg_18_0)
	_G.deviceInfo = arg_18_0

	for iter_18_0, iter_18_1 in pairs(arg_18_0) do
		print(string.format("deviceInfo.%s = %s", iter_18_0, iter_18_1))
	end
end

function MarketCommentsNoSupport()
	local var_19_0 = {
		gameAppId = _G.ChannelLoginInfo.channelAppId,
		token = _G.ChannelLoginInfo.channelToken
	}

	OperationAction.OpenOperationUrl("OFFICIAL_DISCUSS_URL", var_19_0)
end

function ChannelLoginInfoGet(arg_20_0)
	_G.ChannelLoginInfo = arg_20_0
end

function NeedGameUserInfo()
	local var_21_0 = PlayerData:GetPlayerInfo()
	local var_21_1 = _G.TMP_ACCOUNT_ID
	local var_21_2 = var_21_0.nick
	local var_21_3 = var_21_0.userID

	if var_21_0.userID == 1 then
		return
	end

	local var_21_4 = BattleChapterStageCfg[BattleInstance.GetCurrentBattleId()].name
	local var_21_5 = manager.time:STimeDescS(var_21_0.register_timestamp, "!%Y/%m/%d %H:%M")
	local var_21_6 = var_21_0.userLevel
	local var_21_7 = TowerData:GetTowerMaxId()
	local var_21_8 = BattleTowerStageCfg[var_21_7] and BattleTowerStageCfg[var_21_7].name or ""
	local var_21_9 = tostring(_G.CHANNEL_MASTER_ID)
	local var_21_10 = tostring(RechargeData:GetTotalRechargeNum())
	local var_21_11 = "暂无区组"
	local var_21_12 = tostring(_G.YONGSHI_ID)
	local var_21_13 = tostring(TowerData:GetTowerMaxId())
	local var_21_14 = _G.TMP_SERVER_ID
	local var_21_15 = CurrencyData:GetRechargeDiamond()

	SendMessageToSDK(string.format("{\"messageType\" : \"SendGameUserInfo\", \"accountId\" : \"%s\",\"nickName\" : \"%s\" , \"uId\" : \"%d\", \"maxChapterLevel\" : \"%s\", \"createTime\" : \"%s\", \"userLv\" : \"%d\", \"maxChallengeLv\" : \"%s\", \"channel\" : \"%s\", \"rechargeNum\" : \"%s\", \"region\" : \"%s\", \"mixId\" : \"%s\", \"maxTower\" : \"%s\", \"serverId\" : \"%d\", \"currency\" : \"%d\" }", var_21_1, var_21_2, var_21_3, var_21_4, var_21_5, var_21_6, var_21_8, var_21_9, var_21_10, var_21_11, var_21_12, var_21_13, var_21_14, var_21_15))
	GameToSDK.UpUserInfo(PlayerTools.PackUserData("UpdateData"))
end

function ReceivePushNotification(arg_22_0)
	ShowTips(arg_22_0)
end

function SendMessageToSDK(arg_23_0)
	GameToSDK.SendMessage(arg_23_0)
end

function SendMessageToSDKWithCallBack(arg_24_0, arg_24_1, arg_24_2)
	if var_0_1[arg_24_1] then
		if var_0_3[arg_24_1] == nil then
			var_0_3[arg_24_1] = {}
		end

		table.insert(var_0_3[arg_24_1], {
			sendString = arg_24_0,
			waitTag = arg_24_1,
			callBack = arg_24_2
		})

		return
	end

	print("SendMessageToSDKWithCallBack", arg_24_0, arg_24_1)
	GameToSDK.SendMessage(arg_24_0)

	if GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV then
		arg_24_2()

		return
	end

	var_0_1[arg_24_1] = true
	var_0_2[arg_24_1] = arg_24_2
end

function ReceiveSavePhotoMessage(arg_25_0, arg_25_1)
	if arg_25_0 then
		ShowTips("SAVE_PHOTO_SUCCESS")
	else
		ShowTips("SAVE_PHOTO_FAIL")
	end
end
