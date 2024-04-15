slot0 = class("DormSuitGetFurListView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dorm/DormFurnitureGetPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
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
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.OnEnter(slot0)
	slot0.canStorageList = slot0.params_.furEidList or nil

	slot0:RefreshView()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.confirmBtn, nil, function ()
		if uv0.canStorageList then
			for slot3, slot4 in pairs(uv0.canStorageList) do
				for slot8 = 0, slot4.Length - 1 do
					DormFurnitureManager.GetInstance().FindAndRemove(slot4[slot8])
					DormFurEditStateData:ReviseFurNumInEditRoom(slot3, -1)
				end
			end
		end

		if uv0.params_.callBack then
			uv0.params_.callBack()
		end

		uv0.params_.furEidList = nil
		uv0.canStorageList = nil

		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.cancelBtn, nil, function ()
		uv0.params_.furEidList = nil
		uv0.canStorageList = nil

		JumpTools.Back()
	end)
end

function slot0.RefreshView(slot0)
	if slot0.canStorageList then
		slot0.stateController:SetSelectedState("have")
		slot0:RefreshFurInfoList()
	else
		slot0.stateController:SetSelectedState("no")
	end
end

function slot0.RefreshFurInfoList(slot0)
	if slot0.canStorageList then
		slot0.furInfoList = {}

		for slot4, slot5 in pairs(slot0.canStorageList) do
			table.insert(slot0.furInfoList, {
				furID = slot4,
				canStorageNum = slot5.Length
			})
		end

		slot0.scrollHelper_:StartScroll(#slot0.furInfoList)
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.furInfoList[slot1], nil, DormEnum.FurItemType.StorageFurShow, nil, slot1)
end

function slot0.Dispose(slot0)
	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
