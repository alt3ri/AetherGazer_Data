slot0 = class("SailLotteryGameView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdSpinachIncidentCardSelectionUI"
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

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.dialogTextList_ = {
		[SailGameConst.EVENT_LOTEERY_STATUS.PLAY] = GetTips("ACTIVITY_SKADI_SEA_GAMBLE_EVENT_START_TIP"),
		[SailGameConst.EVENT_LOTEERY_STATUS.WAIT] = GetTips("ACTIVITY_SKADI_SEA_GAMBLE_EVENT_WAIT_TIP"),
		[SailGameConst.EVENT_LOTEERY_STATUS.WIN] = GetTips("ACTIVITY_SKADI_SEA_GAMBLE_EVENT_SUCCESS_HALFWAY_TIP"),
		[SailGameConst.EVENT_LOTEERY_STATUS.LOSE] = GetTips("ACTIVITY_SKADI_SEA_GAMBLE_EVENT_FAIL_TIP"),
		[SailGameConst.EVENT_LOTEERY_STATUS.END] = GetTips("ACTIVITY_SKADI_SEA_GAMBLE_EVENT_SUCCESS_FINAL_TIP")
	}
	slot0.maxRound_ = #GameSetting.activity_skadi_sea_gamble_event_win_probability.value
	slot0.cardNum_ = slot0.cardContentTrans_.childCount
	slot0.cardIndexList_ = {}
	slot0.cardList_ = {}

	for slot5 = 1, slot0.cardNum_ do
		slot0.cardIndexList_[slot5] = slot5
		slot0.cardList_[slot5] = SailLotteryItem.New(slot0.cardContentTrans_:GetChild(slot5 - 1).gameObject)

		slot0.cardList_[slot5]:SetSelecteCallback(handler(slot0, slot0.OnSelectCard))
	end

	slot0.leftCardPos_ = slot0.cardContentTrans_:InverseTransformPoint(slot0.leftCardMarkTrans_.position)
	slot0.rightCardPos_ = slot0.cardContentTrans_:InverseTransformPoint(slot0.rightCardMarkTrans_.position)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.overBtn_, nil, function ()
		uv0:GameOver()
	end)
	slot0:AddBtnListener(slot0.continueBtn_, nil, function ()
		uv0:InitCard()
		uv0:UpdateStatus()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.curStageIndex_ = SailGameData:GetCurGameData(slot0.activityID_).curStageIndex

	slot0:GameInit()
	slot0:GameStart()
	slot0:PlayEnterAnim()
	slot0:RegistEventListener(ACTIVITY_UPDATE, handler(slot0, slot0.OnActivityUpdate))
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.cardList_) do
		slot5:Dispose()
	end

	slot0.cardList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.GameStart(slot0)
	slot0:RefreshUI()
end

function slot0.GameOver(slot0)
	if not slot0.gameWin_ then
		SailGameAction.SetEventEndMark(slot0.activityID_, SailGameConst.LOTTERY_OVER_TIPS_INDEX.LOSE)
		SailGameTools.GoToGameView(slot0.activityID_)
	elseif slot0.maxRound_ <= slot0.curRound_ then
		SailGameAction.SetEventEndMark(slot0.activityID_, SailGameConst.LOTTERY_OVER_TIPS_INDEX.SUCCESS_FULLEST)
		SailGameTools.GoToGameView(slot0.activityID_)
	else
		SailGameAction.EventOperate(slot0.activityID_, slot0.curStageIndex_, SailGameConst.EVENT_COMMON_OPERATE.OVER)
	end
end

function slot0.GameInit(slot0)
	slot0:InitCard()

	slot0.rewardNum_ = 0
	slot0.curRound_ = 1
	slot0.curStatus_ = SailGameConst.EVENT_LOTEERY_STATUS.PLAY

	SetActive(slot0.maskGo_, false)
end

function slot0.UpdateStatus(slot0)
	if slot0.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.PLAY then
		slot0.curStatus_ = SailGameConst.EVENT_LOTEERY_STATUS.WAIT
	elseif slot0.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.WAIT then
		slot0:GetCurRoundInfo()

		slot1 = slot0.curRoundInfo_.result == SailGameConst.LOTEERY_GAME_RESULT.WIN
		slot0.gameWin_ = slot1

		if slot1 == true then
			if slot0.curRound_ < slot0.maxRound_ then
				slot0.curStatus_ = SailGameConst.EVENT_LOTEERY_STATUS.WIN
			else
				slot0.curStatus_ = SailGameConst.EVENT_LOTEERY_STATUS.END
			end
		else
			slot0.curStatus_ = SailGameConst.EVENT_LOTEERY_STATUS.LOSE
		end
	elseif slot0.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.WIN then
		slot0.curStatus_ = SailGameConst.EVENT_LOTEERY_STATUS.PLAY
		slot0.curRound_ = slot0.curRound_ + 1
	end

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.statusController_:SetSelectedIndex(slot0.curStatus_)

	if slot0.dialogTextList_[slot0.curStatus_] ~= nil then
		if slot0.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.WIN then
			slot0.dialogText_.text = string.format(slot0.dialogTextList_[slot0.curStatus_], GameSetting.activity_skadi_sea_gamble_event_win_reward.value[slot0.curRound_ + 1][2])
		elseif slot0.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.PLAY then
			slot0.dialogText_.text = string.format(slot0.dialogTextList_[slot0.curStatus_], GameSetting.activity_skadi_sea_gamble_event_win_reward.value[slot0.curRound_][2])
		else
			slot0.dialogText_.text = slot0.dialogTextList_[slot0.curStatus_]
		end
	end

	if slot0.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.PLAY then
		SetActive(slot0.maskGo_, false)
	end
