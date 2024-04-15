slot0 = class("DestroyBoxGameRewardPanel", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, DestroyBoxGameRewardItem)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.activityID_ = slot1
	slot0.rewardIDList_ = slot2

	slot0.uiList_:StartScroll(#slot0.rewardIDList_)
	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0.m_title.text = ActivityCfg[slot0.activityID_].remark
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.rewardIDList_[slot1])
end

return slot0
