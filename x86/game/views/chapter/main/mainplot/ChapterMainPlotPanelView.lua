slot0 = class("ChapterMainPanelView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "early")
end

function slot0.OnEnter(slot0)
	slot0.showChapterClientID_, slot0.activityID_ = ChapterTools.GetOptimalChapterClientID()

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		JumpTools.GoToSystem("/chapterMapContent")
	end)
end

function slot0.RefreshUI(slot0)
	slot1 = ChapterClientCfg[slot0.showChapterClientID_]

	getSpriteWithoutAtlasAsync(SpritePathCfg.ChapterPaint.path .. slot1.chapter_paint_2, function (slot0)
		if uv0.chapterImage_ then
			uv0.chapterImage_.sprite = slot0
		end
	end)

	slot0.chapterNameText_.text = slot1.name
	slot0.chapterDescText_.text = slot1.desc

	slot0:RefreshActivityState()
end

function slot0.RefreshActivityState(slot0)
	if slot0.activityID_ ~= 0 then
		slot0.controller_:SetSelectedState("yes")
	else
		slot0.controller_:SetSelectedState("no")
	end
end

return slot0
