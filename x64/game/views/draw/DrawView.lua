local var_0_0 = class("DrawView", ReduxView)
local var_0_1 = {
	"DRAW_POOL_TYPE_6",
	"DRAW_POOL_TYPE_3",
	"DRAW_POOL_TYPE_7",
	"DRAW_POOL_TYPE_8",
	"DRAW_POOL_TYPE_1",
	"DRAW_POOL_TYPE_2"
}
local var_0_2 = {
	5,
	6,
	2,
	nil,
	5,
	1,
	3,
	4
}
local var_0_3 = {
	[1] = "90",
	[4] = "40"
}
local var_0_4 = {
	[200003] = "WEAPON_DRAW_POOL_RACE_3",
	[200001] = "WEAPON_DRAW_POOL_RACE_1",
	[200009] = "WEAPON_DRAW_POOL_RACE_9",
	[200005] = "WEAPON_DRAW_POOL_RACE_5",
	[200004] = "WEAPON_DRAW_POOL_RACE_4",
	[200002] = "WEAPON_DRAW_POOL_RACE_2"
}

function var_0_0.OnCtor(arg_1_0)
	arg_1_0.moviePaths = {
		"SofdecAsset/function/blue.usm",
		"SofdecAsset/function/purple.usm",
		"SofdecAsset/function/glod.usm"
	}
end

function var_0_0.UIName(arg_2_0)
	return "Widget/System/Pool/PoolUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0.poolToggles_ = {}
	arg_4_0.poolObjects_ = {}
	arg_4_0.poolActivitys_ = {}
	arg_4_0.groupRedPoint = {}
	arg_4_0.drawHandler_ = handler(arg_4_0, arg_4_0.DrawCheck)

	arg_4_0:InitUI()
	arg_4_0:AddUIListener()

	arg_4_0.currencyModifyHandler_ = handler(arg_4_0, arg_4_0.CurrencyModify)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.criMovie_ = arg_5_0.movie_:GetComponent("CriManaMovieControllerForUI")
	arg_5_0.criplayer_ = arg_5_0.criMovie_.player

	arg_5_0.criMovie_:Stop()

	arg_5_0.moviePlaying = false

	SetActive(arg_5_0.movieGo_, false)

	arg_5_0.drawInteract = arg_5_0.drawInteractGo_:GetComponent("DrawController")

	SetActive(arg_5_0.drawInteractGo_, false)

	arg_5_0.showRightController = ControllerUtil.GetController(arg_5_0.transform_, "showRight")
	arg_5_0.rechargeShopGiftController = ControllerUtil.GetController(arg_5_0.transform_, "recharge_shop_gift")
	arg_5_0.tree_ = LuaTree.New(arg_5_0.uitreeGo_)

	arg_5_0.tree_:SetSelectedHandler(handler(arg_5_0, arg_5_0.OnGroupSelect), handler(arg_5_0, arg_5_0.OnItemSelect))
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btnInfo_, nil, function()
		local var_7_0 = DrawPoolCfg[arg_6_0.selectPoolId_]

		if (var_7_0.pool_selected_type == 2 or var_7_0.pool_selected_type == 8) and DrawData:GetPollUpID(arg_6_0.selectPoolId_) == 0 then
			ShowTips("DRAW_NOT_SELECT_TIPS")

			return
		end

		if var_7_0.pool_selected_type == 9 and DrawData:GetPollUpID(arg_6_0.selectPoolId_) == 0 then
			ShowTips("DRAW_NOT_SELECT_WEAPON_TIPS")

			return
		end

		DrawAction.GetPoolData(arg_6_0.selectPoolId_)
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnRecord_, nil, function()
		JumpTools.OpenPageByJump("drawRecord", {
			poolId = arg_6_0.selectPoolId_
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnOnce_, nil, function()
		arg_6_0:DrawCheck(DrawConst.DRAW_TYPE.ONE)
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnTenth_, nil, function()
		if DrawPoolCfg[arg_6_0.selectPoolId_].pool_type == 8 then
			arg_6_0:DrawCheck(math.min(40 - DrawData:GetPoolDrawTimes(arg_6_0.selectPoolId_), 10))
		else
			arg_6_0:DrawCheck(DrawConst.DRAW_TYPE.TEN)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnSkip_, nil, function()
		manager.audio:PlayEffect("ui_system_search", "search_skip", "")
		arg_6_0:SkipMovie()
	end)
	arg_6_0:AddBtnListener(arg_6_0.chooseBtn_, nil, function()
		local var_12_0 = DrawPoolCfg[arg_6_0.selectPoolId_]

		if var_12_0.pool_selected_type == 2 then
			arg_6_0:Go("/drawAllHeroSelect", {
				isFirst = true,
				poolId = arg_6_0.selectPoolId_,
				heroIdList = var_12_0.optional_detail
			})
		elseif var_12_0.pool_selected_type == 8 then
			local var_12_1 = DrawPoolCfg[arg_6_0.selectPoolId_]
			local var_12_2 = table.indexof(var_12_1.optional_lists_poolId, arg_6_0.showId)
			local var_12_3 = var_12_1.optional_detail[var_12_2]

			arg_6_0:Go("/newbieDrawHeroSelect", {
				poolId = arg_6_0.selectPoolId_,
				heroIdList = var_12_1.optional_detail,
				heroId = var_12_3
			})
		elseif var_12_0.pool_selected_type == 9 then
			arg_6_0:Go("/drawSelect", {
				poolID = arg_6_0.selectPoolId_
			})
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.skipInteractBtn_, nil, function()
		manager.audio:PlayEffect("ui_system_search", "search_skip", "")
		arg_6_0:SkipInteract()
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_giftBtn, nil, function()
		local var_14_0 = DrawPoolCfg[arg_6_0.selectPoolId_]
		local var_14_1 = 0

		if var_14_0.pool_type == 3 then
			var_14_1 = 1
		elseif var_14_0.pool_type == 1 then
			var_14_1 = 2
		elseif var_14_0.pool_type == 2 then
			var_14_1 = 3
		elseif var_14_0.pool_type == 6 then
			var_14_1 = 4
		end

		if var_14_1 ~= 0 then
			OperationRecorder.RecordButtonTouch("draw_gifts_type" .. var_14_1)
		end

		JumpTools.OpenPageByJump("rechargeDrawGift", {
			poolId = arg_6_0.selectPoolId_
		})
	end)
end

function var_0_0.OnTop(arg_15_0)
	arg_15_0:StopMovie()
	arg_15_0:ShowBar()
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0:SetupActivityPool()

	if arg_16_0.params_.poolType then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0.poolToggles_) do
			if DrawPoolCfg[iter_16_1].pool_type == arg_16_0.params_.poolType then
				arg_16_0.params_.poolId = iter_16_1
				arg_16_0.params_.poolType = nil
			end
		end
	end

	local var_16_0 = arg_16_0.enterPoolId

	if arg_16_0.params_.poolId then
		local var_16_1 = arg_16_0.poolActivitys_[arg_16_0.params_.poolId]

		if var_16_1 and ActivityData:GetActivityIsOpen(var_16_1) then
			var_16_0 = arg_16_0.params_.poolId
		end
	end

	arg_16_0.tree_.tree_.data.groupDatas[arg_16_0.poolIDToIndexTable[var_16_0][1] - 1].defaultIndex = arg_16_0.poolIDToIndexTable[var_16_0][2] - 1

	arg_16_0.tree_:SelectItem(arg_16_0.poolIDToIndexTable[var_16_0][1], arg_16_0.poolIDToIndexTable[var_16_0][2])
	DrawTools:LoadDrawLevel()
	manager.ui:SetMainCamera("draw")

	arg_16_0.panel_.transform.localPosition = Vector2(0, 0)

	manager.notify:RegistListener(CURRENCY_UPDATE, arg_16_0.currencyModifyHandler_)
