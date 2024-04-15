slot0 = class("IlluIllustration", ReduxView)
slot1 = {
	ACTIVITY_STORY = 3,
	BIRTHDAY = 4,
	MAIN_STORY = 1,
	HEART = 2
}

function slot0.UIName(slot0)
	return "Widget/System/IllustratedHandbook/IlluIllustrationUI"
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

	slot0.loadingSet_ = {}

	for slot4, slot5 in ipairs(CollectPictureCfg.get_id_list_by_type) do
		slot0.loadingSet_[slot4] = {}
	end

	slot0.itemScroll_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, IlluIllustrationItem)
	slot0.editorCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "editor")
	slot0.btn1Controller = ControllerUtil.GetController(slot0.btn1trs_, "name")
	slot0.btn2Controller = ControllerUtil.GetController(slot0.btn2trs_, "name")
	slot0.btn3Controller = ControllerUtil.GetController(slot0.btn3trs_, "name")
	slot0.btn4Controller = ControllerUtil.GetController(slot0.btn4trs_, "name")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_1, nil, function ()
		uv0:RefreshUI(1)

		uv0.params_.index = 1
	end)
	slot0:AddBtnListener(slot0.btn_2, nil, function ()
		uv0:RefreshUI(2)

		uv0.params_.index = 2

		uv0.btn1Controller:SetSelectedIndex(1)
		uv0.btn2Controller:SetSelectedIndex(0)
		uv0.btn3Controller:SetSelectedIndex(1)
		uv0.btn4Controller:SetSelectedIndex(1)
	end)
	slot0:AddBtnListener(slot0.btn_3, nil, function ()
		uv0:RefreshUI(3)

		uv0.params_.index = 3

		uv0.btn1Controller:SetSelectedIndex(1)
		uv0.btn2Controller:SetSelectedIndex(1)
		uv0.btn3Controller:SetSelectedIndex(0)
		uv0.btn4Controller:SetSelectedIndex(1)
	end)
	slot0:AddBtnListener(slot0.btn_4, nil, function ()
		uv0:RefreshUI(4)

		uv0.params_.index = 4

		uv0.btn1Controller:SetSelectedIndex(1)
		uv0.btn2Controller:SetSelectedIndex(1)
		uv0.btn3Controller:SetSelectedIndex(1)
		uv0.btn4Controller:SetSelectedIndex(0)
	end)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("CONFIRM_RESET"),
			OkCallback = function ()
				uv0.loadingSet_[uv0.params_.index] = {}

				uv0:RefreshUI(uv0.params_.index)
			end
		})
	end)
	slot0:AddBtnListener(slot0.saveBtn_, nil, function ()
		IllustratedAction.SaveLoadingSet(uv0.loadingSet_)
	end)
	slot0:AddBtnListener(slot0.editorBtn_, nil, function ()
		uv0.isEditor_ = true

		for slot3, slot4 in ipairs(uv0.loadingSet_) do
			uv0.loadingSet_[slot3] = deepClone(IllustratedData:GetLoadingSetByType(slot3))
		end

		uv0:RefreshUI(uv0.params_.index)
	end)
end

