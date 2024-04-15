slot0 = class("SpringPreheatPrayTreeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
	slot0:RegistEventListener(NEW_DAY, handler(slot0, slot0.OnNewDay))
	slot0:InitBranch()

	slot0.stageController_ = ControllerUtil.GetController(slot0.transform_, "stage")

	slot0.stageController_:SetSelectedState("preheat")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.previewBtn_, nil, function ()
		JumpTools.OpenPageByJump("springPreheatPrayPreview", {})
	end)
end

function slot0.InitBranch(slot0)
	slot0.branchList_ = {}

	for slot5 = 1, slot0:GetDays() do
		slot7 = SpringPreheatPrayBubbleView.New(slot0[string.format("bubbleGo_%d", slot5)])

		slot7:SetData(slot5)
		slot7:SetClickHandler(function (slot0, slot1, slot2, slot3)
			uv0:OnClickBubble(uv1, slot0, slot1, slot2, slot3)
		end)

		slot0.branchList_[slot5] = slot7
	end
end

function slot0.OnEnter(slot0)
	slot5 = HOME_BAR

	manager.windowBar:SwitchBar({
		BACK_BAR,
		slot5
	})

	function slot4()
		JumpTools.Back()
		JumpTools.Back()
	end

	manager.windowBar:RegistBackCallBack(slot4)

	for slot4, slot5 in ipairs(slot0.branchList_) do
		slot5:OnEnter()
	end

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in ipairs(slot0.branchList_) do
		slot5:OnExit()
	end
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
		slot5:RefreshUI()
	end

	slot2 = ActivityData:GetActivityData(SpringPreheatData:GetWelfareActivityId())
	slot0.tipsText_.text = string.format(GetTips("SPRING_BLESSING_SCREEN_TIPS"), manager.time:STimeDescS(slot2.startTime, "!%Y.%m.%d %H:%M"), manager.time:STimeDescS(slot2.stopTime, "!%Y.%m.%d %H:%M"))
end

function slot0.OnClickBubble(slot0, slot1, slot2, slot3, slot4, slot5)
	if SpringPreheatData:GetDayState(slot3) == 1 then
		ShowTips(string.format(GetTips("SPRING_PREHEAT_REWARD_BUBBLE_LOCKED"), slot3))
	elseif slot6 == 2 then
		ShowTips(string.format(GetTips("SPRING_PREHEAT_REWARD_BUBBLE_NOT_READY"), slot3))
	elseif slot6 == 3 then
		JumpTools.OpenPageByJump("SpringPreheatPraySelectReward", {
			maxSelectCount = 2,
			onSelectionConfirmed = function (slot0)
				uv0:RefreshUI()
			end
		})
	elseif slot6 == 4 then
		JumpTools.OpenPageByJump("springPreheatPrayBranch", {
			day = slot3
		})
	end
end

function slot0.OnNewDay(slot0)
	slot0:RefreshUI()
end

function slot0.GetDays(slot0)
	return SpringPreheatData:GetMaxProgress()
end

return slot0
