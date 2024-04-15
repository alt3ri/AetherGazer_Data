manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, function ()
	uv0.UpdateTaskRedPoint()
end)
manager.net:Bind(84001, function (slot0)
	ActivityReforgeData:SetActivityData(slot0)
	uv0.InitRedPointKey(slot0.activity_id)
end)
manager.net:Bind(84003, function (slot0)
	ActivityReforgeData:SetChapterData(slot0)
	manager.notify:CallUpdateFunc(ACTIVITY_REFORGE_CURLEVEL_UPDATE)
end)
manager.net:Bind(84027, function (slot0)
	ActivityReforgeData:SetCurLevelData(slot0)
	manager.notify:CallUpdateFunc(ACTIVITY_REFORGE_CURLEVEL_UPDATE)
end)

return {
	InitRedPointKey = function (slot0)
		slot1 = RedPointConst.ACTIVITY_REFORGE_SKILL .. slot0
		slot2 = {}

		for slot6, slot7 in pairs(ActivityReforgeSkillCfg.all) do
			slot8 = RedPointConst.ACTIVITY_REFORGE_SKILL .. slot7

			table.insert(slot2, slot8)
			manager.redPoint:setTip(slot8, 0)
		end

		manager.redPoint:addGroup(slot1, slot2)

		slot3 = RedPointConst.ACTIVITY_REFORGE .. slot0
		slot4 = RedPointConst.ACTIVITY_REFORGE_TASK .. slot0
		slot5 = RedPointConst.ACTIVITY_REFORGE_NEW_CHPATER .. slot0
		slot6 = {}

		for slot10, slot11 in pairs(ActivityCfg[slot0].sub_activity_list) do
			slot12 = RedPointConst.ACTIVITY_REFORGE_NEW_CHPATER .. slot11

			table.insert(slot6, slot12)
			manager.redPoint:setTip(slot12, 0)
		end

		manager.redPoint:addGroup(slot5, slot6)
		manager.redPoint:addGroup(slot3, {
			slot4,
			slot5
		})
	end,
	UpdateTaskRedPoint = function ()
		slot3 = ActivityTemplateConst.ACTIVITY_REFORGE

		for slot3, slot4 in pairs(ActivityCfg.get_id_list_by_activity_template[slot3]) do
			if ActivityData:GetActivityIsOpen(slot4) then
				if #TaskTools:GetCanGetActivityTaskList(slot4) > 0 then
					manager.redPoint:setTip(RedPointConst.ACTIVITY_REFORGE_TASK .. slot4, 1)
				else
					manager.redPoint:setTip(slot5, 0)
				end
			else
				manager.redPoint:setTip(slot5, 0)
			end
		end
	end,
	StartLevel = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(84004, {
			chapter_id = slot0,
			stage_id = slot1
		}, 84005, function (slot0, slot1)
			uv0:OnStartLevel(slot0, slot1, uv1)
		end)
	end,
	OnStartLevel = function (slot0, slot1, slot2, slot3)
		if isSuccess(slot1.result) then
			ActivityReforgeData:InitCurLevelData(slot2.chapter_id, slot2.stage_id)

			if slot3 then
				slot3()
			end
		else
			ShowTips(GetTips(slot1.result))
		end
	end,
	SetWaveTeam = function (slot0, slot1, slot2, slot3, slot4)
		manager.net:SendWithLoadingNew(84006, {
			chapter_id = slot0,
			stage_id = slot1,
			wave_id = slot2,
			team_id = slot3
		}, 84007, function (slot0, slot1)
			uv0:OnSetWaveTeam(slot0, slot1, uv1)
		end)
	end,
	OnSetWaveTeam = function (slot0, slot1, slot2, slot3)
		if not isSuccess(slot1.result) then
			ShowTips(GetTips(slot1.result))
		end

		if slot3 then
			slot3()
		end
	end,
	TeamLevelUp = function (slot0, slot1, slot2, slot3)
		if ActivityReforgeAction.CheckGold(ActivityReforgeTeamCfg[slot2].cost[ActivityReforgeData:GetTeamInfo(slot2).level], true) then
			manager.net:SendWithLoadingNew(84008, {
				chapter_id = slot0,
				stage_id = slot1,
				team_id = slot2
			}, 84009, function (slot0, slot1)
				uv0:OnTeamLevelUp(slot0, slot1, uv1)
			end)
		end
	end,
	OnTeamLevelUp = function (slot0, slot1, slot2, slot3)
		if isSuccess(slot1.result) then
			ShowTips("ACTIVITY_REFORGE_TEAM_LEVEL_UP")

			if slot3 then
				slot3()
			end
		else
			ShowTips(GetTips(slot1.result))
		end
	end,
	ResetTeamLevel = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(84010, {
			chapter_id = slot0,
			stage_id = slot1,
			team_id = slot2
		}, 84011, function (slot0, slot1)
			uv0:OnResetTeamLevel(slot0, slot1)
		end)
	end,
	OnResetTeamLevel = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			ShowTips("ACTIVITY_REFORGE_RESET_TEAM_LEVEL")
		else
			ShowTips(GetTips(slot1.result))
		end
	end,
	BuySkill = function (slot0, slot1, slot2, slot3)
		if ActivityReforgeAction.CheckGold(ActivityReforgeSkillCfg[slot2].cost, true) then
			manager.net:SendWithLoadingNew(84012, {
				chapter_id = slot0,
				stage_id = slot1,
				skill_id = slot2
			}, 84013, function (slot0, slot1)
				uv0:OnBuySkill(slot0, slot1, uv1)
			end)
		end
	end,
	OnBuySkill = function (slot0, slot1, slot2, slot3)
		if isSuccess(slot1.result) then
			if slot3 then
				slot3()
			end
		else
			ShowTips(GetTips(slot1.result))
		end
	end,
	SelectSkill = function (slot0, slot1, slot2, slot3)
		manager.net:SendWithLoadingNew(84014, {
			chapter_id = slot0,
			stage_id = slot1,
			skill_id = slot2
		}, 84015, function (slot0, slot1)
			uv0:OnSelectSkill(slot0, slot1, uv1)
		end)
	end,
	OnSelectSkill = function (slot0, slot1, slot2, slot3)
		if isSuccess(slot1.result) then
			if slot3 then
				slot3()
			end
		else
			ShowTips(GetTips(slot1.result))
		end
	end,
	UnSelectSkill = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(84016, {
			chapter_id = slot0,
			stage_id = slot1,
			skill_id = slot2
		}, 84017, function (slot0, slot1)
			uv0:OnUnSelectSkill(slot0, slot1)
		end)
	end,
	OnUnSelectSkill = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			ShowTips("ACTIVITY_REFORGE_UNUSE_SKILL")
		else
			ShowTips(GetTips(slot1.result))
		end
	end,
	SellSkill = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(84018, {
			chapter_id = slot0,
			stage_id = slot1,
			skill_id = slot2
		}, 84019, function (slot0, slot1)
			uv0:OnSellSkill(slot0, slot1)
		end)
	end,
	OnSellSkill = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			ShowTips("ACTIVITY_REFORGE_SELL_SKILL")
		else
			ShowTips(GetTips(slot1.result))
		end
	end,
	GiveUpCurLevel = function (slot0, slot1)
		manager.net:SendWithLoadingNew(84020, {
			chapter_id = slot0,
			stage_id = slot1
		}, 84021, function (slot0, slot1)
			uv0:OnGiveUpCurLevel(slot0, slot1)
		end)
	end,
	OnGiveUpCurLevel = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			ActivityReforgeData:ClearCurLevelData()
			manager.notify:CallUpdateFunc(ACTIVITY_REFORGE_GIVEUP_LEVEL)
		else
			ShowTips(GetTips(slot1.result))
		end
	end,
	LevelFinish = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(84022, {
			chapter_id = slot0,
			stage_id = slot1
		}, 84023, function (slot0, slot1)
			uv0:OnLevelFinish(slot0, slot1, uv1)
		end)
	end,
	OnLevelFinish = function (slot0, slot1, slot2, slot3)
		if isSuccess(slot1.result) then
			ActivityReforgeData:SetCurFinishLevelServerData(slot1.stage_info)

			if slot3 then
				slot3()
			end
		else
			ShowTips(GetTips(slot1.result))
		end
	end,
	RequestAllPlayerLevelData = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(84024, {
			chapter_id = slot0,
			stage_id = slot1
		}, 84025, function (slot0, slot1)
			uv0:OnRequestAllPlayerLevelData(slot0, slot1, uv1)
		end)
	end,
	OnRequestAllPlayerLevelData = function (slot0, slot1, slot2, slot3)
		if isSuccess(slot1.result) then
			ActivityReforgeData:SetLevelAllPlayerServerData(slot2.chapter_id, slot2.stage_id, slot1.all_player_stage_info)

			if slot3 then
				slot3()
			end
		else
			ShowTips(GetTips(slot1.result))
		end
	end,
	CheckGold = function (slot0, slot1)
		if ActivityReforgeData:GetCurCanUseGold() < slot0 then
			if slot1 then
				ShowTips("ACTIVITY_REFORGE_NEED_GLOD_LESS_THEN_HAVE")
			end

			return false
		end

		return true
	end
}