function slot0.UpdateData(slot0, slot1)
	slot0.itemList_ = {}

	for slot5, slot6 in ipairs(CollectPictureCfg.get_id_list_by_type[slot1]) do
		if not slot0.isEditor_ and CollectPictureCfg[slot6].group_display_order == 1 or slot0.isEditor_ then
			if CollectPictureCfg[slot6].type ~= 3 then
				table.insert(slot0.itemList_, {
					id = slot6
				})
			elseif IllustratedData:GetIllustrationInfo()[slot6] then
				table.insert(slot0.itemList_, {
					id = slot6
				})
			end
		end
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot0.itemList_) do
		slot10 = 1

		for slot14, slot15 in ipairs(CollectPictureCfg.get_id_list_by_group_id[CollectPictureCfg[slot7.id].group_id]) do
			if IllustratedData:GetIllustrationInfo()[slot15] and slot16.is_receive == 0 then
				slot10 = 0

				break
			end
		end

		slot2[slot8] = slot10
	end

	table.sort(slot0.itemList_, function (slot0, slot1)
		slot2 = CollectPictureCfg[slot0.id].group_id
		slot3 = CollectPictureCfg[slot1.id].group_id
		slot5 = IllustratedData:GetIllustrationInfo()[slot1.id]

		if IllustratedData:GetIllustrationInfo()[slot0.id] and not slot5 then
			return true
		end

		if not slot4 and slot5 then
			return false
		end

		if slot4 and slot5 then
			if uv0.isEditor_ then
				if uv0:IsSelected(slot0.id) ~= uv0:IsSelected(slot1.id) then
					return slot6
				end
			elseif uv1[slot2] and uv1[slot3] and uv1[slot2] ~= uv1[slot3] then
				return uv1[slot2] < uv1[slot3]
			end

			return slot2 < slot3
		else
			return slot2 < slot3
		end
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot3 = slot0.selectType_

	if slot0.isEditor_ then
		slot2:SetSelect(slot0:IsSelected(slot0.itemList_[slot1].id))
	else
		slot2:SetSelect(false)
	end

	slot2:RefreshUI(slot0.itemList_[slot1], slot0.isEditor_)
	slot2:RegisterGiftFunc(handler(slot0, slot0.ReceiveIllustrationReward))
	slot2:RegisterItemFunc(handler(slot0, slot0.ItemClickFun))
end

function slot0.ReceiveIllustrationReward(slot0)
	if #IlluTools.GetIllustrationNotRewardList() == 0 then
		error("发生错误")
	end

	IllustratedAction.ReceiveIllustrationReward(slot1)
end

function slot0.OnReceiveIllustrationReward(slot0, slot1, slot2)
	getReward(mergeReward(slot1.item_list))
	slot0:RefreshUI(slot0.params_.index)
end

function slot0.ItemClickFun(slot0, slot1)
	if slot0.isEditor_ then
		slot2 = CollectPictureCfg[slot1].type

		if slot0:IsSelected(slot1) then
			table.remove(slot0.loadingSet_[slot2], table.indexof(slot0.loadingSet_[slot2], slot1))
			slot0.itemScroll_:Refresh()
			slot0:RefreshEditorText()
		else
			for slot7, slot8 in ipairs(slot0.loadingSet_) do
				slot3 = 0 + #slot0.loadingSet_[slot7]
			end

			if GameSetting.loading_pic_max.value[1] <= slot3 then
				ShowTips("SET_FAILED")
			else
				table.insert(slot0.loadingSet_[slot2], slot1)
				slot0.itemScroll_:Refresh()
				slot0:RefreshEditorText()
				ShowTips("SET_CONFIRMED")
			end
		end
	else
		slot0:Go("/illuIllustrationDetail", {
			ID = slot1
		})
	end
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.editorCon_:SetSelectedState(slot0.isEditor_ and "true" or "false")
	SetActive(slot0.btn3trs_.gameObject, slot0:IsShowToggleByType(uv0.ACTIVITY_STORY))
	SetActive(slot0.btn4trs_.gameObject, slot0:IsShowToggleByType(uv0.BIRTHDAY))
	slot0:UpdateData(slot1)

	if slot2 then
		if slot0.params_.scrollPos_ then
			slot0.itemScroll_:StartScrollByPosition(#slot0.itemList_, slot0.params_.scrollPos_)
		else
			slot0.itemScroll_:StartScroll(#slot0.itemList_)
		end
	else
		slot0.itemScroll_:StartScroll(#slot0.itemList_)
	end

	if slot0.isEditor_ then
		slot0:RefreshEditorText()
	else
		slot0:RefreshText(slot1)
	end

	slot0.btn1Controller:SetSelectedIndex(slot1 == 1 and 0 or 1)
	slot0.btn2Controller:SetSelectedIndex(slot1 == 2 and 0 or 1)
	slot0.btn3Controller:SetSelectedIndex(slot1 == 3 and 0 or 1)
	slot0.btn4Controller:SetSelectedIndex(slot1 == 4 and 0 or 1)
end

function slot0.RefreshEditorText(slot0)
	for slot5, slot6 in ipairs(slot0.loadingSet_) do
		slot1 = 0 + #slot0.loadingSet_[slot5]
	end

	slot0.limitText_.text = slot1 .. "/" .. GameSetting.loading_pic_max.value[1]
end

function slot0.RefreshText(slot0, slot1)
	for slot6, slot7 in ipairs(CollectPictureCfg.get_id_list_by_type[slot1]) do
		if IllustratedData:GetIllustrationInfo()[slot7] then
			slot2 = 0 + 1
		end
	end

	if slot1 == 3 then
		slot0.numText_.text = slot2 .. "/" .. slot2
	else
		slot0.numText_.text = slot2 .. "/" .. #CollectPictureCfg.get_id_list_by_type[slot1]
	end
end

function slot0.IsShowToggleByType(slot0, slot1)
	for slot5, slot6 in ipairs(CollectPictureCfg.get_id_list_by_type[slot1] or {}) do
		if IllustratedData:GetIllustrationInfo()[slot6] then
			return true
		end
	end

	return false
end

function slot0.OnEnter(slot0)
	slot0.isEditor_ = false

	slot0:UpdateBar()

	slot0.params_.index = slot0.params_.index or 1

	slot0:RefreshUI(slot0.params_.index, true)
	manager.redPoint:bindUIandKey(slot0.btn1trs_, RedPointConst.ILLU_ILLUSTRATION1)
	manager.redPoint:bindUIandKey(slot0.btn2trs_, RedPointConst.ILLU_ILLUSTRATION2)
	manager.redPoint:bindUIandKey(slot0.btn3trs_, RedPointConst.ILLU_ILLUSTRATION3)
	manager.redPoint:bindUIandKey(slot0.btn4trs_, RedPointConst.ILLU_ILLUSTRATION4)
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		if uv0.isEditor_ and uv0:IsChanged() then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("TIP_SETTING_CHANGE"),
				OkCallback = function ()
					IllustratedAction.SaveLoadingSet(uv0.loadingSet_)
				end,
				CancelCallback = function ()
					uv0.isEditor_ = false

					uv0:RefreshUI(uv0.params_.index)
				end
			})
		else
			uv0:Back()
		end
	end)
	manager.windowBar:RegistHomeCallBack(function ()
		if uv0.isEditor_ and uv0:IsChanged() then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("TIP_SETTING_CHANGE"),
				OkCallback = function ()
					IllustratedAction.SaveLoadingSet(uv0.loadingSet_)
					uv0:Go("/home")
				end,
				CancelCallback = function ()
					uv0:Go("/home")
				end
			})
		else
			uv0:Go("/home")
		end
	end)
