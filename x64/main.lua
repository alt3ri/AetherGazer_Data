print(string.format("LUA VM MEMORY USED: %0.2f KB", collectgarbage("count")))
require("include")

slot0 = require("cjson")
RECONNECT_RETRY_COUNT = 3
loginRetryCount = 0
slot1 = true

function setScreenOrientation(slot0)
	uv0 = slot0
end

function getScreenOrientation()
	return uv0
end

debugger = import("game.debugger.debugger")
slot2 = import("game.RoutesConfig")
slot3 = import("game.GameContext")

function __G__TRACKBACK__(slot0)
	slot1 = "----- Lua error begin -----\n" .. "Lua error: " .. tostring(slot0) .. "\n" .. debug.traceback("", 2) .. "----- Lua error end -----"

	print(slot1)
	Debugger.LogError(slot1)
end

function PrepareAdaptData()
	ReduxView.NEED_ADAPT = ReduxView.ADAPT_RAITO < _G.SCREEN_WIDTH / _G.SCREEN_HEIGHT
end

function DeploySetting(slot0)
	slot2, slot3 = SettingTools.GetSettingScreenSize(tonumber(slot0.pic.resolution))

	Screen.SetResolution(slot2, slot3, true)

	manager.ui.cameraExtension.hdr = slot0.pic.hdr == 1

	if PlayerPrefs.GetInt("allowMSAA") == 0 then
		UnityEngine.Pipelines.SimPipeline.SimPipelineSettings.AliasingEnable = false
	else
		UnityEngine.Pipelines.SimPipeline.SimPipelineSettings.AliasingEnable = true
	end

	Application.targetFrameRate = slot0.pic.frame == 0 and 30 or slot0.pic.frame == 1 and 60 or 120

	SettingAction.DeploySoundSetting("allData", slot0.sound)

	ReduxView.VIEW_ADAPT_DISTANCE = slot0.game.adapter_value

	PlayerPrefs.SetString("text_language", slot0.sound.text_language)
end

function EnterGame()
	_G.gameContext = uv0.New(uv1, {
		"home"
	})

	_G.gameContext:RegistPreLoadFunc(ViewTools.PreDealWithAsset)
	_G.gameContext:SetSystemLayer("login")

	_G.CHANNEL_MASTER_ID = GameToSDK.GetChannelMasterId()

	if _G.CHANNEL_MASTER_ID == -1 then
		_G.CHANNEL_MASTER_ID = 0
	end

	print("GameToSDK ", _G.CHANNEL_MASTER_ID)
	manager.uiInit()

	_G.GlobalCall = require("library/GlobalCall")

	if _G.SCREEN_WIDTH == nil or _G.SCREEN_HEIGHT == nil then
		_G.SCREEN_WIDTH = Screen.width
		_G.SCREEN_HEIGHT = Screen.height
	end

	PrepareAdaptData()
	DeploySetting(SettingData:GetSettingData())

	_G.gameListener = GameListener.New()
	_G.gameTimer = GameTimer.GetInstance()
	_G.AnalyticsPresetProperties = GameToSDK.GetData("{\"dataType\" : \"GetAnalyticsPresetProperties\"}")

	if _G.AnalyticsPresetProperties == nil or _G.AnalyticsPresetProperties == "" then
		_G.AnalyticsPresetProperties = "{}"
	end

	_G.AnalyticsPresetProperties = uv2.decode(_G.AnalyticsPresetProperties)

	SendMessageToSDKWithCallBack("{\"messageType\" : \"GetDeviceInfo\"}", "DeviceInfoGet", function ()
		GotoLoginView()
	end)
	LuaForUtil.InitSavePhoto()
end

