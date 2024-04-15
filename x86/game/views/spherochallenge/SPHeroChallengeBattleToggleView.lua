slot0 = class("SPHeroChallengeBattleToggleView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeBattleToggleUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.tree_ = LuaTree.New(slot0.uitreeGo_)

	slot0.tree_:SetSelectedHandler(handler(slot0, slot0.OnGroupSelect))
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot1 = SPHeroChallengeData:GetActivityID()
	slot5 = slot1
	slot0.viewList = {
		SPHeroChallengeStoryView.New(slot0.panelTrs_, slot1),
		SPHeroChallengeTrainView.New(slot0.panelTrs_, slot1),
		SPHeroChallengeBossView.New(slot0.panelTrs_, slot5)
	}

	for slot5, slot6 in ipairs(slot0.viewList) do
		slot6:Show(false)
	end
end

function slot0.OnEnter(slot0)
	slot0:RegisterEvents()

	slot0.activityID = SPHeroChallengeData:GetActivityID()

	if SPHeroChallengeData.activityCfg[slot0.activityID] then
		slot0.chapterIDList = {
			slot1.storyChapter,
			slot1.trainChapter,
			slot1.bossChapter
		}
	end

	if slot0.params_.stageID then
		if BattleVerthandiExclusiveCfg[slot0.params_.stageID].sub_type == SpHeroChallengeConst.BattleSubType.story then
			slot0.groupIndex = 1
		elseif slot2 == SpHeroChallengeConst.BattleSubType.boss then
			slot0.groupIndex = 3
		else
			slot0.groupIndex = 2

			JumpTools.OpenPageByJump("/spHeroChallengeTrainStageView", {
				playAnimation = true,
				trainType = slot2
			})

			return
		end
	end

	slot0.groupIndex = slot0.params_.groupIndex or slot0.groupIndex or 1

	if not SPHeroChallengeTools:GetChapterIsOpen(slot0.chapterIDList[slot0.groupIndex]) then
		slot0.groupIndex = 1
	end

	slot0.tree_:SelectGroup(slot0.groupIndex)

	if slot0:IsOpenSectionView() then
		SetActive(slot0.backBtn_.gameObject, true)
		SetActive(slot0.uitreeGo_, false)
	else
		SetActive(slot0.backBtn_.gameObject, false)
		SetActive(slot0.uitreeGo_, true)
	end

	slot0:RefreshLockState()
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(SP_HERO_CHALLENGE_UPDATE_BOSS, function ()
		uv0:RefreshLockState()
	end)
end

function slot0.OnTop(slot0)
	if slot0.curView then
		slot0.curView:OnTop()
	end
end

function slot0.RefreshLockState(slot0)
	for slot4, slot5 in ipairs(slot0.chapterIDList) do
		if slot0.tree_:GetGroupGameObjectById(slot4) then
			if SPHeroChallengeTools:GetChapterIsOpen(slot5) then
				ControllerUtil.GetController(slot6.transform, "lock"):SetSelectedState("false")
			else
				slot7:SetSelectedState("true")
			end
		end
	end
end

function slot0.OnUpdate(slot0)
	if slot0.curView then
		slot0.curView:SetParams(slot0.params_)
		slot0.curView:OnUpdate()
		slot0:RefreshWinBar()
	end

	if slot0:IsOpenSectionView() then
		SetActive(slot0.backBtn_.gameObject, true)
		SetActive(slot0.uitreeGo_, false)
	else
		SetActive(slot0.backBtn_.gameObject, false)
		SetActive(slot0.uitreeGo_, true)
	end
end

function slot0.OnBehind(slot0)
	if slot0.curView then
		slot0.curView:OnBehind()
	end

	slot0:RefreshBackBtnState()
end

function slot0.OnExit(slot0)
	if slot0.curView then
		slot0.curView:OnExit()
		slot0.curView:Show(false)
	end

	slot0.oldIndex = nil
	slot0.params_.groupIndex = nil

	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		if uv0:IsOpenSectionView() then
			uv0:Back()
			uv0:RefreshBackBtnState()
		end
	end)
end

function slot0.IsOpenSectionView(slot0)
	return slot0:IsOpenRoute("spHeroChallengeSectionView")
end

function slot0.RefreshBackBtnState(slot0)
	if slot0.groupIndex == SpHeroChallengeConst.BattleSubType.story then
		return
	end

	if slot0:IsOpenSectionView() then
		SetActive(slot0.backBtn_.gameObject, true)
	else
		SetActive(slot0.backBtn_.gameObject, false)
	end
end

function slot0.RefreshWinBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		JumpTools.OpenPageByJump("/spHeroChallengeMainView")
	end)
end

function slot0.Dispose(slot0)
	if slot0.viewList then
		for slot4, slot5 in pairs(slot0.viewList) do
			slot5:Dispose()
		end
	end

	if slot0.tree_ then
		slot0.tree_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	if slot0.oldIndex and slot0.oldIndex == slot1 then
		return
	end

	slot6, slot7 = SPHeroChallengeTools:GetChapterIsOpen(slot0.chapterIDList[slot1])

	if not slot6 then
		-- Nothing
	end

	slot0.groupIndex = slot1
	slot0.oldIndex = slot0.groupIndex

	slot0:SwitchPage(slot6, slot7)
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("spHeroChallengeSectionView")
end

function slot0.SwitchPage(slot0, slot1, slot2)
	if slot0:IsOpenSectionInfo() then
		slot0:Back()
	end

	if slot0.curView then
		slot0.curView:OnExit()
		slot0.curView:Show(false)
	end

	slot0.curView = slot0.viewList[slot0.groupIndex]

	if slot0.curView then
		slot0.curView:Show(true)

		slot0.params_.showFlag = slot1
		slot0.params_.reason = slot2

		slot0.curView:SetParams(slot0.params_)
		slot0.curView:OnEnter()
		slot0.curView:OnTop()
		slot0:RefreshWinBar()
	end
end

return slot0
