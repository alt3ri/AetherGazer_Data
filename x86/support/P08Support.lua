function formatRewardCfgList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0) do
		table.insert(slot1, formatReward(slot6))
	end

	return slot1
end

function unformatRewardCfgList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0) do
		table.insert(slot1, {
			slot6.id,
			slot6.num,
			[4] = slot6.time_valid
		})
	end

	return slot1
end

function formatReward(slot0)
	if slot0[1] then
		return {
			id = slot0[1],
			num = slot0[2],
			time_valid = slot0[4]
		}
	elseif slot0.id then
		return slot0
	end

	error("传入的reward结构既非{id:number, num:number, timeValid:number}也非number[4]")
end

function rewardToItemTemplate(slot0, slot1)
	slot2 = slot1 or clone(ItemTemplateData)
	slot2.id = slot0.id
	slot2.number = slot0.num
	slot2.timeValid = slot0.time_valid

	return slot2
end

function getReward(slot0, slot1, slot2, slot3, slot4)
	if type(slot2) ~= "function" then
		slot2 = nil
	end

	if slot0 and #slot0 > 0 then
		showRewardUI(slot0, slot1, slot2, slot3)
	end
end

getReward2 = getReward

function sortMergeGetReward(slot0, slot1, slot2, slot3, slot4)
	slot0 = mergeReward(slot0)

	sortReward(slot0, true)
	getReward(slot0, slot1, slot2, slot3, slot4)
end

function showRewardUI(slot0, slot1, slot2, slot3)
	slot4 = {}
	slot6 = slot2
	slot7 = {}

	for slot11, slot12 in ipairs(slot0) do
		slot14 = ItemCfg[ItemWillConvert(slot12) and slot12.convert_from.id or slot12.id]

		if slot1 ~= nil and #slot1 > 0 and table.indexof(slot1, slot14.type) then
			if ItemConst.ITEM_TYPE.WEAPON_SERVANT == slot14.type then
				if slot14.display_rare > 3 or IllustratedData:GetNewObtainedServant(slot13) then
					table.insert({}, slot12)
				end
			else
				table.insert(slot5, slot12)
			end
		end

		if slot14.type == 8 and slot14.id ~= slot14.param[1] then
			function slot6()
				if uv0 then
					uv0()
				end

				PlayerAction.RefreshSkinGiftRedPoint()
			end

			table.insert(slot5, slot12)
		end

		if slot14.type == 21 then
			slot7.HasDlc = true
			slot7.dlcCfg = slot14
		end
	end

	slot8 = nil

	for slot13, slot14 in ipairs(slot0) do
		if ItemCfg[slot14.id].sub_type == ItemConst.ITEM_SUB_TYPE.LIMIT_TIME_SKIN_ITEM then
			slot8 = slot14
			slot9 = 0 + 1
		end
	end

	if slot9 == 1 then
		slot10 = deepClone(slot6)

		function slot6()
			if uv0 then
				uv0()
			end

			JumpTools.OpenPageByJump("limitTimeSkinUsePop", {
				itemData = uv1
			})
		end
	end

	IllustratedData:ConsumeNewObtainedServant()

	if #slot5 > 0 then
		gameContext:Go("obtainView", {
			doNextHandler = function ()
				JumpTools.OpenPageByJump("switchHeroReward", {
					list = uv0,
					needShowVitalityBox = needShowVitalityFullBox(),
					needShowEquipBox = needShowBagFullBox(),
					callBack = uv1,
					lateCallback = uv2
				})
			end,
			itemList = slot5,
			obtainsParams = slot7
		})
	else
		JumpTools.OpenPageByJump("switchHeroReward", {
			list = slot0,
			needShowVitalityBox = needShowVitalityFullBox(),
			needShowEquipBox = needShowBagFullBox(),
			callBack = slot6,
			lateCallback = slot3
		})
	end
end

function rewardSortFunc(slot0, slot1)
	if ItemCfg[slot0.id].rare ~= ItemCfg[slot1.id].rare then
		return slot7 < slot6
	end

	if slot4.type ~= slot5.type then
		return slot8 < slot9
	elseif slot8 == ItemConst.ITEM_TYPE.EQUIP then
		slot10 = 0
		slot11 = 0

		if EquipCfg[slot2].starlevel == EquipCfg[slot3].starlevel then
			return slot3 < slot2
		else
			return slot11 < slot10
		end
	else
		return slot3 < slot2
	end
end

function sortReward(slot0, slot1)
	slot2 = slot1 and slot0 or clone(slot0)

	table.sort(slot2, rewardSortFunc)

	return slot2
end

function getItemStar(slot0)
	slot2 = 0

	if ItemCfg[slot0].type == ItemConst.ITEM_TYPE.EQUIP then
		slot2 = EquipCfg[slot0].starlevel
	end

	if slot2 > 6 then
		slot2 = 6
	end

	return slot2
end

