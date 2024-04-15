slot0 = class("GuildRecommendView", ReduxView)
slot1 = 10

function slot0.UIName(slot0)
	return "Widget/System/Club/ClubFoundedUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.recommendUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, GuildRecommendItem)
	slot0.clubController_ = slot0.controller:GetController("None")
	slot0.btnComtroller = slot0.controller:GetController("btn")
	slot0.emptytroller = slot0.controller:GetController("descEmpty")
end

function slot0.OnEnter(slot0)
	slot0:AddRefreshStamptime()
	slot0:RefreshScroll()
	slot0:RegisterEvent()
end

function slot0.OnTop(slot0)
	slot0:RefreshWinBar()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:StopRefreshStamptime()
	slot0:RemoveAllEventListener()
end

function slot0.RefreshWinBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:RegistBackCallBack(function ()
		uv0:Back(2)
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.recommendUIList_ then
		slot0.recommendUIList_:Dispose()

		slot0.recommendUIList_ = nil
	end
end

function slot0.RegisterEvent(slot0)
	slot0:RegistEventListener(GUILD_RECOMMEND_CLICK, handler(slot0, slot0.ClickRecommendItem))
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonSearch_, nil, function ()
		if uv0.inputField_.text == "" then
			return
		end

		if tonumber(uv0.inputField_.text) == nil or slot0 < 0 then
			uv0.inputField_.text = ""

			return ShowTips("ERROR_CLUB_NOT_EXIST")
		end

		GuildAction.SearchGuild(tonumber(uv0.inputField_.text), function (slot0)
			if isSuccess(slot0.result) then
				ShowTips(slot0.result)

				uv0.searchFlag_ = true
				uv0.inputField_.text = ""

				uv0:RefreshScroll()
			else
				ShowTips(slot0.result)
			end
		end)
	end)
	slot0:AddBtnListener(slot0.buttonRefresh_, nil, function ()
		uv0:ClickRefreshBtn()
	end)
	slot0:AddBtnListener(slot0.buttonJoin_, nil, function ()
		if OperationData:IsFunctionStoped(OperationConst.OPERATION_STOP.JOIN_CLUB) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		SDKTools.SendMessageToSDK("club_member_manage_jump", {
			source = 3
		})
		GuildAction.GuildRequestJoin(uv0:GetItemData()[uv0.selectIndex_].id, function (slot0)
			GuildData:AddJoinData(uv0.id)
			uv1:RefreshInfo()
		end)
	end)
	slot0:AddBtnListener(slot0.foundBtn, nil, function ()
		JumpTools.OpenPageByJump("guildFoundedView")
	end)
	slot0:AddBtnListener(slot0.copyIDBtn, nil, function ()
		slot0 = uv0:GetItemData()

		if uv0.selectIndex_ and slot0[uv0.selectIndex_] then
			UnityEngine.GUIUtility.systemCopyBuffer = slot0[uv0.selectIndex_].id

			ShowTips("COPY_SUCCESS")
		end
	end)
end

function slot0.ClickRefreshBtn(slot0)
	if manager.time:GetServerTime() < GuildData:GetRecommendRefreshStamptime() + uv0 then
		return
	end

	GuildAction.RequiredGuildRecommendList(function (slot0)
		if isSuccess(slot0.result) then
			GuildData:SetRecommendRefreshStamptime()

			uv0.searchFlag_ = false

			uv0:AddRefreshStamptime()
			uv0:RefreshScroll()
		else
			ShowTips(slot0.result)
		end
	end)
end

function slot0.RefreshScroll(slot0)
	slot0.selectIndex_ = 1

	if #slot0:GetItemData() <= 0 then
		slot0.clubController_:SetSelectedState("false")
	else
		slot0.clubController_:SetSelectedState("true")
	end

	slot0.recommendUIList_:StartScroll(#slot1, slot0.selectIndex_)
	slot0:RefreshInfo()
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0:GetItemData()[slot1], slot1 == slot0.selectIndex_)
end

function slot0.ClickRecommendItem(slot0, slot1)
	slot0.selectIndex_ = slot1

	slot0:RefreshInfo()
end

function slot0.RefreshInfo(slot0)
	if slot0:GetItemData()[slot0.selectIndex_] == nil then
		return
	end

	slot0.textName_.text = GetI18NText(slot2.name)
	slot0.textMember_.text = string.format("%s/%s", slot2.member, slot2.maxMemberCnt)
	slot0.textLevel_.text = string.format(GetTips("CLUB_LEVEL"), slot2.level)
	slot0.textContribute_.text = GetI18NText(slot2.contribute)
	slot0.textID_.text = slot2.id

	if slot2.notice and slot2.notice ~= "" then
		slot0.emptytroller:SetSelectedState("full")

		slot0.textNotice_.text = GetI18NText(slot2.notice)
	else
		slot0.emptytroller:SetSelectedState("empty")
	end

	slot0.imageIcon_.sprite = getSpriteViaConfig("ClubHeadIcon", ClubHeadIconCfg[slot2.icon].icon_bg)

	slot0:RefreshBtnState()
end

function slot0.RefreshBtnState(slot0)
	if slot0:GetItemData()[slot0.selectIndex_] == nil then
		return
	end

	slot0.btnComtroller:SetSelectedState("can")

	if OperationData:IsFunctionStoped(OperationConst.OPERATION_STOP.JOIN_CLUB) then
		slot0.btnComtroller:SetSelectedState("no")

		return
	end

	if slot2.is_requested and slot2.is_requested == 1 then
		slot0.btnComtroller:SetSelectedState("had")

		return
	end
end

function slot0.GetItemData(slot0)
	if slot0.searchFlag_ then
		return GuildData:GetSearchList()
	else
		return GuildData:GetRecommendList()
	end
end

function slot0.AddRefreshStamptime(slot0)
	slot0:RefreshCDText()
	slot0:StopRefreshStamptime()

	slot0.refreshTimer_ = Timer.New(function ()
		uv0:RefreshCDText()
	end, 1, -1)

	slot0.refreshTimer_:Start()
end

function slot0.RefreshCDText(slot0)
	if GuildData:GetRecommendRefreshStamptime() + uv0 - manager.time:GetServerTime() > 0 then
		slot0.textRefresh_.text = string.format("%s(%sS)", GetTips("CLUB_REFRES_TEXT"), slot3)
	else
		slot0:StopRefreshStamptime()

		slot0.textRefresh_.text = slot2
	end
end

function slot0.StopRefreshStamptime(slot0)
	if slot0.refreshTimer_ then
		slot0.refreshTimer_:Stop()

		slot0.refreshTimer_ = nil
	end
end

return slot0
