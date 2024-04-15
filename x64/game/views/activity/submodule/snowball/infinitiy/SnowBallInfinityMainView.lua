slot0 = class("SnowBallInfinityMainView", ReduxView)
slot1 = 201061

function slot2(slot0)
	for slot5, slot6 in pairs(slot0) do
		slot1 = 0 + 1
	end

	return slot1
end

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/JapanRegionSnowballIceUI"
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
	slot0:AdaptScreen()

	slot0.itemViewList = {}
	slot0.list = LuaList.New(handler(slot0, slot0.SetItemData), slot0.listGo_, SnowBallInfinityItem)
	slot0.levelList = LuaList.New(handler(slot0, slot0.SetLevelItemData), slot0.levelGo_, SnowBallInfinityLevelItem)
	slot0.mainRewardItem = CommonItem.New(slot0.commonItemGo_)
	slot0.levelControllerList = {}
end

function slot0.SetItemData(slot0, slot1, slot2)
	slot2:SetData(slot0.poolID, slot1, slot0.phase, handler(slot0, slot0.UpdateLevelList), slot0.maskGo_)
end

function slot0.SetLevelItemData(slot0, slot1, slot2)
	slot2:SetData(slot0.poolID, slot1, slot0.activityID, slot0.phase, handler(slot0, slot0.SelectListener))

	slot0.levelControllerList[slot1] = slot2:GetController()

	SetActive(slot2.redGo_, slot0:ShowRedPoint(slot1))
end

function slot0.AddUIListener(slot0)
	function slot1()
		OsirisAction.ResetPool(uv0.poolID, function (slot0)
			if isSuccess(slot0.result) then
				uv0:UpdateView()
			else
				ShowTips(slot0.result)
			end
		end)
	end

	function slot2()
		if uv0(uv1.poolData.openBoxList) == uv1.count then
			ShowTips("ACTIVITY_SNOWBALL_ICE_CANTGET")

			return
		end

		slot0 = ActivityInfinityPoolCfg[uv1.poolID].cost_item

		if ItemTools.getItemNum(slot0[1]) < slot0[2] then
			ShowTips(string.format(GetTips("ACTIVITY_SNOWBALL_ICE_COST_FAILED"), ItemTools.getItemName(slot0[1])))

			return
		end

		slot2 = {}

		for slot6 = 1, uv1.count do
			if slot0[2] <= slot1 and uv1.poolData.openBoxList[slot6] == nil then
				table.insert(slot2, slot6)

				slot1 = slot1 - slot0[2]
			end
		end

		slot3 = uv1.poolData.isOpenCoreItem

		OsirisAction.OpenPoolBox(uv1.poolID, slot2, function (slot0)
			if isSuccess(slot0.result) then
				slot1 = {
					[slot5] = {
						slot6.item.id,
						slot6.item.num
					}
				}

				for slot5, slot6 in ipairs(slot0.box_list) do
					-- Nothing
				end

				slot6 = "minigame_activity_2_6_snowball_icebreak"
				slot7 = ""

				manager.audio:PlayEffect("minigame_activity_2_6_snowball", slot6, slot7)

				slot2 = {}

				for slot6, slot7 in ipairs(uv0) do
					slot10 = uv1.list
					slot12 = slot10

					for slot11, slot12 in ipairs(slot10.GetItemList(slot12)) do
						if slot7 == slot12.index then
							table.insert(slot2, slot12)
						end
					end
				end

				slot3 = 1

				SetActive(uv1.maskGo_, true)
				SetActive(slot2[1].hammerGo_, true)

				slot4 = slot2[1].hammerAnimator_:GetCurrentAnimatorClipInfo(0)[0].clip.length
				uv1.time = 0

				for slot8, slot9 in ipairs(slot2) do
					SetActive(slot9.hammerGo_, true)

					slot9.iceImage_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/JapanRegionUI2_6_00953")
				end

				uv1.isGet = false
				uv1.captionTimer = FuncTimerManager.inst:CreateFuncFrameTimer(function ()
					uv0.time = uv0.time + Time.deltaTime

					if uv0.time > uv1 * uv2 and uv2 <= uv3[2] then
						uv2 = uv2 + 1

						for slot3, slot4 in ipairs(uv4) do
							SetActive(slot4.hammerGo_, false)
							SetActive(slot4.hammerGo_, true)
						end
					end

					if uv2 == uv3[2] + 1 then
						for slot3, slot4 in ipairs(uv4) do
							slot4.animator_.enabled = true
						end

						if uv0.time > uv1 * uv3[2] + uv4[1].animator_:GetCurrentAnimatorClipInfo(0)[0].clip.length then
							slot1 = tonumber(GameSetting.activity_snowball_ice_action_delay.value[1])

							if uv0.isGet ~= true then
								uv0.isGet = true

								SetActive(uv0.maskGo_, false)
								sortMergeGetReward(uv5, nil, , , true)
								uv0:UpdateView()
								uv0:UpdateLevelList()

								if uv6 == false and uv0.poolData.isOpenCoreItem == true then
									ShowTips(string.format(GetTips("ACTIVITY_SNOWBALL_ICE_GETREAWARD"), GetI18NText(OsirisInfinityPoolData:GetOpenPhase(ActivityInfinityPoolCfg[uv0.poolID].activity_id))))
								end
							elseif uv0.time > uv1 * uv3[2] + slot0 + slot1 then
								manager.notify:Invoke(SNOWBALL_GAME_INFINITY_POOL_CLICK_ICE)
								uv0:RemoveCaptionTimer()
							end
						end
					end
				end, -1, true)

				return
			end

			ShowTips(slot0.result)
		end)
	end

	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("SnowBallInfinityRewardView", {
			poolID = uv0.poolID
		})
	end)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		if uv0.phase == #ActivityInfinityPoolCfg.get_id_list_by_activity_id[uv0.activityID] and uv1(uv0.poolData.openBoxList) == uv0.count then
			ShowMessageBox({
				isTop = true,
				content = GetTips("ACTIVITY_SNOWBALL_ICE_RESET_TIPS"),
				OkCallback = uv2
			})
		else
			uv3()
		end
	end)
	slot0:AddBtnListener(slot0.modelBtn_, nil, function ()
		manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, SnowballGameMgr.GetInstance():GetPlayerEID(), GetTips("ACTIVITY_SNOWBALL_ICE_TALK" .. math.random(1, 4)), true)
		manager.notify:Invoke(SNOWBALL_GAME_INFINITY_POOL_CLICK_MODEL)
	end)
