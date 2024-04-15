slot0 = class("DrawView", ReduxView)
slot1 = {
	"DRAW_POOL_TYPE_6",
	"DRAW_POOL_TYPE_3",
	"DRAW_POOL_TYPE_7",
	"DRAW_POOL_TYPE_8",
	"DRAW_POOL_TYPE_1",
	"DRAW_POOL_TYPE_2"
}
slot2 = {
	5,
	6,
	2,
	nil,
	5,
	1,
	3,
	4
}
slot3 = {
	[1.0] = "90",
	[4.0] = "40"
}
slot4 = {
	[200003.0] = "WEAPON_DRAW_POOL_RACE_3",
	[200001.0] = "WEAPON_DRAW_POOL_RACE_1",
	[200009.0] = "WEAPON_DRAW_POOL_RACE_9",
	[200005.0] = "WEAPON_DRAW_POOL_RACE_5",
	[200004.0] = "WEAPON_DRAW_POOL_RACE_4",
	[200002.0] = "WEAPON_DRAW_POOL_RACE_2"
}

function slot0.OnCtor(slot0)
	slot0.moviePaths = {
		"SofdecAsset/function/blue.usm",
		"SofdecAsset/function/purple.usm",
		"SofdecAsset/function/glod.usm"
	}
end

function slot0.UIName(slot0)
	return "Widget/System/Pool/PoolUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.poolToggles_ = {}
	slot0.poolObjects_ = {}
	slot0.poolActivitys_ = {}
	slot0.groupRedPoint = {}
	slot0.drawHandler_ = handler(slot0, slot0.DrawCheck)

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.currencyModifyHandler_ = handler(slot0, slot0.CurrencyModify)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.criMovie_ = slot0.movie_:GetComponent("CriManaMovieControllerForUI")
	slot0.criplayer_ = slot0.criMovie_.player

	slot0.criMovie_:Stop()

	slot0.moviePlaying = false

	SetActive(slot0.movieGo_, false)

	slot0.drawInteract = slot0.drawInteractGo_:GetComponent("DrawController")

	SetActive(slot0.drawInteractGo_, false)

	slot0.showRightController = ControllerUtil.GetController(slot0.transform_, "showRight")
	slot0.rechargeShopGiftController = ControllerUtil.GetController(slot0.transform_, "recharge_shop_gift")
	slot0.tree_ = LuaTree.New(slot0.uitreeGo_)

	slot0.tree_:SetSelectedHandler(handler(slot0, slot0.OnGroupSelect), handler(slot0, slot0.OnItemSelect))
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnInfo_, nil, function ()
		if (DrawPoolCfg[uv0.selectPoolId_].pool_selected_type == 2 or slot0.pool_selected_type == 8) and DrawData:GetPollUpID(uv0.selectPoolId_) == 0 then
			ShowTips("DRAW_NOT_SELECT_TIPS")

			return
		end

		if slot0.pool_selected_type == 9 and DrawData:GetPollUpID(uv0.selectPoolId_) == 0 then
			ShowTips("DRAW_NOT_SELECT_WEAPON_TIPS")

			return
		end

		DrawAction.GetPoolData(uv0.selectPoolId_)
	end)
	slot0:AddBtnListener(slot0.btnRecord_, nil, function ()
		JumpTools.OpenPageByJump("drawRecord", {
			poolId = uv0.selectPoolId_
		})
	end)
	slot0:AddBtnListener(slot0.btnOnce_, nil, function ()
		uv0:DrawCheck(DrawConst.DRAW_TYPE.ONE)
	end)
	slot0:AddBtnListener(slot0.btnTenth_, nil, function ()
		if DrawPoolCfg[uv0.selectPoolId_].pool_type == 8 then
			uv0:DrawCheck(math.min(40 - DrawData:GetPoolDrawTimes(uv0.selectPoolId_), 10))
		else
			uv0:DrawCheck(DrawConst.DRAW_TYPE.TEN)
		end
	end)
	slot0:AddBtnListener(slot0.btnSkip_, nil, function ()
		manager.audio:PlayEffect("ui_system_search", "search_skip", "")
		uv0:SkipMovie()
	end)
	slot0:AddBtnListener(slot0.chooseBtn_, nil, function ()
		if DrawPoolCfg[uv0.selectPoolId_].pool_selected_type == 2 then
			uv0:Go("/drawAllHeroSelect", {
				isFirst = true,
				poolId = uv0.selectPoolId_,
				heroIdList = slot0.optional_detail
			})
		elseif slot0.pool_selected_type == 8 then
			slot1 = DrawPoolCfg[uv0.selectPoolId_]

			uv0:Go("/newbieDrawHeroSelect", {
				poolId = uv0.selectPoolId_,
				heroIdList = slot1.optional_detail,
				heroId = slot1.optional_detail[table.indexof(slot1.optional_lists_poolId, uv0.showId)]
			})
		elseif slot0.pool_selected_type == 9 then
			uv0:Go("/drawSelect", {
				poolID = uv0.selectPoolId_
			})
		end
	end)
	slot0:AddBtnListener(slot0.skipInteractBtn_, nil, function ()
		manager.audio:PlayEffect("ui_system_search", "search_skip", "")
		uv0:SkipInteract()
	end)
	slot0:AddBtnListener(slot0.m_giftBtn, nil, function ()
		slot1 = 0

		if DrawPoolCfg[uv0.selectPoolId_].pool_type == 3 then
			slot1 = 1
		elseif slot0.pool_type == 1 then
			slot1 = 2
		elseif slot0.pool_type == 2 then
			slot1 = 3
		elseif slot0.pool_type == 6 then
			slot1 = 4
		end

		if slot1 ~= 0 then
			OperationRecorder.RecordButtonTouch("draw_gifts_type" .. slot1)
		end

		JumpTools.OpenPageByJump("rechargeDrawGift", {
			poolId = uv0.selectPoolId_
		})
	end)