end

function var_0_0.OnExit(arg_17_0)
	manager.notify:RemoveListener(CURRENCY_UPDATE, arg_17_0.currencyModifyHandler_)

	if arg_17_0.selectPoolId_ and arg_17_0.selectPoolId_ ~= 0 and arg_17_0.selectPoolId_ ~= -1 and manager.net ~= nil and manager.net.tcpConnection_ ~= nil then
		local var_17_0 = manager.net.tcpConnection_:GetMachineState()

		if var_17_0 and (var_17_0 == "connected" or var_17_0 == "connecting") then
			arg_17_0:HidePoolNewTag(arg_17_0.selectPoolId_, true)
		end
	end

	manager.windowBar:HideBar()
	arg_17_0:StopMovie()
	arg_17_0.criMovie_:Stop()

	if arg_17_0.curPoolObject then
		arg_17_0.curPoolObject:SetActive(false)
	end

	arg_17_0.curPoolObject = nil
	arg_17_0.selectPoolId_ = -1
	arg_17_0.one_cost_type = nil
	arg_17_0.ten_cost_type = nil

	if arg_17_0.interactTimer then
		arg_17_0.interactTimer:Stop()

		arg_17_0.interactTimer = nil
	end

	manager.ui:SetMainCameraCom("CinemachineBrain", false)
	arg_17_0:RemoveCountDownTimer()
	DrawTools:UnLoadDrawLevel()
end

function var_0_0.InitTree(arg_18_0)
	local var_18_0 = UITreeData.New()
	local var_18_1 = {}

	arg_18_0.poolIDToIndexTable = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.poolToggles_) do
		local var_18_2 = DrawPoolCfg[iter_18_1]
		local var_18_3 = var_0_2[var_18_2.pool_show_type]

		if var_18_1[var_18_3] == nil then
			var_18_1[var_18_3] = 1
		end

		arg_18_0.poolIDToIndexTable[iter_18_1] = {
			var_18_3,
			var_18_1[var_18_3]
		}
		var_18_1[var_18_3] = var_18_1[var_18_3] + 1
	end

	local var_18_4 = {}
	local var_18_5 = 1

	for iter_18_2 = 1, 8 do
		if var_18_1[iter_18_2] then
			var_18_4[iter_18_2] = var_18_5
			var_18_5 = var_18_5 + 1
		end
	end

	local var_18_6 = {}

	for iter_18_3, iter_18_4 in ipairs(var_0_1) do
		var_18_6[iter_18_3] = UITreeGroupData.New()
		var_18_6[iter_18_3].text = GetTips(iter_18_4)
	end

	for iter_18_5, iter_18_6 in ipairs(arg_18_0.poolToggles_) do
		local var_18_7 = DrawPoolCfg[iter_18_6]
		local var_18_8 = var_0_2[var_18_7.pool_show_type]

		arg_18_0.poolIDToIndexTable[iter_18_6][1] = var_18_4[var_18_8]
		var_18_6[var_18_8].id = var_18_4[var_18_8]

		local var_18_9 = UITreeItemData.New()

		var_18_9.id = var_18_7.id
		var_18_9.text = GetI18NText(var_18_7.name)

		if var_18_7.pool_show_type == 2 then
			local var_18_10 = DrawData:GetPollUpID(iter_18_6)

			var_18_9.text = GetI18NText(var_18_7.name)

			if var_18_10 ~= 0 then
				var_18_9.text = GetTips(var_0_4[var_18_10])
			end
		elseif var_18_7.pool_show_type == 8 or var_18_7.pool_show_type == 3 and var_18_7.pool_selected_type == 2 then
			local var_18_11 = DrawData:GetPollUpID(iter_18_6)

			var_18_9.text = GetI18NText(var_18_7.name)

			if var_18_11 ~= 0 then
				local var_18_12 = DrawData:ConvertUpId(iter_18_6, var_18_11, 0)

				var_18_9.text = HeroCfg[var_18_12].name or ""
			end
		end

		if arg_18_0.poolIDToIndexTable[iter_18_6][1] == 1 and arg_18_0.poolIDToIndexTable[iter_18_6][2] == 1 then
			arg_18_0.enterPoolId = iter_18_6
		end

		var_18_6[var_18_8].itemDatas:Add(var_18_9)
	end

	for iter_18_7 = 1, 6 do
		if var_18_6[iter_18_7].itemDatas.Count > 0 then
			var_18_0.groupDatas:Add(var_18_6[iter_18_7])
		end
	end

	arg_18_0.tree_:SetData(var_18_0)
end

