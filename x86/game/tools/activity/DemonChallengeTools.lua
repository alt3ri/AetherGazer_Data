return {
	GetChildId = function (slot0, slot1, slot2)
		slot3 = nil

		if (slot2 ~= true or NewDemonChallengeCfg.get_id_list_by_activity_id[slot0]) and DemonChallengeCfg.get_id_list_by_activity_id[slot0] then
			return slot3[slot1]
		end
	end,
	GetStageId = function (slot0, slot1, slot2)
		slot3 = nil

		if (slot2 ~= true or NewDemonChallengeCfg.get_id_list_by_activity_id[slot0]) and DemonChallengeCfg.get_id_list_by_activity_id[slot0] then
			if slot2 == true then
				return NewDemonChallengeCfg[slot3[slot1]].stage_id
			else
				return DemonChallengeCfg[slot4].stage_id
			end
		end
	end,
	GetMainUIName = function (slot0)
		if ActivityTools.GetOriginActivityTheme(ActivityTools.GetActivityTheme(slot0)) == ActivityConst.THEME.OSIRIS then
			return "UI/VersionUI/OsirisUI/DemonChallenge/DemonMainUI"
		elseif slot2 == ActivityConst.THEME.HELLA then
			return "UI/VersionUI/HellaUI/HellaBossChallengeUI"
		elseif slot2 == ActivityConst.THEME.VOLUME_DOWN then
			return "UI/VolumeIIIDownUI/VolumeIIIDownDemonChallenge/VolumeDemonChallengeMainUI"
		elseif slot2 == ActivityConst.THEME.DREAM then
			return "UI/EmptyDream/DemonChallenge/EDream_DCMainUI"
		elseif slot2 == ActivityConst.THEME.ACTIVITY_2_2 then
			return "UI/VersionUI/XuHeng3rdUI/XH3rdMindDemonUI/XuHeng3rdDemonLevelUI"
		else
			return "UI/VersionUI/OsirisUI/DemonChallenge/DemonMainUI"
		end
	end,
	GetDifficultyUIName = function (slot0)
		if ActivityTools.GetOriginActivityTheme(ActivityTools.GetActivityTheme(slot0)) == ActivityConst.THEME.OSIRIS then
			return "UI/VersionUI/OsirisUI/DemonChallenge/DemonDifficultyUI"
		elseif slot2 == ActivityConst.THEME.HELLA then
			return "UI/VersionUI/HellaUI/HellaChoosedifficultyUI"
		elseif slot2 == ActivityConst.THEME.VOLUME_DOWN then
			return "UI/VolumeIIIDownUI/VolumeIIIDownDemonChallenge/VolumeDemonChallengeDifficultyUI"
		elseif slot2 == ActivityConst.THEME.DREAM or slot2 == ActivityConst.THEME.ACTIVITY_2_2 then
			return "UI/EmptyDream/DemonChallenge/EDream_DCChoosedifficultUI"
		else
			return "UI/VersionUI/OsirisUI/DemonChallenge/DemonDifficultyUI"
		end
	end,
	GetAwardUIName = function (slot0)
		if ActivityTools.GetOriginActivityTheme(ActivityTools.GetActivityTheme(slot0)) == ActivityConst.THEME.OSIRIS then
			return "UI/PopUp/DemonAwardUI"
		elseif slot2 == ActivityConst.THEME.VOLUME_DOWN then
			return "UI/VolumeIIIDownUI/VolumeIIIDownDemonChallenge/VolumeDemonChallengeRewardPop"
		elseif slot2 == ActivityConst.THEME.DREAM then
			return "UI/EmptyDream/DemonChallenge/EDream_DCRewardUI"
		else
			return "UI/PopUp/DemonAwardUI"
		end
	end
}
