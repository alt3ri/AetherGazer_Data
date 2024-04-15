slot0 = class("ActivityEntraceView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.itemUiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListGo_, ActivityEntraceItem)
	slot0.activityOpenHandler_ = handler(slot0, slot0.ActivityOpen)
end

function slot0.OnEnter(slot0)
	manager.notify:RegistListener(ACTIVITY_UPDATE, slot0.activityOpenHandler_)
	manager.notify:RegistListener(ACTIVITY_ENTRACE_OPEN, slot0.activityOpenHandler_)
	slot0:InitItemList()
	slot0:AddTimer()
	slot0:RefreshScrollView()
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(ACTIVITY_UPDATE, slot0.activityOpenHandler_)

	slot4 = slot0.activityOpenHandler_

	manager.notify:RemoveListener(ACTIVITY_ENTRACE_OPEN, slot4)
	slot0:StopTimer()

	for slot4, slot5 in pairs(slot0.itemUiList_:GetItemList()) do
		slot5:OnExit()
	end
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot0.activiteTime_ = Timer.New(function ()
		for slot3, slot4 in ipairs(uv0.idList_) do
			if ActivityData:GetActivityIsOpen(slot4) == false then
				manager.notify:Invoke(ACTIVITY_ENTRACE_OPEN, slot4)
			end
		end
	end, 1, -1)

	slot0.activiteTime_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.activiteTime_ then
		slot0.activiteTime_:Stop()

		slot0.activiteTime_ = nil
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.activityOpenHandler_ = nil

	slot0.itemUiList_:Dispose()

	slot0.itemUiList_ = nil
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.idList_[slot1])
end

function slot0.InitItemList(slot0)
	slot0.idList_ = {}

	for slot4, slot5 in ipairs(ActivityEntraceCfg.all) do
		if ActivityData:GetActivityIsOpen(slot5) then
			table.insert(slot0.idList_, slot5)
		end
	end

	slot0.itemUiList_:StartScroll(#slot0.idList_)
end

function slot0.ActivityOpen(slot0, slot1)
	if ActivityTemplateConst.MAIN_ACTIVITY ~= ActivityTools.GetActivityType(slot1) then
		return
	end

	if not table.indexof(slot0.idList_, slot1) then
		if ActivityEntraceCfg[slot1] == nil then
			return
		end

		table.insert(slot0.idList_, slot1)
		table.sort(slot0.idList_)
	elseif not ActivityData:GetActivityIsOpen(slot1) then
		table.removebyvalue(slot0.idList_, slot1)
	end

	slot0.itemUiList_:StartScroll(#slot0.idList_)
	slot0:RefreshScrollView()
end

function slot0.RefreshScrollView(slot0)
	if #slot0.idList_ > 1 then
		slot0.scrollView_.enabled = true
	else
		slot0.scrollView_.verticalNormalizedPosition = 0
		slot0.scrollView_.enabled = false
	end
end

return slot0
