slot0 = class("PolyhedronHeroShortHead", HeroShortHead)

function slot0.GetHeroUnLock(slot0)
	return PolyhedronData:GetPolyhedronHeroUnlock(slot0.heroInfo_.id)
end

function slot0.SetHeroData(slot0, slot1, slot2)
	uv0.super.SetHeroData(slot0, slot1, slot2)

	slot0.headIcon_.sprite = HeroTools.GetHeadSprite(slot0.heroInfo_.using_skin)

	if PolyhedronAction:GetPolyhedronHeroRedPointCount(slot0.heroId_) > 0 then
		manager.redPoint:SetRedPointIndependent(slot0.noticePos_, true)
	else
		manager.redPoint:SetRedPointIndependent(slot0.noticePos_, false)
	end
end

function slot0.SetRedPoint(slot0)
	SetActive(slot0.noticePos_.gameObject, PolyhedronAction:GetPolyhedronHeroRedPointCount(slot0.heroId_) > 0)
end

return slot0
