slot0 = class("WeaponServantDecomposeView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Bag/SplitServantUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.rewardIndex_ = 0
	slot0.rewardItems_ = {}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.servantDetailView_ = WeaponServantMainDetailModule.New(slot0.servantDetailGo_)

	slot0.servantDetailView_:SwitchBtnStyle(4)

	slot0.servantItemList_ = LuaList.New(handler(slot0, slot0.indexServantItem), slot0.uiListGo_, CommonItemView)
	slot0.returnItemList_ = LuaList.New(handler(slot0, slot0.indexRewardItem), slot0.returnItemListGo_, CommonItemView)
	slot0.previewController_ = slot0.controllerEx_:GetController("preview")
	slot0.emptyController_ = slot0.controllerEx_:GetController("empty")
	slot0.btnController_ = slot0.controllerEx_:GetController("btnState")
	slot0.orderController_ = slot0.orderCon_:GetController("sort")
	slot4 = "color"
	slot0.filterController_ = slot0.filterCon_:GetController(slot4)
	slot0.starToggle_ = {}

	for slot4 = 3, 4 do
		slot0.starToggle_[slot4] = slot0["toggle_" .. slot4]
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnShowFilter_, nil, function ()
		JumpTools.OpenPageByJump("commonFilterView", {
			filterGroup = Filter_Root_Define.Decompose_Servant_Filter_List
		})
	end)
	slot0:AddToggleListener(slot0.dropDown_, function (slot0)
		uv0.priority_ = slot0 == 0 and 1 or 0

		uv0:RefreshData()
	end)

	slot4 = slot0.btnOrder_

	slot0:AddBtnListener(slot4, nil, function ()
		slot0 = uv0.order_ == 0
		uv0.order_ = slot0 and 1 or 0

		uv0.orderController_:SetSelectedState(slot0 and "up" or "down")
		uv0:RefreshData()
	end)

	for slot4 = 3, 4 do
		slot0:AddToggleListener(slot0.starToggle_[slot4], function (slot0)
			uv0:QuickSelectServant(uv1, slot0)
		end)
	end

	slot0:AddBtnListener(slot0.btnShowPreview_, nil, function ()
		uv0:RefreshRewardItem()
		uv0.previewController_:SetSelectedState("show")
	end)
	slot0:AddBtnListener(slot0.btnPreviewMask_, nil, function ()
		uv0.previewController_:SetSelectedState("hide")
	end)
	slot0:AddBtnListener(slot0.btnConfirm_, nil, function ()
		if uv0.currentSelectNum_ > 0 then
			uv0:RefreshRewardItem()
			JumpTools.OpenPageByJump("decomposeConfirmPop", {
				type = "servant",
				itemList = uv0.usedServantList_,
				returnList = uv0.rewardList_
			})
		end
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})

	slot0.refreshSelectIndex_ = 1
	slot0.usedServantList_ = {}
	slot0.currentSelectNum_ = 0
	slot0.priority_ = 1
	slot0.order_ = 1

	slot0:Render()
	slot0:RenderFilterBtn()
	slot0.filterController_:SetSelectedState("normal")
	slot0.previewController_:SetSelectedState("hide")
	slot0:RegistEventListener(COMMON_FILTER_OK, handler(slot0, slot0.OnFilterChange))
end

function slot0.Render(slot0)
	slot0:RefreshData()
end

