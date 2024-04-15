slot0 = class("GuildFoundedView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Club/ClubCreateUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot0:RegisterEvent()
	slot0:RefreshBar()

	slot0.textCost_.text = GameSetting.club_founded_cost.value[1]
	slot0.headIconID_ = slot0.headIconID_ or math.random(1, #ClubHeadIconCfg.all)

	slot0:RefreshHeadIcon()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.RegisterEvent(slot0)
	slot0:RegistEventListener(GUILD_SWITCH_HEAD_ICON, handler(slot0, slot0.SwitchHeadIcon))
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.RefreshBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:RegistBackCallBack(function ()
		uv0:Back()
	end)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.selIconBtn, nil, function ()
		JumpTools.OpenPageByJump("guildHeadIconSelect", {
			selectID = uv0.headIconID_
		})
	end)
	slot0:AddBtnListener(slot0.buttonFounded_, nil, function ()
		if uv0.inputFieldName_.text == "" then
			ShowTips("INPUT_CHAT_CONTENT")

			return
		end

		if IsAllSpace(uv0.inputFieldName_.text) then
			ShowTips("INPUT_CHAT_CONTENT")

			uv0.inputFieldName_.text = ""

			return
		end

		slot0, slot1 = textLimit(uv0.inputFieldName_.text, GameSetting.club_name_max.value[1])

		if not nameRule(uv0.inputFieldName_.text) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		if not slot1 then
			ShowTips("CLUB_FOUNDED_NAME_MAX")

			return
		end

		slot3, slot4 = textLimit(uv0.inputFieldNotice_.text, GameSetting.club_announcement_max.value[1])
		uv0.inputFieldNotice_.text = GetI18NText(slot3)

		if not slot4 then
			ShowTips(string.format(GetTips("ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE"), slot2))

			return
		end

		if not nameRule(slot3, true) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		WordVerifyBySDK(uv0.inputFieldName_.text .. "" .. uv0.inputFieldNotice_.text, function (slot0)
			if not slot0 then
				ShowTips("SENSITIVE_WORD")

				return
			end

			if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) < GameSetting.club_founded_cost.value[1] then
				ShopTools.DefaultOpenPopUp(GameSetting.club_founded_cost.value[1] - slot1)

				return
			end

			GuildAction.FoundedGuild(uv0.inputFieldName_.text, uv0.inputFieldNotice_.text, uv0.headIconID_, function (slot0)
				if isSuccess(slot0.result) then
					ShowTips("CLUB_FOUNDED_SUCCESS")
					SendMessageManagerToSDK("guild_join")

					uv0.inputFieldName_.text = ""
					uv0.inputFieldNotice_.text = ""
				else
					ShowTips(slot0.result)
				end
			end)
		end, JUDGE_MESSAGE_TYPE.GUILD_NAME)
	end)
end

function slot0.SwitchHeadIcon(slot0, slot1)
	slot0.headIconID_ = slot1

	slot0:RefreshHeadIcon()
end

function slot0.RefreshHeadIcon(slot0)
	slot1 = ClubHeadIconCfg[slot0.headIconID_]
	slot0.imageIcon_.sprite = getSpriteViaConfig("ClubHeadIcon", slot1.iconName)
	slot0.imageBg_.sprite = getSpriteViaConfig("ClubHeadIcon", slot1.bg)
end

return slot0
