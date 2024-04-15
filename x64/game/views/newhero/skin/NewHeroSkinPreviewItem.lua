slot0 = class("NewHeroSkinPreviewItem", NewHeroSkinItem)

function slot0.SkinState(slot0)
	if slot0:isUnlock(slot0.skinID_) then
		if HeroTools.GetHeroIsUnlock(SkinCfg[slot0.skinID_].hero) == false and slot0.skinID_ == SkinCfg[slot0.skinID_].hero then
			return 7
		end

		return 8
	else
		if HeroTools.CanChangeSkin(slot0.skinID_) then
			return 8
		end

		if HeroTools.IsSkinOutOfDate(slot0.skinID_) then
			return 4
		end

		if ShopTools.IsPC() and ShopTools.IsRMB(HeroTools.GetShopIdBySkinId(slot0.skinID_)) then
			return 12
		end

		return 3
	end
end

return slot0
