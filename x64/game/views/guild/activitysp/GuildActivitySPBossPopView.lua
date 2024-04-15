slot0 = class("GuildActivitySPBossPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/GuildActivitySPUI/GuildActivitySPBossPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0.queryRankHandler_ = handler(slot0, slot0.OnQueryRank)

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.finalReachableController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "finalReachable")
	slot0.boss_statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "boss_status")
	slot0.affixrScroll_ = LuaList.New(handler(slot0, slot0.indexAffix), slot0.affixUiList, GuildActivitySpAffixItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.recordBtn_, nil, function ()
		GuildActivitySPAction.GetFightRecord(uv0.params_.nodeId, function (slot0)
			JumpTools.OpenPageByJump("guildActivitySPRecord", {
				dataList = slot0
			})
		end)
	end)
	slot0:AddBtnListener(slot0.challengeBtn_, nil, function ()
		uv0:Go("/sectionSelectHero", {
			section = uv0.nodeCfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP,
			nodeId = uv0.nodeCfg_.id,
			activityID = GuildActivitySPData:GetCurRunActivityID()
		})
	end)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		if uv0.params_.nodeId ~= GuildActivitySPData:GetMaxNodeId() and GuildActivitySPData:GetNodeData(uv0.nodeCfg_.id).health <= 0 then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				isTop = true,
				content = GetTips("BOSS_BE_KILLED_TIP"),
				OkCallback = function ()
					uv0:UpdateView()
				end
			})

			return
		end

		uv0:Go("/sectionSelectHero", {
			section = uv0.nodeCfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP,
			nodeId = uv0.nodeCfg_.id,
			activityID = GuildActivitySPData:GetCurRunActivityID()
		})
	end)
	slot0:AddBtnListener(slot0.nextFloorBtn_, nil, function ()
		if table.indexof(ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()], uv0.nodeCfg_.map_id) < #GuildActivitySPData:GetSpawnIdList() then
			manager.notify:CallUpdateFunc(GUILD_ACTIVITY_SP_ENTER_NEW_LEVEL)
		else
			GuildActivitySPAction.EnterNext(uv0.nodeCfg_.id)
		end
	end)
	slot0:AddBtnListener(slot0.bossInfoBtn_, nil, function ()
		JumpTools.OpenPageByJump("bossInfo", {
			bossID = uv0.nodeCfg_.boss_id,
			spritePath = SpritePathCfg.CollectBoss.path .. uv0.nodeCfg_.boss_id
		})
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(GUILD_ACTIVITY_SP_UPDATE_GRIDS_DATA, function (slot0)
		if table.indexof(slot0, uv0.params_.nodeId) then
			uv0:UpdateView()
		end
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
end

function slot0.UpdateBar(slot0)
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.UpdateTimer(slot0)
	slot3 = ActivityData:GetActivityData(GuildActivitySPData:GetCurRunActivityID())
	slot6 = slot3.stopTime
	slot7 = BattleClubActivitySPCfg[slot0.nodeCfg_.stage_id].affix_type

	if slot3.startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600 < manager.time:GetServerTime() then
		slot0.stageLevel = 2
	else
		slot0.stageLevel = 1
	end

	if slot7 and slot7 ~= "" then
		if slot0.nodeCfg_.id == GuildActivitySPData:GetMaxNodeId() then
			if slot0.stageLevel == 2 then
				slot0.boss_statusController_:SetSelectedIndex(1)
			else
				slot0.boss_statusController_:SetSelectedIndex(0)
			end
		else
			slot0.boss_statusController_:SetSelectedIndex(2)
		end
	else
		slot0.boss_statusController_:SetSelectedIndex(2)
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.nodeCfg_ = ActivityClubSPCfg[slot0.params_.nodeId]

	slot0:UpdateTimer()
	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	slot0:StopTimer()
end

function slot0.UpdateView(slot0)
	slot0.detailLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_BOSS_FIRST_BONUS_DESC"))
	slot5 = table.indexof(ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()], slot0.nodeCfg_.map_id)
	slot0.titleLabel_.text = BattleClubActivitySPCfg[slot0.nodeCfg_.stage_id].name
	slot6 = slot0.nodeCfg_.boss_score
	slot7 = GuildActivitySPData:GetNodeData(slot0.params_.nodeId).health
	slot0.hpLabel_.text = string.format("%d/%d", slot7, slot6)
	slot0.hpProgressBar_.value = slot7 / slot6
	slot0.bossNameLabel_.text = GetMonsterName({
		slot0.nodeCfg_.boss_id
	})
	slot0.icon_.sprite = getSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. slot0.nodeCfg_.boss_id)
	slot0.costLabel_.text = slot0.nodeCfg_.vitality_cost
	slot9 = GuildActivitySPData:GetCurMainActivityID()

	if BattleClubActivitySPCfg[slot0.nodeCfg_.stage_id].drop_lib_id ~= nil and slot10 > 0 then
		slot11 = DropCfg[slot10].base_drop[1]
		slot0.nodeRewardImg.sprite = ItemTools.getItemSprite(slot11[1])
		slot0.firstRecoverLabel_.text = slot11[2]
	else
		slot0.nodeRewardImg.sprite = ItemTools.getItemSprite(GuildActivitySpTools.GetCurCurrencyID(slot9, 2))
		slot0.firstRecoverLabel_.text = ""
	end

	slot11 = GuildActivitySPData:IsNodeCanReach(slot0.params_.nodeId)

	if GuildActivitySPData:IsAllLittleBossPass(slot2) == 0 then
		slot0.statusController_:SetSelectedState("lock")
	elseif slot1.health <= 0 then
		if slot0.params_.nodeId == GuildActivitySPData:GetMaxNodeId() then
			if slot11 then
				slot0.statusController_:SetSelectedState("occupy")
				slot0.finalReachableController_:SetSelectedState("true")
			else
				slot0.statusController_:SetSelectedState("unreachable")
				slot0.finalReachableController_:SetSelectedState("false")
			end
		else
			slot0.statusController_:SetSelectedState("value_5")
		end
	elseif slot11 then
		slot0.statusController_:SetSelectedState("occupy")
	else
		slot0.statusController_:SetSelectedState("unreachable")
	end

	slot0:RefreshAffixType()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.RefreshAffixType(slot0)
	slot0:UpdateTimer()

	slot0.affixList = {}

	if BattleClubActivitySPCfg[slot0.nodeCfg_.stage_id].affix_type ~= nil and slot1 ~= "" then
		for slot5, slot6 in ipairs(slot1) do
			table.insert(slot0.affixList, slot6)
		end

		slot0.affixrScroll_:StartScroll(#slot0.affixList)
	else
		slot0.affixrScroll_:StartScroll(0)
	end
end

function slot0.indexAffix(slot0, slot1, slot2)
	slot2:SetClickCallBack(handler(slot0, function (slot0)
		if BattleClubActivitySPCfg[uv0.nodeCfg_.stage_id].affix_type == nil or slot1 == "" then
			return
		end

		JumpTools.OpenPageByJump("affixDetail", {
			affixList = slot1
		})
	end))

	if slot0.stageLevel == 2 then
		slot2:RefreshUI(slot0.affixList[slot1], true)
	else
		slot2:RefreshUI(slot0.affixList[slot1], false)
	end
end

function slot0.Dispose(slot0)
	if slot0.affixrScroll_ then
		slot0.affixrScroll_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.OnQueryRank(slot0)
	JumpTools.OpenPageByJump("guildActivitySPRank")
end

return slot0
