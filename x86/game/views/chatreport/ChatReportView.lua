slot0 = class("ChatReportView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Friends/LineReportUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.optionDataList_ = {}

	for slot4, slot5 in ipairs(ChatConst.CHAT_REPORT_REASON) do
		slot0.optionDataList_[slot4] = OptionDataList.New()

		for slot9, slot10 in ipairs(slot5) do
			if slot10 == 0 then
				slot0.optionDataList_[slot4].options:Add(OptionData.New(GetTips("REPORT_SELECT")))
			else
				slot0.optionDataList_[slot4].options:Add(OptionData.New(GetTips(ChatConst.CHAT_REASON_INDEX[slot10])))
			end
		end
	end
end

function slot0.OnEnter(slot0)
	slot0.inputFieldNote_.text = ""
	slot0.textNick_.text = GetI18NText(slot0.params_.reportData.nick)
	slot0.dropDownReason_.options = slot0.optionDataList_[slot0.params_.reportType].options
	slot0.dropDownReason_.value = 0
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.optionDataList_) do
		slot5.options:Clear()
	end

	slot0.optionDataList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonCancel_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonSure_, nil, function ()
		if uv0.dropDownReason_.value == 0 then
			ShowTips("NEED_REPORT_REASON")

			return
		end

		if uv0.params_.reportType == ChatConst.CHAT_REPORT_TYPE.CONTENT then
			ChatAction.ChatReportMsg(uv0.params_.reportData.msgID, ChatConst.CHAT_REPORT_REASON[uv0.params_.reportType][uv0.dropDownReason_.value + 1], uv0.inputFieldNote_.text, function (slot0)
				if isSuccess(slot0.result) then
					ShowMessageBox({
						ButtonType = "SingleBtn",
						isTop = true,
						content = GetTips("REPORT_SUCCESS"),
						OkCallback = function ()
							uv0:Back()
						end
					})
				else
					ShowTips(slot0.result)
				end
			end)
		elseif uv0.params_.reportType == ChatConst.CHAT_REPORT_TYPE.USER then
			ChatAction.ChatReportUser(uv0.params_.reportData.userID, ChatConst.CHAT_REPORT_REASON[uv0.params_.reportType][uv0.dropDownReason_.value + 1], uv0.inputFieldNote_.text, function (slot0)
				if isSuccess(slot0.result) then
					ShowMessageBox({
						ButtonType = "SingleBtn",
						isTop = true,
						content = GetTips("REPORT_SUCCESS"),
						OkCallback = function ()
							uv0:Back()
						end
					})
				else
					ShowTips(slot0.result)
				end
			end)
		elseif uv0.params_.reportType == ChatConst.CHAT_REPORT_TYPE.DORM then
			function slot0()
				SetActive(manager.ui.uiPop.transform, false)
				WaitRenderFrameUtil.inst.StartScreenShot(function ()
					slot1, slot2 = SettingTools.GetSettingScreenSize(tonumber(SettingData:GetSettingData().pic.resolution))

					if not SDKTools.IsSDK() then
						slot2 = Screen.height
						slot1 = Screen.width
					end

					uv0.screenSnap_ = ScreenSnap.New(slot1, slot2)

					uv0.screenSnap_:Take()

					slot3 = uv0.screenSnap_:GetSprite()

					SetActive(manager.ui.uiPop.transform, true)

					if uv0.params_.reportData then
						slot4 = PlayerData:GetPlayerInfo().userID .. "_" .. PlayerData:GetPlayerInfo().signUserId

						function slot6(slot0)
							if slot0 == "ServerError" then
								print("图片服务器上传失败")

								return
							end

							ChatAction.DormReportUser({
								reported_user_id = uv0.params_.reportData.userID,
								layout_uid = uv0.params_.reportData.layout_uid,
								architecture_id = uv0.params_.reportData.architecture_id,
								report_type = ChatConst.CHAT_REPORT_REASON[uv0.params_.reportType][uv0.dropDownReason_.value + 1],
								report_note = uv0.inputFieldNote_.text,
								picture_link = slot0
							}, function (slot0)
								if not isSuccess(slot0.result) then
									ShowTips(slot0.result)
								end
							end)
						end

						slot7 = OperationAction.GetOperationUrl("REST_URL")

						print("获取图片服务器路径", slot7)

						if not slot7 then
							print("获取图片服务器路径失败")
						else
							DormLuaBridge.SavePhotoToWebServer(slot3, slot7 .. "/common/uploadResource", slot4, slot6)
						end

						uv0:Back()
						ShowTips("REPORT_SUCCESS")
					end
				end)
			end

			WordVerifyBySDK(uv0.inputFieldNote_.text, function (slot0)
				if not slot0 then
					ShowTips("ERROR_USER_NAME_VER_WORD")
				elseif uv0 then
					uv0()
				end
			end, JUDGE_MESSAGE_TYPE.OTHER)
		end
	end)
end

return slot0
