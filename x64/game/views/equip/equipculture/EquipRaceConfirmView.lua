slot0 = class("EquipRaceConfirmView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_equip/Develop/HeroEquipGroupReset"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.leftController_ = slot0.leftCon_:GetController("state")
	slot0.leftHeroController_ = slot0.leftCon_:GetController("equippedHero")
	slot0.rightController_ = slot0.rightCon_:GetController("state")
	slot0.rightHeroController_ = slot0.rightCon_:GetController("equippedHero")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnLeftChoose_, nil, function ()
		uv0:OnRaceConfirmClick(false)
	end)
	slot0:AddBtnListener(slot0.btnRightChoose_, nil, function ()
		uv0:OnRaceConfirmClick(true)
		ShowTips("EQUIP_RACE_RESET")
	end)
end

function slot0.OnEnter(slot0)
	slot0.equipId = slot0.params_.equipId
	slot0.heroId = slot0.params_.heroId
	slot2 = HeroCfg[slot0.heroId]

	if not EquipData:GetEquipData(slot0.equipId) then
		return
	end

	slot0.equipIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/Equip/icon_s/" .. ItemCfg[slot1.prefab_id].icon)

	if slot1.race ~= 0 and RaceEffectCfg[slot3] then
		slot0.leftController_:SetSelectedIndex(1)

		slot0.leftGroupText_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(slot4.name))
		slot0.leftGroupIcon_.sprite = getSprite("Atlas/SystemGroupAtlas", slot4.icon2)
		slot0.leftIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/Group_l/" .. slot4.icon2)
		slot5 = slot2 and slot3 == slot2.race

		slot0.leftHeroController_:SetSelectedState(slot5 and "on" or "off")

		if slot5 then
			slot0.leftHeroIcon_.sprite = HeroTools.GetSmallHeadSprite(slot0.heroId)
		end
	else
		slot0.leftController_:SetSelectedIndex(0)
	end

	if slot1.race_preview ~= 0 and RaceEffectCfg[slot5] then
		slot0.rightController_:SetSelectedIndex(1)

		slot0.rightGroupText_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(slot6.name))
		slot0.rightGroupIcon_.sprite = getSprite("Atlas/SystemGroupAtlas", slot6.icon2)
		slot0.rightIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/Group_l/" .. slot6.icon2)
		slot7 = slot2 and slot5 == slot2.race

		slot0.rightHeroController_:SetSelectedState(slot7 and "on" or "off")

		if slot7 then
			slot0.rightHeroIcon_.sprite = HeroTools.GetSmallHeadSprite(slot0.heroId)
		end
	else
		slot0.rightController_:SetSelectedIndex(0)
	end
end

function slot0.OnRaceConfirmClick(slot0, slot1)
	EquipAction.QueryEquipRaceConfirm(slot0.equipId, slot1)
end

function slot0.OnEquipRaceConfirm(slot0)
	slot0:Back()
end

return slot0
