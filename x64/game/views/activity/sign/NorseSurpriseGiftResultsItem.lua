slot0 = class("NorseSurpriseGiftResultsItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heartCtrl = slot0.transform_:GetComponent("ControllerExCollection"):GetController("heart")
	slot0.stockCtrl = slot0.transform_:GetComponent("ControllerExCollection"):GetController("Outofstock")
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0:UpdateView(slot1)
end

function slot0.UpdateView(slot0, slot1)
	slot0.heroId = slot1
	slot4 = slot0.heroViewProxy_:GetHeroUsingSkinInfo(slot1).id
	slot0.bottomAmountText_.text = 1
	slot0.gradeImage_.sprite = getSprite("Atlas/SystemHeroGradeAtlas", "com_grade_" .. 3)
	slot0.raceImage_.sprite = getSprite("Atlas/SystemGroupAtlas", RaceEffectCfg[HeroCfg[slot1].race].icon2)
	slot0.iconImage_.sprite = HeroTools.GetHeadSprite(slot0.heroId)

	slot0.heartCtrl:SetSelectedIndex(1)
	slot0.stockCtrl:SetSelectedIndex(1)
end

function slot0.SetHeart(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0.heroId == slot6 then
			slot0.heartCtrl:SetSelectedIndex(0)

			break
		end
	end
end

function slot0.SetDelete(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0.heroId == slot6 then
			slot0.stockCtrl:SetSelectedIndex(0)

			break
		end
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