end

function slot0.OnTop(slot0)
	slot0:StopMovie()
	slot0:ShowBar()
end

function slot0.OnEnter(slot0)
	slot0:SetupActivityPool()

	if slot0.params_.poolType then
		for slot4, slot5 in ipairs(slot0.poolToggles_) do
			if DrawPoolCfg[slot5].pool_type == slot0.params_.poolType then
				slot0.params_.poolId = slot5
				slot0.params_.poolType = nil
			end
		end
	end

	slot1 = slot0.enterPoolId

	if slot0.params_.poolId and slot0.poolActivitys_[slot0.params_.poolId] and ActivityData:GetActivityIsOpen(slot2) then
		slot1 = slot0.params_.poolId
	end

	slot0.tree_.tree_.data.groupDatas[slot0.poolIDToIndexTable[slot1][1] - 1].defaultIndex = slot0.poolIDToIndexTable[slot1][2] - 1

	slot0.tree_:SelectItem(slot0.poolIDToIndexTable[slot1][1], slot0.poolIDToIndexTable[slot1][2])
	DrawTools:LoadDrawLevel()
	manager.ui:SetMainCamera("draw")

	slot0.panel_.transform.localPosition = Vector2(0, 0)

	manager.notify:RegistListener(CURRENCY_UPDATE, slot0.currencyModifyHandler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(CURRENCY_UPDATE, slot0.currencyModifyHandler_)

	if slot0.selectPoolId_ and slot0.selectPoolId_ ~= 0 and slot0.selectPoolId_ ~= -1 and manager.net ~= nil and manager.net.tcpConnection_ ~= nil and manager.net.tcpConnection_:GetMachineState() and (slot1 == "connected" or slot1 == "connecting") then
		slot0:HidePoolNewTag(slot0.selectPoolId_, true)
	end

	manager.windowBar:HideBar()
	slot0:StopMovie()
	slot0.criMovie_:Stop()

	if slot0.curPoolObject then
		slot0.curPoolObject:SetActive(false)
	end

	slot0.curPoolObject = nil
	slot0.selectPoolId_ = -1
	slot0.one_cost_type = nil
	slot0.ten_cost_type = nil

	if slot0.interactTimer then
		slot0.interactTimer:Stop()

		slot0.interactTimer = nil
	end

	manager.ui:SetMainCameraCom("CinemachineBrain", false)
	slot0:RemoveCountDownTimer()
	DrawTools:UnLoadDrawLevel()
end

function slot0.InitTree(slot0)
	slot1 = UITreeData.New()
	slot2 = {}
	slot0.poolIDToIndexTable = {}

	for slot6, slot7 in ipairs(slot0.poolToggles_) do
		if slot2[uv0[DrawPoolCfg[slot7].pool_show_type]] == nil then
			slot2[slot9] = 1
		end

		slot0.poolIDToIndexTable[slot7] = {
			slot9,
			slot2[slot9]
		}
		slot2[slot9] = slot2[slot9] + 1
	end

	slot3 = {
		[slot8] = slot4
	}
	slot4 = 1

	for slot8 = 1, 8 do
		if slot2[slot8] then
			slot4 = slot4 + 1
		end
	end

	for slot9, slot10 in ipairs(uv1) do
		({
			[slot9] = UITreeGroupData.New()
		})[slot9].text = GetTips(slot10)
	end

	for slot9, slot10 in ipairs(slot0.poolToggles_) do
		slot11 = DrawPoolCfg[slot10]
		slot12 = uv0[slot11.pool_show_type]
		slot0.poolIDToIndexTable[slot10][1] = slot3[slot12]
		slot5[slot12].id = slot3[slot12]
		slot13 = UITreeItemData.New()
		slot13.id = slot11.id
		slot13.text = GetI18NText(slot11.name)

		if slot11.pool_show_type == 2 then
			slot13.text = GetI18NText(slot11.name)

			if DrawData:GetPollUpID(slot10) ~= 0 then
				slot13.text = GetTips(uv2[slot14])
			end
		elseif slot11.pool_show_type == 8 or slot11.pool_show_type == 3 and slot11.pool_selected_type == 2 then
			slot13.text = GetI18NText(slot11.name)

			if DrawData:GetPollUpID(slot10) ~= 0 then
				slot13.text = HeroCfg[DrawData:ConvertUpId(slot10, slot14, 0)].name or ""
			end
		end

		if slot0.poolIDToIndexTable[slot10][1] == 1 and slot0.poolIDToIndexTable[slot10][2] == 1 then
			slot0.enterPoolId = slot10
		end

		slot5[slot12].itemDatas:Add(slot13)
	end

	for slot9 = 1, 6 do
		if slot5[slot9].itemDatas.Count > 0 then
			slot1.groupDatas:Add(slot5[slot9])
		end
	end

	slot0.tree_:SetData(slot1)
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	slot0.tree_.tree_.data.groupDatas[slot1 - 1].defaultIndex = 0
end

function slot0.OnItemSelect(slot0, slot1, slot2, slot3, slot4)
	slot0:HidePoolNewTag(slot2)
	slot0:SetSelectPool(slot2)
	SetActive(slot0.upArrowGo_, false)
	SetActive(slot0.upTargetTipsGo_, false)

	if uv0[DrawPoolCfg[slot2].pool_show_type] == 1 then
		slot0.ALevelTips_.text = GetTips("DRAW_POOL_PROBABILITY_A_4")
		slot0.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_5")
	elseif slot6 == 2 then
		slot0.ALevelTips_.text = GetTips("DRAW_POOL_PROBABILITY_A_4")
		slot0.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
	elseif slot6 == 3 then
		slot0.ALevelTips_.text = GetTips("DRAW_POOL_PROBABILITY_A_4")
		slot0.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
	elseif slot6 == 4 then
		slot0.ALevelTips_.text = GetTips("DRAW_POOL_PROBABILITY_A_4")
		slot0.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_8")
	elseif slot6 == 5 then
		slot0.ALevelTips_.text = GetTips("DRAW_POOL_PROBABILITY_A_4")
		slot0.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_S_4")
	elseif slot6 == 6 then
		slot0.ALevelTips_.text = GetTips("DRAW_POOL_PROBABILITY_FOUR_WEAPON_4")
		slot0.upTips_.text = GetTips("DRAW_POOL_PROBABILITY_FIVE_WEAPON_4")
	end
end

function slot0.SetupActivityPool(slot0)
	slot0.poolToggles_ = {}

	for slot5, slot6 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.DRAW] or {}) do
		if ActivityData:GetActivityIsOpen(slot6) and ActivityDrawPoolCfg[slot6] then
			for slot11, slot12 in ipairs(slot7.config_list) do
				if DrawPoolCfg[slot12].pool_show_type == 8 then
					if not DrawData:GetNewbieChooseDrawFlag() then
						table.insert(slot0.poolToggles_, slot12)

						slot0.poolActivitys_[slot12] = slot6
					end
				else
					table.insert(slot0.poolToggles_, slot12)

					slot0.poolActivitys_[slot12] = slot6
				end
			end
		end
	end

	if #slot0.poolToggles_ == 0 then
		Debugger.LogError("draw error pools is empty")
	end

	table.sort(slot0.poolToggles_, function (slot0, slot1)
		return DrawPoolCfg[slot0].order < DrawPoolCfg[slot1].order
	end)
	slot0:InitTree()
	slot0:InitPoolNew()
