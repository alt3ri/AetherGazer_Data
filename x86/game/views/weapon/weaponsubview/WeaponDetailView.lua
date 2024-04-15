slot0 = class("WeaponDetailView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:Init()
end

function slot0.Init(slot0)
	slot0.constVar = {
		sliderBarWidth = 387
	}
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.ShowWeaponInfo(slot0, slot1, slot2, slot3)
	slot0.weaponnameText_.text = HeroCfg[slot1].weapon_name
	slot0.nowlevelText_.text = slot2.level
	slot0.toplevelText_.text = "/" .. GameSetting.weapon_exp_limit.value[slot2.breakthrough + 1] or HeroConst.WEAPON_LV_MAX
	slot0.weaponstoryText_.text = HeroCfg[slot1].weapon_desc
	slot0.atknumText_.text = string.format("%d", WeaponTools.WeaponAtk(slot2.level, slot2.breakthrough))
	slot0.dcrinameText_.text, slot0.crinumText_.text = SkillTools.GetAttr(HeroCfg[slot1].weapon_break_attribute[slot2.breakthrough + 1])
	slot8, slot9, slot10 = WeaponTools.AddWeaponExp(slot2.exp, slot2.breakthrough, 0)

	slot0.realExpTrans_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, slot8 / GameLevelSetting[slot2.level].weapon_level_exp * slot0.constVar.sliderBarWidth)

	if HeroConst.WEAPON_LV_MAX <= slot2.level then
		slot0.expShowTxt_.text = "-/-"
	else
		slot0.expShowTxt_.text = slot8 .. "/" .. slot11
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
