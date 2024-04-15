slot0 = class("SpringPreheatEditLetterView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreePopUI1"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
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

	slot0.letterList_ = LuaList.New(handler(slot0, slot0.IndexTextItem), slot0.letterUiListGo_, SpringPreheatLetterTextItem)
	slot0.playerInfo_ = slot0:GetLocalPlayerInfo()
	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")

	slot0.stateController_:SetSelectedState("writing")
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
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(handler(slot0, slot0.OnClickBackBtn))
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	AnimatorTools.Stop()
end

function slot0.Dispose(slot0)
	slot0.letterList_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	for slot4 = 1, slot0.stickerNum_ do
		if slot0.stickerBtn_[slot4] then
			slot0:AddBtnListener(slot5, nil, function ()
				uv0:SelectSticker(uv1)
			end)
		end
	end

	slot0:AddBtnListener(slot0.sendBtn_, nil, function ()
		uv0:TrySendBlessingLetter()
	end)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		uv0:ResetLetter()
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
	end)
	slot0:RegistEventListener(NEW_DAY, handler(slot0, slot0.OnNewDay))
end

function slot0.IndexTextItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.selectingImg_ and slot0.selectingImg_.sprite or nil, slot0.selectedImg_ and slot0.selectedImg_.sprite or nil)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.letterDateText_.text = manager.time:STimeDescS(manager.time:GetServerTime(), "!%Y/%m/%d")
	slot0.tipsText_.text = GetTips("SPRING_PREHEAT_TITLE_TIPS")
	slot0.resetText_.text = GetTips("SPRING_PREHEAT_RESET")

	slot0:RefreshPlayerUI()

	for slot7 = 1, slot0.stickerNum_ do
		slot0:RefreshStickerUI(slot7)
	end

	if not slot1 then
		slot0.letterList_:StartScroll(#SpringPreheatData:GetPlayerLetter().option_button_list)
	end
end

function slot0.RefreshPlayerUI(slot0)
	slot1 = slot0.playerInfo_
	slot0.playerNameText_.text = slot1.nick
	slot0.playerIcon_.sprite = ItemTools.getItemSprite(slot1.icon)

	slot0.playerIcon_:SetNativeSize()
end

function slot0.SelectSticker(slot0, slot1)
	if slot0.isAniPlaying_ or slot0.isStaying_ then
		return
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot0.stickerInfo_) do
		if slot7.stickerID ~= 0 then
			table.insert(slot2, slot7.stickerID)
		end
	end

	JumpTools.OpenPageByJump("springPreheatLetterSelect", {
		isStickerMode = true,
		usedList = slot2,
		info = slot0.stickerInfo_[slot1],
		index = slot1,
		onChangeSticker = handler(slot0, slot0.OnChangeSticker)
	})
end

function slot0.OnChangeSticker(slot0, slot1, slot2, slot3)
	for slot7, slot8 in ipairs(slot0.stickerInfo_) do
		if slot8.stickerID == slot2 then
			slot0.stickerInfo_[slot7] = slot0:CreateEmptyStickerInfo()
		end
	end

	slot0.stickerInfo_[slot1] = {
		stickerID = slot2,
		size = slot3
	}

	for slot7 = 1, slot0.stickerNum_ do
		slot0:RefreshStickerUI(slot7)
	end
end

function slot0.RefreshStickerUI(slot0, slot1)
	slot0.stickerController_[slot1]:SetSelectedState(slot0.stickerInfo_[slot1].stickerID > 0 and "active" or "add")

	slot3 = slot0.stickerImg_[slot1]

	if slot2.stickerID > 0 and slot3 then
		slot3.sprite = ItemTools.getItemSprite(slot2.stickerID, {
			size = slot2.size
		})
	end
end

function slot0.TrySendBlessingLetter(slot0)
	slot1 = slot0.playerInfo_.user_id

	for slot6 = 1, slot0.stickerNum_ do
		table.insert({}, slot0.stickerInfo_[slot6].stickerID)
	end

	slot3 = {}
	slot4 = SpringPreheatData:GetPlayerLetter()

	for slot8, slot9 in pairs(slot0.letterList_:GetItemList()) do
		for slot14 = 1, #slot9:GetLetterInfo() do
			if SpringPreheatData:IsEnableOption(slot4.id, slot8, slot14) then
				if slot10[slot14] == 0 then
					ShowTips("SPRING_PREHEAT_WORD_NOT_SELECT")

					return
				end

				table.insert(slot3, table.indexof(SpringPreheatData:GetLetterOptionList(slot4.id, slot8, slot14), slot15))
			end
		end
	end

	SpringPreheatAction:SendBlessingLetter(slot1, slot3, slot2, function ()
		uv0:PlayEffect(handler(uv0, uv0.OnFinishSendBlessingLetter))
	end)
end

function slot0.PlayEffect(slot0, slot1)
	slot0:SwitchSendingMode(true)

	slot0.isStaying_ = true

	Timer.New(function ()
		if uv0.sendLetterAni_ then
			manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_preheat_sent", "")

			uv0.isAniPlaying_ = true

			uv0.sendLetterAni_:Play("PopUI1_send", -1, 0)
			uv0.sendLetterAni_:Update(0)
			AnimatorTools.PlayAnimationWithCallback(uv0.sendLetterAni_, "PopUI1_send", function ()
				uv0.isAniPlaying_ = false

				uv1()
			end)
		else
			uv1()
		end

		uv0.isStaying_ = false
	end, GameSetting.spring_preheat_2_8_watingtime.value[1], 0):Start()
end

function slot0.OnFinishSendBlessingLetter(slot0)
	if slot0.params_.onFinishSendLetter then
		slot0.params_.onFinishSendLetter()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	slot0:Back()

	if GameSetting.spring_preheat_2_8_story.value[2] and not manager.story:IsStoryPlayed(slot1) then
		manager.story:StartStoryById(slot1, function (slot0)
			JumpTools.OpenPageByJump("/springPreheatBlank/springPreheatPray", {})
		end)

		return
	end

	JumpTools.OpenPageByJump("/springPreheatBlank/springPreheatPray", {})
end

function slot0.ResetLetter(slot0)
	for slot4, slot5 in pairs(slot0.letterList_:GetItemList()) do
		slot5:ResetLetterInfo()
	end

	for slot4 = 1, #slot0.stickerInfo_ do
		slot0.stickerInfo_[slot4] = slot0:CreateEmptyStickerInfo()
	end

	slot0:RefreshUI(true)
	slot0.sendLetterAni_:Play("btn", -1, 0)
end

function slot0.SwitchSendingMode(slot0, slot1)
	slot0.stateController_:SetSelectedState(slot1 and "preview" or "writing")

	slot0.stickerFrameImg_[1].enabled = not slot1
	slot0.stickerFrameImg_[2].enabled = not slot1

	SetActive(slot0.stickerAddGo_1, not slot1)
	SetActive(slot0.stickerAddGo_2, not slot1)

	for slot5, slot6 in pairs(slot0.letterList_:GetItemList()) do
		slot6:SetSendingMode(slot1)
		slot6:RefreshUI()
	end

	if slot1 then
		manager.windowBar:HideBar()
	end
end

function slot0.OnNewDay(slot0)
	slot0:SwitchSendingMode(false)
	slot0:ResetLetter()
end

function slot0.OnClickBackBtn(slot0)
	if slot0.isAniPlaying_ or slot0.isStaying_ then
		return
	end

	JumpTools.Back()
	JumpTools.Back()
end

function slot0.GetActivityID(slot0)
	return slot0.params_.activityId
end

return slot0
