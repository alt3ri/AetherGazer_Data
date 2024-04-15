slot0 = class("HeroUpgradeView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_arrt/HeroArrtLvupUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

slot1 = 0
slot2 = {}
slot3 = {}

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.tweens_ = {}
	slot0.breakItems_ = {}
	slot0.needIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.addExpController_ = slot0.controller_:GetController("addExp")
	slot0.typeController_ = slot0.controller_:GetController("type")
	slot0.moneyEnoughController_ = slot0.controller_:GetController("moneyEnough")
	slot0.canBreakController_ = slot0.controller_:GetController("canBreak")
	slot0.canLevelUpController_ = slot0.controller_:GetController("canLevelUp")
	slot0.conditionBreakController_ = slot0.conditionController_:GetController("conditionItem")

	slot0:InitMaterialItem()
	slot0:InitPropItem()
end

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		2
	}, false)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		slot0 = false

		for slot4 = 1, #uv0.items_ do
			if uv0.items_[slot4]:GetData().topAmountValue > 0 then
				slot0 = true

				break
			end
		end

		if not slot0 then
			ShowTips("HERO_LEVEL_MATERIAL_NOT_SELECTED")

			return
		end

		if uv0:HaveMaterial() then
			uv0.cutExpForReward_ = uv0.cutExp_

			if #MaterialTools.materialGiveBack(uv0.cutExp_, ItemConst.STR_ITEM.HERO) > 0 then
				JumpTools.OpenPageByJump("materialPreview", {
					content = GetTips("HERO_STRENGTH_EXP_OVERFLOW"),
					OkCallback = function ()
						uv0:SendAddExpToServer()
					end,
					itemList = slot1
				})

				return
			else
				uv0:SendAddExpToServer()
			end
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("NO_HERO_EXP_MATERIAL"),
				OkCallback = function ()
					JumpTools.JumpToPage(ItemCfg[GameSetting.hero_exp_props_id_list.value[1]].source[1])
				end
			})
		end
	end)
	slot0:AddBtnListener(slot0.oneKeyBtn_, nil, function ()
		slot0 = false

		for slot4 = 1, #uv0.items_ do
			if uv0.items_[slot4]:GetData().number > 0 then
				slot0 = true

				break
			end
		end

		if uv0:HaveMaterial() and slot0 then
			uv0:OnKeyLevelUp()
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("NO_HERO_EXP_MATERIAL"),
				OkCallback = function ()
					JumpTools.JumpToPage(ItemCfg[GameSetting.hero_exp_props_id_list.value[1]].source[1])
				end
			})
		end
	end)
	slot0:AddBtnListener(slot0.breakPreviewBtn_, nil, function ()
		JumpTools.OpenPageByJump("heroBreakPreview", {
			heroInfo = uv0.heroInfo_
		})
	end)
	slot0:AddBtnListener(slot0.breakBtn_, nil, function ()
		if uv0.canBreak_ then
			uv0:SendBreakToServer()
		elseif PlayerData:GetPlayerInfo().userLevel < uv0.breakCfg_.user_level then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), uv0.breakCfg_.user_level))
		elseif not uv0:HaveBreakMaterial() then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")
		elseif not checkGold(uv0.breakCfg_.cost_gold, true) then
			return
		end
	end)
end

function slot0.OnHeroBreak(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		HeroAction.BreakSuccess(slot0.heroInfo_.id, (slot0.heroInfo_.break_level or 0) + 1)
		JumpTools.OpenPageByJump("newBreakSuccess", {
			heroId = slot0.heroInfo_.id,
			breakLevel = slot0.heroInfo_.break_level or 0,
			oldCrit = uv0[HeroConst.HERO_ATTRIBUTE.CRITICAL],
			proxy = slot0.heroViewProxy_
		})

		uv0 = HeroTools.CaculateHeroAttribute(slot0.heroInfo_, slot0.heroViewProxy_:CalHeroEquipAttribute(slot0.heroInfo_.id))
	end
end

function slot0.SendAddExpToServer(slot0)
	uv0 = slot0.heroInfo_.level
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.items_) do
		if slot6:GetData().topAmountValue > 0 then
			table.insert(slot1, {
				id = slot7.id,
				num = slot7.topAmountValue
			})
		end
	end

	HeroAction.AddHeroExp(slot0.heroInfo_.id, slot1)
