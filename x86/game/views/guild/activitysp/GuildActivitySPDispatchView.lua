slot0 = class("GuildActivitySPDispatchView", ReduxView)

function slot0.UIName(slot0)
	return "UI/GuildActivitySPUI/GuildActivitySPDispatchUI"
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

	slot0.eliteController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "elite")
	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListGo_, GuildActivitySPDispatchItemView)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetSelectHandler(handler(slot0, slot0.OnItemSelect))
	slot2:SetData(slot1, slot0.allCatIds_[slot1], slot0.params_.nodeId)
	slot2:SetSelect(slot0.selectedIndex_ ~= nil and slot1 == slot0.selectedIndex_)
end

function slot0.OnItemSelect(slot0, slot1, slot2)
	slot4 = nil

	if not table.indexof(GuildActivitySPData:GetCanDispatchCatList(), slot0.allCatIds_[slot1]) then
		for slot10, slot11 in ipairs(ActivityClubSPLevelSettingCfg.all) do
			if table.indexof(ActivityClubSPLevelSettingCfg[slot11].dispatch, slot3) then
				ShowTips(string.format(GetTips("ACTIVITY_CLUB_FIGHT_MEMBER_LOCK_TIP"), tostring(slot12.user_level)))

				return
			end
		end
	end

	if slot4 == slot2 then
		return
	end

	if GuildActivitySPData:IsDispatchMax(slot2) then
		ShowTips("ACTIVITY_CLUB_SP_DISPATCH_MAX")

		return
	end

	if GuildActivitySPData:IsCatDispatched(slot3) then
		ShowMessageBox({
			content = string.format(GetTips("ACTIVITY_CLUB_SP_REDISPATCH_CONFIRM_TIP"), ChipCfg[slot3].suit_name),
			OkCallback = function ()
				GuildActivitySPAction.Dispatch(uv0, uv1)
			end,
			CancelCallback = function ()
			end
		})
	else
		GuildActivitySPAction.Dispatch(slot2, slot3)
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(GUILD_ACTIVITY_SP_DISPATCHED, function (slot0, slot1)
		ShowTips("CANTEEN_TASK_DISPATCH")
		uv0:Back()
	end)
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

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.allCatIds_ = GuildActivitySPData:GetAllDispatchCatList()

	slot0.uiList_:StartScroll(#slot0.allCatIds_)
	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.UpdateView(slot0)
	slot1 = ActivityClubSPCfg[slot0.params_.nodeId]
	slot0.levelLabel_.text = "Lv." .. slot1.level
	slot0.recoverLabel_.text = "+" .. slot1.token_get
	slot0.gridName.text = GetTips(GuildActivitySPConst.NodeType[slot1.type])
	slot0.cuyImg.sprite = ItemTools.getItemSprite(tonumber(GuildActivitySpTools.GetCurCurrencyID(GuildActivitySPData:GetCurMainActivityID(), 1)))
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