function var_0_0.OnGroupSelect(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	arg_19_0.tree_.tree_.data.groupDatas[arg_19_1 - 1].defaultIndex = 0
end

function var_0_0.OnItemSelect(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	arg_20_0:HidePoolNewTag(arg_20_2)
	arg_20_0:SetSelectPool(arg_20_2)

	local var_20_0 = DrawPoolCfg[arg_20_2]

	SetActive(arg_20_0.upArrowGo_, false)
	SetActive(arg_20_0.upTargetTipsGo_, false)

	local var_20_1 = var_0_2[var_20_0.pool_show_type]

	if var_20_1 == 1 then
		arg_20_0.ALevelTips_.text = GetTips("DRAW_POOL_PROBABILITY_A_4")
		arg_20_0.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_5")
	elseif var_20_1 == 2 then
		arg_20_0.ALevelTips_.text = GetTips("DRAW_POOL_PROBABILITY_A_4")
		arg_20_0.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
	elseif var_20_1 == 3 then
		arg_20_0.ALevelTips_.text = GetTips("DRAW_POOL_PROBABILITY_A_4")
		arg_20_0.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
	elseif var_20_1 == 4 then
		arg_20_0.ALevelTips_.text = GetTips("DRAW_POOL_PROBABILITY_A_4")
		arg_20_0.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_8")
	elseif var_20_1 == 5 then
		arg_20_0.ALevelTips_.text = GetTips("DRAW_POOL_PROBABILITY_A_4")
		arg_20_0.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
	elseif var_20_1 == 6 then
		arg_20_0.ALevelTips_.text = GetTips("DRAW_POOL_PROBABILITY_FOUR_WEAPON_4")
		arg_20_0.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_FIVE_WEAPON_4")
	end
end

function var_0_0.SetupActivityPool(arg_21_0)
	arg_21_0.poolToggles_ = {}

	local var_21_0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.DRAW] or {}

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if ActivityData:GetActivityIsOpen(iter_21_1) then
			local var_21_1 = ActivityDrawPoolCfg[iter_21_1]

			if var_21_1 then
				for iter_21_2, iter_21_3 in ipairs(var_21_1.config_list) do
					if DrawPoolCfg[iter_21_3].pool_show_type == 8 then
						if not DrawData:GetNewbieChooseDrawFlag() then
							table.insert(arg_21_0.poolToggles_, iter_21_3)

							arg_21_0.poolActivitys_[iter_21_3] = iter_21_1
						end
					else
						table.insert(arg_21_0.poolToggles_, iter_21_3)

						arg_21_0.poolActivitys_[iter_21_3] = iter_21_1
					end
				end
			end
		end
	end

	if #arg_21_0.poolToggles_ == 0 then
		Debugger.LogError("draw error pools is empty")
	end

	table.sort(arg_21_0.poolToggles_, function(arg_22_0, arg_22_1)
		return DrawPoolCfg[arg_22_0].order < DrawPoolCfg[arg_22_1].order
	end)
	arg_21_0:InitTree()
	arg_21_0:InitPoolNew()
end

function var_0_0.InitPoolNew(arg_23_0)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0.poolToggles_) do
		if DrawData:GetPoolIsNew(iter_23_1) == 1 then
			arg_23_0:SetNewTag(true, iter_23_1)
		end
	end
end

function var_0_0.HidePoolNewTag(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0.selectPoolId_ ~= -1 and arg_24_0.selectPoolId_ ~= nil and arg_24_0.selectPoolId_ ~= arg_24_1 and DrawData:GetPoolIsNew(arg_24_0.selectPoolId_) == 1 or arg_24_2 then
		DrawAction.HidePoolNewTag(arg_24_0.selectPoolId_, handler(arg_24_0, arg_24_0.SetNewTag))
	end
end

function var_0_0.SetNewTag(arg_25_0, arg_25_1, arg_25_2)
	if not arg_25_0.poolIDToIndexTable[arg_25_2] then
		return
	end

	if not arg_25_0.tree_ then
		return
	end

	local var_25_0 = arg_25_0.poolIDToIndexTable[arg_25_2][1]
	local var_25_1 = arg_25_0.poolIDToIndexTable[arg_25_2][2]
	local var_25_2 = arg_25_0.tree_:GetGroupRedPointContainerById(var_25_0)
	local var_25_3 = arg_25_0.tree_:GetItemRedPointContainerById(var_25_0, arg_25_2)

	if var_25_2 == nil or var_25_3 == nil then
		return
	end

	local var_25_4 = true

	if arg_25_1 then
		arg_25_0.groupRedPoint[var_25_0] = arg_25_0.groupRedPoint[var_25_0] or {}
		arg_25_0.groupRedPoint[var_25_0][var_25_1] = arg_25_2
	else
		arg_25_0.groupRedPoint[var_25_0][var_25_1] = nil

		if not next(arg_25_0.groupRedPoint[var_25_0]) then
			arg_25_0.groupRedPoint[var_25_0] = nil
		end

		if not next(arg_25_0.groupRedPoint) then
			manager.redPoint:setTip(RedPointConst.DRAW, 0, RedPointStyle.SHOW_NEW_TAG)

			arg_25_0.groupRedPoint = {}
		end
	end

	local var_25_5 = arg_25_0.groupRedPoint[var_25_0] and next(arg_25_0.groupRedPoint[var_25_0])

	manager.redPoint:setRedPoint({
		display = var_25_2
	}, var_25_5, RedPointStyle.SHOW_NEW_TAG)
	manager.redPoint:setRedPoint({
		display = var_25_3
	}, arg_25_1, RedPointStyle.SHOW_NEW_TAG)
end

function var_0_0.RefreshActivityPool(arg_26_0)
	arg_26_0:SetupActivityPool()

	if not table.indexof(arg_26_0.poolToggles_, arg_26_0.selectPoolId_) then
		arg_26_0.selectPoolId_ = arg_26_0.poolToggles_[1]

		arg_26_0:RefreshUI()
	end
end

function var_0_0.SetSelectPool(arg_27_0, arg_27_1)
	if not table.indexof(arg_27_0.poolToggles_, arg_27_1) then
		return
	end

	if arg_27_1 == arg_27_0.selectPoolId_ then
		return
	end

	arg_27_0.selectPoolId_ = arg_27_1
	arg_27_0.params_.poolId = arg_27_1

	arg_27_0:RefreshUI()
end

function var_0_0.ShowBar(arg_28_0)
	local var_28_0 = DrawTools.GetCostTicketList(arg_28_0.selectPoolId_)
	local var_28_1 = DrawTools.GetActivityCostTicket(arg_28_0.selectPoolId_)
	local var_28_2 = {
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	}

	if var_28_1 == 0 or ItemTools.IsItemExpiredByItemId(var_28_1) then
		for iter_28_0, iter_28_1 in ipairs(var_28_0) do
			table.insert(var_28_2, iter_28_1)
		end

		table.insertto(var_28_2, {
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})
		manager.windowBar:SwitchBar(var_28_2)
	elseif var_28_1 == InviteData:GetDataByPara("drawItemId") then
		for iter_28_2, iter_28_3 in ipairs(var_28_0) do
			table.insert(var_28_2, iter_28_3)
		end

		table.insertto(var_28_2, {
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})
		manager.windowBar:SwitchBar(var_28_2)
	else
		if ItemTools.getItemNum(var_28_1) > 0 then
			table.insert(var_28_2, var_28_1)
		end

		for iter_28_4, iter_28_5 in ipairs(var_28_0) do
			table.insert(var_28_2, iter_28_5)
		end

		table.insertto(var_28_2, {
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})
		manager.windowBar:SwitchBar(var_28_2)

		if ItemTools.getItemNum(var_28_1) > 0 then
			manager.windowBar:SetBarCanAdd(var_28_1, false)
			manager.windowBar:SetBarCanClick(var_28_1, true)
		end
	end

	manager.windowBar:RegistBackCallBack(function()
		DrawData:ResetServantRedPoint()
		arg_28_0:Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		DrawData:ResetServantRedPoint()
		gameContext:Go("/home", nil, nil, true)
	end)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)

	for iter_28_6, iter_28_7 in pairs(var_28_0) do
		manager.windowBar:SetBarCanAdd(iter_28_7, false)
		manager.windowBar:SetBarCanClick(iter_28_7, true)
	end
