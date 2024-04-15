GuildActivitySpTools = import("game.tools.GuildActivitySPTools")
ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("GuildActivitySpEnterView", ActivityMainBasePanel)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.activityID_ = slot2
	slot0.gameObject_ = Object.Instantiate(GuildActivitySpTools.GetActivityEnterViewPrefab(slot2), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.phaseController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "phase")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		slot1, slot2 = GuildActivitySpTools.CheckActivityCurState(uv0.mainActivityID)

		if slot1 == "start" then
			if GuildActivitySPData:HaveRegister() then
				StartGuildActivitySP(GuildActivitySPData:GetCurrentGrid())
			else
				uv0:DoSignup()
			end
		elseif slot1 == "register" then
			uv0:DoSignup()
		end

		if not slot0 and manager.redPoint:getTipValue(RedPointConst.GUILD_ACTIVITY_SP_UNREGISTER) == 1 then
			GuildActivitySPAction.SetUnRegisterRedPointClicked(true)
		end

		GuildActivitySPAction.SetCoinRedPointClicked(true, uv0.activityID_)
	end)
	slot0:AddBtnListener(slot0.helpBtn_, nil, function ()
		slot0, slot1 = GuildActivitySpTools.GetCurActivityDescribe()

		JumpTools.OpenPageByJump("gameHelpPro", {
			pages = slot0,
			isPrefab = slot1
		})
	end)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		slot0 = {}

		for slot5, slot6 in ipairs(ShopListCfg.all) do
			if ShopListCfg[slot6].display_group == ShopListCfg[uv0.shopID].display_group then
				table.insert(slot0, slot6)
			end
		end

		JumpTools.GoToSystem("/shop", {
			hideHomeBtn = 1,
			shopId = uv0.shopID,
			showShops = slot0
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
end

function slot0.DoSignup(slot0)
	if GameSetting.activity_club_sp_user_level_limit.value[1] <= PlayerData:GetPlayerInfo().userLevel then
		GuildActivitySPAction.Register(function ()
			if ActivityData:GetActivityIsOpen(uv0.startActivityID) then
				StartGuildActivitySP(GuildActivitySPData:GetCurrentGrid())
			else
				uv0:UpdateView()
			end
		end)
	else
		ShowTips("ACTIVITY_CLUB_REGISTER_CANT_TIP")
	end
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.StartTimer(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateView()
		end, 1, -1)
	end

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnEnter(slot0)
	slot0.mainActivityID = GuildActivitySPData:GetCurMainActivityID()
	slot0.activityInfo = GuildActivitySpTools.GetCurActivityIDInfo(slot0.mainActivityID)

	if slot0.activityInfo then
		slot0.startActivityID = slot0.activityInfo.start
		slot0.registerActivityID = slot0.activityInfo.register
		slot0.shopID = slot0.activityInfo.shopID
	end

	slot0:StartTimer()
	slot0:UpdateView()
	slot0:BindRedPoint()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	slot0:UnBindRedPoint()
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.goBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP, slot0.mainActivityID))
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.goBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP, slot0.mainActivityID))
end

function slot0.UpdateView(slot0)
	slot2 = GuildActivitySPData:HaveRegister()
	slot3 = GuildActivitySpTools.GetCurOpenActivityStateInfo()

	if ActivityData:GetActivityIsOpen(slot0.startActivityID) then
		slot4 = ActivityData:GetActivityData(slot0.startActivityID)

		if slot4.startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600 < manager.time:GetServerTime() then
			slot0.stageLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP2"))
			slot0.lastDayLabel_.text = manager.time:GetLostTimeStrWith2Unit(slot4.stopTime)
		else
			slot0.stageLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP1"))
			slot0.lastDayLabel_.text = manager.time:GetLostTimeStrWith2Unit(slot6)
		end

		if slot2 then
			slot0.activityDesc.text = string.format(GetTips(slot3.introduction))

			slot0.phaseController_:SetSelectedState("setout")
		else
			slot0.activityDesc.text = string.format(GetTips(slot3.application_2))

			slot0.phaseController_:SetSelectedState("replenish")
		end
	else
		slot0.stageLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP0"))
		slot0.lastDayLabel_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(slot0.registerActivityID).stopTime)
		slot0.activityDesc.text = string.format(GetTips(slot3.application_1), manager.time:STimeDescS(ActivityData:GetActivityData(slot0.startActivityID).startTime, GetTips("!%Y/%m/%d %H:%M:%S")))

		if slot2 then
			slot0.phaseController_:SetSelectedState("setout")
		else
			slot0.phaseController_:SetSelectedState("replenish")
		end

		if slot2 then
			slot0.phaseController_:SetSelectedState("registered")
		else
			slot0.phaseController_:SetSelectedState("unregistered")
		end
	end

	slot4 = nil
	slot0.conditionLabel_.text = (GameSetting.activity_club_sp_user_level_limit.value[1] > PlayerData:GetPlayerInfo().userLevel or string.format(GetTips("UPGRADE_LIMIT_LEVEL"), slot6)) and string.format(GetTips("UPGRADE_LIMIT_LEVEL_RED"), slot6)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	slot0:StopTimer()
	uv0.super.Dispose(slot0)
end

return slot0
