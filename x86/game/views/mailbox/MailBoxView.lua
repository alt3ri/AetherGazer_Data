slot0 = class("MailBoxView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Mail/MailUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
	slot0.letterContentItems_ = {}
	slot0.letterContentClass_ = {
		MailImageItemView,
		MailTextItemView,
		MailRewardItemView,
		MailTitleItemView
	}
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.letterTemplate_ = {
		slot0.imageTemplate_,
		slot0.textTemplate_,
		slot0.rewardTemplate_,
		slot0.titleTemplate_
	}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.letterUiList_ = LuaList.New(handler(slot0, slot0.IndexLetterItem), slot0.mailListGo_, MailBoxListItem)
	slot0.rewardUiList_ = LuaList.New(handler(slot0, slot0.IndexRewardItem), slot0.rewardListGo_, MailBoxRewardItem)
	slot0.allReceiveCon_ = slot0.conExCollection_:GetController("Receive_All")
	slot0.emptyController_ = slot0.conExCollection_:GetController("empty")
	slot0.rewardController_ = slot0.conExCollection_:GetController("reward")
	slot0.starController_ = ControllerUtil.GetController(slot0.starBtn_.transform, "star")
	slot0.modeController_ = slot0.conExCollection_:GetController("mode")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.delBtn_, nil, function ()
		if MailData.GetTotal() <= MailData.GetUnread() then
			ShowTips("NO_MAIL_CAN_BE_DELETED")

			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("MAIL_DELETE_CONFIRM"),
			SecondTip = GetTips("MAIL_DELETE_CONFIRM_NOTICE"),
			OkCallback = function ()
				MailAction.TryToDeteleMail(0)
			end,
			CancelCallback = function ()
			end
		})
	end)
	slot0:AddBtnListener(slot0.letterBtn_, nil, function ()
		JumpTools.GoToSystem("/letterBox")
	end)
	slot0:AddBtnListener(slot0.allReceiveBtn_, nil, function ()
		if MailData.GetTotal() == 0 then
			ShowTips("ERROR_NO_MAIL_CAN_RECEIVE")

			return
		end

		MailAction.ReceiveAllMails()
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if MailData.GetMail(uv0.curMailId_).attach_flag == 2 then
			return
		end

		uv0:OnClickReceiveBtn()
	end)
	slot0:AddBtnListener(slot0.removeBtn_, nil, function ()
		if MailData.GetMail(uv0.curMailId_).attach_flag == 1 then
			return
		end

		uv0:OnClickDeleteBtn()
	end)
	slot0:AddBtnListener(slot0.starBtn_, nil, function ()
		MailAction.SetMailStar(uv0.curMailId_, MailData.GetMail(uv0.curMailId_).star_state == 1 and 0 or 1)
	end)
	slot0:AddBtnListener(slot0.dlcBtn_, nil, function ()
		uv0:OnClickGotoPurchase()
	end)
end

function slot0.AddEventListener(slot0)
	slot0:RegistEventListener(MAIL_BRIEF_UPDATE, handler(slot0, slot0.OnBriefUpdate))
	slot0:RegistEventListener(MAIL_LIST_UPDATE, handler(slot0, slot0.OnMailListUpdate))
	slot0:RegistEventListener(MAIL_INFO_UPDATE, handler(slot0, slot0.OnMailInfoUpdate))
	slot0:RegistEventListener(MAIL_STAR_UPDATE, handler(slot0, slot0.OnMailStarUpdate))
end

function slot0.IndexRewardItem(slot0, slot1, slot2)
	slot3 = MailData.GetMail(slot0.curMailId_)

	slot2:SetRewardData(slot3.rewardList[slot1], slot3.attach_flag == 2)
end

function slot0.IndexLetterItem(slot0, slot1, slot2)
	slot2:SetMailData(MailData.GetMail(slot0:GetMailSortedList()[slot1]))
	slot2:SetClickHandler(function ()
		uv0:OnClickLetter(uv1, uv2)
	end)

	if slot0.curMailId_ then
		if slot0.curMailId_ == slot3 then
			slot2:SetSelected(true)
		else
			slot2:SetSelected(false)
		end
	elseif slot1 == 1 then
		slot0:SelectItem(1)
	end

	slot2:UpdateView()
end

function slot0.OnEnter(slot0)
	MailAction.SortMailManual()
	slot0:AddEventListener()
	manager.redPoint:bindUIandKey(slot0.letterTrans_, RedPointConst.LETTER_UNREAD)
	slot0:RefreshUI()
	slot0:StartTimer()
end