function ItemWillConvert(slot0)
	return (nullable(slot0, "convert_from", "id") or 0) ~= 0
end

function slot0(slot0, slot1)
	slot2 = slot1.id
	slot3 = slot1.num
	slot4 = slot1.time_valid
	slot5 = ItemCfg[slot2]

	if ItemCfg[slot2].type == ItemConst.ITEM_TYPE.EQUIP then
		return false
	elseif slot2 ~= slot0.id then
		return false
	elseif slot4 ~= slot0.time_valid then
		return false
	elseif ItemWillConvert(slot0) or ItemWillConvert(slot1) then
		return false
	end

	return true
end

function mergeRewardList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = false

		for slot11, slot12 in ipairs(slot0) do
			if uv0(slot12, slot6) then
				slot12.num = slot6.num + slot12.num
				slot7 = true

				break
			end
		end

		if slot7 == false then
			table.insert(slot0, slot6)
		end
	end

	return slot0
end

function mergeReward(slot0)
	return mergeRewardList({}, slot0)
end

mergeReward2 = mergeReward

function IsConditionAchieved(slot0, slot1)
	if ConditionCfg[slot0] == nil then
		return true, 0, 0
	end

	slot3 = false
	slot4 = 0
	slot5 = slot2.params[1]

	if slot2.type == 1001 then
		slot3 = slot2.params[1] <= HeroData:GetHeroData(slot1.heroId).level
	elseif slot2.type == 1004 then
		slot3 = slot2.params[1] <= HeroTools.GetHeroProficiency(slot1.heroId)
	elseif slot2.type == 1002 then
		slot3 = slot2.params[1] <= HeroTools.CountHeroTotalSkilllv(slot1.heroId)
	elseif slot2.type == 1003 then
		slot3 = slot2.params[1] <= HeroData:GetHeroData(slot1.heroId).star / 100
	elseif slot2.type == 1024 then
		slot3 = slot2.params[1] <= HeroData:GetHeroData(slot1.heroId).star
	elseif slot2.type == 1005 then
		slot3 = slot2.params[1] <= #HeroData:GetHeroData(slot1.heroId).unlocked_astrolabe
	elseif slot2.type == 1006 then
		slot5 = 1

		for slot10, slot11 in pairs(slot2.params) do
			if table.keyof(HeroData:GetHeroData(slot1.heroId).clear_mission_list, slot11) then
				slot4 = 1
				slot3 = true

				break
			end
		end
	elseif slot2.type == 1007 then
		slot3 = slot2.params[1] <= (HeroData:GetHeroData(slot1.heroId).weapon_info.level or 0)
	elseif slot2.type == 1008 then
		slot5 = 1

		if BattleTeachData:GetHeroTeachInfo(slot1.heroId, HeroCfg[slot1.heroId].study_stage[1]) > 0 then
			slot4 = 1
			slot3 = true
		end
	elseif slot2.type == 1009 then
		slot6 = HeroTools.GetExSkillId(slot1.heroId)
		slot3 = slot2.params[1] <= HeroTools.GetSkillLv(slot1.heroId, slot6) + HeroTools.GetHeroSkillAddLevel(HeroData:GetHeroData(slot1.heroId), slot6)
	elseif slot2.type == 1010 then
		slot3 = slot2.params[1] <= HeroData:GetHeroData(slot1.heroId).break_level
	elseif slot2.type == 1011 or slot2.type == 5002 then
		slot3 = (BattleStageData:GetStageData()[slot2.params[1]] and slot7.clear_times > 0 and 1 or 0) >= 1
	elseif slot2.type == 1012 then
		slot3 = slot5 <= ArchiveData:GetArchive(HeroTools.GetHeroOntologyID(slot1.heroId)).lv
		slot4 = slot7
	elseif slot2.type == 1013 then
		slot6 = HeroTools.GetHeroOntologyID(slot1.heroId)
		slot3 = slot5 <= (ArchiveData:GetArchive(slot6).gift_list[HeroRecordCfg[slot6].gift_like_id1[1]] or 0)
	elseif slot2.type == 1014 then
		slot3 = slot5 <= PlayerData:GetPlayerInfo().userLevel
	elseif slot2.type == 1015 then
		slot3 = slot2.params[2] <= (HeroData:GetHeroData(slot2.params[1]) and slot6.level or 0)
	elseif slot2.type == 1016 then
		slot3 = slot5 <= ArchiveData:GetArchive(HeroTools.GetHeroOntologyID(slot1.heroId)).lv
		slot4 = slot7
	elseif slot2.type == 1019 then
		slot3 = slot5 <= ArchiveData:GetTrustLevel(slot1.heroId)
		slot4 = slot6
	elseif slot2.type == 2001 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot4 >= 1, slot4, 1
	elseif slot2.type == 2002 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[1] <= slot4, slot4, slot2.params[1]
	elseif slot2.type == 2003 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[1] <= slot4, slot4, slot2.params[1]
	elseif slot2.type == 2004 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[1] <= slot4, slot4, slot2.params[1]
	elseif slot2.type == 2005 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 1

		return slot2.params[1] <= slot4, slot4, slot2.params[1]
	elseif slot2.type == 2101 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot4 >= 1, slot4, 1
	elseif slot2.type == 2201 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[1] <= slot4, slot4, slot2.params[1]
	elseif slot2.type == 2202 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot4 >= 1, slot4, 1
	elseif slot2.type == 2301 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot4 >= 1, slot4, 1
	elseif slot2.type == 2401 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot4 >= 1, slot4, 1
	elseif slot2.type == 3001 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[2] <= slot4, slot4, slot2.params[2]
	elseif slot2.type == 3002 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[1] <= slot4, slot4, slot2.params[1]
	elseif slot2.type == 3003 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[1] <= slot4, slot4, slot2.params[1]
	elseif slot2.type == 3004 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot4 >= 1, slot4, 1
	elseif slot2.type == 3005 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[1] <= slot4, slot4, slot2.params[1]
	elseif slot2.type == 3006 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[1] <= slot4, slot4, slot2.params[1]
	elseif slot2.type == 3007 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[1] <= slot4, slot4, slot2.params[1]
	elseif slot2.type == 3008 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[1] <= slot4, slot4, slot2.params[1]
	elseif slot2.type == 3009 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[1] <= slot4, slot4, slot2.params[1]
	elseif slot2.type == 5001 then
		for slot12, slot13 in ipairs(HeroRecordCfg[HeroTools.GetHeroOntologyID(slot2.params[1])].plot_id) do
			if not ArchiveData:IsStoryRead(slot7, slot13) then
				return false
			end
		end

		return true
	elseif slot2.type == 1017 then
		slot5 = 1

		if HeroTools.IsSkinUnlock(slot2.params[1]) and HomeSceneSettingData:IsHaveScene(slot2.params[2]) then
			slot4 = 1
			slot3 = true
		end
	elseif slot2.type == 1018 then
		slot5 = 1

		if HeroTools.IsSkinUnlock(slot2.params[1]) then
			slot4 = 1
			slot3 = true
		end
	elseif slot2.type == 9001 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[1] <= slot4, slot4, slot2.params[1]
	elseif slot2.type == 9002 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[1] <= slot4, slot4, slot2.params[1]
	elseif slot2.type == 9003 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[1] <= slot4, slot4, slot2.params[1]
	elseif slot2.type == 9004 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot4 >= 1, slot4, 1
	elseif slot2.type == 9005 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot4 >= 1, slot4, 1
	elseif slot2.type == 9011 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[1] <= slot4, slot4, slot2.params[1]
	elseif slot2.type == 9012 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[2] <= slot4, slot4, slot2.params[2]
	elseif slot2.type == 9013 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[1] <= slot4, slot4, slot2.params[1]
	elseif slot2.type == 9014 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot4 >= 1, slot4, 1
	elseif slot2.type == 9015 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot4 >= 1, slot4, 1
	elseif slot2.type == 9016 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[1] <= slot4, slot4, slot2.params[1]
	elseif slot2.type == 9017 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[2] <= slot4, slot4, slot2.params[2]
	elseif slot2.type == 1101 then
		slot4 = nullable(ShopData.GetGoodInfo(slot2.params[1], slot2.params[2]), "buy_times") or 0

		return slot2.params[3] <= slot4, slot4, slot2.params[3]
	elseif slot2.type == 1102 then
		return TowerData:CheckIsOverStage(slot2.params[1], slot2.params[2])
	elseif slot2.type == 8013 then
		slot4 = CanteenData:GetFurnitureLevel(slot2.params[1]) or 0

		return slot2.params[2] <= slot4, slot4, slot2.params[2]
	elseif slot2.type == 8014 then
		slot4 = CanteenData:GetCurEarning() or 0

		return slot2.params[1] <= slot4, slot4, slot2.params[1]
	elseif slot2.type == 8021 then
		slot3 = slot5 <= (DormRoomTools:GetGiftNumByRoomID(DormRoomTools:GetDormIDViaArchive(HeroTools.GetHeroOntologyID(slot1.heroId))) or 0)
	elseif slot2.type == 8022 then
		slot3 = slot5 <= DormHeroTools:GetDormLevelByHeroID(HeroTools.GetHeroOntologyID(slot1.heroId))
	elseif slot2.type == 8023 then
		slot3 = slot5 <= (DormData:GetHeroTemplateInfo(slot1.heroId) and (slot7:GetHeroTotalFeedTime() or 0) or 0)
	elseif slot2.type == 8101 then
		slot4 = DormRoomTools:GetUnlockRoomNum() or 0

		return slot2.params[1] <= slot4, slot4, slot2.params[1]
	elseif slot2.type == 5003 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[3] <= slot4, slot4, slot2.params[3]
	elseif slot2.type == 11200 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot4 > 0, slot4, slot2.params[1]
	elseif slot2.type == 11201 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot4 > 0, slot4, slot2.params[1]
	elseif slot2.type == 11202 then
		slot4 = ActivityData:GetActivityIsOpen(slot2.params[1]) and 1 or 0

		return slot4 > 0, slot4, slot2.params[1]
	elseif slot2.type == 11203 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[2] <= slot4, slot4, slot2.params[2]
	elseif slot2.type == 11204 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot4 > 0, slot4, slot2.params[1]
	elseif slot2.type == 11205 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot4 > 0, slot4, slot2.params[2]
	elseif slot2.type == 11206 then
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0

		return slot2.params[2] <= slot4, slot4, slot2.params[2]
	end

	return slot3, slot4, slot5
