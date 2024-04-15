ChapterVariantBaseView = import("game.views.chapterVariant.base.ChapterVariantBaseView")
slot0 = class("ChapterVariantThothView", ChapterVariantBaseView)

function slot0.UIName(slot0)
	return "Widget/System/ChaptePlot/NorseUI_3_0_Plot01UI"
end

function slot0.GetItemClass(slot0)
	return ChapterVariantThothItem
end

return slot0
