slot0 = class("ChapterSelectTitleView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0, slot1)
	if slot0.chapterClientID_ then
		slot0:UnBindRedPoint()
	end

	slot0.chapterClientID_ = slot1

	slot0:BindRedPoint()
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	slot0:UnBindRedPoint()

	slot0.chapterClientID_ = nil
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.BindRedPoint(slot0)
	if ChapterClientCfg[slot0.chapterClientID_].toggle == BattleConst.TOGGLE.PLOT then
		manager.redPoint:bindUIandKey(slot0.redPointTransform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT, slot0.chapterClientID_))
	elseif ChapterClientCfg[slot0.chapterClientID_].toggle == BattleConst.TOGGLE.SUB_PLOT then
		manager.redPoint:bindUIandKey(slot0.redPointTransform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, slot0.chapterClientID_))
	end
end

function slot0.UnBindRedPoint(slot0)
	if ChapterClientCfg[slot0.chapterClientID_].toggle == BattleConst.TOGGLE.PLOT then
		manager.redPoint:unbindUIandKey(slot0.redPointTransform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT, slot0.chapterClientID_))
	elseif ChapterClientCfg[slot0.chapterClientID_].toggle == BattleConst.TOGGLE.SUB_PLOT then
		manager.redPoint:unbindUIandKey(slot0.redPointTransform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, slot0.chapterClientID_))
	end
end

function slot0.RefreshUI(slot0)
	slot1 = slot0.chapterClientID_
	slot2 = ChapterClientCfg[slot1]
	slot0.chapterIndexText_.text = slot2.desc
	slot0.chapterNameText_.text = slot2.name
	slot3 = ChapterTools.GetChapterClientFinishPercentage(slot1)
	slot0.percentageImage_.fillAmount = slot3
	slot0.percentageText_.text = string.format("%s<size=28>%%</size>", math.floor(slot3 * 100))
end

return slot0
