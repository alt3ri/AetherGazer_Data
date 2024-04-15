return {
	GetMainUIName = function(arg_1_0, arg_1_1)
		if ActivityTools.GetActivityTheme(arg_1_1) == ActivityConst.THEME.ACTIVITY_2_1 then
			return "UI/VersionUI/XuHeng2ndUI/XH2ndLinkGameUI/XH2ndLinkGameUI"
		end
	end,
	GetTaskActivityID = function(arg_2_0, arg_2_1)
		if arg_2_1 == ActivityConst.ACTIVITY_2_1_LINK_GANE then
			return ActivityConst.ACTIVITY_2_1_LINK_GANE_TASK
		end
	end,
	GetLostTimeStr = function(arg_3_0, arg_3_1)
		local var_3_0 = ActivityLinkGameCfg[arg_3_1].activity_id
		local var_3_1 = ActivityData:GetActivityData(var_3_0).stopTime - TimeMgr.GetInstance():GetServerTime()
		local var_3_2 = math.floor(var_3_1 / 86400)
		local var_3_3 = math.fmod(math.floor(var_3_1 / 3600), 24)
		local var_3_4 = math.fmod(math.floor(var_3_1 / 60), 60)
		local var_3_5 = math.fmod(var_3_1, 60)
		local var_3_6

		if var_3_2 > 0 then
			return var_3_6.format(GetTips("ACTIVITY_LINKGAME_TIME_LIMIT"), var_3_2 + 1)
		elseif var_3_3 > 0 then
			return var_3_3 + 1 .. GetTips("HOUR")
		elseif var_3_4 > 0 then
			return var_3_4 + 1 .. GetTips("MINUTE")
		elseif var_3_5 > 0 then
			return var_3_4 + 1 .. GetTips("MINUTE")
		end
	end,
	GetLevelIDByDiffAndActivityID = function(arg_4_0, arg_4_1, arg_4_2)
		for iter_4_0, iter_4_1 in ipairs(ActivityLinkGameCfg.all) do
			if ActivityLinkGameCfg[iter_4_1].activity_id == arg_4_1 and ActivityLinkGameCfg[iter_4_1].difficult == arg_4_2 then
				return iter_4_1
			end
		end

		print("未找到活动id")
	end,
	GetAwardDesc = function(arg_5_0, arg_5_1)
		if ActivityLinkGameRewardCfg[arg_5_1] then
			local var_5_0 = ActivityLinkGameRewardCfg[arg_5_1].condition
			local var_5_1 = ConditionCfg[var_5_0]

			if var_5_1.type == DormLinkGameConst.AwardCondition.Point then
				local var_5_2 = ActivityLinkGameRewardCfg[arg_5_1].activity_id
				local var_5_3 = var_5_1.params[1]
				local var_5_4 = var_5_1.params[2]
				local var_5_5

				for iter_5_0, iter_5_1 in ipairs(ActivityLinkGameCfg.all) do
					if ActivityLinkGameCfg[iter_5_1].activity_id == var_5_2 then
						var_5_5 = ActivityLinkGameCfg[iter_5_1].name

						break
					end
				end

				if var_5_5 then
					return string.format(var_5_1.desc, var_5_5, var_5_4)
				end
			end
		end

		print("未找奖励id")
	end,
	GetCurrencyID = function(arg_6_0, arg_6_1)
		if arg_6_1 == ActivityConst.ACTIVITY_2_1_LINK_GANE then
			return CurrencyIdMapCfg.CURRENCY_LINKGAME_COST.item_id
		end
	end,
	ChecklevelUnLock = function(arg_7_0, arg_7_1)
		if ActivityLinkGameCfg[arg_7_1] then
			local var_7_0 = ActivityLinkGameCfg[arg_7_1].activity_id
			local var_7_1 = ActivityData:GetActivityData(var_7_0)
			local var_7_2 = var_7_1.startTime
			local var_7_3 = var_7_1.stopTime
			local var_7_4 = manager.time:GetServerTime()

			if ActivityLinkGameCfg[arg_7_1].pre_stage then
				local var_7_5 = ActivityLinkGameCfg[arg_7_1].pre_stage

				if var_7_5 > 0 and not DormLinkGameData:CheckActivityComplete(var_7_5) then
					return false, DormLinkGameConst.LevelLockType.preLevel, var_7_5
				end
			end

			if var_7_4 < var_7_2 then
				return false, DormLinkGameConst.LevelLockType.time, var_7_2
			elseif var_7_3 < var_7_4 then
				return false, DormLinkGameConst.LevelLockType.stop
			end

			return true
		end
	end,
	GetDormLinkGameItemIcon = function(arg_8_0, arg_8_1, arg_8_2)
		if ActivityTools.GetActivityTheme(arg_8_1) == ActivityConst.THEME.ACTIVITY_2_1 then
			local var_8_0 = ActivityLinkGameGoodsCfg[arg_8_2].path
			local var_8_1 = ActivityLinkGameGoodsCfg[arg_8_2].goods_icon_id

			if var_8_0 and var_8_1 then
				return getSpriteWithoutAtlas(var_8_0 .. var_8_1)
			end
		end
	end,
	GetFoodMaterialIcon = function(arg_9_0, arg_9_1)
		local var_9_0 = ActivityLinkGameCellCfg[arg_9_1].album_id
		local var_9_1 = ActivityLinkGameCellCfg[arg_9_1].path

		return getSpriteWithoutAtlas(var_9_1 .. "/" .. var_9_0)
	end,
	PlaySpecialVoice = function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_10_0:FindConformSpecialVoice(arg_10_1, arg_10_2)

		if var_10_0 then
			local var_10_1 = ActivityLinkGameDiaLogCfg[var_10_0]
			local var_10_2 = math.random(1, #var_10_1.sheetName)
			local var_10_3 = var_10_1.sheetName[var_10_2]
			local var_10_4 = var_10_1.cueName[var_10_2]
			local var_10_5 = var_10_1.awbName[var_10_2]

			if var_10_3 ~= "" then
				manager.audio:PlayEffect(var_10_3, var_10_4, var_10_5)
			end
		end
	end,
	FindConformSpecialVoice = function(arg_11_0, arg_11_1, arg_11_2)
		for iter_11_0, iter_11_1 in ipairs(ActivityLinkGameDiaLogCfg.all) do
			local var_11_0 = ActivityLinkGameDiaLogCfg[iter_11_1].condition

			if ConditionCfg[var_11_0].type == arg_11_1 and arg_11_0:CheckConditionConform(var_11_0, arg_11_2, arg_11_1) then
				return iter_11_1
			end
		end
	end,
	CheckConditionConform = function(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		if arg_12_3 == DormLinkGameConst.SpecialVoiceType.SuccssBatterNum then
			local var_12_0 = arg_12_2.oldNum
			local var_12_1 = arg_12_2.newNum
			local var_12_2 = ConditionCfg[arg_12_1].params[1]

			if var_12_0 < var_12_2 and var_12_2 <= var_12_1 then
				return true
			end
		elseif arg_12_3 == DormLinkGameConst.SpecialVoiceType.FaileBatterNum then
			if arg_12_2.num >= ConditionCfg[arg_12_1].params[1] then
				return true
			end
		elseif arg_12_3 == DormLinkGameConst.SpecialVoiceType.SuccssfulLevel then
			return true
		elseif arg_12_3 == DormLinkGameConst.SpecialVoiceType.FaileLevel then
			return true
		elseif arg_12_3 == DormLinkGameConst.SpecialVoiceType.LastTime then
			local var_12_3 = arg_12_2.num
			local var_12_4 = ConditionCfg[arg_12_1].params[1]

			if var_12_4 < var_12_3 + 1 and var_12_3 <= var_12_4 then
				return true
			end
		end

		return false
	end,
	GetSkillItemDecs = function(arg_13_0, arg_13_1)
		local var_13_0 = ActivityLinkGameGoodsCfg[arg_13_1].goods_des
		local var_13_1 = ActivityLinkGameGoodsCfg[arg_13_1].coin_num
		local var_13_2 = ActivityLinkGameGoodsCfg[arg_13_1].extra_param[1]

		return string.format(var_13_0, var_13_1, var_13_2)
	end,
	UseSkillItem = function(arg_14_0, arg_14_1)
		local var_14_0 = DormLinkGameData:GetGameCacheInfo()

		if not var_14_0.useItemList[arg_14_1] then
			var_14_0.useItemList[arg_14_1] = 0
		end

		var_14_0.useItemList[arg_14_1] = var_14_0.useItemList[arg_14_1] + 1
		var_14_0.costTokenNum = var_14_0.costTokenNum + ActivityLinkGameGoodsCfg[arg_14_1].coin_num

		arg_14_0:ImplementItemEffect(arg_14_1)
		manager.notify:Invoke(LIANLIANKAN_USE_ITEM)
	end,
	ImplementItemEffect = function(arg_15_0, arg_15_1)
		if arg_15_1 == DormLinkGameConst.SkillItemEffectType.Eliminate then
			manager.notify:Invoke(LIANLIANKAN_AUTO_MATCH)
		elseif arg_15_1 == DormLinkGameConst.SkillItemEffectType.ClearMaterialList then
			local var_15_0 = ActivityLinkGameGoodsCfg[arg_15_1].extra_param[1]

			DormLinkGameData:ClearConveyorMaterial(var_15_0)
			DormLinkGameData:PauseMaterialGenerate(var_15_0)
		end
	end,
	ExitGame = function(arg_16_0)
		DormLinkGameData:DisposeGameCacheInfo()
		LuaExchangeHelper.GoToMain()
		OpenPageUntilLoaded("/dormLinkGameLevelView")
	end
}