end

function slot0.SendBreakToServer(slot0)
	HeroTools.CalFinalAttribute(uv0)
	HeroAction.HeroBreak(slot0.heroInfo_.id)
end

function slot0.OnAddHeroExp(slot0, slot1)
	if isSuccess(slot1.result) then
		slot3 = uv0

		HeroAction.AddHeroExpSuccess(slot0.heroInfo_.id, slot0.nextLv_, slot0.finalExp_)

		if uv1 < slot0.nextLv_ then
			JumpTools.OpenPageByJump("newHeroUpgradeSuccess", {
				heroId = slot0.heroInfo_.id,
				oldLv = uv1,
				oldAttr = slot3,
				proxy = slot0.heroViewProxy_,
				callback = function ()
					if #MaterialTools.materialGiveBack(uv0.cutExpForReward_, ItemConst.STR_ITEM.HERO) > 0 then
						getReward(formatRewardCfgList(slot0))
					end
				end
			})
		end

		uv0 = HeroTools.CaculateHeroAttribute(slot0.heroInfo_, slot0.heroViewProxy_:CalHeroEquipAttribute(slot0.heroInfo_.id))

		HeroTools.CalFinalAttribute(uv0)

		if slot0:HaveMaterial() and slot0.curLvMax_ > slot0.nextLv_ then
			if manager.guide:IsPlaying() then
				-- Nothing
			elseif slot0.nextLv_ ~= slot0.curLvMax_ then
				slot0:SelectFirstMaterial()
			end
		end
	end
end

function slot0.OnKeyLevelUp(slot0)
	slot0:QuickSelectList()
	slot0:UpdatePreview()
end

function slot0.UpdatePreview(slot0)
	slot0.fromLevelText_.text = string.format("%d", slot0.heroInfo_.level)
	slot1 = 0
	slot2 = 0

	for slot6, slot7 in ipairs(slot0.items_) do
		slot8 = slot7:GetData()
		slot1 = slot1 + ItemCfg[slot8.id].param[1] * slot8.topAmountValue
		slot8.number = slot0:GetNumber(slot8.id)
		slot8.selectStyle = slot8.topAmountValue ~= 0

		slot7:SetData(slot8)
		slot7:RefreshGray(slot8.number == 0 or slot8.topAmountValue > 0)

		if slot8.number == 0 then
			slot2 = slot2 + 1
		end
	end

	slot3, slot4, slot5, slot0.finalExp_, slot7 = LvTools.CheckHeroExp(slot0.heroInfo_.level, slot0.heroInfo_.exp + slot1, slot0.curLvMax_)
	slot0.cutExp_ = slot7
	slot0.addExpText_.text = string.format("+%d", slot1 - slot7)
	slot0.toLevelText_.text = string.format("%d", slot3)
	slot8 = GameLevelSetting[slot3].hero_level_exp1

	if HeroConst.HERO_LV_MAX <= slot3 then
		slot0.progressText_.text = "-/-"
	else
		slot0.progressText_.text = string.format("%d/%d", slot4, slot8)
	end

	slot0.currentProgressBar_.value = (slot0.heroInfo_.exp - LvTools.LevelToExp(slot0.heroInfo_.level, "hero_level_exp1")) / slot8
	slot0.previewProgressBar_.value = slot4 / slot8

	if slot0.heroInfo_.level < slot3 then
		slot0.currentProgressBar_.value = 0
	end

	slot0.addExpController_:SetSelectedState(tostring(slot1 - slot7 ~= 0))

	if slot0.nextLv_ ~= slot3 then
		slot0.nextLv_ = slot3

		slot0:UpdatePreviewAttr()
	end

	SetActive(slot0.maxText_, slot0.curLvMax_ <= slot3)
