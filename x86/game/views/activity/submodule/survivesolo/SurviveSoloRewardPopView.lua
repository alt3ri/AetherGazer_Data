slot0 = class("SurviveSoloRewardPopView", ReduxView)

function slot0.UIName(slot0)
	return SurviveSoloTools.GetRewardPopView(slot0.params_.activityID)
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

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, SurviveSoloRewardItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.list_[slot1], slot0.activityID_)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.list_ = ActivitySoloSlayerCfg.get_id_list_by_main_activity_id[slot0.activityID_]

	slot0:RefreshReward()
	slot0:RefreshList()
end

function slot0.RefreshReward(slot0)
	for slot5, slot6 in ipairs(slot0.list_) do
		if SurviveSoloData:GetData(slot6) then
			slot1 = 0 + #slot7.rewards
		end
	end

	slot0.rewardTxt_.text = slot1
	slot0.allTxt_.text = "/" .. #slot0.list_ * 3
end

function slot0.RefreshList(slot0)
	slot1 = 1

	for slot5, slot6 in ipairs(slot0.list_) do
		if SurviveSoloData:GetData(slot6) then
			for slot14, slot15 in ipairs(ActivitySoloSlayerCfg[slot6].reward_item_list) do
				if slot15[1] <= slot7.time and not table.indexof(slot7.rewards, slot15[1]) then
					slot0.scrollHelper_:StartScroll(#slot0.list_, slot5)

					return
				end
			end
		end
	end

	slot0.scrollHelper_:StartScroll(#slot0.list_)
end

function slot0.OnSurviveSoloReward(slot0)
	slot0:RefreshReward()
	slot0.scrollHelper_:Refresh()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Dispose()

		slot0.scrollHelper_ = nil
	end

	slot0.super.Dispose(slot0)
end

return slot0