end

function var_0_0.RefreshUI(arg_31_0)
	local var_31_0 = arg_31_0.selectPoolId_
	local var_31_1 = DrawPoolCfg[var_31_0]
	local var_31_2 = var_31_0

	arg_31_0:UpdateFirstSelectButton(true)

	if var_31_1.pool_selected_type == 9 then
		local var_31_3 = DrawData:GetPollUpID(var_31_0)

		if var_31_3 == 0 then
			arg_31_0:UpdateFirstSelectButton(false)

			var_31_2 = -1
		else
			var_31_2 = var_31_3
		end
	elseif var_31_1.pool_selected_type == 2 or var_31_1.pool_selected_type == 8 then
		local var_31_4 = DrawData:GetPollUpID(var_31_0)

		if var_31_4 == 0 then
			local var_31_5 = var_31_1.pool_change
			local var_31_6 = DrawData:GetPoolUpTimes(var_31_0)

			if var_31_5 == 0 or var_31_6 < var_31_5 then
				arg_31_0.timer = TimeTools.StartAfterSeconds(0.1, function(arg_32_0)
					if DrawData:IsOnePrefabPool(arg_32_0) then
						if var_31_1.pool_selected_type == 2 then
							arg_31_0:UpdateFirstSelectButton(false)
						elseif var_31_1.pool_selected_type == 8 then
							arg_31_0:UpdateFirstSelectButton(false)
						end
					else
						arg_31_0:Go("/drawHeroSelect", {
							poolId = arg_31_0.selectPoolId_
						})
					end
				end, {
					var_31_0
				})
			end

			var_31_2 = -arg_31_0.selectPoolId_
		else
			var_31_2 = var_31_4
		end
	end

	if var_31_1.pool_type == 8 then
		arg_31_0.tenOneKeyGetText_.text = string.format(GetTips("DRAW_POOL_SCREEN_TYPE_2"), string.format(GetTips("NUM_" .. math.min(40 - DrawData:GetPoolDrawTimes(var_31_0), 10))))
		arg_31_0.tips3Text_.text = GetTips("DRAW_POOL_SCREEN_TYPE_3")
	else
		arg_31_0.tenOneKeyGetText_.text = string.format(GetTips("DRAW_POOL_SCREEN_TYPE_2"), GetTips("NUM_10"))
	end

	SetActive(arg_31_0.tips3Text_.gameObject, var_31_1.pool_type == 8)

	if var_31_1.pool_type == 8 then
		arg_31_0.tenIconText_.text = "x" .. math.min(40 - DrawData:GetPoolDrawTimes(var_31_0), 10)
	else
		arg_31_0.tenIconText_.text = "x10"
	end

	if var_31_1.pool_type ~= 1 then
		SetActive(arg_31_0.timeGo_, true)
	else
		SetActive(arg_31_0.timeGo_, not DrawData:GetIsFirstSSR())
	end

	if arg_31_0.curPoolObject then
		if arg_31_0.curPoolObject:GetShowId() == var_31_2 then
			arg_31_0.curPoolObject:Refresh(var_31_2)
			arg_31_0:RefreshRightPanel()

			return
		else
			arg_31_0.curPoolObject:SetActive(false)
		end
	end

	arg_31_0.showId = var_31_2

	if not arg_31_0.poolObjects_[var_31_2] then
		if var_31_1.pool_type == 1 then
			arg_31_0.poolObjects_[var_31_2] = DrawNormalPool.New(arg_31_0.poolcontentTrs_, var_31_0, var_31_2)
		elseif var_31_1.pool_selected_type == 2 or var_31_1.pool_selected_type == 8 then
			if DrawData:IsOnePrefabPool(var_31_0) then
				if var_31_1.pool_selected_type == 8 then
					arg_31_0.poolObjects_[var_31_2] = NewbieDrawSelectPool.New(arg_31_0.poolcontentTrs_, var_31_0, var_31_2)
				else
					arg_31_0.poolObjects_[var_31_2] = DrawSelectPool.New(arg_31_0.poolcontentTrs_, var_31_0, var_31_2)
				end
			else
				arg_31_0.poolObjects_[var_31_2] = DrawUpPool.New(arg_31_0.poolcontentTrs_, var_31_0, var_31_2)
			end
		elseif var_31_1.pool_selected_type == 9 then
			if DrawData:GetPollUpID(var_31_0) == var_31_2 then
				arg_31_0.poolObjects_[var_31_2] = DrawServantPool.New(arg_31_0.poolcontentTrs_, var_31_0, var_31_2)
			else
				arg_31_0.poolObjects_[var_31_2] = DrawServantNormalPool.New(arg_31_0.poolcontentTrs_, var_31_0, var_31_2)
			end
		else
			arg_31_0.poolObjects_[var_31_2] = DrawBasePool.New(arg_31_0.poolcontentTrs_, var_31_0, var_31_2)
		end
	end

	arg_31_0.curPoolObject = arg_31_0.poolObjects_[var_31_2]

	arg_31_0.curPoolObject:Refresh(var_31_2)
	arg_31_0.curPoolObject:SetActive(true)
	arg_31_0:OnRequestRecord()
	arg_31_0:RefreshRightPanel()

	local var_31_7 = arg_31_0.poolActivitys_[var_31_0]

	if var_31_7 and ActivityData:GetActivityData(var_31_7) then
		local var_31_8 = ActivityData:GetActivityData(var_31_7).stopTime

		arg_31_0:SetCountDown(true, var_31_8)
	else
		arg_31_0:SetCountDown(false)
	end

	arg_31_0:ShowBar()

	if #DrawTools.GetRechargeDrawGiftList(var_31_0) == 0 then
		arg_31_0.rechargeShopGiftController:SetSelectedIndex(0)
	else
		arg_31_0.rechargeShopGiftController:SetSelectedIndex(1)
	end

	arg_31_0:UpdateFreeDraw()
