slot1 = class("EnchantChangeView", import("game.views.equip.equipCulture.EquipBaseView"))

function slot1.UIName(slot0)
	return "Widget/System/Hero_equip/Develop/HeroEquipEnchant"
end

function slot1.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	uv0.super.Init(slot0)

	slot0.max = GameSetting.equip_enchant_save_num.value[1] or 0
	slot0.isLockedSkill_ = false
	slot0.lockedIndex_ = nil
	slot0.standardRatio_ = 0.09270833333333334
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.skillPreItems_ = {}
	slot0.items_ = {}
	slot0.materialIndex = 1
	slot0.skillPopView_ = EquipNewSkillInfoView.New(slot0.equipSkillPopGo_)
	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
	slot0.enchantScroller_ = LuaList.New(handler(slot0, slot0.indexPreviewItem), slot0.enchantListGo_, EquipEnchantPreviewItem)
	slot0.giveupController_ = slot0.transCon_:GetController("allGiveup")
	slot0.popController_ = slot0.transCon_:GetController("pop")

	slot0:InitFixedSkill()
	slot0:InitMaterial()
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnEnchant_, nil, function ()
		uv0:OnEnchantClick()
	end)
	slot0:AddBtnListener(slot0.btnGiveUp_, nil, function ()
		if uv0.enchantPreviewList and #uv0.enchantPreviewList > 0 then
			EquipAction.QueryEquipGiveUpAllEnchant(uv0.equipId, uv0.enchatPos)
		end
	end)
	slot0:AddBtnListener(slot0.btnHidePopMask_, nil, function ()
		uv0:HidePop()
	end)
	slot0:AddBtnListener(slot0.btnAccess_, nil, function ()
		slot0 = uv0.materials_[uv0.materialIndex]

		ShowPopItem(POP_SOURCE_ITEM, {
			slot0.id,
			ItemTools.getItemNum(slot0.id)
		})
	end)
end

function slot1.OnEnter(slot0)
	slot0.equipId = slot0.params_.equipId
	slot0.enchatPos = slot0.params_.enchatPos
	slot0.equipData = EquipData:GetEquipData(slot0.equipId)
	slot0.heroID_ = slot0.equipData:GetEquipHero()
	slot0.heroViewDataProxy_ = slot0.params_.proxy

	slot0:RefreshSkillData()
	slot0:RefreshSelect()
	slot0:RefreshUI()
	slot0:ShowBar()
	slot0:RegistEventListener(CURRENCY_UPDATE, handler(slot0, slot0.OnGoldChange))
	slot0:RegistEventListener(MATERIAL_MODIFY, handler(slot0, slot0.OnMaterialModify))
end

function slot1.ShowBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
end

function slot1.RefreshSkillData(slot0)
	slot0.skillList_ = {}

	if slot0.heroID_ and slot0.heroViewDataProxy_ then
		slot3, slot4, slot5 = EquipTools.CountHeroTotalSkill(slot0.heroViewDataProxy_:GetEquipDataList(slot0.heroID_), HeroData:GetHeroData(slot0.heroID_), true)

		for slot9, slot10 in pairs(slot3) do
			slot0.skillList_[slot9] = {
				id = slot9,
				num = slot10,
				isAdd = slot4,
				location = slot5[slot9]
			}
		end
	end
end

function slot1.InitFixedSkill(slot0)
	slot0.fixedSkills = {}

	for slot4 = 1, 2 do
		slot5 = {}

		ComponentBinder.GetInstance():BindCfgUI(slot5, slot0["enchantSkill_" .. slot4])

		slot5.selectController_ = slot5.transCon_:GetController("select")
		slot5.lockController_ = slot5.transCon_:GetController("lock")
		slot5.nullController_ = slot5.transCon_:GetController("null")

		slot0:AddBtnListener(slot5.btnLock_, nil, function ()
			uv0:OnLockClick(uv1)
		end)
		slot0:AddBtnListener(slot5.btnInfo_, nil, function ()
			if uv0.isSkill then
				uv1:OnSkillClick(uv0, uv1.skillList_[uv0.id], uv2)
			end
		end)
		table.insert(slot0.fixedSkills, slot5)
	end
end

function slot1.InitMaterial(slot0)
	slot0.materials_ = EquipData:GetEnchantMaterial()
	slot0.showLockMaterials_ = EquipData:GetLockEnchantMaterial()
	slot0.materialGoList_ = {}

	for slot4 = 1, #slot0.materials_ do
		slot5 = CommonItemView.New(slot0["material_" .. slot4])
		slot6 = clone(ItemTemplateData)
		slot6.id = slot0.materials_[slot4].id
		slot6.number = nil

		function slot6.clickFun()
			if not uv0.isLockedSkill_ then
				uv0:OnMarerialChange(uv1)
			end
		end

		slot5:SetData(slot6)

		slot0.materialGoList_[slot4] = slot5
	end
end

