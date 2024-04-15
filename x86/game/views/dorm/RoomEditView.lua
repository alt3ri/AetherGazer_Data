slot0 = class("RoomEditView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dorm/DormEditstatusUI"
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

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, FurnitureItem)
	slot0.choiceController = ControllerUtil.GetController(slot0.screeningswitchTrs_, "choice")
	slot0.switchController = ControllerUtil.GetController(slot0.screeningswitchTrs_, "switch")
	slot0.canPlaceController = ControllerUtil.GetController(slot0.canPlace.transform, "name")
	slot0.notPresentedController = ControllerUtil.GetController(slot0.notPresented.transform, "name")
	slot0.hadPlaceController = ControllerUtil.GetController(slot0.hadPlace.transform, "name")
	slot0.otherHadPlaceController = ControllerUtil.GetController(slot0.otherHadPlace.transform, "name")
	slot0.descController = ControllerUtil.GetController(slot0.transform_, "desc")
	slot0.descText.text = GetTips("DORM_FURNITURE_EDIT_INFO")
	slot0.devController = ControllerUtil.GetController(slot0.transform_, "devState")
	slot0.suitController = ControllerUtil.GetController(slot0.transform_, "suitPage")
end

function slot0.OnEnter(slot0)
	slot0.roomID = DormData:GetCurrectSceneID()
	slot0.roomData = DormitoryData:GetDormSceneData(slot0.roomID)

	DormLuaBridge.ChangeCameraMode(1, true)
	DormLuaBridge.SetIsCanEditTag(true)

	slot0.selectIndex_ = slot0.params_.index or DormConst.FLOOR_TYPE_NUM
	slot0.params_.index = slot0.selectIndex_
	slot0.filterShow = false

	slot0:RegisterEvents()
	slot0:BindRedPoint()
end

function slot0.OnTop(slot0)
	slot0:RefreshView(true)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	slot0:UnBindRedPoint()
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_REFRESH_GIFT_FUR_LIST, function ()
		if uv0.scrollHelper_ then
			uv0:RefreshView(true)
		end
	end)
end

