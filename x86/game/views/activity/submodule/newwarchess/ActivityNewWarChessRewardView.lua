slot0 = class("ActivityNewWarChessRewardView", ReduxView)

function slot0.UIName(slot0)
	if slot0.params_.mainActivityID == ActivityConst.ACTIVITY_NEWWARCHESS_2_6 then
		return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionNewWarChessRewardUI"
	elseif slot0.params_.mainActivityID == ActivityConst.ACTIVITY_2_10_NEWWARCHESS then
		return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10NewWarChessRewardUI"
	end
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, ActivityNewWarChessRewardItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.activityIds_[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.mainActivityID_ = slot0.params_.mainActivityID
	slot0.activityIds_ = slot0.params_.activityIDList

	slot0.uiList_:StartScroll(#slot0.activityIds_, slot0:GetCurScrollIndex())
end

function slot0.GetCurScrollIndex(slot0)
	slot1 = 1

	for slot5, slot6 in pairs(slot0.activityIds_) do
		slot7 = NewWarChessLevelCfg.get_id_list_by_activity[slot6][1]

		for slot13, slot14 in pairs(NewWarChessLevelCfg[slot7].explore) do
			if slot14 <= NewWarChessData:GetExploreValue(slot7) and not NewWarChessData:GetRewardIsGet(slot7, slot14) then
				return slot5
			end
		end
	end

	return slot1
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
