slot0 = class("HellaMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/HellaUI/HellaMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
	slot0:InitSubmoduleButton()
end

function slot0.InitSubmoduleButton(slot0)
	slot0.submoduleBtnList_ = {
		ActivitySubmoduleItem.New(slot0.butterflyGo_, ActivityConst.HELLA_STORY_STAGE),
		ActivitySubmoduleItem.New(slot0.passGo_, ActivityConst.HELLA_BOSS_CHALLENGE),
		ActivitySubmoduleItem.New(slot0.talentGo_, ActivityConst.HELLA_TALENT_TREE),
		ActivitySubmoduleItem.New(slot0.tombGo_, ActivityConst.HELLA_CHESS),
		ActivitySkinTrialSubmoduleItem.New(slot0.skinTrialGo_, ActivityConst.HELLA_SKIN_TRIAL_STAGE),
		ActivitySubmoduleItem.New(slot0.disasterGo_, ActivityConst.HELLA_SLAYER),
		ActivitySubmoduleItem.New(slot0.missGo_, ActivityConst.HELLA_PARKOUR),
		ActivitySubmoduleItem.New(slot0.campGo_, ActivityConst.HELLA_TOWER_DEFENCE),
		ActivityHeroTrialItem.New(slot0.tryGo_, ActivityConst.HELLA_HERO_TRIAL_STAGE)
	}
end

function slot0.RefreshUI(slot0)
	slot2 = ActivityData:GetActivityData(ActivityTools.GetReprintActivityID(ActivityConst.HELLA_ACTIVITY))
	slot0.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(slot2.startTime, "!%Y.%m.%d %H:%M"), manager.time:STimeDescS(slot2.stopTime, "!%Y.%m.%d %H:%M"))
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	slot0:RefreshUI()

	slot1 = getData("activity_movie", "hella_" .. slot0.params_.activityID) ~= nil

	SetActive(slot0.movie1Go_, not slot1)
	SetActive(slot0.movie2Go_, slot1)

	if slot1 then
		slot0.mainDirector_.time = 4
	else
		slot0.mainDirector_.time = 0
	end

	slot0.mainDirector_:Play()

	slot5 = 1

	saveData("activity_movie", "hella_" .. slot0.params_.activityID, slot5)

	for slot5, slot6 in pairs(slot0.submoduleBtnList_) do
		slot6:OnEnter()
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in pairs(slot0.submoduleBtnList_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.submoduleBtnList_) do
		slot5:Dispose()
	end

	slot0.submoduleBtnList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		slot1 = ActivityShopCfg[ActivityTools.GetReprintActivityID(ActivityConst.HELLA_ACTIVITY)].shop_id

		JumpTools.GoToSystem("/shop", {
			shopId = slot1,
			showShops = {
				slot1
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.btn_warchessBtn_, nil, function ()
		JumpTools.GoToSystem("/warChessStage", {
			firstChapter = 4040301,
			chapterClientID = 404
		}, ViewConst.SYSTEM_ID.WARCHESS)
	end)
end

return slot0