end

function slot0.OnSelectCard(slot0, slot1)
	if slot0.curStatus_ ~= SailGameConst.EVENT_LOTEERY_STATUS.PLAY then
		return
	end

	slot0:UpdateStatus()

	slot0.selfCardIndex_ = slot1

	if not slot0:GetCurRoundInfo() then
		SailGameAction.EventOperate(slot0.activityID_, slot0.curStageIndex_)
	else
		slot0:OnEventOperateSuccess()
	end
end

function slot0.OnEventOperateSuccess(slot0, slot1)
	if slot1 ~= SailGameConst.EVENT_COMMON_OPERATE.OVER then
		SetActive(slot0.maskGo_, true)

		slot2 = GameSetting.activity_skadi_sea_gamble_event_point.value[1]
		slot4 = 0
		slot5 = 0

		slot0:GetCurRoundInfo()

		if slot0.curRoundInfo_.result == SailGameConst.LOTEERY_GAME_RESULT.WIN == true then
			slot5 = math.random(slot2, math.random(slot2 + 1, GameSetting.activity_skadi_sea_gamble_event_point.value[2]) - 1)
		else
			slot4 = math.random(slot2, math.random(slot2 + 1, slot3) - 1)
		end

		swap(slot0.cardIndexList_, slot0.selfCardIndex_, slot0.cardNum_)
		swap(slot0.cardIndexList_, slot0.selfCardIndex_, slot0.cardNum_)
		slot0:RefreshResult(slot6, slot0.selfCardIndex_, slot4, slot0.cardIndexList_[math.random(1, slot0.cardNum_ - 1)], slot5)
		slot0:RefreshReward(slot6)
	else
		SailGameAction.SetEventEndMark(slot0.activityID_, SailGameConst.LOTTERY_OVER_TIPS_INDEX.SUCCESS)
		SailGameTools.GoToGameView(slot0.activityID_)
	end
end

function slot0.RefreshResult(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = slot0.cardList_[slot2]

	slot6:SetPoint(slot3, true)
	slot0.cardList_[slot4]:SetPoint(slot5, false)
	slot6:SetResult(slot1)

	slot8 = slot4 < slot2

	slot6:SetTargetPos(slot8 and slot0.rightCardPos_ or slot0.leftCardPos_)
	slot7:SetTargetPos(not slot8 and slot0.rightCardPos_ or slot0.leftCardPos_)

	for slot12, slot13 in ipairs(slot0.cardList_) do
		if slot12 ~= slot2 and slot12 ~= slot4 then
			slot13:PlayExitAnim()
		end
	end
end

function slot0.OnWaitStatusEnd(slot0)
	SetActive(slot0.maskGo_, false)

	if slot0.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.WAIT then
		slot0:UpdateStatus()
	end
end

function slot0.RefreshReward(slot0, slot1)
	if slot1 == true then
		slot0.rewardNum_ = slot0.rewardNum_ + GameSetting.activity_skadi_sea_gamble_event_win_reward.value[slot0.curRound_][2]
	else
		slot0.rewardNum_ = 0
	end

	slot0.rewardNumText_.text = slot0.rewardNum_
	slot0.rewardIcon_.sprite = ItemTools.getItemSprite(GameSetting.activity_skadi_sea_gamble_event_win_reward.value[1][1])
end

function slot0.GetCurRoundInfo(slot0)
	slot1 = false

	if SailGameData:GetCurGameData(slot0.activityID_).eventList[slot0.curStageIndex_].lotteryInfo then
		slot0.curRoundInfo_ = slot2.eventList[slot0.curStageIndex_].lotteryInfo[slot0.curRound_]
		slot1 = slot0.curRoundInfo_ ~= nil and true or false
	end

	return slot1
end

function slot0.InitCard(slot0)
	for slot4 = 1, slot0.cardNum_ do
		slot0.cardList_[slot4]:SetData(slot4, slot0.activityID_)
	end
end

function slot0.PlayEnterAnim(slot0)
	slot0.animator_.enabled = true

	slot0.animator_:Play("XH3rdSpinachIncidentCardSelectionUI", -1, 0)

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0.timer_ = Timer.New(function ()
		if uv0.animator_:GetCurrentAnimatorStateInfo(0):IsName(uv1) and slot0.normalizedTime >= 1 then
			if uv0.timer_ ~= nil then
				uv0.timer_:Stop()

				uv0.timer_ = nil
			end

			uv0.animator_.enabled = false
		end
	end, 0.033, -1)

	slot0.timer_:Start()
end

function slot0.OnActivityUpdate(slot0, slot1)
	if slot1 == slot0.activityID_ and not ActivityData:GetActivityIsOpen(slot1) then
		ShowTips("TIME_OVER")
		SailGameTools.ShutDown()
		JumpTools.OpenPageByJump("/sailMain", {
			activityID = slot0.activityID_
		})
	end
end

return slot0
