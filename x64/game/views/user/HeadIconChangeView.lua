slot0 = class("HeadIconChangeView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/UserInfor/AvatarSystemUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.page_ = {
		"portrait",
		"frame",
		"cardBg",
		"chatBubble"
	}
	slot0.lockCon_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.pageCon_ = ControllerUtil.GetController(slot0.transform_, "page")
	slot0.btnCon_1 = slot0.btn_1.transform:GetComponent("ControllerExCollection"):GetController("status")
	slot0.btnCon_2 = slot0.btn_2.transform:GetComponent("ControllerExCollection"):GetController("status")
	slot0.btnCon_3 = slot0.btn_3.transform:GetComponent("ControllerExCollection"):GetController("status")
	slot0.btnCon_4 = slot0.btn_4.transform:GetComponent("ControllerExCollection"):GetController("status")
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, UserHeadItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.curList_[slot1].id

	slot2:SetUsed(slot0:IsUsed(slot3))
	slot2:SetSelected(slot0.curID_ == slot3)
	slot2:RefreshItem(slot3, slot0.curPage_)
	slot2:RegisterClickListener(function ()
		uv0:SetCurID(uv1)

		if uv0.curPage_ == "chatBubble" and not RedPointData:GetIsRedPointOpen(RedPointConst.CHAT_BUBBLE_RANGE + uv1) and table.keyof(PlayerData:GetUnlockChatBubbleIDList(), uv1) then
			RedPointAction.HandleRedPoint(RedPointConst.CHAT_BUBBLE_RANGE + uv1)
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHAT_BUBBLE, uv1), 0)
		end

		uv0.scrollHelper_:Refresh()
	end)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		if uv0.curPage_ == "portrait" then
			PlayerAction.ChangePortrait(uv0.curID_)
		elseif uv0.curPage_ == "frame" then
			PlayerAction.ChangeFrameIcon(uv0.curID_)
		elseif uv0.curPage_ == "cardBg" then
			PlayerAction.ChangeCardBg(uv0.curID_)
		elseif uv0.curPage_ == "chatBubble" then
			PlayerAction.ChangeChatBubble(uv0.curID_, function ()
				ShowTips("DORM_CANTEEN_HERO_CHANGE_SUCCESS")

				uv0.chatBubbleID_ = PlayerData:GetCurChatBubbleID()

				uv0:SetCurID(uv0.curID_)
				uv0.scrollHelper_:Refresh()
			end)
		end
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)

	slot4 = slot0.previewBtn_
	slot5 = nil

	slot0:AddBtnListener(slot4, slot5, function ()
		if uv0.curPage_ == "cardBg" then
			JumpTools.OpenPageByJump("/newUserInfoPreviewPop", {
				previewID = uv0.curID_
			})
		end
	end)

	for slot4, slot5 in ipairs(slot0.page_) do
		slot0:AddBtnListener(slot0["btn_" .. slot4], nil, function ()
			uv0.index_ = uv1
			uv0.curPage_ = uv0.page_[uv1]

			if uv0.curPage_ == "portrait" then
				uv0:SetCurID(uv0.portraitID_)
			elseif uv0.curPage_ == "frame" then
				uv0:SetCurID(uv0.frameID_)
			elseif uv0.curPage_ == "cardBg" then
				uv0:SetCurID(uv0.cardBgID_)
			elseif uv0.curPage_ == "chatBubble" then
				uv0:SetCurID(uv0.chatBubbleID_)
			end

			uv0:ChangeBtnController(uv1)
			OperationRecorder.RecordButtonTouch("userinfo_headportrait_" .. uv0.index_)
			uv0.scrollHelper_:StartScroll(#uv0.curList_)
		end)
	end
end

function slot0.ChangeBtnController(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.page_) do
		slot0["btnCon_" .. slot5]:SetSelectedIndex(slot5 == slot1 and 1 or 0)
	end
end

function slot0.OnEnter(slot0)
	slot0.curList_ = {}

	if slot0.params_.isEnter then
		slot0.index_ = 1
		slot0.params_.isEnter = nil
	end

	slot0:ChangeBtnController(1)
	slot0:RefreshUI()

	slot0.index_ = slot0.index_ or 1
	slot0.curPage_ = slot0.page_[slot0.index_]

	if slot0.curPage_ == "portrait" then
		slot0:SetCurID(slot0.portraitID_)
	elseif slot0.curPage_ == "frame" then
		slot0:SetCurID(slot0.frameID_)
	elseif slot0.curPage_ == "cardBg" then
		slot0:SetCurID(slot0.cardBgID_)
	elseif slot0.curPage_ == "chatBubble" then
		slot0:SetCurID(slot0.chatBubbleID_)
	end

	slot0.scrollHelper_:StartScroll(#slot0.curList_)
	slot0:BindRedPoint()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshData()
	slot0:RefreshCurID()
end

function slot0.RefreshData(slot0)
	slot0:GetPortraitList()
	slot0:GetFrameList()
	slot0:GetCardBgList()
	slot0:GetChatBubbleList()
end

function slot0.RefreshCurID(slot0)
	slot0.portraitID_ = PlayerData:GetCurPortrait()
	slot0.frameID_ = PlayerData:GetCurFrame()
	slot0.cardBgID_ = PlayerData:GetCurCardBg()
	slot0.chatBubbleID_ = PlayerData:GetCurChatBubbleID()
end

function slot0.SetCurID(slot0, slot1)
	slot0.curID_ = slot1

	slot0.pageCon_:SetSelectedState(slot0.curPage_)

	slot2 = slot0:IsUsed(slot0.curID_)

	if slot0.curPage_ ~= "chatBubble" then
		slot0.icon_.sprite = ItemTools.getItemSprite(slot0.curPage_ == "portrait" and slot0.curID_ or slot0.portraitID_)

		slot0.icon_:SetNativeSize()

		slot0.frameIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. (slot0.curPage_ == "frame" and slot0.curID_ or slot0.frameID_))

		slot0.frameIcon_:SetNativeSize()

		slot0.cardBgIcon_.sprite = ItemTools.getItemSprite(slot0.curPage_ == "cardBg" and slot0.curID_ or slot0.cardBgID_)

		slot0.cardBgIcon_:SetNativeSize()
	else
		slot3 = slot0.curPage_ == "chatBubble" and slot0.curID_ or slot0.chatBubbleID_
		slot0.chatBubbleImg_.sprite = ItemTools.getItemSprite(slot3)
		slot4 = ChatBubbleCfg[slot3].color1
		slot0.chatBubbleTxt_.color = Color(slot4[1], slot4[2], slot4[3])
	end

	slot0.itemCfg_ = ItemCfg[slot0.curID_]
	slot0.nameTxt_.text = ItemTools.getItemName(slot0.itemCfg_.id)
	slot0.descTxt_.text = ItemTools.getItemDesc(slot0.itemCfg_.id)
	slot0.wayTxt_.text = GetI18NText(slot0.itemCfg_.desc_source) or ""
	slot3 = nil

	if slot0.curPage_ == "portrait" then
		slot0.curList_ = slot0.portraitList_
		slot3 = PlayerData:GetPortrait(slot0.curID_)
	elseif slot0.curPage_ == "frame" then
		slot0.curList_ = slot0.frameList_
		slot3 = PlayerData:GetFrame(slot0.curID_)

		PlayerData:DealOverdueFrame()
	elseif slot0.curPage_ == "cardBg" then
		slot0.curList_ = slot0.cardBgList_
		slot3 = PlayerData:GetCardBg(slot0.curID_)

		PlayerData:DealOverdueCardBgList()
		PlayerData:ClearCardBgRed()
	elseif slot0.curPage_ == "chatBubble" then
		slot0.curList_ = slot0.chatBubbleList_
		slot3 = {
			unlock = table.keyof(PlayerData:GetUnlockChatBubbleIDList(), slot0.curID_) and 1 or 0
		}
	end

	if slot3.lasted_time and slot3.lasted_time > 0 then
		slot0.timeCntText_.text = manager.time:STimeDescS(slot3.lasted_time, "!%Y/%m/%d %H:%M")

		SetActive(slot0.timeCntGo_, true)
	else
		SetActive(slot0.timeCntGo_, false)
	end

	slot0.lockCon_:SetSelectedState(slot3.unlock == 0 and "lock" or "default")

	if slot2 then
		slot0.useBtn_.interactable = false

		slot0.lockCon_:SetSelectedState("value_2")
	else
		slot0.useBtn_.interactable = true
		slot0.btnTxt_.text = GetTips("TIP_USE")
	end
end

function slot0.GetPortraitList(slot0)
	slot0.portraitList_ = {}

	for slot6, slot7 in ipairs(PlayerData:GetPortraitList()) do
		if not HideInfoData:GetHeadIconHideList()[slot7] then
			table.insert(slot0.portraitList_, PlayerData:GetPortrait(slot7))
		end
	end

	table.sort(slot0.portraitList_, function (slot0, slot1)
		if slot0.unlock ~= slot1.unlock then
			return slot1.unlock < slot0.unlock
		end

		return slot0.id < slot1.id
	end)
end

function slot0.GetFrameList(slot0)
	slot0.frameList_ = {}

	for slot5, slot6 in ipairs(PlayerData:GetFrameList()) do
		if ItemCfg[slot6].sub_type ~= ItemConst.ITEM_SUB_TYPE.FRAME_LINK then
			table.insert(slot0.frameList_, PlayerData:GetFrame(slot6))
		elseif slot8.unlock == 1 or slot8.lasted_time > 0 then
			table.insert(slot0.frameList_, slot8)
		end
	end

	table.sort(slot0.frameList_, function (slot0, slot1)
		if slot0.unlock ~= slot1.unlock then
			return slot1.unlock < slot0.unlock
		end

		return slot0.id < slot1.id
	end)
end

function slot0.GetCardBgList(slot0)
	slot0.cardBgList_ = {}

	for slot5, slot6 in ipairs(PlayerData:GetCardBgList()) do
		if ItemCfg[slot6].sub_type ~= ItemConst.ITEM_SUB_TYPE.CARD_BG_LIMIT then
			table.insert(slot0.cardBgList_, PlayerData:GetCardBg(slot6))
		elseif slot8.unlock == 1 or slot8.lasted_time > 0 then
			table.insert(slot0.cardBgList_, slot8)
		end
	end

	table.sort(slot0.cardBgList_, function (slot0, slot1)
		if slot0.unlock ~= slot1.unlock then
			return slot1.unlock < slot0.unlock
		end

		return slot0.id < slot1.id
	end)
end

function slot0.GetChatBubbleList(slot0)
	slot1 = clone(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.CHAT_BUBBLE])
	slot2 = PlayerData:GetUnlockChatBubbleIDList()

	function slot6(slot0, slot1)
		if table.keyof(uv0, slot0) and table.keyof(uv0, slot1) then
			return slot0 < slot1
		elseif slot2 then
			return true
		elseif slot3 then
			return false
		else
			return slot0 < slot1
		end
	end

	table.sort(slot1, slot6)

	slot0.chatBubbleList_ = {}

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot0.chatBubbleList_, {
			id = slot7
		})
	end