end

function slot0.InitPoolNew(slot0)
	for slot4, slot5 in ipairs(slot0.poolToggles_) do
		if DrawData:GetPoolIsNew(slot5) == 1 then
			slot0:SetNewTag(true, slot5)
		end
	end
end

function slot0.HidePoolNewTag(slot0, slot1, slot2)
	if slot0.selectPoolId_ ~= -1 and slot0.selectPoolId_ ~= nil and slot0.selectPoolId_ ~= slot1 and DrawData:GetPoolIsNew(slot0.selectPoolId_) == 1 or slot2 then
		DrawAction.HidePoolNewTag(slot0.selectPoolId_, handler(slot0, slot0.SetNewTag))
	end
end

function slot0.SetNewTag(slot0, slot1, slot2)
	if not slot0.poolIDToIndexTable[slot2] then
		return
	end

	if not slot0.tree_ then
		return
	end

	slot3 = slot0.poolIDToIndexTable[slot2][1]
	slot4 = slot0.poolIDToIndexTable[slot2][2]

	if slot0.tree_:GetGroupRedPointContainerById(slot3) == nil or slot0.tree_:GetItemRedPointContainerById(slot3, slot2) == nil then
		return
	end

	slot7 = true

	if slot1 then
		slot0.groupRedPoint[slot3] = slot0.groupRedPoint[slot3] or {}
		slot0.groupRedPoint[slot3][slot4] = slot2
	else
		slot0.groupRedPoint[slot3][slot4] = nil

		if not next(slot0.groupRedPoint[slot3]) then
			slot0.groupRedPoint[slot3] = nil
		end

		if not next(slot0.groupRedPoint) then
			manager.redPoint:setTip(RedPointConst.DRAW, 0, RedPointStyle.SHOW_NEW_TAG)

			slot0.groupRedPoint = {}
		end
	end

	manager.redPoint:setRedPoint({
		display = slot5
	}, slot0.groupRedPoint[slot3] and next(slot0.groupRedPoint[slot3]), RedPointStyle.SHOW_NEW_TAG)
	manager.redPoint:setRedPoint({
		display = slot6
	}, slot1, RedPointStyle.SHOW_NEW_TAG)
end

function slot0.RefreshActivityPool(slot0)
	slot0:SetupActivityPool()

	if not table.indexof(slot0.poolToggles_, slot0.selectPoolId_) then
		slot0.selectPoolId_ = slot0.poolToggles_[1]

		slot0:RefreshUI()
	end
end

function slot0.SetSelectPool(slot0, slot1)
	if not table.indexof(slot0.poolToggles_, slot1) then
		return
	end

	if slot1 == slot0.selectPoolId_ then
		return
	end

	slot0.selectPoolId_ = slot1
	slot0.params_.poolId = slot1

	slot0:RefreshUI()
end

