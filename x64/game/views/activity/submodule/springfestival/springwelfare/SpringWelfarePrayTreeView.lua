slot0 = class("SpringWelfarePrayTreeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
	slot0:InitBranch()

	slot0.stageController_ = ControllerUtil.GetController(slot0.transform_, "stage")

	slot0.stageController_:SetSelectedState("welfare")

	slot0.prayController_ = ControllerUtil.GetController(slot0.prayBtn_.transform, "state")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.mailBtn_, nil, function ()
		JumpTools.OpenPageByJump("springWelfareLetterBox", {})
	end)
	slot0:AddBtnListener(slot0.taskBtn_, nil, function ()
		JumpTools.OpenPageByJump("springWelfareTask", {})
	end)
	slot0:AddBtnListener(slot0.prayBtn_, nil, function ()
		uv0:TryStartPray()
	end)
end

function slot0.InitBranch(slot0)
	slot0.branchList_ = {}

	for slot5 = 1, slot0:GetDays() do
		slot7 = SpringWelfarePrayBubbleView.New(slot0[string.format("bubbleGo_%d", slot5)])

		slot7:SetData(slot5)
		slot7:SetClickHandler(function (slot0, slot1, slot2, slot3)
			uv0:OnClickBubble(uv1, slot0, slot1, slot2, slot3)
		end)

		slot0.branchList_[slot5] = slot7
	end
end

function slot0.UpdateBar(slot0)
	slot1, slot2 = SpringWelfareData:GetPoolSignCost()
	slot3, slot4 = SpringWelfareData:GetPoolCost()

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		slot1,
		slot3
	})
	manager.windowBar:SetBarCanAdd(slot1, true)
	manager.windowBar:SetBarCanAdd(slot3, true)
	manager.windowBar:SetGameHelpKey("SPRING_BLESSING_DES")
end

function slot0.OnEnter(slot0)
	slot0:UpdateBar()

	for slot4, slot5 in ipairs(slot0.branchList_) do
		slot5:OnEnter()
	end

	slot1 = slot0:GetActivityID()
	slot2 = ActivityTools.GetRedPointKey(slot1) .. slot1

	manager.redPoint:bindUIandKey(slot0.mailBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_9_SPRING_WELFARE_LETTER, slot2))
	manager.redPoint:bindUIandKey(slot0.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_9_SPRING_WELFARE_REWARD, slot2))
	slot0:RefreshUI()
end

function slot0.OnTop(slot0)
	slot0:NewDayEffect()
	slot0:RefreshPrayStateUI()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in ipairs(slot0.branchList_) do
		slot5:OnExit()
	end

	slot1 = slot0:GetActivityID()
	slot2 = ActivityTools.GetRedPointKey(slot1) .. slot1

	manager.redPoint:unbindUIandKey(slot0.mailBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_9_SPRING_WELFARE_LETTER, slot2))
	manager.redPoint:unbindUIandKey(slot0.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_9_SPRING_WELFARE_REWARD, slot2))
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.branchList_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	for slot4, slot5 in ipairs(slot0.branchList_) do
		slot5:UpdateItemIdList()
		slot5:RefreshItemUiList()
	end

	slot0:RefreshPrayStateUI()

	slot2 = ActivityData:GetActivityData(slot0:GetActivityID())
	slot0.tipsText_.text = string.format(GetTips("SPRING_BLESSING_SCREEN_TIPS"), manager.time:STimeDescS(slot2.startTime, "!%Y.%m.%d %H:%M"), manager.time:STimeDescS(slot2.stopTime, "!%Y.%m.%d %H:%M"))

	SpringWelfareAction:UpdateRedPoint(slot0:GetActivityID())
end

function slot0.RefreshPrayStateUI(slot0)
	slot4 = 0
	slot5 = 0

	if SpringWelfareData:GetDayState(SpringWelfareData:GetCurPrayDay()) == SPRING_WELFARE_DAY_STATE_TYPE.ACQUIRED then
		slot0.prayController_:SetSelectedState(slot1 == slot0:GetDays() and "finish" or "prayed")
		SetActive(slot0.prayCostGo_, false)

		return
	elseif slot3 == SPRING_WELFARE_DAY_STATE_TYPE.NEED_SIGN then
		slot4, slot5 = SpringWelfareData:GetPoolSignCost()

		slot0.prayController_:SetSelectedState("sign")
	elseif slot3 == SPRING_WELFARE_DAY_STATE_TYPE.CAN_PRAY then
		slot6, slot7 = SpringWelfareData:GetPoolCost()

		slot0.prayController_:SetSelectedState("pray")

		if ItemTools.getItemNum(slot6) < slot7 and slot0:CanSign(SpringWelfareData:GetCurSignDay()) then
			slot1 = slot6
			slot4, slot5 = SpringWelfareData:GetPoolSignCost()

			slot0.prayController_:SetSelectedState("sign")
		end
	end

	SetActive(slot0.prayCostGo_, true)

	slot0.prayIcon_.sprite = ItemTools.getItemSprite(slot4)
	slot0.prayInfoText_.text = slot5
