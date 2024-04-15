slot0 = class("KagutsuchiGachaRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardController_ = ControllerUtil.GetController(slot0.transform_, "reward")
	slot0.commonItem_ = CommonItem.New(slot0.commonItemGo_)
end

function slot0.AddUIListeners(slot0)
	slot0.commonItem_:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			uv0.itemID_
		})
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.id_ = slot3
	slot0.poolId_ = slot2
	slot0.activityId_ = slot1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.itemID_, slot2 = KagutsuchiGachaData:GetDrawItemReward(slot0.poolId_, slot0.id_)
	slot3 = KagutsuchiGachaData:GetDrawItemRemainCount(slot0.poolId_, slot0.id_)

	slot0.rewardController_:SetSelectedState(slot3 > 0 and "have" or "no")

	slot0.itemText_.text = slot3 .. "/" .. KagutsuchiGachaData:GetDrawItemTotalCount(slot0.poolId_, slot0.id_)

	slot0.commonItem_:RefreshData({
		id = slot1,
		number = slot2
	})
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.commonItem_:Dispose()

	slot0.commonItem_ = nil

	slot0.super.Dispose(slot0)
end

return slot0