end

function GetConditionProgressText(slot0, slot1, slot2)
	if ConditionCfg[slot0].progress_show == 1 then
		return string.format("%s/%s", slot1, slot2)
	else
		return ""
	end
end

function isMeetAllCondition(slot0)
	for slot4, slot5 in ipairs(slot0) do
		if not isMeetCondition(slot5) then
			return false
		end
	end

	return true
end

function isMeetCondition(slot0)
	if slot0[1] == 101 then
		return ChapterTools.IsClearStage(slot0[2])
	elseif slot0[1] == 102 then
		return ChapterTools.IsClearChapter(slot0[2])
	else
		return false
	end
end

function getConditionText(slot0)
	if slot0[1] == 101 then
		slot1 = slot0[2]

		return string.format(GetTips("NOTE_TASK_UNLOCK"), GetI18NText(BattleStageTools.GetStageCfg(ChapterCfg[getChapterIDByStageID(slot1)].type, slot1).name))
	elseif slot0[1] == 102 then
		return string.format(GetTips("NOTE_TASK_UNLOCK"), GetI18NText(ChapterCfg[slot0[2]].subhead))
	else
		return ""
	end
end

function needShowBagFullBox()
	if EquipData:GetEquipBagFull() then
		EquipAction.EquipBagFull(false)

		return true
	end

	return false
