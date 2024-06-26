slot0 = class("MoonBoRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/VolumeRewardPreview"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, MoonBoRewardItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot1, slot0.params_.activityId)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.scrollHelper_:StartScroll(#MoonBoCfg.get_id_list_by_activity_id[slot0.params_.activityId])
end

function slot0.OnExit(slot0)
	slot3 = slot0.scrollHelper_
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
