slot0 = class("StoreItemInfo", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.storeHeadInfoView_ = StoreHeadInfo.New(slot0.itemHeadGo_)
	slot0.hideBtnController_ = slot0.controllerEx_:GetController("btnState")
	slot0.btnController_ = slot0.controllerEx_:GetController("btn")
	slot0.switchBtnController_ = slot0.controllerEx_:GetController("tab")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexSourceItem), slot0.uiListGo_, StoreItemSource)
	slot0.selectInfoType_ = StoreConst.ITEM_INFO_TYPE.DESC
end

function slot0.OnEnter(slot0)
	slot0.storeHeadInfoView_:OnEnter()
end

function slot0.OnExit(slot0)
	slot0.storeHeadInfoView_:OnExit()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.uiList_:Dispose()

	slot0.uiList_ = nil

	slot0.storeHeadInfoView_:Dispose()

	slot0.storeHeadInfoView_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.switchBtn_, nil, function ()
		if uv0.selectInfoType_ == StoreConst.ITEM_INFO_TYPE.DESC then
			uv0.selectInfoType_ = StoreConst.ITEM_INFO_TYPE.SOURCE
		else
			uv0.selectInfoType_ = StoreConst.ITEM_INFO_TYPE.DESC
		end

		uv0:RefreshInfo()
	end)
	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		slot0 = ItemCfg[uv0.itemData_.id]

		if ItemTools.GetItemExpiredTimeByInfo(uv0.itemData_) ~= 0 and slot1 <= manager.time:GetServerTime() then
			ShowTips("ITEM_EXPIRE")

			return
		end

		if slot0.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM or slot0.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM_MULT or slot0.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM_LIMIT_TIME then
			JumpTools.OpenPageByJump("optionalItemSelect", {
				popItemInfo = {
					uv0.itemData_.id,
					uv0.itemData_.number,
					0,
					slot1
				},
				selectNum = 1
			})

			return
		end

		if slot0.type == ItemConst.ITEM_TYPE.GIFT and ItemConst.ITEM_SUB_TYPE.FUKUBUKURO == slot0.sub_type then
			JumpTools.OpenPageByJump("popFukubukuroSelect", {
				popItemInfo = {
					uv0.itemData_.id,
					uv0.itemData_.number,
					0,
					uv0.itemData_.timeValid
				},
				instance_id = uv0.itemData_.instance_id
			})

			return
		end

		if slot0.sub_type == ItemConst.ITEM_SUB_TYPE.LIMIT_TIME_SKIN_ITEM then
			JumpTools.OpenPageByJump("limitTimeSkinUsePop", {
				itemData = uv0.itemData_
			})

			return
		end

		JumpTools.OpenPageByJump("itemUse", {
			itemData = uv0.itemData_
		})
	end)
	slot0:AddBtnListener(slot0.composeBtn_, nil, function ()
		JumpTools.OpenPageByJump("synthesise", {
			id = ItemCfg[uv0.itemData_.id].compose_id
		})
	end)
	slot0:AddBtnListener(slot0.decomposeBtn_, nil, function ()
		JumpTools.OpenPageByJump("synthesise", {
			id = ItemCfg[uv0.itemData_.id].decompose_id
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.itemData_ = slot1

	slot0.storeHeadInfoView_:SetData(slot1)

	slot3 = slot1.id
	slot0.descText_.text = ItemTools.getItemDesc(slot3)
	slot5 = false

	if ItemCfg[slot3].compose_id ~= 0 and slot4.decompose_id ~= 0 then
		slot0.btnController_:SetSelectedState("state3")
	elseif slot4.compose_id ~= 0 then
		slot0.btnController_:SetSelectedState("state1")
	elseif slot4.decompose_id ~= 0 then
		slot0.btnController_:SetSelectedState("state2")
	elseif ItemTools.isCanUseItem(slot3) then
		slot0.btnController_:SetSelectedState("state0")
	else
		slot5 = true
	end

	if slot5 then
		slot0.hideBtnController_:SetSelectedState("hide")
	else
		slot0.hideBtnController_:SetSelectedState("show")
	end

	if not slot2 then
		slot0.selectInfoType_ = StoreConst.ITEM_INFO_TYPE.DESC
	end

	slot0:RefreshInfo()

	slot0.sourceList_ = ItemTools.GetItemSourceList(slot3)

	slot0.uiList_:StartScroll(#slot0.sourceList_)
end

function slot0.RefreshInfo(slot0)
	if slot0.selectInfoType_ == StoreConst.ITEM_INFO_TYPE.DESC then
		slot0.switchBtnController_:SetSelectedState("desc")
	else
		slot0.switchBtnController_:SetSelectedState("source")
	end
end

function slot0.IndexSourceItem(slot0, slot1, slot2)
	slot2:SetData(slot0.sourceList_[slot1])
end

return slot0
