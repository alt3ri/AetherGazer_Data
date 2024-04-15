slot0 = class("AdminCatExploringView", ReduxView)

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.UIName(slot0)
	return "Widget/System/ExploreUI/ExploringPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list = LuaList.New(handler(slot0, slot0.SetEventData), slot0.listGo_, AdminCatExploreEventView)
end

function slot0.SetEventData(slot0, slot1, slot2)
	slot2:SetData(slot0.regionData.eventData[slot1], slot0.regionData.adminCatID, slot0.regionData.startTime)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBg_, nil, function ()
		uv0:Back()
	end)
end

function slot0.UpdateView(slot0)
	slot1 = ExploreAreaCfg[slot0.regionId]
	slot2 = 0
	slot0.regionData = AdminCatExploreData:GetDataByPara("regionData")[slot0.regionId]

	if slot0.regionData == nil then
		return
	end

	for slot6, slot7 in ipairs(slot0.regionData.eventData) do
		if manager.time:GetServerTime() >= slot7.time + slot0.regionData.startTime then
			slot2 = math.min(slot2 + 1, #slot0.regionData.eventData)
		end
	end

	for slot6, slot7 in ipairs(slot0.regionData.eventData) do
		if manager.time:GetServerTime() >= slot7.time + slot0.regionData.startTime then
			slot2 = 0 + 1
		end
	end

	slot0.regionTxt_.text = GetI18NText(slot1.area_name)
	slot3 = slot0.regionData.stopTime - manager.time:GetServerTime()
	slot0.remainTxt_.text = manager.time:DescCDTime(slot3)
	slot0.updateTimer_ = Timer.New(function ()
		uv0 = uv1.regionData.stopTime - manager.time:GetServerTime()
		uv1.remainTxt_.text = manager.time:DescCDTime(uv0)

		if uv2 < #uv1.regionData.eventData and manager.time:GetServerTime() >= uv1.regionData.eventData[uv2 + 1].time + uv1.regionData.startTime then
			uv2 = math.min(uv2 + 1, #uv1.regionData.eventData)

			uv1.list:StartScroll(uv2, uv2)
		end

		if uv0 <= 0 then
			uv1.updateTimer_:Stop()

			uv1.updateTimer_ = nil

			uv1:Back()
			AdminCatExploreAction.AdminCatExploreFinish(uv1.regionId)
		end
	end, 1, slot3, 1)

	slot0.list:StartScroll(slot2)
	slot0.updateTimer_:Start()
end

function slot0.OnEnter(slot0)
	slot0.regionId = slot0.params_.regionId

	slot0:UpdateView()
	manager.audio:PlayEffect("ui_system_explore", "explore_working", "")
	manager.audio:PlayEffect("ui_system_explore", "explore_working_loop", "")
end

function slot0.OnExit(slot0)
	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end
end

function slot0.Dispose(slot0)
	if slot0.list then
		slot0.list:Dispose()

		slot0.list = nil
	end

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
