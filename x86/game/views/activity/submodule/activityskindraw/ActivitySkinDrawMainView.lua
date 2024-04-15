slot0 = class("ActivitySkinDrawMainView", ReduxView)

function slot0.UIName(slot0)
	return ActivitySkinDrawTools.GetMainUIName(slot0.params_.activityID)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.skinFloorRewardItem_ = {}
	slot0.sceneFloorRewardItem_ = {}
	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.drawCon_ = ControllerUtil.GetController(slot0.transform_, "draw")

	slot0:InitActivityData()

	slot0.skinPoolCon_ = {}
	slot0.skinPoolBtn_ = {}
	slot0.skinPoolSelectIcon_ = {}
	slot0.skinPoolUnelectIcon_ = {}

	for slot4, slot5 in ipairs(ActivityLimitedDrawPoolListCfg[slot0.skinPoolID_].main_icon_info) do
		slot0.skinPoolBtn_[slot4] = slot0["skinPoolBtn_" .. slot4]
		slot0.skinPoolSelectIcon_[slot4] = slot0["skinPoolSelectIcon_" .. slot4]
		slot0.skinPoolUnelectIcon_[slot4] = slot0["skinPoolUnelectIcon_" .. slot4]
		slot0.skinPoolCon_[slot4] = ControllerUtil.GetController(slot0.transform_, "skin_" .. slot4)
	end

	slot0.sceneCon_ = ControllerUtil.GetController(slot0.transform_, "scene")
	slot0.criMovie_ = slot0.movieGo_:GetComponent("CriManaMovieControllerForUI")
	slot0.criplayer_ = slot0.criMovie_.player

	slot0.criplayer_:SetMaxPictureDataSize(300000)
end

