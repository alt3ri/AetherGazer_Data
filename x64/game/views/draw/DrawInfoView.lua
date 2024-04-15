slot0 = class("DrawInfoView", ReduxView)

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
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot1 = slot0.params_.poolId

	slot0:RefreshData(slot1, DrawData:GetPoolData(slot1))
end

function slot0.RefreshData(slot0, slot1, slot2)
	if not DrawPoolCfg[slot1] then
		return
	end

	slot0.labDetailNote_.text = GetI18NText(slot3.detail_note)

	for slot9 = 1, #slot0:GetProbabilityList(slot1, slot2) do
		if not slot0.items[slot9] then
			slot0.items[slot9] = DrawProbabilityItem.New(Object.Instantiate(slot0.item_, slot0.itemParent_))
		end

		slot0.items[slot9]:RefreshData(slot4[slot9])
	end

	for slot9 = slot5 + 1, #slot0.items do
		slot0.items[slot9]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_6)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_5)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_4)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_3)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_2)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_1)
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
			itemid_ = {}
		}

		if slot2.s_up_item then
			for slot9, slot10 in ipairs(slot2.s_up_item) do
				table.insert(slot5.itemid_, slot10)
			end

			if slot2.s_other_item then
				for slot9, slot10 in ipairs(slot2.s_other_item) do
					table.insert(slot5.itemid_, slot10)
				end
			end
		else
			for slot9, slot10 in ipairs(slot2.s_other_item) do
				table.insert(slot5.itemid_, slot10)
			end
		end

		table.insert(slot4, slot5)

		slot5 = {
			define = "DRAW_POOL_PROBABILITY_FOUR_WEAPON",
			poolId = slot1,
			name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FOUR_WEAPON_1].desc,
			probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FOUR_WEAPON_2].desc,
			probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FOUR_WEAPON_3].desc,
			itemid_ = {}
		}

		if slot2.a_up_item then
			for slot9, slot10 in ipairs(slot2.a_up_item) do
				table.insert(slot5.itemid_, slot10)
			end

			if slot2.a_other_item then
				for slot9, slot10 in ipairs(slot2.a_other_item) do
					table.insert(slot5.itemid_, slot10)
				end
			end
		else
			for slot9, slot10 in ipairs(slot2.a_other_item) do
				table.insert(slot5.itemid_, slot10)
			end
		end

		table.insert(slot4, slot5)

		slot5 = {
			define = "DRAW_POOL_PROBABILITY_THREE_WEAPON",
			poolId = slot1,
			name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_THREE_WEAPON_1].desc,
			probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_THREE_WEAPON_2].desc,
			itemid_ = {}
		}

		if slot2.b_item then
			for slot9, slot10 in ipairs(slot2.b_item) do
				if DrawItemCfg[slot10].pool_id ~= 301 then
					table.insert(slot5.itemid_, slot10)
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
			itemid_ = {}
		}

		if slot2.s_up_item then
			for slot9, slot10 in ipairs(slot2.s_up_item) do
				table.insert(slot5.itemid_, slot10)
			end

			if slot2.s_other_item then
				for slot9, slot10 in ipairs(slot2.s_other_item) do
					table.insert(slot5.itemid_, slot10)
				end
			end
		else
			for slot9, slot10 in ipairs(slot2.s_other_item) do
				table.insert(slot5.itemid_, slot10)
			end
		end

		table.insert(slot4, slot5)

		slot5 = {
			define = "DRAW_POOL_PROBABILITY_A",
			poolId = slot1,
			name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_1].desc,
			probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_2].desc,
			probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_3].desc,
			itemid_ = {}
		}

		if slot2.a_up_item then
			for slot9, slot10 in ipairs(slot2.a_up_item) do
				table.insert(slot5.itemid_, slot10)
			end

			if slot2.a_other_item then
				for slot9, slot10 in ipairs(slot2.a_other_item) do
					table.insert(slot5.itemid_, slot10)
				end
			end
		else
			for slot9, slot10 in ipairs(slot2.a_other_item) do
				table.insert(slot5.itemid_, slot10)
			end
		end

		table.insert(slot4, slot5)

		slot5 = {
			define = "DRAW_POOL_PROBABILITY_B",
			poolId = slot1,
			name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_B_1].desc,
			probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_B_2].desc,
			itemid_ = {}
		}

		if slot2.b_item then
			for slot9, slot10 in ipairs(slot2.b_item) do
				if DrawItemCfg[slot10].pool_id == 301 then
					table.insert(slot5.itemid_, slot10)
				end
			end
		end

		table.insert(slot4, slot5)

		slot5 = {
			define = "DRAW_POOL_PROBABILITY_C",
			poolId = slot1,
			name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_C_1].desc,
			probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_C_2].desc,
			itemid_ = {}
		}

		if slot2.b_item then
			for slot9, slot10 in ipairs(slot2.b_item) do
				if DrawItemCfg[slot10].pool_id ~= 301 then
					table.insert(slot5.itemid_, slot10)
				end
			end
		end

		table.insert(slot4, slot5)
	end

	slot0.probabilityCfgList[slot1] = slot4

	return slot4
end

function slot0.Dispose(slot0)
	if slot0.items then
		for slot4, slot5 in ipairs(slot0.items) do
			slot5:Dispose()
		end

		slot0.items = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