function GetInitAssetList()
	return {
		"Fonts/SourceHanSansBlod",
		"Fonts/OykoRegular",
		"Fonts/FontEditor",
		"Atlas/PopUI",
		"Atlas/Common",
		"Atlas/Hero",
		"Atlas/BattleSelectHero",
		"Atlas/Shop",
		"Atlas/Draw",
		"Atlas/Currency",
		"Atlas/Item",
		"Atlas/ItemSmall",
		"Atlas/ChapterMap",
		"UI/Main/HomeUI",
		"Atlas/Home"
	}, nil
end

function InitGameSetBGM(slot0)
	manager.audio:PlayBGM("ui_skip", "ui_reset_filter")
	AudioManager.Instance:SetAisacControlOfCategory("music", "phase_controller", 0)
	AudioManager.Instance:SetAisacControlOfCategory("music", "bgm_volume", 0)
	AudioManager.Instance:SetAisacControlOfCategory("music", "bgm_speed", 1)
	AudioManager.Instance:SetAisacControlOfCategory("music", "music_Control", 1)
	AudioManager.Instance:SetAisacControlOfCategory("sfx", "sfx_Control", 1)
	AudioManager.Instance:SetAisacControlOfCategory("vocal", "vocal_Control", 1)
end

function GetHomeMusicID()
	slot0 = IllustratedData:GetBgm()

	if SettingData:GetHomeSceneSettingData().home_scene_scene_bgm == 1 then
		slot3 = HomeSceneSettingCfg[HomeSceneSettingData:GetCurScene()]

		if slot3.default_music ~= 0 and table.indexof(slot3.scene_setting, HomeSceneSettingConst.SETTING.SCENE_BGM) then
			slot0 = slot5
		end
	end

	return slot0
end

function PlayGameSetBGM()
	if GetHomeMusicID() == nil or slot0 == 0 then
		return nil
	end

	if not MusicRecordCfg[slot0] then
		return nil
	end

	for slot6, slot7 in pairs(MusicData:GetAisacSet(slot0)) do
		AudioManager.Instance:SetAisacControlOfCategory("music", slot6, slot7)
	end

	manager.audio:PlayBGM(slot1.cuesheet, slot1.cueName, slot1.awbName)

	return true
end

function GameInit()
	pcall(debugger.Start)
	Asset.Load("Fonts/SourceHanSans", true)
	SettingData:InitSetting()
	manager.init()
	LoadingUIManager.inst:ShowLoadUI(LoadingUIType.GameStart)
	LeanTween.init(800)
	EnterGame()
end

function PreLoadAssetByPlayer()
	LoadingUIManager.inst:ShowLoadUI()

	for slot5, slot6 in pairs(HeroTools.GetNeedPreLoadHeroId()) do
		-- Nothing
	end

	PreLoadAsset({
		["Char/" .. HeroTools.HeroUsingSkinInfo(slot5).modelId] = 20
	}, 0, function ()
		for slot3, slot4 in pairs(uv0) do
			slot5 = HeroCfg[slot3]

			manager.resourcePool:DestroyOrReturn(manager.resourcePool:Get("Char/" .. HeroTools.HeroUsingSkinInfo(slot3).modelId, ASSET_TYPE.TPOSE), ASSET_TYPE.TPOSE)
		end

		gameContext:Go("/home", {
			isFirstCheck = true
		}, false, true)
	end)
end

function PreLoadAsset(slot0, slot1, slot2, slot3)
	slot4 = 0
	slot5 = slot1

	if not slot3 then
		LoadingUIManager.inst:SetUIText(string.format(GetTips("LOADING")))
	end

	function slot6(slot0)
		return function ()
			uv0 = uv0 + uv1

			if not uv2 then
				LoadingUIManager.inst:SetUIProgress(uv0)
			end

			if uv0 > 99 and uv3 then
				uv3()

				uv3 = nil
			end
		end
	end

	for slot10, slot11 in pairs(slot0) do
		slot4 = slot4 + slot11
	end

	for slot10, slot11 in pairs(slot0) do
		Asset.LoadAsync(slot10, slot6(math.ceil(slot11 / slot4 * (100 - slot1))))
	end
end