function slot0.BindRedPoint(slot0)
	for slot4 = DormConst.DORM_FUR_TYPE_START, DormConst.DORM_FUR_TYPE_END - 1 do
		manager.redPoint:bindUIandKey(slot0["item_" .. slot4 .. "icon"], string.format("%s_%s", RedPointConst.DORM_FURNITURE, tostring(slot4)))
	end

	manager.redPoint:bindUIandKey(slot0["item_" .. 28 .. "icon"], RedPointConst.DORM_SUIT)

	if BackHomeCfg[slot0.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		manager.redPoint:bindUIandKey(slot0.suitBtn1.transform, RedPointConst.DORM_FULL_PUBLIC_SUIT)
	elseif slot1 == DormConst.BACKHOME_TYPE.PrivateDorm then
		manager.redPoint:bindUIandKey(slot0.suitBtn1.transform, RedPointConst.DORM_FULL_PRIVATE_SUIT)
	end

	manager.redPoint:bindUIandKey(slot0.suitBtn2.transform, RedPointConst.DORM_PART_SUIT)
end

function slot0.UnBindRedPoint(slot0)
	for slot4 = DormConst.DORM_FUR_TYPE_START, DormConst.DORM_FUR_TYPE_END - 1 do
		manager.redPoint:unbindUIandKey(slot0["item_" .. slot4 .. "icon"], string.format("%s_%s", RedPointConst.DORM_FURNITURE, tostring(slot4)))
	end

	manager.redPoint:unbindUIandKey(slot0["item_" .. 28 .. "icon"], RedPointConst.DORM_SUIT)

	if BackHomeCfg[slot0.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		manager.redPoint:unbindUIandKey(slot0.suitBtn1.transform, RedPointConst.DORM_FULL_PUBLIC_SUIT)
	elseif slot1 == DormConst.BACKHOME_TYPE.PrivateDorm then
		manager.redPoint:unbindUIandKey(slot0.suitBtn1.transform, RedPointConst.DORM_FULL_PRIVATE_SUIT)
	end

	manager.redPoint:unbindUIandKey(slot0.suitBtn2.gameObject.transform, RedPointConst.DORM_PART_SUIT)

	if slot0.scrollHelper_ then
		for slot6, slot7 in pairs(slot0.scrollHelper_:GetItemList()) do
			manager.redPoint:unbindUIandKey(slot7.transform_)
		end
	end
end

function slot0.RefreshView(slot0, slot1)
	slot0:InitRoomCanUseFurList()
	slot0:OnGroupSelect(slot0.selectIndex_, slot1)
	slot0:UpdataHasPlaceFurNum()
	slot0:RefreshEditTypeSwichBar()
	slot0:RefreshDevInfo()
end

function slot0.UpdataHasPlaceFurNum(slot0)
	slot0.curNum.text = DormFurnitureTools:GetHasPlaceFurNumInfoInMap(slot0.roomID) + DormFurEditStateData:GetCacheFurTotalNum() + DormConst.DORM_SPECIAL_FURNITURE_NUM
	slot3 = 0

	if BackHomeCfg[slot0.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		slot3 = GameSetting.dorm_lobby_furniture_limited.value[1]
	elseif BackHomeCfg[slot0.roomID].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		slot3 = BackHomeDormLevel[DormitoryData:GetDormLevel(slot0.roomID)].furniture_max
	end

	slot0.totalNum.text = "/" .. slot3
end

function slot0.InitRoomCanUseFurList(slot0)
	slot0.furList = {}

	if DormFurnitureTools:GetFurEditFlag().canPlaceFlag then
		slot0.canPlaceList = DormFurnitureTools:GetRoomCanPlaceFurList(slot0.roomID)

		for slot5, slot6 in ipairs(slot0.canPlaceList) do
			table.insert(slot0.furList, {
				furID = slot6,
				type = DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace
			})
		end
	end

	if slot1.notPresentedFlag then
		slot0.notPresentedList = DormFurnitureTools:GetNotPresentedFurInRoom(slot0.roomID)

		for slot5, slot6 in ipairs(slot0.notPresentedList) do
			table.insert(slot0.furList, {
				furID = slot6,
				type = DormConst.DORM_FUR_EDITVIEW_TYPE.NotPresented
			})
		end
	end

	if slot1.hadPlaceFlag then
		slot0.hadPlaceFurList = DormFurEditStateData:GetHadPlaceFurNumInRoom(slot0.roomID)

		for slot5, slot6 in ipairs(slot0.hadPlaceFurList) do
			table.insert(slot0.furList, {
				furID = slot6,
				type = DormConst.DORM_FUR_EDITVIEW_TYPE.HadPlace
			})
		end
	end

	if slot1.otherHadPlaceFlag then
		slot0.otherHadPlaceFurList = DormFurnitureTools:GetHadPlaceFlagFurInRoom(slot0.roomID)

		for slot5, slot6 in ipairs(slot0.otherHadPlaceFurList) do
			table.insert(slot0.furList, {
				furID = slot6,
				type = DormConst.DORM_FUR_EDITVIEW_TYPE.OtherHadPlace
			})
		end
	end
end

function slot0.RefreshEditTypeSwichBar(slot0)
	if slot0.filterShow then
		slot0.switchController:SetSelectedState("on")
		slot0:RefreshFurEditTypeController()
	else
		slot0.switchController:SetSelectedState("off")
	end

	for slot5, slot6 in pairs(DormFurnitureTools:GetFurEditFlag()) do
		if not slot1[slot5] then
			slot0.choiceController:SetSelectedState("single")

			return
		end
	end

	slot0.choiceController:SetSelectedState("all")
end

function slot0.OnGroupSelect(slot0, slot1, slot2)
	if slot0.selectIndex_ == slot1 and not slot2 then
		return
	end

	slot0:ClickCurSuitListRedPoint()
	slot0.descController:SetSelectedState("false")

	slot0.selectIndex_ = slot1
	slot0.params_.index = slot0.selectIndex_
	slot0["item_" .. slot0.selectIndex_ .. "Tgl_"].isOn = true
	slot0.dataList_ = {}

	if slot0.selectIndex_ == DormConst.DORM_SUIT_TYPE then
		slot0.suitController:SetSelectedState("true")
		slot0:SelectEditSuitSetType(slot0.suitTypeIndex or 1)
	else
		slot0.selItem_ = nil

		slot0.suitController:SetSelectedState("false")

		if slot0.furList then
			for slot6, slot7 in ipairs(slot0.furList) do
				if BackHomeFurniture[slot7.furID].type == slot1 then
					table.insert(slot0.dataList_, slot7)
				end
			end
		end

		slot0.scrollHelper_:StartScroll(#slot0.dataList_)

		if slot0.selIndex then
			slot0.scrollHelper_:ScrollToIndex(slot0.selIndex, true, false)
		end

		slot0.redPointList = {}

		for slot6, slot7 in ipairs(slot0.dataList_) do
			if slot7.type == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
				table.insert(slot0.redPointList, slot7)
			end
		end

		DormRedPointTools:CloseDormFurRedPoint(slot0.roomID, slot0.selectIndex_, slot0.redPointList)
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	if slot0.selectIndex_ == DormConst.DORM_SUIT_TYPE then
		slot2:RefreshUI(slot0.dataList_[slot1], slot0.selItem_, DormEnum.FurItemType.SuitEdit, nil, slot1, slot0.suitTypeIndex)
	else
		slot2:RefreshUI(slot0.dataList_[slot1], slot0.selItem_, DormEnum.FurItemType.Edit, nil, slot1)
	end

	slot2:OnPointerDown(function (slot0, slot1, slot2)
		uv0.furType = slot2

		if slot2 == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace or DormSuitData:CheckIsSuit(slot0) then
			uv0.selItem_ = slot0
			uv0.selIndex = slot1

			uv0.scrollHelper_:Refresh()
			uv0.descController:SetSelectedState("true")
		end

		if DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot0) and slot2 == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
			JumpTools.OpenPageByJump("/furnitureEdit", {
				type = "drag",
				itemId = slot0,
				itemType = uv0.selItemType
			})
		else
			slot3, slot4 = DormSuitData:CheckIsSuit(slot0)

			if slot3 then
				DormRedPointTools:ClickSuitIconRedPoint(slot0)

				if slot4 == DormSuitTools.DORM_SUIT_TYPE.FULL_SET then
					DormSuitEditData:EnterFullSuitEditMode()
					DormFurnitureTools:SetEditFurFlag(true)
					DormSuitTools:GenerateFullSetFurSuit(slot0)
					JumpTools.OpenPageByJump("/dormSuitFurInfoView", {
						suitID = slot0
					})
				end
			end
		end
	end)
	slot2:GrayCallBack(function (slot0, slot1, slot2, slot3, slot4)
		slot5, slot6 = DormSuitData:CheckIsSuit(slot0)

		if slot5 then
			uv0.selItem_ = slot0

			uv0.scrollHelper_:Refresh()

			if slot6 == DormSuitTools.DORM_SUIT_TYPE.FULL_SET then
				DormSuitEditData:EnterFullSuitEditMode()
				DormSuitTools:GenerateFullSetFurSuit(slot0)
				JumpTools.OpenPageByJump("/dormSuitFurInfoView", {
					suitID = slot0
				})
			elseif slot6 == DormSuitTools.DORM_SUIT_TYPE.PART_SET then
				JumpTools.OpenPageByJump("dormPartSuitInfoPopView", {
					suitID = slot0
				})
			end

			DormRedPointTools:ClickSuitIconRedPoint(slot0)
		else
			uv0.selIndex = slot1
			uv0.params_.index = uv0.selectIndex_

			if BackHomeCfg[uv0.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
				JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
					state = "gift",
					furID = slot0
				})
			elseif slot7 == DormConst.BACKHOME_TYPE.PrivateDorm then
				JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
					state = "gift",
					furID = slot0
				})
			end
		end
	end)
	slot2:ItemInfoCallBack(function (slot0)
		uv0.selItem_ = slot0

		uv0.scrollHelper_:Refresh()
		JumpTools.OpenPageByJump("dormPartSuitInfoPopView", {
			suitID = slot0
		})
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.saveBtn_, nil, function ()
		if DormData:GetDevModelFlag() then
			JumpTools.OpenPageByJump("dormChangeTemplateNameView", {
				showText = "",
				callBack = function (slot0)
					if not string.isNullOrEmpty(slot0) then
						DormSuitData:SetSuitSerializeData(slot0)
						uv0:SaveFurEditList()
					end
				end
			})
		else
			uv0:SaveFurEditList()
		end
	end)
	slot0:AddBtnListenerScale(slot0.resetBtn_, nil, function ()
		ShowMessageBox({
			isTop = true,
			content = GetTips("DORM_EDIT_CLEAN"),
			OkCallback = function ()
				DormFurnitureTools:SetEditFurFlag(true)
				DormFurEditStateData:RestoreRoomAllFurniture()
				DormFurnitureManager.GetInstance():ClearAndGenByFurList()
				uv0:RefreshView(true)
			end,
			CancelCallback = function ()
			end
		})
	end)

	slot4 = nil

	slot0:AddBtnListenerScale(slot0.cancelBtn_, slot4, function ()
		if DormFurnitureTools:GetEditFurFlag() then
			ShowMessageBox({
				isTop = true,
				content = GetTips("DORM_EDIT_CANCEL"),
				OkCallback = function ()
					DormFurnitureTools:GenerateFurnitureWhenEnterScene()
					uv0:BackToDormHomeView()
				end,
				CancelCallback = function ()
				end
			})
		else
			uv0:BackToDormHomeView()
		end
	end)

	for slot4 = DormConst.DORM_FUR_TYPE_START, DormConst.DORM_FUR_TYPE_END do
		slot0:AddToggleListener(slot0["item_" .. slot4 .. "Tgl_"], function (slot0)
			if slot0 then
				uv0:OnGroupSelect(uv1)
			end
		end)
	end

	slot0.uilistSrex_.ExitScrollArea:AddListener(function ()
		if uv0.selItem_ then
			if not DormFurnitureTools:GetIsOverLoad(uv0.roomID) then
				ShowTips(GetTips("DORM_FURNITURE_SET_MAX"))

				return
			end

			slot0 = false

			if DormSuitData:CheckIsSuit(uv0.selItem_) then
				if DormSuitData:CheckSuitCanUseInRoom(uv0.selItem_, uv0.roomID) then
					slot0 = true
				end
			elseif uv0.furType == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
				slot0 = true
			end

			if slot0 then
				JumpTools.OpenPageByJump("/furnitureEdit", {
					type = "drag",
					itemId = uv0.selItem_,
					itemType = uv0.selItemType
				})
				DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.PlaceFur)
			end
		end
	end)
	slot0:AddBtnListenerScale(slot0.filterbtn_, nil, function ()
		if not uv0.filterShow then
			uv0.filterShow = true
		else
			uv0.filterShow = false
		end

		uv0:RefreshEditTypeSwichBar()
	end)
	slot0:AddBtnListenerScale(slot0.canPlacebtn_, nil, function ()
		if DormFurnitureTools:GetFurEditFlag().canPlaceFlag then
			slot0.canPlaceFlag = false
		else
			slot0.canPlaceFlag = true
		end

		uv0.selIndex = nil

		uv0:RefreshView(true)
	end)
	slot0:AddBtnListenerScale(slot0.hadPlacebtn_, nil, function ()
		if DormFurnitureTools:GetFurEditFlag().hadPlaceFlag then
			slot0.hadPlaceFlag = false
		else
			slot0.hadPlaceFlag = true
		end

		uv0.selIndex = nil

		uv0:RefreshView(true)
	end)
	slot0:AddBtnListenerScale(slot0.otherHadPlacebtn_, nil, function ()
		if DormFurnitureTools:GetFurEditFlag().otherHadPlaceFlag then
			slot0.otherHadPlaceFlag = false
		else
			slot0.otherHadPlaceFlag = true
		end

		uv0.selIndex = nil

		uv0:RefreshView(true)
	end)

	slot4 = nil

	slot0:AddBtnListenerScale(slot0.notPresentedbtn_, slot4, function ()
		if DormFurnitureTools:GetFurEditFlag().notPresentedFlag then
			slot0.notPresentedFlag = false
		else
			slot0.notPresentedFlag = true
		end

		uv0.selIndex = nil

		uv0:RefreshView(true)
	end)

	for slot4 = 1, 2 do
		slot0:AddToggleListener(slot0["suitBtn" .. slot4], function (slot0)
			if slot0 then
				uv0:SelectEditSuitSetType(uv1)
			end
		end)
	end

	for slot4 = 1, 2 do
		slot0:AddToggleListener(slot0["stateBtn" .. slot4], function (slot0)
			if slot0 then
				uv0:OnSuitSetType(uv1)
			end
		end)
	end
