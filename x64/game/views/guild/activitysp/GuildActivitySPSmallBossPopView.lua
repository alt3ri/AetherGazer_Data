slot0 = class("GuildActivitySPSmallBossPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/GuildActivitySPUI/GuildActivitySPSmallBossPopUI"
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
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		if GuildActivitySPData:GetNodeData(uv0.nodeCfg_.id).health <= 0 then
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

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.nodeCfg_ = ActivityClubSPCfg[slot0.params_.nodeId]

	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.UpdateView(slot0)
	slot0.detailLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_BOSS_FIRST_BONUS_DESC"))
	slot0.titleLabel_.text = BattleClubActivitySPCfg[slot0.nodeCfg_.stage_id].name
	slot2 = slot0.nodeCfg_.boss_score
	slot3 = GuildActivitySPData:GetNodeData(slot0.params_.nodeId).health
	slot0.hpLabel_.text = string.format("%d/%d", slot3, slot2)
	slot0.hpProgressBar_.value = slot3 / slot2
	slot0.bossNameLabel_.text = GetMonsterName({
		slot0.nodeCfg_.boss_id
	})
	slot0.icon_.sprite = getSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. slot0.nodeCfg_.boss_id)
	slot5 = GuildActivitySPData:GetCurMainActivityID()
	slot0.costLabel_.text = slot0.nodeCfg_.vitality_cost

	if BattleClubActivitySPCfg[slot0.nodeCfg_.stage_id].drop_lib_id ~= nil and slot6 > 0 then
		slot7 = DropCfg[slot6].base_drop[1]
		slot0.nodeRewardImg.sprite = ItemTools.getItemSprite(slot7[1])
		slot0.firstRecoverLabel_.text = slot7[2]
	else
		slot0.nodeRewardImg.sprite = ItemTools.getItemSprite(GuildActivitySpTools.GetCurCurrencyID(slot5, 2))
		slot0.firstRecoverLabel_.text = ""
	end

	slot7 = GuildActivitySPData:IsNodeCanReach(slot0.params_.nodeId)

	if slot1.health <= 0 then
		slot0.statusController_:SetSelectedState("win")
	elseif slot7 then
		slot0.statusController_:SetSelectedState("occupy")
	else
		slot0.statusController_:SetSelectedState("unreachable")
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.OnQueryRank(slot0)
	JumpTools.OpenPageByJump("guildActivitySPRank")
end

return slot0
