slot0 = class("ValentineGameV2RewardItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.commonItem_ = CommonItem.New(slot0.commonItemGo_)
end

function slot0.SetData(slot0, slot1)
	slot0.commonItem_:RefreshData(rewardToItemTemplate(formatReward(slot1)))
	slot0.commonItem_:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, slot0)
	end)
end

function slot0.Dispose(slot0)
	if slot0.commonItem_ then
		slot0.commonItem_:Dispose()

		slot0.commonItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
