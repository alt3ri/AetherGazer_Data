local var_0_0 = class("LoginRender", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/LoginInterface/LoginInterface"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

local var_0_1 = false

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	local var_4_0 = GameToSDK.CURRENT_SERVER

	arg_4_0.isOverSeas_ = var_4_0 ~= nil and var_4_0 ~= "" and var_4_0 ~= "zh_cn"
	arg_4_0.myID = PlayerPrefs.GetString("AccountID")

	arg_4_0:UpdateAccount(arg_4_0.myID)

	_G.isLogining = false
	arg_4_0.serverList_ = {
		{
			port = 8102,
			text = "本地服",
			host = "127.0.0.1"
		}
	}

	if not SDKTools.IsSDK() then
		arg_4_0.serverList_ = require("lua_exclude/innerLoginList"):GetLoginList()
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0.serverList_) do
		arg_4_0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(iter_4_1.text))
	end

	arg_4_0.dropDown_:RefreshShownValue()

	arg_4_0.currentServerIndex_ = tonumber(PlayerPrefs.GetString("SelectServer")) or 1

	if GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV then
		arg_4_0.dropDown_.value = arg_4_0.currentServerIndex_ - 1
	end

	arg_4_0:RefreshState()

	arg_4_0.versionName_.text = "VersionName: " .. LuaForUtil.GetResourceVersionName()
	arg_4_0.clientVersion_.text = "ClientVersion: " .. LuaForUtil.GetClientVersion()
	arg_4_0.resourceVersion_.text = "ResourceVersion: " .. LuaForUtil.GetResourceVersion()
	arg_4_0.battleVersion_.text = "BattleVersion: " .. LuaForUtil.GetBattleVersion()
	_G.bulletinInfoGetted = false

	GameToSDK.SendMessage("{\"messageType\" : \"GetAgeTip\"}")
	arg_4_0:WaitForBulletin()

	arg_4_0.criMovie_ = arg_4_0.movieGo_:GetComponent("CriManaMovieControllerForUI")
	arg_4_0.criplayer_ = arg_4_0.criMovie_.player

	local var_4_1 = manager.audio:GetEffectVolume()

	arg_4_0.criplayer_:SetVolume(var_4_1)
	print("server", GameToSDK.CURRENT_SERVER)
	print("serverList", GameToSDK.SERVER_LIST)
	DealAreaDifferenceCfg(GameToSDK.CURRENT_SERVER)

	local var_4_2 = GameToSDK.SERVER_LIST.Length

	SetActive(arg_4_0.selectRegion_.gameObject, var_4_2 > 1)
	arg_4_0:AddOperationListener()
	arg_4_0:AddBtnListenerScale(arg_4_0.startupBtn_, nil, handler(arg_4_0, arg_4_0.TryToLoginIn))
	arg_4_0:AddBtnListener(arg_4_0.deleteFolderBtn_, nil, function()
		if _G.isLogining then
			return
		end

		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("VERIFY_ASSETS_BEFORE_CONFIRM"),
			OkCallback = function()
				JumpTools.OpenPageByJump("repairAssetsView")
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.levelBtn_, nil, function()
		SetActive(arg_4_0.ageLimitGo_, true)
	end)
	arg_4_0:AddBtnListener(arg_4_0.ageLimitOkBtn_, nil, function()
		SetActive(arg_4_0.ageLimitGo_, false)
	end)
	arg_4_0:AddBtnListener(arg_4_0.ageLimitBgBtn_, nil, function()
		SetActive(arg_4_0.ageLimitGo_, false)
	end)

	if var_4_2 > 1 then
		local var_4_3 = 0

		for iter_4_2 = 0, var_4_2 - 1 do
			if GameToSDK.CURRENT_SERVER == GameToSDK.SERVER_LIST[iter_4_2] then
				var_4_3 = iter_4_2
			end

			local var_4_4 = AreaDifferenceCfg[GameToSDK.SERVER_LIST[iter_4_2]]

			arg_4_0.selectRegion_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(var_4_4.name))
		end

		arg_4_0.selectRegion_:RefreshShownValue()

		arg_4_0.selectRegion_.value = var_4_3

		arg_4_0.selectRegion_.onValueChanged:AddListener(function(arg_11_0)
			if arg_11_0 ~= var_4_3 then
				ShowMessageBox({
					content = GetTips("CHANGE_SERVER"),
					OkCallback = function()
						PlayerPrefs.SetInt("SERVER_DEFAULT_SELECT_INDEX", arg_11_0)
						Quit()
					end,
					CancelCallback = function()
						arg_4_0.selectRegion_.value = var_4_3
					end
				})
			end
		end)
	end

	arg_4_0.serverMaintainController = arg_4_0.m_controller:GetController("serverMaintain")
	arg_4_0.serverShowController = arg_4_0.m_controller:GetController("serverShow")
	arg_4_0.serverNewTagController = arg_4_0.m_controller:GetController("serverNewTag")

	arg_4_0.serverShowController:SetSelectedIndex(0)
	arg_4_0:AddBtnListener(arg_4_0.m_serverBtn, nil, function()
		gameContext:Go("loginSeverSelectPop")
	end)