function CheckManagers()
	if LuaExchangeHelper.GetSceneIsHanding() then
		return false
	end

	if not manager.managerInit then
		manager.uiInit()
	end

	return true
end

function CheckNewGuide()
	manager.guide:InitGuide()

	if manager.guide:IsGoToHome() then
		PreLoadAssetByPlayer()
	else
		gameContext:ClearHistory()
	end
end

slot4 = nil

function LateInitData()
	PlayerAction.InitChatBubbleRedPoint()
	ChatAction.FriendChatInitData()
	ChatAction.GuildChatInitData()
	ChatAction.LoadChannelChatData()
	FriendsAction:ChatInit()
	ShopAction.LateInitLua()
	WarChessAction.UpdateSummerChessPlotRedPoint()
	WarChessData:InitRedPoint()
	BattleStageAction.AddActivityTimer()
	BattleStageAction.UpdateActivityRedPoint()
	BattleStageAction.UpdateSubPlotRedPoint()
	EquipSeizureAction.InitRedPointEveryDay()
	GuildActivitySPAction.UpdateRedPoint()
	ActivityAction.InitLoginShopRedPoint()

	if uv0 then
		uv0:Stop()
	end

	slot0 = GameSetting.refresh_time1.value[1][1]
	slot1 = manager.time:GetNextTime(slot0, 0, 0)
	slot2 = TimeMgr.GetInstance():GetNextWeekTime(1, slot0, 0, 0)
	uv0 = Timer.New(function ()
		if uv0 <= manager.time:GetServerTime() then
			uv0 = manager.time:GetNextTime(uv1, 0, 0)

			manager.notify:Invoke(ZERO_REFRESH)
		end

		if TimeMgr.GetInstance():GetServerTime() - uv2 > 0 then
			uv2 = TimeMgr.GetInstance():GetNextWeekTime(1, uv1, 0, 0)

			manager.notify:Invoke(WEEK_ZERO_REFRESH)
		end
	end, 1, -1)

	uv0:Start()
end

function DisposeData()
	BattleStageAction.RemoveActivityTimer()
	SequentialBattleAction.ResetData()
	SpringFestivalRiddleAction.Dispose()
	ActivityTools.ClearAllActivityTimer()
	BulletinData.OnLogout()
	manager.rollTips:OnLogout()

	if uv0 then
		uv0:Stop()

		uv0 = nil
	end
end

function GetTips(slot0)
	slot1 = nil

	if type(slot0) == "number" then
		slot1 = slot0
	elseif type(slot0) == "string" then
		slot1 = TipsCfg.get_id_list_by_define[slot0]
	end

	slot2 = nil

	if slot1 and TipsCfg[slot1] then
		if TipsCfg[slot1] then
			slot2 = GetI18NText(TipsCfg[slot1].desc)
		else
			slot2 = GetTips("ERROR_CODE") .. slot1
		end
	elseif slot0 ~= nil then
		slot2 = "" .. slot0
	end

	return slot2, slot1
end

function GetTipsF(slot0, ...)
	slot2, slot3 = GetTips(slot0)

	return string.format(slot2, unpack({
		...
	})), slot3
end

function ShowTips(slot0, slot1)
	if LuaExchangeHelper.GetSceneIsHanding() then
		return
	end

	slot2, slot3 = GetTips(slot0)

	manager.tips:ShowTips(slot2, slot3, slot1)
end

function ShakingMobile()
	if manager == nil then
		return
	end

	if manager.notify == nil then
		return
	end

	manager.notify:Invoke(SHAKING_MOBILE)
end

