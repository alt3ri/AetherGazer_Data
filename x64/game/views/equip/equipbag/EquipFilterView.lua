slot0 = class("EquipFilterView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Com_dynamic/FilterPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.suitScrollHelper_ = LuaList.New(handler(slot0, slot0.indexSuitItem), slot0.suitListGo_, EquipBagSuitItem)
	slot0.skillScrollHelper_ = LuaList.New(handler(slot0, slot0.indexSkillItem), slot0.skillListGo_, SkillSelectItem)
	slot0.filterBottomView_ = CommonFilterBottom.New(slot0.fillListGo_)

	slot0.filterBottomView_:RegisteClearBtnListener(handler(slot0, slot0.ClearFilter))
	slot0.filterBottomView_:RegisteItemClickListener(handler(slot0, slot0.OnFilterItemClick))

	slot0.tabController_ = slot0.filterController_:GetController("tab")
	slot0.selectController_ = slot0.filterController_:GetController("select")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnConfirm_, nil, function ()
		uv0:OnClose(true)
	end)
	slot0:AddBtnListener(slot0.btnSuit_, nil, function ()
		uv0:ClearFilter()
		uv0.tabController_:SetSelectedState("suit")

		uv0.filterIndex_ = 1
		uv0.filterList_ = uv0.filterGroup[uv0.filterIndex_]
	end)
	slot0:AddBtnListener(slot0.btnSkill_, nil, function ()
		uv0:ClearFilter()
		uv0.tabController_:SetSelectedState("skill")

		uv0.filterIndex_ = 2
		uv0.filterList_ = uv0.filterGroup[uv0.filterIndex_]
	end)
	slot0:AddBtnListener(slot0.btnMask_, nil, function ()
		uv0:OnClose(false)
	end)
	slot0:AddBtnListener(slot0.brnCloseSelected_, nil, function ()
		uv0:ClearFilter()
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:HideBar()

	slot0.info_ = clone(slot0.params_.info) or {}
	slot0.info_.heroId = slot0.info_ and slot0.info_.heroId or 0
	slot0.info_.suitPos = slot0.info_ and slot0.info_.suitPos or 0
	slot0.lastInfo_ = clone(slot0.info_)
	slot0.lastInfo_.filterIndex = slot0.info_.filterIndex or 1
	slot0.closeFunc = slot0.params_.closeFunc
	slot0.filterGroup = slot0.info_.filterGroup or {
		{},
		{}
	}
	slot0.selectedItem = slot0.info_.selectedItem or {}
	slot0.filterIndex_ = slot0.info_.filterIndex or 1
	slot0.filterList_ = slot0.filterGroup[slot0.filterIndex_]
	slot0.isFilterEquiped_ = slot0.params_.isFilterEquiped

	slot0:InitSuitList()
	slot0:InitSkillList()
	slot0:RefreshBottom()
	slot0.tabController_:SetSelectedState(slot0.filterIndex_ == 1 and "suit" or "skill")
end

function slot0.InitSuitList(slot0)
	slot1 = {}
	slot0.suitList_, slot1 = EquipTools.GetHaveSuitList(true)

	if #(EquipRecommendCfg[slot0.info_.heroId] and EquipRecommendCfg[slot0.info_.heroId].suit_list or {}) > 0 then
		table.sort(slot0.suitList_, function (slot0, slot1)
			if uv1[slot0] ~= uv1[slot1] then
				if not not table.indexof(uv0, slot0) == not not table.indexof(uv0, slot1) then
					return not uv1[slot1]
				else
					return not slot3
				end
			elseif slot2 == slot3 then
				return slot0 < slot1
			else
				return not slot3
			end
		end)
	end

	slot0.suitScrollHelper_:StartScroll(#slot0.suitList_)
end

function slot0.InitSkillList(slot0)
	slot0.skillList_ = EquipTools.GetHaveSkillList(true)

	slot0.skillScrollHelper_:StartScroll(#slot0.skillList_)
end

function slot0.indexSuitItem(slot0, slot1, slot2)
	slot3 = slot0.suitList_[slot1]

	slot2:RefreshData(slot0.info_.heroId, slot3)
	slot2:RefreshPos(slot0.info_.suitPos, slot0.isFilterEquiped_)

	if slot0.selectedItem[slot3] ~= nil and slot0.filterIndex_ == 1 then
		slot0.selectedItem[slot3] = slot2
	end

	slot2:SetSelect(slot4)
	slot2:RegistCallBack(function (slot0)
		uv0:FilterItemCb(uv1, slot0)
	end)
end

function slot0.indexSkillItem(slot0, slot1, slot2)
	slot3 = slot0.skillList_[slot1]

	slot2:RefreshData(slot0, {
		id = slot3
	})
	slot2:RefreshPos(slot0.info_.suitPos, slot0.isFilterEquiped_)

	if slot0.selectedItem[slot3] ~= nil and slot0.filterIndex_ == 2 then
		slot0.selectedItem[slot3] = slot2
	end

	slot2:SetSelect(slot4)
	slot2:RegistCallBack(function (slot0)
		uv0:FilterItemCb(uv1, slot0)
	end)
end

function slot0.OnFilterItemClick(slot0, slot1)
	slot0:FilterItemCb(nil, slot1.id)
end

function slot0.FilterItemCb(slot0, slot1, slot2)
	if slot0.selectedItem[slot2] ~= nil then
		table.remove(slot0.filterList_, table.indexof(slot0.filterList_, slot2))
		slot0.selectedItem[slot2]:SetSelect(false)

		slot0.selectedItem[slot2] = nil
	else
		table.insert(slot0.filterList_, slot2)

		slot0.selectedItem[slot2] = slot1

		slot0.selectedItem[slot2]:SetSelect(true)
	end

	slot0:RefreshBottom()
end

function slot0.RefreshBottom(slot0)
	slot1 = #slot0.filterList_ ~= 0

	slot0.selectController_:SetSelectedState(slot1 and "select" or "noselect")

	slot2 = {}

	if slot1 then
		for slot6, slot7 in ipairs(slot0.filterList_) do
			table.insert(slot2, {
				name = GetI18NText(slot0.filterIndex_ == 1 and EquipSuitCfg[slot7].name or EquipSkillCfg[slot7].name),
				id = slot7
			})
		end

		slot0.filterBottomView_:Refresh(slot2)
	end
end

function slot0.OnClose(slot0, slot1)
	slot0:ShowDefaultBar()

	if slot1 then
		slot0:RefrehBagView()
	end

	if slot0.closeFunc then
		slot0.closeFunc()
	end

	slot0:Back()
end

function slot0.ClearFilter(slot0)
	slot4 = "noselect"

	slot0.selectController_:SetSelectedState(slot4)

	for slot4, slot5 in pairs(slot0.selectedItem) do
		slot5:SetSelect(false)
	end

	slot0.filterGroup = {
		{},
		{}
	}
	slot0.filterList_ = slot0.filterGroup[slot0.filterIndex_]
	slot0.selectedItem = {}
end

function slot0.RefrehBagView(slot0)
	if slot0:CheckFilterChange() then
		manager.notify:Invoke(EQUIP_FILTER_CONFIRM, {
			filterGroup = slot0.filterGroup,
			filterIndex = slot0.filterIndex_,
			selectedItem = slot0.selectedItem
		})
	end
end

function slot0.CheckFilterChange(slot0)
	slot1 = slot0.filterGroup[1]
	slot2 = slot0.filterGroup[2]
	slot3 = slot0.lastInfo_.filterGroup and slot0.lastInfo_.filterGroup[1] or {}
	slot4 = slot0.lastInfo_.filterGroup and slot0.lastInfo_.filterGroup[2] or {}

	if slot0.lastInfo_.filterIndex ~= slot0.filterIndex_ then
		return true
	end

	if #slot3 ~= #slot1 or #slot4 ~= #slot2 then
		return true
	end

	if #slot3 ~= 0 and #slot1 ~= 0 or #slot4 ~= 0 and #slot2 ~= 0 then
		slot5 = {
			{},
			{}
		}

		for slot9 = 1, 2 do
			for slot14, slot15 in ipairs(slot9 == 1 and slot3 or slot4) do
				slot5[slot9][slot15] = true
			end
		end

		for slot9 = 1, 2 do
			for slot14, slot15 in ipairs(slot9 == 1 and slot1 or slot2) do
				if not slot5[slot9][slot15] then
					return true
				end
			end
		end
	end

	return false
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.suitScrollHelper_:Dispose()
	slot0.skillScrollHelper_:Dispose()
	slot0.filterBottomView_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
