slot0 = class("DownloadPageView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Setting/SettingDownUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.downloadStateController_ = slot0.controllerEx_:GetController("default0")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		if uv0.canceling then
			return
		end

		uv0.canceling = true

		VoicePackageManager.Instance:DownloadCancel()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		CloseDownLoadPage()
	end)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.SetTitle(slot0, slot1)
	slot0.titleText_.text = GetI18NText(slot1)
end

function slot0.SetProgress(slot0, slot1, slot2)
	slot0.progressSli_.value = slot1
	slot0.progressText_.text = slot2
end

function slot0.OnEnter(slot0)
	if slot0.params_.title then
		slot0:SetTitle(slot0.params_.title)
	end

	slot0:SetProgress(0, GetTips("DOWNLOAD_START"))
	slot0.downloadStateController_:SetSelectedIndex(1)

	slot0.canceling = false

	VoicePackageManager.Instance:StartDownLoadPackage(slot0.params_.abbr)

	if slot0.updateTimer ~= nil then
		slot0.updateTimer:Stop()

		slot0.updateTimer = nil
	end

	if slot0.updateTimer == nil then
		slot0.updateTimer = Timer.New(function ()
			if VoicePackageManager.Instance:IsDownloading(VoicePackageManager.Instance:UpdateDownloading()) then
				uv0:SetTitle(GetTips("DOWNLOAD_START"))

				if VoicePackageManager.Instance:GetDownloadInfo(slot0) ~= "" then
					slot2 = string.split(slot1, ":")

					uv0:SetProgress(tonumber(slot2[2]) / tonumber(slot2[3]), slot2[4])
				end
			end

			if VoicePackageManager.Instance:IsSucceed(slot0) then
				if uv0.updateTimer ~= nil then
					uv0.updateTimer:Stop()

					uv0.updateTimer = nil
				end

				uv0.downloadStateController_:SetSelectedIndex(0)
				uv0:SetProgress(1, GetTips("DOWNLOAD_SUCCESS"))
				VoicePackageManager.Instance:InsertDownloadedPackage(uv0.params_.abbr)
				VoicePackageManager.Instance:DownloadShutdown()
				manager.notify:CallUpdateFunc(LANGUAGE_PACKAGE_DOWNLOADED, uv0.params_.abbr)
			end

			if VoicePackageManager.Instance:IsFailed(slot0) then
				uv0:SetTitle(GetTips("DOWNLOAD_FAIL"))
				uv0:SetProgress(0, GetTips("DOWNLOAD_FAIL"))
				Debug.Log("Language DownLoad Fail:" .. VoicePackageManager.Instance:GetDownloadInfo(slot0))
			end

			if VoicePackageManager.Instance:IsCanceling(slot0) then
				slot1 = VoicePackageManager.Instance:GetDownloadInfo(slot0)

				uv0:SetProgress(0, GetTips("DOWNLOAD_CANCEL"))
			end

			if VoicePackageManager.Instance:IsCanceled(slot0) then
				if uv0.updateTimer ~= nil then
					uv0.updateTimer:Stop()

					uv0.updateTimer = nil
				end

				VoicePackageManager.Instance:DownloadShutdown()
				manager.notify:CallUpdateFunc(LANGUAGE_PACKAGE_CANCEL)
				CloseDownLoadPage()
			end
		end, 0.1, -1)
	end

	slot0.updateTimer:Start()
end

function slot0.OnExit(slot0)
	if slot0.updateTimer ~= nil then
		slot0.updateTimer:Stop()

		slot0.updateTimer = nil
	end
end

function slot0.Dispose(slot0)
	slot0.params_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
