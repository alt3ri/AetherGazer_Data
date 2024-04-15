slot0 = class("ChipManagerCultivateView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/MimirChip/MimirChipCultivateUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.isBattle = false
	slot0.tabIndex = 1

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.chipManagerUIList_ = LuaList.New(handler(slot0, slot0.RefreshChipManagerItem), slot0.uiList_, slot0:GetChipManagerItem())
	slot0.chipUIList_ = LuaList.New(handler(slot0, slot0.RefreshChipItem), slot0.chipuilistUilist_, slot0:GetChipItem())
	slot0.chipManagerInfoView_ = slot0:GetChipManagerInfoView().New(slot0.panelGo_, slot0)
	slot0.chipInfoView_ = slot0:GetChipInfoView().New(slot0.panel2Go_, slot0)
	slot0.isbattleControl = slot0.leftControllerexcollection_:GetController("is_BattleSet")
	slot0.leftSelectControl = slot0.contentControllerexcollection_:GetController("select")
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		uv0:Back(1, {
			isSorted = true
		})
	end)

	slot0.handler_ = handler(slot0, slot0.OnUnlockChipManager)

	manager.notify:RegistListener(UNLOCK_CHIP_MANAGER, slot0.handler_)

	slot0.unlockChipHandler_ = handler(slot0, slot0.OnUnlockChip)

	manager.notify:RegistListener(UNLOCK_CHIP, slot0.unlockChipHandler_)

	slot0.chipManagerList_ = slot0:GetChipManagerList()
	slot0.defaultSelectID_ = slot0.params_.chipManagerID or slot0.chipManagerList_[1]
	slot0.chipManagerDataTemplate_ = ChipManagerDataTemplate.New({
		id = slot0.defaultSelectID_,
		unlockChipManagerIDList_ = ChipData:GetUnlockChipManagerIDList(),
		unlockChipIDList_ = ChipData:GetUnlockChipIDList()
	})

	slot0.chipManagerUIList_:StartScroll(#slot0.chipManagerList_, table.keyof(slot0.chipManagerList_, slot0.defaultSelectID_))

	slot0.chipList_ = slot0:GetChipTypeCntList() or {}

	slot0.chipUIList_:StartScroll(#slot0.chipList_)

	slot0.clickItemHandler_ = handler(slot0, slot0.OnClickChipItem)

	manager.notify:RegistListener(ON_CLICK_CHIP_ITEM, slot0.clickItemHandler_)

	slot0.defaultSelectChipID_ = slot0.params_.chipID or slot0.chipList_[1]

	slot0:RefreshUI()
	slot0.chipManagerUIList_:Refresh()
	slot0.chipUIList_:Refresh()
end

function slot0.OnUpdate(slot0)
	slot0.defaultSelectID_ = slot0.params_.chipManagerID or slot0.chipManagerList_[1]

	slot0:RefreshUI()
	slot0.chipManagerUIList_:Refresh()
	slot0.chipUIList_:Refresh()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(UNLOCK_CHIP_MANAGER, slot0.handler_)

	slot0.handler_ = nil

	manager.notify:RemoveListener(ON_CLICK_CHIP_ITEM, slot0.clickItemHandler_)
	manager.notify:RemoveListener(UNLOCK_CHIP, slot0.unlockChipHandler_)

	slot0.clickItemHandler_ = nil

	if slot0.chipManagerInfoView_ then
		slot0.chipManagerInfoView_:OnExit()
	end

	if slot0.chipInfoView_ then
		slot0.chipInfoView_:OnExit()
	end

	manager.redPoint:unbindUIandKey(slot0.notice1_)
	manager.redPoint:unbindUIandKey(slot0.notice2_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.mimirBtn_, nil, function ()
		uv0.leftSelectControl:SetSelectedState("state0")

		uv0.tabIndex = 1

		uv0:UpdateRightView(uv0.tabIndex)
	end)
	slot0:AddBtnListener(slot0.mimirchipBtn_, nil, function ()
		uv0.leftSelectControl:SetSelectedState("state1")

		uv0.tabIndex = 2

		uv0:UpdateRightView(uv0.tabIndex)
	end)
end

function slot0.UpdateRightView(slot0, slot1)
	slot0.curIndex = slot1
	slot5 = ({
		slot0.defaultSelectID_,
		slot0.defaultSelectChipID_
	})[slot0.curIndex]

	if ({
		slot0.chipManagerInfoView_,
		slot0.chipInfoView_
	})[slot0.curIndex] and slot4.Enter then
		slot4:Enter()
	end

	if slot4 and slot4.RefreshData then
		if slot4.SetTemplateData then
			slot4:SetTemplateData(slot0.chipManagerDataTemplate_)
		end

		slot4:RefreshData(slot5)
	end
end

function slot0.OnClickChipItem(slot0, slot1)
	slot0.defaultSelectChipID_ = slot1

	slot0:Go("/chipManager", {
		chipManagerID = slot0.defaultSelectID_,
		chipID = slot1,
		defaultSelectChipID_ = slot0.chipManagerID_
	})
end

function slot0.RefreshUI(slot0)
	slot0:UpdateRightView(slot0.tabIndex)

	slot0.iconImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Managecat_l/" .. ChipCfg[slot0.defaultSelectID_].picture_id)
	slot0.numText1_.text = string.format("%s/%s", #(slot0.chipManagerDataTemplate_.unlockChipManagerIDList_ or {}) or 0, #(slot0.chipManagerList_ or {}) or 0)
	slot0.numText2_.text = string.format("%s/%s", #(slot0.chipManagerDataTemplate_.unlockChipIDList_ or {}), #(slot0.chipList_ or {}))

	manager.redPoint:bindUIandKey(slot0.notice1_, RedPointConst.CHIP_MANAGER_CHIP, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(slot0.notice2_, RedPointConst.CHIP_CHIP, {
		x = 0,
		y = 0
	})
end

function slot0.OnUnlockChipManager(slot0)
	slot0:RefreshUI()
	slot0.chipManagerUIList_:Refresh()
end

function slot0.OnUnlockChip(slot0)
	slot0:RefreshUI()
	slot0.chipUIList_:Refresh()
end

function slot0.RefreshChipManagerItem(slot0, slot1, slot2)
	slot3 = slot0.chipManagerList_[slot1]

	slot2:SetTemplateData(slot0.chipManagerDataTemplate_)
	slot2:SetChipManagerID(slot3)
	slot2:RefreshUI(slot3 == slot0.defaultSelectID_)
end

function slot0.RefreshChipItem(slot0, slot1, slot2)
	slot2:SetTemplateData(slot0.chipManagerDataTemplate_)
	slot2:SetChipID(slot0.chipList_[slot1])
	slot2:RefreshUI(slot0.defaultSelectChipID_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.chipInfoView_ then
		slot0.chipInfoView_:Dispose()

		slot0.chipInfoView_ = nil
	end

	if slot0.chipManagerInfoView_ then
		slot0.chipManagerInfoView_:Dispose()

		slot0.chipManagerInfoView_ = nil
	end

	if slot0.chipManagerUIList_ then
		slot0.chipManagerUIList_:Dispose()

		slot0.chipManagerUIList_ = nil
	end

	if slot0.chipUIList_ then
		slot0.chipUIList_:Dispose()

		slot0.chipUIList_ = nil
	end
end

function slot0.GetChipManagerList(slot0)
	return ChipTools.SortChipManager(ChipData:GetEnabledChipManagerID())
end

function slot0.GetUnlockChipManagerList(slot0)
	return ChipData:GetUnlockChipManagerIDList()
end

function slot0.GetChipTypeCntList(slot0)
	if manager.guide:IsPlaying() then
		table.sort(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_CHIP], function (slot0, slot1)
			return slot0 == 105
		end)
	else
		table.sort(slot1, function (slot0, slot1)
			if uv0.chipManagerDataTemplate_ and (uv0.chipManagerDataTemplate_:GetIsUnlockChip(slot0) and 2 or ChipTools.GetChipCanLocked(slot0) and 1 or 0) ~= (uv0.chipManagerDataTemplate_:GetIsUnlockChip(slot1) and 2 or ChipTools.GetChipCanLocked(slot1) and 1 or 0) then
				return slot5 < slot4
			end

			return slot0 < slot1
		end)
	end

	return slot1
end

function slot0.GetManagerUnlockView(slot0)
	return ChipManagerUnlockView
end

function slot0.GetChipManagerItem(slot0)
	return ChipManagerItem
end

function slot0.GetChipItem(slot0)
	return ChipItem
end

function slot0.GetChipManagerInfoView(slot0)
	return MimirChipManagerInfoView
end

function slot0.GetChipInfoView(slot0)
	return MimirChipInfoView
end

function slot0.RecordStay(slot0, slot1)
	if slot1 == "1" then
		OperationRecorder.RecordStayView("STAY_VIEW_AI_STORY", math.floor((Time.realtimeSinceStartup - slot0.storyTime) * 1000), slot0.defaultSelectID_)
	end

	slot0.storyTime = Time.realtimeSinceStartup
end

return slot0
