local var_0_0 = class("DormChooseRoomView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormEntranceUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()

	arg_3_0.canteenHeroStateScroll = LuaList.New(handler(arg_3_0, arg_3_0.indexHeroItem), arg_3_0.heroUilistGo_, BackHomeNewHeroItem)
	arg_3_0.danceHeroStateScroll = LuaList.New(handler(arg_3_0, arg_3_0.indexDanceHeroItem), arg_3_0.danceHeroUilistGo_, BackHomeNewHeroItem)
	arg_3_0.toggleGropu = {}

	local var_3_0 = GameDisplayCfg.dorm_area_layer_num.value[1]

	for iter_3_0 = 1, var_3_0 do
		arg_3_0.toggleGropu[iter_3_0] = arg_3_0["floor" .. iter_3_0 .. "Tgl_"]
	end

	arg_3_0.roomItemView = DromPrivateRoomItem.New(arg_3_0.dormRoomItem)

	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitController()
end

function var_0_0.InitController(arg_5_0)
	arg_5_0.canteenTaskStateController = ControllerUtil.GetController(arg_5_0.canteenstateTrs_, "taskstate")
	arg_5_0.canteenFoodEnoughController = ControllerUtil.GetController(arg_5_0.canteenstateTrs_, "foodstate")
	arg_5_0.danceTaskController = ControllerUtil.GetController(arg_5_0.danceTaskTrs_, "taskstate")
	arg_5_0.listShowController = arg_5_0.showController:GetController("switch")
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:RefreshFloorInfo()

	arg_6_0.moveFlag = false

	arg_6_0:RegisterEvent()
	DormRedPointTools:UpdataDormRedPoint(false)
	arg_6_0:BindRedPoint()
	arg_6_0.roomItemView:OnEnter()
	arg_6_0:RefreshCanteenState()
	arg_6_0:RefreshDanceState()
end

function var_0_0.OnBehind(arg_7_0)
	arg_7_0.roomItemView:OnBehind()
end

function var_0_0.BindRedPoint(arg_8_0)
	manager.redPoint:bindUIandKey(arg_8_0.redpoint, RedPointConst.CANTEEN)
end

function var_0_0.UnBindRedPoint(arg_9_0)
	manager.redPoint:unbindUIandKey(arg_9_0.redpoint, RedPointConst.CANTEEN)
end

function var_0_0.RefreshFloorInfo(arg_10_0)
	if not arg_10_0.floor then
		arg_10_0.floor = DormitoryData:GetFloor() or 1
	end

	arg_10_0.toggleGropu[arg_10_0.floor].isOn = true

	for iter_10_0 = 1, GameDisplayCfg.dorm_area_layer_num.value[1] do
		arg_10_0["text" .. iter_10_0 .. "Text_"].text = iter_10_0 .. "F"
	end

	arg_10_0:RefreshRoomItem()
end

function var_0_0.OnTop(arg_11_0)
	arg_11_0:UpdateBar()
	arg_11_0.roomItemView:OnTop()
end

function var_0_0.OnUpdate(arg_12_0)
	arg_12_0.roomItemView:OnUpdate()
end

function var_0_0.UpdateBar(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		CurrencyConst.CURRENCY_TYPE_DORM_GOLD,
		DormConst.DORM_HOME_UNLOCK_ROOM_CURRENCY
	})
	manager.windowBar:SetBarCanAdd(DormConst.DORM_HOME_UNLOCK_ROOM_CURRENCY, true)
	manager.windowBar:RegistBackCallBack(function()
		arg_13_0.roomItemView:OnExit()

		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Main then
			BackHomeDataManager:ExitBackHomeSystem()
			JumpTools.OpenPageByJump("/home")
		else
			BackHomeTools:BackHomeGotoMain()
		end
	end)
end

function var_0_0.RegisterEvent(arg_15_0)
	arg_15_0:RegistEventListener(DORM_PRIVATE_LEVEL_UP, function()
		arg_15_0:RefreshRoomItem()
	end)
	arg_15_0:RegistEventListener(DORM_HERO_OCCUPY, function()
		if arg_15_0.floor then
			arg_15_0.roomItemView:RefreshUI(arg_15_0.floor)
		end
	end)
	arg_15_0:RegistEventListener(CANTEEN_SET_JOG_SUCCESS, function()
		arg_15_0:RefreshCanteenState()
	end)
	arg_15_0:RegistEventListener(SHOW_MESSAGE_BOX, function()
		arg_15_0:OnBehind()
	end)
	arg_15_0:RegistEventListener(CLOSE_MESSAGE_BOX, function()
		arg_15_0:OnTop()
	end)
	arg_15_0:RegistEventListener(GUIDE_START, function()
		arg_15_0:OnTop()
	end)
end

function var_0_0.OnExit(arg_22_0)
	arg_22_0.roomItemView:OnExit()
	manager.windowBar:HideBar()
	arg_22_0:RemoveAllEventListener()
	arg_22_0:UnBindRedPoint()
end

