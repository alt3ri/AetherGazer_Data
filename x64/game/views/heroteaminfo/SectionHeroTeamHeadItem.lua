slot1 = class("SectionHeroTeamHeadItem", import("game.views.newHero.HeroLongHead"))

function slot1.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot2 = slot1

	slot0:InitProxy()

	slot0.gameObject_ = slot0.realGo_
	slot0.transform_ = slot0.realGo_.transform

	slot0:Init()

	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
end

function slot1.InitProxy(slot0)
	slot0:BindCfgUI()

	slot0.sectionLockTypeController_ = slot0.sectionController_:GetController("sectionLockType")
	slot0.sectionTeamMarkBgStyleController_ = slot0.sectionController_:GetController("sectionTeamMarkBgStyle")
	slot0.sectionEnergyController_ = slot0.sectionController_:GetController("sectionEnergy")
	slot0.sectionLockingController_ = slot0.sectionController_:GetController("sectionLocking")
	slot0.sectionHPController_ = slot0.sectionController_:GetController("sectionHP")
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot1.SetSectionHeroData(slot0, slot1)
	slot0.sectionHeroData_ = slot1
	slot2 = slot0.sectionHeroData_.id
	slot3 = slot0.sectionHeroData_.trialID
	slot5 = slot0.sectionHeroData_.heroViewProxy
	slot0.gameObject_.name = tostring(slot2)

	slot0:SetProxy(slot5)
	slot0:SetHeroId(slot2, slot0.sectionHeroData_.type, slot5.tempHeroList)
	slot0:SetRedPointEnable(false)
	slot0:RefreshSectionUI()
end

function slot1.RefreshSectionUI(slot0)
	if slot0.sectionHeroData_.type == HeroConst.HERO_DATA_TYPE.DEFAULT then
		slot0:SetTrial(false)
	elseif slot1 == HeroConst.HERO_DATA_TYPE.TRIAL then
		slot0:SetTrial(true)
	elseif slot1 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		slot0:SetTrial(true)
	elseif slot1 == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
		slot0:SetTrial(false)
	end
end

function slot1.SetEnergy(slot0, slot1, slot2)
	slot0.sectionEnergyController_:SetSelectedState(slot1 and "on" or "off")

	slot0.sectionEnergyLabel_.text = slot2
end

function slot1.SetTeamMarkBg(slot0, slot1)
	slot0.sectionTeamMarkBgStyleController_:SetSelectedState(slot1)
end

function slot1.SetTeamMark(slot0, slot1, slot2)
	SetActive(slot0.sectionTeamMarkGo_, slot1)

	if slot1 then
		slot0.sectionTeamMarkText_.text = GetI18NText(slot2)

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.sectionTeamMarkTransform_)
	end
end

function slot1.SetInTeamFlag(slot0, slot1, slot2)
	SetActive(slot0.sectionTeamMarkGo_, slot1)

	if slot1 then
		if slot2 then
			slot0.sectionTeamMarkText_.text = GetTips("IS_CAPTAIN")
		else
			slot0.sectionTeamMarkText_.text = GetTips("IN_TEAM")
		end
	end
end

function slot1.SetInShowFlag(slot0, slot1)
	SetActive(slot0.sectionTeamMarkGo_, slot1)

	slot0.sectionTeamMarkText_.text = GetTips("DISPLAY")
end

function slot1.SetHeroLock(slot0, slot1)
	slot0:SetLocking(slot1)
end

function slot1.SetHeroLockType(slot0, slot1)
	slot0.sectionLockTypeController_:SetSelectedState(slot1)
end

function slot1.SetHeroLockText(slot0, slot1)
	slot0.sectionLockLabelText_.text = GetI18NText(slot1)
end

function slot1.SetChallengeFlag(slot0, slot1)
	SetActive(slot0.sectionBossChallengeGo_, slot1)
end

function slot1.SetHp(slot0, slot1)
	slot0.sectionHPController_:SetSelectedState(slot1 and "on" or "off")
end

function slot1.RefreshHpValue(slot0, slot1)
	slot0.sectionHPImg_.fillAmount = slot1 / 100
	slot0.sectionHPText_.text = slot1 .. "%"
end

function slot1.SetLocking(slot0, slot1)
	slot0.sectionLockingController_:SetSelectedState(slot1 and "on" or "off")
end

function slot1.SetTrial(slot0, slot1)
	slot0.trialController_:SetSelectedState(tostring(slot1))
end

function slot1.SetSoloChallengeIndex(slot0, slot1)
	if slot1 ~= -1 then
		SetActive(slot0.sectionTeamMarkGo_, false)
		SetActive(slot0.sectionTeamOrderGo_, true)

		slot0.sectionTeamOrderText_.text = GetTips(string.format("TEAM_%d", slot1))
	else
		SetActive(slot0.teamOrder_, false)
	end
end

return slot1
