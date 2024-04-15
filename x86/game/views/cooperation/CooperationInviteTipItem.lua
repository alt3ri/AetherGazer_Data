slot0 = class("CooperationInviteTipItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.isShow = false

	SetActive(slot0.gameObject_, false)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_okBtn, function ()
		if uv0.inviteTip then
			CooperationAction.ReceiveInvite(uv0.inviteTip.invite.uid)
		end

		CooperationData:ClearNewInviteTip()
		uv0:Hide()
		manager.redPoint:setTip(RedPointConst.COOPERATION_INVIT, 0)
	end)
	slot0:AddBtnListener(nil, slot0.m_cancelBtn, function ()
		if uv0.inviteTip then
			CooperationAction.DelectInvite({
				uv0.inviteTip.invite.uid
			})
		end

		CooperationData:ClearNewInviteTip()
		uv0:HideInvite()
		manager.redPoint:setTip(RedPointConst.COOPERATION_INVIT, 0)
	end)
end

function slot0.Show(slot0)
	if not slot0.isShow then
		slot0:RegistEventListener(COOPERATION_NEW_INVITE, function ()
			uv0:Check()
		end)

		slot0.isShow = true
	end

	slot0:Check()
end

function slot0.Hide(slot0)
	if slot0.isShow then
		slot0:RemoveAllEventListener()

		slot0.isShow = false
	end

	slot0:HideInvite()
end

function slot0.HideInvite(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	SetActive(slot0.gameObject_, false)
end

function slot0.Check(slot0)
	if manager.guide:IsPlaying() then
		slot0:HideInvite()

		return
	end

	slot0.inviteTip = CooperationData:GetNewInviteTip()
	slot1 = manager.time:GetServerTime()

	if not slot0.inviteTip or slot0.inviteTip.overdue_time < slot1 then
		slot0:HideInvite()

		return
	end

	slot2 = slot0.inviteTip.invite
	slot0.m_name.text = slot2.nick
	slot0.m_icon.sprite = ItemTools.getItemSprite(slot2.icon)
	slot0.m_frame.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot2.icon_frame)
	slot0.m_des.text = slot0.inviteTip.overdue_time - slot1

	SetActive(slot0.gameObject_, true)

	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:Process()
		end, 1, -1)
	end

	slot0.timer_:Start()
	slot0:Process()
end

function slot0.Process(slot0)
	slot1 = manager.time:GetServerTime()

	if not slot0.inviteTip or slot0.inviteTip.overdue_time < slot1 then
		slot0:HideInvite()

		return
	end

	slot0.m_des.text = string.format(GetTips("ACTIVITY_STRONGHOLD_INVITED"), slot0.inviteTip.overdue_time - slot1)
end

function slot0.Dispose(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0:RemoveAllEventListener()

	slot0.isShow = false

	uv0.super.Dispose(slot0)
end

return slot0
