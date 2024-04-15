slot0 = class("ActivityInvitePlotView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionConserverUI/JapanRegionContenuUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list = LuaList.New(handler(slot0, slot0.SetItem), slot0.listGo_, ActivityInvitePlotItem)
end

function slot0.SetItem(slot0, slot1, slot2)
	slot2:SetData({
		id = slot0.inviteCfg.chat_order_seq[slot1],
		role = slot0.inviteCfg.chat_name_seq[slot1],
		heroId = slot0.inviteCfg.hero_id
	}, slot1, slot0.inviteCfg, slot0.index)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.finishBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.listBtn_, nil, function ()
		uv0.index = uv0.index + 1

		if #uv0.inviteCfg.chat_order_seq > uv0.index - 1 then
			uv0.list:StartScroll(uv0.index, uv0.index)
			manager.audio:PlayEffect("minigame_activity_2_6", "minigame_activity_2_6_talk_3", "")
		else
			SetActive(uv0.finishBtn_.gameObject, true)
		end
	end)
end

function slot0.UpdateBar(slot0)
end

function slot0.UpdateView(slot0)
	slot0.activityId = InviteData:GetDataByPara("activityId")
	slot1 = ActivityData:GetActivityData(slot0.activityId)

	SetActive(slot0.finishBtn_.gameObject, false)

	slot0.remainTxt_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(slot1.stopTime, nil, true)
	slot0.updateTimer_ = Timer.New(function ()
		uv0.remainTxt_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(uv1.stopTime, nil, true)
	end, 1, slot1.stopTime, 1)
	slot0.inviteCfg = ActivityInviteCfg[slot0.params_.id]
	slot0.nameTxt_.text = GetI18NText(HeroCfg[slot0.inviteCfg.hero_id].suffix)
	slot0.roleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/" .. tostring(slot0.inviteCfg.hero_image_route))

	slot0.list:StartScroll(slot0.index, slot0.index)
end

function slot0.OnEnter(slot0)
	slot0.index = 1

	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end

	if slot0.params_.haveReward then
		slot0.params_.haveReward = false

		ShowTips("ACTIVITY_INVITE_FINISH_TIPS")
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.list then
		slot0.list:Dispose()

		slot0.list = nil
	end

	Object.Destroy(slot0.gameObject_)
end

return slot0
