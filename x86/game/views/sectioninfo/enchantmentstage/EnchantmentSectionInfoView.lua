slot0 = class("EnchantmentSectionInfoView", import("..SectionInfoMultipleBaseView"))

function slot0.Init(slot0)
	uv0.super.Init(slot0)
	slot0.hideDropPanelController_:SetSelectedState("false")
	slot0.hideBattleAffixController_:SetSelectedState("false")
end

function slot0.OnClickBtn(slot0)
	slot0:Go("/sectionSelectHero", {
		section = slot0.stageID_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT,
		multiple = slot0.multiple_
	})
end

function slot0.RefreshData(slot0)
	slot1 = BattleEnchantmentStageCfg[slot0.stageID_]
	slot0.lock_ = false
	slot0.lockTips_ = ""
	slot0.cost_ = slot1.cost
	slot0.dropLibID_ = slot1.drop_lib_id
	slot0.isFirstClear_ = true

	uv0.super.RefreshData(slot0)
end

function slot0.RefreshUI(slot0)
	uv0.super.RefreshUI(slot0)
	slot0:RefreshBattleAffix()
	SetActive(slot0.affixInfoTrs_.gameObject, false)
end

function slot0.AddListeners(slot0)
	uv0.super.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buffAffixBtn_, nil, function ()
		uv0:ShowAffixInfo(uv0.buffAffixBtn_.transform, uv0.buff_[1])
	end)
	slot0:AddBtnListener(slot0.debuffAffixBtn_, nil, function ()
		uv0:ShowAffixInfo(uv0.debuffAffixBtn_.transform, uv0.debuff_[1])
	end)
end

function slot0.RemoveListeners(slot0)
	uv0.super.RemoveListeners(slot0)
	slot0.buffAffixBtn_.onClick:RemoveAllListeners()
	slot0.debuffAffixBtn_.onClick:RemoveAllListeners()
end

function slot0.RefreshRewardItem(slot0, slot1, slot2)
	slot4 = nil

	if slot0.rewardList_[slot1] then
		slot4 = rewardToItemTemplate(slot3)
		slot4.number = nil

		function slot4.clickFun(slot0)
			ShowPopItem(POP_ITEM, slot0)
		end
	end

	slot2:SetData(slot4)
end

function slot0.RefreshStageInfo(slot0)
	slot1 = BattleEnchantmentStageCfg[slot0.stageID_]
	slot0.sectionName_.text = GetI18NText(slot1.name)
	slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot1.background_1))
end

function slot0.RefreshBattleAffix(slot0)
	slot0.buff_ = getHeroAffixs(BattleEnchantmentStageCfg[slot0.stageID_].affix_type)
	slot0.debuff_ = BattleEnchantmentStageCfg[slot0.stageID_].affix_type_in_map == "" and getMosterAffix(BattleEnchantmentStageCfg[slot0.stageID_].affix_type) or BattleEnchantmentStageCfg[slot0.stageID_].affix_type_in_map

	if slot0.buff_ and slot0.buff_ ~= "" and slot0.buff_[1] then
		slot0.buffAffixText_.text = GetI18NText(getAffixName(slot0.buff_[1]))
		slot0.buffAffixImg_.sprite = getAffixSprite(slot0.buff_[1])
	else
		slot0.buffAffixText_.text = ""
		slot0.buffAffixImg_.sprite = nil
	end

	if slot0.debuff_ and slot0.debuff_ ~= "" and slot0.debuff_[1] then
		slot0.debuffAffixText_.text = GetI18NText(getAffixName(slot0.debuff_[1]))
		slot0.debuffAffixImg_.sprite = getAffixSprite(slot0.debuff_[1])
	else
		slot0.debuffAffixText_.text = ""
		slot0.debuffAffixImg_.sprite = nil
	end
end

function slot0.ShowAffixInfo(slot0, slot1, slot2)
	slot0.affixInfoTrs_:SetParent(slot1)

	slot0.affixInfoTrs_.localPosition = Vector3(0, 0, 0)

	SetActive(slot0.affixInfoTrs_.gameObject, true)

	if slot2 and slot2 ~= "" then
		slot0.affixContentText_.text = GetI18NText(getAffixDesc(slot2))
		slot0.affixTitleText_.text = GetI18NText(getAffixName(slot2))
	else
		slot0.affixContentText_.text = ""
		slot0.affixTitleText_.text = ""
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.affixInfoTrs_)

	if slot0.countdownTimer_ then
		slot0.countdownTimer_:Stop()

		slot0.countdownTimer_ = nil
	end

	slot0.countdownTimer_ = Timer.New(function ()
		if uv0.affixInfoTrs_ and uv0.affixInfoTrs_.gameObject then
			SetActive(uv0.affixInfoTrs_.gameObject, false)
		end
	end, 2, 1)

	slot0.countdownTimer_:Start()
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)

	if slot0.countdownTimer_ then
		slot0.countdownTimer_:Stop()

		slot0.countdownTimer_ = nil
	end
end

return slot0