end

function isBagFull(slot0)
	for slot4, slot5 in pairs(slot0) do
		if ItemCfg[slot5[1]].type == ItemConst.ITEM_TYPE.EQUIP and GameSetting.max_equip.value[1] <= EquipTools.GetEquipNum() then
			return true
		end
	end

	return false
end

function showEquipSendMail(slot0)
	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTips("EQUIP_SEND_MAIL"),
		OkCallback = function ()
			if uv0 then
				uv0()
			end
		end
	})
end

function showBagFullBox()
	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTips("EQUIP_NUM_MAX"),
		OkCallback = function ()
			JumpTools.GoToSystem("/bag", {
				type = "equip"
			}, ViewConst.SYSTEM_ID.BAG)
		end
	})
end

function needShowVitalityFullBox()
	if CurrencyData:GetVitalityFull() then
		ActionCreators.VitalityFull(false)

		return true
	end

	return false
end

function isVitalityFull()
	return ItemCfg[CurrencyConst.CURRENCY_TYPE_VITALITY].max <= ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
end

function showVitalitySendMail(slot0)
	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTips("VITALITY_FULL"),
		OkCallback = function ()
			if uv0 then
				uv0()
			end
		end
	})
end

function canAddVitalityByProp(slot0)
	if table.keyof(GameSetting.vitality_exchange_id_list.value, slot0) then
		return not isVitalityFull()
	else
		return true
	end
end

function hasVitalityProp()
	for slot3, slot4 in ipairs(GameSetting.vitality_exchange_id_list.value) do
		if ItemTools.getItemNum(slot4) > 0 then
			return true
		end
	end

	return false
end

function isOpenMission(slot0)
	slot1 = BattleStageData:GetStageData()

	if ChapterTools.IsFinishPreChapter(getChapterIDByStageID(slot0)) and slot1[slot0] then
		if slot0 == GameSetting.travel_skuld_new_ending_stage_id.value[1] and slot1[slot0].clear_times < 1 then
			return false
		end

		return true
	end

	return false
end

function getMaxOpenSection(slot0)
	slot1 = getChapterIDByStageID(slot0)

	if isOpenMission(slot0) then
		return slot0, slot1
	end

	for slot6 = ChapterCfg[slot1].difficulty, 1, -1 do
		for slot12 = table.keyof(getChapterListByDifficulty(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, slot6), slot1), 1, -1 do
			for slot18 = table.keyof(ChapterCfg[slot7[slot12]].section_id_list, slot0) or #slot13.section_id_list, 1, -1 do
				if isOpenMission(slot13.section_id_list[slot18]) then
					return slot19, slot7[slot12]
				end
			end
		end
	end

	return slot0, slot1
end