end

function slot0.SelectListener(slot0, slot1)
	if slot0.phase == slot1 then
		return
	end

	slot6 = SnowballGameMgr.GetInstance():GetPlayerEID()

	manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, slot6, GetTips("ACTIVITY_SNOWBALL_ICE_TALK" .. math.random(1, 4)), true)

	for slot6 = 1, OsirisInfinityPoolData:GetOpenPhase(slot0.activityID) do
		slot0.levelControllerList[slot6]:SetSelectedState(slot6 == slot1 and "select" or "normal")
	end

	slot0.phase = slot1

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.poolID = ActivityInfinityPoolCfg.get_id_list_by_activity_id[slot0.activityID][slot0.phase]
	slot0.poolData = OsirisInfinityPoolData:GetPoolData(slot0.poolID)
	slot0.count = #slot0.poolData.itemList
	slot0.count = slot0.count + (slot0.poolData.coreItem == nil and 0 or 1)

	slot0.list:StartScroll(slot0.count)

	slot0.nameTxt_.text = string.format(GetTips("ACTIVITY_SNOWBALL_ICE_LEVEL"), slot0.phase)

	slot0:RefreshMainReward(slot0.poolData.coreItem)

	slot0.resetTxt_.text = GetTips(slot0:IsShowReset() and "ACTIVITY_SNOWBALL_ICE_RESET" or "ACTIVITY_SNOWBALL_ICE_AUTOGET")

	SetActive(slot0.redPointGo_, slot0:ShowRedPoint(slot0.phase))

	slot5 = slot0.levelList

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		SetActive(slot5.redGo_, slot0:ShowRedPoint(slot5.index))
	end
end

function slot0.ShowRedPoint(slot0, slot1)
	slot3 = ItemTools.getItemNum(ActivityInfinityPoolCfg[slot0.poolID].cost_item[1])

	if OsirisInfinityPoolData:GetOpenPhase(slot0.activityID) < slot1 then
		return false
	end

	slot6 = OsirisInfinityPoolData:GetPoolData(ActivityInfinityPoolCfg.get_id_list_by_activity_id[slot0.activityID][slot1])

	return uv0(slot6.openBoxList) ~= #slot6.itemList + (slot6.coreItem == nil and 0 or 1) and slot2[2] <= slot3
