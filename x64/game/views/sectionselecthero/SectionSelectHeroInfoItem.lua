slot0 = class("SectionSelectHeroInfoItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.pos_ = slot2

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.postController_ = slot0.controllerExCollection_:GetController("post")
	slot0.emptyController_ = slot0.controllerExCollection_:GetController("empty")
	slot0.hpController_ = slot0.controllerExCollection_:GetController("HP")
	slot0.assistantController_ = slot0.controllerExCollection_:GetController("assistant")
	slot0.powerController_ = slot0.controllerExCollection_:GetController("power")
	slot0.energyController_ = slot0.controllerExCollection_:GetController("energy")
end

function slot0.Dispose(slot0)
	slot0.stateComtroller_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.SetProxy(slot0, slot1)
	slot0.sectionProxy_ = slot1
end

function slot0.OnEnter(slot0, slot1)
	slot0:BindRedPoint()

	if GameObject.Find(string.format("X104/X104_SceneSteps/X104_Formation_HeroPos_%s", slot1)) then
		slot0.stateComtroller_ = slot2:GetComponent("ControllerExCollection"):GetController("state")
	end
end

function slot0.OnExit(slot0)
	slot0:UnBindRedPoint()
end

function slot0.SetData(slot0, slot1)
	slot0.pos_ = slot1
	slot0.isCaptain_ = slot1 == 1
	slot0.heroID_ = slot0.sectionProxy_.heroInfoList[slot0.pos_].heroID
	slot0.trialID_ = slot0.sectionProxy_.heroInfoList[slot0.pos_].trialID
	slot0.isLock_ = slot0.sectionProxy_.heroInfoList[slot0.pos_].isLock

	slot0:RefreshUI()
	slot0:RefreshCustomUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshAddBtn()

	if not slot0.heroID_ or slot0.heroID_ == 0 then
		slot0.emptyController_:SetSelectedState("true")

		return
	else
		slot0.emptyController_:SetSelectedState("false")
	end

	slot0:RefershPower()
	slot0:RefreshRace()
	slot0:RefreshPost()
	slot0:RefreshAttackType()
	slot0:RefreshHP()
	slot0:RefreshAssistant()
	slot0:RefreshEnergy()
end

function slot0.RefreshCustomUI(slot0)
end

function slot0.RefershPower(slot0)
	slot0.powerController_:SetSelectedState(tostring(slot0.sectionProxy_.needHeroPower))

	if slot0.sectionProxy_.needHeroPower then
		slot0:RefreshPowerUI()
	end
end

function slot0.RefreshPowerUI(slot0)
	slot0.powerText_.text = slot0:GetHeroPower()
end

function slot0.RefreshRace(slot0)
	slot0.raceIcon_.sprite = HeroTools.GetHeroRaceIcon(slot0.heroID_)
end

function slot0.RefreshPost(slot0)
	slot0.postController_:SetSelectedState(tostring(slot0.isCaptain_))
end

function slot0.RefreshAttackType(slot0)
	if HeroTools.GetHeroSkillAttributeIcon(slot0.heroID_) then
		SetActive(slot0.attackTypeIcon_.gameObject, true)

		slot0.attackTypeIcon_.sprite = slot1
	else
		SetActive(slot0.attackTypeIcon_.gameObject, false)
	end
end

function slot0.RefreshAddBtn(slot0)
	if slot0.stateComtroller_ then
		if slot0.heroID_ and slot0.heroID_ ~= 0 then
			slot0.stateComtroller_:SetSelectedState("selected")
		elseif slot0.isLock_ == true or not slot0.sectionProxy_.canChangeTeam then
			slot0.stateComtroller_:SetSelectedState("lock")
		else
			slot0.stateComtroller_:SetSelectedState("empty")
		end
	end
end

function slot0.RefreshHP(slot0)
	slot0.hpController_:SetSelectedState(tostring(slot0.sectionProxy_.needHeroHP))

	if slot0.sectionProxy_.needHeroHP then
		slot0:RefreshHPUI()
	end
end

function slot0.RefreshHPUI(slot0)
	slot1, slot2 = slot0:GetHeroHP()
	slot0.hpImg_.fillAmount = slot2 / 100
	slot0.hpText_.text = slot2 .. "%"
end

function slot0.RefreshAssistant(slot0)
	slot0.assistantController_:SetSelectedState(tostring(slot0.sectionProxy_.needHeroAssistant))

	if slot0.sectionProxy_.needHeroAssistant then
		slot0:RefreshAssistantUI()
	end
end

function slot0.RefreshAssistantUI(slot0)
	slot0.assistantController_:SetSelectedState(tostring(slot0.sectionProxy_.heroInfoList[slot0.pos_].isAssistant))
end

function slot0.RefreshEnergy(slot0)
	slot0.energyController_:SetSelectedState(tostring(slot0.sectionProxy_.needHeroEnergy))

	if slot0.sectionProxy_.needHeroEnergy then
		slot0:RefreshEnergyUI()
	end
end

function slot0.RefreshEnergyUI(slot0)
	if slot0.heroID_ ~= 0 then
		slot0.energyController_:SetSelectedState("true")

		slot0.energyText_.text = slot0:GetHeroEnergy()

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.energyBgTrans_)
	else
		slot0.energyController_:SetSelectedState("false")
	end
end

function slot0.BindRedPoint(slot0)
	slot0.sectionProxy_:CustomHeroBindRedPoint(slot0.pos_, slot0)
end

function slot0.UnBindRedPoint(slot0)
	slot0.sectionProxy_:CustomHeroUnBindRedPoint(slot0.pos_, slot0)
end

function slot0.GetHeroPower(slot0)
	return slot0.sectionProxy_:CustomGetHeroPower(slot0.pos_, slot0.heroID_, slot0.trialID_)
end

function slot0.GetHeroHP(slot0)
	return slot0.sectionProxy_:CustomGetHeroHP(slot0.pos_, slot0.heroID_, slot0.trialID_)
end

function slot0.GetHeroEnergy(slot0)
	return slot0.sectionProxy_:CustomGetHeroEnergy(slot0.pos_, slot0.heroID_, slot0.trialID_)
end

return slot0
