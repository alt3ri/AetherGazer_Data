slot0 = class("CommunityWelfareView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Club/ClubWelfarePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.tree_ = LuaTree.New(slot0.goTree_)

	slot0.tree_:SetSelectedHandler(handler(slot0, slot0.OnGroupSelect), nil)

	slot0.CommunityCon_ = slot0.controller:GetController("community")
	slot0.welfareCon_ = slot0.controller:GetController("welfare")
	slot0.welfare_ = CommonItemView.New(slot0.commonItemGo_)
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	if slot1 == slot0.pageIndex and not slot0.enterflag then
		return
	end

	slot0.pageIndex = slot1

	slot0:RefreshView()
end

function slot0.RefreshView(slot0)
	if slot0.pageIndex == GuildConst.WELFARE_TYPE.COMMON then
		slot0:RefreshWelfare(GameSetting.club_welfare.value[1])

		slot0.tittleText_.text = ItemCfg[GameSetting.club_welfare.value[1]].name
	elseif slot0.pageIndex == GuildConst.WELFARE_TYPE.DEEP then
		slot0:RefreshWelfare(GameSetting.club_special_welfare.value[1])

		slot0.tittleText_.text = ItemCfg[GameSetting.club_special_welfare.value[1]].name
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.openBtn_, nil, function ()
		if GameSetting.club_welfare_cost.value[1] <= CommunityData:GetCurrenyA() then
			CommunityAction:OpenWelfare()
		else
			ShowTips("ERROR_CLUB_COIN_NO_ENOUGH")
		end
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if uv0.identity_ == CommunityConst.MEMBER_TYPE.NEWBIE or uv0.identity_ == CommunityConst.MEMBER_TYPE.STRANGER then
			ShowTips("ERROR_CLUB_REWARD_ONLY_FORMAT_RECEIVE")
		else
			CommunityAction:ReceiveWelfare()
		end
	end)
	slot0:AddBtnListener(slot0.deepBtn, nil, function ()
		if CommunityData:GetWelfareExchangeCnt() <= 0 then
			ShowTips("EXCEED_MAX_CNT")

			return
		end

		JumpTools.OpenPageByJump("communitySpecialWelfareShop")
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:RestoreBar()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.enterflag = true

	slot0:SaveBar()
	CommunityAction:RefreshCurrencyA()
	slot0.tree_:SelectGroup(GuildConst.WELFARE_TYPE.COMMON)

	slot0.enterflag = false
end

function slot0.SaveBar(slot0)
	slot0.lastHomeFunc_ = manager.windowBar:GetLastHomeFunc()
	slot0.lastBackFunc_ = manager.windowBar:GetLastBackFunc()
	slot0.lastInfoFunc_ = manager.windowBar:GetLastInfoFunc()
	slot0.lastBarList_ = manager.windowBar:GetLastBarList()
	slot0.lastAddBarList_ = manager.windowBar:GetLastAddBarList()
	slot0.lastCanClickBarList_ = manager.windowBar:GetLastCanClickBarList()
end

function slot0.RefreshMemberTypeUI(slot0)
	manager.windowBar:SetAsLastSibling()

	slot0.identity_ = CommunityData:GetIdentity()
	slot0.welfareType_ = CommunityData:GetWelfareType()

	if slot0.identity_ == CommunityConst.MEMBER_TYPE.HEAD or slot0.identity_ == CommunityConst.MEMBER_TYPE.DEPUTY then
		slot0.openBtn_.interactable = true

		slot0.CommunityCon_:SetSelectedState("type1")
		slot0:RefreshType1Bar()
	elseif slot0.identity_ == CommunityConst.MEMBER_TYPE.MEMBER or slot0.identity_ == CommunityConst.MEMBER_TYPE.NEWBIE or slot0.identity_ == CommunityConst.MEMBER_TYPE.STRANGER then
		slot0.openBtn_.interactable = false

		slot0.CommunityCon_:SetSelectedState("type2")
		slot0:RefreshType2Bar()
	else
		print("暂未设计")
	end
end

function slot0.RefreshType1Bar(slot0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)
end

function slot0.RefreshType2Bar(slot0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)
end

function slot0.RefreshCost(slot0)
	if slot0.pageIndex == GuildConst.WELFARE_TYPE.COMMON then
		slot0.priceImg_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A)

		if GameSetting.club_welfare_cost.value[1] <= CommunityData:GetCurrenyA() then
			slot0.cost_.text = "<color='#28282B'>X" .. slot1 .. "</color>"
		else
			slot0.cost_.text = "<color='#FF0000'>X" .. slot1 .. "</color>"
		end

		SetActive(slot0.descText_.gameObject, true)
	elseif slot0.pageIndex == GuildConst.WELFARE_TYPE.DEEP then
		slot0.tipsText_.text = string.format("%s%d/%d", GetTips("LIMIT_WEEK"), math.abs(CommunityData:GetWelfareExchangeCnt() - GameSetting.club_special_reward_buy_limit_weekly.value[1]), GameSetting.club_special_reward_buy_limit_weekly.value[1])

		SetActive(slot0.descText_.gameObject, false)
	end