end

function var_0_0.OnRequestRecord(arg_33_0)
	local var_33_0 = DrawData:GetDrawRecord(arg_33_0.selectPoolId_)
	local var_33_1 = DrawPoolCfg[arg_33_0.selectPoolId_]

	if var_33_0 then
		local var_33_2 = var_33_0.ssr_draw_times
		local var_33_3 = var_0_2[var_33_1.pool_show_type]

		arg_33_0.drawTxt_.text = var_33_2 .. "/" .. (var_0_3[var_33_3] or "70")
	else
		DrawAction.RequestRecord(arg_33_0.selectPoolId_)
	end
end

function var_0_0.UpdateFreeDraw(arg_34_0)
	local var_34_0 = InviteData:GetDataByPara("poolID")
	local var_34_1 = InviteData:GetDataByPara("drawItemId")
	local var_34_2 = DrawPoolCfg[var_34_0]

	SetActive(arg_34_0.freeGo_, arg_34_0.selectPoolId_ == var_34_0 and ItemTools.getItemNum(var_34_1) > 0)

	if var_34_2 == nil then
		return
	end

	local var_34_3 = arg_34_0.tree_:GetGroupRedPointContainerById(var_0_2[var_34_2.pool_show_type])

	if var_34_3 == nil then
		return
	end

	manager.redPoint:setRedPoint({
		display = var_34_3
	}, ItemTools.getItemNum(var_34_1) > 0)

	local var_34_4 = arg_34_0.tree_:GetItemRedPointContainerById(var_0_2[var_34_2.pool_show_type], var_34_0)

	if var_34_4 == nil then
		return
	end

	manager.redPoint:setRedPoint({
		display = var_34_4
	}, ItemTools.getItemNum(var_34_1) > 0)
end

function var_0_0.RefreshRightPanel(arg_35_0)
	if not arg_35_0.curPoolObject then
		return
	end

	if arg_35_0.curPoolObject:ShowRightPanel() then
		local var_35_0 = DrawTools.GetActivityCostTicket(arg_35_0.selectPoolId_)

		if var_35_0 == 0 or ItemTools.IsItemExpiredByItemId(var_35_0) or ItemTools.getItemNum(var_35_0) == 0 then
			local var_35_1 = DrawTools.GetCostTicket(arg_35_0.selectPoolId_, 1)

			arg_35_0.iconOnce_.sprite = ItemTools.getItemSprite(var_35_1)

			local var_35_2 = DrawTools.GetCostTicket(arg_35_0.selectPoolId_, 10)

			arg_35_0.iconTenth_.sprite = ItemTools.getItemSprite(var_35_2)
			arg_35_0.one_cost_type = DrawConst.DRAW_COST_TYPE.COMMON
			arg_35_0.ten_cost_type = DrawConst.DRAW_COST_TYPE.COMMON
		else
			arg_35_0.iconOnce_.sprite = ItemTools.getItemSprite(var_35_0)
			arg_35_0.one_cost_type = DrawConst.DRAW_COST_TYPE.ACTIVITY

			if ItemTools.getItemNum(var_35_0) < 10 then
				local var_35_3 = DrawTools.GetCostTicket(arg_35_0.selectPoolId_, 10)

				arg_35_0.iconTenth_.sprite = ItemTools.getItemSprite(var_35_3)
				arg_35_0.ten_cost_type = DrawConst.DRAW_COST_TYPE.COMMON
			else
				arg_35_0.iconTenth_.sprite = ItemTools.getItemSprite(var_35_0)
				arg_35_0.ten_cost_type = DrawConst.DRAW_COST_TYPE.ACTIVITY
			end
		end

		arg_35_0.showRightController:SetSelectedIndex(1)
	else
		arg_35_0.showRightController:SetSelectedIndex(0)
	end

	if #DrawTools.GetRechargeDrawGiftList(arg_35_0.selectPoolId_) == 0 then
		arg_35_0.rechargeShopGiftController:SetSelectedIndex(0)
	else
		arg_35_0.rechargeShopGiftController:SetSelectedIndex(1)
	end
end

function var_0_0.DestroyPoolGo(arg_36_0)
	for iter_36_0, iter_36_1 in pairs(arg_36_0.poolObjects_) do
		iter_36_1:Dispose()
	end

	arg_36_0.poolObjects_ = {}
end

