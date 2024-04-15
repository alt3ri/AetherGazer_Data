slot0 = class("RegressionBPRewardItem", ReduxView)

function slot0.GetItemPath(slot0)
	if slot0.isSmall_ then
		return "Widget/System/Com_dynamic/CommonItem_s"
	else
		return "Widget/System/Com_dynamic/CommonItem"
	end
end

function slot0.OnCtor(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.parentGo_ = Object.Instantiate(slot2, slot1.transform)

	slot0:BindCfgUI(slot0.parentGo_)

	slot0.isSmall_ = slot3
	slot0.gameObject_ = slot0.parentGo_
	slot0.transform_ = slot0.parentGo_.transform

	SetActive(slot0.gameObject_, true)

	slot0.commonItemGo_ = manager.objectPool:Get(slot0:GetItemPath())
	slot0.commonItem_ = CommonItemView.New(slot0.commonItemGo_)

	slot0:SetParent()

	slot0.clickCallback_ = slot5

	if slot0.receivedMarkGo_ then
		slot0.receivedMarkGo_.transform:SetAsLastSibling()
	end

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.SetParent(slot0)
	slot0.commonItemGo_.transform:SetParent(slot0.parentGo_.transform, true)
	slot0.commonItem_:ResetTransform()
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	if not slot0.itemData_ then
		slot0.itemData_ = clone(ItemTemplateData)
		slot0.itemData_.clickFun = slot0.clickCallback_
	end

	slot0.itemData_.id = slot1[1]
	slot0.itemData_.number = slot1[2]

	slot0.commonItem_:SetData(slot0.itemData_)
	slot0:Show(true)

	if slot3 == nil or slot3 >= 1 then
		slot0.commonItem_:RefreshLock(false)
	else
		slot0.commonItem_:RefreshLock(true)
	end
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.parentGo_, slot1)
end

function slot0.RefreshStatus(slot0, slot1)
	slot0.statusController_:SetSelectedIndex(slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.commonItem_:Dispose()

	slot0.commonItem_ = nil

	manager.objectPool:Return(slot0:GetItemPath(), slot0.commonItemGo_)
end

return slot0