function GotoLoginView(slot0)
	GameToSDK.UpUserEvent("{\"eventType\" : \"End\"}")
	manager.ui:SetUIDText("")
	DisposeData()
	manager.story:Dispose()

	if manager.NewChessManager then
		manager.NewChessManager:Dispose()

		manager.NewChessManager = nil
	end

	manager.net:Disconnect()
	manager.net:ChatDisconnect()
	manager.guide:OnLogout()
	ActivityAction.OnLogout()
	ResetSceneDataForExcehange()
	manager.achievementTips:InitData()

	_G.clickCDing_ = false
	_G.isLogining = false

	if true or GameLocalData:GetValueFromCommonModule("LoginConceptGuideData", "watched") then
		gameContext:Go("/login", {
			isAutoLogin = slot0
		})
	else
		gameContext:Go("/loginConceptGuild", {
			isAutoLogin = slot0
		})
	end

	ReduxFactory.GetInstance():ClearCacheViews()
	_G.gameTimer:Dispose()
end

function SetActive(slot0, slot1)
	slot1 = slot1 or false

	if isNil(slot0) then
		return
	end

	if slot0:GetComponent("UIPanel") then
		slot2:SetActive(slot1)
	else
		slot0:SetActive(slot1)
	end
end

function isSuccess(slot0)
	return slot0 == TipsCfg.get_id_list_by_define.SUCCESS
end

function ShowQuanquan(slot0)
	manager.loadui:ShowLoad(slot0)
end

function SetForceShowQuanquan(slot0)
	manager.loadui:ForceShowLoad(slot0)
end

function ShowMessageBox(slot0)
	if LuaExchangeHelper.GetSceneIsHanding() then
		slot1 = nil
		slot2 = FrameTimer.New(function ()
			if LuaExchangeHelper.GetSceneIsHanding() then
				return
			end

			uv0:Stop()
			CheckManagers()
			manager.messageBox:ShowMessage(uv1)
		end, 1, -1)
		slot1 = slot2

		slot2:Start()

		return
	end

	manager.messageBox:ShowMessage(slot0)
end

function cfgToItemTemplate(slot0)
	if slot0[1] then
		slot1 = clone(ItemTemplateData)
		slot1.id = slot0[1]
		slot1.number = slot0[2]
		slot1.timeValid = slot0[4]

		return slot1
	end

	return slot0
end

function ShowPopItem(slot0, slot1, slot2, slot3)
	if ItemCfg[cfgToItemTemplate(slot1).id].type == ItemConst.ITEM_TYPE.EQUIP then
		JumpTools.OpenPageByJump("/equipCultureView", {
			equipId = slot1.equip_id and slot1.equip_id ~= 0 and slot1.equip_id or nil,
			prefabId = slot4,
			pageIndex = slot2 and slot2.page or 1
		})
	elseif slot6 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		if whereami == "battleResult" then
			JumpTools.OpenPageByJump("showServantView", {
				state = "onlydetail",
				id = slot4,
				gameContext:SetSystemLayer("battleResult")
			})
		elseif whereami ~= "home" then
			JumpTools.OpenPageByJump("/showServantView", {
				state = "onlydetail",
				id = slot4
			})
		else
			ShowPopItemOnly(slot0, slot1, slot2)
		end
	elseif slot6 == ItemConst.ITEM_TYPE.DORM_FURNITURE then
		JumpTools.OpenPageByJump("dormItemPopView", {
			id = slot4
		})
	else
		ShowPopItemOnly(slot0, slot1, slot2)
	end
end

function ShowPopItemOnly(slot0, slot1, slot2)
	if slot0 == POP_ITEM then
		JumpTools.OpenPageByJump("popItem", {
			popItemInfo = cfgToItemTemplate(slot1),
			extraInfo = slot2
		})
	elseif slot0 == POP_SOURCE_ITEM then
		JumpTools.OpenPageByJump("popSourceItem", {
			popItemInfo = slot1,
			extraInfo = slot2
		})
	elseif slot0 == POP_OPERATE_ITEM then
		JumpTools.OpenPageByJump("popOperateItem", {
			popItemInfo = slot1,
			extraInfo = slot2
		})
	elseif slot0 == POP_MERGE_ITEM then
		JumpTools.OpenPageByJump("popMergeItem", {
			popItemInfo = slot1,
			extraInfo = slot2
		})
	elseif slot0 == POP_SOURCE_DES_ITEM then
		JumpTools.OpenPageByJump("popSourceDesItem", {
			popItemInfo = slot1,
			extraInfo = slot2
		})
	elseif slot0 == POP_OTHER_ITEM then
		JumpTools.OpenPageByJump("popItem", {
			popItemInfo = slot1,
			extraInfo = slot2
		})
	end