end

function slot0.RefreshWelfare(slot0, slot1)
	slot0:RefreshMemberTypeUI()
	slot0:RefreshItem(slot1)
	slot0:RefreshBtnState()
	slot0:RefreshCost()
end

function slot0.RefreshBtnState(slot0)
	if slot0.pageIndex == GuildConst.WELFARE_TYPE.COMMON then
		if slot0.welfareType_ == CommunityConst.WELFARE_TYPE.CLOSE then
			if slot0.identity_ == CommunityConst.MEMBER_TYPE.HEAD or slot0.identity_ == CommunityConst.MEMBER_TYPE.DEPUTY then
				slot0.welfareCon_:SetSelectedState("close")
			else
				slot0.welfareCon_:SetSelectedState("lock")
			end
		elseif slot0.welfareType_ == CommunityConst.WELFARE_TYPE.RECEIVE then
			slot0.receiveBtn_.interactable = true

			slot0.welfareCon_:SetSelectedState("receive")
		elseif slot0.welfareType_ == CommunityConst.WELFARE_TYPE.FINISH then
			slot0.receiveBtn_.interactable = false

			slot0.welfareCon_:SetSelectedState("finish")
		else
			print("暂未设计")
		end
	elseif slot0.pageIndex == GuildConst.WELFARE_TYPE.DEEP then
		if CommunityData:GetWelfareExchangeCnt() > 0 then
			slot0.welfareCon_:SetSelectedState("buyDeep")
		else
			slot0.welfareCon_:SetSelectedState("buyMax")
		end
	end
end

function slot0.RefreshItem(slot0, slot1)
	slot0.welfare_:SetData({
		id = slot1,
		clickFun = function (slot0)
			ShowPopItem(POP_ITEM, {
				slot0.id
			})
		end
	})
end

function slot0.RestoreBar(slot0)
	slot4 = slot0.lastBarList_

	manager.windowBar:SwitchBar(slot4)

	for slot4, slot5 in ipairs(slot0.lastAddBarList_) do
		manager.windowBar:SetBarCanAdd(slot5, true)
	end

	for slot4, slot5 in ipairs(slot0.lastCanClickBarList_) do
		manager.windowBar:SetBarCanClick(slot5, true)
	end

	manager.windowBar:RegistHomeCallBack(slot0.lastHomeFunc_)
	manager.windowBar:RegistBackCallBack(slot0.lastBackFunc_)
	manager.windowBar:RegistInfoCallBack(slot0.lastInfoFunc_)
end

function slot0.OnReceiveWelfare(slot0)
	slot0:RefreshView()
end

function slot0.OnRefreshWelfare(slot0)
	slot0:RefreshView()
end

function slot0.OnExit(slot0)
	slot0.lastHomeFunc_ = nil
	slot0.lastBackFunc_ = nil
	slot0.lastInfoFunc_ = nil
	slot0.lastBarList_ = nil
	slot0.lastAddBarList_ = nil
	slot0.lastCanClickBarList_ = nil
end

function slot0.OnExitInput(slot0)
	JumpTools.Back()

	return true
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.welfare_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
