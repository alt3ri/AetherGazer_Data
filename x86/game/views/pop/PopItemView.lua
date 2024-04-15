slot0 = class("PopItemView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Common/Pop/ProphintspopUI"
end

function slot0.OnCtor(slot0, ...)
	slot1, slot2 = gameContext:GetLastHistoryAndParams()

	if string.char(string.byte(slot1)) == "/" then
		slot1 = string.sub(slot1, 2)
	end

	slot0.lastRecord_ = slot1

	OperationRecorder.Record(slot0.lastRecord_, "PopItemView")
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.GetItemID(slot0)
	return slot0.itemInfo_.id
end

function slot0.GetItemNum(slot0)
	return slot0.itemInfo_.num
end

function slot0.GetItemTimeValid(slot0)
	return slot0.itemInfo_.timeValid
end

function slot0.OnEnter(slot0)
	slot0.itemInfo_ = slot0.params_.popItemInfo
	slot0.extraInfo_ = slot0.params_.extraInfo or {}

	slot0:RefreshCommonItem()
	slot0:RefreshContent()
	slot0:RefreshCount()
	slot0:RefreshOwnedTotalCount()
end

function slot0.OnMaterialUpdate(slot0, slot1)
	if slot1 == slot0:GetItemID() then
		slot0:RefreshCount()
	end
end

function slot0.RefreshLableContent(slot0)
	if DormFurnitureTools:CheckFurShowExtendLable(slot0:GetItemID()) then
		slot0.lableList = DormTools:GetFurLable(slot0:GetItemID()) or {}

		slot0.labelScroll_:StartScroll(#slot0.lableList)
	end
end

function slot0.indexLableItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0:GetItemID(), slot0.lableList[slot1])
end

function slot0.indexSoureceItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0:GetItemID(), slot0.sourceList[slot1])

	if slot0.OnJumpCallback then
		slot2:SetJumpCallback(handler(slot0, slot0.OnJumpCallback))
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	slot0.commonItemView_:Dispose()

	slot0.commonItemView_ = nil
	slot0.maskBtn_ = nil
	slot0.nameText_ = nil
	slot0.countentText_ = nil
	slot0.sourceBtn_ = nil
	slot0.sourceBtnGo_ = nil
	slot0.operatePanel_ = nil
	slot0.useBtn_ = nil
	slot0.cntPanel_ = nil
	slot0.cntText_ = nil
	slot0.commonItem_ = nil
	slot0.sourcePanel_ = nil
	slot0.infoBtn_ = nil
	slot0.sourceParent_ = nil
	slot0.unlockItem_ = nil
	slot0.lockItem_ = nil
	slot0.invalidItem_ = nil

	if slot0.sourceScroll_ then
		slot0.sourceScroll_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.infoController = slot0.prophintspopuiControllerexcollection_:GetController("tab")
	slot0.timeController = slot0.prophintspopuiControllerexcollection_:GetController("time")
	slot0.equipController = slot0.prophintspopuiControllerexcollection_:GetController("equip")
	slot0.groupController = slot0.prophintspopuiControllerexcollection_:GetController("group")
	slot0.viewController = slot0.prophintspopuiControllerexcollection_:GetController("view")
	slot0.useController = slot0.prophintspopuiControllerexcollection_:GetController("Use")
	slot0.bgController = slot0.prophintspopuiControllerexcollection_:GetController("bg")
	slot0.starController = slot0.prophintspopuiControllerexcollection_:GetController("star")
	slot0.tabControllerController = slot0.prophintspopuiControllerexcollection_:GetController("tab")
	slot0.btnShowControllerController = slot0.prophintspopuiControllerexcollection_:GetController("isShowBtn")
	slot0.soureceDesControllerController = slot0.prophintspopuiControllerexcollection_:GetController("soureceDes")
	slot0.probabilityController = slot0.prophintspopuiControllerexcollection_:GetController("probability")
	slot0.useNumTriggerListener_ = slot0.useNumSlider_.gameObject.transform:GetComponent(typeof(EventTriggerListener))
	slot0.sourceList = {}
	slot0.sourceScroll_ = LuaList.New(handler(slot0, slot0.indexSoureceItem), slot0.accessUilist_, PopsoureceItem)

	slot0.viewController:SetSelectedState("state0")
	slot0.useController:SetSelectedState("state0")
	slot0.starController:SetSelectedState("state0")
	slot0.soureceDesControllerController:SetSelectedState("notshow")
	slot0.probabilityController:SetSelectedState("notshow")
	slot0.tabControllerController:SetSelectedState("none")
	slot0:CustomInitUI()
end

function slot0.CustomInitUI(slot0)
	slot0.tabControllerController:SetSelectedState("descripe")
	slot0.btnShowControllerController:SetSelectedState("hide")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.RemoveListeners(slot0)
end