end

function slot0.InitMaterialItem(slot0)
	slot0.items_ = {}

	for slot4, slot5 in ipairs(GameSetting.hero_exp_props_id_list.value) do
		slot6 = slot0[string.format("itemGo%d_", slot4)]

		SetActive(slot6, true)

		slot7 = CommonItemView.New(slot6)

		table.insert(slot0.items_, slot7)

		slot8 = clone(ItemTemplateData)
		slot8.id = slot5
		slot8.number = slot0:GetNumber(slot5)
		slot8.topAmountValue = 0

		function slot8.longClickFun(slot0, slot1, slot2)
			if slot2.dragging then
				return false
			end

			if slot0.number == 0 then
				ShowPopItem(POP_SOURCE_ITEM, {
					slot0.id,
					slot0.number
				})
			end

			if slot0.number <= slot0.topAmountValue or uv0.cutExp_ >= 0 and uv0.nextLv_ == uv0.curLvMax_ or slot0.topAmountValue == ItemTools.getItemNum(slot0.id) then
				return false
			end

			slot0.topAmountValue = slot0.topAmountValue + 1

			uv0:UpdatePreview()

			return true
		end

		function slot8.clickAmountFun(slot0)
			slot0.topAmountValue = slot0.topAmountValue - 1

			uv0:UpdatePreview()

			return true
		end

		slot7:SetData(slot8)
	end
end

function slot0.InitPropItem(slot0)
	slot0.propNames_ = {
		slot0.propName1_,
		slot0.propName2_,
		slot0.propName3_,
		slot0.propName4_
	}
	slot0.propItems_ = {
		slot0.propNum1_,
		slot0.propNum2_,
		slot0.propNum3_,
		slot0.propNum4_
	}
	slot0.toPropItems_ = {
		slot0.toPropNum1_,
		slot0.toPropNum2_,
		slot0.toPropNum3_,
		slot0.toPropNum4_
	}
	slot0.arrowItems_ = {
		slot0.arrowItem1_,
		slot0.arrowItem2_,
		slot0.arrowItem3_,
		slot0.arrowItem4_
	}
	slot0.propIcon_ = {
		slot0.propIcon1_,
		slot0.propIcon2_,
		slot0.propIcon3_,
		slot0.propIcon4_
	}
	slot0.propIndexes_ = {
		HeroConst.HERO_ATTRIBUTE.ATK,
		HeroConst.HERO_ATTRIBUTE.ARM,
		HeroConst.HERO_ATTRIBUTE.STA,
		HeroConst.HERO_ATTRIBUTE.CRITICAL
	}
	slot0.endfixes_ = {}

	for slot4 = 1, 4 do
		slot5, slot6, slot0.propIcon_[slot4].sprite = SkillTools.GetAttr({
			slot0.propIndexes_[slot4],
			0
		})
		slot0.propNames_[slot4].text = GetI18NText(slot5)
		slot0.endfixes_[slot4] = PublicAttrCfg[slot0.propIndexes_[slot4]].percent == 1 and "%" or ""
	end
end