end

function slot0.IsUsed(slot0, slot1)
	return slot1 == slot0.portraitID_ or slot1 == slot0.frameID_ or slot1 == slot0.cardBgID_ or slot1 == slot0.chatBubbleID_
end

function slot0.OnChangePortrait(slot0)
	slot0:RefreshCurID()
	slot0:SetCurID(slot0.curID_)
	slot0.scrollHelper_:Refresh()
end

function slot0.OnChangeFrame(slot0)
	slot0:RefreshCurID()
	slot0:SetCurID(slot0.curID_)
	slot0.scrollHelper_:Refresh()
end

function slot0.OnChangeCardBg(slot0)
	slot0:RefreshCurID()
	slot0:SetCurID(slot0.curID_)
	slot0.scrollHelper_:Refresh()
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.btn_3.transform, RedPointConst.CARD_BG)
	manager.redPoint:bindUIandKey(slot0.btn_4.transform, RedPointConst.CHAT_BUBBLE)
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.btn_3.transform, RedPointConst.CARD_BG)
	manager.redPoint:unbindUIandKey(slot0.btn_4.transform, RedPointConst.CHAT_BUBBLE)
end

function slot0.OnExit(slot0)
	slot0:UnbindRedPoint()

	slot3 = slot0.scrollHelper_
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot3 = slot0.scrollHelper_
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		slot5:Dispose()
	end

	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
