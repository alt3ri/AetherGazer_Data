slot0 = class("IndiaNianMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaNianUI/IndiaNianMainUI"
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

	slot0.stageItemList_ = {}

	for slot4 = 1, 8 do
		table.insert(slot0.stageItemList_, IndiaNianStageItem.New(slot0["stageGo_" .. slot4]))
	end

	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		slot5 = ActivityShopCfg[uv0.activityID_].activity_theme

		for slot5, slot6 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[slot5]) do
			if ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[slot6].shop_id].activity_id) and slot8:IsActivitying() then
				table.insert({}, ActivityShopCfg[slot6].shop_id)
			end
		end

		slot2, slot3 = ShopTools.IsShopOpen(slot0.shop_id)

		if slot2 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = slot0.shop_id,
				showShops = slot1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif slot3 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif slot3 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	slot0:AddBtnListener(slot0.taskBtn_, nil, function ()
		JumpTools.OpenPageByJump("indiaNianReward")
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.bossStageBtn_, nil, function ()
		IndiaNianData:SetMainSelectedIndex(0)
		uv0:SetSelectedData(uv0.bossCfg_)
	end)
	slot0:AddBtnListener(slot0.tokenBtn_, nil, function ()
		ShowPopItem(POP_ITEM, {
			IndiaNianData:GetSelectedStageCost()[1]
		})
	end)
	slot0:AddBtnListener(slot0.playBtn_, nil, function ()
		IndiaNianData:SetMainSelectedIndex(0)
		uv0:SetSelectedData(uv0.bossCfg_)
		uv0:Go("indiaNianStageInfo", {
			section = IndiaNianData:GetSelectedStageID(),
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_INDIA_NIAN,
			callback = function ()
				uv0.stateController_:SetSelectedState("main")
				IndiaNianData:SetMainSelectedIndex(-1)
				uv0:RefreshUI()
			end
		})

		uv0.ani_.enabled = false

		uv0.stateController_:SetSelectedState("detail")
	end)
	slot0:AddBtnListener(slot0.detailBtn_, nil, function ()
		JumpTools.OpenPageByJump("/indiaNianDetail")

		if IndiaNianData:GetHasUnlockBuff() then
			saveData("ActivityIndiaNian" .. uv0.activityID_ .. PlayerData:GetPlayerInfo().userID, "buffNum", IndiaNianData:GetClearBuffNum())
			manager.redPoint:setTip(RedPointConst.ACTIVITY_INDIA_NIAN_UNLOCK, 0)
		end
	end)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_INDIA_NIAN_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_INDIA_NIAN_DESC")
		})
	end)
end

function slot0.OnTaskListChange(slot0)
	slot0:RefreshUI()
end

function slot0.OnDataUpdate(slot0)
	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.activityID_ = IndiaNianData:GetActivityID()
	slot0.isInited = false

	slot0:RefreshData()
	slot0:RefreshUI()
	slot0:AddTimer()
	slot0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(slot0, slot0.RefreshUI))
	manager.redPoint:bindUIandKey(slot0.taskBtn_.transform, RedPointConst.ACTIVITY_INDIA_NIAN_REWARD)
	manager.redPoint:bindUIandKey(slot0.detailBtn_.transform, RedPointConst.ACTIVITY_INDIA_NIAN_UNLOCK)
end

function slot0.SetSelectedData(slot0, slot1)
	IndiaNianData:SetSelectedStage(slot1.stage_id)
	IndiaNianData:SetSelectedStageCost(slot1.extra_cost)
	IndiaNianData:SetSelectedDestID(slot1.id)
	slot0:RefreshStageUI()
end

