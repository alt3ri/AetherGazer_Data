slot0 = class("NorseSurpriseGiftInStockItem", ReduxView)

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

	slot0.stateCtrl = slot0.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnLook_, nil, function ()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			hid = uv0.heroId
		})
	end)
	slot0:AddBtnListener(slot0.selfBtn_, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.heroId)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0:UpdateView(slot1)
end

function slot0.UpdateView(slot0, slot1)
	slot0.heroId = slot1
	slot3 = HeroCfg[slot0.heroId].ATK_attribute[1]
	slot4 = slot0.heroViewProxy_:GetHeroUsingSkinInfo(slot0.heroId).id
	slot0.headIcon_.sprite = HeroTools.GetHeadSprite(slot0.heroId)
	slot0.atkImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(slot0.heroId)
	slot0.raceImg_.sprite = HeroTools.GetHeroRaceIcon(slot0.heroId)
end

function slot0.SetChoose(slot0, slot1)
	slot2 = 1

	for slot6, slot7 in ipairs(slot1) do
		if slot0.heroId == slot7.id then
			slot2 = 0
			slot0.heroSortTxt_.text = slot6

			break
		end
	end

	slot0.stateCtrl:SetSelectedState(slot2)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.clickFunc = nil
end

return slot0