end

function slot0.OnNewDay(slot0)
	slot0:RefreshUI()

	for slot4, slot5 in ipairs(slot0.branchList_) do
		slot5:RefreshUI()
	end

	if gameContext:GetLastOpenPage() == "springWelfarePrayTree" then
		slot0:NewDayEffect()
	end
end

function slot0.OnActivitySpringWelfareInit(slot0)
	slot0:OnNewDay()
end

function slot0.OnTaskListChange(slot0)
	SpringWelfareAction:UpdateRedPoint(slot0:GetActivityID())
end

function slot0.OnClickBubble(slot0, slot1, slot2, slot3, slot4, slot5)
	JumpTools.OpenPageByJump("springWelfarePrayBranch", {
		day = slot3
	})
end

function slot0.TryStartPray(slot0)
	if SpringWelfareData:GetDayState(SpringWelfareData:GetCurPrayDay()) == SPRING_WELFARE_DAY_STATE_TYPE.ACQUIRED then
		ShowTips("SPRING_WELFARE_ALREADY_PRAY")
	elseif slot2 == SPRING_WELFARE_DAY_STATE_TYPE.NOT_ACQUIRE then
		return
	end

	slot3 = false
	slot4 = 0
	slot5 = 0

	if slot2 == SPRING_WELFARE_DAY_STATE_TYPE.NEED_SIGN then
		slot4, slot5 = SpringWelfareData:GetPoolSignCost()
		slot3 = true
	elseif slot2 == SPRING_WELFARE_DAY_STATE_TYPE.CAN_PRAY then
		slot4, slot5 = SpringWelfareData:GetPoolCost()
	end

	if ItemTools.getItemNum(slot4) < slot5 then
		if slot0:CanSign(SpringWelfareData:GetCurSignDay()) then
			slot1 = slot6
			slot3 = false
		elseif slot4 == 1 then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")

			return
		else
			ShowTips("SPRING_WELFARE_PRAY_COST_LACK")

			return
		end
	end

	if not slot3 or _G.SkipTip.SkipSpringWelfareResignTip then
		SpringWelfareAction:StartPray(slot1, handler(slot0, slot0.OnFinishPray))
	else
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = {
				GetTips("WHETHER_TO_CONSUME"),
				{
					slot4,
					slot5
				},
				string.format(GetTips("RESIGN"), slot5)
			},
			OkCallback = function ()
				SpringWelfareAction:StartPray(uv0, handler(uv1, uv1.OnFinishPray))
			end,
			ToggleCallback = function (slot0)
				_G.SkipTip.SkipSpringWelfareResignTip = slot0
			end,
			toggleText = GetTips("LOGIN_MUTE_TIP")
		})
	end
end

function slot0.OnFinishPray(slot0, slot1)
	slot0:PlayEffect(function ()
		uv0:RefreshUI()

		for slot3, slot4 in ipairs(uv0.branchList_) do
			slot4:RefreshUI()
		end
	end)
end

function slot0.PlayEffect(slot0, slot1)
	if slot0.prayAni_ then
		slot0.isAniPlaying_ = true

		manager.windowBar:HideBar()
		SetActive(slot0.prayAniGo_, true)
		slot0.prayAni_:Play("IndiaWishingTreeUI_sign", -1, 0)
		slot0.prayAni_:Update(0)
		AnimatorTools.PlayAnimationWithCallback(slot0.prayAni_, "IndiaWishingTreeUI_sign", function ()
			uv0.isAniPlaying_ = false

			SetActive(uv0.prayAniGo_, false)
			uv0:UpdateBar()
			uv1()
		end)
	else
		slot1()
	end
end

function slot0.NewDayEffect(slot0)
	if not SpringWelfareData:GetNextNewSystemLetterId() then
		return
	end

	if SpringWelfareData:GetLetterData(slot1) and not slot2.gotReward then
		JumpTools.OpenPageByJump("springWelfareSystemLetter", {
			gotReward = false,
			firstView = true,
			letterServerId = slot1
		})
	end
end

function slot0.GetDays(slot0)
	return SpringPreheatData:GetMaxProgress()
end

function slot0.GetActivityID(slot0)
	return SpringWelfareData:GetActivityId()
end

function slot0.CanSign(slot0, slot1)
	if (slot1 or SpringWelfareData:GetCurSignDay()) < 0 then
		return false
	end

	slot2, slot3 = SpringWelfareData:GetPoolSignCost()

	if ItemTools.getItemNum(slot2) < slot3 then
		return false
	end

	return true
end

return slot0