function slot0.ShowBar(slot0)
	slot1 = DrawTools.GetCostTicketList(slot0.selectPoolId_)
	slot3 = {
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	}

	if DrawTools.GetActivityCostTicket(slot0.selectPoolId_) == 0 or ItemTools.IsItemExpiredByItemId(slot2) then
		for slot7, slot8 in ipairs(slot1) do
			table.insert(slot3, slot8)
		end

		table.insertto(slot3, {
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})
		manager.windowBar:SwitchBar(slot3)
	elseif slot2 == InviteData:GetDataByPara("drawItemId") then
		for slot7, slot8 in ipairs(slot1) do
			table.insert(slot3, slot8)
		end

		table.insertto(slot3, {
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})
		manager.windowBar:SwitchBar(slot3)
	else
		if ItemTools.getItemNum(slot2) > 0 then
			table.insert(slot3, slot2)
		end

		for slot7, slot8 in ipairs(slot1) do
			table.insert(slot3, slot8)
		end

		table.insertto(slot3, {
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})
		manager.windowBar:SwitchBar(slot3)

		if ItemTools.getItemNum(slot2) > 0 then
			manager.windowBar:SetBarCanAdd(slot2, false)
			manager.windowBar:SetBarCanClick(slot2, true)
		end
	end

	manager.windowBar:RegistBackCallBack(function ()
		DrawData:ResetServantRedPoint()
		uv0:Back()
	end)
	manager.windowBar:RegistHomeCallBack(function ()
		DrawData:ResetServantRedPoint()
		gameContext:Go("/home", nil, , true)
	end)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)

	slot7 = CurrencyConst.GetPlatformDiamondId()
	slot8 = true

	manager.windowBar:SetBarCanAdd(slot7, slot8)

	for slot7, slot8 in pairs(slot1) do
		manager.windowBar:SetBarCanAdd(slot8, false)
		manager.windowBar:SetBarCanClick(slot8, true)
	end
end

function slot0.RefreshUI(slot0)
	slot1 = slot0.selectPoolId_
	slot3 = slot1

	slot0:UpdateFirstSelectButton(true)

	if DrawPoolCfg[slot1].pool_selected_type == 9 then
		if DrawData:GetPollUpID(slot1) == 0 then
			slot0:UpdateFirstSelectButton(false)

			slot3 = -1
		else
			slot3 = slot4
		end
	elseif slot2.pool_selected_type == 2 or slot2.pool_selected_type == 8 then
		if DrawData:GetPollUpID(slot1) == 0 then
			if slot2.pool_change == 0 or DrawData:GetPoolUpTimes(slot1) < slot5 then
				slot0.timer = TimeTools.StartAfterSeconds(0.1, function (slot0)
					if DrawData:IsOnePrefabPool(slot0) then
						if uv0.pool_selected_type == 2 then
							uv1:UpdateFirstSelectButton(false)
						elseif uv0.pool_selected_type == 8 then
							uv1:UpdateFirstSelectButton(false)
						end
					else
						uv1:Go("/drawHeroSelect", {
							poolId = uv1.selectPoolId_
						})
					end
				end, {
					slot1
				})
			end

			slot3 = -slot0.selectPoolId_
		else
			slot3 = slot4
		end
	end

	if slot2.pool_type == 8 then
		slot0.tenOneKeyGetText_.text = string.format(GetTips("DRAW_POOL_SCREEN_TYPE_2"), string.format(GetTips("NUM_" .. math.min(40 - DrawData:GetPoolDrawTimes(slot1), 10))))
		slot0.tips3Text_.text = GetTips("DRAW_POOL_SCREEN_TYPE_3")
	else
		slot0.tenOneKeyGetText_.text = string.format(GetTips("DRAW_POOL_SCREEN_TYPE_2"), GetTips("NUM_10"))
	end

	SetActive(slot0.tips3Text_.gameObject, slot2.pool_type == 8)

	if slot2.pool_type == 8 then
		slot0.tenIconText_.text = "x" .. math.min(40 - DrawData:GetPoolDrawTimes(slot1), 10)
	else
		slot0.tenIconText_.text = "x10"
	end

	if slot2.pool_type ~= 1 then
		SetActive(slot0.timeGo_, true)
	else
		SetActive(slot0.timeGo_, not DrawData:GetIsFirstSSR())
	end

	if slot0.curPoolObject then
		if slot0.curPoolObject:GetShowId() == slot3 then
			slot0.curPoolObject:Refresh(slot3)
			slot0:RefreshRightPanel()

			return
		else
			slot0.curPoolObject:SetActive(false)
		end
	end

	slot0.showId = slot3

	if not slot0.poolObjects_[slot3] then
		if slot2.pool_type == 1 then
			slot0.poolObjects_[slot3] = DrawNormalPool.New(slot0.poolcontentTrs_, slot1, slot3)
		elseif slot2.pool_selected_type == 2 or slot2.pool_selected_type == 8 then
			if DrawData:IsOnePrefabPool(slot1) then
				if slot2.pool_selected_type == 8 then
					slot0.poolObjects_[slot3] = NewbieDrawSelectPool.New(slot0.poolcontentTrs_, slot1, slot3)
				else
					slot0.poolObjects_[slot3] = DrawSelectPool.New(slot0.poolcontentTrs_, slot1, slot3)
				end
			else
				slot0.poolObjects_[slot3] = DrawUpPool.New(slot0.poolcontentTrs_, slot1, slot3)
			end
		elseif slot2.pool_selected_type == 9 then
			if DrawData:GetPollUpID(slot1) == slot3 then
				slot0.poolObjects_[slot3] = DrawServantPool.New(slot0.poolcontentTrs_, slot1, slot3)
			else
				slot0.poolObjects_[slot3] = DrawServantNormalPool.New(slot0.poolcontentTrs_, slot1, slot3)
			end
		else
			slot0.poolObjects_[slot3] = DrawBasePool.New(slot0.poolcontentTrs_, slot1, slot3)
		end
	end

	slot0.curPoolObject = slot0.poolObjects_[slot3]

	slot0.curPoolObject:Refresh(slot3)
	slot0.curPoolObject:SetActive(true)
	slot0:OnRequestRecord()
	slot0:RefreshRightPanel()

	if slot0.poolActivitys_[slot1] and ActivityData:GetActivityData(slot4) then
		slot0:SetCountDown(true, ActivityData:GetActivityData(slot4).stopTime)
	else
		slot0:SetCountDown(false)
	end

	slot0:ShowBar()

	if #DrawTools.GetRechargeDrawGiftList(slot1) == 0 then
		slot0.rechargeShopGiftController:SetSelectedIndex(0)
	else
		slot0.rechargeShopGiftController:SetSelectedIndex(1)
	end

	slot0:UpdateFreeDraw()
