slot0 = class("AstrolabeUnlockView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.conditionController1_ = slot0.condition1Controllerexcollection_:GetController("clear")
	slot0.conditionController2_ = slot0.condition2Controllerexcollection_:GetController("clear")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.unlockBtn_, nil, function ()
		slot0 = HeroAstrolabeCfg[uv0.info_.id]

		if not uv0.isCanUp_ then
			ShowTips("ERROR_ASTROLABE_UNLOCK_CONDITION_NOT_MATCH")

			return
		end

		if not checkGold(uv0.cost_) then
			return
		end

		AstrolabeAction.AstrolabeUnlock(uv0.info_.heroId, uv0.info_.id)
	end)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot0.info_ = slot1

		slot0:RefreshLimit()
		slot0:RefreshCost()
	end
end

function slot0.RefreshLimit(slot0)
	slot1 = HeroAstrolabeCfg[slot0.info_.id]
	slot0.isAchieve_, slot0.current_, slot0.all_ = IsConditionAchieved(slot1.unlock_condition, {
		heroId = slot0.info_.heroId
	})
	slot0.conditiondescire1Text_.text = GetI18NText(ConditionCfg[slot1.unlock_condition].desc)

	slot0.conditionController1_:SetSelectedState(slot0.isAchieve_ and "clear" or "notclear")

	if HeroTools.IsSpHero(slot0.info_.heroId) then
		slot0.num1Text_.text = slot0.all_ <= slot0.current_ and "1/1" or "0/1"

		SetActive(slot0.condition2Go_, false)

		if HeroAstrolabeCfg[slot1.pre_astrolabe_id] then
			SetActive(slot0.condition2Go_, true)

			slot0.conditiondescire2Text_.text = string.format(GetTips("SP_SURPASS_DES"), HeroAstrolabeCfg[slot3].name)
		end
	else
		slot0.num1Text_.text = string.format("%d/%d", slot0.current_, slot0.all_)
		slot0.conditiondescire2Text_.text = GetTips("NORMAL_ASTROLABE_DES")

		SetActive(slot0.condition2Go_, slot1.pos ~= 1)
	end

	slot0.isLastUnlock_ = AstrolabeTools.GetLastIsUnlock(slot0.info_.id, slot0.info_.heroId)

	slot0.conditionController2_:SetSelectedState(slot0.isLastUnlock_ and "clear" or "notclear")

	slot0.num2Text_.text = slot0.isLastUnlock_ and "1/1" or "0/1"
	slot0.isCanUp_ = slot0.isAchieve_ and slot0.isLastUnlock_
	slot0.tokenImg_.sprite = ItemTools.getItemSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
end

function slot0.RefreshCost(slot0)
	if slot0.info_ == nil then
		return
	end

	slot0.cost_ = HeroAstrolabeCfg[slot0.info_.id].unlock[1][2]
	slot0.costtextText_.text = slot0.cost_

	if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < slot0.cost_ then
		slot0.costtextText_.color = CurrencyConst.LACK_COLOR
	else
		slot0.costtextText_.color = CurrencyConst.ENOUGH_COLOR
	end
end

function slot0.OnAstrolabeUnlock(slot0, slot1, slot2)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.SetProxy(slot0, slot1)
	slot0.heroViewProxy_ = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