end

function ShowPopItemSource(slot0, slot1, slot2)
	slot3 = nil

	if slot2 then
		for slot7, slot8 in ipairs(EquipCfg.get_id_list_by_suit[slot2]) do
			if EquipCfg[slot8].starlevel == 5 then
				slot0 = slot8

				break
			end
		end
	end

	JumpTools.OpenPageByJump("popEquipSourceView", {
		popItemInfo = {
			id = slot0
		},
		equip_info = EquipStruct.New(0, slot0),
		suitID = slot2
	})
end

function ShowPopEquipSuit(slot0, slot1)
	JumpTools.OpenPageByJump("popEquipSuitView", {
		suitId = slot0,
		hideBtn = slot1
	})
end

function saveData(slot0, slot1, slot2)
	GameLocalData:SaveToTargetModule(slot0, slot1, slot2)
end

function getData(slot0, slot1)
	return GameLocalData:GetValueFromTargetModule(slot0, slot1)
end

function saveModule(slot0, slot1)
	slot2 = GameLocalData:GetTargetModule(slot0)

	for slot6, slot7 in pairs(slot1) do
		slot2[slot6] = slot7
	end

	GameLocalData:SaveTargetModule(slot0, slot2)
end

function getModule(slot0)
	return GameLocalData:GetTargetModule(slot0)
end

function getCommonData(slot0, slot1)
	return GameLocalData:GetValueFromCommonModule(slot0, slot1)
end

function cleanProtoTable(slot0, slot1)
	slot2 = {}

	if slot0 then
		for slot6, slot7 in ipairs(slot0) do
			if slot1 and type(slot1) == "table" then
				slot2[slot6] = {}

				for slot11, slot12 in ipairs(slot1) do
					slot2[slot6][slot12] = slot7[slot12]
				end
			else
				slot2[slot6] = slot7
			end
		end
	end

	return slot2
end

function OpenPageUntilLoaded(slot0, slot1, slot2)
	JumpTools.OpenPageUntilLoaded(slot0, slot1, slot2)
end

function Quit()
	NeedGameUserInfo()
	GameToSDK.UpUserEvent("{\"eventType\" : \"End\"}")
	GameToSDK.UpUserInfo(PlayerTools.PackUserData("ExitGame"))
	pcall(debugger.Stop)
	LuaHelper.Quit()
	SendMessageManagerToSDK("role_logout")
end

function OnApplicationQuit(slot0)
	manager.net:Disconnect()
	manager.net:ChatDisconnect()
	gameContext:DestroyCurRoutes()

	if manager.ChessManager then
		manager.ChessManager:Dispose()

		manager.ChessManager = nil
	end

	if manager.NewChessManager then
		manager.NewChessManager:Dispose()

		manager.NewChessManager = nil
	end

	manager.achievementTips:Dispose()
	manager.destroy()

	if manager.guide then
		manager.guide:Dispose()

		manager.guide = nil
	end

	if manager.rollTips then
		manager.rollTips:Dispose()

		manager.rollTips = nil
	end

	SendMessageManagerToSDK("role_logout")
end

slot5 = true
slot6 = false

function OnApplicationFocus(slot0)
	OnAppFocusPauseStateChange(slot0, uv0)
end

function OnApplicationPause(slot0)
	OnAppFocusPauseStateChange(uv0, slot0)
end