function slot0.UpdateBreakView(slot0)
	uv0 = HeroTools.CaculateHeroAttribute(slot0.heroInfo_, {})

	HeroTools.CalFinalAttribute(uv0)

	slot0.fromBreakLevelText_.text = slot0.breakCfg_.max_level

	if slot0.nextBreakCfg_ then
		slot0.toBreakLevelText_.text = slot0.nextBreakCfg_.max_level
	end

	slot0.fromCritText_.text = string.format("%.2f", uv0[HeroConst.HERO_ATTRIBUTE.CRITICAL] / 10) .. (PublicAttrCfg[HeroConst.HERO_ATTRIBUTE.CRITICAL].percent == 1 and "%" or "")
	slot1 = deepClone(slot0.heroInfo_)
	slot1.break_level = slot1.break_level + 1
	slot2 = HeroTools.CaculateHeroAttribute(slot1, {})

	HeroTools.CalFinalAttribute(slot2)

	slot0.toCritText_.text = string.format("%.2f", slot2[HeroConst.HERO_ATTRIBUTE.CRITICAL] / 10) .. (PublicAttrCfg[HeroConst.HERO_ATTRIBUTE.CRITICAL].percent == 1 and "%" or "")

	slot0:CheckCanBreak()
end

function slot0.CheckCanBreak(slot0)
	slot0.canBreak_ = true
	slot1 = nil

	if slot0.breakCfg_.user_level <= PlayerData:GetPlayerInfo().userLevel then
		slot1 = string.format(GetTips("UPGRADE_LIMIT_LEVEL"), slot0.breakCfg_.user_level)

		slot0.conditionBreakController_:SetSelectedState("achieve")
	else
		slot1 = string.format(GetTips("UPGRADE_LIMIT_LEVEL_RED"), slot0.breakCfg_.user_level)
		slot0.canBreak_ = false

		slot0.conditionBreakController_:SetSelectedState("unsuccessful")
	end

	slot0.conditionText_.text = slot1
	slot2 = #slot0.breakCfg_.cost

	for slot6 = 1, 3 do
		slot7 = slot0["breakItemGo" .. slot6 .. "_"]

		if slot6 <= slot2 then
			if not slot0.breakItems_[slot6] then
				SetActive(slot7, true)
				table.insert(slot0.breakItems_, NewHeroBreakMaterialItem.New(slot0, slot7))
			end

			slot0.breakItems_[slot6]:SetInfo(slot0.breakCfg_.cost[slot6][1], slot0.breakCfg_.cost[slot6][2])

			if not slot0.breakItems_[slot6]:IsEnough() then
				slot0.canBreak_ = false
			end
		else
			SetActive(slot7, false)
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.breakItemContent_)

	while slot2 < #slot0.breakItems_ do
		slot0.breakItems_[#slot0.breakItems_]:Dispose()
		table.remove(slot0.breakItems_, #slot0.breakItems_)
	end

	slot0.needNumText_.text = string.format("%d", slot0.breakCfg_.cost_gold)

	if slot0.breakCfg_.cost_gold <= CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD) then
		slot0.moneyEnoughController_:SetSelectedState("true")
	else
		slot0.moneyEnoughController_:SetSelectedState("false")

		slot0.canBreak_ = false
	end

	slot0.canBreakController_:SetSelectedState(tostring(slot0.breakCfg_.user_level <= PlayerData:GetPlayerInfo().userLevel))
end

function slot0.OnTop(slot0)
	slot0:CheckCanBreak()
end

function slot0.HaveMaterial(slot0)
	for slot4, slot5 in ipairs(GameSetting.hero_exp_props_id_list.value) do
		if ItemTools.getItemNum(slot5) > 0 then
			return true
		end
	end

	return false
end

function slot0.HaveBreakMaterial(slot0)
	for slot5 = 1, #slot0.breakCfg_.cost do
		if not slot0.breakItems_[slot5]:IsEnough() then
			return false
		end
	end

	return true
end

function slot0.SelectFirstMaterial(slot0)
	slot1 = true

	for slot5 = 1, #slot0.items_ do
		slot6 = slot0.items_[slot5]:GetData()
		slot6.selectNum_ = 0

		if uv0:GetNumber(slot6.id) > 0 and slot1 then
			slot1 = false
			slot6.topAmountValue = 1

			slot0.items_[slot5]:SetData(slot6)
			slot0.items_[slot5]:RefreshGray(slot6.number == 0)
		else
			slot6.topAmountValue = 0

			slot0.items_[slot5]:SetData(slot6)
			slot0.items_[slot5]:RefreshGray(slot6.number == 0)
		end
	end

	slot0:UpdatePreview()
end

function slot0.UpdateBar(slot0)
	if slot0.type_ == "lvUp" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_GOLD
		})
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	end
end