function slot0.RefreshData(slot0)
	slot0.bossCfgIDList_ = IndiaNianCfg.get_id_list_by_activity_id[slot0.activityID_]
	slot0.round = IndiaNianData:GetRound()

	SetActive(slot0.maskBtn_.transform.gameObject, false)

	slot1 = {}
	slot2 = 1

	for slot7, slot8 in ipairs(slot0.bossCfgIDList_) do
		if IndiaNianCfg[slot8].group_id == 100 and slot9.round <= IndiaNianData:GetRound() and slot9.stage_type == 0 then
			slot0.bossCfg_ = slot9
		elseif slot9.group_id ~= 100 and not slot1[slot9.group_id] then
			slot0.stageItemList_[slot2]:SetData(slot2, slot9)
			slot0.stageItemList_[slot2]:SetCallBack(function (slot0)
				IndiaNianData:SetMainSelectedIndex(slot0)
				uv0:RefreshStageUI()
				uv0:Go("indiaNianStageInfo", {
					section = IndiaNianData:GetSelectedStageID(),
					sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_INDIA_NIAN,
					callback = function ()
						uv0.stateController_:SetSelectedState("main")
						IndiaNianData:SetMainSelectedIndex(-1)
						uv0:RefreshUI()
					end
				})

				uv0.ani_.enabled = false

				uv0.stateController_:SetSelectedState("detail")
			end)

			slot1[slot9.group_id] = true
			slot2 = slot2 + 1
		end
	end

	if slot0.bossCfg_.stage_type == 0 and slot0.bossCfg_.round < IndiaNianData:GetRound() or slot0.bossCfg_.round == IndiaNianData:GetRound() and IndiaNianData:GetCurrentHpByID(slot0.bossCfg_.id) == 0 then
		for slot9, slot10 in ipairs(IndiaNianCfg.get_id_list_by_group_id[slot0.bossCfg_.group_id]) do
			if IndiaNianCfg[slot10].activity_id == slot0.bossCfg_.activity_id and slot11.stage_type == 1 then
				slot0.bossCfg_ = slot11
			end
		end
	end

	if not slot0.isInited then
		if slot3 == slot0.bossCfg_.round then
			slot0:SetSelectedData(slot0.bossCfg_)
		else
			for slot8, slot9 in ipairs(slot0.stageItemList_) do
				if slot9.cfg_.round == slot3 then
					IndiaNianData:SetSelectedStage(slot9.cfg_.stage_id)
					IndiaNianData:SetSelectedStageCost(slot9.cfg_.extra_cost)

					if slot9.cfg_.round < IndiaNianData:GetRound() or slot9.cfg_.round == IndiaNianData:GetRound() and IndiaNianData:GetCurrentHpByID(slot9.cfg_.id) == 0 then
						for slot15, slot16 in ipairs(IndiaNianCfg.get_id_list_by_group_id[slot9.cfg_.group_id]) do
							if IndiaNianCfg[slot16].activity_id == slot9.cfg_.activity_id and IndiaNianCfg[slot16].stage_type == 1 then
								IndiaNianData:SetSelectedDestID(slot16)
							end
						end

						break
					end

					IndiaNianData:SetSelectedDestID(slot9.cfg_.id)

					break
				end
			end
		end

		slot0.isInited = true
	end
end

function slot0.RefreshStageUI(slot0)
	slot0.selectController_:SetSelectedState(tostring(IndiaNianData:GetMainSelectedIndex() == 0 and not not IndiaNianData:IsBossRound(IndiaNianData:GetRound())))

	for slot5, slot6 in ipairs(slot0.stageItemList_) do
		slot6:RefreshUI()
	end

	slot0.lockController_:SetSelectedState(tostring(slot1))
end

function slot0.RefreshUI(slot0)
	slot0:RefreshSliderBar()
	slot0:RefreshStageUI()

	slot0.tokenImg_.sprite = ItemTools.getItemSprite(IndiaNianData.GetSelectedStageCost()[1])
	slot0.tokenNumText_.text = ItemTools.getItemNum(IndiaNianData.GetSelectedStageCost()[1]) .. "/" .. 15
end

function slot0.RefreshSliderBar(slot0)
	if IndiaNianData:GetCurrentHpByID(slot0.bossCfg_.id) / IndiaNianData:GetTotalHp() < 0.01 and IndiaNianData:GetCurrentHpByID(slot0.bossCfg_.id) ~= 0 then
		slot1 = 0.01
	end

	slot0.percentText_.text = math.ceil(slot1 * 100) .. "%"
	slot0.barFilImg_.fillAmount = slot1
	slot0.barLineTrs_.localPosition = Vector3(slot0.barBgTrs_.rect.width * slot1 - slot0.barBgTrs_.rect.width / 2, 0, 0)
end

function slot0.AddTimer(slot0)
	slot0.leftTimeText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(slot0.activityID_).stopTime, nil, true)
	slot0.timer_ = Timer.New(function ()
		if uv0 < manager.time:GetServerTime() then
			JumpTools.OpenPageByJump("/springFestivalMainV2")

			return
		end

		uv1.leftTimeText_.text = manager.time:GetLostTimeStr2(uv0, nil, true)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(slot0.taskBtn_.transform, RedPointConst.ACTIVITY_INDIA_NIAN_REWARD)
	manager.redPoint:unbindUIandKey(slot0.detailBtn_.transform, RedPointConst.ACTIVITY_INDIA_NIAN_UNLOCK)
	manager.windowBar:HideBar()
	slot0.stateController_:SetSelectedState("main")

	slot0.ani_.enabled = true

	slot0.timer_:Stop()

	slot0.timer_ = nil
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.stageItemList_ then
		for slot4, slot5 in ipairs(slot0.stageItemList_) do
			slot5:Dispose()
		end

		slot0.stageItemList_ = nil
	end
end

return slot0
