slot0 = class("DrawInfoPopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Pool/PoolInfoPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.probabilityCfgList = {}
	slot0.items = {}
	slot0.stateCon_ = slot0.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgMask_, nil, function ()
		uv0.stateCon_:SetSelectedState("info")
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.btnInfo_, nil, function ()
		uv0.stateCon_:SetSelectedState("info")
	end)
	slot0:AddBtnListener(slot0.btnMessage_, nil, function ()
		uv0.stateCon_:SetSelectedState("message")
	end)
end

function slot0.OnEnter(slot0)
	slot1 = slot0.params_.poolId
	slot2 = DrawData:GetPoolData(slot1)

	slot0:RefreshInfo(slot1, slot2)
	slot0:RefreshMessage(slot1, slot2)
	TimeTools.StartAfterSeconds(0.033, function ()
		uv0.contentTrs_.localPosition = Vector3.New(0, 0, 0)
	end, {})
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_1)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_2)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_3)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_4)
end

function slot0.RefreshInfo(slot0, slot1, slot2)
	if SettingData:GetCurrentLanguage() == "jp" or slot4 == "en" or slot4 == "de" or slot4 == "fr" then
		slot0.infoTxt_.text = GetI18NText(DrawPoolCfg[slot1].detail_note)
	else
		slot0:SetInfoText(slot3, slot2)
	end
end

function slot0.RefreshMessage(slot0, slot1, slot2)
	for slot8 = 1, #slot0:GetProbabilityList(slot1, slot2) do
		if not slot0.items[slot8] then
			slot0.items[slot8] = DrawInfoMessageItem.New(Object.Instantiate(slot0.msgItem_, slot0.contentTrs_))
		end

		slot0.items[slot8]:RefreshData(slot3[slot8])
	end

	for slot8 = slot4 + 1, #slot0.items do
		slot0.items[slot8]:Show(false)
	end
end

