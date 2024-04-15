slot0 = class("GuildManagerView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Club/ClubManagementUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.tree_ = LuaTree.New(slot0.goTree_)

	slot0.tree_:SetSelectedHandler(handler(slot0, slot0.OnGroupSelect), handler(slot0, slot0.OnItemSelect))

	slot0.memberUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, GuildManagerItem)
	slot0.isManagerController_ = slot0.controller:GetController("isManager")
	slot0.showContributeController = slot0.controller:GetController("showContribute")
	slot0.btnController = slot0.controller:GetController("btnState")
end

function slot0.OnEnter(slot0)
	slot0:RefreshBar()
	slot0:RefreshToggleType()
	slot0:RefreshList()
	slot0:RegisterEvent()
	slot0:RefreshEnterToggle()
	slot0:StartTimer()
	slot0:BindRedPoint()
end

function slot0.RefreshBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)
end

function slot0.StartTimer(slot0)
	if not slot0.refreshTimer then
		slot0.refreshTimer = Timer.New(function ()
			uv0:RefreshItemTimer()
		end, 1, -1)

		slot0.refreshTimer:Start()
	end
end

function slot0.RefreshItemTimer(slot0)
	if slot0.memberList_ then
		for slot4 = 1, #slot0.memberList_ do
			if slot0.memberUIList_:GetItemByIndex(slot4) then
				slot5:RefreshTimer()
			end
		end
	end
end

function slot0.RefreshEnterToggle(slot0)
	if slot0.params_.isBack then
		if slot0.page_ then
			slot1 = slot0.page_
			slot2 = 1

			if slot0.page_ == GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE then
				slot1 = GuildConst.MEMBER_LIST_TYPE.WEEK_CONTRIBUTE
				slot2 = 2
			end

			slot0.tree_:SelectItem(slot1, slot2)
		elseif slot0.params_.userID then
			slot2 = false

			for slot6, slot7 in ipairs(GuildData:GetGuildMemberIDList()) do
				if slot7 == slot0.params_.userID then
					slot0.tree_:SelectGroup(1)

					slot2 = true

					break
				end
			end

			if not slot2 then
				slot0.tree_:SelectGroup(2)
			end

			slot0.params_.userID = nil
		end
	else
		slot0.tree_:SelectGroup(1)
	end
end

function slot0.RefreshList(slot0)
	slot0.memberIDList_ = GuildData:GetGuildMemberIDList()
	slot0.memberWeekContributeList_ = GuildData:GetGuildWeekContributeList()
	slot0.memberContributeList_ = GuildData:GetGuildContributeList()
end

function slot0.RegisterEvent(slot0)
	slot0:RegistEventListener(GUILD_REFRESH_MEMBER, handler(slot0, slot0.RefreshMember))
	slot0:RegistEventListener(GUILD_REFRESH_REQUEST, handler(slot0, slot0.RefreshRequest))
	slot0:RegistEventListener(GUILD_EXIT, handler(slot0, slot0.ExitGuild))
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(GuildConst.MEMBER_LIST_TYPE.MEMBER), RedPointConst.GUILD_IMPEACH)
	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(GuildConst.MEMBER_LIST_TYPE.REQUEST), RedPointConst.GUILD_REQUEST)
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(GuildConst.MEMBER_LIST_TYPE.MEMBER), RedPointConst.GUILD_IMPEACH)
	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(GuildConst.MEMBER_LIST_TYPE.REQUEST), RedPointConst.GUILD_REQUEST)
end

function slot0.OnExit(slot0)
	if slot0.memberUIList_ then
		slot0.memberUIList_:StopRender()
	end

	slot0:StopTimer()

	slot0.scrollPos_ = clone(slot0.memberUIList_:GetScrolledPosition())

	slot0:UnBindRedPoint()
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
end