end

function slot0.OnRequestRecord(slot0)
	if DrawData:GetDrawRecord(slot0.selectPoolId_) then
		slot0.drawTxt_.text = slot1.ssr_draw_times .. "/" .. (uv1[uv0[DrawPoolCfg[slot0.selectPoolId_].pool_show_type]] or "70")
	else
		DrawAction.RequestRecord(slot0.selectPoolId_)
	end
end

function slot0.UpdateFreeDraw(slot0)
	slot1 = InviteData:GetDataByPara("poolID")

	SetActive(slot0.freeGo_, slot0.selectPoolId_ == slot1 and ItemTools.getItemNum(InviteData:GetDataByPara("drawItemId")) > 0)

	if DrawPoolCfg[slot1] == nil then
		return
	end

	if slot0.tree_:GetGroupRedPointContainerById(uv0[slot3.pool_show_type]) == nil then
		return
	end

	manager.redPoint:setRedPoint({
		display = slot4
	}, ItemTools.getItemNum(slot2) > 0)

	if slot0.tree_:GetItemRedPointContainerById(uv0[slot3.pool_show_type], slot1) == nil then
		return
	end

	manager.redPoint:setRedPoint({
		display = slot5
	}, ItemTools.getItemNum(slot2) > 0)
end

function slot0.RefreshRightPanel(slot0)
	if not slot0.curPoolObject then
		return
	end

	if slot0.curPoolObject:ShowRightPanel() then
		if DrawTools.GetActivityCostTicket(slot0.selectPoolId_) == 0 or ItemTools.IsItemExpiredByItemId(slot1) or ItemTools.getItemNum(slot1) == 0 then
			slot0.iconOnce_.sprite = ItemTools.getItemSprite(DrawTools.GetCostTicket(slot0.selectPoolId_, 1))
			slot0.iconTenth_.sprite = ItemTools.getItemSprite(DrawTools.GetCostTicket(slot0.selectPoolId_, 10))
			slot0.one_cost_type = DrawConst.DRAW_COST_TYPE.COMMON
			slot0.ten_cost_type = DrawConst.DRAW_COST_TYPE.COMMON
		else
			slot0.iconOnce_.sprite = ItemTools.getItemSprite(slot1)
			slot0.one_cost_type = DrawConst.DRAW_COST_TYPE.ACTIVITY

			if ItemTools.getItemNum(slot1) < 10 then
				slot0.iconTenth_.sprite = ItemTools.getItemSprite(DrawTools.GetCostTicket(slot0.selectPoolId_, 10))
				slot0.ten_cost_type = DrawConst.DRAW_COST_TYPE.COMMON
			else
				slot0.iconTenth_.sprite = ItemTools.getItemSprite(slot1)
				slot0.ten_cost_type = DrawConst.DRAW_COST_TYPE.ACTIVITY
			end
		end

		slot0.showRightController:SetSelectedIndex(1)
	else
		slot0.showRightController:SetSelectedIndex(0)
	end

	if #DrawTools.GetRechargeDrawGiftList(slot0.selectPoolId_) == 0 then
		slot0.rechargeShopGiftController:SetSelectedIndex(0)
	else
		slot0.rechargeShopGiftController:SetSelectedIndex(1)
	end
end

function slot0.DestroyPoolGo(slot0)
	for slot4, slot5 in pairs(slot0.poolObjects_) do
		slot5:Dispose()
	end

	slot0.poolObjects_ = {}
end

function slot0.SetCountDown(slot0, slot1, slot2)
	slot0.activityEndTime_ = slot2

	if slot1 then
		if not slot0.activityTimer_ then
			slot0.activityTimer_ = Timer.New(handler(slot0, slot0.UpdateCountDownText), 1, -1)
		end

		slot0:UpdateCountDownText()
		slot0.curPoolObject:ShowCountDownText(true)
		slot0.activityTimer_:Start()
	else
		slot0.curPoolObject:ShowCountDownText(false)

		if slot0.activityTimer_ then
			slot0.activityTimer_:Stop()
		end
	end
end

function slot0.UpdateCountDownText(slot0)
	slot0.curPoolObject:SetCountDownText(slot0.activityEndTime_)
end

function slot0.RemoveCountDownTimer(slot0)
	if slot0.activityTimer_ then
		slot0.activityTimer_:Stop()

		slot0.activityTimer_ = nil
	end
end

function slot0.DrawCheck(slot0, slot1)
	if GameSetting.max_weapon_servant.value[1] <= WeaponServantData:GetServantNum() then
		ShowMessageBox({
			content = GetTips("SERVANT_NUM_MAX"),
			BtnText = {
				[2] = GetTips("SCAN_TIPS_1"),
				GetTips("SCAN_TIPS_2")
			},
			OkCallback = function ()
				JumpTools.OpenPageByJump("/weaponServantList")
			end,
			CancelCallback = function ()
				uv0:StartDraw(uv1)
			end
		})
	else
		slot0:StartDraw(slot1)
	end
