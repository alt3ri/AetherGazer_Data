slot0 = class("ActivityMatrixSelectAffixView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/SoloRoguelike/AactivityMatrixSelectAffixUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.affixRegularList_ = LuaList.New(handler(slot0, slot0.IndexAffixWeekItem), slot0.m_weekList, MatrixAffixLongItem)
	slot0.affixGroupList_ = LuaList.New(handler(slot0, slot0.IndexGroupItem), slot0.m_list, MatrixAffixGroupItem)
	slot0.affixHeroGroupList_ = LuaList.New(handler(slot0, slot0.IndexGroupHeroIitem), slot0.m_heroList, MatrixAffixGroupItem)
	slot0.lockController = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.customData = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_okBtn, nil, function ()
		ActivityMatrixAction.QueryStartMatrix(uv0.params_.select_hero_list, uv0.matrix_activity_id, uv0.customData)
	end)
end

function slot0.Reset(slot0)
	slot0.customData = {}

	slot0:ClearItems()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
end

function slot0.OnEnter(slot0)
	slot0.customData = {}

	slot0:Reset()

	slot0.matrix_activity_id = slot0.params_.matrix_activity_id
	slot0.regularData = {}
	slot2 = {}
	slot3 = {}

	for slot8, slot9 in ipairs(ActivityMatrixCfg[slot0.matrix_activity_id].custom_affix) do
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

	for slot8, slot9 in ipairs(slot0.regularData) do
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

	slot0.chooseData = {}
	slot0.chooseData_hero = {}

	for slot8, slot9 in pairs(slot2) do
		table.sort(slot9, function (slot0, slot1)
			return slot1 < slot0
		end)
		table.insert(slot0.chooseData, {
			id = slot8,
			list = slot9
		})
	end

	for slot8, slot9 in pairs(slot3) do
		table.sort(slot9, function (slot0, slot1)
			return slot1 < slot0
		end)
		table.insert(slot0.chooseData_hero, {
			id = slot8,
			list = slot9
		})
	end

	slot0:Refresh(true)
	slot0.lockController:SetSelectedIndex(0)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Refresh(slot0, slot1)
	if slot1 then
		slot0.affixRegularList_:StartScroll(#slot0.regularData)
		slot0.affixGroupList_:StartScroll(#slot0.chooseData)
		slot0.affixHeroGroupList_:StartScroll(#slot0.chooseData_hero)
	else
		slot0.affixRegularList_:StartScrollByPosition(#slot0.regularData, slot0.affixRegularList_:GetScrolledPosition())
		slot0.affixGroupList_:Refresh()
		slot0.affixHeroGroupList_:Refresh()
	end

	for slot7, slot8 in ipairs(slot0.regularData) do
		slot9 = ActivityAffixPoolCfg[slot8]
		slot2 = 0 + slot9.point
		slot3 = 0 + slot9.multiple
	end

	for slot7, slot8 in ipairs(slot0.customData) do
		slot9 = ActivityAffixPoolCfg[slot8]
		slot2 = slot2 + slot9.point
		slot3 = slot3 + slot9.multiple
	end

	slot0.m_scoreLab.text = "" .. slot2
	slot0.m_retaLab.text = string.format(GetTips("MATRIX_AFFIX_RATE"), slot3 / 10 .. "%")

	if not slot1 then
		slot0:RefreshItems()
	end
end

function slot0.IndexAffixWeekItem(slot0, slot1, slot2)
	slot2:Refresh(ActivityAffixPoolCfg[slot0.regularData[slot1]].affix, 2)
end

function slot0.IndexAffixOptionalItem(slot0, slot1, slot2)
	slot2:Refresh(ActivityAffixPoolCfg[slot0.customData[slot1]].affix, 2)
end

function slot0.IndexGroupItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.chooseData[slot1], slot0.regularData, slot0.customData)
	slot2:RegistCallBack(handler(slot0, slot0.OnChooseCallBack))
end

function slot0.IndexGroupHeroIitem(slot0, slot1, slot2)
	slot2:Refresh(slot0.chooseData_hero[slot1], slot0.regularData, slot0.customData)
	slot2:RegistCallBack(handler(slot0, slot0.OnChooseCallBack))
end

function slot0.OnChooseCallBack(slot0, slot1)
	for slot7, slot8 in ipairs(slot0.regularData) do
		if ActivityAffixPoolCfg[slot1].affix[1] == ActivityAffixPoolCfg[slot8].affix[1] then
			return
		end
	end

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

function slot0.StartScroll(slot0)
end

function slot0.StartScrollByPosition(slot0)
end

function slot0.RefreshItems(slot0)
	slot1 = slot0.m_content.childCount

	print(slot1)

	for slot5 = 0, slot1 - 1 do
		slot0.m_content:GetChild(slot5).gameObject:SetActive(false)
	end

	print(slot1)

	slot3 = nil

	if slot1 < #slot0.customData then
		for slot7 = 1, slot2 - slot1 do
			Object.Instantiate(slot0.m_item.gameObject, slot0.m_content.transform):SetActive(true)
		end
	end

	slot4 = 0
	slot5 = nil

	for slot9, slot10 in pairs(slot0.customData) do
		slot3 = slot0.m_content:GetChild(slot4).gameObject
		slot4 = slot4 + 1

		slot3:SetActive(true)
		MatrixAffixLongItem.New(slot3):Refresh(ActivityAffixPoolCfg[slot10].affix, 2)
	end

	slot9 = "RectTransform"

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_content:GetComponent(slot9))

	for slot9 = 0, slot1 - 1 do
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_content:GetChild(slot9))
	end
end

function slot0.ClearItems(slot0)
	slot1 = slot0.m_content.childCount

	print(slot1)

	for slot5 = 0, slot1 - 1 do
		slot0.m_content:GetChild(slot5).gameObject:SetActive(false)
	end
end

function slot0.Dispose(slot0)
	slot0.affixRegularList_:Dispose()
	slot0.affixGroupList_:Dispose()
	slot0.affixHeroGroupList_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
