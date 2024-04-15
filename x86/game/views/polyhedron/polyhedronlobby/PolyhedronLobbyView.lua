slot0 = class("PolyhedronLobbyView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Polyhedron/PolyhedronPrepareUI"
end

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_policyBtn, nil, function ()
		JumpTools.OpenPageByJump("/polyhedronPolicyReward")
	end)
	slot0:AddBtnListener(slot0.m_heroBtn, nil, function ()
		JumpTools.GoToSystem("/polyhedronHero", {
			isEnter = true,
			type = HeroConst.HERO_DATA_TYPE.POLYHEDRON,
			tempHeroList = PolyhedronData:GetHeroIDList()
		})
	end)
	slot0:AddBtnListener(slot0.m_taskBtn, nil, function ()
		JumpTools.OpenPageByJump("/polyhedronTask")
	end)
	slot0:AddBtnListener(slot0.m_altasBtn, nil, function ()
		JumpTools.GoToSystem("/polyhedronArtifactAtlas", nil)
	end)
	slot0:AddBtnListener(slot0.m_rankBtn, nil, function ()
		PolyhedronAction.QueryOpenRankView()
	end)
	slot0:AddBtnListener(slot0.m_shopBtn, nil, function ()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.NEW_DUO_WEI
		})
	end)
	slot0:AddBtnListener(slot0.m_beaconBtn, nil, function ()
		JumpTools.OpenPageByJump("/polyhedronBeaconOperate")
	end)
	slot0:AddBtnListener(slot0.m_terminalBtn, nil, function ()
		JumpTools.OpenPageByJump("/polyhedronTerminal")
	end)
	slot0:AddBtnListener(slot0.m_challengeBtn, nil, function ()
		slot1 = PolyhedronData:GetPolyhedronInfo():GetState()

		if GameSetting.polyhedron_max_challenge_times.value[1] <= PolyhedronData:GetAlreadyChallengeTimes() then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				title = GetTips("PROMPT"),
				content = GetTips("POLYHEDRON_EXCEED_CHALLENGE_TIMES"),
				OkCallback = function ()
				end
			})

			return
		end

		if GameSetting.polyhedron_max_challenge_times.value[1] <= PolyhedronData:GetAlreadyChallengeTimes() then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				title = GetTips("PROMPT"),
				content = GetTips("POLYHEDRON_EXCEED_CHALLENGE_TIMES"),
				OkCallback = function ()
				end
			})

			return
		end

		if PolyhedronConst.STATE_TYPE.NOTSTARTED == slot1 then
			PolyhedronData:SetCacheBeaconList({})
			PolyhedronData:SetCacheSelectHero(0)
			JumpTools.OpenPageByJump("/polyhedronDifficulty", {})
		elseif PolyhedronConst.STATE_TYPE.SETTLEMENT == slot1 then
			OpenPageUntilLoaded("/polyhedronBlank/polyhedronOver", {})
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("POLYHEDRON_LOBBY_START_TIP"),
				BtnText = {
					[2] = GetTips("POLYHEDRON_LOBBY_SETTLEMENT"),
					GetTips("POLYHEDRON_LOBBY_BUTTON_CONTINUE")
				},
				OkCallback = function ()
					PolyhedronAction.LaunchPolyhedronBattle()
				end,
				MaskCallback = function ()
				end,
				CancelCallback = function ()
					PolyhedronAction.QueryPolyhedronGiveUp(function (slot0)
						if isSuccess(slot0.result) then
							if PolyhedronConst.STATE_TYPE.SETTLEMENT == PolyhedronData:GetPolyhedronInfo():GetState() then
								JumpTools.GoToSystem("/polyhedronBlank/polyhedronOver", nil)
							else
								JumpTools.GoToSystem("/polyhedronBlank/polyhedronLobby", nil)
							end
						else
							ShowTips(slot0.result)
						end
					end)
				end
			})
		end
	end)
end

function slot0.OnTop(slot0)
	slot1 = GameSetting.polyhedron_describe and GameSetting.polyhedron_describe.value or {}

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistInfoCallBack(function ()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			hideBg = true,
			pages = uv0
		})
	end)
	CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
end

function slot0.OnEnter(slot0)
	slot0.m_policyLvLab.text = ""
	slot0.m_timeLab.text = ""

	if PolyhedronConst.STATE_TYPE.NOTSTARTED == PolyhedronData:GetPolyhedronInfo():GetState() then
		slot0.m_btnLab.text = GetTips("POLYHEDRON_LOBBY_BUTTON_START")
	else
		slot0.m_btnLab.text = GetTips("POLYHEDRON_LOBBY_BUTTON_CONTINUE")
	end

	slot0.m_policyLvLab.text = PolyhedronTools.PolyhedronPolicyExpToLevel()

	slot0:BindRedPoint()
	slot0:RefreshTime()

	slot0.timer = Timer.New(function ()
		uv0:RefreshTime()
	end, 1, -1)

	slot0.timer:Start()
	PolyhedronAction.UpdatePolyhedronNewRed()
	CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:UnbindRedPoint()

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end
end

function slot0.RefreshTime(slot0)
	if ActivityData:GetActivityData(PolyhedronData:GetActivityID()) and manager.time:GetServerTime() <= slot2.stopTime then
		slot0.m_timeLab.text = manager.time:GetLostTimeStr(slot2.stopTime)

		return
	end

	slot0.m_timeLab.text = GetTips("TIME_OVER")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.m_taskBtn.transform, RedPointConst.POLYHEDRON_TASK)
	manager.redPoint:bindUIandKey(slot0.m_policyBtn.transform, RedPointConst.POLYHEDRON_POLICY_LEVEL_REWARD)
	manager.redPoint:bindUIandKey(slot0.m_beaconBtn.gameObject.transform, RedPointConst.POLYHEDRON_BEACON_UNLOCK)
	manager.redPoint:bindUIandKey(slot0.m_terminalBtn.gameObject.transform, RedPointConst.POLYHEDRON_TERMINAL_GIFT)
	manager.redPoint:bindUIandKey(slot0.m_heroBtn.gameObject.transform, RedPointConst.POLYHEDRON_HERO_UNLOCK)
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.m_taskBtn.transform, RedPointConst.POLYHEDRON_TASK)
	manager.redPoint:unbindUIandKey(slot0.m_policyBtn.transform, RedPointConst.POLYHEDRON_POLICY_LEVEL_REWARD)
	manager.redPoint:unbindUIandKey(slot0.m_beaconBtn.gameObject.transform, RedPointConst.POLYHEDRON_BEACON_UNLOCK)
	manager.redPoint:unbindUIandKey(slot0.m_terminalBtn.gameObject.transform, RedPointConst.POLYHEDRON_TERMINAL_GIFT)
	manager.redPoint:unbindUIandKey(slot0.m_heroBtn.gameObject.transform, RedPointConst.POLYHEDRON_HERO_UNLOCK)
end

return slot0
