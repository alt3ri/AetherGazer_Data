slot0 = class("AdminCatExploreMainView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/ExploreUI/ExploreHome"
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

	slot0.itemViewList = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cultureBtn_, nil, function ()
		JumpTools.GoToSystem("/adminCatExploreCatCultivate", {})
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.GoToSystem("adminCatExploreReward", {})
	end)
	slot0:AddBtnListener(slot0.storeBtn_, nil, function ()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.ADMIN_CAT_SHOP,
			showShops = {
				ShopConst.SHOP_ID.ADMIN_CAT_SHOP
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
end

function slot0.UpdateBar(slot0)
end

function slot0.UpdateView(slot0)
	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end

	for slot4 = 1, 5 do
		if slot0.itemViewList[slot4] == nil then
			slot0.itemViewList[slot4] = AdminCatExploreRegionItem:New(slot0["regionItem" .. slot4 .. "_"])
		end

		slot0.itemViewList[slot4]:SetData(nil, slot4)
		slot0.itemViewList[slot4]:OnEnter()
	end

	slot0.level = AdminCatExploreData:GetDataByPara("level")
	slot0.exploreLevelImg_.sprite = getSpriteWithoutAtlas("TextureBg/ExploreUI/icon_" .. slot0.level)
	slot2 = AdminCatExploreData:GetDataByPara("exp")
	slot0.queueTxt_.text = AdminCatExploreData:GetDataByPara("exploringCount") .. "/" .. ExploreLevelCfg[slot0.level].amount
	slot0.expImage_.fillAmount = AdminCatExploreData:GetDataByPara("maxLevel") == slot0.level and 1 or slot2 / slot1.exp
	slot0.exploreDay = AdminCatExploreData:GetDataByPara("exploreDay")
	slot0.exportFill_.fillAmount = slot0.exploreDay / 7
	slot0.rateTxt_.text = "x" .. AdminCatExploreData:GetDataByPara("rate")[slot0.exploreDay]
	slot0.expTxt_.text = slot3 == slot0.level and "0/0" or slot2 .. "/" .. slot1.exp
	slot0.updateTimer_ = Timer.New(function ()
		AdminCatExploreData:UpdateRegionRedPoint()
	end, 1, -1, 1)

	slot0.updateTimer_:Start()
end

function slot0.OnGetWeeklyReward(slot0)
	slot0:UpdateView()
end

function slot0.OnEnter(slot0)
	if AdminCatExploreData:GetDataByPara("isFirstOpen") == 0 and GuideData:IsFinish(56) then
		JumpTools.OpenPageByJump("adminCatExploreFirstPop", {})
		AdminCatExploreAction.WeeklyFirstOpen()
	end

	manager.ui.cameraExtension.uiFov = 2

	slot0:UpdateView()
	slot0:BindRedPoint()
	AdminCatExploreData:UpdateQueueRedPoint()
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, RedPointConst.EXPLORE_REWARD, {
		x = 70,
		y = 70
	})
	manager.redPoint:bindUIandKey(slot0.cultureBtn_.transform, RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT, {
		x = 155,
		y = 60
	})
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, RedPointConst.EXPLORE_REWARD)
	manager.redPoint:unbindUIandKey(slot0.cultureBtn_.transform, RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT)
end

function slot0.OnExploreUpdate(slot0)
	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	slot0:UnbindRedPoint()

	manager.ui.cameraExtension.uiFov = 30

	if slot0.itemViewList then
		for slot4, slot5 in pairs(slot0.itemViewList) do
			slot5:OnExit()
		end
	end

	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end

	manager.windowBar:HideBar()
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Show(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		NAVI_BAR,
		54,
		55,
		56
	})
	manager.windowBar:SetBarCanClick(54, true)
	manager.windowBar:SetBarCanClick(55, true)
	manager.windowBar:SetBarCanClick(56, true)
	manager.windowBar:SetGameHelpKey("EXPLORE_EXPLAIN")
end

function slot0.Dispose(slot0)
	if slot0.itemViewList then
		for slot4, slot5 in pairs(slot0.itemViewList) do
			slot5:Dispose()
		end

		slot0.itemViewList = nil
	end

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
