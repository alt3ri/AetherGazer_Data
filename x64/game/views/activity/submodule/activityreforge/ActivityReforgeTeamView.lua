slot0 = class("ActivityReforgeTeamView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeTeamUI"
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

	slot0.teamList_ = LuaList.New(handler(slot0, slot0.IndexTeamItem), slot0.listGo_, ActivityReforgeTeamItem)
end

function slot0.IndexTeamItem(slot0, slot1, slot2)
	slot2:SetData(slot0.chapterActivityID_, slot0.levelID_, slot0.curWaveID_, slot0.teamIDList_[slot1])
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.chapterActivityID_ = slot0.params_.chapterActivityID
	slot0.levelID_ = slot0.params_.levelID
	slot0.curWaveID_ = slot0.params_.curWaveID
	slot0.levelCfg_ = ActivityReforgeLevelCfg[slot0.levelID_]

	slot0:SortTeam()
	slot0.teamList_:StartScroll(#slot0.teamIDList_)
end

function slot0.SortTeam(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot4 = {}
	slot5 = 0
	slot6 = ActivityReforgeWaveCfg[slot0.curWaveID_]

	for slot10, slot11 in pairs(slot0.levelCfg_.team_list) do
		if ActivityReforgeData:GetTeamCurUsingWaveID(slot11) > 0 then
			if slot12 == slot0.curWaveID_ then
				slot5 = slot11
			elseif table.indexof(slot6.recommend_team, slot11) then
				table.insert(slot4, slot11)
			else
				table.insert(slot3, slot11)
			end
		elseif table.indexof(slot6.recommend_team, slot11) then
			table.insert(slot2, slot11)
		else
			table.insert(slot1, slot11)
		end
	end

	slot0.teamIDList_ = {}

	if slot5 > 0 then
		table.insert(slot0.teamIDList_, slot5)
	end

	for slot10, slot11 in pairs(slot2) do
		table.insert(slot0.teamIDList_, slot11)
	end

	for slot10, slot11 in pairs(slot1) do
		table.insert(slot0.teamIDList_, slot11)
	end

	for slot10, slot11 in pairs(slot4) do
		table.insert(slot0.teamIDList_, slot11)
	end

	for slot10, slot11 in pairs(slot3) do
		table.insert(slot0.teamIDList_, slot11)
	end
end

function slot0.OnActivityReforgeCurLevelUpdate(slot0)
	slot0.teamList_:Refresh()
end

function slot0.Dispose(slot0)
	if slot0.teamList_ then
		slot0.teamList_:Dispose()

		slot0.teamList_ = nil
	end

	slot0.super.Dispose(slot0)
end

return slot0
