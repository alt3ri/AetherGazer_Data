slot0 = class("PolyhedronHeroInfoView", HeroInfoView)

function slot0.UpdateView(slot0)
	slot0.nameText_.text = GetI18NText(slot0.heroCfg_.name)
	slot0.subNameText_.text = GetI18NText(slot0.heroCfg_.suffix)
	slot2 = PolyhedronData:GetPolyhedronHeroUnlock(slot0.heroInfo_.id)

	slot0.lockController_:SetSelectedState(tostring(not (HeroData:GetHeroData(slot0.heroInfo_.id).unlock == 1)))
	slot0.isSelfController_:SetSelectedState(tostring(not slot0.heroViewProxy_.isSelf))

	slot0.campLogo_.sprite = HeroTools.GetRaceIcon(slot0.heroCfg_.race)
	slot0.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(slot0.heroCfg_.id)
	slot0.rangeTypeText_.text = CharactorParamCfg[slot0.heroInfo_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")

	if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS) == 0 then
		slot0.polyhedronCurrencyText_.text = "<color=#FF0000> 1 </color>"
	else
		slot0.polyhedronCurrencyText_.text = "1"
	end

	slot0.polyhedronDesText_.text = HeroCfg[slot0.heroInfo_.id].hero_desc

	slot0:RefreshChargeType()
	slot0.polyhedronController_:SetSelectedState(tostring(not slot2))

	if slot0.heroInfo_.unlock == 0 then
		slot0:UpdateLockedView()
	else
		slot0:UpdateUnlockedView()

		if slot0.type_ == HeroConst.HERO_DATA_TYPE.DEFAULT then
			ArchiveAction.CheckAllRelationRedPoint(slot0.heroCfg_.id)
		end
	end
end

function slot0.AddUIListener(slot0)
	uv0.super.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.polyhedronUnlockBtn_, nil, function ()
		PolyhedronAction.QueryUnlockHero(uv0.heroCfg_.id)
	end)
end

function slot0.UpdateUnlockBtnState(slot0)
	slot0.levelStateController_:SetSelectedState("none")
end

function slot0.GetHeroPiece(slot0)
	return HeroData:GetHeroData(slot0.heroInfo_.id).piece
end

return slot0
