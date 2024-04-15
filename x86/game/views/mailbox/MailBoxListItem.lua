slot0 = class("MailBoxListItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:AddEventListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.starController_ = slot0.conExCollection_:GetController("star")
	slot0.readController_ = slot0.conExCollection_:GetController("read")
	slot0.rewardController_ = slot0.conExCollection_:GetController("reward")
	slot0.selectController_ = slot0.conExCollection_:GetController("select")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.onClickHandler_ ~= nil then
			uv0:onClickHandler_()
		end
	end)
end

function slot0.AddEventListener(slot0)
	slot0:RegistEventListener(MAIL_INFO_UPDATE, handler(slot0, slot0.OnMailInfoUpdate))
	slot0:RegistEventListener(MAIL_STAR_UPDATE, handler(slot0, slot0.OnMailStarUpdate))
end

function slot0.OnMailInfoUpdate(slot0, slot1)
	if slot1.id == slot0.data_.id then
		slot0:UpdateView()
	end
end

function slot0.OnMailStarUpdate(slot0, slot1)
	if slot1.id == slot0.data_.id then
		slot0:UpdateStar()
	end
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.SetMailData(slot0, slot1)
	slot0.data_ = slot1
end

function slot0.SetClickHandler(slot0, slot1)
	slot0.onClickHandler_ = slot1
end

function slot0.UpdateView(slot0)
	if MailData.GetMail(slot0.data_.id) == nil then
		return
	end

	slot0.nameText_.text = MailData.GetMailTitle(slot0.data_.id)

	slot0.rewardController_:SetSelectedState(slot0.data_.attach_flag > 0 and "true" or "false")

	if slot0.data_.attach_flag == 2 then
		slot0.rewardController_:SetSelectedState("false")
	else
		slot0.rewardController_:SetSelectedState(slot3 and "true" or "false")
	end

	slot0:UpdateRead()
	slot0:UpdateStar()
	slot0:UpdateCountdown()
	slot0.selectController_:SetSelectedState(slot0.selected_ and "true" or "false")
end

function slot0.UpdateStar(slot0)
	if slot0.data_.star_state == 1 then
		slot0.starController_:SetSelectedState("true")
	else
		slot0.starController_:SetSelectedState("false")
	end
end

function slot0.UpdateRead(slot0)
	if slot0.selected_ then
		slot0.readController_:SetSelectedState("false")
	elseif MailData.HaveMailRead(slot0.data_.id) then
		slot0.readController_:SetSelectedState("true")
	else
		slot0.readController_:SetSelectedState("false")
	end
end

function slot0.SetSelected(slot0, slot1)
	slot0.selected_ = slot1
end

function slot0.UpdateCountdown(slot0)
	slot0.tipsText_.text = string.format(GetTips("TIME_DISPLAY_5"), MailTools.GetLostTimeStr(slot0.data_.timeout_timestamp))
end

function slot0.GetData(slot0)
	return slot0.data_
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:RemoveAllEventListener()
	uv0.super.Dispose(slot0)
end

return slot0
