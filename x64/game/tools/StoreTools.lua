return {
	getHideItemIDList = function ()
		return {
			InviteData:GetDataByPara("drawItemId"),
			30011
		}
	end,
	getMaterialList = function ()
		slot6 = ItemConst.ITEM_STORE_MATERIAL_IGNORE

		for slot5, slot6 in pairs(uv0.GetMaterialListExceptTypes(slot6)) do
			if slot6.num > 0 and not table.keyof(uv0.getHideItemIDList(), slot6.id) then
				slot7 = clone(ItemTemplateData)
				slot7.id = slot6.id
				slot7.number = slot6.num
				slot7.timeValid = slot6.timeValid or 0

				table.insert({}, slot7)
			end
		end

		for slot5, slot6 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.DROP_TICKET] or {}) do
			if ItemTools.getItemNum(slot6) > 0 and slot1[slot6] ~= true then
				slot8 = clone(ItemTemplateData)
				slot8.id = slot6
				slot8.number = slot7

				table.insert(slot0, slot8)
			end
		end

		for slot5, slot6 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.CHANGE_NAME_CARD] or {}) do
			if ItemTools.getItemNum(slot6) > 0 and slot1[slot6] ~= true then
				slot8 = clone(ItemTemplateData)
				slot8.id = slot6
				slot8.number = slot7

				table.insert(slot0, slot8)
			end
		end

		for slot5, slot6 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PERIODICITY_EXPLORE_TICKER_INSTANCE] or {}) do
			if CurrencyData:GetTimeVaildCurrencyListBySubTypes(slot6) and slot1[slot6] ~= true then
				for slot11, slot12 in pairs(slot7) do
					if slot12.num > 0 then
						slot13 = clone(ItemTemplateData)
						slot13.id = slot12.id
						slot13.number = slot12.num
						slot13.timeValid = slot12.timeValid or 0

						table.insert(slot0, slot13)
					end
				end
			end
		end

		for slot6, slot7 in pairs(FukubukuroData:GetFukuburoList()) do
			slot8 = clone(ItemTemplateData)
			slot8.id = slot7.item_id
			slot8.number = 1
			slot8.instance_id = slot7.instance_id

			table.insert(slot0, slot8)
		end

		return slot0
	end,
	getMaterialMinTimestamp = function ()
		if #CurrencyData:CheckExpiredCurrencyList() > 0 or #MaterialData:CheckExpiredMaterialList() > 0 then
			return 0
		end

		for slot5, slot6 in ipairs(uv0.getMaterialList()) do
			if ItemTools.GetItemExpiredTimeByInfo(slot6) ~= 0 then
				if nil == nil then
					slot1 = slot7
				elseif slot7 < slot1 then
					slot1 = slot7
				end
			end
		end

		return slot1
	end,
	GetMaterialListExceptTypes = function (slot0)
		slot1 = {}

		for slot6, slot7 in pairs(MaterialData:MaterialList()) do
			slot8 = ItemCfg[slot6]

			if not slot0.type[slot8.type] and not slot0.subType[slot8.sub_type] then
				for slot14, slot15 in pairs(slot7) do
					table.insert(slot1, {
						id = slot6,
						num = slot15,
						timeValid = slot14
					})
				end
			end
		end

		return slot1
	end,
	GetMaterialListByTypes = function (slot0)
		slot1 = {}

		for slot6, slot7 in pairs(MaterialData:MaterialList()) do
			if table.indexof(slot0, ItemCfg[slot6].type) then
				for slot13, slot14 in pairs(slot7) do
					table.insert(slot1, {
						id = slot6,
						num = slot14,
						timeValid = slot13
					})
				end
			end
		end

		return slot1
	end,
	GetMaterialListBySubTypes = function (slot0)
		slot1 = {}

		for slot6, slot7 in pairs(MaterialData:MaterialList()) do
			if table.indexof(slot0, ItemCfg[slot6].sub_type) then
				for slot13, slot14 in pairs(slot7) do
					table.insert(slot1, {
						id = slot6,
						num = slot14,
						timeValid = slot13
					})
				end
			end
		end

		return slot1
	end
}
