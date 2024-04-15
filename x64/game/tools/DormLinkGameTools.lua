return {
	GetMainUIName = function (slot0, slot1)
		if ActivityTools.GetActivityTheme(slot1) == ActivityConst.THEME.ACTIVITY_2_1 then
			return "UI/VersionUI/XuHeng2ndUI/XH2ndLinkGameUI/XH2ndLinkGameUI"
		end
	end,
	GetTaskActivityID = function (slot0, slot1)
		if slot1 == ActivityConst.ACTIVITY_2_1_LINK_GANE then
			return ActivityConst.ACTIVITY_2_1_LINK_GANE_TASK
		end
	end,
	GetLostTimeStr = function (slot0, slot1)
		slot5 = ActivityData:GetActivityData(ActivityLinkGameCfg[slot1].activity_id).stopTime - TimeMgr.GetInstance():GetServerTime()
		slot7 = math.fmod(math.floor(slot5 / 3600), 24)
		slot8 = math.fmod(math.floor(slot5 / 60), 60)
		slot9 = math.fmod(slot5, 60)
		slot10 = nil

		if math.floor(slot5 / 86400) > 0 then
			return slot10.format(GetTips("ACTIVITY_LINKGAME_TIME_LIMIT"), slot6 + 1)
		elseif slot7 > 0 then
			return slot7 + 1 .. GetTips("HOUR")
		elseif slot8 > 0 then
			return slot8 + 1 .. GetTips("MINUTE")
		elseif slot9 > 0 then
			return slot8 + 1 .. GetTips("MINUTE")
		end
	end,
	GetLevelIDByDiffAndActivityID = function (slot0, slot1, slot2)
		for slot6, slot7 in ipairs(ActivityLinkGameCfg.all) do
			if ActivityLinkGameCfg[slot7].activity_id == slot1 and ActivityLinkGameCfg[slot7].difficult == slot2 then
				return slot7
			end
		end

		print("未找到活动id")
	end,
	GetAwardDesc = function (slot0, slot1)
		if ActivityLinkGameRewardCfg[slot1] and ConditionCfg[ActivityLinkGameRewardCfg[slot1].condition].type == DormLinkGameConst.AwardCondition.Point then
			slot5 = slot3.params[1]
			slot6 = slot3.params[2]
			slot7 = nil

			for slot11, slot12 in ipairs(ActivityLinkGameCfg.all) do
				if ActivityLinkGameCfg[slot12].activity_id == ActivityLinkGameRewardCfg[slot1].activity_id then
					slot7 = ActivityLinkGameCfg[slot12].name

					break
				end
			end

			if slot7 then
				return string.format(slot3.desc, slot7, slot6)
			end
		end

		print("未找奖励id")
	end,
	GetCurrencyID = function (slot0, slot1)
		if slot1 == ActivityConst.ACTIVITY_2_1_LINK_GANE then
			return CurrencyIdMapCfg.CURRENCY_LINKGAME_COST.item_id
		end
	end,
	ChecklevelUnLock = function (slot0, slot1)
		if ActivityLinkGameCfg[slot1] then
			slot3 = ActivityData:GetActivityData(ActivityLinkGameCfg[slot1].activity_id)
			slot4 = slot3.startTime
			slot5 = slot3.stopTime
			slot6 = manager.time:GetServerTime()

			if ActivityLinkGameCfg[slot1].pre_stage and ActivityLinkGameCfg[slot1].pre_stage > 0 and not DormLinkGameData:CheckActivityComplete(slot7) then
				return false, DormLinkGameConst.LevelLockType.preLevel, slot7
			end

			if slot6 < slot4 then
				return false, DormLinkGameConst.LevelLockType.time, slot4
			elseif slot5 < slot6 then
				return false, DormLinkGameConst.LevelLockType.stop
			end

			return true
		end
	end,
	GetDormLinkGameItemIcon = function (slot0, slot1, slot2)
		if ActivityTools.GetActivityTheme(slot1) == ActivityConst.THEME.ACTIVITY_2_1 then
			slot5 = ActivityLinkGameGoodsCfg[slot2].goods_icon_id

			if ActivityLinkGameGoodsCfg[slot2].path and slot5 then
				return getSpriteWithoutAtlas(slot4 .. slot5)
			end
		end
	end,
	GetFoodMaterialIcon = function (slot0, slot1)
		return getSpriteWithoutAtlas(ActivityLinkGameCellCfg[slot1].path .. "/" .. ActivityLinkGameCellCfg[slot1].album_id)
	end,
	PlaySpecialVoice = function (slot0, slot1, slot2)
		if slot0:FindConformSpecialVoice(slot1, slot2) then
			slot4 = ActivityLinkGameDiaLogCfg[slot3]
			slot5 = math.random(1, #slot4.sheetName)

			if slot4.sheetName[slot5] ~= "" then
				manager.audio:PlayEffect(slot6, slot4.cueName[slot5], slot4.awbName[slot5])
			end
		end
	end,
	FindConformSpecialVoice = function (slot0, slot1, slot2)
		for slot6, slot7 in ipairs(ActivityLinkGameDiaLogCfg.all) do
			if ConditionCfg[ActivityLinkGameDiaLogCfg[slot7].condition].type == slot1 and slot0:CheckConditionConform(slot8, slot2, slot1) then
				return slot7
			end
		end
	end,
	CheckConditionConform = function (slot0, slot1, slot2, slot3)
		if slot3 == DormLinkGameConst.SpecialVoiceType.SuccssBatterNum then
			if slot2.oldNum < ConditionCfg[slot1].params[1] and slot6 <= slot2.newNum then
				return true
			end
		elseif slot3 == DormLinkGameConst.SpecialVoiceType.FaileBatterNum then
			if ConditionCfg[slot1].params[1] <= slot2.num then
				return true
			end
		elseif slot3 == DormLinkGameConst.SpecialVoiceType.SuccssfulLevel then
			return true
		elseif slot3 == DormLinkGameConst.SpecialVoiceType.FaileLevel then
			return true
		elseif slot3 == DormLinkGameConst.SpecialVoiceType.LastTime and ConditionCfg[slot1].params[1] < slot2.num + 1 and slot4 <= slot5 then
			return true
		end

		return false
	end,
	GetSkillItemDecs = function (slot0, slot1)
		return string.format(ActivityLinkGameGoodsCfg[slot1].goods_des, ActivityLinkGameGoodsCfg[slot1].coin_num, ActivityLinkGameGoodsCfg[slot1].extra_param[1])
	end,
	UseSkillItem = function (slot0, slot1)
		if not DormLinkGameData:GetGameCacheInfo().useItemList[slot1] then
			slot2.useItemList[slot1] = 0
		end

		slot2.useItemList[slot1] = slot2.useItemList[slot1] + 1
		slot2.costTokenNum = slot2.costTokenNum + ActivityLinkGameGoodsCfg[slot1].coin_num

		slot0:ImplementItemEffect(slot1)
		manager.notify:Invoke(LIANLIANKAN_USE_ITEM)
	end,
	ImplementItemEffect = function (slot0, slot1)
		if slot1 == DormLinkGameConst.SkillItemEffectType.Eliminate then
			manager.notify:Invoke(LIANLIANKAN_AUTO_MATCH)
		elseif slot1 == DormLinkGameConst.SkillItemEffectType.ClearMaterialList then
			slot2 = ActivityLinkGameGoodsCfg[slot1].extra_param[1]

			DormLinkGameData:ClearConveyorMaterial(slot2)
			DormLinkGameData:PauseMaterialGenerate(slot2)
		end
	end,
	ExitGame = function (slot0)
		DormLinkGameData:DisposeGameCacheInfo()
		LuaExchangeHelper.GoToMain()
		OpenPageUntilLoaded("/dormLinkGameLevelView")
	end
}