function OnAppFocusPauseStateChange(slot0, slot1)
	uv0 = slot0
	uv1 = slot1

	if (uv1 == false and slot1 == true or uv0 == true and slot0 == false) and slot3 == false and slot1 == true then
		GameToSDK.UpUserEvent("{\"eventType\" : \"End\"}")
		FatigueReminder()
		DailyFatigueReminder()
		CatExploreReminder()
		CanteenDispatchReminder()
		CanteenFullReminder()
	end

	if slot3 == true and slot1 == false then
		GameToSDK.UpUserEvent("{\"eventType\" : \"Begin\"}")
		StopFatigueReminder()
		StopDailyFatigueReminder()
		StopCatExploreReminder()
		StopCanteenDispatchReminder()
		StopCanteenFullReminder()

		if OperationAction ~= nil then
			OperationAction.OnApplicationBack()
		end
	end

	if manager ~= nil and manager.notify ~= nil then
		manager.notify:Invoke(GAME_FOCUS_CHANGE, slot0, slot1)
	end
end

function CanteenFullReminder()
	if manager == nil then
		return
	end

	if SettingData:GetRemindSettingData() ~= nil and (slot0.canteen_full_reminder or 0) == 1 then
		TimerReminderData:SetReminder(TimerReminderConst.CANTEEN_FULL)
	end
end

function CanteenDispatchReminder()
	if manager == nil then
		return
	end

	if SettingData:GetRemindSettingData() ~= nil and (slot0.canteen_dispatch_reminder or 0) == 1 then
		TimerReminderData:SetReminder(TimerReminderConst.CANTEEN_DISPATCH)
	end
end

function CatExploreReminder()
	if manager == nil then
		return
	end

	if SettingData:GetRemindSettingData() ~= nil and (slot0.cat_explore_reminder or 0) == 1 then
		TimerReminderData:SetReminder(TimerReminderConst.CAT_EXPLORE)
	end
end

function DailyFatigueReminder()
	if manager == nil then
		return
	end

	if SettingData:GetRemindSettingData() ~= nil and (slot0.daily_fatigue_reminder or 0) == 1 then
		TimerReminderData:SetReminder(TimerReminderConst.DAILYFATIGUE)
	end
end

function FatigueReminder()
	if manager == nil then
		return
	end

	if SettingData:GetRemindSettingData() ~= nil then
		if (slot0.fatigue_full_reminder or 0) == 1 and CurrencyData:GetFatigueCallFlag() == 1 then
			TimerReminderData:SetReminder(TimerReminderConst.FATIGUE)
		end
	end
end

function StopFatigueReminder()
	TimerReminderData:CancelReminder(TimerReminderConst.FATIGUE)
end

function StopDailyFatigueReminder()
	TimerReminderData:CancelReminder(TimerReminderConst.DAILYFATIGUE)
end

function StopCatExploreReminder()
	TimerReminderData:CancelReminder(TimerReminderConst.CAT_EXPLORE)
end

function StopCanteenDispatchReminder()
	TimerReminderData:CancelReminder(TimerReminderConst.CANTEEN_DISPATCH)
end

function StopCanteenFullReminder()
	TimerReminderData:CancelReminder(TimerReminderConst.CANTEEN_FULL)
end

_G.OnLoadedCallBackPre_ = nil
_G.OnLoadedCallBack_ = nil

function RefreshUI(slot0)
	if slot0 then
		gameContext:SetSystemLayer(slot0)
	else
		gameContext:SetSystemLayer("home")
	end

	manager.uiInit()

	if _G.OnLoadedCallBackPre_ then
		_G.OnLoadedCallBackPre_()
	end

	gameContext:RevertRoutes()
	ResetSceneDataForExcehange()

	if _G.OnLoadedCallBack_ then
		_G.OnLoadedCallBack_()

		_G.OnLoadedCallBack_ = nil
	end

	LuaForUtil.UpdateCameraSetting()
end

function DestroyLua()
	gameContext:SetSystemLayer()
	gameContext:DestroyCurRoutes()
	manager.destroy()
end

function StatUILoadTimeToServer(slot0)
end

function LuaGcCollect()
	collectgarbage("collect")
end

