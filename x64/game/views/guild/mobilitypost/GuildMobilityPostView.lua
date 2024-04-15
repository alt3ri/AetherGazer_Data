slot0 = class("GuildMobilityPostView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Club/ClubMobilityPostPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot0.memberID_ = slot0.params_.memberID

	slot0:RefreshPlayerInfo()

	if GuildData:GetGuildMemberData(slot0.memberID_).post == GuildConst.GUILD_POST.DEPUTY then
		slot0.mobilityDeputyText_.text = GetTips("ERROR_CLUB_VICE_CHAIRMAN_CANCEL")
	else
		slot0.mobilityDeputyText_.text = GetTips("ERROR_CLUB_VICE_CHAIRMAN_APPOINT")
	end
end

function slot0.RefreshPlayerInfo(slot0)
	slot1 = GuildData:GetGuildMemberData(slot0.memberID_)
	slot0.nameText_.text = slot1.name
	slot0.headImg_.sprite = ItemTools.getItemSprite(slot1.icon)
	slot0.frameImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot1.frame)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonMobilityCaptain_, nil, function ()
		ShowMessageBox({
			isTop = true,
			content = string.format(GetTips("CLUB_MOBILITY_CAPTAIN"), GuildData:GetGuildMemberData(uv0.memberID_).name),
			OkCallback = function ()
				GuildAction.GuildMobilityCaptain(uv0.memberID_, function (slot0)
					if not isSuccess(slot0.result) then
						ShowTips(slot0.result)
					end

					uv0:Go("/guildEntrace/guildMain")
				end)
			end,
			CancelCallback = function ()
			end
		})
	end)
	slot0:AddBtnListener(slot0.buttonMobilityDeputy_, nil, function ()
		if GuildData:GetGuildMemberData(uv0.memberID_).post == GuildConst.GUILD_POST.DEPUTY then
			ShowMessageBox({
				isTop = true,
				content = string.format(GetTips("CLUB_DISMISS"), GuildData:GetGuildMemberData(uv0.memberID_).name),
				OkCallback = function ()
					GuildAction.GuildDismiss(uv0.memberID_, function (slot0)
						if not isSuccess(slot0.result) then
							ShowTips(slot0.result)
						end

						uv0:Back()
					end)
				end,
				CancelCallback = function ()
				end
			})
		else
			ShowMessageBox({
				isTop = true,
				content = string.format(GetTips("CLUB_MOBILITY_DEPUTY"), GuildData:GetGuildMemberData(uv0.memberID_).name),
				OkCallback = function ()
					GuildAction.GuildMobilityDeputy(uv0.memberID_, function (slot0)
						if not isSuccess(slot0.result) then
							ShowTips(slot0.result)
						end

						uv0:Back()
					end)
				end,
				CancelCallback = function ()
				end
			})
		end
	end)
end

return slot0
