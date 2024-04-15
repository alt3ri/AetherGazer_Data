slot0 = class("PolyhedronHeroPropertyPage", HeroPropertyPage)

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.lockController_ = slot0.controller_:GetController("lock")
	slot0.favoriteController_ = slot0.favorBtnController_:GetController("follow")
	slot0.favoriteShowController_ = slot0.favorBtnController_:GetController("favor")
	slot0.detailController_ = slot0.heroInfoController_:GetController("detail")
	slot0.heroInfoView_ = PolyhedronHeroInfoView.New(slot0, slot0.infoViewGo_)
end

function slot0.CheckLocked(slot0)
	slot0.lockController_:SetSelectedState("true")
end

return slot0