function var_0_0.SetCountDown(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0.activityEndTime_ = arg_37_2

	if arg_37_1 then
		if not arg_37_0.activityTimer_ then
			arg_37_0.activityTimer_ = Timer.New(handler(arg_37_0, arg_37_0.UpdateCountDownText), 1, -1)
		end

		arg_37_0:UpdateCountDownText()
		arg_37_0.curPoolObject:ShowCountDownText(true)
		arg_37_0.activityTimer_:Start()
	else
		arg_37_0.curPoolObject:ShowCountDownText(false)

		if arg_37_0.activityTimer_ then
			arg_37_0.activityTimer_:Stop()
		end
	end
end

function var_0_0.UpdateCountDownText(arg_38_0)
	arg_38_0.curPoolObject:SetCountDownText(arg_38_0.activityEndTime_)
end

function var_0_0.RemoveCountDownTimer(arg_39_0)
	if arg_39_0.activityTimer_ then
		arg_39_0.activityTimer_:Stop()

		arg_39_0.activityTimer_ = nil
	end
end

function var_0_0.DrawCheck(arg_40_0, arg_40_1)
	if WeaponServantData:GetServantNum() >= GameSetting.max_weapon_servant.value[1] then
		ShowMessageBox({
			content = GetTips("SERVANT_NUM_MAX"),
			BtnText = {
				nil,
				GetTips("SCAN_TIPS_1"),
				GetTips("SCAN_TIPS_2")
			},
			OkCallback = function()
				JumpTools.OpenPageByJump("/weaponServantList")
			end,
			CancelCallback = function()
				arg_40_0:StartDraw(arg_40_1)
			end
		})
	else
		arg_40_0:StartDraw(arg_40_1)
	end
end

function var_0_0.StartDraw(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0.selectPoolId_
	local var_43_1 = DrawPoolCfg[var_43_0]
	local var_43_2
	local var_43_3
	local var_43_4
	local var_43_5

	if DrawConst.DRAW_TYPE.ONE == arg_43_1 then
		var_43_2 = arg_43_0.one_cost_type
		var_43_3 = 1
		var_43_5 = 1
	elseif DrawConst.DRAW_TYPE.TEN == arg_43_1 then
		var_43_2 = arg_43_0.ten_cost_type
		var_43_3 = 10

		if var_43_1.discount > 0 then
			var_43_3 = var_43_3 * var_43_1.discount / 100
		end

		var_43_5 = 10
	else
		var_43_2 = arg_43_0.ten_cost_type
		var_43_3 = arg_43_1

		if var_43_1.discount > 0 then
			var_43_3 = var_43_3 * var_43_1.discount / 100
		end

		var_43_5 = arg_43_1
	end

	local var_43_6 = 0

	if DrawConst.DRAW_COST_TYPE.COMMON == var_43_2 then
		var_43_6 = DrawTools.GetCostTicket(var_43_0, var_43_3)

		local var_43_7 = ItemTools.getItemNum(var_43_6)

		if var_43_7 < var_43_3 then
			local var_43_8 = var_43_3 - var_43_7

			arg_43_0.shopDrawInfo = {
				poolId = var_43_0,
				draw_type = arg_43_1,
				cost_id = var_43_6,
				cost_num = var_43_3
			}

			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_gacha_diamond = "{" .. ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) .. "," .. CurrencyData:GetRechargeDiamond()
			})
			arg_43_0:ShowBuyView(var_43_8, var_43_1)

			return
		end
	elseif DrawConst.DRAW_COST_TYPE.ACTIVITY == var_43_2 then
		var_43_6 = DrawTools.GetActivityCostTicket(var_43_0)

		if ItemTools.IsItemExpiredByItemId(var_43_6) then
			ShowTips("TIP_EXPIRED")
			arg_43_0:RefreshActivityPool()
			arg_43_0:RefreshUI()

			return
		end

		if var_43_3 > ItemTools.getItemNum(var_43_6) then
			error("draw activity tick num error")

			return
		end
	end

	if not SDKTools.GetIsOverSea() and var_43_5 + DrawData:GetTodayDrawTimes() > GameSetting.draw_num_max.value[1] then
		ShowTips("DRAW_NUM_MAX")

		return
	end

	DrawData:SetNewHeroFlag(false)

	local var_43_9 = InviteData:GetDataByPara("drawItemId")

	if _G.SkipTip["DrawSkipTip" .. arg_43_0.selectPoolId_] or var_43_9 == var_43_6 then
		manager.achievementTips:SetShowFlag(false)
		DrawAction.GoToDraw(arg_43_0.selectPoolId_, arg_43_1, var_43_6, var_43_3)
	else
		JumpTools.OpenPageByJump("popCostItem", {
			costId = var_43_6,
			itemId = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
			popCostCallBack = function()
				manager.achievementTips:SetShowFlag(false)
				DrawAction.GoToDraw(arg_43_0.selectPoolId_, arg_43_1, var_43_6, var_43_3)
			end,
			ToggleCallback = function(arg_45_0)
				_G.SkipTip["DrawSkipTip" .. arg_43_0.selectPoolId_] = arg_45_0
			end,
			content = string.format(GetTips("DRAW_TIMES"), ItemTools.getItemName(var_43_6), var_43_3, var_43_3)
		})
	end
end