function slot0.OnEnter(slot0)
	slot0.heroViewProxy_ = slot0.params_.proxy

	slot0:UpdateView()
	slot0:RegistEventListener(HERO_DATA_MODIFY, handler(slot0, slot0.OnHeroModify))
end

function slot0.GetNumber(slot0, slot1)
	return ItemTools.getItemNum(slot1)
end

function slot0.OnMaterialModify(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.items_) do
		if slot6:GetData().id == slot1 then
			slot7.number = slot0:GetNumber(slot1)
			slot7.topAmountValue = 0

			slot6:SetData(slot7)
			slot0.items_[slot5]:RefreshGray(slot7.number == 0)
		end
	end
end

function slot0.QuickSelectList(slot0)
	slot1 = LvTools.LevelToExp(slot0.curLvMax_, "hero_level_exp1") - slot0.heroInfo_.exp
	slot2 = {}

	for slot6 = 1, #slot0.items_ do
		slot7 = slot0.items_[slot6]:GetData()
		slot8 = ItemCfg[slot7.id].param[1]
		slot2[slot6] = math.max(math.min(math.ceil(slot1 / slot8), slot7.number), 0)

		if slot1 - slot2[slot6] * slot8 < 0 and slot6 > 1 then
			slot9 = -slot1

			for slot13 = slot6 - 1, 1, -1 do
				slot15 = ItemCfg[slot0.items_[slot13]:GetData().id].param[1]
				slot16 = math.modf(slot9 / slot15)
				slot2[slot13] = math.max(0, slot2[slot13] - slot16)
				slot18 = math.min(slot2[slot13], slot16)
				slot9 = slot9 - slot15 * slot18
				slot1 = slot1 + slot15 * slot18
			end
		end

		if slot1 <= 0 then
			break
		end
	end

	for slot6 = 1, #slot0.items_ do
		if slot2[slot6] == nil then
			slot2[slot6] = 0
		end

		slot0.items_[slot6]:GetData().topAmountValue = slot2[slot6]
		slot0.selectStyle = slot2[slot6] ~= 0
	end
end

function slot0.UpdatePreviewAttr(slot0)
	uv0 = slot0.heroViewProxy_:GetHeroAllAttribute(slot0.heroInfo_.id)
	uv1 = slot0:GetPreviewAttribute(slot0.heroInfo_.id)

	for slot4, slot5 in pairs(slot0.propItems_) do
		slot7 = uv0[slot0.propIndexes_[slot4]] or 0

		SetActive(slot0.toPropItems_[slot4].gameObject, uv1[slot0.propIndexes_[slot4]] - slot7 ~= 0)
		SetActive(slot0.arrowItems_[slot4], slot8 - slot7 ~= 0)

		if PublicAttrCfg[slot0.propIndexes_[slot4]].percent == 1 then
			slot5.text = string.format("%.2f", slot7 / 10) .. slot0.endfixes_[slot4]
		else
			slot5.text = math.floor(slot7)
		end

		if slot6 then
			slot0.toPropItems_[slot4].text = string.format("%.2f", slot8 / 10) .. slot0.endfixes_[slot4]
		else
			slot0.toPropItems_[slot4].text = math.floor(slot8)
		end
	end
end