end

function slot0.IsShowReset(slot0)
	return slot0.phase == #ActivityInfinityPoolCfg.get_id_list_by_activity_id[slot0.activityID] and uv0(slot0.poolData.openBoxList) == slot0.count
end

function slot0.RefreshMainReward(slot0, slot1)
	if slot1 == nil or slot1[1] == 0 then
		SetActive(slot0.mainRewardGo_, false)

		return
	end

	SetActive(slot0.mainRewardGo_, true)
	slot0.mainRewardItem:RefreshData({
		id = slot1[1],
		number = slot1[2]
	})
	slot0.mainRewardItem:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.num
		})
	end)
end

function slot0.UpdateLevelList(slot0)
	slot0.levelList:StartScroll(#ActivityInfinityPoolCfg.get_id_list_by_activity_id[slot0.activityID])

	slot0.poolID = ActivityInfinityPoolCfg.get_id_list_by_activity_id[slot0.activityID][slot0.phase]
	slot0.poolData = OsirisInfinityPoolData:GetPoolData(slot0.poolID)
	slot0.resetTxt_.text = GetTips(slot0:IsShowReset() and "ACTIVITY_SNOWBALL_ICE_RESET" or "ACTIVITY_SNOWBALL_ICE_AUTOGET")

	SetActive(slot0.redPointGo_, slot0:ShowRedPoint(slot0.phase))
end

function slot0.OnEnter(slot0)
	slot0.activityID = uv0
	slot0.phase = slot0.phase or OsirisInfinityPoolData:GetOpenPhase(slot0.activityID)

	SetActive(slot0.maskGo_, false)
	slot0:UpdateLevelList()
	slot0:AddTimer()
	slot0:UpdateView()
	slot0:LoadModel()
end

function slot0.LoadModel(slot0)
	slot0.snowBallModelId = SnowballGameMgr.GetInstance():GetPlayerCfgID()

	SnowballGameMgr.GetInstance():SetPlayer(GameSetting.activity_snowball_ice_show.value[1])
	manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, SnowballGameMgr.GetInstance():GetPlayerEID(), GetTips("ACTIVITY_SNOWBALL_ICE_TALK" .. math.random(1, 4)), true)
end

function slot0.UnloadModel(slot0)
	SnowballGameMgr.GetInstance():SetPlayer(slot0.snowBallModelId)
end

function slot0.AddTimer(slot0)
	slot0.stopTime = ActivityData:GetActivityData(slot0.activityID).stopTime

	if slot0.stopTime <= manager.time:GetServerTime() then
		slot0.remainTxt_.text = GetTips("TIME_OVER")

		return
	end

	slot0.remainTxt_.text = manager.time:GetLostTimeStr(slot0.stopTime)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime <= manager.time:GetServerTime() then
			if uv0.timer_ then
				uv0.timer_:Stop()

				uv0.timer_ = nil
			end

			uv0.remainTxt_.text = GetTips("TIME_OVER")

			return
		end

		uv0.remainTxt_.text = manager.time:GetLostTimeStr(uv0.stopTime)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.RemoveCaptionTimer(slot0)
	if slot0.captionTimer then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.captionTimer)

		slot0.captionTimer = nil
	end
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0:UnloadModel()

	slot3 = slot0.list
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.GetItemList(slot5)) do
		slot5:OnExit()
	end

	slot0:RemoveCaptionTimer()
	manager.windowBar:HideBar()
end

function slot0.OnTop(slot0)
	slot2 = ActivityInfinityPoolCfg[ActivityInfinityPoolCfg.get_id_list_by_activity_id[slot0.activityID][1]].cost_item

	manager.windowBar:SetGameHelpKey("ACTIVITY_SNOWBALL_DESC2")
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		slot2[1]
	})
	manager.windowBar:SetBarCanAdd(slot2[1], true)
end

function slot0.Dispose(slot0)
	if slot0.list then
		slot0.list:Dispose()

		slot0.list = nil
	end

	if slot0.levelList then
		slot0.levelList:Dispose()

		slot0.levelList = nil
	end

	slot0.mainRewardItem:Dispose()
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
