slot0 = class("CanteenGainItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2)

	SetActive(slot0.gameObject_, true)

	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0, slot1)
	slot2 = nil

	if slot1.skillType == CanteenConst.HeroSkillType.FoodCostQucik or slot1.skillType == CanteenConst.HeroSkillType.FoodCostRise then
		slot3 = slot1.foodType
		slot6 = nil
		slot2 = string.format(BackHomeHeroSkillDescCfg[slot1.skillType].desc, tostring(CanteenTools:GetFootTypeName(slot3))) .. ((DormSkillData:GetSkillEffect(slot1.skillType, nil, , slot3) <= 0 or string.format(BackHomeHeroSkillDescCfg[slot1.skillType].pos_desc, string.format("<color=#e48a00>" .. slot4 .. "</color>"))) and string.format(BackHomeHeroSkillDescCfg[slot1.skillType].neg_desc, string.format("<color=#e48a00>" .. -slot4 .. "</color>")))
	elseif slot1.skillType == CanteenConst.HeroSkillType.PopularRise then
		slot4 = nil
		slot2 = BackHomeHeroSkillDescCfg[slot1.skillType].desc .. ((DormSkillData:GetSkillEffect(slot1.skillType) <= 0 or string.format(BackHomeHeroSkillDescCfg[slot1.skillType].pos_desc, string.format("<color=#e48a00>" .. slot3 .. "</color>"))) and string.format(BackHomeHeroSkillDescCfg[slot1.skillType].neg_desc, string.format("<color=#e48a00>" .. -slot3 .. "</color>")))
	end

	slot0.desc.text = slot2
end

function slot0.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
	uv0.super.Dispose(slot0)
end

return slot0
