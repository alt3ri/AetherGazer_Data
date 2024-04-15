slot0 = class("CapsuleToysRewardItem", ReduxView)

function slot0.GetItemPath(slot0)
	if slot0.isSmall_ then
		return "Widget/System/Com_dynamic/CommonItem_s"
	else
		return "Widget/System/Com_dynamic/CommonItem"
	end
end

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.parentGo_ = Object.Instantiate(slot2, slot1.transform, false)

	slot0:BindCfgUI(slot0.parentGo_)

	slot0.isSmall_ = slot3
	slot0.gameObject_ = slot0.parentGo_
	slot0.transform_ = slot0.parentGo_.transform

	SetActive(slot0.gameObject_, true)

	slot0.commonItemGo_ = manager.objectPool:Get(slot0:GetItemPath())
	slot0.commonItem_ = CommonItemView.New(slot0.commonItemGo_)

	slot0:SetParent()

	slot0.parentGo_.transform.localScale = Vector3.one

	if slot0.soldOutGo_ then
		slot0.soldOutGo_.transform:SetAsLastSibling()
	end
end

function slot0.SetParent(slot0)
	slot0.commonItemGo_.transform:SetParent(slot0.contentTrans_, true)
	slot0.commonItem_:ResetTransform()
end

function slot0.SetData(slot0, slot1)
	slot0.rewardID_ = slot1
	slot2 = RegressionCapsuleToysCfg[slot1]
	slot4 = 0

	if RegressionData:GetCapsuleToysStatus()[slot1] then
		slot4 = slot3.remain_num
	end

	slot0.progressText_.text = string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), slot4, slot2.total)

	if slot0.soldOutGo_ then
		SetActive(slot0.soldOutGo_, slot4 == 0)
	end

	slot5 = RegressionCapsuleToysCfg[slot0.rewardID_].reward

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

	slot0.commonItem_:SetData(slot0.itemData_)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.parentGo_, slot1)
	uv0.super.Show(slot0, slot1)
end

function slot0.Dispose(slot0)
	slot0.commonItem_:Dispose()

	slot0.commonItem_ = nil

	manager.objectPool:Return(slot0:GetItemPath(), slot0.commonItemGo_)

	slot0.commonItemGo_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
