slot0 = class("MailBoxRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.commonItem_ = CommonItemView.New(slot0.commonItemGo_)
end

function slot0.AddUIListener(slot0)
end

function slot0.SetRewardData(slot0, slot1, slot2)
	slot0.rewardData_ = slot1
	slot0.haveGet_ = slot2

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot1 = formatReward(slot0.rewardData_)
	clone(ItemTemplateData).id = slot1.id
	slot2.number = slot1.num or slot1.number
	slot2.timeValid = slot1.timeValid or 0
	slot2.completedFlag = slot0.haveGet_
	slot2.clickFun = handler(slot0, slot0.OnClickCommonItem)

	slot0.commonItem_:SetData(slot2)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.OnClickCommonItem(slot0, slot1)
	ShowPopItem(POP_ITEM, {
		slot1.id,
		slot1.number
	})
	OperationRecorder.Record("MailBoxRewardItem", "popItem")
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.commonItem_ then
		slot0.commonItem_:Dispose()

		slot0.commonItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
