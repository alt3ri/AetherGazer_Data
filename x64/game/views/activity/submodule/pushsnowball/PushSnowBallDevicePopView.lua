slot0 = class("PushSnowBallDevicePopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballDevicePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.refreshHandler_ = handler(slot0, function ()
		uv0:RefreshUI()
	end)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.deviceList_, PushSnowBallDeviceItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
	manager.notify:RegistListener(PUSH_SNOWBALL_EQUIP_DEVICE, slot0.refreshHandler_)
end

function slot0.RefreshUI(slot0)
	slot0.deviceDataList_ = PushSnowBallDeviceCfg.all

	slot0.uiList_:StartScroll(#slot0.deviceDataList_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.deviceDataList_[slot1])
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(PUSH_SNOWBALL_EQUIP_DEVICE, slot0.refreshHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end
end

return slot0
