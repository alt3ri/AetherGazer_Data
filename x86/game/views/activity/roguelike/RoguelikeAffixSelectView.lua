slot0 = class("RoguelikeAffixSelectView", ReduxView)

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.UIName(slot0)
	return "UI/StrategyMatrix/StrategyMatrixSelectAffixUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.customItems = {}
end

function slot0.OnEnter(slot0)
	slot0.customData = {}
	slot0.activity_id = slot0.params_.activity_id
	slot0.cfg = StrategyMatrixCfg[slot0.activity_id]

	slot0:MappingConfig(slot0.cfg)
	slot0:Refresh(true)
end

function slot0.Reset(slot0)
	slot0.customData = {}
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(StrategyMatrixTools.GetGameTipKey(slot0.activity_id))
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.InitUI(slot0)
	slot0.gameObject_:InjectUI(slot0)

	slot0.affixGroupList_ = LuaList.New(handler(slot0, slot0.IndexGroupItem), slot0.RectMonster, MatrixAffixGroupItem)
	slot0.affixHeroGroupList_ = LuaList.New(handler(slot0, slot0.IndexGroupHeroItem), slot0.RectHero, MatrixAffixGroupItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_okBtn, nil, function ()
		StrategyMatrixAction.QueryStartMatrix(uv0.cfg.hero_standard_system_id_list, uv0.activity_id, uv0.customData)
	end)
end

function slot0.MappingConfig(slot0, slot1)
	if not slot1 then
		return
	end

	slot0.monster_affix = {}
	slot0.hero_affix = {}
	slot2 = {}
	slot3 = {}

	for slot8, slot9 in ipairs(slot1.custom_affix) do
		slot10 = ActivityAffixPoolCfg[slot9].affix
		slot11 = slot10[1]

		if slot10[3] == 3 then
			if not slot3[slot11] then
				slot3[slot11] = {}
			end

			table.insert(slot3[slot11], slot9)
		else
			if not slot2[slot11] then
				slot2[slot11] = {}
			end

			table.insert(slot2[slot11], slot9)
		end
	end

	for slot8, slot9 in pairs(slot3) do
		table.sort(slot9, function (slot0, slot1)
			return slot1 < slot0
		end)
		table.insert(slot0.hero_affix, {
			id = slot8,
			list = slot9
		})
	end

	for slot8, slot9 in pairs(slot2) do
		table.sort(slot9, function (slot0, slot1)
			return slot1 < slot0
		end)
		table.insert(slot0.monster_affix, {
			id = slot8,
			list = slot9
		})
	end

	print("词缀长度-------------->", #slot0.monster_affix, "--", #slot0.hero_affix)
end

function slot0.GetHeroData(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(slot0.cfg.hero_standard_system_id_list) do
		table.insert(slot1, {
			hero_type = 2,
			hero_standard_system_id = slot7
		})
	end

	return slot1
end

function slot0.Refresh(slot0, slot1)
	slot6 = #slot0.customData

	slot0:GenerateItems(slot0.customItems, slot6, MatrixAffixLongItem, slot0.GoItem, slot0.Content)

	for slot6 = 1, #slot0.customData do
		slot0.customItems[slot6]:Refresh(ActivityAffixPoolCfg[slot0.customData[slot6]].affix, 2)
	end

	if slot1 then
		slot0.affixGroupList_:StartScroll(#slot0.monster_affix)
		slot0.affixHeroGroupList_:StartScroll(#slot0.hero_affix)
	else
		slot0.affixGroupList_:Refresh()
		slot0.affixHeroGroupList_:Refresh()
	end

	for slot8, slot9 in ipairs(slot0.customData) do
		slot10 = ActivityAffixPoolCfg[slot9]
		slot3 = 0 + slot10.point
		slot4 = 0 + slot10.multiple
	end

	slot0.TxtDifficult.text = tostring(slot3)
	slot0.TxtRate.text = string.format(GetTips("MATRIX_AFFIX_RATE"), slot4 / 10 .. "%")
end

function slot0.IndexAffixOptionalItem(slot0, slot1, slot2)
	slot2:Refresh(ActivityAffixPoolCfg[slot0.customData[slot1]].affix, 2)
end

function slot0.IndexGroupItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.monster_affix[slot1], {}, slot0.customData)
	slot2:RegistCallBack(handler(slot0, slot0.OnChooseCallBack))
end

function slot0.IndexGroupHeroItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.hero_affix[slot1], {}, slot0.customData)
	slot2:RegistCallBack(handler(slot0, slot0.OnChooseCallBack))
end

function slot0.GenerateItems(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot0.pool then
		slot0.pool = {}
	end

	slot6 = #slot0.pool
	slot7 = #slot1

	while slot2 > slot7 do
		if slot6 > 0 then
			slot8 = slot0.pool[slot6]

			slot8.transform_:SetParent(slot5)
			table.insert(slot1, slot8)
			table.remove(slot0.pool, slot6)
		else
			table.insert(slot1, slot3.New(Object.Instantiate(slot4, slot5)))
		end

		slot7 = slot7 + 1
	end

	while slot2 < slot7 do
		slot1[slot7].gameObject_:SetActive(false)
		table.insert(slot0.pool, slot1[slot7])
		table.remove(slot1, slot7)

		slot7 = slot7 - 1
	end

	for slot11 = 1, slot7 do
		slot1[slot11].gameObject_:SetActive(true)
	end
end

function slot0.OnChooseCallBack(slot0, slot1)
	slot3 = ActivityAffixPoolCfg[slot1].affix[1]
	slot4 = false

	for slot8, slot9 in ipairs(slot0.customData) do
		if slot9 == slot1 then
			table.remove(slot0.customData, slot8)

			slot4 = true

			break
		end

		if slot3 == ActivityAffixPoolCfg[slot9].affix[1] then
			slot0.customData[slot8] = slot1
			slot4 = true

			break
		end
	end

	if not slot4 then
		table.insert(slot0.customData, 1, slot1)
	end

	slot0:Refresh()
end

function slot0.Dispose(slot0)
	slot0.affixGroupList_:Dispose()
	slot0.affixHeroGroupList_:Dispose()

	for slot4, slot5 in ipairs(slot0.customItems) do
		slot5:Dispose()
	end

	slot0.customItems = {}

	uv0.super.Dispose(slot0)
end

return slot0