function getHeroAffixs(slot0)
	if type(slot0) ~= "table" then
		return {}
	end

	slot1 = {}

	for slot5, slot6 in pairs(slot0) do
		if slot6[3] and slot6[3] == 3 then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function getMosterAffix(slot0)
	if type(slot0) ~= "table" then
		return {}
	end

	slot1 = {}

	for slot5, slot6 in pairs(slot0) do
		if slot6[3] and slot6[3] ~= 3 then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function getAffixName(slot0)
	if slot0[1] == nil then
		return ""
	end

	if AffixTypeCfg[slot1] == nil then
		-- Nothing
	end

	return GetI18NText(slot2.name)
end

function getAffixDesc(slot0)
	slot2 = slot0[2]

	if slot0[1] == nil then
		return ""
	end

	slot4 = {}

	if AffixTypeCfg[slot1] == nil then
		-- Nothing
	end

	return GetI18NText(GetCfgDescription(slot5.description[1], slot2))
end

function getAffixSprite(slot0)
	if slot0[1] == nil then
		return ""
	end

	if AffixTypeCfg[slot1] == nil then
		-- Nothing
	end

	if PublicBuffCfg[slot2.affix_buff_id].icon == "" then
		-- Nothing
	end

	return getSpriteWithoutAtlas(SpritePathCfg.AffixIcon.path .. slot3)
end

function getEquipSkillSprite(slot0)
	if slot0 == nil then
		return ""
	end

	if EquipSkillCfg[slot0] == nil then
		-- Nothing
	end

	return getSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. slot1.icon)
end

function getAttributeAffix(slot0, slot1)
	if PublicBuffCfg[AffixTypeCfg[clone(EquipBreakThroughMaterialItemCfg[slot0].params)[1]].buffid[1]].max_level < slot1 then
		slot2[2] = slot3.max_level
	else
		slot2[2] = slot1
	end

	return slot2
end

function getAttributeAffixValue(slot0, slot1)
	if PublicBuffCfg[AffixTypeCfg[clone(EquipBreakThroughMaterialItemCfg[slot0].params)[1]].buffid[1]].max_level < slot1 then
		slot1 = slot3.max_level
	end

	return slot3.buffparam_base[2] + slot3.buffparam_factor[2] * (slot1 - 1)
end

function MergeActivityID(slot0, slot1)
	if slot0 then
		if ActivityCfg[slot0] and slot2.activity_template == ActivityTemplateConst.STORY_STAGE then
			for slot6, slot7 in pairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STORY]) do
				if table.keyof(ActivityCfg[slot7].sub_activity_list, slot0) then
					return slot7
				end
			end
		elseif slot2 and slot2.activity_template == ActivityTemplateConst.ACTIVITY_AFFIX_SELECT_SUBMODULE then
			for slot6, slot7 in pairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_AFFIX_SELECT]) do
				if table.keyof(ActivityCfg[slot7].sub_activity_list, slot0) then
					return slot7
				end
			end
		end
	end

	return slot0
end

function GetTrialHeroList(slot0, slot1, slot2)
	if slot0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT or slot0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT then
		if ChapterCfg[getChapterIDByStageID(slot1)].activity_id ~= 0 and ActivityTools.GetActivityStatus(slot5) ~= 1 then
			return {}
		end

		return type(slot4.trial_list) == "table" and slot4.trial_list or {}
	end

	if slot0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		if GetChessLevelIDByStageID(slot1) then
			return type(WarchessLevelCfg[GetChessLevelIDByStageID(slot1)].trial_list) == "table" and slot3.trial_list or {}
		else
			return {}
		end
	end

	if slot0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS then
		slot3 = {}

		for slot8, slot9 in pairs(NewWarChessData:GetHeroInfoList()) do
			if slot9[2] > 0 then
				table.insert(slot3, NewWarChessHeroCfg[slot9[1]].temp_id)
			end
		end

		return slot3
	end

	if slot0 == BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON then
		if SoloHeartDemonData:GetDataByPara("stageToDifficulty")[slot1] < 3 then
			return SoloHeartDemonCfg[SoloHeartDemonData:GetDataByPara("openEditor")].trial_hero
		end

		return {}
	end

	if slot0 == BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME then
		return DestroyBoxGameCfg[DestroyBoxGameData:GetSelectID(DestroyBoxGameCfg[DestroyBoxGameCfg.get_id_list_by_activity_id[slot2][1]].main_activity_id)].trial_hero
	end

	return BattleTeamData:GetHeroTrial(GetHeroTeamActivityID(slot0, slot2, true)) or {}
end

