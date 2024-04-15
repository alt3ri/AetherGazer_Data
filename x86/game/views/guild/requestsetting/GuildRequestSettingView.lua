slot0 = class("GuildRequestSettingView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Club/ClubApplicationsettingsPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot1 = GuildData:GetGuildInfo()
	slot0[string.format("toggle%d_", tonumber(slot1.reviewFlag))].isOn = true
	slot0.reviewFlag_ = slot1.reviewFlag
	slot3 = GameSetting.user_level_max.value[1]
	slot0.curNum = slot1.limitLevel or GameSetting.club_default_level_limit.value[1]

	slot0:RefreshView()
end

function slot0.RefreshView(slot0)
	slot0.inputFieldLevel_.text = slot0.curNum
	slot0.levelText.text = slot0.curNum
	slot0.reduceNumBtn_.interactable = GameSetting.club_default_level_limit.value[1] < slot0.curNum
	slot0.addNumBtn_.interactable = slot0.curNum < GameSetting.user_level_max.value[1]
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.inputFieldLevel_.onEndEdit:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonCancel_, nil, function ()
		uv0:Back()
	end)
	slot0:AddPressingByTimeListener(slot0.reduceNumBtn_.gameObject, 3, 0.5, 0.5, function ()
		uv0.curNum = Mathf.Clamp(uv0.curNum - 1, GameSetting.club_default_level_limit.value[1], GameSetting.user_level_max.value[1])

		uv0:RefreshView()

		return true
	end)
	slot0:AddPressingByTimeListener(slot0.addNumBtn_.gameObject, 3, 0.5, 0.5, function ()
		uv0.curNum = Mathf.Clamp(uv0.curNum + 1, GameSetting.club_default_level_limit.value[1], GameSetting.user_level_max.value[1])

		uv0:RefreshView()

		return true
	end)
	slot0:AddBtnListener(slot0.buttonOk_, nil, function ()
		if uv0.inputFieldLevel_.text == "" or uv0.inputFieldLevel_.text == "-" then
			uv0.inputFieldLevel_.text = GuildData:GetGuildInfo().limitLevel
		end

		if tonumber(uv0.inputFieldLevel_.text) < GameSetting.club_default_level_limit.value[1] then
			slot0 = slot1
		end

		if GameSetting.user_level_max.value[1] < slot0 then
			slot0 = GameSetting.user_level_max.value[1]
		end

		GuildAction.GuildRequestSetting(uv0.reviewFlag_, slot0, function (slot0)
			if isSuccess(slot0.result) then
				ShowTips("CLUB_SAVE_SETTING")
				GuildData:SetGuildSetting(uv0.reviewFlag_, uv1)
				uv0:Back()
			else
				ShowTips(slot0.result)
			end
		end)
	end)
	slot0.inputFieldLevel_.onEndEdit:AddListener(function ()
		if uv0.inputFieldLevel_.text == "" or uv0.inputFieldLevel_.text == "-" then
			uv0.inputFieldLevel_.text = GuildData:GetGuildInfo().limitLevel
		else
			uv0.inputFieldLevel_.text = Mathf.Clamp(tonumber(uv0.inputFieldLevel_.text), GameSetting.club_default_level_limit.value[1], GameSetting.user_level_max.value[1])
		end

		uv0.curNum = tonumber(uv0.inputFieldLevel_.text)
		uv0.levelText.text = uv0.curNum
	end)

	slot4 = nil

	slot0:AddBtnListener(slot0.btnmaxBtn_, slot4, function ()
		uv0.curNum = GameSetting.user_level_max.value[1]

		uv0:RefreshView()
	end)

	for slot4 = 1, 3 do
		slot0:AddToggleListener(slot0[string.format("toggle%d_", slot4)], function (slot0)
			if slot0 then
				uv0.reviewFlag_ = uv1
			end
		end)
	end
end

return slot0
