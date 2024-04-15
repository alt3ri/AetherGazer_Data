slot0 = class("DormChooseRoomView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dorm/DormEntranceUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.canteenHeroStateScroll = LuaList.New(handler(slot0, slot0.indexHeroItem), slot0.heroUilistGo_, BackHomeNewHeroItem)
	slot0.danceHeroStateScroll = LuaList.New(handler(slot0, slot0.indexDanceHeroItem), slot0.danceHeroUilistGo_, BackHomeNewHeroItem)
	slot0.toggleGropu = {}

	for slot5 = 1, GameDisplayCfg.dorm_area_layer_num.value[1] do
		slot0.toggleGropu[slot5] = slot0["floor" .. slot5 .. "Tgl_"]
	end

	slot0.roomItemView = DromPrivateRoomItem.New(slot0.dormRoomItem)

	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:InitController()
end

function slot0.InitController(slot0)
	slot0.canteenTaskStateController = ControllerUtil.GetController(slot0.canteenstateTrs_, "taskstate")
	slot0.canteenFoodEnoughController = ControllerUtil.GetController(slot0.canteenstateTrs_, "foodstate")
	slot0.danceTaskController = ControllerUtil.GetController(slot0.danceTaskTrs_, "taskstate")
	slot0.listShowController = slot0.showController:GetController("switch")
end

function slot0.OnEnter(slot0)
	slot0:RefreshFloorInfo()

	slot0.moveFlag = false

	slot0:RegisterEvent()
	DormRedPointTools:UpdataDormRedPoint(false)
	slot0:BindRedPoint()
	slot0.roomItemView:OnEnter()
	slot0:RefreshCanteenState()
	slot0:RefreshDanceState()
end

function slot0.OnBehind(slot0)
	slot0.roomItemView:OnBehind()
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.redpoint, RedPointConst.CANTEEN)
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.redpoint, RedPointConst.CANTEEN)
end

function slot0.RefreshFloorInfo(slot0)
	if not slot0.floor then
		slot0.floor = DormitoryData:GetFloor() or 1
	end

	slot0.toggleGropu[slot0.floor].isOn = true

	for slot4 = 1, GameDisplayCfg.dorm_area_layer_num.value[1] do
		slot0["text" .. slot4 .. "Text_"].text = slot4 .. "F"
	end

	slot0:RefreshRoomItem()
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
	slot0.roomItemView:OnTop()
end

function slot0.OnUpdate(slot0)
	slot0.roomItemView:OnUpdate()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		CurrencyConst.CURRENCY_TYPE_DORM_GOLD,
		DormConst.DORM_HOME_UNLOCK_ROOM_CURRENCY
	})
	manager.windowBar:SetBarCanAdd(DormConst.DORM_HOME_UNLOCK_ROOM_CURRENCY, true)
	manager.windowBar:RegistBackCallBack(function ()
		uv0.roomItemView:OnExit()

		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Main then
			BackHomeDataManager:ExitBackHomeSystem()
			JumpTools.OpenPageByJump("/home")
		else
			BackHomeTools:BackHomeGotoMain()
		end
	end)
end

function slot0.RegisterEvent(slot0)
	slot0:RegistEventListener(DORM_PRIVATE_LEVEL_UP, function ()
		uv0:RefreshRoomItem()
	end)
	slot0:RegistEventListener(DORM_HERO_OCCUPY, function ()
		if uv0.floor then
			uv0.roomItemView:RefreshUI(uv0.floor)
		end
	end)
	slot0:RegistEventListener(CANTEEN_SET_JOG_SUCCESS, function ()
		uv0:RefreshCanteenState()
	end)
	slot0:RegistEventListener(SHOW_MESSAGE_BOX, function ()
		uv0:OnBehind()
	end)
	slot0:RegistEventListener(CLOSE_MESSAGE_BOX, function ()
		uv0:OnTop()
	end)
	slot0:RegistEventListener(GUIDE_START, function ()
		uv0:OnTop()
	end)
end

function slot0.OnExit(slot0)
	slot0.roomItemView:OnExit()
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
	slot0:UnBindRedPoint()
end

