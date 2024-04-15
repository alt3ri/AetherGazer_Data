ChapterVariantBaseView = import("game.views.chapterVariant.base.ChapterVariantBaseView")
slot0 = class("ChapterVariant16View", ChapterVariantBaseView)

function slot0.UIName(slot0)
	return "UI/Stage/ChaptePlot/JapanRegionMainUI"
end

function slot0.GetItemClass(slot0)
	return ChapterVariant16Item
end

return slot0