function slot0.InitActivityData(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
	slot0.cfg_ = ActivityCfg[slot0.activityID_]
	slot1 = slot0.cfg_.sub_activity_list
	slot0.skinDrawActivityID_ = slot1[1]
	slot0.sceneDrawActivityID_ = slot1[2]
	slot0.taskActiivtyID_ = ActivitySkinDrawTools.GetTaskActivityID(slot0.activityID_)
	slot0.skinPoolID_ = slot0:GetPoolID(slot0.skinDrawActivityID_)
	slot0.scenePoolID_ = slot0:GetPoolID(slot0.sceneDrawActivityID_)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.storyBtn_, nil, function ()
		manager.story:StartStoryById(ActivitySkinDrawTools.GetStoryID(uv0.activityID_), function ()
		end)
	end)
	slot0:AddBtnListener(slot0.taskBtn_, nil, function ()
		JumpTools.OpenPageByJump("/activitySkinDrawTask", {
			activityID = uv0.activityID_,
			taskActivityID = uv0.taskActiivtyID_
		})
	end)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		if not ShopTools.IsShopOpen(ActivitySkinDrawTools.GetActivityShopID(uv0.activityID_)) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.GoToSystem("/shop", {
			shopId = slot0,
			showShops = {
				slot0
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.pvBtn_, nil, function ()
		if not SkinCfg[uv0.skinID_].video_url or slot0 == "" then
			return
		end

		if not SDKTools.IsSDK() then
			Application.OpenURL(slot0)
		else
			LuaForUtil.OpenWebView(slot0, true, function ()
				manager.audio:PauseAll(true)
				print("--->> open webView")
			end, function ()
				print("====>>> close webView")
				manager.audio:PauseAll(false)
			end)
		end
	end)
	slot0:AddBtnListener(slot0.sceneTrailBtn_, nil, function ()
		JumpTools.OpenPageByJump("/scenePreview", {
			sceneID = uv0.sceneID_
		})
	end)
	slot0:AddBtnListener(slot0.infoSkinBtn_, nil, function ()
		JumpTools.OpenPageByJump("skinDrawInfo", {
			poolID = uv0.skinPoolID_,
			poolActivityID = uv0.skinDrawActivityID_
		})
	end)
	slot0:AddBtnListener(slot0.infoSceneBtn_, nil, function ()
		JumpTools.OpenPageByJump("skinDrawInfo", {
			poolID = uv0.scenePoolID_,
			poolActivityID = uv0.sceneDrawActivityID_
		})
	end)
	slot0:AddBtnListener(slot0.skinSelectBtn_, nil, function ()
		uv0.curPoolID_ = uv0.skinPoolID_

		uv0:RefreshCurPool()
	end)
	slot0:AddBtnListener(slot0.sceneSelectBtn_, nil, function ()
		uv0.curPoolID_ = uv0.scenePoolID_

		uv0:RefreshCurPool()
	end)
	slot0:AddBtnListener(slot0.oneBtn_, nil, function ()
		uv0:DrawCheck(1)
	end)
	slot0:AddBtnListener(slot0.tenBtn_, nil, function ()
		uv0:DrawCheck(10)
	end)

	slot4 = nil

	function slot5()
		ShowPopItem(POP_ITEM, {
			uv0.sceneID_
		})
	end

	slot0:AddBtnListener(slot0.sceneBtn_, slot4, slot5)

	for slot4, slot5 in ipairs(ActivityLimitedDrawPoolListCfg[slot0.skinPoolID_].main_icon_info) do
		slot8 = ActivityLimitedDrawPoolCfg[slot5[1]].reward[1][1]

		slot0:AddBtnListener(slot0["skinPoolBtn_" .. slot4], nil, function ()
			ShowPopItem(POP_ITEM, {
				uv0
			})
		end)
	end
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
	slot0:RefreshBar()
	slot0:BindRedPoint()
	slot0:CheckSceneDrawed()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshMovie()
	slot0:RefreshTime()
	slot0:RefreshPool()
end

function slot0.RefreshMovie(slot0)
	slot0.criMovie_:Stop()

	slot2 = deepClone(ObtainSkinBackgroundMovieCfg[slot0.activityID_].start_path)

	if ActivitySkinDrawData:GetLastFile(slot0.activityID_) then
		table.remove(slot2, table.indexof(slot2, slot3))
	end

	slot5 = slot2[math.random(#slot2)]

	slot0.criplayer_:SetVolume(manager.audio:GetMusicVolume())
	slot0:StopFrameTimer()

	slot0.frameTimer_ = FrameTimer.New(function ()
		if tostring(uv0.criplayer_.status) == "Stop" then
			uv0.criplayer_:SetFile(nil, uv1, CriMana.Player.SetMode.New)
			ActivitySkinDrawData:SetLastFile(uv0.activityID_, uv1)
			uv0.criMovie_:Play()
			uv0:StopFrameTimer()
		end
	end, 1, -1)

	slot0.frameTimer_:Start()
end

function slot0.StopFrameTimer(slot0)
	if slot0.frameTimer_ then
		slot0.frameTimer_:Stop()

		slot0.frameTimer_ = nil
	end
end

function slot0.RefreshTime(slot0)
	slot1 = nil

	slot0:StopTimer()

	if manager.time:GetServerTime() < slot0.stopTime_ then
		slot0.timeText_.text = manager.time:GetLostTimeStr2(slot0.stopTime_)
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1.stopTime_ - manager.time:GetServerTime()

			if uv0 <= 0 then
				uv1:StopTimer()
				uv1:RefreshTime()
			end
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.timeText_.text = GetTips("TIME_OVER")
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshPool(slot0)
	slot0:RefreshSkinPool()
	slot0:RefreshScenePool()
	slot0:GetCurPoolID()
	slot0:RefreshCurPool()
end

function slot0.RefreshSkinPool(slot0)
	slot0.skinLastRewardCnt_ = 0
	slot0.skinTotalRewardCnt_ = 0

	for slot5, slot6 in ipairs(ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[slot0.skinPoolID_] or {}) do
		slot0.skinTotalRewardCnt_ = slot0.skinTotalRewardCnt_ + ActivityLimitedDrawPoolCfg[slot6].total

		if ActivitySkinDrawData:GetDrawInfo(slot0.skinDrawActivityID_, slot6) then
			slot0.skinLastRewardCnt_ = slot0.skinLastRewardCnt_ + slot8.num
		else
			slot0.skinLastRewardCnt_ = slot0.skinLastRewardCnt_ + slot7.total
		end
	end

	for slot6, slot7 in ipairs(ActivityLimitedDrawPoolListCfg[slot0.skinPoolID_].main_icon_info) do
		slot8 = slot7[1]
		slot9 = ActivityLimitedDrawPoolCfg[slot8]

		slot0.skinPoolCon_[slot6]:SetSelectedState((ActivitySkinDrawData:GetDrawInfo(slot0.skinDrawActivityID_, slot8) and slot10.num or slot9.total) > 0 and "on" or "off")

		slot12 = slot7[2]
		slot0.skinPoolSelectIcon_[slot6].sprite = ItemTools.getItemSprite(slot12)
		slot0.skinPoolUnelectIcon_[slot6].sprite = ItemTools.getItemSprite(slot12)

		if ItemCfg[slot9.reward[1][1]].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			slot0.skinID_ = slot13
		end
	end

	for slot7, slot8 in ipairs(ActivityLimitedDrawPoolListCfg[slot0.skinPoolID_].icon_info) do
		if not slot0.skinFloorRewardItem_[slot7] then
			slot0.skinFloorRewardItem_[slot7] = ActivitySkinDrawItem.New(Object.Instantiate(slot0.templateItem_, slot0.skinRewardContent_))
		end

		SetActive(slot0.skinFloorRewardItem_[slot7].gameObject_, true)
		slot0.skinFloorRewardItem_[slot7]:SetData(slot0.skinDrawActivityID_, slot8)
	end

	for slot7 = #slot3 + 1, #slot0.skinFloorRewardItem_ do
		SetActive(slot0.skinFloorRewardItem_[slot7].gameObject_, false)
	end
end

function slot0.RefreshScenePool(slot0)
	slot0.sceneLastRewardCnt_ = 0
	slot0.sceneTotalRewardCnt_ = 0

	for slot5, slot6 in ipairs(ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[slot0.scenePoolID_] or {}) do
		slot0.sceneTotalRewardCnt_ = slot0.sceneTotalRewardCnt_ + ActivityLimitedDrawPoolCfg[slot6].total

		if ActivitySkinDrawData:GetDrawInfo(slot0.sceneDrawActivityID_, slot6) then
			slot0.sceneLastRewardCnt_ = slot0.sceneLastRewardCnt_ + slot8.num
		else
			slot0.sceneLastRewardCnt_ = slot0.sceneLastRewardCnt_ + slot7.total
		end
	end

	slot0.sceneCon_:SetSelectedState((ActivitySkinDrawData:GetDrawInfo(slot0.sceneDrawActivityID_, ActivityLimitedDrawPoolListCfg[slot0.scenePoolID_].main_icon_info[1][1]) and slot4.num or ActivityLimitedDrawPoolCfg[slot3].total) > 0 and "on" or "off")

	slot0.sceneID_ = ActivityLimitedDrawPoolCfg[slot3].reward[1][1]

	for slot12, slot13 in ipairs(ActivityLimitedDrawPoolListCfg[slot0.scenePoolID_].icon_info) do
		if not slot0.sceneFloorRewardItem_[slot12] then
			slot0.sceneFloorRewardItem_[slot12] = ActivitySkinDrawItem.New(Object.Instantiate(slot0.templateItem_, slot0.sceneRewardContent_))
		end

		SetActive(slot0.sceneFloorRewardItem_[slot12].gameObject_, true)
		slot0.sceneFloorRewardItem_[slot12]:SetData(slot0.sceneDrawActivityID_, slot13)
	end

	for slot12 = #slot8 + 1, #slot0.sceneFloorRewardItem_ do
		SetActive(slot0.sceneFloorRewardItem_[slot12].gameObject_, false)
	end
end

function slot0.GetPoolID(slot0, slot1)
	for slot6, slot7 in ipairs(ActivityLimitedDrawPoolListCfg.all) do
		if table.indexof(ActivityLimitedDrawPoolListCfg[slot7].activity_id, slot1) then
			return slot7
		end
	end

	return 0
end

function slot0.GetCurPoolID(slot0)
	slot0.curPoolID_ = ActivitySkinDrawData:GetCurDrawPool(slot0.activityID_)

	if not slot0.curPoolID_ then
		slot0.curPoolID_ = slot0.skinPoolID_
	end
end

function slot0.RefreshCurPool(slot0)
	slot1 = 0

	if slot0.curPoolID_ == slot0.skinPoolID_ then
		slot0.typeCon_:SetSelectedState("skin")

		slot1 = slot0.skinLastRewardCnt_
	elseif slot0.curPoolID_ == slot0.scenePoolID_ then
		slot0.typeCon_:SetSelectedState("scene")

		slot1 = slot0.sceneLastRewardCnt_
	end

	if slot1 >= 10 then
		slot0.drawCon_:SetSelectedState("ten")
	elseif slot1 > 0 then
		slot0.drawCon_:SetSelectedState("one")
	else
		slot0.drawCon_:SetSelectedState("none")
	end

	slot2 = ActivityLimitedDrawPoolListCfg[slot0.curPoolID_].cost_once[1]
	slot0.drawIcon_1.sprite = ItemTools.getItemSprite(slot2)
	slot0.drawIcon_2.sprite = ItemTools.getItemSprite(slot2)

	slot0.btnAni_:Play("btn_show", -1, 0)
end

function slot0.CheckSceneDrawed(slot0)
	if slot0.params_.isSceneDrawed then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("GENGCHEN_SWIMWEAR_CHANGE_SCENE"), ItemTools.getItemName(slot0.sceneID_)),
			OkCallback = function ()
				JumpTools.OpenPageByJump("/scenePreview", {
					sceneID = uv0.sceneID_
				})
			end
		})
	end

	slot0.params_.isSceneDrawed = false
end

function slot0.DrawCheck(slot0, slot1)
	if not slot0.activityData_:IsActivitying() then
		ShowTips("TIME_OVER")
	end

	if not _G.SkipTip.SkipActivitySkinDrawTip then
		slot2 = nil
		slot3 = true

		if slot0.curPoolID_ == slot0.skinPoolID_ then
			slot2 = slot0.skinID_
			slot3 = HeroTools.IsSkinUnlock(slot0.skinID_)
		else
			slot2 = slot0.sceneID_
			slot3 = HomeSceneSettingData:IsUnlockScene(slot0.sceneID_)
		end

		if slot3 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("GENGCHEN_SWIMWEAR_CONTINUE"), ItemTools.getItemName(slot2)),
				OkCallback = function ()
					_G.SkipTip.SkipActivitySkinDrawTip = uv0.SkipActivitySkinDrawTip_

					uv0:AfterCheck(uv1)
				end,
				ToggleCallback = function (slot0)
					uv0.SkipActivitySkinDrawTip_ = slot0
				end
			})
		else
			slot0:AfterCheck(slot1)
		end
	else
		slot0:AfterCheck(slot1)
	end
