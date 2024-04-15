slot0 = class("KagutsuchiAffixMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionWorkUI/JapanRegionWorkTalentUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.talentIdList_ = KagutsuchiTalentData:GetTalentIdList()

	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.upBtnController_ = ControllerUtil.GetController(slot0.upgradeTrs_, "button")
	slot4 = "text"
	slot0.upTxtController_ = ControllerUtil.GetController(slot0.upgradeTrs_, slot4)

	for slot4 = 1, #slot0.talentIdList_ do
		if slot0[string.format("talent%dBtn_", slot4)] then
			slot0[string.format("lock%dController_", slot4)] = ControllerUtil.GetController(slot5.transform, "lock")
		end
	end

	slot0.rightLockController_ = ControllerUtil.GetController(slot0.rightIconTrs_, "lock")
end

function slot0.AddUIListener(slot0)
	for slot4 = 1, #slot0.talentIdList_ do
		if slot0[string.format("talent%dBtn_", slot4)] then
			slot0:AddBtnListener(slot5, nil, function ()
				uv0:SelectItem(uv1)
			end)
		end
	end

	slot0:AddBtnListener(slot0.upBtn_, nil, function ()
		uv0:UpgradeTalent()
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.currentIndex_ = -1

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	AnimatorTools.Stop()
end

function slot0.RefreshUI(slot0)
	for slot4, slot5 in ipairs(slot0.talentIdList_) do
		slot0:RefreshItem(slot4, slot5)

		if slot0[string.format("select%dGo_", slot4)] then
			SetActive(slot6, false)
		end
	end

	slot0:SelectItem(1)
	SetActive(slot0.upEffectGo_, false)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot3 = TalentTreeCfg[slot2]
	slot5 = KagutsuchiTalentData:GetTalentLevel(slot2) == KagutsuchiTalentData:GetTalentMaxLevel(slot2)

	if slot0[string.format("lock%dGo_", slot1)] then
		SetActive(slot7, KagutsuchiTalentData:IsTalentLocked(slot2))
	end

	if slot0[string.format("select%dGo_", slot1)] then
		SetActive(slot8, true)
	end

	if slot0[string.format("max%dGo_", slot1)] then
		SetActive(slot9, slot5)
	end

	if slot0[string.format("level%dText_", slot1)] then
		if slot5 or slot6 then
			slot10.text = ""
		else
			slot10.text = string.format("LV.%d", slot4)
		end
	end

	if slot0[string.format("name%dText_", slot1)] then
		slot11.text = getAffixName({
			slot3.affix_id,
			1
		})
	end

	slot0[string.format("lock%dController_", slot1)]:SetSelectedState(slot6 and "yes" or "no")

	if slot0[string.format("talent%dIcon_", slot1)] then
		-- Nothing
	end

	slot0:RefreshRightPanel(slot2, slot1)
end

function slot0.RefreshRightPanel(slot0, slot1, slot2)
	slot0.rightNameText_.text = getAffixName({
		TalentTreeCfg[slot1].affix_id,
		1
	})
	slot4 = KagutsuchiTalentData:IsTalentMaxLevel(slot1)
	slot5 = KagutsuchiTalentData:CanUpgrade(slot1)
	slot7 = KagutsuchiTalentData:GetTalentLevel(slot1)

	if KagutsuchiTalentData:IsTalentLocked(slot1) then
		slot7 = 1
	end

	slot0.rightLockController_:SetSelectedState(slot6 and "yes" or "no")

	if slot0[string.format("talent%dIcon_", slot2)] then
		slot0.rightIcon_.sprite = slot8.sprite
	end

	SetActive(slot0.rightLockGo_, slot6)
	SetActive(slot0.rightLevelGo_, not slot6)
	SetActive(slot0.rightMaxGo_, slot4)

	if slot4 then
		SetActive(slot0.rightLevelGo_, false)
	else
		slot0.rightLevelText_.text = string.format("LV.%d", slot7)
	end

	slot0.rightDescText_.text = getAffixDesc({
		slot3.affix_id,
		slot7
	})

	if slot4 or slot6 then
		SetActive(slot0.rightNextGo_, false)
	else
		slot0.rightNextDescText_.text = getAffixDesc({
			slot3.affix_id,
			slot7 + 1
		})

		SetActive(slot0.rightNextGo_, true)
	end

	slot0:RefreshCondition(slot1, slot6 and slot7 or slot7 + 1)

	if slot5 then
		slot0.upBtnController_:SetSelectedState("yellow")
		slot0.upTxtController_:SetSelectedState(slot6 and "unlock" or "upgrade")
	elseif slot6 then
		slot0.upBtnController_:SetSelectedState("gray")
		slot0.upTxtController_:SetSelectedState("unlock")
	elseif slot4 then
		slot0.upBtnController_:SetSelectedState("black")
		slot0.upTxtController_:SetSelectedState("max")
	else
		slot0.upBtnController_:SetSelectedState("gray")
		slot0.upTxtController_:SetSelectedState(slot6 and "unlock" or "upgrade")
	end
end

function slot0.RefreshCondition(slot0, slot1, slot2)
	slot4 = KagutsuchiTalentData:CanUpgrade(slot1)

	if KagutsuchiTalentData:IsTalentMaxLevel(slot1) then
		SetActive(slot0.unlockGo_, false)

		return
	end

	SetActive(slot0.unlockGo_, true)

	slot6 = ConditionCfg[KagutsuchiTalentData:GetTalentConditionId(slot1, slot2)]
	slot8 = slot6.params

	if slot6.type == 1020 then
		slot9 = HeroConst.Hero_Star
		slot0.rightConditionText_.text = slot6.desc
		slot0.rightProgressText_.text = string.format("(%s/%s)", HeroData:GetHeroData(slot8[1]).unlock == 0 and "-" or slot9[math.floor(slot10.star / 100)], slot9[slot8[2]])
	elseif slot7 == 2510 then
		slot0.rightConditionText_.text = string.format(slot6.desc, slot8[1])
		slot0.rightProgressText_.text = string.format("(%d/%d)", KagutsuchiWorkData:GetTotalCoins(), slot8[1])
	end

	SetActive(slot0.rightCanUpGo_, slot4)
end

function slot0.SelectItem(slot0, slot1)
	if slot0.currentIndex_ == slot1 then
		return
	end

	slot2 = slot0.talentIdList_[slot1]

	if slot0.currentIndex_ and slot0[string.format("select%dGo_", slot0.currentIndex_)] then
		SetActive(slot3, false)
	end

	slot0.currentIndex_ = slot1

	slot0:RefreshItem(slot1, slot2)
end

function slot0.UpgradeTalent(slot0)
	if not KagutsuchiTalentData:CanUpgrade(slot0.talentIdList_[slot0.currentIndex_]) then
		if KagutsuchiTalentData:IsTalentLocked(slot1) then
			ShowTips(string.format(GetTips("NO_REACH_UNLOCK")))
		else
			ShowTips(string.format(GetTips("DORM_CANTEEN_CANT_LEVEL_UP")))
		end

		return
	end

	KagutsuchiTalentAction:UpgradeTalent(slot1, handler(slot0, slot0.OnUpgradeTalent))
end

function slot0.OnUpgradeTalent(slot0, slot1, slot2)
	slot0:RefreshItem(slot0.currentIndex_, slot2.talent_id)
	SetActive(slot0.upEffectGo_, true)
	AnimatorTools.PlayAnimationWithCallback(slot0.upgradeAni_, "JapanRegionWorkTalentUI_saoguang", function ()
		SetActive(uv0.upEffectGo_, false)
	end)
end

return slot0
