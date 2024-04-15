ChapterVariantBaseItem = import("game.views.chapterVariant.base.ChapterVariantBaseItem")
slot0 = class("ChapterVariantEmptyDreamItem", ChapterVariantBaseItem)

function slot0.RefreshControllerState(slot0)
	if slot0.isLock_ or slot0.chapterID_ == 11112 and not SkuldTravelData:IsCollectAllPhoto() then
		slot0.controller_:SetSelectedState("lock")
	else
		slot0.controller_:SetSelectedState("normal")
	end
end

return slot0