function slot1.RefreshSelect(slot0)
	if EquipData:GetIsSetLockView(slot0.equipId, slot0.enchatPos) then
		slot0.fixedSkills[slot1].lockController_:SetSelectedState("lock")
		slot0:OnMarerialChange(3)

		slot0.isLockedSkill_ = true
		slot0.lockedIndex_ = slot1

		slot0:RreshMateriaMoney()
	else
		slot0.fixedSkills[1].lockController_:SetSelectedState("unlock")
		slot0.fixedSkills[2].lockController_:SetSelectedState("unlock")

		slot0.materialIndex = EquipData:GetSelectEnchantMaterialIndex()

		slot0:OnMarerialChange(slot0.materialIndex)
	end
end

function slot1.RefreshUI(slot0)
	slot0:RreshMaterialUI()
	slot0:RreshFixedSkill()
	slot0:RefreshBottom()
end

function slot1.RreshMaterialUI(slot0)
	for slot5, slot6 in ipairs(slot0.materialGoList_) do
		slot8 = slot0.showLockMaterials_[slot5]

		slot6:RefreshBottomText({
			ItemTools.getItemNum(slot0.materials_[slot5].id),
			slot0.isLockedSkill_ and slot8.number or slot7.number
		})
		slot6:RefreshLock(slot0.isLockedSkill_ and not slot8.lock or false)
	end
end

function slot1.RreshFixedSkill(slot0, slot1)
	slot3 = EquipData:GetEquipData(slot0.equipId).enchant[slot0.enchatPos] or {}

	if slot1 then
		slot0.glowAnim_:Play("glow_bg")
	end

	slot0.fixedSkillIds_ = {}

	for slot7 = 1, 2 do
		slot9 = slot0.fixedSkills[slot7]

		if slot3[slot7] then
			slot9.id = slot8.id
			slot10 = EquipSkillCfg[slot8.id]
			slot11 = slot0.skillList_[slot8.id] and slot0.skillList_[slot8.id].num or slot8.num
			slot0.fixedSkillIds_[slot8.id] = slot0.fixedSkillIds_[slot8.id] and slot0.fixedSkillIds_[slot8.id] + 1 or 1
			slot9.num_.text = string.format("%s/%s", slot10.lvmax < slot11 and string.format("<color=#FF000B>%s</color>", slot11) or slot11, slot10.lvmax)

			if slot10.desc_spec_value ~= nil and slot10.desc_spec_value ~= "" then
				slot15 = string.gsub(GetCfgDescriptionWithValue(slot10.desc[1], tostring(slot10.upgrade / slot10.percent * (slot10.lvmax < slot11 and slot10.lvmax or slot11))), tostring(slot14), slot10.desc_spec_value[slot0.cfg_.num])
			end

			slot9.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. slot10.icon)
			slot9.name_.text = GetI18NText(slot10.name)
			slot9.desc_.text = slot15

			slot9.nullController_:SetSelectedState("skill")

			slot9.isSkill = true
		else
			slot9.isSkill = false

			slot9.nullController_:SetSelectedState("null")
		end
	end
end

