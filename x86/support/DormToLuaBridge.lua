Dorm.timer = {}

function Dorm.NewTimer(...)
	slot0 = Timer.New(...)

	table.insert(Dorm.timer, slot0)

	return slot0
end

function slot0(slot0)
	Dorm.heroSpecialVfxInfo = {}

	Dorm.storage:MapToData(DormEnum.Namespace.HeroShowSpecialVfx, Dorm.heroSpecialVfxInfo)

	Dorm.charaVfxActiveType = slot0
end

function OnEnterDormScene(slot0)
	gameContext:SetSystemLayer("battle")
	DormLuaBridge.CalcDormSpawnBounds()

	if DormConst.DORM_VISIT_ROOM_MIN <= DormData:GetCurrectSceneID() then
		Dorm.DormEntityManager.EnablePlayerInput = false
	else
		Dorm.DormEntityManager.EnablePlayerInput = true
	end

	Dorm.storage = DormStorage.GetInstance()

	Dorm.storage:Reset()
	LuaForUtil.UpdateCameraSetting()

	if not slot0 then
		manager.uiInit()
	end

	Dorm.subtitleViewStack = {}
	Dorm.globalSubtitleView = SubtitleBubbleView.New()

	Dorm.globalSubtitleView:OnEnter()
	DormRegisterCMDEvent()
	uv0({
		DormEnum.SpecialVfx.Hungry
	})
	DormFurnitureManager.GetInstance():Init()
	DormCharacterManager.GetInstance():Init()
	DormCharacterActionManager:Init()
	DormCharacterInteractBehaviour:Init()

	if BackHomeCfg[DormData:GetCurrectSceneID()].type == DormConst.BACKHOME_TYPE.PublicDorm or slot2 == DormConst.BACKHOME_TYPE.PrivateDorm then
		DormAction.AskDormRoomLikeNum(slot1)
	end

	if DormitoryData:GetFlag() then
		gameContext:Go("/dormVisitView")
		DormitoryData:VisitFlag(nil)
	else
		gameContext:Go("/dorm")
	end

	manager.windowBar:SetWhereTag("dorm")
	DormFurnitureTools:GenerateFurnitureWhenEnterScene()
	DormHeroTools:GenerateHeroWhenEnterScene()
	Dorm.Enter()
end

function OnExitDormScene(slot0)
	Dorm.Leave()
	manager.audio:StopAll()
	manager.windowBar:ClearWhereTag()
	Dorm.globalSubtitleView:OnExit()

	Dorm.globalSubtitleView = Dorm.globalSubtitleView:Dispose()
	Dorm.subtitleViewStack = nil

	if slot0 then
		gameContext:DestroyCurRoutes()
	else
		DestroyLua()
	end

	DormCharacterManager.GetInstance():Reset()
	DormFurnitureManager.GetInstance():Reset()
	DormCharacterInteractBehaviour:Reset()
	DormCharacterActionManager:Reset()

	Dorm.charaVfxActiveType = nil
	Dorm.heroSpecialVfxInfo = nil
end

function OnClickFurniture(slot0, slot1, slot2)
	slot3 = nil

	if slot2 and slot2 >= 0 then
		slot3 = slot2
	end

	JumpTools.OpenPageByJump("/furnitureEdit", {
		type = "edit",
		itemId = slot0,
		furEntityID = slot1,
		furSuitEid = slot3
	})
end

function OnClickIllegalSuitFurniture(slot0, slot1, slot2)
	if slot2 == "otherSuit" then
		ShowTips("DORM_FURNITURE_CANT_ADD_OTHER_SUIT")
	elseif slot2 == "cantPlace" then
		ShowTips("DORM_SUIT_CANT_PlACE_ADD_FURNITURE")
	elseif slot2 == "wallFur" then
		ShowTips("DORM_FURNITURE_CANT_ADD_SUIT")
	end
end

function EnterSuitAllEditMode(slot0, slot1, slot2)
	manager.notify:Invoke(DORM_ENTER_SUIT_EDIT_MODE, slot0, slot1, slot2)
end

function OnEnterCanteenScene()
	gameContext:SetSystemLayer("battle")

	Dorm.DormEntityManager.EnablePlayerInput = false
	Dorm.sceneItemInfo = {}
	Dorm.charaVfxActiveType = {
		DormEnum.SpecialVfx.Tired
	}

	DormLuaBridge.RecordInfoFromDormTag()

	Dorm.timer = {}
	Dorm.storage = DormStorage.GetInstance()

	Dorm.storage:Reset()

	Dorm.restaurant = CanteenManager.GetInstance()

	LuaForUtil.UpdateCameraSetting()
	manager.uiInit()
	DormRegisterCMDEvent()
	manager.windowBar:SetWhereTag("canteen")
	uv0({
		DormEnum.SpecialVfx.Tired
	})
	Dorm.restaurant:RegisterEvent()
	Dorm.restaurant:Init()
	gameContext:Go("/restaurantMain")
	DormRedPointTools:ConsumeNotification(RedPointConst.CANTEEN_BUSINESS_STOPPED, DormRedPointTools.RedPointType.Session)
	CanteenTools:SwitchCanteenBgm(DormEnum.RestaurantMode.Start)
	Dorm.Enter()
end

function OnExitCanteenScene()
	Dorm.Leave()

	for slot3, slot4 in pairs(Dorm.timer) do
		slot4:Stop()
	end

	manager.audio:StopAll()
	manager.windowBar:ClearWhereTag()
	Dorm.restaurant:RemoveEvent()
	Dorm.restaurant:Reset()

	Dorm.sceneItemInfo = nil
	Dorm.charaVfxActiveType = nil
	Dorm.heroSpecialVfxInfo = nil

	DestroyLua()
end

function ChangeDormScene()
	DestroyLua()
end

function ChangeDormBackGround()
	slot1 = GameDisplayCfg.dorm_loading_picture

	if GameDisplayCfg.dorm_loading_tips and slot1 then
		LoadingUIManager.inst:UpdateLoadingInfo(GetTips(slot0.value[math.random(1, #slot0.value)][1]) or "", GetTips(slot0.value[slot2][2]) or "", slot1.value[math.random(1, #slot1.value)] or "loading_11")
	end
end
