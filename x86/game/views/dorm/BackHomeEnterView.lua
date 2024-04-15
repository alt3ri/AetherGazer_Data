slot0 = class("BackHomeEnterView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BackHouseUI/BackHouseUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.canteenBtn_, nil, function ()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Canteen then
			CanteenTools:SwitchCanteenBgm(DormEnum.RestaurantMode.Start)
			JumpTools.OpenPageByJump("/restaurantMain")
		else
			BackHomeTools:GotoBackHomeRoom(DormConst.CANTEEN_ID)
		end
	end)
	slot0:AddBtnListenerScale(slot0.dormBtn_, nil, function ()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
	slot0:AddBtnListenerScale(slot0.lockBtn_, nil, function ()
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Main then
			JumpTools.OpenPageByJump("/home")
		else
			BackHomeTools:BackHomeGotoMain()
		end
	end)
	manager.windowBar:RegistHomeCallBack(function ()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Main then
			JumpTools.OpenPageByJump("/home")
		else
			BackHomeTools:BackHomeGotoMain()
		end
	end)
	manager.redPoint:bindUIandKey(slot0.dormBtn_.transform, RedPointConst.DORM)
	manager.redPoint:bindUIandKey(slot0.canteenBtn_.transform, RedPointConst.CANTEEN)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(slot0.dormBtn_.transform, RedPointConst.DORM)
	manager.redPoint:unbindUIandKey(slot0.canteenBtn_.transform, RedPointConst.CANTEEN)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
