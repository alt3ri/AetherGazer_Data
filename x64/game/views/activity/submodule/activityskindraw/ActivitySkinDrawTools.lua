return {
	GetMainUIName = function (slot0)
		if slot0 == ActivityConst.ACTIVITY_2_2_SKIN_DRAW then
			return "UI/VersionUI/XuHeng3rdUI/T0Scene/T0Scene"
		else
			return "UI/VersionUI/XuHeng3rdUI/T0Scene/T0Scene"
		end
	end,
	GetTaskUIName = function (slot0)
		if slot0 == ActivityConst.ACTIVITY_2_2_SKIN_DRAW then
			return "UI/VersionUI/XuHeng3rdUI/T0Scene/T0Scene2"
		else
			return "UI/VersionUI/XuHeng3rdUI/T0Scene/T0Scene2"
		end
	end,
	GetPopUIName = function (slot0)
		if slot0 == ActivityConst.ACTIVITY_2_2_SKIN_DRAW then
			return "UI/VersionUI/XuHeng3rdUI/T0Scene/T0Scene3"
		else
			return "UI/VersionUI/XuHeng3rdUI/T0Scene/T0Scene3"
		end
	end,
	GetDrawStartUIName = function (slot0)
		if slot0 == ActivityConst.ACTIVITY_2_2_SKIN_DRAW then
			return "UI/VersionUI/XuHeng3rdUI/T0Scene/DrawCardsUI/T0_DrawCardUI"
		else
			return "UI/VersionUI/XuHeng3rdUI/T0Scene/DrawCardsUI/T0_DrawCardUI"
		end
	end,
	GetDrawRewardUIName = function (slot0)
		if slot0 == ActivityConst.ACTIVITY_2_2_SKIN_DRAW then
			return "UI/VersionUI/XuHeng3rdUI/T0Scene/SingledrawUI/T0_Single"
		else
			return "UI/VersionUI/XuHeng3rdUI/T0Scene/SingledrawUI/T0_Single"
		end
	end,
	GetDrawResultUIName = function (slot0)
		if slot0 == ActivityConst.ACTIVITY_2_2_SKIN_DRAW then
			return "UI/VersionUI/XuHeng3rdUI/T0Scene/T0Scene4"
		else
			return "UI/VersionUI/XuHeng3rdUI/T0Scene/T0Scene4"
		end
	end,
	GetDrawInfoUIName = function (slot0)
		if slot0 == ActivityConst.ACTIVITY_2_2_SKIN_DRAW then
			return "UI/VersionUI/XuHeng3rdUI/T0Scene/T0_DrawInfoUI"
		else
			return "UI/VersionUI/XuHeng3rdUI/T0Scene/T0_DrawInfoUI"
		end
	end,
	GetTaskActivityID = function (slot0)
		if slot0 == ActivityConst.ACTIVITY_2_2_SKIN_DRAW then
			return ActivityConst.ACTIVITY_2_2_SKIN_TASK
		else
			return ActivityConst.ACTIVITY_2_2_SKIN_TASK
		end
	end,
	GetActivityShopID = function (slot0)
		return ActivityShopCfg[slot0].shop_id
	end,
	GetStoryID = function (slot0)
		if slot0 == ActivityConst.ACTIVITY_2_2_SKIN_DRAW then
			return GameSetting.limited_skin_story_1.value[1]
		else
			return GameSetting.limited_skin_story_1.value[1]
		end
	end,
	GetTypeGo = function (slot0)
		if slot0 == ActivityConst.ACTIVITY_2_2_SKIN_DRAW then
			return {
				"UI/VersionUI/XuHeng3rdUI/T0Scene/SingledrawUI/SingledrawUI_blue",
				"UI/VersionUI/XuHeng3rdUI/T0Scene/SingledrawUI/SingledrawUI_purple",
				"UI/VersionUI/XuHeng3rdUI/T0Scene/SingledrawUI/SingledrawUI_golden",
				special = "UI/VersionUI/XuHeng3rdUI/T0Scene/SingledrawUI/SingledrawUI_special",
				movie = "UI/VersionUI/XuHeng3rdUI/T0Scene/SingledrawUI/SingledrawUI_movie"
			}
		else
			return {
				"UI/VersionUI/XuHeng3rdUI/T0Scene/SingledrawUI/SingledrawUI_blue",
				"UI/VersionUI/XuHeng3rdUI/T0Scene/SingledrawUI/SingledrawUI_purple",
				"UI/VersionUI/XuHeng3rdUI/T0Scene/SingledrawUI/SingledrawUI_golden",
				special = "UI/VersionUI/XuHeng3rdUI/T0Scene/SingledrawUI/SingledrawUI_special",
				movie = "UI/VersionUI/XuHeng3rdUI/T0Scene/SingledrawUI/SingledrawUI_movie"
			}
		end
	end,
	GetTaskCurrency = function (slot0)
		if slot0 == ActivityConst.ACTIVITY_2_2_SKIN_DRAW then
			return {
				CurrencyIdMapCfg.CURRENCY_TYPE_GENGCHEN_SKIN_COIN.item_id
			}
		else
			return {}
		end
	end
}
