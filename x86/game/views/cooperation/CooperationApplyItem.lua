slot0 = class("CooperationApplyItem", ReduxView)

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

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.onlineController = ControllerUtil.GetController(slot0.transform_, "online")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_agreeBtn, function ()
		CooperationAction.ReceiveInvite(uv0.uid)
	end)
	slot0:AddBtnListener(nil, slot0.m_refuseBtn, function ()
		CooperationAction.DelectInvite({
			uv0.uid
		})
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.data = slot1
	slot0.dest = slot1.dest
	slot0.uid = slot1.uid
	slot0.room_id = slot1.room_id
	slot0.m_name.text = GetI18NText(slot1.nick)
	slot0.m_lvLab.text = "LV." .. slot1.level
	slot0.m_icon.sprite = ItemTools.getItemSprite(slot1.icon)
	slot0.m_frame.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot1.icon_frame)
	slot0.m_timeLab.text = slot0:GetOnLineText(slot1.timestamp)
	slot0.m_destName.text = CooperationTools.GetCooperationRoomName(slot1.battle_type, slot1.dest, slot1.activity_id)

	slot0:UpdateState()
end

function slot0.GetOnLineText(slot0, slot1)
	if slot1 == 0 then
		return GetTips("ONLINE")
	end

	if manager.time:GetServerTime() - slot1 < 60 then
		return GetTips("FRIEND_ONLINE_TIME_ONE_MINUTE")
	elseif slot2 < 300 then
		return GetTips("FRIEND_ONLINE_TIME_FIVE_MINUTE")
	elseif slot2 < 3600 then
		return GetTips("FRIEND_ONLINE_TIME_WITHIN_AN_HOUR")
	elseif slot2 < 86400 then
		return GetTips("FRIEND_ONLINE_TIME_IN_ONE_DAY")
	elseif slot2 < 2592000 then
		return string.format(GetTips("FRIEND_ONLINE_TIME_ONE_DAY_AGO"), math.floor(slot2 / 86400))
	else
		return string.format(GetTips("FRIEND_ONLINE_TIME_ONE_DAY_AGO"), 30)
	end
end

function slot0.UpdateState(slot0)
	slot0.stateController:SetSelectedIndex(slot0.data.refuse and 1 or 0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
