slot0 = {
	HZ07 = LianLianKanBridge,
	HZ07_diaoyu1 = FishingGameBridge,
	HZ07_xueqiu1 = SnowballGameBridge,
	HZ07_tuanxue1 = PushSnowBallGameBridge,
	WT_RK = IdolTraineeCampBridge,
	HZ07_kaorou1 = BarbuceGameBridge
}

function OnEnterMiniGameScene(slot0)
	Dorm.Enter()
	LuaForUtil.UpdateCameraSetting()
	manager.uiInit()
	manager.windowBar:SetWhereTag("minigame")

	Dorm.storage = DormStorage.GetInstance()

	Dorm.storage:Reset()

	Dorm.sceneItemInfo = {}
	Dorm.subtitleViewStack = {}

	DormLuaBridge.RecordInfoFromDormTag()
	DormUtils.MapSceneItemTagInfo()
	DormCharacterActionManager:Init()
	DormCharacterInteractBehaviour:Init()

	if nullable(Dorm.minigame, "Enter") then
		slot1(Dorm.minigame, slot0)
	end
end

function OnExitMiniGameScene(slot0, slot1)
	if Dorm.lastMinigame == nil then
		Dorm.minigame = nil
		Dorm.lastMinigame = Dorm.minigame
	end

	if nullable(Dorm.lastMinigame, "Exit") then
		slot3(slot2, slot0, slot1)
	end

	Dorm.subtitleViewStack = nil
	Dorm.lastMinigame = nil

	DormCharacterInteractBehaviour:Reset()
	DormCharacterActionManager:Reset()
	Dorm.storage:Reset()

	Dorm.sceneItemInfo = nil

	manager.windowBar:ClearWhereTag()
	DestroyLua()
	Dorm.Leave()
end

DormMinigame = {
	Launch = function (slot0, slot1)
		Dorm.minigame = slot1 or uv0[slot0]
		Dorm.lastMinigame = Dorm.minigame

		Dorm.LuaBridge.MiniGameBridge.Launch(slot0)
		DestroyLua()
		gameContext:SetSystemLayer("battle")
	end,
	Exit = function ()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		OpenPageUntilLoaded("/home")
	end,
	AdjustCameraFOV = function (slot0, slot1)
		slot3 = slot1 or manager.ui.mainCameraCom_.fieldOfView
		manager.ui.mainCameraCom_.fieldOfView = math.max(1 / slot0 / (Screen.width / Screen.height) * slot3, slot3)
	end
}
