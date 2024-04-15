slot0 = class("CommunityTaskView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Club/ClubCtivityUI"
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

	slot0.taskList_ = {}
	slot0.taskListModule = CommonTaskListModule.New(slot0.comTaskList_)
	slot0.guildExitHandler_ = handler(slot0, slot0.ExitGuild)
end

function slot0.AddUIListener(slot0)
end

function slot0.OnEnter(slot0)
	slot0.taskListModule:OnEnter()
	slot0.taskListModule:RenderTypeTaskList(TaskConst.TASK_TYPE.CLUB_TASK)
	slot0:RefreshUI()
	manager.notify:RegistListener(GUILD_EXIT, slot0.guildExitHandler_)
end

function slot0.RefreshUI(slot0)
	slot0.identity_ = CommunityData:GetIdentity()

	slot0:RefreshBar()
end

function slot0.RefreshBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)
end

function slot0.ExitGuild(slot0)
	slot0:Go("/home")
end

function slot0.OnExit(slot0)
	slot0.taskListModule:OnExit()
	manager.notify:RemoveListener(GUILD_EXIT, slot0.guildExitHandler_)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0.taskListModule:Dispose()
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
