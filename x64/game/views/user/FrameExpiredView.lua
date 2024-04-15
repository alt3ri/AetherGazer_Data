StoreExpiredView = import("game.views.store.expired.StoreExpiredView")
slot0 = class("FrameExpiredView", StoreExpiredView)

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshData({
		id = slot0.params_.materialList[slot1].id,
		number = slot0.params_.materialList[slot1].num,
		timeValid = slot0.params_.materialList[slot1].timeValid
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_OTHER_ITEM, {
			slot0.id,
			slot0.number,
			0,
			slot0.timeValid
		})
	end)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot1 = slot0.params_.type
	slot2 = slot0.titleText1_
	slot3 = slot0.descText1_

	if #slot0.getItemDataList_ > 0 then
		slot2 = slot0.titleText2_
		slot3 = slot0.descText2_
	end

	if slot1 == ItemConst.ITEM_TYPE.FRAME then
		slot2.text = GetTips("PROFILE_AVATAR_FRAME_OVERDUE_TITLE")
		slot3.text = GetTips("PROFILE_AVATAR_FRAME_OVERDUE_CONTENT")
	elseif slot1 == ItemConst.ITEM_TYPE.CARD_BG then
		slot2.text = GetTips("PROFILE_BUSINESS_CARD_OVERDUE_TITLE")
		slot3.text = GetTips("PROFILE_BUSINESS_CARD_OVERDUE_CONTENT")
	elseif slot1 == ItemConst.ITEM_TYPE.TAG then
		slot2.text = GetTips("PROFILE_LABEL_OVERDUE_TITLE")
		slot3.text = GetTips("PROFILE_LABEL_OVERDUE_CONTENT")
	end
end

return slot0
