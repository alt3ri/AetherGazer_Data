slot0 = class("NewWarChessPopItemView", ReduxView)

function slot0.UIName(slot0)
	return "UI/NewWarChess/NewWarChessActionUIPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
	slot0.allProps = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.NEWWARCHESS_MOVEPOINT_PACKAGE]
	slot0.selectNum_ = 0
	slot0.canUseMaxNum_ = 0
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.btnController_ = ControllerUtil.GetController(slot0.okBtn_.transform, "enabled")
	slot0.scrollHelper = LuaList.New(handler(slot0, slot0.indexItem), slot0.itemListGo_, CommonItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot3 = slot0.propsBonds[slot1]

	slot2:RefreshData({
		id = slot3,
		number = ItemTools.getItemNum(slot3),
		type = ItemCfg[slot3].type
	})
	slot2:SetSelectType("equip")
	slot2:ShowSelect(slot1 == slot0.selectInex and 1 or 0)
	slot2:RegistCallBack(function (slot0)
		if uv0 > 0 then
			uv1.selectInex = uv2
			uv1.selectNum_ = 1

			uv1:RefreshCanUseMaxNum()
			uv1.scrollHelper:Refresh()
			uv1:UpdateSliderPositionBySelectNum()
			uv1:UpdatePreview()
		end
	end)
end

function slot0.RefreshCanUseMaxNum(slot0)
	slot0.canUseMaxNum_ = math.max(math.min(math.min(math.floor((NewWarChessAttributeCfg.GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT.max - NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT")) / ItemCfg[slot0.propsBonds[slot0.selectInex]].param[1]), ItemTools.getItemNum(slot0.propsBonds[slot0.selectInex])), NewChessTools.GetNewWarChessGameSetting("new_warchess_movepoint_usenum_max", NewWarChessData:GetCurrentMainActivity())[1]), 0)

	if slot0.canUseMaxNum_ <= 0 then
		slot0.selectNum_ = 0
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		if uv0.selectNum_ > 0 then
			CommonAction.TryToUseItem({
				{
					itme_info = {
						id = uv0.propsBonds[uv0.selectInex],
						num = slot1
					},
					use_list = {
						NewWarChessData:GetCurrentWarChessMapID()
					}
				}
			})
		end
	end)
	slot0.useNumSlider_.onValueChanged:AddListener(function ()
		uv0.selectNum_ = math.floor(uv0.canUseMaxNum_ * uv0.useNumSlider_.value + 1e-05)

		if uv0.canUseMaxNum_ > 0 then
			if uv0.selectNum_ < 1 then
				uv0.selectNum_ = 1
			end
		elseif uv0.canUseMaxNum_ <= 0 then
			uv0.selectNum_ = 0
		end

		uv0:UpdateSliderPositionBySelectNum()
		uv0:UpdatePreview()
	end)
	slot0:AddPressingByTimeListener(slot0.delBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.selectNum_ > 1 then
			uv0.selectNum_ = uv0.selectNum_ - 1

			uv0:UpdateSliderPositionBySelectNum()
			uv0:UpdatePreview()

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.addBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.selectNum_ < uv0.canUseMaxNum_ then
			uv0.selectNum_ = uv0.selectNum_ + 1

			uv0:UpdateSliderPositionBySelectNum()
			uv0:UpdatePreview()

			return true
		end

		return false
	end)
end

function slot0.OnTryToUseItem(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		slot3 = slot2.use_item_list[1].num * ItemCfg[slot2.use_item_list[1].item_id].param[1]

		NewWarChessData:SubAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT", slot3)
		JumpTools.Back()
		manager.NewChessManager:CreateTips({
			tipsType = NewChessConst.TIPS_TYPE.NORMAL,
			tipsText = string.format(GetTips("ACTIVITY_NEW_WARCHESS_GET_MOVEPOINT"), slot3)
		})
	else
		ShowTips(slot1.result)
	end
end

function slot0.OnEnter(slot0)
	slot0.mainActivityID_ = slot0.params_.mainActivityID
	slot0.propsBonds = {}

	for slot4, slot5 in pairs(slot0.allProps) do
		if ItemCfg[slot5].time[2][1] == slot0.mainActivityID_ then
			table.insert(slot0.propsBonds, slot5)
		end
	end

	slot0.selectInex = 0
	slot0.selectNum_ = 0
	slot0.canUseMaxNum_ = 0

	slot0:RefreshTexts()

	for slot4, slot5 in ipairs(slot0.propsBonds) do
		if ItemTools.getItemNum(slot5) > 0 then
			slot0.selectInex = slot4
			slot0.selectNum_ = 1

			slot0:RefreshCanUseMaxNum()
			slot0:UpdateSliderPositionBySelectNum()
			slot0:UpdatePreview()

			break
		end
	end

	slot0.scrollHelper:StartScroll(#slot0.propsBonds)

	if slot0.selectInex == 0 then
		slot0.selectNum_ = 0
		slot0.canUseMaxNum_ = 0

		slot0:UpdateSliderPositionBySelectNum()
		slot0:UpdatePreview()
	end
end

function slot0.RefreshTexts(slot0)
	slot0.currencyText_.text = NewChessTools.GetMovePointText(NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT"))
end

function slot0.UpdateSliderPositionBySelectNum(slot0)
	if slot0.canUseMaxNum_ == 0 then
		slot0.useNumSlider_.value = 0
	else
		slot0.useNumSlider_.value = slot0.selectNum_ / slot0.canUseMaxNum_
	end
end

function slot0.UpdatePreview(slot0)
	slot0.useNumText_.text = slot0.selectNum_

	if slot0.selectNum_ == 0 then
		slot0.getnumText_.text = 0

		slot0.btnController_:SetSelectedState("false")

		slot0.okBtn_.interactable = false
	else
		slot0.getnumText_.text = ItemCfg[slot0.propsBonds[slot0.selectInex]].param[1] * slot0.selectNum_

		slot0.btnController_:SetSelectedState("true")

		slot0.okBtn_.interactable = true
	end

	slot0.delBtn_.interactable = slot0.selectNum_ > 1
	slot0.addBtn_.interactable = slot0.selectNum_ < slot0.canUseMaxNum_
	slot0.okBtn_.interactable = slot0.selectInex > 0
end

function slot0.OnExitInput(slot0)
	JumpTools.Back()

	return true
end

function slot0.Dispose(slot0)
	slot0.scrollHelper:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
