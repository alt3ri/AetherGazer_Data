slot1 = class("NewGuildBossAssistantHeadItemView", import("game.views.heroTeamInfo.SectionHeroTeamHeadItem"))

function slot1.InitProxy(slot0)
	uv0.super.InitProxy(slot0)

	slot0.positionController_ = ControllerUtil.GetController(slot0.transform_, "position")
end

function slot1.SetSectionHeroData(slot0, slot1)
	slot0.assistantData_ = slot1
	slot2 = slot0.assistantData_.assist_hero_id
	slot0.gameObject_.name = tostring(slot2)

	slot0:SetHeroData(slot2)
	slot0:SetRedPointEnable(false)
end

function slot1.SetHeroId(slot0, slot1)
	slot0:SetHeroData(slot1)
end

function slot1.SetHeroData(slot0, slot1)
	slot0.heroId_ = slot1
	slot0.trialID_ = 0
	slot0.heroCfg_ = HeroCfg[slot1]

	slot0:UpdateView()
end

function slot1.UpdateView(slot0)
	slot1 = HeroCfg[slot0.heroId_]
	slot2 = nil
	slot0.headIcon_.sprite = HeroTools.GetHeadSprite((slot0.assistantData_.assist_hero_skin == 0 or slot0.assistantData_.assist_hero_skin) and slot0.heroId_)

	slot0.headIcon_:SetNativeSize()

	slot0.campLogo_.sprite = HeroTools.GetRaceIcon(slot1.race)
	slot0.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(slot0.heroId_)
	slot0.rareImg_.sprite = HeroTools.GetRareSprite(slot1.rare)

	slot0:SetLevel(slot0.assistantData_.hero_level or 1)

	slot0.nickLabel_.text = GetI18NText(slot0.assistantData_.nick)
	slot0.fightPowerLabel_.text = slot0.assistantData_.fight_capacity

	slot0.positionController_:SetSelectedState(tostring(slot0.assistantData_.member_post))

	if tostring(slot0.assistantData_.member_post) == "1" then
		slot0.clubMemberLabel_.text = GetTips("CLUB_CHAIR_MAN")
	elseif tostring(slot0.assistantData_.member_post) == "2" then
		slot0.clubMemberLabel_.text = GetTips("CLUB_VICE_CHAIR_MAN")
	elseif tostring(slot0.assistantData_.member_post) == "3" then
		slot0.clubMemberLabel_.text = GetTips("CLUB_MEMBER")
	elseif tostring(slot0.assistantData_.member_post) == "4" then
		slot0.clubMemberLabel_.text = GetTips("CLUB_NOVICIATE")
	end
end

function slot1.GetHeroId(slot0)
	return slot0.assistantData_.assist_hero_id
end

function slot1.GetOwnerId(slot0)
	return slot0.assistantData_.member_id
end

function slot1.SetSelected(slot0, slot1)
	SetActive(slot0.sectionSelectGo_, slot1 == true)
end

return slot1
