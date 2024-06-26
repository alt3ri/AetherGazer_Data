manager.net:Bind(50001, function (slot0)
	ChipData:InitData(slot0)
end)

return {
	UpdateChipRed = function ()
		for slot3, slot4 in ipairs(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_MANAGER]) do
			if not table.keyof(ChipData:GetUnlockChipManagerIDList(), slot4) and IsConditionAchieved(ChipCfg[slot4].new_condition) and JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHIP_MANAGER) == false then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHIP_MANAGER, slot4), 1)
			end
		end

		if table.length(ChipData:GetUnlockChipIDList()) <= 0 and manager.redPoint:getTipValue(RedPointConst.CHIP_MANAGER) <= 0 then
			return
		end

		for slot3, slot4 in ipairs(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_CHIP]) do
			if not table.keyof(ChipData:GetUnlockChipIDList(), slot4) and ChipTools.GetChipCanLocked(slot4) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHIP_CHIP, slot4), 1)
			end
		end
	end,
	UnlockChipManager = function (slot0)
		manager.net:SendWithLoadingNew(50002, {
			id = slot0
		}, 50003, function (slot0)
			if isSuccess(slot0.result) then
				ShowTips("CHIP_MANAGER_UNLOCK_SUCCESS")
				ChipData:UnlockChipManager(uv0)
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHIP_MANAGER, uv0), 0)
				print(" UnlockChipManager chipManagerID")
				manager.notify:Invoke(UNLOCK_CHIP_MANAGER)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	UnlockChip = function (slot0)
		manager.net:SendWithLoadingNew(50002, {
			id = slot0
		}, 50003, function (slot0)
			if isSuccess(slot0.result) then
				ShowTips("CHIP_UNLOCK_SUCCESS")
				ChipData:UnlockChip(uv0)
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHIP_CHIP, uv0), 0)
				manager.notify:Invoke(UNLOCK_CHIP)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	UnlockHeroChip = function (slot0)
		manager.net:SendWithLoadingNew(50002, {
			id = slot0
		}, 50003, function (slot0)
			if isSuccess(slot0.result) then
				ShowTips("CHIP_HERO_UNLOCK_SUCCESS")
				ChipData:UnlockHeroChip(uv0)

				slot1 = ChipCfg[uv0]
				slot2 = nil

				manager.redPoint:setTip(ChipCfg[uv0].cost_condition ~= "" and RedPointConst.CHIP_HERO_CURRENCY_CHIP .. "_" .. slot1.spec_char .. "_" .. slot1.role_type_id .. "_" .. uv0 or RedPointConst.CHIP_HERO_CHIP .. "_" .. slot1.spec_char .. "_" .. slot1.role_type_id .. "_" .. uv0, 0)
				uv1.UpdateHeroChipRedPoint()
				manager.notify:CallUpdateFunc(HERO_CHIP_STATUS_UPDATE)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	EnabledChipID = function (slot0, slot1)
		slot3 = false
		slot4 = 0

		for slot10, slot11 in ipairs(ChipData:GetChipManagerList()[slot0]) do
			if ChipCfg[slot11].spec_char ~= 0 and table.keyof(ChipCfg.get_id_list_by_spec_char[ChipCfg[slot1].spec_char], slot11) and slot11 ~= slot1 then
				slot3 = true
				slot4 = slot11

				break
			end
		end

		if not table.keyof(slot2, slot1) and not slot3 and GameSetting.ai_secondary_chip_equip_num.value[1] <= #slot2 then
			ShowTips("CHIP_CNT_MORE_THEN_MAX")

			return
		end

		manager.net:SendWithLoadingNew(50006, {
			kernel_id = slot0,
			secondary_id = slot1,
			oper = slot7 and 2 or 1
		}, 50007, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 then
					ChipData:RemoveChipID(uv1, uv2)
					ShowTips("CHIP_USE_SUCCESS")
					ChipData:SetEnabledChipID(uv1, uv3)
				elseif uv4 then
					ShowTips("CHIP_UNLOAD_SUCCESS")
					ChipData:RemoveChipID(uv1, uv3)
				else
					ShowTips("CHIP_USE_SUCCESS")
					ChipData:SetEnabledChipID(uv1, uv3)
				end

				manager.notify:Invoke(ENABLED_CHIP)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	EnabledHeroChip = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(50018, {
			hero_id = slot0,
			slot_id = slot2,
			secondary = slot1
		}, 50019, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 == 0 then
					ShowTips("CHIP_HERO_UNLOAD_SUCCESS")
				else
					ShowTips("CHIP_HERO_USE_SUCCESS")
				end

				ChipData:EnableHeroChip(uv1, uv0, uv2)
				manager.notify:CallUpdateFunc(HERO_CHIP_STATUS_UPDATE)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	EnabledSchemeID = function (slot0, slot1)
		manager.net:SendWithLoadingNew(50014, {
			kernel_chip_id = slot0,
			proposal_id = slot1
		}, 50015, function (slot0)
			if isSuccess(slot0.result) then
				ShowTips("USE_SCHEME_SUCCESS")
				uv1.ResetChip(uv2)

				for slot5, slot6 in ipairs(ChipData:GetSchemeList()[uv0].chipList) do
					ChipData:SetEnabledChipID(uv2, slot6)
				end

				manager.notify:Invoke(ENABLED_SCHEME)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ResetChipManager = function (slot0)
		manager.net:SendWithLoadingNew(50016, {
			kernel_id = slot0
		}, 50017, function (slot0)
			if isSuccess(slot0.result) then
				ShowTips("CHIP_UNLOAD_SUCCESS")
				uv0.ResetChip(uv1)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ResetChip = function (slot0)
		ChipData:ResetChipManager(slot0)
		manager.notify:Invoke(ENABLED_CHIP)
	end,
	SaveChipScheme = function (slot0)
		manager.net:SendWithLoadingNew(50008, {
			id = slot0.id,
			name = slot0.name,
			secondary = slot0.chipList
		}, 50009, function (slot0)
			if isSuccess(slot0.result) then
				ShowTips("SAVE_SCHEME_SUCCESS")
				ChipData:SaveChipScheme(clone(uv0))
				manager.notify:Invoke(SAVE_CHIP_SCHEME, uv0.id)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	RenameChipScheme = function (slot0, slot1)
		manager.net:SendWithLoadingNew(50012, {
			id = slot0,
			name = slot1
		}, 50013, function (slot0)
			if isSuccess(slot0.result) then
				ShowTips("SAVE_SCHEME_SUCCESS")
				ChipData:RenameChipScheme(uv0, uv1)
				manager.notify:Invoke(RENAME_CHIP_SCHEME, uv0)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	DeleteChipScheme = function (slot0)
		manager.net:SendWithLoadingNew(50010, {
			id = slot0
		}, 50011, function (slot0)
			if isSuccess(slot0.result) then
				ShowTips("DELETE_CHIP_SCHEME_SUCCESS")
				ChipData:DeleteChipScheme(uv0)
				manager.notify:Invoke(DELETE_CHIP_SCHEME)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	UpdateHeroChipRedPoint = function ()
		for slot4, slot5 in pairs(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_HERO_CHIP]) do
			if not table.keyof(ChipData:GetUnlockHeroChipIDList(), slot5) then
				slot6 = ChipCfg[slot5]
				slot7 = nil
				slot8 = nil

				if (ChipCfg[slot5].new_condition <= 0 or (ChipCfg[slot5].spec_char <= 0 or IsConditionAchieved(slot6.new_condition, {
					heroId = ChipCfg[slot5].spec_char
				})) and IsConditionAchieved(ChipCfg[slot5].new_condition)) and (ChipCfg[slot5].cost_condition[1][2] <= ItemTools.getItemNum(ChipCfg[slot5].cost_condition[1][1]) and true or false) then
					manager.redPoint:setTip(ChipCfg[slot5].cost_condition ~= "" and RedPointConst.CHIP_HERO_CURRENCY_CHIP .. "_" .. slot6.spec_char .. "_" .. slot6.role_type_id .. "_" .. slot5 or RedPointConst.CHIP_HERO_CHIP .. "_" .. slot6.spec_char .. "_" .. slot6.role_type_id .. "_" .. slot5, 1)
				else
					manager.redPoint:setTip(slot8, 0)
				end
			end
		end
	end
}
