slot0 = class("EquipInfoView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.transform_ = slot1.transform
	slot0.gameObject_ = slot1
	slot0.info_ = slot2
	slot0.lockHandler_ = slot3

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.attrItem_ = {}

	for slot4 = 1, 2 do
		slot0.attrItem_[slot4] = AttributeItem.New(slot0, slot0["attrItem_" .. slot4])
	end

	slot0.skillList_ = {}
	slot0.heroSkillIndex_ = 0
	slot0.heroSkillItems_ = {}
	slot0.raceController_ = slot0.mainController_:GetController("race")
	slot0.tabController_ = slot0.mainController_:GetController("tab")
	slot0.bgController_ = slot0.mainController_:GetController("bg")
	slot0.isSelfController_ = slot0.mainController_:GetController("btnState")
	slot0.emptyController_ = slot0.mainController_:GetController("empty")
	slot0.typeController_ = slot0.headController_:GetController("type")
	slot0.qualityController_ = slot0.headController_:GetController("quality")
	slot0.lockController_ = slot0.headController_:GetController("lock")
	slot0.slotController_ = slot0.headController_:GetController("slot")
	slot0.starController_ = slot0.headController_:GetController("star")
	slot0.posController_ = slot0.equipBg_:GetController("pos")
	slot0.equipSuitItem_ = EquipNewSuitItem.New(slot0.suitGo_)
	slot0.skillScrollHelper_ = LuaList.New(handler(slot0, slot0.indexSkillItem), slot0.skillListGo_, EquipNewSkillItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnSkill_, nil, function ()
		uv0:ChangeShowView("skill")
	end)
	slot0:AddBtnListener(slot0.btnSuit_, nil, function ()
		uv0:ChangeShowView("suit")
	end)
	slot0:AddBtnListener(slot0.btnLock_, nil, function ()
		uv0.isLock_ = not uv0.isLock_

		EquipAction.ApplyLockEquip(uv0.info_.equip_id, uv0.isLock_)

		if uv0.lockHandler_ then
			uv0.lockHandler_(uv0.isLock_, uv0.info_.equip_id)
		end

		uv0.lockController_:SetSelectedState(uv0.isLock_ and "lock" or "unlock")
	end)
	slot0:AddBtnListener(slot0.btnChange_, nil, function ()
		slot0 = EquipCfg[uv0.info_.prefab_id]

		if uv0.equipFunc_ then
			uv0.equipFunc_()
		elseif uv0.equipedId_ ~= 0 and uv0.equipedId_ == uv0.info_.equip_id then
			uv0:SendUseEquip(uv0.heroId_, 0, slot0.pos)
		else
			slot1 = uv0.info_
			slot2 = uv0.info_.equip_id
			slot3 = uv0.heroId_
			slot4 = slot0.pos
			slot5 = uv0.info_:GetEquipHero() or 0
			slot6 = HeroCfg[slot5]

			if slot5 and slot6 then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = string.format(GetTips("EQUIP_IS_USING"), GetI18NText(slot6.name)),
					OkCallback = function ()
						uv0:SendUseEquip(uv1, uv2, uv3)
					end
				})
			else
				uv0:SendUseEquip(slot3, slot2, slot4)
			end
		end
	end)
	slot0:AddBtnListener(slot0.btnCulture_, nil, function ()
		if uv0.handler_.KeepFilter then
			uv0.handler_:KeepFilter()
		end

		if uv0.cultureFunc_ then
			uv0.cultureFunc_()
		elseif uv0.info_ and uv0.info_.prefab_id ~= 0 then
			uv0.info_.id = uv0.info_.prefab_id

			uv0:Go("/equipCultureView", {
				pageIndex = 2,
				equipId = uv0.info_.equip_id,
				proxy = uv0.heroViewProxy_
			})
		else
			ShowTips("NO_EQUIP")
		end
	end)
end