function slot0.GetProbabilityList(slot0, slot1, slot2)
	slot4 = {}

	if DrawPoolCfg[slot1].pool_type == 2 then
		slot5 = {
			define = "DRAW_POOL_PROBABILITY_FIVE_WEAPON",
			poolId = slot1,
			name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FIVE_WEAPON_1].desc,
			probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FIVE_WEAPON_2].desc,
			probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FIVE_WEAPON_3].desc,
			s_up_servant = {},
			s_all_servant = {}
		}

		if slot2.s_up_item then
			for slot9, slot10 in ipairs(slot2.s_up_item) do
				table.insert(slot5.s_up_servant, slot10)
				table.insert(slot5.s_all_servant, slot10)
			end

			if slot2.s_other_item then
				for slot9, slot10 in ipairs(slot2.s_other_item) do
					table.insert(slot5.s_all_servant, slot10)
				end
			end
		else
			for slot9, slot10 in ipairs(slot2.s_other_item) do
				table.insert(slot5.s_all_servant, slot10)
			end
		end

		table.insert(slot4, slot5)

		slot5 = {
			define = "DRAW_POOL_PROBABILITY_FOUR_WEAPON",
			poolId = slot1,
			name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FOUR_WEAPON_1].desc,
			probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FOUR_WEAPON_2].desc,
			probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FOUR_WEAPON_3].desc,
			a_up_servant = {},
			a_all_servant = {}
		}

		if slot2.a_up_item then
			for slot9, slot10 in ipairs(slot2.a_up_item) do
				table.insert(slot5.a_up_servant, slot10)
				table.insert(slot5.a_all_servant, slot10)
			end

			if slot2.a_other_item then
				for slot9, slot10 in ipairs(slot2.a_other_item) do
					table.insert(slot5.a_all_servant, slot10)
				end
			end
		else
			for slot9, slot10 in ipairs(slot2.a_other_item) do
				table.insert(slot5.a_all_servant, slot10)
			end
		end

		table.insert(slot4, slot5)

		slot5 = {
			define = "DRAW_POOL_PROBABILITY_THREE_WEAPON",
			poolId = slot1,
			name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_THREE_WEAPON_1].desc,
			probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_THREE_WEAPON_2].desc,
			b_servant = {}
		}

		if slot2.b_item then
			for slot9, slot10 in ipairs(slot2.b_item) do
				if DrawItemCfg[slot10].pool_id ~= 301 then
					table.insert(slot5.b_servant, slot10)
				end
			end
		end

		table.insert(slot4, slot5)
	elseif slot3 == 8 then
		slot5 = {
			define = "DRAW_POOL_PROBABILITY_S",
			poolId = slot1,
			name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_1].desc,
			probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_2].desc,
			probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_6].desc,
			s_up_probability = slot2.s_up_probability,
			s_up_hero = {},
			s_all_hero = {}
		}

		if slot2.s_up_item then
			for slot9, slot10 in ipairs(slot2.s_up_item) do
				table.insert(slot5.s_up_hero, slot10)
				table.insert(slot5.s_all_hero, slot10)
			end

			if slot2.s_other_item then
				for slot9, slot10 in ipairs(slot2.s_other_item) do
					table.insert(slot5.s_all_hero, slot10)
				end
			end
		else
			for slot9, slot10 in ipairs(slot2.s_other_item) do
				table.insert(slot5.s_all_hero, slot10)
			end
		end

		table.insert(slot4, slot5)

		slot5 = {
			define = "DRAW_POOL_PROBABILITY_A",
			poolId = slot1,
			name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_1].desc,
			probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_2].desc,
			probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_3].desc,
			a_up_probability = slot2.a_up_probability,
			a_up_hero = {},
			a_all_hero = {}
		}

		if slot2.a_up_item then
			for slot9, slot10 in ipairs(slot2.a_up_item) do
				table.insert(slot5.a_up_hero, slot10)
				table.insert(slot5.a_all_hero, slot10)
			end

			if slot2.a_other_item then
				for slot9, slot10 in ipairs(slot2.a_other_item) do
					table.insert(slot5.a_all_hero, slot10)
				end
			end
		else
			for slot9, slot10 in ipairs(slot2.a_other_item) do
				table.insert(slot5.a_all_hero, slot10)
			end
		end

		table.insert(slot4, slot5)

		slot5 = {
			define = "DRAW_POOL_PROBABILITY_B",
			poolId = slot1,
			name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_B_1].desc,
			probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_B_2].desc,
			b_hero = {}
		}

		if slot2.b_item then
			for slot9, slot10 in ipairs(slot2.b_item) do
				if DrawItemCfg[slot10].pool_id == 301 then
					table.insert(slot5.b_hero, slot10)
				end
			end
		end

		table.insert(slot4, slot5)

		slot5 = {
			define = "DRAW_POOL_PROBABILITY_C",
			poolId = slot1,
			name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_C_1].desc,
			probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_C_2].desc,
			b_servant = {}
		}

		if slot2.b_item then
			for slot9, slot10 in ipairs(slot2.b_item) do
				if DrawItemCfg[slot10].pool_id ~= 301 then
					table.insert(slot5.b_servant, slot10)
				end
			end
		end

		table.insert(slot4, slot5)
	else
		slot5 = {
			define = "DRAW_POOL_PROBABILITY_S",
			poolId = slot1,
			name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_1].desc,
			probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_2].desc,
			probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_3].desc,
			s_up_probability = slot2.s_up_probability,
			s_up_hero = {},
			s_all_hero = {}
		}

		if slot2.s_up_item then
			for slot9, slot10 in ipairs(slot2.s_up_item) do
				table.insert(slot5.s_up_hero, slot10)
				table.insert(slot5.s_all_hero, slot10)
			end

			if slot2.s_other_item then
				for slot9, slot10 in ipairs(slot2.s_other_item) do
					table.insert(slot5.s_all_hero, slot10)
				end
			end
		else
			for slot9, slot10 in ipairs(slot2.s_other_item) do
				table.insert(slot5.s_all_hero, slot10)
			end
		end

		table.insert(slot4, slot5)

		slot5 = {
			define = "DRAW_POOL_PROBABILITY_A",
			poolId = slot1,
			name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_1].desc,
			probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_2].desc,
			probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_3].desc,
			a_up_probability = slot2.a_up_probability,
			a_up_hero = {},
			a_all_hero = {}
		}

		if slot2.a_up_item then
			for slot9, slot10 in ipairs(slot2.a_up_item) do
				table.insert(slot5.a_up_hero, slot10)
				table.insert(slot5.a_all_hero, slot10)
			end

			if slot2.a_other_item then
				for slot9, slot10 in ipairs(slot2.a_other_item) do
					table.insert(slot5.a_all_hero, slot10)
				end
			end
		else
			for slot9, slot10 in ipairs(slot2.a_other_item) do
				table.insert(slot5.a_all_hero, slot10)
			end
		end

		table.insert(slot4, slot5)

		slot5 = {
			define = "DRAW_POOL_PROBABILITY_B",
			poolId = slot1,
			name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_B_1].desc,
			probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_B_2].desc,
			b_hero = {}
		}

		if slot2.b_item then
			for slot9, slot10 in ipairs(slot2.b_item) do
				if DrawItemCfg[slot10].pool_id == 301 then
					table.insert(slot5.b_hero, slot10)
				end
			end
		end

		table.insert(slot4, slot5)

		slot5 = {
			define = "DRAW_POOL_PROBABILITY_C",
			poolId = slot1,
			name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_C_1].desc,
			probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_C_2].desc,
			b_servant = {}
		}

		if slot2.b_item then
			for slot9, slot10 in ipairs(slot2.b_item) do
				if DrawItemCfg[slot10].pool_id ~= 301 then
					table.insert(slot5.b_servant, slot10)
				end
			end
		end

		table.insert(slot4, slot5)
	end

	slot0.probabilityCfgList[slot1] = slot4

	return slot4