end

function slot0.StartDraw(slot0, slot1)
	slot3 = DrawPoolCfg[slot0.selectPoolId_]
	slot4, slot5, slot6 = nil

	if DrawConst.DRAW_TYPE.ONE == slot1 then
		slot4 = slot0.one_cost_type
		slot5 = 1
		slot6 = 1
	elseif DrawConst.DRAW_TYPE.TEN == slot1 then
		slot4 = slot0.ten_cost_type

		if slot3.discount > 0 then
			slot5 = 10 * slot3.discount / 100
		end

		slot6 = 10
	else
		slot4 = slot0.ten_cost_type

		if slot3.discount > 0 then
			slot5 = slot1 * slot3.discount / 100
		end

		slot6 = slot1
	end

	slot7 = 0

	if DrawConst.DRAW_COST_TYPE.COMMON == slot4 then
		if ItemTools.getItemNum(DrawTools.GetCostTicket(slot2, slot5)) < slot5 then
			slot0.shopDrawInfo = {
				poolId = slot2,
				draw_type = slot1,
				cost_id = slot7,
				cost_num = slot5
			}

			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_gacha_diamond = "{" .. ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) .. "," .. CurrencyData:GetRechargeDiamond()
			})
			slot0:ShowBuyView(slot5 - slot8, slot3)

			return
		end
	elseif DrawConst.DRAW_COST_TYPE.ACTIVITY == slot4 then
		if ItemTools.IsItemExpiredByItemId(DrawTools.GetActivityCostTicket(slot2)) then
			ShowTips("TIP_EXPIRED")
			slot0:RefreshActivityPool()
			slot0:RefreshUI()

			return
		end

		if ItemTools.getItemNum(slot7) < slot5 then
			error("draw activity tick num error")

			return
		end
	end

	if not SDKTools.GetIsOverSea() and GameSetting.draw_num_max.value[1] < slot6 + DrawData:GetTodayDrawTimes() then
		ShowTips("DRAW_NUM_MAX")

		return
	end

	DrawData:SetNewHeroFlag(false)

	if _G.SkipTip["DrawSkipTip" .. slot0.selectPoolId_] or InviteData:GetDataByPara("drawItemId") == slot7 then
		manager.achievementTips:SetShowFlag(false)
		DrawAction.GoToDraw(slot0.selectPoolId_, slot1, slot7, slot5)
	else
		JumpTools.OpenPageByJump("popCostItem", {
			costId = slot7,
			itemId = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
			popCostCallBack = function ()
				manager.achievementTips:SetShowFlag(false)
				DrawAction.GoToDraw(uv0.selectPoolId_, uv1, uv2, uv3)
			end,
			ToggleCallback = function (slot0)
				_G.SkipTip["DrawSkipTip" .. uv0.selectPoolId_] = slot0
			end,
			content = string.format(GetTips("DRAW_TIMES"), ItemTools.getItemName(slot7), slot5, slot5)
		})
	end
end

function slot0.ShowBuyView(slot0, slot1, slot2)
	slot3 = getShopCfg(slot2.exchange_id)
	slot5 = {
		id = DrawTools.GetCostTicket(slot2.id, slot1),
		num = slot1
	}
	slot6 = {}
	slot7 = {}

	if math.min(ItemTools.getItemNum(slot3.cost_id), slot3.cost * slot1) > 0 then
		slot6 = {
			id = slot3.cost_id,
			num = slot8
		}
	end

	if slot4 - slot8 > 0 then
		slot7 = {
			id = CurrencyConst.GetPlatformDiamondId(),
			num = slot9
		}
	end

	if not slot6.id and slot7.id then
		slot6 = slot7
		slot7 = {}
	end

	JumpTools.OpenPageByJump("itemBuy", {
		title = GetTips("TREASURE_TICKET_TO_BUY"),
		item1 = slot5,
		item2 = slot6,
		item3 = slot7,
		OkCallback = function ()
			if uv0 > 0 and CurrencyData:GetRechargeDiamond() < uv0 then
				if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 1 then
					ShopTools.DiamondEnoughMessageBox()
				else
					ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")
				end

				return
			end

			ShopAction.BuyItem({
				{
					goodID = uv1.exchange_id,
					buyNum = uv2
				}
			}, nil, PayConst.BUY_SOURCE_DRAW_POPUP)
		end,
		CancelCallback = function ()
			uv0.shopDrawInfo = nil
		end
	})
end

function slot0.OnShopBuyResult(slot0, slot1, slot2, slot3, slot4)
	if slot1 == 0 then
		if slot0.shopDrawInfo == nil then
			return
		end

		slot0:Back()
		manager.achievementTips:SetShowFlag(false)

		if slot0.poolActivitys_[slot0.shopDrawInfo.poolId] and ActivityData:GetActivityIsOpen(slot6) then
			DrawAction.GoToDraw(slot0.shopDrawInfo.poolId, slot0.shopDrawInfo.draw_type, slot0.shopDrawInfo.cost_id, slot0.shopDrawInfo.cost_num)
		end

		slot0.shopDrawInfo = nil
	else
		if slot1 then
			ShowTips(slot1)
		end

		slot0.shopDrawInfo = nil
	end
end

