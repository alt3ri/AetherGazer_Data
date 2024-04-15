slot0 = class("SummerStoryMainRemasteredView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BranchlineUI/SummerUI/SummerIslandMapUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.itemList_ = {}
	slot4 = ChessConst.SUBPLOT_TAG.ISLAND

	for slot4, slot5 in ipairs(WarchessLevelCfg.get_id_list_by_tag[slot4]) do
		slot0.itemList_[slot4] = SummerStoryMainWarchessRemasteredItem.New(slot0[string.format("sideStoryGo%s_", slot4)], slot5)
	end

	slot1 = ChapterClientCfg[6010003].chapter_list
	slot0.mainItem_ = SummerStoryMainRemasteredItem.New(slot0.mainStoryGo_, slot1[1])
	slot0.seabedItem_ = SummerStorySeabedRemasteredItem.New(slot0.seabedGo_, slot1[2], ActivityConst.SUMMER_STORY_SEABED)
	slot0.plotController_ = ControllerUtil.GetController(slot0.sideStoryBtn_.transform, "name")
	slot0.chessController_ = ControllerUtil.GetController(slot0.shipLogBtn_.transform, "name")
end

function slot0.OnEnter(slot0)
	slot4 = {
		BACK_BAR,
		slot5
	}
	slot5 = HOME_BAR

	manager.windowBar:SwitchBar(slot4)
	slot0.mainItem_:OnEnter()
	slot0.seabedItem_:OnEnter()

	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:OnEnter()
	end

	slot0.unLockSideStoryState_ = ActivityTools.IsUnlockActivity(ActivityConst.SUMMER_CHESS_SHIP_LOG)
	slot0.unLockChipLogState_ = ActivityTools.IsUnlockActivity(ActivityConst.SUMMER_CHESS_SHIP_LOG)

	slot0:RefreshUI()
	manager.redPoint:bindUIandKey(slot0.sideStoryBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityConst.THEME.SUMMER))
	manager.redPoint:bindUIandKey(slot0.shipLogBtn_.transform, string.format("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.SUMMER_CHESS_SHIP_LOG))

	if not getData("ActivityFirstEnter", ActivityConst.THEME.SUMMER, false) then
		if ChapterTools.IsClearStage(ChapterCfg[ChapterClientCfg[6010003].chapter_list[1]].section_id_list[1]) then
			return
		end

		saveData("ActivityFirstEnter", ActivityConst.THEME.SUMMER, true)
		BattleStageAction.ClickSubPlot(slot1)
		slot0:Go("/summerStoryRemastered", {
			chapterID = slot1
		})
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(slot0.sideStoryBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityConst.THEME.SUMMER))

	slot4 = slot0.shipLogBtn_.transform
	slot5 = string.format

	manager.redPoint:unbindUIandKey(slot4, slot5("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.SUMMER_CHESS_SHIP_LOG))
	slot0.mainItem_:OnExit()
	slot0.seabedItem_:OnExit()

	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.mainItem_:Dispose()

	slot0.mainItem_ = nil

	slot0.seabedItem_:Dispose()

	slot0.seabedItem_ = nil

	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.timeList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.sideStoryBtn_, nil, function ()
		if not uv0.unLockSideStoryState_ then
			slot0 = ActivityCfg[ActivityConst.SUMMER_CHESS_SHIP_LOG].unlock_condition

			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ChapterCfg[slot0[2][1]].subhead, BattleActivityStoryStageCfg[slot0[2][2]].name))

			return
		end

		uv0:Go("/summerPlotRemastered", {
			theme = ActivityConst.THEME.SUMMER
		})
	end)
	slot0:AddBtnListener(slot0.shipLogBtn_, nil, function ()
		if not uv0.unLockChipLogState_ then
			slot0 = ActivityCfg[ActivityConst.SUMMER_CHESS_SHIP_LOG].unlock_condition

			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ChapterCfg[slot0[2][1]].subhead, BattleActivityStoryStageCfg[slot0[2][2]].name))

			return
		end

		uv0:Go("/summerChessRemastered", {
			tag = ChessConst.SUBPLOT_TAG.SEA
		})
	end)
end

function slot0.RefreshUI(slot0)
	slot1, slot2 = ActivityTools.GetActivityChessProgress(ChessConst.SUBPLOT_TAG.ISLAND)
	slot0.exploreText_.text = string.format("%d%%", math.floor(slot1 / slot2))

	if slot0.unLockSideStoryState_ then
		slot0.plotController_:SetSelectedState("on")
	else
		slot0.plotController_:SetSelectedState("off")
	end

	if slot0.unLockChipLogState_ then
		slot0.chessController_:SetSelectedState("on")
	else
		slot0.chessController_:SetSelectedState("off")
	end
end

return slot0
