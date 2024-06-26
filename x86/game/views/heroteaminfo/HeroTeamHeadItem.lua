slot1 = class("HeroTeamHeadItem", import("game.views.newHero.NewHeroHead"))

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)

	if slot0.heroLock1_ then
		slot0.lockTypeController_ = ControllerUtil.GetController(slot0.heroLock1_.transform, "lockType")
	end

	slot0.trialController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "trial")
	slot0.bgStyleController_ = ControllerUtil.GetController(slot0.teamMark_.transform, "bgStyle")
	slot0.energyController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "energy")
	slot0.lockingController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "locking")
	slot0.showAttackTypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "showAttackType")
end

function slot1.SetEnergy(slot0, slot1, slot2)
	slot0.energyController_:SetSelectedState(slot1 and "on" or "off")

	slot0.energyLabel_.text = slot2
end

function slot1.SetTeamMarkBg(slot0, slot1)
	slot0.bgStyleController_:SetSelectedState(slot1)
end

function slot1.SetTeamMark(slot0, slot1, slot2)
	SetActive(slot0.teamMark_, slot1)

	if slot1 then
		slot0.teamMarkText_.text = GetI18NText(slot2)
	end
end

function slot1.SetInTeamFlag(slot0, slot1, slot2)
	SetActive(slot0.teamMark_, slot1)

	if slot1 then
		if slot2 then
			slot0.teamMarkText_.text = GetTips("IS_CAPTAIN")
		else
			slot0.teamMarkText_.text = GetTips("IN_TEAM")
		end
	end
end

function slot1.SetInShowFlag(slot0, slot1)
	SetActive(slot0.teamMark_, slot1)

	slot0.teamMarkText_.text = GetTips("DISPLAY")
end

function slot1.SetHeroLock(slot0, slot1)
	SetActive(slot0.heroLock_, slot1)
	SetActive(slot0.heroLock1_, slot1)
end

function slot1.SetHeroLockType(slot0, slot1)
	slot0.lockTypeController_:SetSelectedState(slot1)
end

function slot1.SetHeroLockText(slot0, slot1)
	slot0.heroLockLabel_.text = GetI18NText(slot1)
end

function slot1.SetChallengeFlag(slot0, slot1)
	SetActive(slot0.challenge_, slot1)
end

function slot1.SetHp(slot0, slot1)
	slot0.hpController_:SetSelectedState(slot1 and "show" or "no")
end

function slot1.RefreshHpValue(slot0, slot1)
	slot0.bloodImg_.fillAmount = slot1 / 100
	slot0.hptextText_.text = slot1 .. "%"
end

function slot1.SetLocking(slot0, slot1)
	slot0.lockingController_:SetSelectedState(slot1 and "on" or "off")
end

function slot1.SetTrial(slot0, slot1)
	slot0.trialController_:SetSelectedState(tostring(slot1))
end

function slot1.Dispose(slot0)
	slot0.teamMark_ = nil
	slot0.teamMarkText_ = nil
	slot0.heroLock_ = nil
	slot0.challenge_ = nil

	uv0.super.Dispose(slot0)
end

function slot1.SetSoloChallengeIndex(slot0, slot1)
	if slot1 ~= -1 then
		SetActive(slot0.teamMark_, false)
		SetActive(slot0.teamOrder_, true)

		slot0.teamOrderText_.text = GetTips(string.format("TEAM_%d", slot1))
	else
		SetActive(slot0.teamOrder_, false)
	end
end

function slot1.SetLove(slot0, slot1)
	slot0.loveCon_:SetSelectedState(slot1 and "off" or "on")
end

function slot1.SetShowAttackType(slot0, slot1)
	if not slot0.showAttackTypeController_ then
		return
	end

	if slot1 and HeroCfg[slot0.heroId_] then
		for slot6, slot7 in ipairs(GameDisplayCfg.hero_atack_type_tag.value) do
			if slot7[1] == slot2.ATK_attribute[1] then
				slot0.m_attributeIcon.sprite = getSpriteWithoutAtlas("TextureConfig/HeroIconUI/AttributeIcon/" .. slot7[2])

				break
			end
		end

		slot0.showAttackTypeController_:SetSelectedIndex(1)
	else
		slot0.showAttackTypeController_:SetSelectedIndex(0)
	end
end

return slot1
