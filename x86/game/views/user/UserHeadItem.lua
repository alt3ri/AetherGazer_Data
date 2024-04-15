slot0 = class("UserHeadItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectCon_ = ControllerUtil.GetController(slot0.iconGo_.transform, "select")
	slot0.lockCon_ = ControllerUtil.GetController(slot0.iconGo_.transform, "lock")
	slot0.useCon_ = ControllerUtil.GetController(slot0.iconGo_.transform, "use")
	slot0.typeCon_ = ControllerUtil.GetController(slot0.iconGo_.transform, "type")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.iconBtn_, nil, function ()
		if uv0.clickFunc_ then
			uv0.clickFunc_()
		end
	end)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	manager.redPoint:unbindUIandKey(slot0.transform_)

	slot0.itemID_ = slot1

	if slot2 == "portrait" then
		slot0.info_ = PlayerData:GetPortrait(slot0.itemID_)

		slot0.typeCon_:SetSelectedState("portrait")

		slot0.icon_.sprite = ItemTools.getItemSprite(slot0.itemID_)

		slot0.icon_:SetNativeSize()
	elseif slot2 == "frame" then
		slot0.info_ = PlayerData:GetFrame(slot0.itemID_)

		slot0.typeCon_:SetSelectedState("frame")

		slot0.frame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot0.itemID_)
	elseif slot2 == "cardBg" then
		slot0.info_ = PlayerData:GetCardBg(slot0.itemID_)

		slot0.typeCon_:SetSelectedState("cardBg")

		slot0.cardBgIcon_.sprite = ItemTools.getItemSprite(slot0.itemID_)

		slot0.cardBgIcon_:SetNativeSize()
	elseif slot2 == "chatBubble" then
		slot0.info_ = {
			unlock = table.keyof(PlayerData:GetUnlockChatBubbleIDList(), slot0.itemID_) and 1 or 0
		}

		slot0.typeCon_:SetSelectedState("chatBubble")

		slot0.chatBubbleImg_.sprite = ItemTools.getItemSprite(slot0.itemID_)
		slot3 = ChatBubbleCfg[slot0.itemID_].color1
		slot0.chatBubbleTxt_.color = Color(slot3[1], slot3[2], slot3[3])

		manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.CHAT_BUBBLE, slot0.itemID_))
	end

	slot0.lockCon_:SetSelectedState(slot0.info_.unlock == 0 and "lock" or "default")
	SetActive(slot0.timeCntGo_, slot0.info_.lasted_time and slot0.info_.lasted_time > 0)
	slot0:RefreshTime()
end

function slot0.RefreshTime(slot0)
	slot0:StopTimer()

	if not slot0.info_.lasted_time or slot0.info_.lasted_time == 0 then
		return
	end

	if slot0.info_.lasted_time - manager.time:GetServerTime() <= 0 then
		slot0.timeCntText_.text = GetTips("TIP_EXPIRED")
	else
		slot0.timeCntText_.text = manager.time:GetLostTimeStr2(slot0.info_.lasted_time)
	end

	slot0.timer_ = Timer.New(function ()
		if uv0.info_.lasted_time - manager.time:GetServerTime() > 0 then
			uv0.timeCntText_.text = manager.time:GetLostTimeStr2(uv0.info_.lasted_time)
		else
			uv0.timeCntText_.text = GetTips("TIP_EXPIRED")

			if uv0.info_.unlock == 1 then
				if curPage == "frame" then
					PlayerData:LockFrame(uv0.itemID_)

					if PlayerData:GetCurFrame() == uv0.itemID_ then
						PlayerAction.ChangeFrameIcon(GameSetting.profile_avatar_frame_default.value[1])
					end
				elseif curPage == "cardBg" then
					PlayerData:LockCardBg(uv0.itemID_)

					if PlayerData:GetCurCardBg() == uv0.itemID_ then
						PlayerAction.ChangeCardBg(GameSetting.profile_business_card_default.value[1])
					end
				end
			end

			uv0:StopTimer()
		end
	end, -1, 1)

	slot0.timer_:Start()
end

function slot0.SetUsed(slot0, slot1)
	slot0.useCon_:SetSelectedState(slot1 and "used" or "default")
end

function slot0.SetSelected(slot0, slot1)
	slot0.selectCon_:SetSelectedState(slot1 and "select" or "default")
end

function slot0.RegisterClickListener(slot0, slot1)
	slot0.clickFunc_ = slot1
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
