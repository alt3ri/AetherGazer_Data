slot1 = class("HeroTeamInfoSoloChallengeView", import("game.views.heroTeamInfo.HeroTeamInfoBaseView"))

function slot1.GetHeroTeam(slot0)
	slot2 = ReserveTools.GetReserveTemplate(BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE, slot0.params_.stageID):GetContDataTemplateById(slot0.params_.reserveParams.contID)
	slot0.heroTeam_, slot0.heroTrialList_ = slot2:GetSummaryHeroList()
	slot0.lockStateList_ = {
		false,
		false,
		false
	}
	slot0.lockHeroList_ = slot2:GetLockHeroList(slot0.params_.activityID, slot0.params_.reserveParams.customData.difficultyIndex)
end

function slot1.HeadRenderer(slot0, slot1, slot2)
	uv0.super.HeadRenderer(slot0, slot1, slot2)

	slot3 = slot0.heroDataList_[slot1].id
	slot5, slot6, slot7 = slot0:IsInTeam(slot3, slot0.heroDataList_[slot1].trialID)

	if (table.keyof(slot0.lockHeroList_, slot3) ~= nil or table.keyof(slot0.lockHeroList_, slot4) ~= nil) == false then
		slot2:SetSoloChallengeIndex(slot7)
	else
		slot2:SetSoloChallengeIndex(-1)
	end

	slot2:SetHeroLock(slot8)
	slot2:SetInTeamFlag(false)
end

function slot1.TryToChangeTeam(slot0, slot1, slot2)
	slot0:ChangeTeam(slot1, slot2)
end

function slot1.ChangeTeam(slot0, slot1, slot2)
	ReserveTools.GetReserveTemplateByReserveType(ReserveTools.GetReserveType(BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE, slot0.params_.stageID)):GetContDataTemplateById(slot0.params_.reserveParams.contID):SetSummaryHeroList(slot1, slot2)
	ReserveAction.SaveSoloChallengeContData(slot0.params_.activityID, slot0.params_.reserveParams.customData.difficultyIndex, function ()
		uv0:OnChangeTeamSuccess()
	end)
end

return slot1