function slot0.RefreshData(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.handler_ = slot1
	slot0.info_ = slot2
	slot0.lockHandler_ = slot3
	slot0.heroId_ = slot4
	slot0.equipedId_ = slot5

	slot0:RefreshUI()
	slot0:RefreshState()
end

function slot0.OnEnter(slot0, slot1)
	slot0.heroViewProxy_ = slot1
end

function slot0.RefreshUI(slot0)
	if slot0.info_ and slot0.info_.prefab_id ~= 0 then
		slot0.emptyController_:SetSelectedState("notEmpty")
		slot0:RefreshTitle()
		slot0:RreshRace()
		slot0:RefreshAttr()
		slot0:RefreshSuit()
		slot0:RefreshSkill()
	else
		slot0.emptyController_:SetSelectedState("empty")
	end
end

function slot0.CheckLocked(slot0)
	slot0.isSelfController_:SetSelectedState(tostring(not slot0.heroViewProxy_.isSelf))
end

function slot0.RefreshTitle(slot0)
	slot1 = EquipCfg[slot0.info_.prefab_id]
	slot0.icon_.sprite = ItemTools.getItemSprite(slot0.info_.prefab_id, nil, true)
	slot0.name_.text = ItemTools.getItemName(slot0.info_.prefab_id)
	slot3 = HeroConst.RARE_COLOR[ItemCfg[slot0.info_.prefab_id].rare]

	slot0.starController_:SetSelectedState(slot1.starlevel)
	slot0.qualityController_:SetSelectedState(slot1.starlevel)
	slot0.slotController_:SetSelectedIndex(slot0.info_:GetEnchantCount())

	slot0.level_ = slot0.info_:GetLevel()
	slot0.lv_.text = string.format("%s%s/%s", GetTips("LEVEL"), slot0.level_, slot0.info_:GetMaxLv())
	slot0.isLock_ = slot0.info_.is_lock

	if slot0.info_.equip_id and slot0.info_.equip_id ~= 0 and slot0.heroViewProxy_ and slot0.heroViewProxy_.isSelf then
		slot0.lockController_:SetSelectedState(slot0.isLock_ and "lock" or "unlock")
	else
		slot0.lockController_:SetSelectedState("off")
	end

	slot0.posController_:SetSelectedState(slot1.pos or 0)
end

function slot0.RreshRace(slot0)
	if slot0.info_.race ~= 0 then
		slot2 = nil

		slot0.raceController_:SetSelectedState("on")

		if table.keyof(RaceEffectCfg.all, slot0.info_.race) ~= nil then
			slot2 = RaceEffectCfg[slot0.info_.race]
			slot0.raceText_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(slot2.name))
			slot0.raceImage_.sprite = getSprite("Atlas/SystemGroupAtlas", slot2.icon2)
		else
			slot3 = slot0.info_.race
			slot2 = HeroCfg[slot3]
			slot0.raceText_.text = string.format(GetTips("EQUIP_HERO_ATTRIBUTE_UP"), HeroTools.GetHeroFullName(slot3))
			slot0.raceImage_.sprite = HeroTools.GetSmallHeadSprite(slot0.info_.race)
		end
	else
		slot0.raceController_:SetSelectedState("off")
	end
end

function slot0.RefreshAttr(slot0)
	slot2 = 1

	for slot6, slot7 in pairs(EquipTools.CountEquipAttribute(slot0.info_)) do
		slot0.attrItem_[slot2]:RefreshData(slot0, {
			key = slot6,
			value = slot7,
			race = slot0.info_.race,
			heroId = slot0.heroId_
		}, true)

		slot2 = slot2 + 1
	end
end

function slot0.RefreshSuit(slot0)
	slot2 = EquipCfg[slot0.info_.prefab_id]
	slot3 = slot2.suit
	slot4 = EquipSuitCfg[slot3]
	slot5, slot6 = EquipTools.GetHeroEquipSuitPos(slot0.info_:GetEquipHero(), slot3, slot2.pos)

	if slot0.info_.suitNumAdd then
		slot6 = slot6 + slot0.info_.suitNumAdd
	end

	slot0.equipSuitItem_:RefreshData(slot0.heroViewProxy_ and slot0.heroViewProxy_:GetHeroData(slot0.heroId_) or HeroData:GetHeroData(slot0.heroId_), {
		equipId = slot0.info_.equip_id,
		id = slot3,
		num = slot6,
		pos = slot5,
		equipPos = slot2.pos,
		heroId = slot0.heroId_
	})