function slot0.OnGoToDraw(slot0, slot1, slot2)
	if slot1.result == 0 then
		slot3 = {}

		for slot9, slot10 in ipairs(slot1.item) do
			DrawData:TodayDrawTimesChange(1)
			table.insert(slot3, formatReward(slot10))

			if 0 < (ItemCfg[slot10.id] and slot11.display_rare or 0) then
				slot4 = slot12
			end
		end

		slot0:RefreshUI()
		manager.windowBar:HideBar()

		slot0.itemList_ = slot3

		slot0:CheckInteract(slot4)
	else
		ShowTips(slot1.result)
		slot0:RefreshActivityPool()
		slot0.tree_:SelectItem(slot0.poolIDToIndexTable[slot0.selectPoolId_][1], slot0.poolIDToIndexTable[slot0.selectPoolId_][2])
		manager.achievementTips:SetShowFlag(true)
	end

	slot0.shopDrawInfo = nil
end

function slot0.JumpToReward(slot0)
	manager.achievementTips:SetShowFlag(true)

	if #slot0.itemList_ > 0 then
		slot2 = {}
		slot3 = {
			[slot8.id] = true
		}

		for slot7, slot8 in ipairs(slot0.itemList_) do
			if ItemCfg[slot8.id].type == ItemConst.ITEM_TYPE.HERO then
				setmetatable({
					index = slot7
				}, {
					__index = slot8
				}).newTag = true

				DrawData:SetNewHeroFlag(true)
			elseif ItemCfg[slot8.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
				slot9.newTag = IllustratedData:GetNewObtainedServant(slot8.id) ~= nil

				if slot9.newTag and ItemCfg[slot8.id].rare >= 5 then
					DrawData:SetServantRedPoint(slot0.selectPoolId_, 1)
				end
			end

			table.insert(slot2, slot9)
		end

		slot4 = 0

		for slot8, slot9 in ipairs(slot0.itemList_) do
			if ItemCfg[slot9.id].type == ItemConst.ITEM_TYPE.HERO or ItemCfg[slot10].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT or ItemCfg[slot10].type == ItemConst.ITEM_TYPE.HERO_PIECE then
				slot11 = slot10

				if ItemWillConvert(slot9) then
					slot11 = slot9.convert_from.id
				end

				for slot16, slot17 in ipairs(GameSetting.currency_for_draw.value) do
					if ItemCfg[slot11].rare == slot17[1] then
						slot4 = slot4 + slot17[2]
					end
				end
			end
		end

		if slot1 ~= 1 then
			gameContext:Go("drawTenTimesReward", {
				reward = slot2,
				callBack_afterTen = function ()
					getReward({
						{
							id = ItemConst.CURRENCY_FOR_DRAW,
							num = uv0
						}
					}, nil, function ()
						if DrawPoolCfg[uv0.selectPoolId_].pool_type == 8 and DrawData:GetNewbieChooseDrawFlag() then
							ShowTips("DRAW_POOL_SCREEN_TYPE_1")
							uv0:SetupActivityPool()

							uv0.tree_.tree_.data.groupDatas[1].defaultIndex = 1

							uv0.tree_:SelectItem(1, 1)
						end
					end)
					uv1:ShowBar()
				end
			})
		else
			if DrawPoolCfg[slot0.selectPoolId_].pool_type == 8 and DrawData:GetNewbieChooseDrawFlag() then
				ShowTips("DRAW_POOL_SCREEN_TYPE_1")
				slot0:SetupActivityPool()

				slot0.tree_.tree_.data.groupDatas[1].defaultIndex = 1

				slot0.tree_:SelectItem(1, 1)
			end

			slot0:ShowBar()
		end
	end

	slot0:UpdateFreeDraw()
	slot0:OnRequestRecord()
end

function slot0.SkipMovie(slot0)
	slot0.criplayer_.statusChangeCallback = nil

	if slot0.moviePlaying then
		slot0.criMovie_:Stop()
	end

	slot0:DoNextNode(true)
end

function slot5(slot0)
	slot1 = {
		__index = slot0
	}

	print("BuildShowItemInfo", slot0.convert_from.id, slot0.id)

	slot5 = {}

	if ItemCfg[ItemWillConvert(slot0) and slot0.convert_from.id or slot0.id].type == ItemConst.ITEM_TYPE.HERO or slot4 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		for slot10, slot11 in ipairs(GameSetting.currency_for_draw.value) do
			if slot3.rare == slot11[1] then
				slot5.draw_rebate = slot11[2]
			end
		end
	end

	return setmetatable(slot5, slot1)
end

function slot0.DoNextNode(slot0, slot1)
	slot0.panel_.transform.localPosition = Vector2(0, 0)
	slot2 = #slot0.itemList_

	if slot1 and slot2 > 1 then
		slot3 = {}

		for slot7, slot8 in ipairs(slot0.itemList_) do
			if ItemCfg[slot8.id].type == ItemConst.ITEM_TYPE.HERO and ObtainHeroMovieCfg[slot8.id] and not (getData(DrawConst.WATCH_TAG, tostring(slot8.id)) or false) then
				table.insert(slot3, uv0(slot8))
			end
		end

		if #slot3 == 0 then
			slot0:JumpToReward()
		else
			slot5 = handler(slot0, slot0.JumpToReward)

			slot0:Go("obtainView", {
				doNextHandler = slot5,
				skipHandler = slot5,
				itemList = slot3
			})
		end

		return
	end

	if slot2 > 0 then
		slot3 = {}

		for slot7, slot8 in ipairs(slot0.itemList_) do
			if slot2 == 1 and ItemCfg[ItemWillConvert(slot8) and slot8.convert_from.id or slot8.id].type == ItemConst.ITEM_TYPE.HERO and ItemWillConvert(slot8) then
				DrawData:SetNewHeroFlag(true)
			end

			table.insert(slot3, uv0(slot8))
		end

		slot0:Go("obtainView", {
			doNextHandler = handler(slot0, slot0.JumpToReward),
			skipHandler = handler(slot0, slot0.JumpToReward),
			itemList = slot3
		})
	else
		slot0:JumpToReward()
	end
end

function slot0.PlayMovie(slot0, slot1)
	slot0.criplayer_:SetVolume(manager.audio:GetMusicVolume())
	slot0.criMovie_:Play()

	slot0.criplayer_.statusChangeCallback = handler(slot0, slot0.CirMovieStatusChange)
	slot0.moviePlaying = true

	if slot1 >= 5 then
		manager.audio:SetObtainGoldSelectorLabel()
	elseif slot1 >= 4 then
		manager.audio:SetObtainPurpleSelectorLabel()
	else
		manager.audio:SetObtainBlueSelectorLabel()
	end

	manager.audio:PlayEffect("ui_system_search", "search_animation", "")
	SetActive(slot0.movieGo_, true)
end

function slot0.CirMovieStatusChange(slot0, slot1)
	if tostring(slot1) == "PlayEnd" or slot2 == "Stop" then
		slot0:DoNextNode(false)
	end
end

function slot0.StopMovie(slot0)
	slot0.criplayer_.statusChangeCallback = nil
	slot0.moviePlaying = false

	SetActive(slot0.movieGo_, false)
end

function slot0.SkipInteract(slot0)
	SetActive(slot0.drawInteractGo_, false)

	if slot0.drawInteract.timeline then
		slot0.drawInteract.timeline:Stop()
	end

	slot0:DoNextNode(true)
end

function slot0.CheckInteract(slot0, slot1)
	slot0.maxRare = slot1

	if not DrawTools:LevelIsDone() then
		SetForceShowQuanquan(true)

		if slot0.interactTimer then
			slot0.interactTimer:Stop()

			slot0.interactTimer = nil
		end

		slot0.interactTimer = FrameTimer.New(handler(slot0, slot0.WaitInteract), 1, -1)

		slot0.interactTimer:Start()
	else
		slot0:StarInteract()
	end
end

function slot0.WaitInteract(slot0)
	if DrawTools:LevelIsDone() then
		SetForceShowQuanquan(false)

		if slot0.interactTimer then
			slot0.interactTimer:Stop()

			slot0.interactTimer = nil
		end

		slot0:StarInteract()
	end
end

function slot0.StarInteract(slot0)
	if (slot0.maxRare or 0) >= 5 then
		slot0.criplayer_:SetFile(nil, slot0.moviePaths[3])
	elseif slot1 >= 4 then
		slot0.criplayer_:SetFile(nil, slot0.moviePaths[2])
	else
		slot0.criplayer_:SetFile(nil, slot0.moviePaths[1])
	end

	slot2 = nil

	if (slot1 < 5 or GameObject.Find("X102/TC/directors/director_gold")) and (slot1 < 4 or GameObject.Find("X102/TC/directors/director_purple")) and GameObject.Find("X102/TC/directors/director_blue") then
		slot0.drawInteract:Init(slot2:GetComponent("PlayableDirector"), handler(slot0, slot0.StopInteract))
		slot0.drawInteract:Reset()

		slot0.panel_.transform.localPosition = Vector2(9999, 9999)

		SetActive(slot0.drawInteractGo_, true)
	else
		slot0:StopInteract()
	end

	if slot0.selectPoolId_ and slot0.selectPoolId_ ~= 0 and slot0.selectPoolId_ ~= -1 then
		slot0:HidePoolNewTag(slot0.selectPoolId_, true)
	end
end

function slot0.StopInteract(slot0)
	SetActive(slot0.drawInteractGo_, false)
	slot0:PlayMovie(slot0.maxRare or 0)
end

function slot0.Dispose(slot0)
	slot0.currencyModifyHandler_ = nil
	slot0.timer = nil

	slot0:DestroyPoolGo()
	slot0.tree_:Dispose()

	slot0.drawHandler_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.CurrencyModify(slot0)
	slot0:RefreshRightPanel()
end

function slot0.UpdateFirstSelectButton(slot0, slot1)
	SetActive(slot0.chooseBtn_.gameObject, not slot1)
	SetActive(slot0.btnOnce_.gameObject, slot1)
	SetActive(slot0.btnTenth_.gameObject, slot1)

	slot0.chooseText_.text = GetTips(DrawPoolCfg[slot0.selectPoolId_].pool_selected_type == 9 and "DRAW_WEAPON_BUTTON" or "DRAW_CHARACTER_BUTTON")
end

function slot0.OnInviteDrawUpdate(slot0)
	slot0:UpdateFreeDraw()
end

function slot0.AdaptRight(slot0)
	uv0.super.AdaptRight(slot0)

	if uv0.VIEW_ADAPT_DISTANCE == slot0.lastAdaptDistance_ then
		return
	end

	if not uv0.NEED_ADAPT then
		slot0.btnSkip_.transform.anchoredPosition = Vector3(0, 0, 0)
		slot0.skipInteractBtn_.transform.anchoredPosition = Vector3(0, 0, 0)
	else
		slot0.btnSkip_.transform.anchoredPosition = Vector3(-1 * uv0.VIEW_ADAPT_DISTANCE, 0, 0)
		slot0.skipInteractBtn_.transform.anchoredPosition = Vector3(-1 * uv0.VIEW_ADAPT_DISTANCE, 0, 0)
	end
end

return slot0
