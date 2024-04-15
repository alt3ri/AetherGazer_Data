slot0 = class("RecallSystemSignItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddBtnListener(slot0.signBtn_, nil, function ()
		if ActivityRecallData:GetSevenDaySignIndex(uv0.index) > 0 then
			ActivityRecallAction.RequireRecalledSign(ActivityRecallData:GetDataByPara("signActivityID"), uv0.index)
		end
	end)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.item = CommonItemView.New(slot0.m_item, true)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.data = slot1
	slot0.index = slot2

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot1 = ActivityRecallData:GetDataByPara("getRewardList")

	CommonTools.SetCommonData(slot0.item, {
		id = slot0.data.reward[1],
		number = slot0.data.reward[2],
		clickFun = function (slot0)
			ShowPopItem(POP_OTHER_ITEM, {
				slot0.id,
				slot0.number
			})
		end
	})
	SetActive(slot0.canGetGo_, slot0.index <= ActivityRecallData:GetDataByPara("signCount") and slot1[slot0.index] == nil)
	SetActive(slot0.getGo_, slot1[slot0.index] ~= nil)

	slot0.dayTxt_.text = slot0.data.day
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.item then
		slot0.item:Dispose()

		slot0.item = nil
	end
end

return slot0
