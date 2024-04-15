slot0 = class("PolyhedronSetHeroItem", ReduxView)

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

	slot0.leaderController = ControllerUtil.GetController(slot0.transform_, "leader")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.id)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.id = slot2
	slot3 = HeroCfg[slot2]
	slot0.n_name.text = slot3.name
	slot0.m_suffix.text = slot3.suffix
	slot4 = PolyhedronData:GetHeroUsingSkinInfo(slot2).id

	if slot2 == slot1:GetLeaderHeroId() then
		slot0.leaderController:SetSelectedIndex(1)
	else
		slot0.leaderController:SetSelectedIndex(0)
	end

	slot0.m_icon.sprite = HeroTools.GetHeadSprite(slot4)
	slot0.m_campImg.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[slot3.race].icon)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
