return {
	GetLockHero = function ()
		if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NONE then
			return {}
		end

		if slot0 == BossConst.MODE_NORMAL then
			return BattleBossChallengeNormalData:GetLockHero()
		else
			return BattleBossChallengeAdvanceData:GetLockHero()
		end
	end,
	GetCacheHeroTeam = function (slot0)
		if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NORMAL then
			return BattleBossChallengeNormalData:GetCacheHeroTeam(slot0)
		else
			return BattleBossChallengeAdvanceData:GetCacheHeroTeam(slot0)
		end
	end,
	CheckTimeout = function ()
		if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NONE then
			BattleBossChallengeAction.BossChallengeBackEntrace()
		end
	end,
	GetBossID = function (slot0, slot1)
		if slot0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE then
			return StageGroupCfg[BattleBossChallengeNormalData:GetBossList()[slot1]].boss_id
		elseif slot0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE then
			return BattleBossChallengeAdvanceData:GetBossList()[slot1].templateID
		end
	end,
	GetContID = function (slot0, slot1)
		if slot0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE then
			return BattleBossChallengeNormalData:GetBossList()[slot1]
		elseif slot0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE then
			return BattleBossChallengeAdvanceData:GetBossList()[slot1].id
		end
	end,
	IsFirstEnterUI = function (slot0)
		slot1 = BattleBossChallengeData:GetRewardPreviewLevel()

		if uv0.IsClearedStage() then
			return false
		end

		slot2 = nil

		return slot1 ~= ((slot0 ~= BossConst.MODE_NORMAL or BattleBossChallengeNormalData:GetBossChallengeCfg().range_id) and BattleBossChallengeAdvanceData:GetChooseModeID())
	end,
	SaveFirstEnterUIValue = function (slot0)
		slot1 = nil

		BattleBossChallengeData:SetRewardPreviewLevel((slot0 ~= BossConst.MODE_NORMAL or BattleBossChallengeNormalData:GetBossChallengeCfg().range_id) and BattleBossChallengeAdvanceData:GetChooseModeID())
	end,
	IsClearedStage = function ()
		for slot3, slot4 in ipairs(uv0.GetLockHero()) do
			if #slot4 > 0 then
				return true
			end
		end

		return false
	end
}