function SetHeroTeam(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	ReserveTools.SetTeam(ReserveParams.New(nil, slot7, slot8, {
		stageType = slot0,
		stageID = slot1,
		activityID = slot2
	}), slot3, slot4, slot5, slot6.mimir_id or 0, slot6.chip_list or {})
end

function GetHeroTeamActivityID(slot0, slot1, slot2)
	if slot0 == BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON then
		if DemonChallengeCfg[slot1] then
			return DemonChallengeCfg[slot1].activity_id
		else
			return slot1
		end
	elseif slot1 and slot1 ~= 0 then
		return slot2 and slot1 or MergeActivityID(slot1)
	elseif slot0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE or slot0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE or slot0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX or slot0 == BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE or slot0 == BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE or slot0 == BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL or slot0 == BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY or slot0 == BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP or slot0 == BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO or slot0 == BattleConst.STAGE_TYPE_NEW.POLYHEDRON then
		return slot0
	else
		return 0
	end
end

function GetLocalHeroTeam(slot0, slot1, slot2, slot3, slot4)
	slot5 = {
		0,
		0,
		0
	}
	slot6 = {
		false,
		false,
		false
	}
	slot7 = {}
	slot8 = {
		0,
		0,
		0
	}
	slot9 = false

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == slot0 then
		slot5 = MatrixData:GetMatrixBattleHeroTeam()
		slot10 = not MatrixData:GetCanChangeCaptain()
		slot6 = {
			slot10,
			slot10,
			slot10
		}
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == slot0 then
		slot5 = ActivityMatrixData:GetMatrixBattleHeroTeam(slot2)
		slot10 = not ActivityMatrixData:GetCanChangeCaptain(slot2)
		slot6 = {
			slot10,
			slot10,
			slot10
		}
	elseif BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX == slot0 then
		slot5 = StrategyMatrixData:GetMatrixBattleHeroTeam(slot2)
		slot10 = not StrategyMatrixData:GetCanChangeCaptain(slot2)
		slot6 = {
			slot10,
			slot10,
			slot10
		}
	else
		return ReserveTools.GetHeroList(ReserveParams.New(nil, slot3, slot4, {
			stageType = slot0,
			stageID = slot1,
			activityID = slot2
		}))
	end

	return slot5, slot6, slot7, slot8, slot9
end

function getShopCfg(slot0)
	return ShopCfg[slot0]
end

function getGoodListByGiveID(slot0)
	return ShopCfg.get_id_list_by_give_id[slot0] or {}
end

function getShopIDListByShopID(slot0)
	return ShopCfg.get_id_list_by_shop_id[slot0] or {}
end

function getShopIDListByCurrency(slot0)
	return ShopCfg.get_id_list_by_cost_id[slot0] or {}
end

_G.SceneDataForExcehangeVar = nil

function GetSceneDataForExcehange()
	if _G.SceneDataForExcehangeVar == nil then
		_G.SceneDataForExcehangeVar = SceneDataForExcehange.New()
	end

	return _G.SceneDataForExcehangeVar
end

function ResetSceneDataForExcehange()
	_G.SceneDataForExcehangeVar = SceneDataForExcehange.New()
end

function TryToStartBattle()
	SetForceShowQuanquan(true)
	LuaExchangeHelper.Launcher(GetSceneDataForExcehange(), function ()
		SetForceShowQuanquan(false)

		_G.BATTLE_SERVER_ERROR_TIME = 0

		DestroyLua()
		gameContext:SetSystemLayer("battle")
	end)
end

_G.ChessDataForExcehangeVar = nil

function GetChessDataForExcehange()
	if _G.ChessDataForExcehangeVar == nil then
		_G.ChessDataForExcehangeVar = ChessDataForExchange.New()
	end

	return _G.ChessDataForExcehangeVar
end

function ResetChessDataForExcehange()
	_G.ChessDataForExcehangeVar = ChessDataForExchange.New()
end

function StartChessBattleMode()
	SetForceShowQuanquan(true)
	ChessLuaBridge.Launcher(GetChessDataForExcehange(), function ()
		SetForceShowQuanquan(false)

		_G.BATTLE_SERVER_ERROR_TIME = 0

		DestroyLua()
		gameContext:SetSystemLayer("battle")
	end)

	_G.ChessDataForExcehangeVar = nil
end

_G.NewChessDataForExcehangeVar = nil

function GetNewChessDataForExcehange()
	if _G.NewChessDataForExcehangeVar == nil then
		_G.NewChessDataForExcehangeVar = NewChessDataForExchange.New()
	end

	return _G.NewChessDataForExcehangeVar
end

function ResetNewChessDataForExcehange()
	_G.NewChessDataForExcehangeVar = NewChessDataForExchange.New()
end

function StartNewChessBattleMode()
	SetForceShowQuanquan(true)
	NewChessLuaBridge.Launcher(GetNewChessDataForExcehange(), function ()
		SetForceShowQuanquan(false)

		_G.BATTLE_SERVER_ERROR_TIME = 0

		DestroyLua()
		gameContext:SetSystemLayer("battle")
	end)

	_G.NewChessDataForExcehangeVar = nil
end

_G.MusicDataForExchangeVar = nil

function GetMusicDataForExchange()
	if _G.MusicDataForExchangeVar == nil then
		_G.MusicDataForExchangeVar = MusicDataForExchange.New()
	end

	return _G.MusicDataForExchangeVar
end

function StartMusicMode()
	DestroyLua()
	MusicLuaBridge.Launcher(GetMusicDataForExchange())
end

_G.MusicDataForExchangeVar2 = nil

function GetMusicDataForExchange2()
	if _G.MusicDataForExchangeVar2 == nil then
		_G.MusicDataForExchangeVar2 = MusicDataForExchange2.New()
	end

	return _G.MusicDataForExchangeVar2
end

function StartMusicMode2()
	DestroyLua()
	MusicLuaBridge2.Launcher(GetMusicDataForExchange2())
end

_G.ZumaDataForExchangeVar = nil

function GetZumaDataForExchange()
	if _G.ZumaDataForExchangeVar == nil then
		_G.ZumaDataForExchangeVar = ZumaDataForExchange.New()
	end

	return _G.ZumaDataForExchangeVar
end

_G.DormDataForExcehangeVar = nil

function GetDormDataForExcehange()
	if _G.DormDataForExcehangeVar == nil then
		_G.DormDataForExcehangeVar = DormDataForExchange.New()
	end

	return _G.DormDataForExcehangeVar
end

function ResetDormDataForExcehange()
	_G.DormDataForExcehangeVar = DormDataForExchange.New()
end

function StartDormMode(slot0)
	SetForceShowQuanquan(true)
	DormLuaBridge.Launcher(slot0 or GetDormDataForExcehange(), function ()
		SetForceShowQuanquan(false)
		DestroyLua()
	end)

	_G.DormDataForExcehangeVar = nil
end

_G.GuildActivityDataForExchangeVar = nil

function GetGuildActivityDataForExchange(slot0, slot1)
	if _G.GuildActivityDataForExchangeVar == nil then
		_G.GuildActivityDataForExchangeVar = GuildActivityDataForExchange.New()
	end

	if slot0 ~= nil and slot0 > 0 then
		_G.GuildActivityDataForExchangeVar.nodeId = slot0
		_G.GuildActivityDataForExchangeVar.level = slot1
	else
		_G.GuildActivityDataForExchangeVar.nodeId = 11001
		_G.GuildActivityDataForExchangeVar.level = 1
	end

	return _G.GuildActivityDataForExchangeVar
end

function ResetGuildActivityDataForExchange()
	_G.GuildActivityDataForExchangeVar = GuildActivityDataForExchange.New()
end

function StartGuildActivity(slot0)
	SetForceShowQuanquan(true)

	slot1 = nil

	GuildActivityLuaBridge.Launcher(GetGuildActivityDataForExchange(slot0, (slot0 == nil or slot0 <= 0 or table.indexof(ActivityClubMapCfg.all, ActivityClubCfg[slot0].map_id)) and 1), function ()
		SetForceShowQuanquan(false)

		_G.BATTLE_SERVER_ERROR_TIME = 0

		manager.windowBar:SetWhereTag("guildActivity")
		DestroyLua()
		gameContext:SetSystemLayer("guildActivity")
	end, function ()
		manager.uiInit()
		GuildActivityAction.EnterGuildWarField(function ()
			JumpTools.OpenPageByJump("/guildActivityWarField", {
				activityID = ActivityConst.GUILD_ACTIVITY_START,
				level = uv0
			})
			GuildActivityLuaBridge.StartGuildActivity(uv1)
		end)
	end)

	_G.GuildActivityDataForExchangeVar = nil
end

_G.GuildActivitySPDataForExchangeVar = nil

function GetGuildSPActivityDataForExchange(slot0, slot1)
	if _G.GuildActivitySPDataForExchangeVar == nil then
		_G.GuildActivitySPDataForExchangeVar = GuildActivitySPDataForExchange.New()
	end

	if slot0 ~= nil and slot0 > 0 then
		_G.GuildActivitySPDataForExchangeVar.nodeId = slot0
		_G.GuildActivitySPDataForExchangeVar.level = slot1
		_G.GuildActivitySPDataForExchangeVar.activityID = GuildActivitySPData:GetCurMainActivityID()
	else
		_G.GuildActivitySPDataForExchangeVar.nodeId = 11001
		_G.GuildActivitySPDataForExchangeVar.level = 1
		_G.GuildActivitySPDataForExchangeVar.activityID = ActivityConst.GUILD_ACTIVITY_SP_2_4
	end

	return _G.GuildActivitySPDataForExchangeVar
end

function ResetGuildActivitySPDataForExchange()
	_G.GuildActivitySPDataForExchangeVar = GuildActivitySPDataForExchange.New()
end

function StartGuildActivitySP(slot0)
	SetForceShowQuanquan(true)

	slot1 = nil

	if type((slot0 == nil or slot0 <= 0 or table.indexof(ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()], ActivityClubSPCfg[slot0].map_id)) and 1) ~= "number" then
		SetForceShowQuanquan(false)
		print("未找到当前点位对应的地图索引,节点id为" .. slot0)

		return
	end

	GuildActivitySPLuaBridge.Launcher(GetGuildSPActivityDataForExchange(slot0, slot1), function ()
		SetForceShowQuanquan(false)

		_G.BATTLE_SERVER_ERROR_TIME = 0

		manager.windowBar:SetWhereTag("guildActivitySP")
		DestroyLua()
		gameContext:SetSystemLayer("guildActivitySP")
	end, function ()
		manager.uiInit()
		GuildActivitySPAction.EnterGuildWarField(function ()
			GuildActivitySPLuaBridge.StartGuildActivity(uv0)

			slot0 = GuildActivitySPData:GetCurRunActivityID()

			JumpTools.OpenPageByJump("/guildActivitySPWarField", {
				nodeID = uv0,
				activityID = slot0,
				level = uv1,
				totalActivityID = slot0
			})
		end)
	end)

	_G.GuildActivitySPDataForExchangeVar = nil