end

function var_0_0.AddOperationListener(arg_15_0)
	arg_15_0:AddBtnListener(arg_15_0.suggestBtn_, nil, function()
		SendMessageToSDK("{\"messageType\" : \"StartCustomerService\"}")
	end)
	arg_15_0:AddBtnListener(arg_15_0.sdkBtn_, nil, function()
		NeedGameUserInfo()
		GameToSDK.GoUserCenter()
	end)
	arg_15_0:AddBtnListener(arg_15_0.anncBtn_, nil, function()
		if _G.bulletinInfoGetted then
			arg_15_0:ShowWebView()
		end
	end)
	arg_15_0:AddBtnListener(arg_15_0.forumBtn_, nil, function()
		if _G.ChannelLoginInfo and _G.ChannelLoginInfo.channelToken then
			local var_19_0 = {
				gameAppId = _G.ChannelLoginInfo.channelAppId,
				token = _G.ChannelLoginInfo.channelToken
			}

			OperationAction.OpenOperationUrl("FORUM_URL", var_19_0)
		else
			OperationAction.OpenOperationUrl("FORUM_URL_HOME")
		end

		SDKTools.SendMessageToSDK("direction", {
			direction_type = 8,
			direction_channel = 1
		})
	end)
end

function var_0_0.OnEnter(arg_20_0)
	gameContext:SetSystemLayer("login")

	_G.isLogining = false
	arg_20_0.params_.isAutoLogin = true

	LoadingUIManager.inst:CloseLoadUI()
	Timer.New(function()
		GameToSDK.SendMessage("{\"messageType\" : \"GetBulletin\"}")
	end, 1, 1):Start()
	arg_20_0:RegistEventListener(AGE_TIP_CALLBACK, function(arg_22_0)
		print("AGE_TIP_CALLBACK")

		arg_20_0.ageLimitGo_.transform:Find("Canvas/panel/descContainer/friendlyDescText"):GetComponent(typeof(Text)).text = arg_22_0
	end)
end

function var_0_0.OnExit(arg_23_0)
	LuaForCursor.UseSystemCursor(false)
	arg_23_0.selectRegion_.onValueChanged:RemoveAllListeners()
	arg_23_0:RemoveAllEventListener()

	var_0_1 = false
end

function var_0_0.WaitForBulletin(arg_24_0)
	print("WaitForBulletin 开始监听公告信息返回")

	if SDKTools.IsSDK() then
		print("SDK 环境")

		local var_24_0 = 0
		local var_24_1

		var_24_1 = Timer.New(function()
			var_24_0 = var_24_0 + 1

			if _G.bulletinInfoGetted or var_24_0 > 30 then
				var_24_1:Stop()
				Timer.New(function()
					arg_24_0:ShowWebView()
					arg_24_0:SDKLogin()
					arg_24_0:AddUIListener()
				end, 0.6, 1):Start()
			end
		end, 0.1, -1)

		var_24_1:Start()
	end
end

function var_0_0.AddUIListener(arg_27_0)
	arg_27_0:AddBtnListener(arg_27_0.imageBtn_, nil, function()
		if _G.SELECT_REGION_SEVER_ID == nil then
			arg_27_0:QueryRegionSeverInfo()

			return
		end

		if not EvokeGateWayLogin(_G.SELECT_REGION_SEVER_ID) then
			arg_27_0:SDKLogin()
		end
	end)
end