function slot0.UpdateView(slot0)
	slot0.heroInfo_ = slot0.heroViewProxy_:GetHeroData(slot0.params_.heroId)
	slot0.heroCfg_ = HeroCfg[slot0.params_.heroId]

	if slot0.heroInfo_.level == HeroConst.HERO_LV_MAX then
		slot0:Back()

		return
	end

	slot0.curLvMax_ = HeroTools.GetHeroCurrentMaxLevel(slot0.heroInfo_)
	slot0.breakCfg_ = HeroTools.GetHeroBreakConfig(slot0.heroCfg_.race, slot0.heroInfo_.break_level or 0)
	slot0.breakIdList_ = HeroBreakCfg.get_id_list_by_race[slot0.heroCfg_.race]

	if slot0.heroInfo_.break_level < #slot0.breakIdList_ - 1 then
		slot0.nextBreakCfg_ = HeroTools.GetHeroBreakConfig(slot0.heroCfg_.race, slot0.heroInfo_.break_level + 1 or 0)
	end

	manager.heroRaiseTrack:SetModelState(slot0.heroViewProxy_:GetHeroUsingSkinInfo(slot0.params_.heroId).id)

	if slot0.heroInfo_.level == slot0.curLvMax_ then
		slot0.type_ = "break"
	else
		slot0.type_ = "lvUp"
	end

	slot0.typeController_:SetSelectedState(slot0.type_)

	if slot0.type_ == "lvUp" then
		slot0:SelectFirstMaterial()

		slot2 = slot0.heroViewProxy_:GetHeroAllAttribute(slot0.heroInfo_.id)

		for slot6, slot7 in ipairs(slot0.propItems_) do
			slot8 = slot2[slot0.propIndexes_[slot6]] or 0

			if PublicAttrCfg[slot0.propIndexes_[slot6]].percent == 1 then
				slot7.text = string.format("%.2f", slot8 / 10) .. slot0.endfixes_[slot6]
			else
				slot7.text = math.floor(slot8)
			end
		end

		slot0.canLevelUpController_:SetSelectedState(tostring(slot0:HaveMaterial()))
	elseif slot0.type_ == "break" then
		slot0:UpdateBreakView()
	end

	slot0:UpdateBar()
end

function slot0.GetPreviewAttribute(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in pairs(deepClone(slot0.heroViewProxy_:GetHeroData(slot1)).equip) do
		if slot8.equip_id ~= 0 then
			table.insert(slot3, EquipData:GetEquipData(slot8.equip_id))
		end
	end

	slot2.level = slot0.nextLv_

	if slot2.servant_uid ~= 0 then
		slot4 = WeaponServantData.GetWeaponServantList()[slot2.servant_uid]
		slot2.servantInfo = {
			id = slot4.id,
			stage = slot4.stage
		}
	else
		slot2.servantInfo = nil
	end

	slot4[HeroConst.HERO_ATTRIBUTE.ATK] = (GetHeroFinalAttr(slot2, slot2.servantInfo, slot3)[HeroConst.HERO_ATTRIBUTE.ATK] or 0) * (1 + (slot4[11] or 0) / 1000 + (slot4[13] or 0) / 1000) + (slot4[12] or 0)
	slot4[HeroConst.HERO_ATTRIBUTE.ARM] = (slot4[HeroConst.HERO_ATTRIBUTE.ARM] or 0) * (1 + (slot4[21] or 0) / 1000) + (slot4[22] or 0)
	slot4[HeroConst.HERO_ATTRIBUTE.STA] = (slot4[HeroConst.HERO_ATTRIBUTE.STA] or 0) * (1 + (slot4[31] or 0) / 1000) + (slot4[32] or 0)

	return slot4
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
end

function slot0.OnHeroModify(slot0, slot1)
	if slot1 == slot0.heroInfo_.id then
		slot0:UpdateView()
	end
end

function slot0.Dispose(slot0)
	if slot0.breakItems_ then
		for slot4, slot5 in pairs(slot0.breakItems_) do
			slot5:Dispose()
		end

		slot0.breakItems_ = nil
	end

	if slot0.items_ then
		for slot4, slot5 in pairs(slot0.items_) do
			slot5:Dispose()
		end

		slot0.items_ = nil
	end

	if slot0.tweens_ then
		slot0.tweens_ = {}
	end

	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
