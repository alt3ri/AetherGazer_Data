slot0 = class("BattleSettlementHeroHeadModule", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.BuildContext(slot0)
	slot0.levelUpTween = nil
	slot0.heroData = nil
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:BuildContext()
end

function slot0.ShowCaptain(slot0, slot1)
	SetActive(slot0.captainObj_, slot1)
end

function slot0.SetHeroData(slot0, slot1)
	slot0.heroData = slot1

	if not slot1 then
		SetActive(slot0.heroNoneObj_, true)
		SetActive(slot0.heroHeadObj_, false)

		return
	else
		SetActive(slot0.heroNoneObj_, false)
		SetActive(slot0.heroHeadObj_, true)
	end

	slot0:SetHeroCfgData(slot1.id, slot1.using_skin, (slot1.star or 0) / 100)
end

function slot0.SetHeroLevelData(slot0, slot1)
	slot2, slot3 = math.modf(slot1)

	if LvTools.GetIsMaxLv(slot2, "hero") then
		slot0:ShowLevel(slot2, 1)
	else
		slot0:ShowLevel(slot2, slot3)
	end
end

function slot0.ShowLevel(slot0, slot1, slot2)
	slot0.levelText_.text = tostring(slot1 or 1)
	slot0.expSlider_.value = slot2
end

function slot0.PlayLevelUpTween(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:StopTween()

	slot0.levelUpTween = LeanTween.value(slot0.gameObject_, slot1 + slot3, slot2 + slot4, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function (slot0)
		uv0:SetHeroLevelData(slot0)
	end)):setOnComplete(LuaHelper.VoidAction(function ()
		uv0:StopTween()
	end))
end

function slot0.RenderContentView(slot0, slot1)
end

function slot0.StopTween(slot0)
	if not isNil(slot0.levelUpTween) then
		slot0.levelUpTween:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.gameObject_)

		slot0.levelUpTween = nil
	end
end

function slot0.SetHeroCfgData(slot0, slot1, slot2, slot3)
	slot0.heroCfg_ = HeroCfg[slot1]
	slot0.campLogo_.sprite = HeroTools.GetHeroRaceIcon(slot1)

	if slot3 == 0 then
		slot0.rareImg_.sprite = HeroTools.GetRareSprite(math.floor(slot4.rare or 0))
	else
		slot0.rareImg_.sprite = HeroTools.GetRareSprite(math.floor(slot3))
	end

	slot0.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(slot1)

	if slot2 then
		slot0.headIcon_.sprite = HeroTools.GetHeadSprite(SkinCfg[slot2].picture_id)

		slot0.headIcon_:SetNativeSize()
	end
end

function slot0.Dispose(slot0)
	slot0:StopTween()
	uv0.super.Dispose(slot0)
end

return slot0