function slot0.OnTop(slot0)
	slot0:ShowDefaultBar()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
	slot0:RemoveTimer()
	manager.redPoint:unbindUIandKey(slot0.letterTrans_)
	slot0:SelectItem(nil)
end

function slot0.RefreshUI(slot0)
	slot0:UpdateList(true)
	slot0:RefreshLeftUI()
end

function slot0.OnMailInfoUpdate(slot0, slot1)
	if slot0.curMailId_ ~= nil and slot1.id == slot0.curMailId_ then
		slot0:RefreshLetterUI(slot1.id, true)
	end
end

function slot0.OnMailStarUpdate(slot0, slot1)
	if slot1.id == slot0.curMailId_ then
		slot0:RefreshStarUI()

		if slot1.star_state == 1 then
			slot0:UpdateList(false)
		end
	end
end

function slot0.OnBriefUpdate(slot0)
	slot0:RefreshLeftUI()
end

function slot0.OnMailListUpdate(slot0)
	if not MailData.IsMailDataComplete() then
		MailData.GetMailListFromServer(handler(slot0, function ()
			uv0:UpdateList()
			uv0:RefreshLeftUI()
		end))
	else
		slot0:UpdateList()
		slot0:RefreshLeftUI()
	end
end

function slot0.DeleteCurrentMail(slot0, slot1)
	if (slot1 or slot0.curMailId_) == nil then
		return
	end

	if table.indexof(slot0:GetMailSortedList(), slot2) == false then
		return
	end

	MailAction.DeleteOneMail(slot2)
end

function slot0.SelectItem(slot0, slot1)
	if slot1 == nil then
		slot0.curIndex_ = nil
		slot0.curMailId_ = nil

		if slot0.curLetterItem_ then
			slot0.curLetterItem_:SetSelected(false)
			slot0.curLetterItem_:UpdateView()

			slot0.curLetterItem_ = nil
		end

		return
	end

	if slot0:GetMailSortedList()[slot1] == 0 then
		return
	end

	if slot0.curLetterItem_ then
		slot0.curLetterItem_:SetSelected(false)
		slot0.curLetterItem_:UpdateView()
	end

	slot4 = slot0.letterUiList_:GetItemByIndex(slot1)
	slot0.curIndex_ = slot1
	slot0.curMailId_ = slot3
	slot0.curLetterItem_ = slot4

	slot4:SetSelected(true)
	MailAction.ReadMail(slot3)
	slot0:RefreshLetterUI(slot3)
end

function slot0.OnClickLetter(slot0, slot1, slot2)
	slot0:SelectItem(slot1)
end

function slot0.OnClickDeleteBtn(slot0)
	if slot0.curMailId_ ~= nil and slot1 ~= 0 then
		if MailData.GetMail(slot1).star_state == 1 then
			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = string.format(GetTips("MAIL_STAR_DELETE_TIP")),
				OkCallback = function ()
					uv0:DeleteCurrentMail(uv1)
				end,
				CancelCallback = function ()
				end
			})
		else
			slot0:DeleteCurrentMail()
		end
	end
end

function slot0.OnClickReceiveBtn(slot0)
	MailAction.TryToGetMailAttachment(slot0.curMailId_)
end

function slot0.OnClickGotoPurchase(slot0)
	if MailData.GetMail(slot0.curMailId_) and MailTools.CheckIsPurchaseTemplate(slot1.mail_template_id) then
		if slot1.mail_template_id == MailConst.MAIL_ID_CONST.SKIN_DLC_EXPIRE and slot1.link_param[1] and slot1.link_param[2] and slot1.link_param[3] then
			ShopTools.JumpToSkinShop(slot1.link_param[2], true, slot1.link_param[1], slot1.link_param[3])
		elseif slot1.mail_template_id == MailConst.MAIL_ID_CONST.SKIN_EXPIRE and slot1.link_param[1] then
			ShopTools.JumpToSkinShop(slot1.link_param[1], false)
		end
	end
end