function var_0_0.SDKLogin(arg_29_0)
	if _G.isLogining or _G.clickCDing_ then
		return
	end

	_G.clickCDing_ = true

	Debug.Log("唤起SDK登录")
	GameToSDK.Login("{}")
	SendMessageManagerToSDK("SDKLogin")
	TimeTools.StartAfterSeconds(5, function()
		_G.clickCDing_ = false
	end, {})
	LuaForCursor.UseSystemCursor(true)
end

function var_0_0.QueryRegionSeverInfo(arg_31_0)
	if var_0_1 then
		print("RegionServerLog QueryRegionSeverInfo fail by repeat")

		return
	end

	var_0_1 = true

	print("RegionServerLog QueryRegionSeverInfo start")
	RegionServerMgr.instance:UpdateRegionServerInfo(_G.TMP_ACCOUNT_ID or "", function(arg_32_0, arg_32_1)
		var_0_1 = false

		if arg_32_0 then
			print("RegionServerLog QueryRegionSeverInfo success")

			if isNil(arg_31_0.gameObject_) then
				return
			end

			arg_31_0:UpdateRegionServer()
		else
			print("RegionServerLog QueryRegionSeverInfo fail")
			ShowTips(arg_32_1)
		end
	end)
end

function var_0_0.UpdateRegionServer(arg_33_0)
	local var_33_0 = RegionServerMgr.instance:GetRegionServerInfoList()
	local var_33_1 = var_33_0.Count

	if var_33_1 == 0 then
		arg_33_0.serverShowController:SetSelectedIndex(0)
		Debug.LogError("RegionServerLog server list count = 0")

		return
	end

	if _G.SELECT_REGION_SEVER_ID and isNil(RegionServerMgr.instance:GetRegionServerInfo(_G.SELECT_REGION_SEVER_ID)) then
		_G.SELECT_REGION_SEVER_ID = nil
	end

	if var_33_1 == 1 then
		_G.SELECT_REGION_SEVER_ID = var_33_0[0].serverId

		arg_33_0.serverShowController:SetSelectedIndex(0)
	else
		if GetSDKLoginInfo() == nil then
			arg_33_0.serverShowController:SetSelectedIndex(0)
		else
			arg_33_0.serverShowController:SetSelectedIndex(1)
		end

		if _G.SELECT_REGION_SEVER_ID == nil then
			local var_33_2 = PlayerPrefs.GetString("RegionServerId", "")

			if var_33_2 == "" or isNil(RegionServerMgr.instance:GetRegionServerInfo(var_33_2)) then
				local var_33_3
				local var_33_4
				local var_33_5 = RegionServerMgr.instance:GetRegionServerInfoList()
				local var_33_6 = var_33_5.Count

				for iter_33_0 = 0, var_33_6 - 1 do
					local var_33_7 = var_33_5[iter_33_0]
					local var_33_8 = var_33_7.serverId
					local var_33_9 = var_33_7.newServerFlag

					if var_33_7.gameUserInfoList.Count > 0 then
						var_33_4 = var_33_8
					end

					if var_33_9 == 1 then
						var_33_3 = var_33_8
					end
				end

				if var_33_4 ~= nil then
					_G.SELECT_REGION_SEVER_ID = var_33_4
				elseif var_33_3 ~= nil then
					_G.SELECT_REGION_SEVER_ID = var_33_3
				else
					_G.SELECT_REGION_SEVER_ID = var_33_5[0].serverId
				end
			else
				_G.SELECT_REGION_SEVER_ID = var_33_2
			end
		end
	end

	local var_33_10 = RegionServerMgr.instance:GetRegionServerInfo(_G.SELECT_REGION_SEVER_ID)

	arg_33_0.m_serverName.text = var_33_10 and var_33_10.serverName or "null"

	if var_33_10 and not var_33_10.maintain then
		arg_33_0.serverMaintainController:SetSelectedIndex(0)
	else
		arg_33_0.serverMaintainController:SetSelectedIndex(1)
	end

	if var_33_10 and var_33_10.newServerFlag ~= 1 then
		arg_33_0.serverNewTagController:SetSelectedIndex(0)
	else
		arg_33_0.serverNewTagController:SetSelectedIndex(1)
	end
end

function var_0_0.ShowWebView(arg_34_0)
	return
end