end

function slot0.RefreshSkill(slot0)
	slot0.skillList_ = slot0.info_:GetTotalSkill()

	slot0.skillScrollHelper_:StartScroll(#slot0.skillList_)
end

function slot0.indexSkillItem(slot0, slot1, slot2)
	slot3 = slot0.skillList_[slot1]
	slot3.level = slot0.level_
	slot3.hideMaxLevel = true

	slot2:RegistCallBack(function (slot0)
		if uv0.skillClickFunc then
			if uv0.lastSkillSelect_ then
				uv0.lastSkillSelect_:ShowSelect(false)
			end

			uv0.lastSkillSelect_ = uv1

			uv1:ShowSelect(true)
			uv0.skillClickFunc(uv1, slot0, uv0.isLeftPop_)
		end
	end)
	slot2:RefreshData(slot0, slot3)
end

function slot0.RegisterSkillClick(slot0, slot1, slot2)
	slot0.skillClickFunc = slot1
	slot0.isLeftPop_ = slot2
end

function slot0.RegistHeroButton(slot0, slot1, slot2)
	slot0.equipFunc_ = slot1
	slot0.cultureFunc_ = slot2
end

function slot0.DeSelect(slot0)
	if slot0.lastSkillSelect_ then
		slot0.lastSkillSelect_:ShowSelect(false)

		slot0.lastSkillSelect_ = nil
	end
end

function slot0.RefreshState(slot0)
	slot0.selectType_ = "suit"

	slot0:ChangeShowView(slot0.selectType_)

	if slot0.equipedId_ == 0 then
		slot0.textBtnChange_.text = GetTips("TIP_EQUIP")
		slot0.imgLeftBtn_.sprite = getSprite("Atlas/SystemCommonAtlas", "com_white_icon_30")
	elseif slot0.equipedId_ == slot0.info_.equip_id and not slot0.equipFunc_ then
		slot0.textBtnChange_.text = GetTips("TIP_UNLOAD")
		slot0.imgLeftBtn_.sprite = getSprite("Atlas/SystemCommonAtlas", "com_white_icon_31")
	else
		slot0.textBtnChange_.text = GetTips("TIP_CHANGE")
		slot0.imgLeftBtn_.sprite = getSprite("Atlas/SystemCommonAtlas", "com_white_icon_05")
	end
end

function slot0.ChangeShowView(slot0, slot1)
	if slot0.changeFunc then
		slot0.changeFunc(slot1)
	end

	slot0:ChangeSelect(slot1)
end

function slot0.ChangeSelect(slot0, slot1)
	slot0.selectType_ = slot1

	slot0.tabController_:SetSelectedState(slot1)
end

function slot0.RegisterChange(slot0, slot1)
	slot0.changeFunc = slot1
end

function slot0.ShowRaceAdd(slot0, slot1)
	for slot5, slot6 in pairs(slot0.attrItem_) do
		slot6:ShowAdd(slot1)
	end
end

function slot0.SendUseEquip(slot0, slot1, slot2, slot3)
	HeroAction.EquipSwap(slot1, slot2, slot3)
end

function slot0.OnEquipLock(slot0, slot1)
	if slot1 then
		ShowTips("ERROR_EQUIP_LOCKED_SUCCESS")
	else
		ShowTips("ERROR_EQUIP_UNLOCKED_SUCCESS")
	end
end

function slot0.Dispose(slot0)
	slot0.equipSuitItem_:Dispose()

	if slot0.skillScrollHelper_ then
		slot0.skillScrollHelper_:Dispose()

		slot0.skillScrollHelper_ = nil
	end

	if slot0.attrItem_ then
		for slot4, slot5 in pairs(slot0.attrItem_) do
			slot5:Dispose()
		end

		slot0.attrItem_ = nil
	end

	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