function slot1.RefreshBottom(slot0, slot1)
	slot0.enchantPreviewList = EquipData:GetEquipData(slot0.equipId).enchant_preview[slot0.enchatPos]
	slot0.enchantNum_.text = string.format(GetTips("ENCHANT_PREVIEW_NUM"), #slot0.enchantPreviewList, slot0.max)

	slot0.giveupController_:SetSelectedState(#slot0.enchantPreviewList == 0 and "off" or "on")

	if slot1 then
		if slot1.scrollToIndex then
			slot3 = math.max(0, #slot0.enchantPreviewList)

			slot0:ShowGlowAnim(slot3)
			slot0.enchantScroller_:ScrollToIndex(math.max(0, slot3 - 1), true, true)
		elseif slot1.keepScrollPos then
			slot0.enchantScroller_:StartScrollByPosition(slot0.max, slot0.enchantScroller_:GetScrolledPosition())
		end
	else
		slot0.enchantScroller_:StartScroll(slot0.max)
	end
end

function slot1.indexPreviewItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.enchantPreviewList[slot1] or {}, slot0.skillList_, slot0.equipId, slot0.enchatPos, slot1, slot0.fixedSkillIds_)
	slot2:RegistSkillClickCallBck(handler(slot0, slot0.OnSkillClick))
end

function slot1.ShowGlowAnim(slot0, slot1)
	slot2 = nil
	slot3 = slot1

	FrameTimer.New(function ()
		if uv0.enchantScroller_:GetItemByIndex(uv1) ~= nil then
			slot0:ShowAnim()
		end

		uv2:Stop()
	end, 20, 1):Start()
end

function slot1.OnSkillClick(slot0, slot1, slot2)
	slot0.skillPopView_:RefreshData(slot0, slot2, true)

	slot0.selectedSkillItem_ = slot1

	slot0.selectedSkillItem_.selectController_:SetSelectedIndex(1)

	slot0.equipSkillPopGo_.transform.localPosition = Vector3(slot0.transform:InverseTransformPoint(slot1.transform.position).x / Screen.width <= slot0.standardRatio_ and slot3.x + 500 or slot3.x - 500, -20, 0)

	slot0.popController_:SetSelectedState("on")
end

function slot1.HidePop(slot0)
	if slot0.selectedSkillItem_ then
		slot0.selectedSkillItem_.selectController_:SetSelectedIndex(0)

		slot0.selectedSkillItem_ = nil
	end

	slot0.popController_:SetSelectedState("off")
end

function slot1.OnMarerialChange(slot0, slot1)
	if slot0.isLockedSkill_ then
		return
	end

	slot0.materialIndex = slot1
	slot5 = slot1

	EquipData:SetSelectEnchantMaterialIndex(slot5)
	slot0:RreshMateriaMoney()

	for slot5, slot6 in ipairs(slot0.materialGoList_) do
		slot6:RefreshSelectState2(slot5 == slot0.materialIndex)
	end
end

function slot1.RreshMateriaMoney(slot0)
	slot2 = (slot0.isLockedSkill_ and slot0.showLockMaterials_[slot0.materialIndex] or slot0.materials_[slot0.materialIndex]).money

	if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < slot2 then
		slot4 = "<color='#FF0000'>" .. tostring(slot2) .. "</color>"
	end

	slot0.costNum_.text = slot4
	slot6 = ItemCfg[slot1.id]

	if slot0.isLockedSkill_ then
		slot0.materialText_.text = GetTips("EQUIP_SKILL_LOCK_DES")
	else
		slot0.materialText_.text = slot6 and ItemTools.getItemDesc(slot5) or ""
	end
end

function slot1.OnEnchantClick(slot0)
	slot0.enchantPreviewList = EquipData:GetEquipData(slot0.equipId).enchant_preview[slot0.enchatPos]

	if slot0.max <= #slot0.enchantPreviewList then
		ShowTips("EQUIP_ENCHANT_RESULT_NUM_MAX")

		return
	end

	slot2 = slot0.equipId
	slot3 = slot0.enchatPos
	slot4 = slot0.materials_[slot0.materialIndex]
	slot5 = 0

	if slot0.isLockedSkill_ then
		slot5 = slot0.lockedIndex_
		slot4 = slot0.showLockMaterials_[slot0.materialIndex]
	end

	EquipAction.QueryEquipEnchant(slot2, slot3, slot4, slot5)
end

function slot1.OnEquipEnchant(slot0)
	slot0:RreshMaterialUI()
	slot0:RreshMateriaMoney()
	slot0:RefreshBottom({
		scrollToIndex = true
	})
end

function slot1.OnEquipEnchantConfirm(slot0, slot1)
	slot0:RefreshSkillData()
	slot0:RreshFixedSkill(slot1)

	if slot1 then
		-- Nothing
	end

	slot0:RefreshBottom({
		keepScrollPos = true
	})
end

function slot1.OnEquipEnchantGiveUp(slot0)
	slot0:RefreshBottom()
end

function slot1.OnGoldChange(slot0, slot1)
	if slot1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		slot0:RreshMateriaMoney()
	end
end

function slot1.OnMaterialModify(slot0, slot1)
	if ItemCfg[slot1].sub_type == 606 then
		slot0:RreshMaterialUI()
	end
end

function slot1.OnLockClick(slot0, slot1)
	if slot0.isLockedSkill_ then
		if slot0.lockedIndex_ then
			if slot0.lockedIndex_ == slot1 then
				slot0.fixedSkills[slot0.lockedIndex_].lockController_:SetSelectedState("unlock")

				slot0.isLockedSkill_ = false
				slot0.lockedIndex_ = nil
				slot0.materialIndex = 3

				EquipData:SetEnchatLockIndex(0, 0, 0)
			elseif #slot0.enchantPreviewList > 0 then
				ShowTips(GetTips("EQUIP_SKILL_LOCK_ENCHANT_EMPTY"))
			else
				slot0.fixedSkills[slot0.lockedIndex_].lockController_:SetSelectedState("unlock")
				slot0.fixedSkills[slot1].lockController_:SetSelectedState("lock")

				slot0.lockedIndex_ = slot1

				EquipData:SetEnchatLockIndex(slot0.equipId, slot0.enchatPos, slot0.lockedIndex_)
			end
		end
	elseif #slot0.enchantPreviewList > 0 then
		ShowTips(GetTips("EQUIP_SKILL_LOCK_ENCHANT_EMPTY"))
	else
		slot0.fixedSkills[slot1].lockController_:SetSelectedState("lock")
		slot0:OnMarerialChange(3)

		slot0.isLockedSkill_ = true
		slot0.lockedIndex_ = slot1

		EquipData:SetEnchatLockIndex(slot0.equipId, slot0.enchatPos, slot0.lockedIndex_)
	end

	slot0:RreshMaterialUI()
	slot0:RreshMateriaMoney()
end

function slot1.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:HidePop()
	slot0:RemoveAllEventListener()

	slot0.isLockedSkill_ = false
	slot0.lockedIndex_ = nil

	for slot4, slot5 in pairs(slot0.fixedSkills) do
		slot5.lockController_:SetSelectedState("unlock")
	end
end

function slot1.Dispose(slot0)
	slot0.enchantScroller_:Dispose()
	slot0.skillPopView_:Dispose()

	for slot4, slot5 in pairs(slot0.materialGoList_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot1
