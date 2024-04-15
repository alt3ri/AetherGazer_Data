return {
	GetChallengeCurrencyID = function (slot0)
		if slot0 == ActivityConst.XUHENG_PT2 then
			return CurrencyIdMapCfg.CURRENCY_XUHENG_TICKET.item_id
		elseif slot0 == ActivityConst.ACTIVITY_2_1_PT2 then
			return CurrencyIdMapCfg.CURRENCY_XUHENG_PT_TICKET.item_id
		elseif slot0 == ActivityConst.ACTIVITY_2_2_PT2 then
			return CurrencyIdMapCfg.CURRENCY_XUHENG_PT_TICKET_2_2.item_id
		elseif slot0 == ActivityConst.ACTIVITY_2_4_PT2_UP then
			return CurrencyIdMapCfg.CURRENCY_PT_TICKET_2_4_UP.item_id
		elseif slot0 == ActivityConst.ACTIVITY_2_4_PT2_DOWN then
			return CurrencyIdMapCfg.CURRENCY_PT_TICKET_2_4_DOWN.item_id
		elseif slot0 == ActivityConst.KAGUTSUCHI_ACTIVITY_PT2_DOWN then
			return CurrencyIdMapCfg.CURRENCY_PT_TICKET_2_7.item_id
		elseif slot0 == ActivityConst.ACTIVITY_2_8_PT2_UP then
			return CurrencyIdMapCfg.CURRENCY_PT_COIN_2_8.item_id
		elseif slot0 == ActivityConst.ACTIVITY_2_8_PT2_DOWN then
			return CurrencyIdMapCfg.CURRENCY_PT_COIN_2_9.item_id
		else
			return CurrencyIdMapCfg.CURRENCY_XUHENG_TICKET.item_id
		end
	end,
	GetHelpKey = function (slot0)
		if slot0 == ActivityConst.XUHENG_PT2 then
			return "ACTIVITY_XUHENG_PT_DESCRIBE"
		elseif slot0 == ActivityConst.ACTIVITY_2_1_PT2 then
			return "ACTIVITY_XUHENG_PT_DESCRIBE_1"
		elseif slot0 == ActivityConst.ACTIVITY_2_2_PT2 then
			return "ACTIVITY_XUHENG_PT_DESCRIBE_2_2"
		elseif slot0 == ActivityConst.ACTIVITY_2_4_PT2_UP then
			return "ACTIVITY_PT_DESCRIBE_2_4_UP"
		elseif slot0 == ActivityConst.ACTIVITY_2_4_PT2_DOWN then
			return "ACTIVITY_PT_DESCRIBE_2_4_DOWN"
		elseif slot0 == ActivityConst.KAGUTSUCHI_ACTIVITY_PT2_DOWN then
			return "ACTIVITY_PT_DESCRIBE_2_7"
		elseif slot0 == ActivityConst.ACTIVITY_2_8_PT2_UP then
			return "ACTIVITY_PT_DESCRIBE_2_8"
		elseif slot0 == ActivityConst.ACTIVITY_2_8_PT2_DOWN then
			return "ACTIVITY_PT_DESCRIBE_2_9"
		else
			return ""
		end
	end,
	GetEnterUIName = function (slot0)
		if slot0 == ActivityConst.XUHENG_PT2 then
			return "UI/VersionUI/XuHeng1stUI/XH1stPtUI/XH1stPtHomeUI"
		elseif slot0 == ActivityConst.ACTIVITY_2_1_PT2 then
			return "UI/VersionUI/XuHeng2ndUI/XH2ndPtUI/XH2ndPtMainUI"
		elseif slot0 == ActivityConst.ACTIVITY_2_2_PT2 then
			return "UI/VersionUI/XuHeng3rdUI/XH3rdPtUI/XH3rdPtMainUI"
		elseif slot0 == ActivityConst.ACTIVITY_2_4_PT2_UP then
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionPTUI/JapanRegionPtMainUpUI"
		elseif slot0 == ActivityConst.ACTIVITY_2_4_PT2_DOWN then
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionPTUI/JapanRegionPtMainDownUI"
		elseif slot0 == ActivityConst.KAGUTSUCHI_ACTIVITY_PT2_DOWN then
			return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionPtDownUI/JapanRegionPtMainDownUI"
		elseif slot0 == ActivityConst.ACTIVITY_2_8_PT2_UP then
			return "UI/VersionUI/IndiaUI_2_8/IndiaPTUp/IndiaPTUpMainUI"
		elseif slot0 == ActivityConst.ACTIVITY_2_8_PT2_DOWN then
			return "UI/VersionUI/IndiaUI_2_8/IndiaPTDown/IndiaPTDownMainUI"
		else
			return "UI/VersionUI/XuHeng1stUI/XH1stPtUI/XH1stPtHomeUI"
		end
	end,
	GetMainUIName = function (slot0)
		if slot0 == ActivityConst.XUHENG_PT2 then
			return "UI/VersionUI/XuHeng1stUI/XH1stPtUI/XH1stPtMainUI"
		elseif slot0 == ActivityConst.ACTIVITY_2_1_PT2 then
			return "UI/VersionUI/XuHeng2ndUI/XH2ndPtUI/XH2ndPtLevelUI"
		elseif slot0 == ActivityConst.ACTIVITY_2_2_PT2 then
			return "UI/VersionUI/XuHeng3rdUI/XH3rdPtUI/XH3rdPtLevelUI"
		elseif slot0 == ActivityConst.ACTIVITY_2_4_PT2_UP then
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionPTUI/JapanRegionPTLevelUpUI"
		elseif slot0 == ActivityConst.ACTIVITY_2_4_PT2_DOWN then
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionPTUI/JapanRegionPTLevelDownUI"
		elseif slot0 == ActivityConst.KAGUTSUCHI_ACTIVITY_PT2_DOWN then
			return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionPtDownUI/JapanRegionPTLevelDownUI"
		elseif slot0 == ActivityConst.ACTIVITY_2_8_PT2_UP then
			return "UI/VersionUI/IndiaUI_2_8/IndiaPTUp/IndiaPTUpLevelUI"
		elseif slot0 == ActivityConst.ACTIVITY_2_8_PT2_DOWN then
			return "UI/VersionUI/IndiaUI_2_8/IndiaPTDown/IndiaPTDownLevelUI"
		else
			return "UI/VersionUI/XuHeng1stUI/XH1stPtUI/XH1stPtMainUI"
		end
	end,
	GetToggleClickEffect = function (slot0, slot1)
		if uv0.GetEffectList(slot0) and #slot2 > 0 then
			slot3 = nil
			slot3 = (#slot2 <= 1 or slot2[slot1]) and slot2[1]

			return slot3[1], slot3[2], slot3[3]
		else
			return "", "", ""
		end
	end,
	GetEffectList = function (slot0)
		slot1 = {}

		if slot0 == ActivityConst.XUHENG_PT2 then
			slot1 = {
				{
					"minigame_activity_2_0",
					"minigame_activity_2_0_pt_whoosh",
					""
				}
			}
		elseif slot0 == ActivityConst.ACTIVITY_2_2_PT2 then
			slot1 = {
				{
					"minigame_activity_2_2",
					"minigame_activity_2_2_pt_loop01",
					""
				},
				{
					"minigame_activity_2_2",
					"minigame_activity_2_2_pt_loop02",
					""
				},
				{
					"minigame_activity_2_2",
					"minigame_activity_2_2_pt_loop03",
					""
				}
			}
		end

		return slot1
	end,
	GetBtnEnterAnimation = function (slot0)
		if slot0 == ActivityConst.ACTIVITY_2_1_PT2 then
			return "Fx_easylevel_cx"
		elseif slot0 == ActivityConst.ACTIVITY_2_4_PT2_UP then
			return "Fx_level_cx"
		elseif slot0 == ActivityConst.ACTIVITY_2_4_PT2_DOWN then
			return "Fx_level_cx"
		else
			return ""
		end
	end,
	GetBtnDisappearAnimation = function (slot0)
		if slot0 == ActivityConst.ACTIVITY_2_1_PT2 then
			return "Fx_easylevel_xuanzhong_xs"
		elseif slot0 == ActivityConst.ACTIVITY_2_4_PT2_UP then
			return "Fx_tuichu"
		elseif slot0 == ActivityConst.ACTIVITY_2_4_PT2_DOWN then
			return "Fx_tuichu"
		else
			return ""
		end
	end,
	GetBtnAppearAnimation = function (slot0)
		if slot0 == ActivityConst.ACTIVITY_2_1_PT2 then
			return "Fx_easylevel_xuanzhong_cx"
		elseif slot0 == ActivityConst.ACTIVITY_2_4_PT2_UP then
			return "Fx_dianji"
		elseif slot0 == ActivityConst.ACTIVITY_2_4_PT2_DOWN then
			return "Fx_dianji"
		else
			return ""
		end
	end,
	GetTaskActivityID = function (slot0, slot1)
		if slot1 == ActivityConst.XUHENG_PT2 then
			return ActivityConst.XUHENG_PT2_TASK
		elseif slot1 == ActivityConst.ACTIVITY_2_1_PT2 then
			return ActivityConst.ACTIVITY_2_1_PT2_TASK
		elseif slot1 == ActivityConst.ACTIVITY_2_2_PT2 then
			return ActivityConst.ACTIVITY_2_2_PT2_TASK
		elseif slot1 == ActivityConst.ACTIVITY_2_4_PT2_UP then
			return ActivityConst.ACTIVITY_2_4_PT2_TASK_UP
		elseif slot1 == ActivityConst.ACTIVITY_2_4_PT2_DOWN then
			return ActivityConst.ACTIVITY_2_4_PT2_TASK_DOWN
		elseif slot1 == ActivityConst.KAGUTSUCHI_ACTIVITY_PT2_DOWN then
			return ActivityConst.KAGUTSUCHI_ACTIVITY_PT2_TASK_DOWN
		elseif slot1 == ActivityConst.ACTIVITY_2_8_PT2_UP then
			return ActivityConst.ACTIVITY_2_8_PT2_TASK_UP
		elseif slot1 == ActivityConst.ACTIVITY_2_8_PT2_DOWN then
			return ActivityConst.ACTIVITY_2_8_PT2_TASK_DOWN
		else
			return ActivityConst.XUHENG_PT2_TASK
		end
	end,
	GetMainActivityID = function (slot0, slot1)
		for slot6, slot7 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_PT_2]) do
			if table.indexof(ActivityCfg[slot7].sub_activity_list, slot1) then
				return slot7
			end
		end
	end
}
