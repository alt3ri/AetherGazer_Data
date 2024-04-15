slot0 = class("SpringWelfareLetterBoxItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.friendController_ = ControllerUtil.GetController(slot0.transform_, "newFriend")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.viewBtn_, nil, function ()
		uv0:OnClickViewButton()
	end)
	slot0:AddBtnListener(slot0.friendBtn_, nil, function ()
		uv0:OnClickFriendButton()
	end)
end

function slot0.SetLetterServerId(slot0, slot1)
	slot0.serverId_ = slot1
end

function slot0.RefreshUI(slot0)
	if SpringWelfareData:GetLetterData(slot0.serverId_).isSystem then
		slot0:RefreshSystemUI(slot1)
	elseif slot1.isPlayer then
		slot0:RefreshPlayerUI(slot1)
	end
end

function slot0.RefreshSystemUI(slot0, slot1)
	if HeroData:GetHeroData(slot1.heroId) == nil then
		print(string.format("英雄id: %d 不存在!", slot2))
	end

	slot0.heroImg_.sprite = HeroTools.GetHeadSprite(slot2)
	slot0.nameText_.text = HeroTools.GetHeroFullName(slot2)

	SetActive(slot0.friendGo_, false)
end

function slot0.RefreshPlayerUI(slot0, slot1)
	slot2 = slot1.playerId
	slot3 = SpringWelfareData:GetPlayerInfo(slot2)
	slot0.userId_ = slot2
	slot0.nameText_.text = slot3.nick
	slot0.heroImg_.sprite = ItemTools.getItemSprite(slot3.icon)

	SetActive(slot0.friendGo_, true)
	slot0.friendController_:SetSelectedState(SpringWelfareData:IsFriendOrInRequest(slot2) and "send" or "add")
end

function slot0.OnClickViewButton(slot0)
	if SpringWelfareData:GetLetterData(slot0.serverId_).isSystem then
		JumpTools.OpenPageByJump("springWelfareSystemLetter", {
			firstView = false,
			letterServerId = slot2.serverId
		})
		SDKTools.SendMessageToSDK("activity_letter", {
			opt = 3,
			publish_player_uid = 0,
			mail_id = slot2.letterId,
			activity_id = SpringWelfareData:GetActivityId()
		})
	elseif slot2.isPlayer then
		slot3 = SpringWelfareData:GetPlayerInfo(slot2.playerId)

		JumpTools.OpenPageByJump("springWelfarePlayerLetter", {
			firstView = false,
			letterServerId = slot2.serverId
		})
		SDKTools.SendMessageToSDK("activity_letter", {
			opt = 3,
			mail_id = slot2.timestamp,
			activity_id = slot1,
			publish_player_uid = slot2.playerId
		})
	end
end

function slot0.OnFriendsListChange(slot0)
	if not slot0.userId_ then
		return
	end

	slot0.friendController_:SetSelectedState(SpringWelfareData:IsFriendOrInRequest(slot0.userId_) and "send" or "add")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.OnClickFriendButton(slot0)
	if FriendsData:IsCanBeFriend(SpringWelfareData:GetLetterData(slot0.serverId_).playerId) then
		FriendsAction:TryToRequestToFriend(slot2, FriendConst.ADD_FRIEND_SOURCE.ACTIVITY_COMMON, SpringWelfareData:GetActivityId())
	end
end

return slot0
