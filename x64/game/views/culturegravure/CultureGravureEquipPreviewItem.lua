slot0 = class("CultureGravureEquipPreviewItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = slot0.control_:GetController("status")
	slot0.qualityController_ = slot0.control_:GetController("quality")
	slot0.enchantController_ = slot0.control_:GetController("enchant")
	slot0.resetController_ = slot0.control_:GetController("reset")
	slot0.emptyController_ = slot0.control_:GetController("empty")
	slot0.starController_ = ControllerUtil.GetController(slot0.equipItem_, "star")
	slot0.posController_ = ControllerUtil.GetController(slot0.equipItem_, "position")
end

function slot0.AddListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	if slot1 and (slot1.equip_id ~= 0 or slot3) then
		slot5 = EquipCfg[slot1.prefab_id]
		slot0.imgIcon_.sprite = ItemTools.getItemSprite(slot1.prefab_id, nil, true)
		slot0.textName_.text = ItemTools.getItemName(slot1.prefab_id)
		slot7 = HeroConst.RARE_COLOR[ItemCfg[slot1.prefab_id].rare]

		slot0.starController_:SetSelectedState(slot5.starlevel)
		slot0.qualityController_:SetSelectedState(slot5.starlevel)
		slot0.enchantController_:SetSelectedState(slot1:GetEnchantCount())

		slot0.level_ = slot1:GetLevel()
		slot0.textLv_.text = string.format("等级：%s/%s", slot0.level_, slot1:GetMaxLv())

		slot0.posController_:SetSelectedState(slot5.pos)
		slot0:RreshReset(slot1)
	end

	if slot1 == nil or slot1.equip_id == 0 and not slot3 then
		slot0.statusController_:SetSelectedState("empty")
		slot0.emptyController_:SetSelectedState(slot4)
	elseif slot2 == "had" and slot3 then
		slot0.statusController_:SetSelectedState("equipped")
	else
		slot0.statusController_:SetSelectedState("current")
	end
end

function slot0.RreshReset(slot0, slot1)
	if slot1 and slot1.race ~= 0 then
		slot3 = nil

		slot0.resetController_:SetSelectedState("true")

		if table.keyof(RaceEffectCfg.all, slot1.race) ~= nil then
			slot3 = RaceEffectCfg[slot1.race]
			slot0.textReset_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(slot3.name))
			slot0.imgReset_.sprite = getSprite("Atlas/SystemGroupAtlas", slot3.icon2)
			slot0.imgReset_.color = Color(0.49019607843137253, 0.5411764705882353, 0.596078431372549)
		else
			slot4 = slot1.race
			slot3 = HeroCfg[slot4]
			slot0.textReset_.text = string.format(GetTips("EQUIP_HERO_ATTRIBUTE_UP"), HeroTools.GetHeroFullName(slot4))
			slot0.imgReset_.sprite = HeroTools.GetSmallHeadSprite(slot1.race)
			slot0.imgReset_.color = Color.white
		end
	else
		slot0.resetController_:SetSelectedState("false")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
