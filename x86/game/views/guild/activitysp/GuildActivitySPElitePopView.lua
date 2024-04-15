slot0 = class("GuildActivitySPElitePopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/GuildActivitySPUI/GuildActivitySPElitePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.isBeginController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isBegin")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.goonBtn_, nil, function ()
		uv0:Back()
		JumpTools.OpenPageByJump("guildActivitySPDispatch", {
			nodeId = uv0.params_.nodeId
		})
	end)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		uv0:Go("/sectionSelectHero", {
			section = uv0.nodeCfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP,
			nodeId = uv0.nodeCfg_.id,
			activityID = GuildActivitySPData:GetCurRunActivityID()
		})
	end)
	slot0:AddBtnListener(slot0.giveupBtn_, nil, function ()
		ShowMessageBox({
			isTop = true,
			content = GetTips("ACTIVITY_CLUB_SP_CANCEL_DISPATCH_CONFIRM_TIP"),
			OkCallback = function ()
				GuildActivitySPAction.CancelDispatch(uv0.nodeCfg_.id)
			end,
			CancelCallback = function ()
			end
		})
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(GUILD_ACTIVITY_SP_UPDATE_GRIDS_DATA, function (slot0)
		if table.indexof(slot0, uv0.params_.nodeId) then
			uv0:UpdateView()
		end
	end)
	slot0:RegistEventListener(GUILD_ACTIVITY_SP_CANCEL_DISPATCH, function (slot0)
		if slot0 == uv0.params_.id then
			uv0:Back()
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
	slot0.titleLabel_.text = BattleClubActivitySPCfg[slot0.nodeCfg_.stage_id].name
	slot0.levelLabel_.text = "Lv." .. slot0.nodeCfg_.level
	slot0.recoverImg.sprite = ItemTools.getItemSprite(GuildActivitySpTools.GetCurCurrencyID(GuildActivitySPData:GetCurMainActivityID(), 1))
	slot0.recoverLabel_.text = "+" .. slot0.nodeCfg_.token_get

	if 10 - GuildActivitySPData:GetNodeData(slot0.params_.nodeId).occupied_num < 1 then
		slot3 = 1
	end

	slot0.dangerousLabel_.text = string.format(GetTips("ACTIVITY_CLUB_DANGEROUS_DESC"), tostring(slot3))
	slot0.difficultyReduceLabel_.text = tostring(100 - slot3 * 10) .. "%"
	slot0.detailLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_FIRST_BONUS_DESC"))
	slot0.nodeRewardImg.sprite = ItemTools.getItemSprite(GuildActivitySpTools.GetCurCurrencyID(slot2, 2))

	if BattleClubActivitySPCfg[slot0.nodeCfg_.stage_id].drop_lib_id ~= nil and slot4 > 0 then
		slot0.firstRecoverLabel_.text = DropCfg[slot4].base_drop[1][2]
	else
		slot0.firstRecoverLabel_.text = "0"
	end

	slot0.energyCostLabel_.text = slot0.nodeCfg_.vitality_cost
	slot0.informationLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_DISPATCH_INFO_TIP"), slot1.dispatch_num, 10)

	if GuildActivitySPData:IsMyOccupiedNode(slot0.params_.nodeId) then
		if GuildActivitySPData:IsDispatched(slot0.params_.nodeId) then
			slot0.statusController_:SetSelectedState("cancel")

			slot6 = GuildActivitySPData:GetSelfNodeData(slot0.params_.nodeId)
		elseif GuildActivitySPData:IsDispatchMax(slot0.params_.nodeId) then
			slot0.statusController_:SetSelectedState("upper_limit")
		else
			slot0.statusController_:SetSelectedState("dispatch")
		end

		slot0.isBeginController_:SetSelectedState("false")
	else
		slot6 = GuildActivitySPData:GetSelfNodeData(slot0.params_.nodeId)

		if GuildActivitySPData:IsNodeCanReach(slot0.params_.nodeId) then
			slot0.statusController_:SetSelectedState("occupy")
		else
			slot0.statusController_:SetSelectedState("unreachable")
		end

		if slot6 then
			slot0.isBeginController_:SetSelectedState("true")

			slot7 = math.floor(100 - slot6.elite_health_rate)
			slot0.attackingProgressLabel_.text = tostring(slot7) .. "%"
			slot0.progressImage_.fillAmount = slot7 / 100
			slot0.slider_.value = slot7 / 100
		else
			slot0.isBeginController_:SetSelectedState("false")

			slot0.attackingProgressLabel_.text = "0%"
			slot0.progressImage_.fillAmount = 0
			slot0.slider_.value = 0
		end
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
