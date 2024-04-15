slot0 = class("GuildManagerItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.memberController_ = slot0.controller:GetController("playerState")
	slot0.postController_ = slot0.controller:GetController("posts")
	slot0.buttonController_ = slot0.btnControllerEx_:GetController("btnState")
	slot0.onlineController = slot0.onlineControllerEx_:GetController("online")

	slot0:RegisterEvents()
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(GUILD_CAPTAIN_IMPEACH, function ()
		if uv0.isMember_ and GuildData:GetGuildMemberData(uv0.id_).post == GuildConst.GUILD_POST.CAPTAIN then
			uv0:SetData(slot0, uv0.isMember_, nil)
		end
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonInfo_, nil, function ()
		ForeignInfoAction:TryToCheckForeignDetailInfo(uv0.id_)
	end)
	slot0:AddBtnListener(slot0.buttonRemove_, nil, function ()
		if not GuildTools:CheckCanExitGuild() then
			return
		end

		ShowMessageBox({
			isTop = true,
			content = string.format(GetTips("CLUB_REMOVE_MEMBER"), GuildData:GetGuildMemberData(uv0.id_).name),
			OkCallback = function ()
				GuildAction.GuildRemoveMember(uv0.id_, function (slot0)
					ShowTips(slot0.result)
				end)
			end,
			CancelCallback = function ()
			end
		})
	end)
	slot0:AddBtnListener(slot0.buttonPost_, nil, function ()
		JumpTools.OpenPageByJump("guildMobilityPost", {
			memberID = uv0.id_
		})
	end)
	slot0:AddBtnListener(slot0.buttonImpeach_, nil, function ()
		ShowMessageBox({
			isTop = true,
			content = GetTips("CLUB_IMPEACH_TIPS"),
			OkCallback = function ()
				GuildAction.GuildImpeach(uv0.id_, function (slot0)
					ShowTips(slot0.result)
				end)
			end,
			CancelCallback = function ()
			end
		})
	end)
	slot0:AddBtnListener(slot0.buttonCancelImpeach_, nil, function ()
		GuildAction.GuildCancelImpeach(function (slot0)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)
			end
		end)
	end)
	slot0:AddBtnListener(slot0.buttonAgree_, nil, function ()
		GuildAction.GuildAgreeRequest(uv0.id_, function (slot0)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)
			end
		end)
	end)
	slot0:AddBtnListener(slot0.buttonRefuse_, nil, function ()
		GuildAction.GuildRefuseRequest(uv0.id_, function (slot0)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)
			end
		end)
	end)
	slot0:AddBtnListener(slot0.applyBtn_, nil, function ()
		ShowMessageBox({
			isTop = true,
			content = GetTips("CLUB_APPLY_CAPTAIN_TIPS"),
			OkCallback = function ()
				GuildAction.ApplyCaptain(function (slot0)
					ShowTips(slot0.result)
				end)
			end,
			CancelCallback = function ()
			end
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.id_ = slot1
	slot0.isMember_ = slot2
	slot4 = nil

	if slot2 then
		if GuildData:GetGuildInfo().post == GuildConst.GUILD_POST.CAPTAIN then
			if GuildData:GetGuildMemberData(slot1).id == USER_ID then
				if slot5.impeachTime - manager.time:GetServerTime() > 0 then
					slot0.buttonController_:SetSelectedState("impeach")
				else
					slot0.buttonController_:SetSelectedState("null")
				end
			elseif slot4.post == GuildConst.GUILD_POST.TRAINEE then
				slot0.buttonController_:SetSelectedState("remove")
			else
				slot0.buttonController_:SetSelectedState("captain")
			end
		elseif slot5.post == GuildConst.GUILD_POST.DEPUTY then
			if slot4.id == USER_ID or slot4.post == GuildConst.GUILD_POST.DEPUTY then
				slot0.buttonController_:SetSelectedState("null")
			elseif slot4.post == GuildConst.GUILD_POST.CAPTAIN then
				if slot5.impeachTime - manager.time:GetServerTime() > 0 then
					if slot5.isCandidate then
						slot0.buttonController_:SetSelectedState("applied")
					else
						slot0.buttonController_:SetSelectedState("impeaching")
					end
				elseif manager.time:GetServerTime() > GuildData:GetCaptainOfflineTime() + 864000 then
					slot0.buttonController_:SetSelectedState("deputy")
				else
					slot0.buttonController_:SetSelectedState("null")
				end
			else
				slot0.buttonController_:SetSelectedState("remove")
			end
		elseif slot4.post == GuildConst.GUILD_POST.CAPTAIN then
			if slot5.impeachTime - manager.time:GetServerTime() > 0 then
				if slot5.isCandidate then
					slot0.buttonController_:SetSelectedState("applied")
				else
					slot0.buttonController_:SetSelectedState("impeaching")
				end
			elseif manager.time:GetServerTime() > GuildData:GetCaptainOfflineTime() + 864000 then
				slot0.buttonController_:SetSelectedState("deputy")
			else
				slot0.buttonController_:SetSelectedState("null")
			end
		else
			slot0.buttonController_:SetSelectedState("null")
		end

		if slot3 == GuildConst.MEMBER_LIST_TYPE.MEMBER then
			slot0.memberController_:SetSelectedState("member")
		else
			slot0.memberController_:SetSelectedState("controubite")
		end
	else
		slot0.memberController_:SetSelectedState("run")

		slot4 = GuildData:GetGuildRequestData(slot1)

		slot0.buttonController_:SetSelectedState("request")
	end

	slot0.imageIcon_.sprite = ItemTools.getItemSprite(slot4.icon)
	slot0.imageHeadBg_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot4.frame)
	slot0.textName_.text = GetI18NText(slot4.name)
	slot0.textLevel_.text = GetTips("LEVEL") .. string.format("%s", slot4.level)
	slot0.textContribute_.text = GetI18NText(slot4.weekContribute)

	if slot3 == GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE then
		slot0.textContribute_.text = GetI18NText(slot4.contribute)
	end

	if slot4.offlineStamptime == 0 then
		slot0.textOnline_.text = manager.time:GetOnLineText(slot4.offlineStamptime)

		slot0.onlineController:SetSelectedState("yes")
	else
		slot0.textOnline_.text = manager.time:GetOnLineText(slot4.offlineStamptime)

		slot0.onlineController:SetSelectedState("no")
	end

	if slot4.post == GuildConst.GUILD_POST.CAPTAIN then
		slot0.labelText_.text = GetTips("CLUB_CHAIR_MAN")

		slot0.postController_:SetSelectedState("CAPTAIN")
	elseif slot4.post == GuildConst.GUILD_POST.DEPUTY then
		slot0.labelText_.text = GetTips("CLUB_VICE_CHAIR_MAN")

		slot0.postController_:SetSelectedState("DEPUTY")
	elseif slot4.post == GuildConst.GUILD_POST.MEMBER then
		slot0.labelText_.text = GetTips("CLUB_MEMBER")

		slot0.postController_:SetSelectedState("MEMBER")
	elseif slot4.post == GuildConst.GUILD_POST.TRAINEE then
		slot0.labelText_.text = GetTips("CLUB_NOVICIATE")

		slot0.postController_:SetSelectedState("TRAINEE")
	end
end

function slot0.RefreshTimer(slot0)
	if slot0.isMember_ then
		if GuildData:GetGuildInfo().post == GuildConst.GUILD_POST.CAPTAIN then
			if GuildData:GetGuildMemberData(slot0.id_).id == USER_ID and slot1.impeachTime - manager.time:GetServerTime() > 0 then
				slot0:CalTimer()
			end
		elseif slot1.post == GuildConst.GUILD_POST.DEPUTY then
			if slot2.id == USER_ID or slot2.post == GuildConst.GUILD_POST.DEPUTY then
				slot0.buttonController_:SetSelectedState("null")
			elseif slot2.post == GuildConst.GUILD_POST.CAPTAIN and slot1.impeachTime - manager.time:GetServerTime() > 0 then
				if slot1.isCandidate then
					slot0.buttonController_:SetSelectedState("applied")
				else
					slot0.buttonController_:SetSelectedState("impeaching")
				end

				slot0:CalTimer()
			end
		elseif slot2.post == GuildConst.GUILD_POST.CAPTAIN and slot1.impeachTime - manager.time:GetServerTime() > 0 then
			if slot1.isCandidate then
				slot0.buttonController_:SetSelectedState("applied")
			else
				slot0.buttonController_:SetSelectedState("impeaching")
			end

			slot0:CalTimer()
		end
	end
end

function slot0.CalTimer(slot0)
	slot1 = GuildData:GetGuildInfo()
	slot0.textCountdown_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:DescCDTime(slot1.impeachTime - manager.time:GetServerTime(), "%H:%M:%S"))
	slot2 = slot1.impeachTime - manager.time:GetServerTime()
	slot0.textCountdown_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:DescCDTime(slot2, "%H:%M:%S"))

	if slot2 <= 0 then
		GuildAction.RequiredGuildMemberList(function (slot0)
			if isSuccess(slot0) then
				manager.notify:Invoke(GUILD_CAPTAIN_IMPEACH)
			end
		end)
	end
end

return slot0
