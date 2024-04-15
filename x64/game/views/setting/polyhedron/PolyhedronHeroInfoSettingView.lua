slot0 = class("PolyhedronHeroInfoSettingView", ReduxView)

function slot0.SetActive(slot0, slot1)
	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, slot1)
	end
end

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.hander_ = slot1
	slot0.transform_ = slot2.transform
	slot0.gameObject_ = slot2
	slot0.stageData = slot3

	slot0:Init()

	slot0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()
	slot0.fight_hero_id_list = slot0.polyhedronInfo:GetFightHeroList()
	slot0.selectHeroId = slot0.fight_hero_id_list[1]

	slot0:RefreshUI()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.hero_list = LuaList.New(handler(slot0, slot0.IndexHeroItem), slot0.m_heroList, PolyhedronSetHeroItem)
	slot0.servantItem = WeaponServantHeadItem.New(slot0.m_servant)
	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.leaderController = ControllerUtil.GetController(slot0.transform_, "leader")
	slot0.showController = ControllerUtil.GetController(slot0.transform_, "show")
	slot0.astrolabeItems = {}
	slot0.skillItems = {}
	slot0.equipItems = {}

	slot0.showController:SetSelectedIndex(0)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_skillBtn, nil, function ()
		uv0.selectController:SetSelectedIndex(0)
		uv0:RefreshUI()
	end)
	slot0:AddBtnListener(slot0.m_weaponBtn, nil, function ()
		uv0.selectController:SetSelectedIndex(1)
		uv0:RefreshUI()
	end)
	slot0:AddBtnListener(slot0.m_equipBtn, nil, function ()
		uv0.selectController:SetSelectedIndex(2)
		uv0:RefreshUI()
	end)
	slot0:AddBtnListener(slot0.m_astrolabeBtn, nil, function ()
		uv0.selectController:SetSelectedIndex(3)
		uv0:RefreshUI()
	end)
	slot0:AddBtnListener(slot0.m_heroBtn, nil, function ()
		uv0.showController:SetSelectedIndex(1)

		uv0.heroList = {}
		slot1 = uv0.polyhedronInfo
		slot3 = slot1
		uv0.fight_hero_id_list = slot1.GetHeroList(slot3)

		for slot3, slot4 in ipairs(uv0.fight_hero_id_list) do
			if slot4 ~= uv0.selectHeroId then
				table.insert(uv0.heroList, slot4)
			end
		end

		uv0.hero_list:StartScroll(#uv0.heroList)
	end)
	slot0:AddBtnListener(slot0.m_mask, nil, function ()
		uv0.showController:SetSelectedIndex(0)
	end)
end

function slot0.RefreshUI(slot0)
	slot0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()
	slot1 = slot0.selectHeroId
	slot2 = HeroCfg[slot1]
	slot0.m_heroName.text = slot2.name
	slot0.m_heroSuffix.text = slot2.suffix
	slot0.m_campImg.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[slot2.race].icon)
	slot6 = PolyhedronHeroCfg[slot0.selectHeroId]
	slot7, slot8 = nil

	if slot1 == slot0.polyhedronInfo:GetLeaderHeroId() then
		slot7, slot8 = slot0.polyhedronInfo:GetPolyhedronLeader():GetVirtualData()

		slot0.leaderController:SetSelectedIndex(1)
	else
		slot7, slot8 = GetVirtualData(slot6.standard_id)

		slot0.leaderController:SetSelectedIndex(0)
	end

	slot14 = PolyhedronData:GetHeroUsingSkinInfo(slot1).id
	slot0.m_heroIcon.sprite = getSpriteViaConfig("HeroLittleIcon", slot14)
	slot10 = 1
	slot0.using_astrolabe = slot7.using_astrolabe

	for slot14, slot15 in ipairs(slot0.using_astrolabe) do
		if slot15 and slot15 ~= 0 then
			if not slot0.astrolabeItems[slot10] then
				slot0.astrolabeItems[slot10] = PolyhedronSetAstrolabeItem.New(Object.Instantiate(slot0.m_astrolabeItem, slot0.m_astrolabeContent))
			end

			slot0.astrolabeItems[slot10]:SetActive(true)
			slot0.astrolabeItems[slot10]:SetData(slot15)

			slot10 = slot10 + 1
		end
	end

	for slot15 = slot10, #slot0.astrolabeItems do
		slot0.astrolabeItems[slot15]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_astrolabeContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_astrolabeContent)

	slot16 = slot8
	slot0.suitList = slot0:GetEquipSuit(slot7, slot16)
	slot12 = 1

	for slot16, slot17 in ipairs(slot0.suitList) do
		slot18 = slot17.id

		if not slot0.equipItems[slot12] then
			slot0.equipItems[slot12] = PolyhedronSetEquipItem.New(Object.Instantiate(slot0.m_equipItem, slot0.m_equipContent))
		end

		slot0.equipItems[slot12]:SetActive(true)
		slot0.equipItems[slot12]:SetData(slot18)

		slot12 = slot12 + 1
	end

	for slot17 = slot12, #slot0.equipItems do
		slot0.equipItems[slot17]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_equipContent)

	slot0.servant_id = slot7.servantInfo and slot7.servantInfo.id or 0
	slot0.servant_level = slot7.servantInfo and slot7.servantInfo.stage or 1

	slot0.servantItem:OnRender({
		id = slot0.servant_id
	})
	slot0.servantItem:RenderEquipStatus(false)
	slot0.servantItem:ShowLock(false)

	slot14 = WeaponServantCfg[slot0.servant_id]
	slot0.m_servantCamp.sprite = getSprite("Atlas/Item", string.format("icon_group_%d_c", slot14.race))
	slot0.m_servantName.text = ItemTools.getItemName(slot0.servant_id)
	slot0.m_servantDes.text = GetCfgDescription(WeaponEffectCfg[slot14.effect[1]].description[1], slot0.servant_level + HeroTools.GetHeroWeaponAddLevel(slot7))
	slot23 = {
		[slot28.skill_id] = slot28.skill_level
	}

	for slot27, slot28 in ipairs(TempHeroData:GetTempHeroDataByTempID(PolyhedronHeroCfg[slot1].standard_id).skill) do
		-- Nothing
	end

	slot0.skillList_ = {}

	for slot27, slot28 in ipairs(HeroCfg[slot1].skills) do
		table.insert(slot0.skillList_, {
			isCanUp = false,
			addSkillLv = 0,
			id = slot28,
			heroId = slot1,
			lv = slot23[slot28]
		})
	end

	slot12 = 1

	for slot27, slot28 in ipairs(slot0.skillList_) do
		if not slot0.skillItems[slot12] then
			slot0.skillItems[slot12] = PolyhedronSetSkillItem.New(Object.Instantiate(slot0.m_skillItem, slot0.m_skillContent))
		end

		slot0.skillItems[slot12]:SetActive(true)
		slot0.skillItems[slot12]:SetData(slot28)

		slot12 = slot12 + 1
	end

	for slot28 = slot12, #slot0.skillItems do
		slot0.skillItems[slot28]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_skillContent)
