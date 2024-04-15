slot0 = class("SpringPreheatEditLetterView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreePopUI1"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
	slot0.stickerNum_ = 2
	slot0.stickerBtn_ = {}
	slot0.stickerImg_ = {}
	slot0.stickerFrameImg_ = {}
	slot0.stickerInfo_ = {}
	slot0.stickerController_ = {}
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	for slot4 = 1, slot0.stickerNum_ do
		slot0.stickerInfo_[slot4] = slot0:CreateEmptyStickerInfo()
		slot5 = slot0[string.format("stickerBtn_%d", slot4)]
		slot0.stickerBtn_[slot4] = slot5
		slot0.stickerController_[slot4] = ControllerUtil.GetController(slot5.transform, "state")
		slot0.stickerImg_[slot4] = slot0[string.format("stickerImg_%d", slot4)]
		slot0.stickerFrameImg_[slot4] = slot0[string.format("stickerFrameImg_%d", slot4)]
	end

	slot0:AddListeners()

	slot0.letterList_ = LuaList.New(handler(slot0, slot0.IndexTextItem), slot0.letterUiListGo_, SpringWelfarePlayerLetterTextItem)
	slot0.playerInfo_ = slot0:GetLocalPlayerInfo()
	slot0.shareController_ = ControllerUtil.GetController(slot0.transform_, "share")
	slot0.friendController_ = ControllerUtil.GetController(slot0.playerTitleRect_, "newFriend")
	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.arrowController_ = ControllerUtil.GetController(slot0.transform_, "arrow")
end

function slot0.CreateEmptyStickerInfo(slot0)
	return {
		stickerID = 0,
		size = 1
	}
end

function slot0.GetLocalPlayerInfo(slot0)
	slot1 = PlayerData:GetPlayerInfo()

	return {
		user_id = slot1.userID,
		nick = slot1.nick,
		icon = slot1.portrait,
		icon_frame = slot1.icon_frame
	}
end

function slot0.OnEnter(slot0)
	slot0.letterServerId_ = slot0.params_.letterServerId
	slot1 = SpringWelfareData:GetLetterData(slot0.letterServerId_)
	slot5 = slot1.playerId
	slot0.playerInfo_ = SpringWelfareData:GetPlayerInfo(slot5)

	for slot5, slot6 in ipairs(slot1.stickerList) do
		slot0.stickerInfo_[slot5].stickerID = slot6.id
	end

	slot0.firstView_ = slot0.params_.firstView

	slot0:RefreshUI()
	slot0:RefreshArrowUI()
end

function slot0.OnTop(slot0)
	slot0:OnEnter()
end

function slot0.OnExit(slot0)
	AnimatorTools.Stop()
end

function slot0.Dispose(slot0)
	slot0.letterList_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.headBtn_, nil, function ()
		ForeignInfoAction:TryToCheckForeignDetailInfo(uv0.playerInfo_.uid)
	end)
	slot0:AddBtnListener(slot0.addFriendBtn_, nil, function ()
		uv0:OnClickAddFriendBtn()
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:OnClickClose()
	end)
	slot0:AddBtnListener(slot0.leftArrowBtn_, nil, function ()
		uv0:JumpNextLetter(-1)
	end)
	slot0:AddBtnListener(slot0.rightArrowBtn_, nil, function ()
		uv0:JumpNextLetter(1)
	end)
	slot0:AddBtnListener(slot0.shareBtn_, nil, function ()
		manager.share:Share(function ()
			uv0.shareController_:SetSelectedState("true")
		end, function ()
			uv0.shareController_:SetSelectedState("false")
		end, function ()
		end)
	end)
end

function slot0.IndexTextItem(slot0, slot1, slot2)
	slot2:SetText(SpringWelfareData:GetLetterParagText(slot0.letterServerId_, slot1))
end

function slot0.RefreshUI(slot0)
	slot4 = "receiver"

	slot0.stateController_:SetSelectedState(slot4)
	slot0:RefreshPlayerUI()

	for slot4 = 1, slot0.stickerNum_ do
		slot0:RefreshStickerUI(slot4)
	end

	slot0.letterList_:StartScroll(#SpringPreheatData:GetPlayerLetter().option_button_list)
	slot0.shareController_:SetSelectedState(slot0.firstView_ and "true" or "false")
end

function slot0.RefreshPlayerUI(slot0)
	slot1 = slot0.playerInfo_
	slot0.playerNameText_.text = slot1.nick
	slot0.playerIcon_.sprite = ItemTools.getItemSprite(slot1.icon)

	slot0.playerIcon_:SetNativeSize()

	slot0.letterDateText_.text = manager.time:STimeDescS(SpringWelfareData:GetLetterData(slot0.letterServerId_).timestamp, "!%Y/%m/%d")

	slot0.friendController_:SetSelectedState(SpringWelfareData:IsFriendOrInRequest(slot0.playerInfo_.uid) and "send" or "add")
end

function slot0.RefreshStickerUI(slot0, slot1)
	slot0.stickerController_[slot1]:SetSelectedState(slot0.stickerInfo_[slot1].stickerID > 0 and "active" or "add")

	slot3 = slot0.stickerImg_[slot1]

	if slot2.stickerID > 0 and slot3 then
		slot3.sprite = ItemTools.getItemSprite(slot2.stickerID, {
			size = slot2.size
		})
	end

	slot0.stickerFrameImg_[1].enabled = false
	slot0.stickerFrameImg_[2].enabled = false

	SetActive(slot0.stickerAddGo_1, false)
	SetActive(slot0.stickerAddGo_2, false)
end

function slot0.RefreshArrowUI(slot0)
	if slot0.firstView_ then
		slot0.arrowController_:SetSelectedState("none")

		return
	end

	slot1 = slot0:GetLetterIdList()

	if table.indexof(slot1, slot0.letterServerId_) > 1 and slot2 < #slot1 then
		slot0.arrowController_:SetSelectedState("both")
	elseif slot4 then
		slot0.arrowController_:SetSelectedState("left")
	elseif slot5 then
		slot0.arrowController_:SetSelectedState("right")
	else
		slot0.arrowController_:SetSelectedState("none")
	end
end

function slot0.JumpNextLetter(slot0, slot1)
	slot2 = slot0:GetLetterIdList()

	if table.indexof(slot2, slot0.letterServerId_) + slot1 < 1 or #slot2 < slot5 then
		return
	end

	JumpTools.OpenPageByJump("springWelfarePlayerLetter", {
		letterServerId = slot2[slot5]
	})
end

function slot0.GetLetterIdList(slot0)
	return SpringWelfareData:GetPlayerLetterIdList()
end

function slot0.OnClickClose(slot0)
	slot0:Back()
end

function slot0.OnClickAddFriendBtn(slot0)
	FriendsAction:TryToRequestToFriend(slot0.playerInfo_.uid, FriendConst.ADD_FRIEND_SOURCE.ACTIVITY_COMMON, SpringWelfareData:GetActivityId())
end

function slot0.OnFriendsListChange(slot0)
	slot0.friendController_:SetSelectedState(SpringWelfareData:IsFriendOrInRequest(slot0.playerInfo_.uid) and "send" or "add")
end

function slot0.GetActivityID(slot0)
	return slot0.params_.activityId
end

return slot0
