slot0 = class("EquipDecomposeView", ReduxView)
slot1 = import("game.tools.HeroTools")
slot2 = import("game.tools.EquipTools")

function slot0.UIName(slot0)
	return "Widget/System/Bag/SplitEquipUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.equipItemList_ = LuaList.New(handler(slot0, slot0.indexEquipItem), slot0.uiListGo_, CommonItemView)
	slot0.rewardItemList_ = LuaList.New(handler(slot0, slot0.indexRewardItem), slot0.rewardListGo_, CommonItemView)
	slot0.equipSkillView_ = EquipNewSkillInfoView.New(slot0.skillPopGo_)
	slot0.equipInfo_ = EquipInfoView.New(slot0.equipInfoGo_)
	slot4 = handler

	slot0.equipInfo_:RegisterSkillClick(slot4(slot0, slot0.SkillClick))

	slot0.equipPosBtn_ = {}

	for slot4 = 0, 6 do
		slot0.equipPosBtn_[slot4] = slot0["equipPosBtn_" .. slot4]
	end

	slot0.starToggle_ = {}

	for slot4 = 2, 5 do
		slot0.starToggle_[slot4] = slot0["toggle_" .. slot4]
	end

	slot0.popController_ = slot0.controllerEx_:GetController("pop")
	slot0.infoController_ = slot0.controllerEx_:GetController("info")
	slot0.btnController_ = slot0.controllerEx_:GetController("btnState")
	slot0.posController_ = slot0.posCon_:GetController("pos")
	slot0.orderController_ = slot0.orderCon_:GetController("sort")
	slot0.filterController_ = slot0.filterCon_:GetController("color")
end

