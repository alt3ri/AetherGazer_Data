slot0 = class("NewServerCapsuleToysItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot1, true)
	slot0:BindCfgUI()

	slot0.commonItem_ = CommonItemView.New(slot0.commonItemGo_)
end

function slot0.SetData(slot0, slot1)
	slot0.rewardID_ = slot1
	slot2 = NewServerCapsuleToysCfg[slot1]
	slot4 = 0

	if NewServerData:GetCapsuleToysStatus()[slot1] then
		slot4 = slot3.remain_num
	end

	slot0.progressText_.text = string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), slot4, slot2.total)
	slot5 = NewServerCapsuleToysCfg[slot0.rewardID_].reward

	if not slot0.itemData_ then
		slot0.itemData_ = clone(ItemTemplateData)

		function slot0.itemData_.clickFun(slot0)
			ShowPopItem(POP_ITEM, {
				slot0.id,
				slot0.number
			})
		end
	end

	slot0.itemData_.id = slot5[1]
	slot0.itemData_.number = slot5[2]
	slot0.itemData_.completedFlag = slot4 == 0

	slot0.commonItem_:SetData(slot0.itemData_)
end

function slot0.Dispose(slot0)
	slot0.commonItem_:Dispose()

	slot0.commonItem_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
