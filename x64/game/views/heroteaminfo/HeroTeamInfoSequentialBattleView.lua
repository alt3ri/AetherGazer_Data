slot1 = class("HeroTeamInfoSequentailBattleView", import("game.views.heroTeamInfo.HeroTeamInfoBaseView"))

function slot1.OnEnter(slot0)
	slot0.cacheSorterExtraHeroList_ = {}

	uv0.super.OnEnter(slot0)
end

function slot1.GetCacheSorterExtraHeroList(slot0, slot1, slot2)
	if slot0.cacheSorterExtraHeroList_[slot2] then
		return slot0.cacheSorterExtraHeroList_[slot2]
	end

	slot0.cacheSorterExtraHeroList_[slot2] = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE):GetContDataTemplateById(slot1):GetHeroList(slot2)

	return slot0.cacheSorterExtraHeroList_[slot2]
end

function slot1.ExtraSorter(slot0, slot1, slot2, slot3, slot4)
	slot7 = table.keyof(SequentialBattleChapterCfg[slot0.params_.activityID].stage_id, slot0.params_.stageID)
	slot8 = {
		[slot12] = {
			id = slot13,
			trialID = slot0.heroTrialList_[slot12]
		}
	}

	for slot12, slot13 in pairs(slot0.heroTeam_) do
		-- Nothing
	end

	slot9 = false
	slot10 = false

	for slot14 = 1, #SequentialBattleChapterCfg[slot0.params_.activityID].stage_id do
		if slot14 ~= slot7 then
			slot19 = slot14

			for slot19, slot20 in pairs(slot0:GetCacheSorterExtraHeroList(slot0.params_.activityID, slot19)) do
				if slot1.id == slot20:GetHeroID() then
					slot9 = true
				end

				if slot2.id == slot21 then
					slot10 = true
				end
			end
		end
	end

	if slot9 ~= slot10 then
		return true, slot10 and true or false
	end

	if slot0:indexof(slot8, slot1) ~= slot0:indexof(slot8, slot2) then
		return true, slot11 < slot12
	end

	if slot1.trialID ~= 0 or slot2.trialID ~= 0 then
		if slot1.trialID ~= 0 and slot2.trialID ~= 0 then
			if slot3 == 0 and slot1.star ~= slot2.star then
				if slot0.curOrder_ == "desc" then
					return true, slot2.star < slot1.star
				else
					return true, slot1.star < slot2.star
				end
			end

			if getHeroPower(slot1.trialID, true) ~= getHeroPower(slot2.trialID, true) then
				if slot4 == "desc" then
					return true, slot14 < slot13
				else
					return true, slot13 < slot14
				end
			else
				return true, slot2.trialID < slot1.trialID
			end
		else
			return true, slot2.trialID < slot1.trialID
		end
	end

	return false, false
end

function slot1.HeadRenderer(slot0, slot1, slot2)
	uv0.super.HeadRenderer(slot0, slot1, slot2)
	slot2:SetHeroLock(table.keyof(slot0.lockHeroList_, slot0.heroDataList_[slot1].id) ~= nil)
end

function slot1.GetTextAndImage(slot0)
	if slot0:IsSameHeroInTeam(slot0.selectID_) and not slot0:IsInTeam(slot0.selectID_, slot0.selectTrialID_) then
		if slot0.heroTeam_[slot0.params_.selectHeroPos] ~= slot0.selectID_ then
			return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
		else
			return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
		end
	end

	if slot0.heroTeam_[slot0.params_.selectHeroPos] == 0 then
		if slot0:IsInTeam(slot0.selectID_, slot0.selectTrialID_) then
			return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
		else
			return string.format("<color=#222222>%s</color>", GetTips("JOIN_TEAM")), "0"
		end
	end

	if slot0.selectID_ == slot0.heroTeam_[slot0.params_.selectHeroPos] then
		return string.format("<color=#EBEBEB>%s</color>", GetTips("REMOVE_FROM_TEAM")), "2"
	end

	return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
end

function slot1.OnJoinClick(slot0)
	if table.keyof(slot0.lockHeroList_, slot0.selectID_) then
		slot1 = slot0.params_.activityID
		slot2 = GetTips("HERO_IN_OTHER_TEAM")
		slot3 = SequentialBattleData:GetHeroTeamData(slot1)
		slot6 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE):GetContDataTemplateById(slot1)
		slot7 = ""

		for slot11 = 1, #SequentialBattleChapterCfg[slot1].stage_id do
			if slot11 ~= table.keyof(SequentialBattleChapterCfg[slot1].stage_id, slot0.params_.stageID) then
				for slot16, slot17 in ipairs(slot6:GetHeroList(slot11)) do
					if slot17:GetHeroID() == slot0.selectID_ then
						slot7 = GetTips(string.format("TEAM_%s", slot11))
					end
				end
			end
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(slot2, slot7),
			OkCallback = function ()
				uv0.super.OnJoinClick(uv1)
			end
		})

		return
	end

	uv0.super.OnJoinClick(slot0)
end

function slot1.ChangeTeam(slot0, slot1, slot2)
	ReserveTools.SetHeroList(slot0.params_.reserveParams, slot1, slot2)
	SequentialBattleTools.SaveEnabledBuff(slot0.params_.activityID, table.keyof(SequentialBattleChapterCfg[slot0.params_.activityID].stage_id, slot0.params_.stageID))
end

return slot1
