slot0 = class("SpringWelfareLetterRewardItem", ReduxView)

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
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.commonItem_ = CommonItem.New(slot0.commonItemGo_)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.onClickHandler_ then
			uv0:onClickHandler_()
		end
	end)
	slot0.commonItem_:RegistCallBack(function (slot0)
		if uv0.onClickHandler_ then
			uv0:onClickHandler_()
		end
	end)
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

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.itemID_ = slot1
	slot0.num_ = slot2
	slot0.acquired_ = slot3

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.stateController_:SetSelectedState(slot0.acquired_ and "acquired" or "normal")
	slot0:RefreshItemUI()
end

function slot0.RefreshItemUI(slot0)
	if slot0.itemID_ == 0 then
		SetActive(slot0.commonItemGo_, false)

		return
	end

	slot0.commonItem_:RefreshData({
		id = slot0.itemID_,
		number = slot0.num_
	})
	SetActive(slot0.commonItemGo_, true)
end

return slot0
