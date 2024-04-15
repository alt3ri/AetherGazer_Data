slot0 = class("BattleMultipleResultHeroItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.heroData_ = slot2
	slot0.stageData = slot3
	slot0.isLock_ = slot4
	slot0.heroCollectData = slot5 or {}

	slot0:InitUI()
	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	slot0:RemoveTween()
	uv0.super.Dispose(slot0)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0)
	slot0.icon_.sprite = getSpriteViaConfig("HeroLittleIcon", slot0.heroData_.using_skin)

	if slot0.isLock_ then
		slot0:LockHero()
	else
		slot0:RefreshHero()
	end
end

function slot0.LockHero(slot0)
	slot0.addExpText_.text = "+0"
	slot0.lvText_.text = slot0.heroData_.level
	slot0.expProgressBar_.value = 1
end

function slot0.RefreshHero(slot0)
	slot1 = slot0.heroData_
	slot3 = 1
	slot4 = 1
	slot5 = 0
	slot6 = 0

	if slot0.heroCollectData then
		slot3 = slot2.oldLv
		slot4 = slot2.newLv
		slot5 = slot2.oldPersent
		slot6 = slot2.newPersent
	end

	slot0.addExpText_.text = ""

	slot0:RemoveTween()

	slot0.heroExp_ = slot4 + slot6
	slot0.tweens_ = LeanTween.value(slot0.expProgressBar_.gameObject, slot3 + slot5, slot4 + slot6, 6):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function (slot0)
		uv0:UpdateHeroData(slot0)
	end)):setOnComplete(LuaHelper.VoidAction(function ()
		uv0:RemoveTween()
	end))
end

function slot0.RemoveTween(slot0)
	if slot0.tweens_ then
		slot1:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot1.id)
	end
end

function slot0.UpdateHeroData(slot0, slot1)
	slot2, slot3 = math.modf(slot1)
	slot0.lvText_.text = string.format("%d", slot2)

	if LvTools.GetIsMaxLv(slot2, "hero") then
		slot0.expProgressBar_.value = 1
	else
		slot0.expProgressBar_.value = slot3
	end
end

function slot0.EndAnimator(slot0)
	slot0:RemoveTween()

	if not slot0.isLock_ then
		slot0:UpdateHeroData(slot0.heroExp_)
	end
end

return slot0