function var_0_0.RefreshState(arg_35_0)
	local var_35_0 = GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV

	SetActive(arg_35_0.btn_server_, var_35_0)
	SetActive(arg_35_0.btn_account_, var_35_0)
	SetActive(arg_35_0.btn_start_, var_35_0)

	local var_35_1 = GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV or _G.CHANNEL_MASTER_ID == 1 or _G.CHANNEL_MASTER_ID == 0

	if arg_35_0.isOverSeas_ then
		SetActive(arg_35_0.levelBtn_.gameObject, false)
		SetActive(arg_35_0.forumGo_, true)

		if SDKTools.GetIsThisServer({
			"tw",
			"jp",
			"en"
		}) then
			SetActive(arg_35_0.forumGo_, false)
		end

		if SDKTools.GetIsThisServer({
			"tw"
		}) then
			-- block empty
		end
	else
		SetActive(arg_35_0.levelBtn_.gameObject, true)
		SetActive(arg_35_0.suggestGo_, var_35_1)
		SetActive(arg_35_0.sdkGo_, var_35_1)
		SetActive(arg_35_0.forumGo_, var_35_1)
	end
end

function var_0_0.TryToLoginIn(arg_36_0)
	local var_36_0 = tostring(arg_36_0:GetAccount())

	if string.len(var_36_0) < 1 then
		ShowTips("IF_ACCOUNT_NIL")

		return
	end

	arg_36_0.currentServerIndex_ = arg_36_0.dropDown_.value + 1
	GATEWAY_ADDR = arg_36_0.serverList_[arg_36_0.currentServerIndex_].host
	GATEWAY_PORT = arg_36_0.serverList_[arg_36_0.currentServerIndex_].port

	PlayerPrefs.SetString("SelectServer", arg_36_0.currentServerIndex_)
	PlayerPrefs.SetString("AccountID", arg_36_0:GetAccount())
	CheckVersion(function()
		manager.net.gateWayConnection_.netStatus = "none"

		LoginAction.GateWayLogin(arg_36_0:GetAccount(), arg_36_0:GetPassword())
	end)
end

function var_0_0.PlayOut(arg_38_0)
	manager.audio:StopEffect()
	manager.messageBox:HideAll()
	arg_38_0:CheckDefaultSetting()
end

function var_0_0.SetSDKId(arg_39_0)
	if arg_39_0.isOverSeas_ and _G.TMP_ACCOUNT_ID then
		arg_39_0.sdkIdText_.text = "SDKID:" .. _G.TMP_ACCOUNT_ID
	end

	LuaForCursor.UseSystemCursor(false)
	print("RegionServerLog query info")
	arg_39_0:QueryRegionSeverInfo()
end

function var_0_0.CheckDefaultSetting(arg_40_0)
	if SettingData:NewDevice() then
		arg_40_0:Go("/graphicRecommend", {
			callback = handler(arg_40_0, arg_40_0.OnGraphicQualitySelect)
		})
	else
		arg_40_0:AwakeName()
	end
end

function var_0_0.OnGraphicQualitySelect(arg_41_0, arg_41_1, arg_41_2)
	SettingData:SetQualitied()
	SettingAction.ChangePicSetting("picOptionId", arg_41_2)
	arg_41_0:AwakeName()
end

function var_0_0.AwakeName(arg_42_0)
	if PlayerData:GetPlayerInfo().is_changed_nick < 1 then
		arg_42_0:Go("/awakeName")
	else
		CheckNewGuide()
	end
end

function var_0_0.UpdateAccount(arg_43_0, arg_43_1, arg_43_2)
	arg_43_0.txtAccount_.text = arg_43_1
	arg_43_0.pwd_ = arg_43_2
end

function var_0_0.GetAccount(arg_44_0)
	return arg_44_0.txtAccount_.text
end

function var_0_0.GetPassword(arg_45_0)
	return arg_45_0.pwd_ or PlayerPrefs.GetString("UserPwd")
end

function var_0_0.Cacheable(arg_46_0)
	return false
end

function var_0_0.Dispose(arg_47_0)
	arg_47_0:RemoveAllListeners()

	var_0_1 = false

	var_0_0.super.Dispose(arg_47_0)
end

function var_0_0.OnExitInput(arg_48_0)
	ShowQuitConfirm()

	return true
end

function var_0_0.OnLoginSeverUpdate(arg_49_0)
	arg_49_0:UpdateRegionServer()
end

return var_0_0
