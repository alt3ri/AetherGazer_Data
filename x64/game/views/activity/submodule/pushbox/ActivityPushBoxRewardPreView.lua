slot0 = class("ActivityPushBoxRewardPreView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/JapanRegionUI_2_10AnniversaryRewardPopup"
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

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, CommonItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot5 = ActivityCelebrationCakeCfg[slot0.list_[slot1]].award_list[1]

	slot2:RefreshData({
		id = slot5[1],
		number = slot5[2]
	})
	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)
	ControllerUtil.GetController(slot2.transform_, "completed"):SetSelectedState(slot0.curIndex_ < slot1 and "false" or "true")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.curIndex_ = ActivityPushBoxData:GetCurIndex(slot0.activityID_)
	slot0.list_ = ActivityCelebrationCakeCfg.get_id_list_by_activity_id[slot0.activityID_]

	slot0.scrollHelper_:StartScroll(#slot0.list_)
end

function slot0.OnExit(slot0)
	slot3 = slot0.scrollHelper_
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.GetItemList(slot5)) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	slot0.super.Dispose(slot0)
end

return slot0
