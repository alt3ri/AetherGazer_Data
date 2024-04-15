slot0 = class("PolyhedronTeamInfoSettingHead", ReduxView)

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

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.emptyController = ControllerUtil.GetController(slot0.transform_, "empty")
	slot0.heroHead = PolyhedronHeroShortHead.New(slot0.m_head)

	slot0.heroHead:SetRedPointEnable(false)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.id)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.id = slot2

	if slot1:GetHeroPolyData(slot2):IsDead() then
		slot0.stateController:SetSelectedIndex(1)

		slot0.m_coldNum.text = slot1:GetTeamateRebornMaxColdDown() - slot4.reborn_cold_down
	else
		slot0.stateController:SetSelectedIndex(0)
	end

	slot0.heroHead:SetProxy(slot3)
	slot0.heroHead:SetHeroId(slot2, HeroConst.HERO_DATA_TYPE.POLYHEDRON)
	slot0.heroHead.lockedController_:SetSelectedState("false")
	SetActive(slot0.heroHead.noticePos_.gameObject, false)
end

function slot0.SetFightData(slot0, slot1, slot2, slot3)
	slot0.id = slot2
	slot4 = slot1:GetHeroPolyData(slot2)
	slot5 = slot1:GetTeamateRebornMaxColdDown()

	if slot2 == nil or slot2 == 0 then
		slot0.emptyController:SetSelectedIndex(1)

		return
	else
		slot0.emptyController:SetSelectedIndex(0)
	end

	slot0.heroHead:SetProxy(slot3)
	slot0.heroHead:SetHeroId(slot2, HeroConst.HERO_DATA_TYPE.POLYHEDRON)
	slot0.heroHead.lockedController_:SetSelectedState("false")
	SetActive(slot0.heroHead.noticePos_.gameObject, false)

	if slot4:IsDead() then
		slot0.m_coldNum.text = slot5 - slot4.reborn_cold_down

		slot0.stateController:SetSelectedIndex(4)
	elseif slot1:GetLeaderHeroId() == slot2 then
		slot0.stateController:SetSelectedIndex(2)

		slot0.heroHead.headIcon_.sprite = HeroTools.GetHeadSprite(PolyhedronData:GetHeroUsingSkinInfo(slot2).id)
	else
		slot0.stateController:SetSelectedIndex(3)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.Dispose(slot0)
	slot0.heroHead:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
