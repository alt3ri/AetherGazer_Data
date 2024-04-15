slot0 = class("PolyhedronHeroView", HeroView)

function slot0.OnTop(slot0)
	uv0.super.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS, true)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
end

function slot0.InitHeroHeadList(slot0)
	slot0.shortScrollHelper_ = LuaList.New(handler(slot0, slot0.ShortHeadRenderer), slot0.heroShortListGo_, PolyhedronHeroShortHead)
	slot0.completeScrollHelper_ = LuaList.New(handler(slot0, slot0.LongHeadRenderer), slot0.heroCompleteListGo_, PolyhedronHeroLongHead)
end

function slot0.SelectHero(slot0, slot1)
	uv0.super.SelectHero(slot0, slot1)

	slot5 = slot1

	PolyhedronData:SetHeroClicked(slot5)

	slot4 = slot0.curScrollHelper_
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetItemList(slot6)) do
		slot6:SetRedPoint()
	end
end

function slot0.GetCurHeroInfo(slot0, slot1)
	return slot0.heroViewProxy_:GetHeroData(slot1)
end

function slot0.OnPolyhedronHeroUnlock(slot0)
	slot0.filterView_:SetHeroIdList(slot0.heroIdList_, slot0.type_)
	slot0.curScrollHelper_:Refresh()
	slot0:CheckLocked()
	slot0:UpdateHeroView()
	slot0.pages_[slot0.curPageIndex_]:UpdateView()
end

return slot0
