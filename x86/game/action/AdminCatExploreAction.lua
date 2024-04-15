manager.net:Bind(67001, function (slot0)
	AdminCatExploreData:InitExploreData(slot0)
end)

return {
	AdminCatSkillLevelUp = function (slot0, slot1)
		manager.net:SendWithLoadingNew(67002, {
			mimir_id = slot0,
			skill_id = slot1
		}, 67003, uv0.AdminCatSkillLevelUpCallBack)
	end,
	AdminCatSkillLevelUpCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			AdminCatExploreData:UpdateSkillList(slot1.skill_id)
			ShowTips("EXPLORE_SKILL_UPGRADE")
			manager.notify:CallUpdateFunc(EXPLORE_LEVEL_UP_SKILL_UPDATE)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	AdminCatExplore = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(67004, {
			area_id = slot2,
			hour_time = slot1,
			mimir_id = slot0
		}, 67005, uv0.AdminCatExploreCallBack)
	end,
	AdminCatExploreCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			manager.notify:CallUpdateFunc(EXPLORE_UPDATE)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	AdminCatExploreFinish = function (slot0)
		manager.net:SendWithLoadingNew(67006, {
			area_id = slot0
		}, 67007, uv0.AdminCatExploreFinishCallBack)
	end,
	AdminCatExploreFinishCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			AdminCatExploreData:UpdateFinishExploreData(slot1.area_id, slot0.event_id, slot0.reward_list)
			manager.notify:CallUpdateFunc(EXPLORE_UPDATE)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	GetWeekReward = function ()
		manager.net:SendWithLoadingNew(67008, {}, 67009, function (slot0)
			if isSuccess(slot0.result) then
				AdminCatExploreData:ResetExploreDay(slot0.reward_list)
				ShowTips("EXPLORE_REWARD_COLLECTION")
				manager.notify:CallUpdateFunc(EXPLORE_REWARD_UPDATE)
			else
				ShowTips(GetTips(slot0.result))
			end
		end)
	end,
	UnlockAdminCat = function (slot0)
		manager.net:SendWithLoadingNew(67010, {
			mimir_id = slot0
		}, 67011, uv0.UnlockAdminCatCallBack)
	end,
	UnlockAdminCatCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			AdminCatExploreData:UpdateUnlockAdminCatList(slot1.mimir_id)
			ShowTips("EXPLORE_MEOW_DEBLOCKING")
			manager.notify:CallUpdateFunc(EXPLORE_UNLOCK_ADMIN_CAT_UPDATE)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	WeeklyFirstOpen = function ()
		manager.net:SendWithLoadingNew(67012, {}, 67013, uv0.WeeklyFirstOpenCallBack)
	end,
	WeeklyFirstOpenCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			AdminCatExploreData:UpdateWeeklyFirst()
		else
			ShowTips(GetTips(slot0.result))
		end
	end
}
