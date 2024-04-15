slot0 = class("ValentineGameV2SelectHeroView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, ValentineGameV2SelectHeroItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.subActivityID_[slot1])
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.subActivityID_ = ActivityCfg[slot0.activityID_].sub_activity_list

	slot0.heroList_:StartScroll(#slot0.subActivityID_)

	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			for slot4, slot5 in pairs(uv0.heroList_:GetItemList()) do
				slot5:RefreshTimeText()
			end
		end, 1, -1)

		slot0.timer_:Start()
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_VALENTINE_DESCRIBE")
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot5, slot6 in pairs(slot0.heroList_:GetItemList()) do
		slot6:OnExit()
	end

	slot0:StopTimer()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	if slot0.heroList_ then
		slot0.heroList_:Dispose()

		slot0.heroList_ = nil
	end

	slot0:StopTimer()
	slot0.super.Dispose(slot0)
end

return slot0