function SpliceI18NText(slot0)
	if #slot0 < 2 then
		return slot0
	end

	slot2 = slot0[1]
	slot3 = ""

	if SettingData:GetCurrentLanguage() == "en" then
		slot3 = " "
	end

	for slot7 = 2, slot1 do
		slot2 = string.format("%s%s%s", slot2, slot3, slot0[slot7])
	end

	return slot2
end

function GetI18NText(slot0)
	if I18NRuntimeManager.Instance:GetI18NText(slot0) then
		return slot1
	end

	return slot0
end

slot7 = {
	AllTranslateCfg,
	AllTranslateCfg2,
	AllTranslateCfg3,
	AllTranslateCfg4,
	AllTranslateCfg5,
	AllTranslateCfg6,
	AllTranslateCfg7,
	AllTranslateCfg8,
	AllTranslateCfg9,
	AllTranslateCfg10
}

function GetTranslateCfg(slot0)
	for slot4, slot5 in ipairs(uv0) do
		if slot5 and slot5[slot0] then
			return slot5[slot0]
		end
	end

	return nil
end

function GetAllTranslateCfg()
	slot0 = {}

	print("GetAllTranslateCfg")

	for slot4, slot5 in ipairs(uv0) do
		if slot5 then
			for slot9, slot10 in pairs(slot5) do
				slot11 = TranslateData.New()
				slot11.zh_cn = slot9
				slot11.en = slot10.translate_en
				slot11.jp = slot10.translate_jp
				slot11.kr = slot10.translate_kr
				slot11.tc = slot10.translate_tc
				slot0[slot9] = slot11
			end
		end
	end

	return slot0
end

function OpenDownLoadPage(slot0, slot1)
	if gameContext:IsOpenRoute("downLoadPage") then
		return
	end

	JumpTools.OpenPageByJump("downLoadPage", {
		title = slot0,
		abbr = slot1
	})
end

function SetDownLoadPageProgress(slot0, slot1)
	if not gameContext:IsOpenRoute("downLoadPage") then
		JumpTools.OpenPageByJump("downLoadPage")
	end

	if gameContext:GetOpenPageHandler(routeName) then
		slot2:SetProgress(slot0, slot1)
	end
end

function CloseDownLoadPage()
	if gameContext:IsOpenRoute("downLoadPage") then
		JumpTools.Back()
	end
end

function EncodeURL(slot0)
	return string.gsub(slot0, "([^%w%p ])", function (slot0)
		return string.format("%%%02X", string.byte(slot0))
	end)
end

function OnHomeVoiceStart(slot0, slot1)
	manager.notify:CallUpdateFunc(HOME_WORD_DISPLAY_START, slot0, slot1)
end

function OnHomeVoiceStop(slot0, slot1)
	manager.notify:CallUpdateFunc(HOME_WORD_DISPLAY_STOP, slot0, slot1)
end

slot8 = false

function EnterMainScene()
	if ReleaseBattleResultSnapshot then
		ReleaseBattleResultSnapshot()
	end

	uv0 = true
end

function ExitMainScene()
	uv0 = false
end

function GetIsInMainScene()
	return uv0
end

function OnExitInput()
	if not manager or not manager.windowBar then
		return
	end

	if manager.ui and not manager.ui:GetIsUIEventEnabled() then
		return
	end

	if manager.guide and manager.guide:IsPlaying() then
		return
	end

	if manager.net and manager.net:GetMainSendingPacketNum() > 0 then
		return
	end

	if gameContext ~= nil then
		if gameContext:GetLastOpenPage() == "home" then
			ShowQuitConfirm()

			return
		end

		if gameContext:GetOpenPageHandler(slot0) and slot1.OnExitInput and slot1:OnExitInput() then
			return
		end
	end

	if manager.windowBar:GetBackBtnIsShow() then
		if not manager.messageBox:GetIsAllFree() then
			return
		end

		manager.windowBar:CallBackFunc()
	end
end
