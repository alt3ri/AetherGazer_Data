ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("ActivityChapterPageView", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return ActivityChapterPageCfg[slot0.activityID_].prefab_path
end

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	if slot0.videoGo_ then
		slot0.criManaExMultipleVedio_ = slot0.videoGo_.transform:GetComponent(typeof(CriManaExMultipleVedio))
	end
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.chapterBtn_.transform, ActivityTools.GetRedPointKey(slot0.activityID_) .. slot0.activityID_)

	if slot0.videoGo_ and ActivityVersionData:GetFirstEnterActivityFlag(slot0.activityID_) then
		slot0.criManaExMultipleVedio_:PlayByIndex(1)
	end

	ActivityVersionData:SetFirstEnterActivityFlag(slot0.activityID_)
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.chapterBtn_.transform, ActivityTools.GetRedPointKey(slot0.activityID_) .. slot0.activityID_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.chapterBtn_, nil, function ()
		if not uv0:IsActivityTime() then
			return
		end

		slot0 = ActivityChapterPageCfg[uv0.activityID_]

		if slot0.chapter_type == 1 then
			if ChapterTools.IsFinishPreChapter(ChapterTools.GetChapterIDByClient(slot0.chapter_client_id)) then
				ChapterTools.GotoChapterSection(slot2)

				return
			end

			ShowTips("TIME_OVER")
		else
			JumpTools.Jump2SubPlot(slot1, nil, true)
		end
	end)
end

return slot0
