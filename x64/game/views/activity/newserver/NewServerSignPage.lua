slot0 = class("NewServerSignPage", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot3 = Object.Instantiate(Asset.Load("Widget/System/NewServer/NewServerSigninUI"), slot1)
	slot0.gameObject_ = slot3
	slot0.transform_ = slot3.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListGo_, NewServerSignItem)
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.SetData(slot0, slot1)
	slot0.activityID_ = slot1
	slot0.index_ = NewServerData:GetSignIndex()
	slot0.rewards_ = NewServerCfg[slot0.activityID_] and NewServerCfg[slot0.activityID_].sign_reward or {}

	slot0.itemList_:StartScroll(#slot0.rewards_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.rewards_[slot1])
	slot2:RegistCallBack(handler(slot0, slot0.OnItemClick))
end

function slot0.OnItemClick(slot0, slot1)
	if not ActivityTools.ActivityOpenCheck(slot0.activityID_) then
		return
	end

	NewServerAction.QuerySign(slot1)
end

function slot0.Dispose(slot0)
	if slot0.itemList_ then
		slot0.itemList_:Dispose()

		slot0.itemList_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.RefreshTime(slot0)
	if slot0.index_ ~= NewServerData:GetSignIndex() then
		for slot5, slot6 in ipairs(slot0.itemList_:GetItemList()) do
			slot6:Refresh()
		end
	end
end

function slot0.OnNewServerSign(slot0, slot1)
	for slot6, slot7 in ipairs(slot0.itemList_:GetItemList()) do
		if slot7.index_ == slot1 then
			slot7:OnSign()
		end
	end
end

return slot0
