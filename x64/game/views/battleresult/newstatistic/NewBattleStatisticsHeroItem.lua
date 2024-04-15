slot0 = class("NewBattleStatisticsHeroItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.BuildContext(slot0)
	slot0.modeController = slot0.controller_:GetController("default0")
	slot0.heroModule = BattleSettlementHeroHeadModule.New(slot0.heroHeadObj_)
	slot0.data = {}
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:BuildContext()
end

function slot0.SetHeroData(slot0, slot1, slot2)
	slot0.data.index = slot1
	slot0.data.heroData = slot2

	if slot2 then
		slot0.modeController:SetSelectedState("hero")
		slot0.heroModule:ShowCaptain(slot1 == 1)
		slot0.heroModule:SetHeroData(slot2)
		slot0.heroModule:ShowLevel(slot2.level, 1)
	else
		slot0.modeController:SetSelectedState("none")
	end
end

function slot0.SetStatisticsData(slot0, slot1, slot2, slot3)
	slot0.data.total = slot1
	slot0.data.max = slot2
	slot0.data.data = slot3
	slot8 = tonumber(tostring(slot3.hurt))
	slot9 = tonumber(tostring(slot3.cure))

	if slot0:valuePass(slot1.damage) then
		slot11 = tonumber(tostring(slot3.damage)) / tonumber(tostring(slot1.damage))
		slot0.attackNumTxt_.text = tostring(slot4)
		slot0.attackTxt_.text = string.format("%.0f%%", slot11 * 100)
		slot0.attackSlider_.value = slot11
	else
		slot0.attackNumTxt_.text = tostring(slot4)
		slot0.attackTxt_.text = "0%"
		slot0.attackSlider_.value = 0
	end

	if slot0:valuePass(slot1.hurt) then
		slot11 = slot8 / tonumber(tostring(slot1.hurt))
		slot0.damageNumTxt_.text = tostring(slot5)
		slot0.damageTxt_.text = string.format(slot10, slot11 * 100)
		slot0.damageSlider_.value = slot11
	else
		slot0.damageNumTxt_.text = tostring(slot5)
		slot0.damageTxt_.text = "0%"
		slot0.damageSlider_.value = 0
	end

	if slot0:valuePass(slot1.cure) then
		slot11 = slot9 / tonumber(tostring(slot1.cure))
		slot0.healNumTxt_.text = tostring(slot6)
		slot0.healTxt_.text = string.format(slot10, slot11 * 100)
		slot0.healSlider_.value = slot11
	else
		slot0.healNumTxt_.text = tostring(slot6)
		slot0.healTxt_.text = "0%"
		slot0.healSlider_.value = 0
	end
end

function slot0.valuePass(slot0, slot1)
	slot2, slot3 = pcall(function ()
		if type(uv0) == "number" then
			return uv0 > 0
		else
			return int64.zero < uv0
		end
	end)

	if slot2 then
		return slot3
	else
		return false
	end
end

function slot0.Dispose(slot0)
	slot0.heroModule:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