end

function slot0.GetEquipSuit(slot0, slot1, slot2)
	slot4 = HeroTools.GetIsSuitNumCut(slot1)
	slot5 = {}

	for slot9, slot10 in pairs(slot2) do
		if slot10.equip_id ~= 0 then
			if slot5[EquipCfg[slot10.prefab_id].suit] then
				slot5[slot11.suit].num = slot5[slot11.suit].num + 1
			else
				slot5[slot11.suit] = {
					num = 1,
					id = slot11.suit
				}
			end
		end
	end

	slot6 = {}

	for slot10, slot11 in pairs(slot5) do
		table.insert(slot6, slot11)
	end

	for slot10 = #slot6, 1, -1 do
		if slot6[slot10].num < EquipTools.GetSuitNeedNum(slot6[slot10].id, slot4) then
			table.remove(slot6, slot10)
		end
	end

	return slot6
end

function slot0.IndexHeroItem(slot0, slot1, slot2)
	slot2:SetData(slot0.polyhedronInfo, slot0.heroList[slot1])
	slot2:RegistCallBack(function (slot0)
		uv0:OnHeroClick(slot0)
	end)
end

function slot0.OnHeroClick(slot0, slot1)
	slot0.selectHeroId = slot1

	slot0:RefreshUI()
	slot0.showController:SetSelectedIndex(0)
end

function slot0.Dispose(slot0)
	slot0.hero_list:Dispose()
	slot0.servantItem:Dispose()

	for slot4, slot5 in ipairs(slot0.astrolabeItems) do
		slot5:Dispose()
	end

	slot0.astrolabeItems = {}

	for slot4, slot5 in ipairs(slot0.skillItems) do
		slot5:Dispose()
	end

	slot0.skillItems = {}

	for slot4, slot5 in ipairs(slot0.equipItems) do
		slot5:Dispose()
	end

	slot0.equipItems = {}

	uv0.super.Dispose(slot0)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
