slot0 = class("SpringPreheatPrayRewardItem", ReduxView)
slot1 = {
	GO_SELECT = 1,
	SELECTING = 2
}

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()

	slot0.id_ = 0

	slot0:SwitchToSelecting()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.goSelectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.selectingController_ = ControllerUtil.GetController(slot0.transform_, "select")

	if slot0.commonItemGo_ then
		slot0.commonItem_ = CommonItem.New(slot0.commonItemGo_)
		slot0.hasCommonItem_ = true
	end
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.onClickHandler_ then
			uv0:onClickHandler_()
		end
	end)

	if slot0.commonItem_ then
		slot0.commonItem_:RegistCallBack(function (slot0)
			if uv0.onClickHandler_ then
				uv0:onClickHandler_()
			end
		end)
	end
end

function slot0.SetClickHandler(slot0, slot1)
	if slot1 then
		slot0.onClickHandler_ = slot1
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	if slot0.commonItem_ then
		slot0.commonItem_:Dispose()

		slot0.commonItem_ = nil
	end

	slot0.super.Dispose(slot0)
end

function slot0.SwitchToGoSelect(slot0)
	slot0.mode_ = uv0.GO_SELECT
end

function slot0.SwitchToSelecting(slot0)
	slot0.mode_ = uv0.SELECTING
end

function slot0.SetSelected(slot0, slot1)
	slot0.selected_ = slot1

	return slot0.selected_
end

function slot0.SetSelectable(slot0, slot1)
	slot0.selectable_ = slot1

	return slot0.selectable_
end

function slot0.SetData(slot0, slot1)
	slot0.id_ = slot1
	slot0.poolId_ = SpringPreheatData:GetPoolId()

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if slot0.mode_ == uv0.GO_SELECT then
		slot0.goSelectController_:SetSelectedState(slot0:CanGoSelect() and "true" or "false")
	elseif slot0.selectable_ then
		slot0.selectingController_:SetSelectedState(slot0.selected_ and "clicked" or "selectable")
	else
		slot0.selectingController_:SetSelectedState("selected")
	end

	slot0:RefreshItemUI()
end

function slot0.RefreshItemUI(slot0)
	if slot0.id_ == 0 then
		slot0.itemID_ = 0

		if slot0.hasCommonItem_ then
			SetActive(slot0.commonItemGo_, false)
		end

		SetActive(slot0.iconGo_, false)

		return
	end

	slot0.itemID_, slot2 = KagutsuchiGachaData:GetDrawItemReward(slot0.poolId_, slot0.id_)

	if slot0.hasCommonItem_ then
		slot0.commonItem_:RefreshData({
			id = slot1,
			number = slot2
		})
		SetActive(slot0.commonItemGo_, true)
	else
		slot0.icon_.sprite = ItemTools.getItemSprite(slot1)

		SetActive(slot0.iconGo_, true)
	end
end

function slot0.GetItemId(slot0)
	return slot0.itemID_
end

function slot0.CanGoSelect(slot0)
	return slot0.id_ ~= 0 and slot0.mode_ == uv0.GO_SELECT
end

return slot0
