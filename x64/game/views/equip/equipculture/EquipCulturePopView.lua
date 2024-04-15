slot0 = class("EquipCulturePopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_equip/Develop/EquipupPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.attrs_ = {}

	for slot4 = 1, 2 do
		slot5 = {}

		ComponentBinder.GetInstance():BindCfgUI(slot5, slot0["attr_" .. slot4])
		table.insert(slot0.attrs_, slot5)
	end

	slot0.stateController_ = slot0.transCon_:GetController("state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnBack_, nil, function ()
		SetActive(uv0.oldLv_.gameObject, false)
		manager.notify:Invoke(EQUIP_CULTURE_SUCCESS)
		uv0:Back()

		if uv0.params_.callback then
			uv0.params_.callback()

			uv0.params_.callback = nil
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot1 = slot0.params_.type

	SetActive(slot0.oldLv_.gameObject, true)
	slot0:RefreshType(slot1)

	if slot1 ~= "reset" then
		slot3 = slot0.params_.newEquip

		if not slot0.params_.oldEquip or not slot3 then
			return
		end

		slot4 = slot2:GetLevel()
		slot5 = slot3:GetLevel()
		slot7 = EquipTools.CountEquipAttribute(slot3)
		slot8 = 1

		for slot12, slot13 in pairs(EquipTools.CountEquipAttribute(slot2)) do
			slot15 = slot0.attrs_[slot8]
			slot16 = math.floor(slot13)
			slot17 = math.floor(slot7[slot12])

			if PublicAttrCfg[slot12].percent and slot14.percent == 1 then
				slot16 = slot13 / 10 .. "%"
				slot17 = slot7[slot12] / 10 .. "%"
			end

			slot15.name_.text = GetI18NText(slot14.name)
			slot15.icon_.sprite = getSprite("Atlas/SystemCommonAtlas", slot14.icon)
			slot15.oldVal_.text = slot16
			slot15.newVal_.text = slot17
			slot8 = slot8 + 1
		end
	end
end

function slot0.RefreshType(slot0, slot1)
	slot0.stateController_:SetSelectedState(slot1 == "reset" and "reset" or "lv")

	if slot1 == "levelup" then
		slot0.oldLv_.text = slot0.params_.oldEquip:GetLevel()
		slot0.newLv_.text = slot0.params_.newEquip:GetLevel()
		slot0.mainTitle_.text = GetTips("EQUIP_LEVELUP_POP")
	elseif slot1 == "upgrade" then
		slot0.oldLv_.text = slot2:GetMaxLv()
		slot0.newLv_.text = slot3:GetMaxLv()
		slot0.mainTitle_.text = GetTips("EQUIP_UPGRADE_POP")

		slot0:ShowUpGradeTips()
	elseif slot1 == "reset" then
		slot4 = slot0.params_.heroId
		slot0.resetHeroIcon_.sprite = HeroTools.GetHeadSprite(slot4)
		slot0.resetDesc_.text = string.format(GetTips("EQUIP_HERO_RESET_POP"), HeroTools.GetHeroFullName(slot4))
	end
end

function slot0.ShowUpGradeTips(slot0)
	slot1 = nil

	Timer.New(function ()
		uv0:Stop()
		ShowTips("EQUIP_BREAK_SUCCESS")
	end, 1, 0):Start()
end

function slot0.RefreshSkill(slot0, slot1, slot2)
	for slot7 = 1, #slot1 do
		if slot7 > #slot0.skillItems_ then
			slot8 = Object.Instantiate(slot0.skillItem_, slot0.skillParent_.transform)
			slot9 = slot8.transform
			slot0.skillItems_[slot7] = {
				gameObject = slot8,
				icon_ = slot0:FindCom(typeof(Image), "icon", slot9),
				name_ = slot0:FindCom(typeof(Text), "lv", slot9),
				lv_ = slot0:FindCom(typeof(Text), "name", slot9)
			}
		end

		slot8 = slot1[slot7]
		slot9 = EquipSkillCfg[slot8.id]
		slot0.skillItems_[slot7].icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. slot9.icon)
		slot0.skillItems_[slot7].name_.text = GetI18NText(slot9.name)
		slot0.skillItems_[slot7].lv_.text = GetTips("LEVEL") .. slot8.num
	end

	for slot7, slot8 in ipairs(slot0.skillItems_) do
		SetActive(slot8.gameObject, slot7 <= slot3)
	end
end

function slot0.GetPlayBackwardsAnimator(slot0)
	return {
		{
			slot0.animator_,
			"Fx_CompopUI04_xs",
			false
		}
	}, nil
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