function slot0.RefreshContent(slot0)
	slot1 = ItemCfg[slot0:GetItemID()]
	slot0.nameText_.text = ItemTools.getItemName(slot1.id)
	slot0.countentText_.text = ItemTools.getItemDesc(slot1.id)

	if ItemTools.GetItemExpiredTimeByInfo(slot0.itemInfo_) == nil or slot3 == 0 then
		slot0.timeController:SetSelectedState("no")
	else
		slot0.timeController:SetSelectedState("yes")

		slot0.timeLabel_.text = string.format(GetTips("TIME_DISPLAY_12"), manager.time:STimeDescS(ItemTools.GetItemExpiredTimeByInfo(slot2), "!%Y/%m/%d %H:%M"))
	end
end

function slot1(slot0, slot1)
	slot2 = slot1 or {}
	slot2.id = slot2.id or slot0.id
	slot2.number = slot2.num or slot0.num
	slot2.timeValid = slot2.timeValid or slot0.timeValid

	return slot2
end

function slot0.RefreshCommonItem(slot0, slot1)
	if not slot0.commonItemView_ then
		slot0.commonItemView_ = CommonItemView.New(slot0.commonItem_)
	end

	slot0.itemInfo_.hideBottomRightTextFlag = true
	slot0.itemInfo_.animatorType = ItemConst.ITEM_ANIMATOR_TYPE.NULL

	slot0.commonItemView_:SetData(slot0.itemInfo_)
	slot0.commonItemView_.rareController_:SetSelectedState("off")
	slot0:UpdateIcon()

	if ItemCfg[slot0:GetItemID()] and ItemConst.ITEM_TYPE.HERO == slot2.type then
		-- Nothing
	end

	if ItemCfg[slot0.itemInfo_.id] then
		slot0.bgController:SetSelectedState("state" .. tostring(slot3.display_rare or 0))
	end
end

function slot0.UpdateIcon(slot0)
	slot0.itemImg_.sprite = ItemTools.getItemSprite(slot0:GetItemID())
end

function slot0.SetCommonItem(slot0, slot1)
	slot0.itemInfo_.number = slot1

	slot0:RefreshCommonItem()
end

function slot0.RefreshCount(slot0)
	slot2 = slot0.itemInfo_
	slot3 = ItemTools.GetItemExpiredTimeByInfo(slot2)
	slot5 = ItemTools.getItemNum(slot0:GetItemID(), ItemTools.GetItemExpiredTimeByInfo(slot2))

	if not MaterialData:IsItemHaveServeTick(slot0.itemInfo_.id) then
		slot5 = ItemTools.getItemNum(slot1)
	end

	slot0.cntText_.text = NumberTools.RetractNumberForWindBar(slot5)
end

slot2 = setmetatable({}, {
	__index = function ()
		return true
	end
})
slot3 = {
	[ItemConst.ITEM_TYPE.CURRENCY] = slot2,
	[ItemConst.ITEM_TYPE.HERO] = slot2,
	[ItemConst.ITEM_TYPE.HERO_SKIN] = slot2,
	[ItemConst.ITEM_TYPE.PORTRAIT] = slot2,
	[ItemConst.ITEM_TYPE.FRAME] = slot2,
	[ItemConst.ITEM_TYPE.STICKER] = slot2,
	[ItemConst.ITEM_TYPE.STICKER_BG] = slot2,
	[ItemConst.ITEM_TYPE.SCENE] = slot2,
	[ItemConst.ITEM_TYPE.TAG] = slot2,
	[ItemConst.ITEM_TYPE.CARD_BG] = slot2,
	[ItemConst.ITEM_TYPE.FURNITURE_SUIT] = slot2,
	[ItemConst.ITEM_TYPE.CHAT_BUBBLE] = slot2,
	[ItemConst.ITEM_TYPE.CLUB_COMMON] = slot2,
	[ItemConst.ITEM_TYPE.GIFT] = {
		[ItemConst.ITEM_SUB_TYPE.EQUIP_PIECE] = true,
		[ItemConst.ITEM_SUB_TYPE.EQUIP_PIECE_UP] = true,
		[ItemConst.ITEM_SUB_TYPE.DROP_ITEM] = true,
		[ItemConst.ITEM_SUB_TYPE.FUKUBUKURO] = true
	}
}

function slot0.ShouldHideOwnedTotalCount(slot0)
	slot1 = ItemCfg[slot0:GetItemID()]

	return nullable(uv0, slot1.type, slot1.sub_type) or false
end

function slot0.RefreshOwnedTotalCount(slot0)
	if slot0:ShouldHideOwnedTotalCount() or (slot0.itemInfo_ and slot0.itemInfo_.isHideNum_ or false) then
		SetActive(slot0.cntPanel_, false)
	else
		SetActive(slot0.cntPanel_, true)
	end
end

function slot0.Cacheable(slot0)
	return false
end

function slot0.ShowInfo(slot0)
	slot0.tabControllerController:SetSelectedState("descripe")
end

return slot0
