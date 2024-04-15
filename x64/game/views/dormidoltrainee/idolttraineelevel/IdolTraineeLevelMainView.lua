slot0 = class("IdolTraineeLevelMainView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/IdolTrainee/IdolBattleLevelView"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.curChapterID_ = 0
	slot0.levelList_ = {}
	slot0.chapterTitleItem_ = IdolTraineeChapterListItem.New(slot0.chapter)
	slot0.levelUIList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.levelUIList_, IdolTraineeLevelListItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if uv0.curChapterID_ then
			JumpTools.OpenPageByJump("/idolTraineeChapterRewardView", {
				chapterID = uv0.curChapterID_
			})
		end
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.curChapterID_ = slot0.params_.chapterID
	slot0.levelList_ = IdolTraineeChapterCfg[slot0.curChapterID_].section_id_list

	slot0.chapterTitleItem_:SetData(slot0.curChapterID_, true)
	slot0.levelUIList_:StartScroll(#slot0.levelList_)

	slot0.titleText_.text = IdolTraineeChapterCfg[slot0.curChapterID_].title

	manager.redPoint:bindUIandKey(slot0.redpointTrs_, string.format("%s_%s", RedPointConst.IDOL_TRAINEE_CHAPTER_TASK, slot0.curChapterID_))
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(slot0.redpointTrs_, string.format("%s_%s", RedPointConst.IDOL_TRAINEE_CHAPTER_TASK, slot0.curChapterID_))
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.levelList_[slot1], slot1, slot0.curChapterID_)
end

function slot0.Dispose(slot0)
	if slot0.chapterTitleItem_ then
		slot0.chapterTitleItem_:Dispose()

		slot0.chapterTitleItem_ = nil
	end

	slot0.levelUIList_:Dispose()

	slot0.levelUIList_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