end

function getRewardFromDropCfg(slot0, slot1)
	if slot0 == nil then
		return {}
	end

	slot2 = DropCfg[slot0]

	if slot0 == 0 then
		return {}
	end

	if slot2 == nil then
		return {}
	end

	slot3 = {}

	if slot1 and #slot2.base_drop >= 1 then
		if slot2.base_drop ~= "" then
			for slot7, slot8 in pairs(slot2.base_drop) do
				table.insert(slot3, formatReward(slot8))
			end
		end
	else
		if slot2.random_drop ~= "" then
			for slot7, slot8 in pairs(slot2.random_drop) do
				table.insert(slot3, formatReward(slot8))
			end
		end

		if slot2.weight_drop ~= "" then
			for slot7, slot8 in pairs(slot2.weight_drop) do
				table.insert(slot3, formatReward(slot8))
			end
		end
	end

	return sortReward(mergeReward(slot3))
end

function checkGold(slot0, slot1)
	if slot1 == nil then
		slot1 = true
	end

	if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < slot0 then
		if slot1 then
			slot3 = false

			for slot8, slot9 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND] or {}) do
				if ItemTools.getItemNum(slot9) > 0 then
					slot3 = true

					break
				end
			end

			if GameSetting.coin_max_buy_time.value[1] <= CurrencyData:GetGoldBuyTimes() and not slot3 then
				ShowTips("ERROR_ITEM_NOT_ENOUGH_GOLD")
			else
				JumpTools.OpenPopUp("currencyBuyGold")
			end
		end

		return false
	end

	return true