end

function slot0.SetInfoText(slot0, slot1, slot2)
	slot3 = slot1.draw_pool_desc

	for slot7 = 1, 15 do
		if slot3 == "DRAW_POOL_DESC_TEMP_FIXED_" .. slot7 then
			slot0.infoTxt_.text = GetTips(slot3)
		end
	end

	if slot3 == "DRAW_POOL_DESC_TEMP_1" then
		slot6 = HeroTools.GetHeroFullName(DrawItemCfg[slot2.s_up_item[1]].item_id)
		slot0.infoTxt_.text = string.format(GetTips(slot3), slot6, slot6)

		return
	elseif slot3 == "DRAW_POOL_DESC_TEMP_2" then
		slot0:DescModule(slot1, slot2)

		return
	elseif slot3 == "DRAW_POOL_DESC_TEMP_3" then
		slot0:DescModule(slot1, slot2)

		return
	elseif slot3 == "DRAW_POOL_DESC_TEMP_4" then
		slot0:DescModule(slot1, slot2)

		return
	elseif slot3 == "DRAW_POOL_DESC_TEMP_5" then
		slot0:DescModule(slot1, slot2)

		return
	elseif slot3 == "DRAW_POOL_DESC_TEMP_6" then
		slot0:DescModule(slot1, slot2)

		return
	elseif slot3 == "DRAW_POOL_DESC_TEMP_7" then
		slot0:DescModule(slot1, slot2)

		return
	end
end

function slot0.DescModule(slot0, slot1, slot2)
	slot4 = GetI18NText(slot1.name)
	slot7 = HeroTools.GetHeroFullName(DrawItemCfg[slot2.s_up_item[1]].item_id)
	slot10 = HeroTools.GetHeroFullName(DrawItemCfg[slot2.a_up_item[1]].item_id)
	slot13 = HeroTools.GetHeroFullName(DrawItemCfg[slot2.a_up_item[2]].item_id)
	slot16 = HeroTools.GetHeroFullName(DrawItemCfg[slot2.a_up_item[3]].item_id)
	slot0.infoTxt_.text = string.format(GetTips(slot1.draw_pool_desc), slot4, slot7, slot10, slot13, slot16, slot4, slot2.s_up_probability .. "%", slot7, slot2.a_up_probability .. "%", slot10, slot13, slot16, slot4)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.items then
		for slot4, slot5 in ipairs(slot0.items) do
			slot5:Dispose()
		end

		slot0.items = nil
	end

	if slot0.probabilityCfgList then
		for slot4, slot5 in ipairs(slot0.probabilityCfgList) do
			slot5 = nil
		end
	end
end

return slot0