end

function slot0.AfterCheck(slot0, slot1)
	if slot1 <= ItemTools.getItemNum(ActivityLimitedDrawPoolListCfg[slot0.curPoolID_].cost_once[1]) then
		slot0:StartDraw(slot1)
	else
		table.insert({}, slot2.payment_free[1])

		slot6 = getShopCfg(slot2.payment_free[1])

		for slot14, slot15 in ipairs(slot2.payment) do
			if ShopData.GetShop(getShopCfg(slot15).shop_id)[slot15] then
				if slot1 <= slot16.limit_num - (slot18.buy_times or 0) and slot1 <= slot6.limit_num - (ShopData.GetShop(slot6.shop_id)[slot2.payment_free[1]].buy_times or 0) then
					table.insert(slot5, slot15)
					slot0:GoPopView(slot1, slot5)

					break
				elseif slot19 > 0 then
					slot0:GoToShop(slot15, slot17)

					break
				end
			end
		end
	end
end

function slot0.StartDraw(slot0, slot1)
	if slot0.curPoolID_ == slot0.skinPoolID_ then
		ActivitySkinDrawAction.StartDraw(slot0.skinDrawActivityID_, slot0.skinPoolID_, slot1)
	elseif slot0.curPoolID_ == slot0.scenePoolID_ then
		ActivitySkinDrawAction.StartDraw(slot0.sceneDrawActivityID_, slot0.scenePoolID_, slot1)
	end
