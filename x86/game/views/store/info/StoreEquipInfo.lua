slot0 = class("StoreEquipInfo", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.raceController_ = slot0.controllerEx_:GetController("race")
	slot0.switchController_ = slot0.controllerEx_:GetController("tab")
	slot0.cultureController_ = slot0.controllerEx_:GetController("btnState")
	slot0.storeHeadInfoView_ = StoreHeadInfo.New(slot0.itemHeadGo_)
	slot0.attributeItemList_ = {}

	for slot5 = 1, 2 do
		slot0.attributeItemList_[slot5] = AttributeItem.New(slot0, slot0[string.format("attributeItem%s_", slot5)])
	end

	slot0.suitUIList_ = LuaList.New(handler(slot0, slot0.IndexSuitItem), slot0.suitUIListGo_, EquipNewSuitItem)
	slot0.skillUIList_ = LuaList.New(handler(slot0, slot0.IndexSkillItem), slot0.skillUIListGo_, EquipNewSkillItem)
	slot0.selectType_ = StoreConst.EQUIP_FILTER_TYPE.SUIT
end

function slot0.OnEnter(slot0)
	slot0.storeHeadInfoView_:OnEnter()
end

function slot0.OnExit(slot0)
	slot0.storeHeadInfoView_:OnExit()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.attributeItemList_) do
		slot5:Dispose()
	end

	slot0.attributeItemList_ = nil

	slot0.storeHeadInfoView_:Dispose()

	slot0.storeHeadInfoView_ = nil

	slot0.suitUIList_:Dispose()

	slot0.suitUIList_ = nil

	slot0.skillUIList_:Dispose()

	slot0.skillUIList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.suitBtn_, nil, function ()
		if uv0.selectType_ ~= StoreConst.EQUIP_FILTER_TYPE.SUIT then
			uv0.selectType_ = StoreConst.EQUIP_FILTER_TYPE.SUIT

			uv0:RefreshTypePanel()
		end
	end)
	slot0:AddBtnListener(slot0.skillBtn_, nil, function ()
		if uv0.selectType_ ~= StoreConst.EQUIP_FILTER_TYPE.SKILL then
			uv0.selectType_ = StoreConst.EQUIP_FILTER_TYPE.SKILL

			uv0:RefreshTypePanel()
		end
	end)
	slot0:AddBtnListener(slot0.cultureBtn_, nil, function ()
		ShowPopItem(nil, uv0.itemData_, {
			page = 2
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.itemData_ = slot1

	slot0.storeHeadInfoView_:SetData(slot1)

	slot4 = slot1.number
	slot5 = slot1.timeVlaid
	slot6 = ItemCfg[slot1.id]
	slot7 = slot6.type
	slot8 = slot6.sub_type

	slot0:RefreshAttribute()
	slot0:RefreshRace()
	slot0:GetSuitData()
	slot0:RefreshSuit()
	slot0:GetSkillData()
	slot0:RefreshSkill()

	if not slot2 then
		slot0.selectType_ = StoreConst.EQUIP_FILTER_TYPE.SUIT
	end

	slot0:RefreshTypePanel()
end

function slot0.RefreshAttribute(slot0)
	slot4 = 1

	for slot8, slot9 in pairs(EquipTools.CountEquipAttribute(EquipData:GetEquipData(slot0.itemData_.equip_id))) do
		slot0.attributeItemList_[slot4]:RefreshData(slot0, {
			key = slot8,
			value = slot9,
			race = slot0.itemData_.race,
			heroId = slot0.bintHeroID
		}, true)

		slot4 = slot4 + 1
	end
end

function slot0.RefreshRace(slot0)
	if slot0.itemData_.bindHeroID ~= 0 then
		slot0.raceController_:SetSelectedState("on")

		slot2 = HeroCfg[slot1]
		slot0.raceText_.text = string.format(GetTips("EQUIP_HERO_ATTRIBUTE_UP"), HeroTools.GetHeroFullName(slot1))
		slot0.raceImage_.sprite = HeroTools.GetSmallHeadSprite(slot1)

		return
	end

	if slot0.itemData_.race ~= 0 then
		slot0.raceController_:SetSelectedState("on")

		slot3 = RaceEffectCfg[slot2]
		slot0.raceText_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(slot3.name))
		slot0.raceImage_.sprite = getSprite("Atlas/SystemGroupAtlas", slot3.icon2)

		return
	end

	slot0.raceController_:SetSelectedState("off")
end

function slot0.RefreshTypePanel(slot0)
	if slot0.selectType_ == StoreConst.EQUIP_FILTER_TYPE.SUIT then
		slot0.switchController_:SetSelectedState("suit")
	else
		slot0.switchController_:SetSelectedState("skill")
	end
end

function slot0.GetSuitData(slot0)
	slot0.suitList_ = {}
	slot1 = slot0.itemData_
	slot2 = slot1.equipedHeroID
	slot3 = EquipCfg[slot1.id]
	slot4 = slot3.suit
	slot5, slot6 = EquipTools.GetHeroEquipSuitPos(slot2, slot4, slot3.pos)

	table.insert(slot0.suitList_, {
		id = slot4,
		num = slot6,
		pos = slot5,
		equipPos = slot3.pos,
		equipHero = HeroData:GetHeroData(slot2)
	})
end

function slot0.RefreshSuit(slot0)
	slot0.suitUIList_:StartScroll(#slot0.suitList_)
end

function slot0.GetSkillData(slot0)
	slot0.skillList_ = EquipData:GetEquipData(slot0.itemData_.equip_id):GetTotalSkill()
end

function slot0.RefreshSkill(slot0)
	slot0.skillUIList_:StartScroll(#slot0.skillList_)
end

function slot0.IndexSuitItem(slot0, slot1, slot2)
	slot2:RefreshData(slot0.suitList_[slot1].equipHero, slot0.suitList_[slot1])
end

function slot0.IndexSkillItem(slot0, slot1, slot2)
	slot3 = slot0.skillList_[slot1]
	slot3.level = slot0.itemData_.equipLevel
	slot3.hideMaxLevel = true

	slot2:RegistCallBack(function (slot0)
		JumpTools.OpenPageByJump("equipSkillInfo", {
			equipSkillData = {
				id = uv0.id,
				skillLevel = uv0.num,
				selectItem = uv1
			}
		})
	end)
	slot2:RefreshData(slot0, slot3)
end

return slot0
