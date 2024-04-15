slot0 = class("DormVisitView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dorm/DormVisitUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.refreshFlag = true
	slot0.refreshTimer = Timer.New(function ()
		uv0.refreshFlag = true
	end, GameSetting.dorm_recommend_refresh_cd.value[1], 1)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexTemplate), slot0.uilistGo_, DormVisitItem)
end

function slot0.OnEnter(slot0)
	slot0.enterType = slot0.params_.enterType
	slot0.back = slot0.params_.back or nil

	slot0:RegisterEvents()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		if uv0.back == "chooseRoom" then
			JumpTools.OpenPageByJump("/dormChooseRoomView")

			return
		end

		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Canteen then
			JumpTools.OpenPageByJump("/restaurantMain")
		elseif slot0 == DormEnum.DormSystemType.Dormitory then
			if uv0.enterType == "quick" then
				JumpTools.OpenPageByJump("/dorm")
			else
				JumpTools.OpenPageByJump("/dormChooseRoomView")
			end
		elseif slot0 == DormEnum.DormSystemType.Main then
			JumpTools.OpenPageByJump("/dormChooseRoomView")
		elseif slot0 == DormEnum.DormSystemType.CricketBattle then
			JumpTools.OpenPageByJump("/idolTraineeCamp")
		end
	end)
	slot0:SelGroup(slot0.groupID or DormVisitTools:GetListIndex() or 1)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()

	slot0.enterType = nil
end

function slot0.AddUIListener(slot0)
	for slot4 = 1, 2 do
		slot0:AddToggleListener(slot0["tog_" .. slot4], function (slot0)
			if slot0 then
				uv0:SelGroup(uv1)
			end
		end)
	end

	slot0:AddDragListener(slot0.uilistGo_, function ()
	end, function ()
	end, function ()
		if uv0.loadingGo_.transform.sizeDelta.y < -1 * uv0.contentGo_.transform.anchoredPosition.y then
			if not uv0.refreshFlag then
				ShowTips(GetTips("DORM_RECOMMEND_CD"))

				return
			else
				uv0.refreshFlag = false

				uv0.refreshTimer:Start()
				DormAction:AskFurTemplateExhibitList(uv0.groupID)
			end
		end
	end)
end

function slot0.SelGroup(slot0, slot1)
	if slot0.groupID == slot1 then
		return
	end

	slot0.groupID = slot1
	slot0["tog_" .. slot0.groupID].isOn = true

	slot0:RefreshList()
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_REFRESH_TEMPLATE_EXHI, function ()
		uv0:RefreshList()
	end)
end

function slot0.indexTemplate(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.visitList[slot1], slot0.groupID)
	slot2:RegisterEnterCallBack(function (slot0)
		SDKTools.SendMessageToSDK("backhome_dorm_visit_jump", {
			backhome_source = 2
		})
		DormVisitTools:SetListIndex(uv0.groupID)
		DormAction:AskSingleFurTemplateExhibit(slot0)
	end)
end

function slot0.RefreshList(slot0)
	slot0.visitList = {}

	if DormVisitTools:GetTemplateExhibitList(slot0.groupID) then
		for slot5, slot6 in pairs(slot1) do
			table.insert(slot0.visitList, slot5)
		end

		slot0.scrollHelper_:StartScroll(#slot0.visitList)
	end
end

function slot0.Dispose(slot0)
	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Dispose()

		slot0.scrollHelper_ = nil
	end

	if slot0.refreshTimer then
		slot0.refreshTimer:Stop()

		slot0.refreshTimer = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
