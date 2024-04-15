slot0 = class("SpringWelfareTaskRewardItem", ReduxView)
slot1 = import("game.tools.ItemTools")

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.commonItem_ = CommonItem.New(slot0.gameObject_)
end

function slot0.Dispose(slot0)
	slot0.commonItem_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
end

function slot0.AddListeners(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.commonItem_:RefreshData(formatReward(slot1))
	slot0.commonItem_:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)
	SetActive(slot0.gameObject_, true)
end

function slot0.UpdateCommonItemAni(slot0)
	slot0.commonItem_:UpdateAnimator()
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.ShowSelect(slot0, slot1)
	slot0.commonItem_:ShowSelect(slot1 and 1 or 0)
end

return slot0
