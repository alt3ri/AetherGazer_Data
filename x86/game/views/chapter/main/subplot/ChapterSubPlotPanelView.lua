slot0 = class("ChapterSubPlotPanelView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "lock")
end

function slot0.OnEnter(slot0)
	slot0.isLock_ = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT)

	manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.COMBAT_SUB_PLOT)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, RedPointConst.COMBAT_SUB_PLOT)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		JumpTools.GoToSystem("/chapterSubPlotContent", {}, ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT)
	end)
end

function slot0.RefreshUI(slot0)
	slot2 = ChapterClientCfg[ChapterTools.GetOpenSubPlotClient()]

	getSpriteWithoutAtlasAsync(SpritePathCfg.ChapterPaint.path .. slot2.chapter_paint_2, function (slot0)
		if uv0.chapterImage_ then
			uv0.chapterImage_.sprite = slot0
		end
	end)

	slot0.chapterNameText_.text = slot2.name
	slot0.chapterDescText_.text = slot2.desc

	slot0:RefreshLockState()

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT) then
		slot0.lockText_.text = JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT, slot4)
	end
end

function slot0.RefreshLockState(slot0)
	if slot0.isLock_ then
		slot0.controller_:SetSelectedState("true")
	else
		slot0.controller_:SetSelectedState("false")
	end
end

return slot0