function slot0.StopTimer(slot0)
	if slot0.refreshTimer then
		slot0.refreshTimer:Stop()

		slot0.refreshTimer = nil
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.tree_ then
		slot0.tree_:Dispose()

		slot0.tree_ = nil
	end

	if slot0.memberUIList_ then
		slot0.memberUIList_:Dispose()

		slot0.memberUIList_ = nil
	end

	slot0:StopTimer()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonSetting_, nil, function ()
		JumpTools.OpenPageByJump("guildRequestSetting")
	end)
	slot0:AddBtnListener(slot0.buttonExit_, nil, function ()
		if not GuildTools:CheckCanExitGuild() then
			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("EXIT_CLUB"),
			OkCallback = function ()
				GuildAction.GuildExit(GuildData:GetGuildInfo().id, function (slot0)
					if isSuccess(slot0.result) then
						JumpTools.OpenPageByJump("/home")
					else
						ShowTips(slot0.result)
					end
				end)
			end,
			CancelCallback = function ()
			end
		})
	end)
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	if slot1 == GuildConst.MEMBER_LIST_TYPE.MEMBER then
		slot0:SwitchPage(GuildConst.MEMBER_LIST_TYPE.MEMBER)
	elseif slot1 == GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE then
		slot0:SwitchPage(GuildConst.MEMBER_LIST_TYPE.WEEK_CONTRIBUTE)
	elseif slot1 == GuildConst.MEMBER_LIST_TYPE.REQUEST then
		slot0:SwitchPage(GuildConst.MEMBER_LIST_TYPE.REQUEST)
	end
end

function slot0.OnItemSelect(slot0, slot1, slot2, slot3, slot4)
	if slot1 == 1 then
		slot0:SwitchPage(GuildConst.MEMBER_LIST_TYPE.WEEK_CONTRIBUTE)

		slot0.lastPage_ = 2
		slot0.lastPageIndex_ = 1
	else
		slot0:SwitchPage(GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE)

		slot0.lastPageIndex_ = 2
	end
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(slot0.memberList_[slot1], slot0.page_ ~= GuildConst.MEMBER_LIST_TYPE.REQUEST, slot0.page_)
end

function slot0.SwitchPage(slot0, slot1)
	slot0.showContributeController:SetSelectedState("member")

	if slot1 == GuildConst.MEMBER_LIST_TYPE.MEMBER then
		slot0.memberList_ = GuildData:GetGuildMemberIDList()
	elseif slot1 == GuildConst.MEMBER_LIST_TYPE.REQUEST then
		slot0.showContributeController:SetSelectedState("request")

		slot0.memberList_ = GuildData:GetGuildRequestIDList()
	elseif slot1 == GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE then
		slot0.showContributeController:SetSelectedState("contribute")

		slot0.memberList_ = slot0.memberContributeList_
	elseif slot1 == GuildConst.MEMBER_LIST_TYPE.WEEK_CONTRIBUTE then
		slot0.showContributeController:SetSelectedState("contribute")

		slot0.memberList_ = slot0.memberWeekContributeList_
	end

	if slot0.page_ ~= slot1 then
		slot0.page_ = slot1

		slot0.memberUIList_:StartScroll(#slot0.memberList_)
	else
		slot0.memberUIList_:StartScrollWithoutAnimator(#slot0.memberList_, slot0.scrollPos_)
	end
end

function slot0.RefreshMember(slot0)
	slot0:RefreshList()

	if slot0.page_ == GuildConst.MEMBER_LIST_TYPE.MEMBER then
		if GuildConst.GUILD_POST.DEPUTY < GuildData:GetGuildInfo().post then
			slot0:Go("/guildEntrace/guildMain")
		else
			slot0.scrollPos_ = clone(slot0.memberUIList_:GetScrolledPosition())

			slot0:SwitchPage(slot0.page_)
		end
	end

	slot0:RefreshToggleType()
end

function slot0.RefreshRequest(slot0)
	if slot0.page_ == GuildConst.MEMBER_LIST_TYPE.REQUEST then
		slot0.scrollPos_ = clone(slot0.memberUIList_:GetScrolledPosition())

		slot0:SwitchPage(slot0.page_)
	end
end

function slot0.ExitGuild(slot0)
	slot0:Go("/home")
end

function slot0.RefreshToggleType(slot0)
	if GuildData:GetGuildInfo().post == GuildConst.GUILD_POST.CAPTAIN or slot1.post == GuildConst.GUILD_POST.DEPUTY then
		slot0.isManagerController_:SetSelectedState("true")
		slot0.btnController:SetSelectedState("high")

		slot0.labelText_.text = GetTips("CLUB_BOSS_MENBER_SET")
	else
		slot0.isManagerController_:SetSelectedState("false")
		slot0.btnController:SetSelectedState("low")

		slot0.labelText_.text = GetTips("CLUB_BOSS_MENBER_LIST")
	end
end

return slot0
