slot0 = class("CanteenHeroItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.clickFlag = slot2

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.fatigueController = ControllerUtil.GetController(slot0.transform_, "fatigue")
	slot0.selController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.jobController = ControllerUtil.GetController(slot0.transform_, "work")
	slot0.skillController = ControllerUtil.GetController(slot0.transform_, "skill")
	slot0.sameNameController = ControllerUtil.GetController(slot0.transform_, "sameName")
end

function slot0.SetFunction(slot0, slot1)
	slot0.showWork = slot1
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.heroitemBtn_, nil, function ()
		if uv0.selFunc then
			uv0.selFunc(uv0.heroID)
		end
	end)
end

function slot0.ResetCharacterCallBack(slot0, slot1)
	if slot1 then
		slot0.selFunc = slot1
	end
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot0.heroID = slot1

	if DormNpcTools:CheckIDIsNpc(slot1) then
		slot0:RefreshNpcInfo(slot1, slot2, slot3)
	else
		slot0:RefreshHeroInfo(slot1, slot2, slot3)
	end
end

function slot0.RefreshHeroInfo(slot0, slot1, slot2, slot3)
	slot0.heroIcon_.sprite = DormHeroTools.GetBackHomeHeadSprite(slot1)
	slot0.heroitemBtn_.interactable = true
	slot4 = DormData:GetHeroFatigue(slot1)
	slot0.curText_.text = slot4
	slot0.maxText_.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
	slot0.progressImg_.fillAmount = 1 - math.min(slot4 / GameSetting.canteen_hero_fatigue_max.value[1], 1)

	if slot4 <= GameDisplayCfg.dorm_hero_fatigue_level.value[1] then
		slot0.fatigueController:SetSelectedState("lack")
	elseif slot5[1] < slot4 and slot4 <= slot5[2] then
		slot0.fatigueController:SetSelectedState("middle")
	else
		slot0.fatigueController:SetSelectedState("full")
	end

	slot6 = DormData:GetHeroTemplateInfo(slot1)

	slot0.jobController:SetSelectedState("false")

	if not slot0.showWork then
		if slot6.jobType then
			slot0.jobController:SetSelectedState("true")

			slot0.jobText_.text = GetI18NText(CanteenTools:GetJobName(slot7))

			if slot6.hero_id ~= slot1 then
				slot0.selController:SetSelectedState("no")
			end
		elseif CanteenEntrustData:CheckHasChooseEntrustCharacter(slot1) then
			slot0.jobController:SetSelectedState("true")

			slot0.jobText_.text = GetTips("DORM_HERO_AT_TASK")
		end
	end

	if #DormSkillData:CheckSkillCanOpen(slot3, slot1) > 0 then
		slot0.iconImg_.sprite = CanteenTools.GetCanteenSkillSprite(slot7[1])

		slot0.skillController:SetSelectedState("true")
	else
		slot0.skillController:SetSelectedState("false")
	end

	if CanteenEntrustData:CheckHasChooseEntrustCharacter(slot1) then
		slot0.selController:SetSelectedState("no")

		slot0.heroitemBtn_.interactable = false

		return
	end

	slot8 = nil

	if slot2 and not DormNpcTools:CheckIDIsNpc(slot2) then
		slot8 = HeroRecordCfg.get_id_list_by_hero_id[slot2][1]
	end

	slot0.archiveID = HeroRecordCfg.get_id_list_by_hero_id[slot1][1]

	slot0.sameNameController:SetSelectedState("false")

	if slot2 == slot1 then
		slot0.selController:SetSelectedState("sel")
	elseif slot0.archiveID == slot8 then
		if not slot6.jobType then
			slot0.sameNameController:SetSelectedState("true")
		end
	else
		slot0.selController:SetSelectedState("normal")
	end

	if slot6.jobType and slot6.hero_id ~= slot1 then
		slot0.selController:SetSelectedState("no")

		slot0.heroitemBtn_.interactable = false
	end
end

function slot0.RefreshNpcInfo(slot0, slot1, slot2, slot3)
	slot0.heroIcon_.sprite = DormNpcTools:GetNpcHeadSprite(slot1)

	if DormNpcTools:GetNpcFatigue(slot1) < 0 then
		slot0.fatigueController:SetSelectedState("infinite")
	end

	if #DormSkillData:CheckSkillCanOpen(slot3, slot1) > 0 then
		slot0.iconImg_.sprite = CanteenTools.GetCanteenSkillSprite(slot5[1])

		slot0.skillController:SetSelectedState("true")
	else
		slot0.skillController:SetSelectedState("false")
	end

	if slot2 == slot1 then
		slot0.selController:SetSelectedState("sel")
	else
		slot0.selController:SetSelectedState("normal")
	end

	if not slot0.showWork then
		if BackHomeNpcData:GetNpcInfoById(slot1).jobType then
			slot0.jobController:SetSelectedState("true")

			slot0.jobText_.text = CanteenTools:GetJobName(slot7)
		else
			slot0.jobController:SetSelectedState("false")
		end
	else
		slot0.jobController:SetSelectedState("false")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
