slot0 = class("NorseSurpriseGiftChooseItem", ReduxView)

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
	slot0.heartCtrl = slot0.transform_:GetComponent("ControllerExCollection"):GetController("heart")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnLook_, nil, function ()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			hid = uv0.heroId
		})
	end)
end

function slot0.SetData(slot0, slot1)
	slot0:UpdateView(slot1)
end

function slot0.UpdateView(slot0, slot1)
	slot0.heroId = slot1
	slot2 = HeroCfg[slot0.heroId]
	slot3 = slot0.heroViewProxy_:GetHeroUsingSkinInfo(slot0.heroId).id
	slot0.headIcon_.sprite = HeroTools.GetHeadSprite(slot0.heroId)
	slot0.atkImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(slot0.heroId)
	slot0.raceImg_.sprite = HeroTools.GetHeroRaceIcon(slot0.heroId)

	slot0.stateCtrl:SetSelectedIndex(0)
	slot0.heartCtrl:SetSelectedIndex(0)
end

function slot0.SetHeart(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0.heroId == slot6 then
			slot0.heartCtrl:SetSelectedIndex(1)

			break
		end
	end
end

function slot0.SetDelete(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0.heroId == slot6 then
			slot0.stateCtrl:SetSelectedIndex(1)

			break
		end
	end
end

function slot0.SetDraw(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0.heroId == slot6 then
			slot0.stateCtrl:SetSelectedIndex(2)

			break
		end
	end
end

function slot0.SetResultRoleId(slot0, slot1)
	if slot0.heroId == slot1 then
		slot0.stateCtrl:SetSelectedIndex(3)
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
