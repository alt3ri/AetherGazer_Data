slot0 = class("NorseSurpriseGiftMachineItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.stateCtrl = slot0.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0:UpdateView(slot1)
end

function slot0.UpdateView(slot0, slot1)
	slot0.heroId = slot1
	slot3 = HeroCfg[slot1].race
	slot4 = slot0.heroViewProxy_:GetHeroUsingSkinInfo(slot1).id
	slot0.raceImage_.sprite = HeroTools.GetHeroRaceIcon(slot0.heroId)
	slot0.iconImage_.sprite = HeroTools.GetHeadSprite(slot0.heroId)
end

function slot0.SetState(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		if slot0.heroId == slot7 then
			slot0.stateCtrl:SetSelectedState("heart")

			break
		end
	end

	slot0.stateCtrl:SetSelectedState(heartState)

	if slot2 and slot2 > 0 then
		if slot2 == slot0.heroId then
			slot0.stateCtrl:SetSelectedState("receive")
		else
			slot0.stateCtrl:SetSelectedState("notreceive")
		end
	else
		slot0.stateCtrl:SetSelectedIndex(0)
	end
end

function slot0.ResetState(slot0)
	slot0.stateCtrl:SetSelectedIndex(0)
end

function slot0.PlayAnim(slot0, slot1)
	if slot1 then
		slot0.anim_:Play("NorseSurpriseGiftMachineUI_item")
		slot0.animZhuanhua_:Play("CommonItem_zhuanhua")
	else
		slot0.anim_:Play("New State")
		slot0.animZhuanhua_:Play("New State")
		SetActive(slot0.animZhuanhua_.gameObject, false)
	end
end

function slot0.OnEnter(slot0)
	slot0.stateCtrl:SetSelectedIndex(0)
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