end

function slot0.BackToDormHomeView(slot0)
	DormLuaBridge.ChangeCameraMode(0, true)
	gameContext:Go("/dorm")

	slot0.selIndex = nil
	slot0.suitTypeIndex = nil

	DormLuaBridge.SetIsCanEditTag(false)
	DormHeroTools:GenerateHeroWhenEnterScene()
	DormFurEditStateData:ExitEditState()
	DormFurnitureTools:SetEditFurFlag(nil)
	slot0:ClickCurSuitListRedPoint()
end

function slot0.SaveFurEditList(slot0)
	slot1, slot2, slot3 = DormFurEditStateData:GetHadPlaceFurInfoList()

	DormAction:SetFurListInMap(slot0.roomID, nil, {
		furInfoList = slot1,
		specialInfo = slot2,
		suitInfo = slot3
	})
	slot0:BackToDormHomeView()
end

function slot0.SelectEditSuitSetType(slot0, slot1)
	slot0:ClickCurSuitListRedPoint()

	slot0["suitBtn" .. slot1].isOn = true
	slot0.suitTypeIndex = slot1
	slot0.dataList_ = {}

	for slot6, slot7 in ipairs(DormSuitData:GetCanUseFurSuitIDList(slot0.roomID, slot1)) do
		table.insert(slot0.dataList_, {
			type = DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace,
			furID = slot7
		})
	end

	slot0.scrollHelper_:StartScroll(#slot0.dataList_)

	if slot0.selIndex then
		slot0.scrollHelper_:ScrollToIndex(slot0.selIndex, false, false)
	end
end

function slot0.ClickCurSuitListRedPoint(slot0)
	if slot0.selectIndex_ == DormConst.DORM_SUIT_TYPE and slot0.dataList_ then
		for slot4, slot5 in ipairs(slot0.dataList_) do
			DormRedPointTools:ClickSuitIconRedPoint(slot5.furID)
		end
	end
end

function slot0.RefreshFurEditTypeController(slot0)
	if DormFurnitureTools:GetFurEditFlag().otherHadPlaceFlag then
		slot0.otherHadPlaceController:SetSelectedState("on")
	else
		slot0.otherHadPlaceController:SetSelectedState("off")
	end

	if slot1.hadPlaceFlag then
		slot0.hadPlaceController:SetSelectedState("on")
	else
		slot0.hadPlaceController:SetSelectedState("off")
	end

	if slot1.canPlaceFlag then
		slot0.canPlaceController:SetSelectedState("on")
	else
		slot0.canPlaceController:SetSelectedState("off")
	end

	if slot1.notPresentedFlag then
		slot0.notPresentedController:SetSelectedState("on")
	else
		slot0.notPresentedController:SetSelectedState("off")
	end
end

function slot0.CheckFurNum(slot0)
	slot1 = nil

	if (BackHomeCfg[slot0.roomID].type ~= DormConst.BACKHOME_TYPE.PublicDorm or GameSetting.dorm_lobby_furniture_limited.value[1]) and BackHomeCfg[slot0.roomID].load_max[DormitoryData:GetDormLevel(slot0.roomID)] then
		if slot1 <= DormFurnitureTools:GetHasPlaceFurNumInfoInMap(slot0.roomID) + DormFurEditStateData:GetCacheFurTotalNum() + DormConst.DORM_SPECIAL_FURNITURE_NUM then
			return false
		else
			return true
		end
	end
end

function slot0.RefreshDevInfo(slot0)
	if DormData:GetDevModelFlag() then
		slot0.devController:SetSelectedState("edit")
		slot0:OnSuitSetType(DormSuitData:GetSuitType())
	else
		slot0.devController:SetSelectedState("player")
	end
end

function slot0.OnSuitSetType(slot0, slot1)
	slot0["stateBtn" .. slot1].isOn = true

	DormSuitData:SetSuitType(slot1)
end

function slot0.Dispose(slot0)
	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Dispose()
	end

	slot0.uilistSrex_.ExitScrollArea:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