function slot0.RefreshData(slot0)
	slot0.itemList_ = ServantTools:GetServantList(nil, ServantTools.GetWeaponShowData(Filter_Root_Define.Decompose_Servant_Filter_List.filter_id, {
		hideEquip = true,
		hideStar = {
			5
		}
	}), nil, slot0.priority_, slot0.order_)
	slot0.totalNum_ = #slot0.itemList_
	slot0.selectNum_.text = string.format("%s/%s", slot0.currentSelectNum_, slot0.totalNum_)

	slot0.servantItemList_:StartScroll(#slot0.itemList_)
	slot0.emptyController_:SetSelectedState(#slot0.itemList_ > 0 and "show" or "hide")
end

function slot0.RefreshRightInfo(slot0, slot1, slot2)
	slot3 = slot2

	if slot0.selectedItem_ then
		slot0.selectedItem_:RefreshSelectState2(false)
	end

	slot1:RefreshSelectState2(true)

	slot0.selectedItem_ = slot1

	slot0.servantDetailView_:OnRenderServant(slot3)
	SetActive(slot0.servantDetailView_.lockBtn_.gameObject, false)
end

function slot0.RefreshRewardItem(slot0)
	if next(slot0.usedServantList_) ~= nil then
		slot0.rewardList_ = ServantTools.GetServantDecomposeRewardItem(slot0.usedServantList_)
	else
		slot0.rewardList_ = {}
	end

	slot0.returnItemList_:StartScroll(#slot0.rewardList_)
end

function slot0.indexServantItem(slot0, slot1, slot2)
	slot3 = clone(ItemTemplateData)
	slot4 = slot0.itemList_[slot1]
	slot3.id = slot4.id
	slot3.uid = slot4.uid
	slot3.addLevel = WeaponServantData:GetServantDataByUID(slot4.uid).stage

	function slot3.clickFun(slot0)
		uv0:RefreshRightInfo(uv1, uv2)

		if uv0.usedServantList_[slot0.uid] then
			uv1:RefreshSelectState(false)

			uv0.usedServantList_[slot1] = nil
			uv0.currentSelectNum_ = uv0.currentSelectNum_ - 1

			uv0:CheckToggleState(uv2)
		else
			uv1:RefreshSelectState(true)

			uv0.usedServantList_[slot1] = uv2
			uv0.currentSelectNum_ = uv0.currentSelectNum_ + 1
		end

		uv0.btnController_:SetSelectedState(uv0.currentSelectNum_ > 0 and "split" or "grey")

		uv0.selectNum_.text = string.format("%s/%s", uv0.currentSelectNum_, uv0.totalNum_)
	end

	slot2:SetData(slot3)
	slot2:RefreshSelectState(slot0.usedServantList_[slot4.uid] ~= nil)

	if slot0.refreshSelectIndex_ == slot1 then
		slot0:RefreshRightInfo(slot2, slot4)
	end
end

function slot0.indexRewardItem(slot0, slot1, slot2)
	slot3 = clone(ItemTemplateData)
	slot4 = slot0.rewardList_[slot1]
	slot3.id = slot4.id
	slot3.number = slot4.number

	slot2:SetData(slot3)
end

function slot0.CheckToggleState(slot0, slot1)
	slot2 = ItemCfg[slot1.id].display_rare

	if not slot0.usedServantList_[slot1.uid] and slot0.starToggle_[slot2].isOn then
		slot0.unSelectItem_ = slot1
		slot0.starToggle_[slot2].isOn = false
	end
end

function slot0.QuickSelectServant(slot0, slot1, slot2)
	if slot2 then
		for slot6, slot7 in ipairs(slot0.itemList_) do
			if WeaponServantCfg[slot7.id].starlevel == slot1 and slot7.stage == 1 then
				if slot0.usedServantList_[slot7.uid] == nil then
					slot0.currentSelectNum_ = slot0.currentSelectNum_ + 1
				end

				slot0.usedServantList_[slot7.uid] = slot7
			end
		end
	elseif slot0.unSelectItem_ then
		slot0.usedServantList_[slot0.unSelectItem_.uid] = nil
		slot0.unSelectItem_ = nil
	else
		for slot6, slot7 in pairs(slot0.usedServantList_) do
			if WeaponServantCfg[slot7.id].starlevel == slot1 then
				slot0.usedServantList_[slot6] = nil
				slot0.currentSelectNum_ = slot0.currentSelectNum_ - 1
			end
		end
	end

	slot0:RefreshSelect()
end

function slot0.RefreshSelect(slot0)
	slot3 = slot0.servantItemList_
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		slot5:RefreshSelectState(slot0.usedServantList_[slot5:GetData().uid] ~= nil)
	end

	slot0.selectNum_.text = string.format("%s/%s", slot0.currentSelectNum_, slot0.totalNum_)

	slot0.btnController_:SetSelectedState(slot0.currentSelectNum_ > 0 and "split" or "grey")
end

function slot0.OnServantDecomposeResult(slot0, slot1, slot2)
	getReward2(mergeReward2(slot1.return_list))

	slot0.refreshSelectIndex_ = 1

	slot0:ClearSelect()
	slot0:Render()
end

function slot0.ClearSelect(slot0)
	slot0.usedServantList_ = {}
	slot0.currentSelectNum_ = 0
	slot4 = "grey"

	slot0.btnController_:SetSelectedState(slot4)

	for slot4, slot5 in pairs(slot0.starToggle_) do
		slot5.isOn = false
	end
end

function slot0.OnFilterChange(slot0)
	slot0:ClearSelect()
	slot0:Render()
	slot0:RenderFilterBtn()
end

function slot0.RenderFilterBtn(slot0)
	if CommonFilterData:AtLeastOneChoose(Filter_Root_Define.Decompose_Servant_Filter_List.filter_id) then
		slot0.filterController_:SetSelectedState("orange")
	else
		slot0.filterController_:SetSelectedState("normal")
	end
end

function slot0.OnExit(slot0)
	slot4 = Filter_Root_Define.Decompose_Servant_Filter_List.filter_id

	CommonFilterData:ClearFilter(slot4)

	for slot4, slot5 in pairs(slot0.starToggle_) do
		slot5.isOn = false
	end

	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.servantItemList_:Dispose()
	slot0.returnItemList_:Dispose()
	slot0.servantDetailView_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