function slot0.RefreshLetterUI(slot0, slot1, slot2)
	slot0.titleText_.text = MailData.GetMailTitle(slot1)
	slot0.dateText_.text = manager.time:STimeDescS(MailData.GetMail(slot1).date, "!%Y-%m-%d")

	if not slot2 then
		SetActive(slot0.itemParent_.gameObject, false)
		MailData.TryToGetMailDetail(slot3.id, handler(slot0, function ()
			uv0:UpdateMailContentView(uv1)
			TimeTools.StartAfterSeconds(0.1, function ()
				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.itemParent_.transform)
				SetActive(uv0.itemParent_.gameObject, true)
			end, {})
		end))
	else
		SetActive(slot0.itemParent_.gameObject, true)
	end

	slot0.rewardUiList_:StartScroll(#slot3.rewardList)
	slot0:RenderRewardState(slot3)
end

function slot0.RenderRewardState(slot0, slot1)
	if MailTools.CheckIsPurchaseTemplate(slot1.mail_template_id) then
		slot0.rewardController_:SetSelectedState("dlc")
		slot0.modeController_:SetSelectedState("delete")

		return
	end

	if slot1.attach_flag == 0 then
		slot0.rewardController_:SetSelectedState("false")
		slot0.modeController_:SetSelectedState("delete")
	elseif slot1.attach_flag == 2 then
		slot0.rewardController_:SetSelectedState("true")
		slot0.modeController_:SetSelectedState("delete")
	else
		slot0.rewardController_:SetSelectedState("true")
		slot0.modeController_:SetSelectedState("reward")
	end
end

function slot0.RefreshStarUI(slot0)
	if MailData.GetMail(slot0.curMailId_).star_state == 1 then
		slot0.starController_:SetSelectedState("true")
	else
		slot0.starController_:SetSelectedState("false")
	end
end

function slot0.RefreshLeftUI(slot0)
	slot0.mailNumText_.text = string.format("%d/%d", MailData.GetTotal(), GameSetting.max_mail_count.value[1])

	slot0:RefreshAllReceiveUI()
end

function slot0.RefreshCountdownUI(slot0)
	for slot4, slot5 in pairs(slot0.letterUiList_:GetItemList()) do
		if slot5 then
			slot5:UpdateCountdown()
		end
	end
end

function slot0.RefreshAllReceiveUI(slot0)
	slot2 = false

	for slot6, slot7 in pairs(slot0:GetMailSortedList()) do
		if MailData.GetMail(slot7) and slot8.attach_flag == 1 then
			slot2 = true

			break
		end
	end

	slot0.allReceiveCon_:SetSelectedState(slot2 and "true" or "false")
end

function slot0.UpdateMailContentView(slot0, slot1)
	slot0.senderText_.text = MailData.GetMailSender(slot1.id)

	slot0:RefreshStarUI()
	slot0:ClearLetterContent()

	for slot6, slot7 in ipairs(MailData.GetMailContent(slot1.id)) do
		slot0:CreateContent(slot7)
	end
end

function slot0.CreateContent(slot0, slot1)
	slot2 = slot1.content_type
	slot6 = slot0.letterContentClass_[slot2].New(Object.Instantiate(slot0.letterTemplate_[slot2], slot0.itemParent_.transform))

	slot6:SetData(slot1)
	table.insert(slot0.letterContentItems_, slot6)
end

function slot0.UpdateList(slot0, slot1)
	slot0.emptyController_:SetSelectedState(MailData.GetTotal() <= 0 and "true" or "false")

	if slot2 <= 0 then
		slot0.letterUiList_:StartScroll(0)
		slot0:SelectItem(nil)
	else
		slot3 = slot0:GetMailSortedList()

		if slot0.curMailId_ then
			if table.indexof(slot3, slot0.curMailId_) then
				slot0.curIndex_ = slot4
			else
				slot0.curIndex_ = math.min(slot0.curIndex_, #slot3)
			end

			slot0.letterUiList_:StartScroll(#slot3, slot0.curIndex_, not slot1)
			slot0:SelectItem(slot0.curIndex_)
		else
			slot0.letterUiList_:StartScroll(#slot3)
		end
	end
end

function slot0.StartTimer(slot0)
	if not slot0.timer_ then
		slot0.timer_ = Timer.New(function ()
			if #MailData.GetTimeoutMailIdList() > 0 then
				MailData.DeleteMail(slot0)
				ShowTips("MAIL_EXPIRED")
			end

			uv0:RefreshCountdownUI()
		end, 1, -1)
	end

	slot0.timer_:Start()
end

function slot0.RemoveTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	if slot0.letterUiList_ then
		slot0.letterUiList_:Dispose()

		slot0.letterUiList_ = nil
	end

	if slot0.rewardUiList_ then
		slot0.rewardUiList_:Dispose()

		slot0.rewardUiList_ = nil
	end

	slot0:ClearLetterContent()

	slot0.letterContentItems_ = nil

	manager.classPool:DisposeOnePool(MailBoxListItem)
	uv0.super.Dispose(slot0)
end

function slot0.ClearLetterContent(slot0)
	for slot4 = #slot0.letterContentItems_, 1, -1 do
		slot0.letterContentItems_[slot4]:Dispose()

		slot0.letterContentItems_[slot4] = nil
	end
end

function slot0.GetMailSortedList(slot0)
	return MailData.GetMailSort()
end

return slot0