function slot0.AddUIListener(slot0)
	slot4 = nil

	slot0:AddBtnListener(slot0.canteenBtn_, slot4, function ()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Canteen then
			CanteenTools:SwitchCanteenBgm(DormEnum.RestaurantMode.Start)
			JumpTools.OpenPageByJump("/restaurantMain")
		else
			BackHomeTools:GotoBackHomeRoom(DormConst.CANTEEN_ID)
		end
	end)

	for slot4 = 1, DormConst.DORM_FLOOR_MAX do
		if slot0["floor" .. slot4 .. "Tgl_"] then
			slot0:AddToggleListener(slot0["floor" .. slot4 .. "Tgl_"], function (slot0)
				if slot0 then
					uv0:ClickChangeFloor(uv1)
				end
			end)
		end
	end

	slot0:AddBtnListenerScale(slot0.visitBtn_, nil, function ()
		JumpTools.OpenPageByJump("/dormVisitView", {
			back = "chooseRoom"
		})
	end)
	slot0:AddBtnListenerScale(slot0.btnupBtn_, nil, function ()
		if uv0.floor < DormConst.DORM_FLOOR_MAX then
			uv0:ClickChangeFloor(uv0.floor + 1)
		end
	end)
	slot0:AddBtnListenerScale(slot0.btnunderBtn_, nil, function ()
		if uv0.floor > 1 then
			uv0:ClickChangeFloor(uv0.floor - 1)
		end
	end)
	slot0:AddBtnListener(slot0.cricketBtn, nil, function ()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.CricketBattle then
			JumpTools.OpenPageByJump("/idolTraineeCamp")

			return
		end

		BackHomeTools:GotoBackHomeRoom(nil, true)
	end)
	slot0:AddBtnListener(slot0.showBtn, nil, function ()
		if uv0.listShowController:GetSelectedState() == "off" then
			uv0.listShowController:SetSelectedState("on")
			uv0:RefreshCanteenState()
			uv0:RefreshDanceState()
		else
			uv0.listShowController:SetSelectedState("off")
		end
	end)
end

function slot0.ClickChangeFloor(slot0, slot1)
	if slot0.roomItemView.edit then
		return
	end

	if slot0.floor == slot1 then
		return
	end

	slot0.floor = slot1
	slot0.toggleGropu[slot0.floor].isOn = true

	slot0:RefreshRoomItem()
	DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.ChangeFloor)
	slot0.roomItemView:PlayFloorAnimation()
end

function slot0.RefreshCanteenState(slot0)
	if CanteenEntrustData.AnyEntrustFinished() then
		slot0.canteenTaskStateController:SetSelectedState("true")
	else
		slot0.canteenTaskStateController:SetSelectedState("false")
	end

	if CanteenTools:CheckSignFoodNumCanOpen() then
		slot0.canteenFoodEnoughController:SetSelectedState("false")
	else
		slot0.canteenFoodEnoughController:SetSelectedState("true")
	end

	slot0:RefreshCanteenJobItem()
end

function slot0.RefreshRoomItem(slot0)
	if slot0.floor then
		slot0.roomItemView:RefreshUI(slot0.floor)
	end
end

function slot0.RefreshCanteenJobItem(slot0)
	slot0.workHeroList = {}

	if CanteenHeroTools:GetCanteenJobList() then
		for slot5, slot6 in ipairs(slot1) do
			table.insert(slot0.workHeroList, slot6.heroID or -1)
		end
	end

	slot0.canteenHeroStateScroll:StartScroll(#slot0.workHeroList)
end

function slot0.indexHeroItem(slot0, slot1, slot2)
	slot2:SetItemFunction({
		showFatigue = true,
		showJobState = true
	})
	slot2:RefreshUI(slot0.workHeroList[slot1])
end

function slot0.indexDanceHeroItem(slot0, slot1, slot2)
	slot2:SetItemFunction({
		showFatigue = true,
		showJobState = true
	})
	slot2:RefreshUI(slot0.danceHeroList[slot1])
end

function slot0.RefreshDanceState(slot0)
	slot0.danceHeroList = {}
	slot1 = DormHeroTools:GetHeroListInDance()

	for slot6 = 1, GameSetting.dorm_idol_room_max_place.value[1] do
		slot0.danceHeroList[slot6] = 0
	end

	for slot6, slot7 in ipairs(slot1) do
		if slot7.dancePos then
			slot0.danceHeroList[slot7.dancePos] = slot7.hero_id
		end
	end

	slot0.danceHeroStateScroll:StartScroll(#slot0.danceHeroList)

	if IdolTraineeTools:CheckDanceTaskComplete() then
		slot0.danceTaskController:SetSelectedState("true")
	else
		slot0.danceTaskController:SetSelectedState("false")
	end
end

function slot0.Dispose(slot0)
	if slot0.canteenHeroStateScroll then
		slot0.canteenHeroStateScroll:Dispose()
	end

	if slot0.danceHeroStateScroll then
		slot0.danceHeroStateScroll:Dispose()
	end

	if slot0.roomItemView then
		slot0.roomItemView:Dispose()
	end

	DormitoryData:SetFloor(slot0.floor)
	uv0.super.Dispose(slot0)
end

return slot0