end

function checkMaterial(slot0, slot1)
	if slot0 == nil then
		slot0 = {}
	end

	if slot1 == nil then
		slot1 = true
	end

	for slot5, slot6 in ipairs(slot0) do
		if ItemTools.getItemNum(slot6[1]) < slot6[2] then
			if slot1 then
				ShowPopItem(POP_SOURCE_ITEM, {
					slot7
				})
			end

			return false
		end
	end

	return true
end

function checkMoney(slot0, slot1)
	if slot1 == nil then
		slot1 = true
	end

	if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) < slot0 then
		if slot1 then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_DIAMOND")
		end

		return false
	end

	return true
end

function checkVitality(slot0, slot1)
	if slot1 == nil then
		slot1 = true
	end

	if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) < slot0 then
		if slot1 then
			if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] then
				JumpTools.OpenPopUp("currencyBuyFatigue")
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
			end
		end

		return false
	end

	return true
end

function setTextColor(slot0, slot1, slot2, slot3, slot4)
	slot5 = "<color=#%s>" .. slot2 .. "</color>"
	slot6 = nil

	return (not slot4 or function (slot0, slot1)
		return slot0 <= slot1
	end(slot2, slot3) or string.format(slot5, slot0)) and string.format(slot5, slot1)
end

function GetServerTime()
	return manager.time:GetServerTime()
end

function formatText(slot0)
	return string.gsub(GetI18NText(slot0), "#{(%w+)}#", function (slot0)
		if slot0 == "nickname" then
			return PlayerData:GetPlayerInfo().nick
		else
			return slot0
		end
	end)
end

function GetMonsterName(slot0)
	if type(slot0) ~= "table" then
		return nil
	end

	for slot5, slot6 in pairs(slot0) do
		slot1 = (slot1 ~= nil or GetI18NText(CharactorParamCfg[slot6].Name)) and GetI18NText(CharactorParamCfg[slot6].Name) .. "&" .. string.match(GetI18NText(CharactorParamCfg[slot6].Name), "<.*>")
	end

	return slot1
end

function GetMonsterSkillDesList(slot0)
	if type(slot0) ~= "table" then
		return {}
	end

	for slot5, slot6 in pairs(slot0) do
		for slot10 = 1, 6 do
			if string.len(MonsterCfg[slot6]["skill" .. slot10]) ~= 0 then
				table.insert(slot1, {
					name = MonsterCfg[slot6]["skill" .. slot10],
					info = MonsterCfg[slot6]["skill_desc" .. slot10]
				})
			end
		end
	end

	return slot1
end
