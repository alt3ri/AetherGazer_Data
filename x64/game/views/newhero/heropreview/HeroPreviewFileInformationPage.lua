slot0 = class("HeroPreviewFileInformationPage", HeroFileInformationPage)

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListeners()

	slot0.curHeroID_ = 0
	slot0.curRecordID_ = 0
	slot0.relationNetController_ = slot0.rightControllerEx_:GetController("relationNet")
	slot0.lockController_ = slot0.controller_:GetController("lock")
end

function slot0.AddBtnListeners(slot0)
	slot0:AddBtnListener(slot0.portraitBtn_, nil, function ()
		uv0:Go("heroPortrait", {
			heroID = uv0.curHeroID_
		})
	end)
	slot0:AddBtnListener(slot0.poltBtn_, nil, function ()
		if ObtainHeroMovieCfg[uv0.curHeroID_] then
			uv0:Go("/heroMovieReplay", {
				heroID = uv0.curHeroID_
			})
		end
	end)
end

function slot0.Show(slot0, slot1, slot2)
	if slot2 ~= slot0.curHeroID_ then
		slot3 = HeroCfg[slot2]
		slot0.heroCfg_ = slot3
		slot0.lableText_.text = GetI18NText(slot3.name)
		slot0.summaryText_.text = GetI18NText(slot3.hero_desc)
		slot0.campImg_.sprite = HeroTools.GetRaceIcon(slot3.race)
		slot0.attackTypeImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(slot0.heroCfg_.id)

		slot0:RefreshChargeType()

		slot0.rareImg_.sprite = getSprite("Atlas/Common", "star_" .. slot3.rare)
		slot0.rangeTypeText_.text = CharactorParamCfg[slot0.heroCfg_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
		slot0.lockSummaryText_.text = GetI18NText(slot3.hero_desc)
		slot0.curHeroID_ = slot2
	end

	if slot1 ~= slot0.curRecordID_ then
		slot3 = HeroRecordCfg[slot1]
		slot0.nameText_.text = GetI18NText(slot3.name)
		slot0.heightText_.text = GetI18NText(slot3.height)
		slot0.weightText_.text = GetI18NText(slot3.weight)
		slot0.birthdayText_.text = GetI18NText(slot3.birthday)
		slot0.organizationText_.text = GetI18NText(slot3.organization)
		slot0.hobbyText_.text = GetI18NText(slot3.like)
		slot0.curRecordID_ = slot1
	end

	manager.redPoint:bindUIandKey(slot0.relationBtn_.transform, string.format("%s_%s", RedPointConst.HERO_REALTION, slot0.curHeroID_))
	slot0.lockController_:SetSelectedState(tostring(HeroData:GetHeroData(slot2).unlock ~= 1))

	slot0.scroll_.enabled = false
	slot0.scroll_.enabled = true

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.summaryContent_)
	slot0.relationNetController_:SetSelectedState("lock")
	SetActive(slot0.poltBtn_.gameObject, ObtainHeroMovieCfg[slot0.curHeroID_] ~= nil)
	SetActive(slot0.gameObject_, true)
end

function slot0.UpdateView(slot0, slot1, slot2)
	uv0.super.UpdateView(slot0, slot1, slot2)
	slot0.relationNetController_:SetSelectedState("lock")
end

function slot0.RefreshChargeType(slot0)
	if slot0.heroCfg_.mechanism_type[1] == HeroConst.HERO_CHARGE_TYPE.RAGE then
		slot0.chargeTypeText_.text = GetTips("NOTE_ENERGYTYPE_1")
	elseif slot1 == HeroConst.HERO_CHARGE_TYPE.ENERGY then
		slot0.chargeTypeText_.text = GetTips("NOTE_ENERGYTYPE_2")
	elseif slot1 == HeroConst.HERO_CHARGE_TYPE.TRACES then
		slot0.chargeTypeText_.text = GetTips("NOTE_ENERGYTYPE_3")
	elseif slot1 == HeroConst.HERO_CHARGE_TYPE.DIVINE_GRACE then
		slot0.chargeTypeText_.text = GetTips("NOTE_ENERGYTYPE_4")
	end
end

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		0,
		1
	}, slot0.displayGo_)
end

return slot0