function var_0_0.AddUIListener(arg_23_0)
	arg_23_0:AddBtnListener(arg_23_0.canteenBtn_, nil, function()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Canteen then
			CanteenTools:SwitchCanteenBgm(DormEnum.RestaurantMode.Start)
			JumpTools.OpenPageByJump("/restaurantMain")
		else
			BackHomeTools:GotoBackHomeRoom(DormConst.CANTEEN_ID)
		end
	end)

	for iter_23_0 = 1, DormConst.DORM_FLOOR_MAX do
		if arg_23_0["floor" .. iter_23_0 .. "Tgl_"] then
			arg_23_0:AddToggleListener(arg_23_0["floor" .. iter_23_0 .. "Tgl_"], function(arg_25_0)
				if arg_25_0 then
					arg_23_0:ClickChangeFloor(iter_23_0)
				end
			end)
		end
	end

	arg_23_0:AddBtnListenerScale(arg_23_0.visitBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormVisitView", {
			back = "chooseRoom"
		})
	end)
	arg_23_0:AddBtnListenerScale(arg_23_0.btnupBtn_, nil, function()
		if arg_23_0.floor < DormConst.DORM_FLOOR_MAX then
			local var_27_0 = arg_23_0.floor + 1

			arg_23_0:ClickChangeFloor(var_27_0)
		end
	end)
	arg_23_0:AddBtnListenerScale(arg_23_0.btnunderBtn_, nil, function()
		if arg_23_0.floor > 1 then
			local var_28_0 = arg_23_0.floor - 1

			arg_23_0:ClickChangeFloor(var_28_0)
		end
	end)
	arg_23_0:AddBtnListener(arg_23_0.cricketBtn, nil, function()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.CricketBattle then
			JumpTools.OpenPageByJump("/idolTraineeCamp")

			return
		end

		BackHomeTools:GotoBackHomeRoom(nil, true)
	end)
	arg_23_0:AddBtnListener(arg_23_0.showBtn, nil, function()
		if arg_23_0.listShowController:GetSelectedState() == "off" then
			arg_23_0.listShowController:SetSelectedState("on")
			arg_23_0:RefreshCanteenState()
			arg_23_0:RefreshDanceState()
		else
			arg_23_0.listShowController:SetSelectedState("off")
		end
	end)
end

function var_0_0.ClickChangeFloor(arg_31_0, arg_31_1)
	if arg_31_0.roomItemView.edit then
		return
	end

	if arg_31_0.floor == arg_31_1 then
		return
	end

	arg_31_0.floor = arg_31_1
	arg_31_0.toggleGropu[arg_31_0.floor].isOn = true

	arg_31_0:RefreshRoomItem()
	DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.ChangeFloor)
	arg_31_0.roomItemView:PlayFloorAnimation()
end

function var_0_0.RefreshCanteenState(arg_32_0)
	if CanteenEntrustData.AnyEntrustFinished() then
		arg_32_0.canteenTaskStateController:SetSelectedState("true")
	else
		arg_32_0.canteenTaskStateController:SetSelectedState("false")
	end

	if CanteenTools:CheckSignFoodNumCanOpen() then
		arg_32_0.canteenFoodEnoughController:SetSelectedState("false")
	else
		arg_32_0.canteenFoodEnoughController:SetSelectedState("true")
	end

	arg_32_0:RefreshCanteenJobItem()
end

function var_0_0.RefreshRoomItem(arg_33_0)
	if arg_33_0.floor then
		arg_33_0.roomItemView:RefreshUI(arg_33_0.floor)
	end
end

function var_0_0.RefreshCanteenJobItem(arg_34_0)
	arg_34_0.workHeroList = {}

	local var_34_0 = CanteenHeroTools:GetCanteenJobList()

	if var_34_0 then
		for iter_34_0, iter_34_1 in ipairs(var_34_0) do
			table.insert(arg_34_0.workHeroList, iter_34_1.heroID or -1)
		end
	end

	arg_34_0.canteenHeroStateScroll:StartScroll(#arg_34_0.workHeroList)
end

function var_0_0.indexHeroItem(arg_35_0, arg_35_1, arg_35_2)
	arg_35_2:SetItemFunction({
		showFatigue = true,
		showJobState = true
	})
	arg_35_2:RefreshUI(arg_35_0.workHeroList[arg_35_1])
end

function var_0_0.indexDanceHeroItem(arg_36_0, arg_36_1, arg_36_2)
	arg_36_2:SetItemFunction({
		showFatigue = true,
		showJobState = true
	})
	arg_36_2:RefreshUI(arg_36_0.danceHeroList[arg_36_1])
end

function var_0_0.RefreshDanceState(arg_37_0)
	arg_37_0.danceHeroList = {}

	local var_37_0 = DormHeroTools:GetHeroListInDance()
	local var_37_1 = GameSetting.dorm_idol_room_max_place.value[1]

	for iter_37_0 = 1, var_37_1 do
		arg_37_0.danceHeroList[iter_37_0] = 0
	end

	for iter_37_1, iter_37_2 in ipairs(var_37_0) do
		if iter_37_2.dancePos then
			arg_37_0.danceHeroList[iter_37_2.dancePos] = iter_37_2.hero_id
		end
	end

	arg_37_0.danceHeroStateScroll:StartScroll(#arg_37_0.danceHeroList)

	if IdolTraineeTools:CheckDanceTaskComplete() then
		arg_37_0.danceTaskController:SetSelectedState("true")
	else
		arg_37_0.danceTaskController:SetSelectedState("false")
	end
end

function var_0_0.Dispose(arg_38_0)
	if arg_38_0.canteenHeroStateScroll then
		arg_38_0.canteenHeroStateScroll:Dispose()
	end

	if arg_38_0.danceHeroStateScroll then
		arg_38_0.danceHeroStateScroll:Dispose()
	end

	if arg_38_0.roomItemView then
		arg_38_0.roomItemView:Dispose()
	end

	DormitoryData:SetFloor(arg_38_0.floor)
	var_0_0.super.Dispose(arg_38_0)
end

return var_0_0