function var_0_0.ShowBuyView(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = getShopCfg(arg_46_2.exchange_id)
	local var_46_1 = var_46_0.cost * arg_46_1
	local var_46_2 = {
		id = DrawTools.GetCostTicket(arg_46_2.id, arg_46_1),
		num = arg_46_1
	}
	local var_46_3 = {}
	local var_46_4 = {}
	local var_46_5 = math.min(ItemTools.getItemNum(var_46_0.cost_id), var_46_1)

	if var_46_5 > 0 then
		var_46_3 = {
			id = var_46_0.cost_id,
			num = var_46_5
		}
	end

	local var_46_6 = var_46_1 - var_46_5

	if var_46_6 > 0 then
		var_46_4 = {
			id = CurrencyConst.GetPlatformDiamondId(),
			num = var_46_6
		}
	end

	if not var_46_3.id and var_46_4.id then
		var_46_3 = var_46_4
		var_46_4 = {}
	end

	JumpTools.OpenPageByJump("itemBuy", {
		title = GetTips("TREASURE_TICKET_TO_BUY"),
		item1 = var_46_2,
		item2 = var_46_3,
		item3 = var_46_4,
		OkCallback = function()
			local var_47_0 = CurrencyData:GetRechargeDiamond()

			if var_46_6 > 0 and var_47_0 < var_46_6 then
				if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 1 then
					ShopTools.DiamondEnoughMessageBox()
				else
					ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")
				end

				return
			end

			ShopAction.BuyItem({
				{
					goodID = arg_46_2.exchange_id,
					buyNum = arg_46_1
				}
			}, nil, PayConst.BUY_SOURCE_DRAW_POPUP)
		end,
		CancelCallback = function()
			arg_46_0.shopDrawInfo = nil
		end
	})
end

function var_0_0.OnShopBuyResult(arg_49_0, arg_49_1, arg_49_2, arg_49_3, arg_49_4)
	if arg_49_1 == 0 then
		if arg_49_0.shopDrawInfo == nil then
			return
		end

		arg_49_0:Back()
		manager.achievementTips:SetShowFlag(false)

		local var_49_0 = arg_49_0.shopDrawInfo.poolId
		local var_49_1 = arg_49_0.poolActivitys_[var_49_0]

		if var_49_1 and ActivityData:GetActivityIsOpen(var_49_1) then
			DrawAction.GoToDraw(arg_49_0.shopDrawInfo.poolId, arg_49_0.shopDrawInfo.draw_type, arg_49_0.shopDrawInfo.cost_id, arg_49_0.shopDrawInfo.cost_num)
		end

		arg_49_0.shopDrawInfo = nil
	else
		if arg_49_1 then
			ShowTips(arg_49_1)
		end

		arg_49_0.shopDrawInfo = nil
	end
end

function var_0_0.OnGoToDraw(arg_50_0, arg_50_1, arg_50_2)
	if arg_50_1.result == 0 then
		local var_50_0 = {}
		local var_50_1 = 0
		local var_50_2 = arg_50_1.item

		for iter_50_0, iter_50_1 in ipairs(var_50_2) do
			DrawData:TodayDrawTimesChange(1)
			table.insert(var_50_0, formatReward(iter_50_1))

			local var_50_3 = ItemCfg[iter_50_1.id]
			local var_50_4 = var_50_3 and var_50_3.display_rare or 0

			if var_50_1 < var_50_4 then
				var_50_1 = var_50_4
			end
		end

		arg_50_0:RefreshUI()
		manager.windowBar:HideBar()

		arg_50_0.itemList_ = var_50_0

		arg_50_0:CheckInteract(var_50_1)
	else
		ShowTips(arg_50_1.result)
		arg_50_0:RefreshActivityPool()
		arg_50_0.tree_:SelectItem(arg_50_0.poolIDToIndexTable[arg_50_0.selectPoolId_][1], arg_50_0.poolIDToIndexTable[arg_50_0.selectPoolId_][2])
		manager.achievementTips:SetShowFlag(true)
	end

	arg_50_0.shopDrawInfo = nil
end

function var_0_0.JumpToReward(arg_51_0)
	manager.achievementTips:SetShowFlag(true)

	local var_51_0 = #arg_51_0.itemList_

	if var_51_0 > 0 then
		local var_51_1 = {}
		local var_51_2 = {}

		for iter_51_0, iter_51_1 in ipairs(arg_51_0.itemList_) do
			local var_51_3 = setmetatable({
				index = iter_51_0
			}, {
				__index = iter_51_1
			})

			if ItemCfg[iter_51_1.id].type == ItemConst.ITEM_TYPE.HERO then
				var_51_3.newTag = true
				var_51_2[iter_51_1.id] = true

				DrawData:SetNewHeroFlag(true)
			elseif ItemCfg[iter_51_1.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
				var_51_3.newTag = IllustratedData:GetNewObtainedServant(iter_51_1.id) ~= nil

				if var_51_3.newTag and ItemCfg[iter_51_1.id].rare >= 5 then
					DrawData:SetServantRedPoint(arg_51_0.selectPoolId_, 1)
				end
			end

			table.insert(var_51_1, var_51_3)
		end

		local var_51_4 = 0

		for iter_51_2, iter_51_3 in ipairs(arg_51_0.itemList_) do
			local var_51_5 = iter_51_3.id

			if ItemCfg[var_51_5].type == ItemConst.ITEM_TYPE.HERO or ItemCfg[var_51_5].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT or ItemCfg[var_51_5].type == ItemConst.ITEM_TYPE.HERO_PIECE then
				local var_51_6 = var_51_5

				if ItemWillConvert(iter_51_3) then
					var_51_6 = iter_51_3.convert_from.id
				end

				local var_51_7 = ItemCfg[var_51_6].rare

				for iter_51_4, iter_51_5 in ipairs(GameSetting.currency_for_draw.value) do
					if var_51_7 == iter_51_5[1] then
						var_51_4 = var_51_4 + iter_51_5[2]
					end
				end
			end
		end

		if var_51_0 ~= 1 then
			gameContext:Go("drawTenTimesReward", {
				reward = var_51_1,
				callBack_afterTen = function()
					getReward({
						{
							id = ItemConst.CURRENCY_FOR_DRAW,
							num = var_51_4
						}
					}, nil, function()
						if DrawPoolCfg[arg_51_0.selectPoolId_].pool_type == 8 and DrawData:GetNewbieChooseDrawFlag() then
							ShowTips("DRAW_POOL_SCREEN_TYPE_1")
							arg_51_0:SetupActivityPool()

							arg_51_0.tree_.tree_.data.groupDatas[1].defaultIndex = 1

							arg_51_0.tree_:SelectItem(1, 1)
						end
					end)
					arg_51_0:ShowBar()
				end
			})
		else
			if DrawPoolCfg[arg_51_0.selectPoolId_].pool_type == 8 and DrawData:GetNewbieChooseDrawFlag() then
				ShowTips("DRAW_POOL_SCREEN_TYPE_1")
				arg_51_0:SetupActivityPool()

				arg_51_0.tree_.tree_.data.groupDatas[1].defaultIndex = 1

				arg_51_0.tree_:SelectItem(1, 1)
			end

			arg_51_0:ShowBar()
		end
	end

	arg_51_0:UpdateFreeDraw()
	arg_51_0:OnRequestRecord()
end

function var_0_0.SkipMovie(arg_54_0)
	arg_54_0.criplayer_.statusChangeCallback = nil

	if arg_54_0.moviePlaying then
		arg_54_0.criMovie_:Stop()
	end

	arg_54_0:DoNextNode(true)
end

local function var_0_5(arg_55_0)
	local var_55_0 = {
		__index = arg_55_0
	}
	local var_55_1 = ItemWillConvert(arg_55_0) and arg_55_0.convert_from.id or arg_55_0.id

	print("BuildShowItemInfo", arg_55_0.convert_from.id, arg_55_0.id)

	local var_55_2 = ItemCfg[var_55_1]
	local var_55_3 = var_55_2.type
	local var_55_4 = {}

	if var_55_3 == ItemConst.ITEM_TYPE.HERO or var_55_3 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		local var_55_5 = var_55_2.rare

		for iter_55_0, iter_55_1 in ipairs(GameSetting.currency_for_draw.value) do
			if var_55_5 == iter_55_1[1] then
				var_55_4.draw_rebate = iter_55_1[2]
			end
		end
	end

	return setmetatable(var_55_4, var_55_0)
end

function var_0_0.DoNextNode(arg_56_0, arg_56_1)
	arg_56_0.panel_.transform.localPosition = Vector2(0, 0)

	local var_56_0 = #arg_56_0.itemList_

	if arg_56_1 and var_56_0 > 1 then
		local var_56_1 = {}

		for iter_56_0, iter_56_1 in ipairs(arg_56_0.itemList_) do
			if ItemCfg[iter_56_1.id].type == ItemConst.ITEM_TYPE.HERO and ObtainHeroMovieCfg[iter_56_1.id] and not (getData(DrawConst.WATCH_TAG, tostring(iter_56_1.id)) or false) then
				table.insert(var_56_1, var_0_5(iter_56_1))
			end
		end

		if #var_56_1 == 0 then
			arg_56_0:JumpToReward()
		else
			local var_56_2 = handler(arg_56_0, arg_56_0.JumpToReward)
			local var_56_3 = {
				doNextHandler = var_56_2,
				skipHandler = var_56_2,
				itemList = var_56_1
			}

			arg_56_0:Go("obtainView", var_56_3)
		end

		return
	end

	if var_56_0 > 0 then
		local var_56_4 = {}

		for iter_56_2, iter_56_3 in ipairs(arg_56_0.itemList_) do
			local var_56_5 = ItemWillConvert(iter_56_3) and iter_56_3.convert_from.id or iter_56_3.id
			local var_56_6 = ItemCfg[var_56_5].type

			if var_56_0 == 1 and var_56_6 == ItemConst.ITEM_TYPE.HERO and ItemWillConvert(iter_56_3) then
				DrawData:SetNewHeroFlag(true)
			end

			table.insert(var_56_4, var_0_5(iter_56_3))
		end

		local var_56_7 = {
			doNextHandler = handler(arg_56_0, arg_56_0.JumpToReward),
			skipHandler = handler(arg_56_0, arg_56_0.JumpToReward),
			itemList = var_56_4
		}

		arg_56_0:Go("obtainView", var_56_7)
	else
		arg_56_0:JumpToReward()
	end
end

function var_0_0.PlayMovie(arg_57_0, arg_57_1)
	local var_57_0 = manager.audio:GetMusicVolume()

	arg_57_0.criplayer_:SetVolume(var_57_0)
	arg_57_0.criMovie_:Play()

	arg_57_0.criplayer_.statusChangeCallback = handler(arg_57_0, arg_57_0.CirMovieStatusChange)
	arg_57_0.moviePlaying = true

	if arg_57_1 >= 5 then
		manager.audio:SetObtainGoldSelectorLabel()
	elseif arg_57_1 >= 4 then
		manager.audio:SetObtainPurpleSelectorLabel()
	else
		manager.audio:SetObtainBlueSelectorLabel()
	end

	manager.audio:PlayEffect("ui_system_search", "search_animation", "")
	SetActive(arg_57_0.movieGo_, true)
end

function var_0_0.CirMovieStatusChange(arg_58_0, arg_58_1)
	local var_58_0 = tostring(arg_58_1)

	if var_58_0 == "PlayEnd" or var_58_0 == "Stop" then
		arg_58_0:DoNextNode(false)
	end
end

function var_0_0.StopMovie(arg_59_0)
	arg_59_0.criplayer_.statusChangeCallback = nil
	arg_59_0.moviePlaying = false

	SetActive(arg_59_0.movieGo_, false)
end

function var_0_0.SkipInteract(arg_60_0)
	SetActive(arg_60_0.drawInteractGo_, false)

	if arg_60_0.drawInteract.timeline then
		arg_60_0.drawInteract.timeline:Stop()
	end

	arg_60_0:DoNextNode(true)
end

function var_0_0.CheckInteract(arg_61_0, arg_61_1)
	arg_61_0.maxRare = arg_61_1

	if not DrawTools:LevelIsDone() then
		SetForceShowQuanquan(true)

		if arg_61_0.interactTimer then
			arg_61_0.interactTimer:Stop()

			arg_61_0.interactTimer = nil
		end

		arg_61_0.interactTimer = FrameTimer.New(handler(arg_61_0, arg_61_0.WaitInteract), 1, -1)

		arg_61_0.interactTimer:Start()
	else
		arg_61_0:StarInteract()
	end
end

function var_0_0.WaitInteract(arg_62_0)
	if DrawTools:LevelIsDone() then
		SetForceShowQuanquan(false)

		if arg_62_0.interactTimer then
			arg_62_0.interactTimer:Stop()

			arg_62_0.interactTimer = nil
		end

		arg_62_0:StarInteract()
	end
end

function var_0_0.StarInteract(arg_63_0)
	local var_63_0 = arg_63_0.maxRare or 0

	if var_63_0 >= 5 then
		arg_63_0.criplayer_:SetFile(nil, arg_63_0.moviePaths[3])
	elseif var_63_0 >= 4 then
		arg_63_0.criplayer_:SetFile(nil, arg_63_0.moviePaths[2])
	else
		arg_63_0.criplayer_:SetFile(nil, arg_63_0.moviePaths[1])
	end

	local var_63_1

	if var_63_0 >= 5 then
		var_63_1 = GameObject.Find("X102/TC/directors/director_gold")
	elseif var_63_0 >= 4 then
		var_63_1 = GameObject.Find("X102/TC/directors/director_purple")
	else
		var_63_1 = GameObject.Find("X102/TC/directors/director_blue")
	end

	if var_63_1 then
		local var_63_2 = var_63_1:GetComponent("PlayableDirector")

		arg_63_0.drawInteract:Init(var_63_2, handler(arg_63_0, arg_63_0.StopInteract))
		arg_63_0.drawInteract:Reset()

		arg_63_0.panel_.transform.localPosition = Vector2(9999, 9999)

		SetActive(arg_63_0.drawInteractGo_, true)
	else
		arg_63_0:StopInteract()
	end

	if arg_63_0.selectPoolId_ and arg_63_0.selectPoolId_ ~= 0 and arg_63_0.selectPoolId_ ~= -1 then
		arg_63_0:HidePoolNewTag(arg_63_0.selectPoolId_, true)
	end
end

function var_0_0.StopInteract(arg_64_0)
	SetActive(arg_64_0.drawInteractGo_, false)
	arg_64_0:PlayMovie(arg_64_0.maxRare or 0)
end

function var_0_0.Dispose(arg_65_0)
	arg_65_0.currencyModifyHandler_ = nil
	arg_65_0.timer = nil

	arg_65_0:DestroyPoolGo()
	arg_65_0.tree_:Dispose()

	arg_65_0.drawHandler_ = nil

	var_0_0.super.Dispose(arg_65_0)
end

function var_0_0.CurrencyModify(arg_66_0)
	arg_66_0:RefreshRightPanel()
end

function var_0_0.UpdateFirstSelectButton(arg_67_0, arg_67_1)
	SetActive(arg_67_0.chooseBtn_.gameObject, not arg_67_1)
	SetActive(arg_67_0.btnOnce_.gameObject, arg_67_1)
	SetActive(arg_67_0.btnTenth_.gameObject, arg_67_1)

	local var_67_0 = DrawPoolCfg[arg_67_0.selectPoolId_]

	arg_67_0.chooseText_.text = GetTips(var_67_0.pool_selected_type == 9 and "DRAW_WEAPON_BUTTON" or "DRAW_CHARACTER_BUTTON")
end

function var_0_0.OnInviteDrawUpdate(arg_68_0)
	arg_68_0:UpdateFreeDraw()
end

function var_0_0.AdaptRight(arg_69_0)
	var_0_0.super.AdaptRight(arg_69_0)

	if var_0_0.VIEW_ADAPT_DISTANCE == arg_69_0.lastAdaptDistance_ then
		return
	end

	if not var_0_0.NEED_ADAPT then
		arg_69_0.btnSkip_.transform.anchoredPosition = Vector3(0, 0, 0)
		arg_69_0.skipInteractBtn_.transform.anchoredPosition = Vector3(0, 0, 0)
	else
		arg_69_0.btnSkip_.transform.anchoredPosition = Vector3(-1 * var_0_0.VIEW_ADAPT_DISTANCE, 0, 0)
		arg_69_0.skipInteractBtn_.transform.anchoredPosition = Vector3(-1 * var_0_0.VIEW_ADAPT_DISTANCE, 0, 0)
	end
end

return var_0_0