end

function slot0.IsSelected(slot0, slot1)
	if not slot1 then
		return false
	end

	return table.indexof(slot0.loadingSet_[CollectPictureCfg[slot1].type], slot1) ~= false
end

function slot0.IsChanged(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.loadingSet_) do
		table.insertto(slot1, slot0.loadingSet_[slot5])
	end

	if #slot1 ~= #IllustratedData:GetAllLoadingSet() then
		return true
	end

	for slot6, slot7 in ipairs(slot1) do
		if not table.indexof(slot2, slot7) then
			return true
		end
	end

	return false
end

function slot0.OnSaveLoadingSet(slot0)
	slot0.isEditor_ = false

	slot0:RefreshUI(slot0.params_.index)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(slot0.btn1trs_, RedPointConst.ILLU_ILLUSTRATION1)
	manager.redPoint:unbindUIandKey(slot0.btn2trs_, RedPointConst.ILLU_ILLUSTRATION2)
	manager.redPoint:unbindUIandKey(slot0.btn3trs_, RedPointConst.ILLU_ILLUSTRATION3)
	manager.redPoint:unbindUIandKey(slot0.btn4trs_, RedPointConst.ILLU_ILLUSTRATION4)

	slot0.params_.scrollPos_ = slot0.itemScroll_:GetScrolledPosition()
end

function slot0.Dispose(slot0)
	slot0.itemScroll_:Dispose()

	slot0.itemScroll_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
