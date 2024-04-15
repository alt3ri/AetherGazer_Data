slot0 = class("HardLevelSectionView", import("..HardLevelBaseView"))

function slot0.GetHardLevelItem(slot0)
	return HardLevelSectionItem
end

function slot0.SetData(slot0, slot1, slot2)
	uv0.super.SetData(slot0, slot1)

	slot0.collectPercentage_ = slot2

	slot0:RefreshCollectPercentage()
end

function slot0.RefreshCollectPercentage(slot0)
	slot0.percentageText_.text = string.format("%s%%", math.floor(slot0.collectPercentage_ * 100))
end

return slot0