end

function slot0.GoPopView(slot0, slot1, slot2)
	JumpTools.OpenPageByJump("activitySkinDrawPop", {
		mainActivity = slot0.activityID_,
		poolActivityID = slot0.curPoolID_ == slot0.skinPoolID_ and slot0.skinDrawActivityID_ or slot0.sceneDrawActivityID_,
		poolID = slot0.curPoolID_,
		cnt = slot1,
		goods = slot2
	})
end

function slot0.GoToShop(slot0, slot1, slot2)
	JumpTools.GoToSystem("/shop", {
		goodId = slot1,
		shopId = slot2,
		showShops = {
			slot2
		}
	}, ViewConst.SYSTEM_ID.SHOP)
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.sceneTrailBtn_.transform, RedPointConst.SCENE .. "_" .. slot0.sceneID_)
	manager.redPoint:bindUIandKey(slot0.taskBtn_.transform, RedPointConst.ACTIVITY_TASK .. "_" .. slot0.taskActiivtyID_)
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.sceneTrailBtn_.transform, RedPointConst.SCENE .. "_" .. slot0.sceneID_)
	manager.redPoint:unbindUIandKey(slot0.taskBtn_.transform, RedPointConst.ACTIVITY_TASK .. "_" .. slot0.taskActiivtyID_)