function slot0.AddUIListener(slot0)
	for slot4 = 0, 6 do
		slot0:AddBtnListener(slot0.equipPosBtn_[slot4], nil, function ()
			if uv0.pos == uv1 then
				return
			end

			uv0:ChangePos(uv1)
		end)
	end

	slot0:AddBtnListener(slot0.btnShowFliter_, nil, function ()
		JumpTools.OpenPageByJump("equipFilterView", {
			isFilterEquiped = true,
			info = uv0.filterInfo_
		})
	end)
	slot0:AddToggleListener(slot0.dropDown_, function (slot0)
		uv0.priority_ = slot0 == 0 and EquipConst.EQUIP_SORT.RARE or EquipConst.EQUIP_SORT.LEVEL

		uv0:RefreshData()
	end)

	slot4 = slot0.btnOrder_

	slot0:AddBtnListener(slot4, nil, function ()
		slot0 = uv0.order_ == ItemConst.SORT_TYPE.DOWN
		uv0.order_ = slot0 and ItemConst.SORT_TYPE.UP or ItemConst.SORT_TYPE.DOWN

		uv0.orderController_:SetSelectedState(slot0 and "down" or "up")
		uv0:RefreshData()
	end)

	for slot4 = 2, 5 do
		slot0:AddToggleListener(slot0.starToggle_[slot4], function (slot0)
			uv0:QuickSelectEquip(uv1, slot0)
		end)
	end

	slot0:AddBtnListener(slot0.btnPreview_, nil, function ()
		if uv0.popController_:GetSelectedState() == "preview" then
			uv0.popController_:SetSelectedState("hide")
		else
			uv0:RefreshRewardItem()
			uv0.popController_:SetSelectedState("preview")
		end
	end)
	slot0:AddBtnListener(slot0.btnMask_, nil, function ()
		if uv0.popController_:GetSelectedState() == "skill" and uv0.selectSkillItem_ then
			uv0.selectSkillItem_:ShowSelect(false)
		end

		uv0.popController_:SetSelectedState("hide")
	end)
	slot0:AddBtnListenerScale(slot0.btnConfirm_, nil, function ()
		if uv0.currentSelectNum_ > 0 then
			uv0:RefreshRewardItem()
			JumpTools.OpenPageByJump("decomposeConfirmPop", {
				type = "equip",
				itemList = uv0.usedEquipList_,
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

	slot0.filterInfo_ = {}
	slot0.refreshSelectIndex_ = 1
	slot0.usedEquipList_ = {}
	slot0.currentSelectNum_ = 0
	slot0.pos = 0
	slot0.suit = 0
	slot0.skill = 0

	slot0:RefreshData()

	slot0.selectNum_.text = string.format("%s/%s", slot0.currentSelectNum_, slot0.totalNum_)

	slot0.filterController_:SetSelectedState("normal")
	slot0.popController_:SetSelectedState("hide")

	slot5 = handler

	slot0:RegistEventListener(EQUIP_FILTER_CONFIRM, slot5(slot0, slot0.OnEquipFilterConfirm))

	slot4 = 0

	slot0.posController_:SetSelectedState(slot4)

	for slot4, slot5 in pairs(slot0.starToggle_) do
		slot5.isOn = false
	end
end

function slot0.RefreshData(slot0)
	slot0.order_ = slot0.order_ or ItemConst.SORT_TYPE.DOWN
	slot0.priority_ = slot0.priority_ or EquipConst.EQUIP_SORT.RARE
	slot0.itemList_ = slot0:GetItemList(slot0.order_, slot0.priority_, slot0.pos, slot0.filterInfo_.suit, slot0.filterInfo_.skill)
	slot0.totalNum_ = #slot0.itemList_

	slot0.equipItemList_:StartScroll(#slot0.itemList_)
	slot0.infoController_:SetSelectedState(#slot0.itemList_ > 0 and "show" or "hide")
	slot0:CheckToggleState(slot0.itemList_)
end

function slot0.GetItemList(slot0, slot1, slot2, slot3, slot4, slot5)
	slot13 = slot5
	slot8 = ProposalData:GetEquipMap()
	slot9 = {}

	for slot13 = #EquipData:GetEquipListComplex(slot1, slot2, slot3, slot4, slot13), 1, -1 do
		if not uv0.GetEquipMap(HeroData:GetHeroList())[slot6[slot13].equip_id] and not slot14.is_lock then
			table.insert(slot9, slot14)
		end
	end

	return slot9
end

function slot0.RefreshRightInfo(slot0, slot1, slot2)
	slot3 = slot2

	if slot0.selectedItem_ then
		slot0.selectedItem_:RefreshSelectState2(false)
	end

	slot1:RefreshSelectState2(true)

	slot0.selectedItem_ = slot1

	slot0.equipInfo_:RefreshData(slot0, slot3, nil, 0, slot3.equip_id)
end

function slot0.RefreshRewardItem(slot0)
	if next(slot0.usedEquipList_) ~= nil then
		slot0.rewardList_ = uv0.GetDecomposeRewardItem(slot0.usedEquipList_)
	else
		slot0.rewardList_ = {}
	end

	slot0.rewardItemList_:StartScroll(#slot0.rewardList_)
end

function slot0.indexEquipItem(slot0, slot1, slot2)
	slot3 = clone(ItemTemplateData)
	slot4 = slot0.itemList_[slot1]
	slot3.id = slot4.prefab_id
	slot3.equip_id = slot4.equip_id
	slot3.equipLevel = uv0.CountEquipLevel(slot4)

	if slot4.race == 0 or table.keyof(RaceEffectCfg.all, slot5) ~= nil then
		slot3.race = slot5 or 0
		slot3.bindHeroID = 0
	else
		slot3.race = HeroCfg[slot5].race or 0
		slot3.bindHeroID = slot6
	end

	function slot3.clickFun(slot0)
		uv0:RefreshRightInfo(uv1, uv2)

		if uv0.usedEquipList_[slot0.equip_id] then
			uv1:RefreshSelectState(false)

			uv0.usedEquipList_[slot1] = nil
			uv0.currentSelectNum_ = uv0.currentSelectNum_ - 1

			uv0:CheckToggleState({
				uv2
			})
		else
			uv1:RefreshSelectState(true)

			uv0.usedEquipList_[slot1] = uv2
			uv0.currentSelectNum_ = uv0.currentSelectNum_ + 1
		end

		uv0.btnController_:SetSelectedState(uv0.currentSelectNum_ > 0 and "split" or "grey")

		uv0.selectNum_.text = string.format("%s/%s", uv0.currentSelectNum_, uv0.totalNum_)
	end

	slot2:SetData(slot3)
	slot2:RefreshSelectState(slot0.usedEquipList_[slot4.equip_id] ~= nil)

	if slot0.refreshSelectIndex_ == slot1 then
		slot0:RefreshRightInfo(slot2, slot4)
	end
end

function slot0.indexRewardItem(slot0, slot1, slot2)
	slot3 = clone(ItemTemplateData)
	slot4 = slot0.rewardList_[slot1]
	slot3.id = slot4.id
	slot3.number = slot4.number

	function slot3.clickFun(slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	slot2:SetData(slot3)
end

function slot0.CheckToggleState(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0.starToggle_[slot6.star].isOn and not slot0.usedEquipList_[slot6.equip_id] then
			slot0.notClearSelect_ = true
			slot0.starToggle_[slot6.star].isOn = false
		end
	end
end

function slot0.SkillClick(slot0, slot1, slot2)
	slot0.popController_:SetSelectedState("skill")

	slot0.selectSkillItem_ = slot1

	slot0.equipSkillView_:RefreshData(slot0, slot2)
end

function slot0.QuickSelectEquip(slot0, slot1, slot2)
	if slot2 then
		for slot7, slot8 in ipairs(slot0.itemList_) do
			if slot8.star == slot1 then
				slot3 = nil or slot7

				if slot0.usedEquipList_[slot8.equip_id] == nil then
					slot0.currentSelectNum_ = slot0.currentSelectNum_ + 1
				end

				slot0.usedEquipList_[slot8.equip_id] = slot8
			end
		end

		if slot3 then
			slot0.equipItemList_:ScrollToIndex(slot3, false, true, 0.5)
		end
	elseif slot0.notClearSelect_ then
		slot0.notClearSelect_ = false
	else
		for slot6, slot7 in ipairs(slot0.itemList_) do
			if next(slot0.usedEquipList_) ~= nil and slot0.usedEquipList_[slot7.equip_id] and slot7.star == slot1 then
				slot0.usedEquipList_[slot7.equip_id] = nil
				slot0.currentSelectNum_ = slot0.currentSelectNum_ - 1
			end
		end
	end

	slot0:RefreshSelect()
end

function slot0.ChangePos(slot0, slot1)
	slot0.posController_:SetSelectedState(slot1)

	slot0.pos = slot1
	slot0.filterInfo_.suitPos = slot1

	slot0:RefreshData()
	slot0:ClearSelect()
end

function slot0.OnEquipDecompose(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		slot7 = {
			list = slot0.rewardList_
		}

		slot0:Go("reward", slot7)

		slot0.usedEquipList_ = {}
		slot0.currentSelectNum_ = 0
		slot6 = "grey"

		slot0.btnController_:SetSelectedState(slot6)
		slot0:RefreshData()

		for slot6, slot7 in pairs(slot0.starToggle_) do
			slot7.isOn = false
		end
	else
		ShowTips(slot1.result)
	end
end

function slot0.RefreshSelect(slot0)
	slot3 = slot0.equipItemList_
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		slot5:RefreshSelectState(slot0.usedEquipList_[slot5:GetData().equip_id] ~= nil)
	end

	slot0.selectNum_.text = string.format("%s/%s", slot0.currentSelectNum_, slot0.totalNum_)

	slot0.btnController_:SetSelectedState(slot0.currentSelectNum_ > 0 and "split" or "grey")
end

function slot0.OnEquipFilterConfirm(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		slot0.filterInfo_[slot5] = slot6
	end

	slot0.filterInfo_.suit = slot0.filterInfo_.filterGroup[1]
	slot0.filterInfo_.skill = slot0.filterInfo_.filterGroup[2]

	slot0.filterController_:SetSelectedState((#slot0.filterInfo_.suit > 0 or #slot0.filterInfo_.skill > 0) and "orange" or "normal")
	slot0:RefreshData()
	slot0:ClearSelect()
end

function slot0.ClearSelect(slot0)
	slot0.usedEquipList_ = {}
	slot0.currentSelectNum_ = 0
	slot5 = slot0.currentSelectNum_
	slot0.selectNum_.text = string.format("%s/%s", slot5, slot0.totalNum_)
	slot4 = "grey"

	slot0.btnController_:SetSelectedState(slot4)

	for slot4, slot5 in pairs(slot0.starToggle_) do
		slot5.isOn = false
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.equipItemList_:Dispose()
	slot0.rewardItemList_:Dispose()
	slot0.equipSkillView_:Dispose()
	slot0.equipInfo_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
