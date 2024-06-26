slot0 = class("ChatMutedView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Common/Pop/LineReportTipsUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot0.textContent_.text = ChatData:GetMutedData().i18nInfo[SettingData:GetCurrentLanguage()] or slot1.mutedContent
	slot0.textTime_.text = GetTips("MUTE_TIME_TEXT") .. manager.time:DescCTime(slot1.mutedTimestamp, GetTips("MUTE_TIME_FORMAT"))
	slot0.timer_ = Timer.New(function ()
		if uv0.mutedTimestamp <= manager.time:GetServerTime() then
			uv1:Back()

			return
		end
	end, 1, -1)

	slot0.timer_:Start()
	ChatData:SetShowMutedTips(true)
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonSure_, nil, function ()
		uv0:Back()
	end)
end

return slot0
