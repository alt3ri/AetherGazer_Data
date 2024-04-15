slot0 = class("SpringWelfareSystemLetterView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeLetterPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.rewardUiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, SpringWelfareLetterRewardItem)
	slot0.shareController_ = ControllerUtil.GetController(slot0.transform_, "share")
	slot0.arrowController_ = ControllerUtil.GetController(slot0.transform_, "arrow")
end

function slot0.OnEnter(slot0)
	slot0.letterServerId_ = slot0.params_.letterServerId
	slot1 = SpringWelfareData:GetLetterData(slot0.letterServerId_)
	slot0.firstView_ = slot0.params_.firstView

	if slot0.params_.gotReward == false then
		slot0.gotReward_ = false
		slot0.params_.gotReward = nil
	end

	slot0.rewardList_ = SpringWelfareData:GetLetterData(slot0.letterServerId_).rewardList

	slot0:RefreshArrowUI()
	slot0:RefreshUI()
end

function slot0.OnTop(slot0)
	slot0:OnEnter()
end

function slot0.OnExit(slot0)
	AnimatorTools.Stop()
end

function slot0.OnTop(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.OnBehind(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Dispose(slot0)
	slot0.rewardUiList_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:OnClickClose()
	end)
	slot0:AddBtnListener(slot0.shareBtn_, nil, function ()
		manager.share:Share(function ()
			uv0.shareController_:SetSelectedState("false")
		end, function ()
			uv0.shareController_:SetSelectedState("true")
		end, function ()
		end)
	end)
	slot0:AddBtnListener(slot0.leftArrowBtn_, nil, function ()
		uv0:JumpNextLetter(-1)
	end)
	slot0:AddBtnListener(slot0.rightArrowBtn_, nil, function ()
		uv0:JumpNextLetter(1)
	end)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.rewardList_[slot1]

	slot2:SetClickHandler(function (slot0)
		ShowPopItem(POP_ITEM, {
			uv0
		})
	end)
	slot2:SetData(slot3[1], slot3[2], not slot0.firstView_ or slot0.gotReward_)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshLetterUI()
	slot0:RefreshHeroUI()
	slot0:RefreshRewardList()
	slot0.shareController_:SetSelectedState(slot0.firstView_ and "false" or "true")
end

function slot0.RefreshLetterUI(slot0)
	slot2 = SpringWelfareData:GetLetterData(slot0.letterServerId_).letterId
	slot0.titleText_.text = GetTips(SpringPreheatData:GetLetterTitle(slot2))
	slot0.contentText_.text = GetTips(SpringPreheatData:GetLetterFixedText(slot2, 1, 1))
end

function slot0.RefreshHeroUI(slot0)
	slot1 = slot0:GetHeroId()
	slot2 = HeroData:GetHeroData(slot1)
	slot0.heroImg_.sprite = HeroTools.GetHeadSprite(slot1)
	slot0.heroNameText_.text = HeroTools.GetHeroFullName(slot1)
end

function slot0.RefreshRewardList(slot0)
	slot0.rewardUiList_:StartScrollWithoutAnimator(#slot0.rewardList_)
	slot0.rewardUiList_:Refresh()
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

	slot0:Back()
	JumpTools.OpenPageByJump("springWelfareSystemLetter", {
		letterServerId = slot2[slot5]
	})
end

function slot0.GetLetterIdList(slot0)
	return SpringWelfareData:GetSystemLetterIdList()
end

function slot0.OnClickClose(slot0)
	if not slot0.firstView_ then
		slot0:Back()

		return
	end

	if slot0.gotReward_ then
		slot0:Back()

		if SpringWelfareData:GetNextNewPlayerLetterId() then
			JumpTools.OpenPageByJump("springWelfarePlayerLetter", {
				firstView = true,
				letterServerId = slot1
			})
		end
	else
		SpringWelfareAction:AcquireLetterReward(SpringWelfareData:GetLetterData(slot0.letterServerId_).day, function ()
			uv0.gotReward_ = true

			uv0.rewardUiList_:Refresh()
			SpringWelfareAction:UpdateRedPoint(SpringWelfareData:GetActivityId())
		end)
	end
end

function slot0.GetHeroId(slot0)
	return SpringWelfareData:GetLetterData(slot0.letterServerId_).heroId
end

return slot0
