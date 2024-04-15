slot0 = class("SoloChallengeSelectView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/SummerUI/SummerSoloChallengeSelectUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.onResetDataHandler_ = handler(slot0, slot0.OnResetData)

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.scrollView_, SoloChallengeSelectItem)
end

function slot0.OnEnter(slot0)
	slot4, slot5 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE):GetContDataTemplateById(ActivitySoloChallengeCfg[slot0.params_.activityID].stage_id[slot0.params_.difficultyIndex][1]):GetSummaryHeroList(slot0.params_.activityID, slot0.params_.difficultyIndex)
	slot6 = false

	for slot11, slot12 in ipairs(slot5) do
		if slot12 ~= 0 and not table.keyof(GetTrialHeroList(BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE, nil, slot0.params_.activityID), slot12) and not table.keyof(lockHeroList, slot12) then
			slot6 = true
			slot5[slot11] = 0
			slot4[slot11] = 0
		end
	end

	if slot6 then
		slot3:SetSummaryHeroList(slot4, slot5)
		ReserveAction.SaveSoloChallengeContData(slot0.params_.activityID, slot0.params_.difficultyIndex, function ()
			uv0:OnTop()
		end)
	end
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()

	slot0.activityID_ = slot0.params_.activityID
	slot0.difficultyIndex_ = slot0.params_.difficultyIndex
	slot0.difficultyID_ = ActivitySoloChallengeCfg[slot0.activityID_].stage_id[slot0.difficultyIndex_][1]
	slot0.stageList_ = ActivitySoloChallengeCfg[slot0.activityID_].stage_id[slot0.difficultyIndex_][2]

	slot0.list_:StartScroll(#slot0.stageList_)
	slot0:RefreshUI()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.activityID_, slot0.stageList_[slot1], slot1, slot0.difficultyIndex_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		slot0 = uv0:GetNextChallengeStageID()

		if not uv0:customHeroReady() then
			ShowTips("HERO_UNREADY_SOLO_CHALLENGE")

			return
		end

		if not uv0:customAffixReady() then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("AFFIX_UNREADY_SOLO_CHALLENGE"),
				OkCallback = function ()
					uv0:GoToStage(uv1)
				end
			})

			return
		end

		uv0:GoToStage(slot0)
	end)
	slot0:AddBtnListener(slot0.giveUpBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_SOLO_CHALLENGE"),
			OkCallback = function ()
				SoloChallengeAction.ResetData(uv0.activityID_, uv0.onResetDataHandler_)
			end
		})
	end)
end

function slot0.GoToStage(slot0, slot1)
	SoloChallengeData:SaveActivityID(slot0.activityID_, slot1)
	SoloChallengeData:SaveDifficultyIndex(slot0.difficultyIndex_, slot1)
	slot0:Go("/sectionSelectHero", {
		canChangeTeam = false,
		section = slot1,
		sectionType = BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE,
		activityID = slot0.activityID_,
		reserveParams = ReserveParams.New(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE, slot0.difficultyID_, table.indexof(slot0.stageList_, slot1), {
			stageType = BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE,
			stageID = slot1,
			activityID = slot0.activityID_,
			difficultyIndex = slot0.difficultyIndex_
		})
	})
end

function slot0.RefreshUI(slot0)
	slot0:RefreshGiveUpBtn()
end

function slot0.RefreshGiveUpBtn(slot0)
	if SoloChallengeData:GetCompletedStageList(slot0.activityID_)[slot0.difficultyIndex_] and #slot1[slot0.difficultyIndex_] ~= 0 then
		slot0.giveUpBtn_.interactable = true
	else
		slot0.giveUpBtn_.interactable = false
	end
end

function slot0.GetNextChallengeStageID(slot0)
	for slot5, slot6 in ipairs(slot0.stageList_) do
		if table.keyof(SoloChallengeData:GetCompletedStageList(slot0.activityID_)[slot0.difficultyIndex_], slot6) == nil then
			return slot6
		end
	end

	return 0
end

function slot0.OnResetData(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		SoloChallengeData:ResetLockData(slot2)
		slot0:Back()
	else
		ShowTips(slot1.result)
	end
end

function slot0.customHeroReady(slot0)
	slot4, slot5 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE):GetContDataTemplateById(ActivitySoloChallengeCfg[slot0.params_.activityID].stage_id[slot0.params_.difficultyIndex][1]):GetSummaryHeroList(slot0.params_.activityID, slot0.params_.difficultyIndex)

	if slot4 == nil then
		return false
	else
		for slot9 = 1, #slot0.stageList_ do
			if slot4[slot9] == 0 then
				return false
			end
		end
	end

	return true
end

function slot0.customAffixReady(slot0)
	slot1 = slot0.activityID_
	slot2 = SoloChallengeData:GetMaxAffixCount(slot1)

	for slot7, slot8 in pairs(slot0.stageList_) do
		if table.keyof(SoloChallengeData:GetCompletedStageList(slot1)[slot0.difficultyIndex_], slot8) == nil then
			slot12 = ReserveTools.GetReserveTemplate(BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE, slot8):GetContDataTemplateById(ActivitySoloChallengeCfg[slot0.activityID_].stage_id[slot0.difficultyIndex_][1]):GetAffixList(slot7)

			for slot16 = 1, slot2 do
				if not slot12[slot16] or slot12[slot16] == 0 then
					return false
				end
			end
		end
	end

	return true
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	slot0.onResetDataHandler_ = nil
	slot0.onSaveCustomListHandler_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnReverTeamData(slot0)
	slot0.stageList_ = ActivitySoloChallengeCfg[slot0.activityID_].stage_id[slot0.difficultyIndex_][2]

	slot0.list_:StartScroll(#slot0.stageList_)
end

return slot0