end

function slot0.RefreshBar(slot0)
	slot1 = {
		BACK_BAR,
		HOME_BAR
	}
	slot3 = ActivityLimitedDrawPoolListCfg[slot0.skinPoolID_].cost_once[1]

	table.insert(slot1, slot3)

	slot5 = ActivityLimitedDrawPoolListCfg[slot0.scenePoolID_].cost_once[1]

	table.insert(slot1, slot5)
	table.insertto(slot1, {
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SwitchBar(slot1)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:SetBarCanAdd(slot3, true)
	manager.windowBar:SetBarCanAdd(slot5, true)
end

function slot0.OnTop(slot0)
	if slot0.skinPoolID_ and slot0.scenePoolID_ then
		slot0:RefreshBar()
	end
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	slot0:UnbindRedPoint()
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()

	for slot4, slot5 in ipairs(slot0.skinFloorRewardItem_) do
		slot0.skinFloorRewardItem_[slot4]:OnExit()
	end

	for slot4, slot5 in ipairs(slot0.sceneFloorRewardItem_) do
		slot0.sceneFloorRewardItem_[slot4]:OnExit()
	end

	ActivitySkinDrawData:SetCurDrawPool(slot0.activityID_, slot0.curPoolID_)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in ipairs(slot0.skinFloorRewardItem_) do
		slot0.skinFloorRewardItem_[slot4]:Dispose()
	end

	for slot4, slot5 in ipairs(slot0.sceneFloorRewardItem_) do
		slot0.sceneFloorRewardItem_[slot4]:Dispose()
	end

	slot0.super.Dispose(slot0)
end

return slot0
