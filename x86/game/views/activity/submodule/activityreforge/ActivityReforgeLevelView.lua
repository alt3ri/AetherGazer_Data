slot0 = class("ActivityReforgeLevelView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeLevelUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()

	slot0.isShowRewardPanel_ = false
	slot0.isSelectLevel_ = false
	slot0.levelID_ = 0
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.levelItemList_ = {}
	slot0.levelItemClickHandler_ = handler(slot0, slot0.OnLevelItemClick)

	for slot4 = 1, 6 do
		slot0.levelItemList_[slot4] = ActivityReforgeLevelViewItem.New(slot0["levelItemGo" .. slot4 .. "_"], slot0.levelItemClickHandler_)
	end

	slot0.isPassController_ = slot0.controllerEx_:GetController("ispass")
	slot0.isBattlingController_ = slot0.controllerEx_:GetController("isbattling")
	slot0.isSelectController_ = slot0.controllerEx_:GetController("isselect")
	slot0.isGetAllRewardController_ = slot0.controllerEx_:GetController("isGetAllReward")
	slot0.levelIndexController_ = slot0.controllerEx_:GetController("levelIndex")
	slot0.timeInfoItem_ = ActivityReforgeLevelFinishItem.New(slot0.timeInfoGo_)
	slot0.pointInfoItem_ = ActivityReforgeLevelFinishItem.New(slot0.pointInfoGo_)
	slot0.goldInfoItem_ = ActivityReforgeLevelFinishItem.New(slot0.goldInfoGo_)
end

function slot0.OnLevelItemClick(slot0, slot1)
	slot0.curLevelItemIndex_ = slot1
	slot0.levelID_ = slot0.cfg_.level_list[slot0.curLevelItemIndex_]
	slot0.isSelectLevel_ = true

	slot0.isSelectController_:SetSelectedState("true")
	slot0:RefreshLevelItemSelect()
	slot0:RefreshLevelInfoUI()
end

function slot0.RefreshLevelItem(slot0)
	for slot4 = 1, 6 do
		if slot4 <= #slot0.cfg_.level_list then
			slot0.levelItemList_[slot4]:SetActive(true)
			slot0.levelItemList_[slot4]:SetData(slot4, slot0.chapterActivityID_, slot0.cfg_.level_list[slot4])
			slot0.levelItemList_[slot4]:RefreshSelect(slot0.curLevelItemIndex_)
		else
			slot0.levelItemList_[slot4]:SetActive(false)
		end
	end
end

function slot0.RefreshLevelItemSelect(slot0)
	for slot4 = 1, #slot0.cfg_.level_list do
		slot0.levelItemList_[slot4]:RefreshSelect(slot0.curLevelItemIndex_)
	end
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.goldInfoBtn_, nil, function ()
		JumpTools.OpenPageByJump("activityReforgeGoldInfoView")
	end)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		if ActivityReforgeData:GetCurLevel() ~= 0 then
			ShowMessageBox({
				content = GetTips("ACTIVITY_REFORGE_RESTART_LEVEL_TIPS"),
				OkCallback = function ()
					ActivityReforgeAction.StartLevel(uv0.chapterActivityID_, uv0.levelID_, function ()
						JumpTools.OpenPageByJump("/activityReforgeWaveView", {
							activityID = uv0.activityID_,
							chapterActivityID = uv0.chapterActivityID_,
							levelID = uv0.levelID_
						})
					end)
				end
			})
		else
			ActivityReforgeAction.StartLevel(uv0.chapterActivityID_, uv0.levelID_, function ()
				JumpTools.OpenPageByJump("/activityReforgeWaveView", {
					activityID = uv0.activityID_,
					chapterActivityID = uv0.chapterActivityID_,
					levelID = uv0.levelID_
				})
			end)
		end
	end)
	slot0:AddBtnListener(slot0.giveUpBtn_, nil, function ()
		ShowMessageBox({
			content = GetTips("ACTIVITY_REFORGE_IS_GIVEUP_CURLEVEL"),
			OkCallback = function ()
				ActivityReforgeAction.GiveUpCurLevel(uv0.chapterActivityID_, uv0.cfg_.level_list[uv0.curLevelItemIndex_])
			end
		})
	end)
	slot0:AddBtnListener(slot0.continueBtn_, nil, function ()
		slot0 = ActivityReforgeLevelCfg[uv0.levelID_].wave_list

		if ActivityReforgeData:GetCurLevel() ~= 0 and ActivityReforgeData:GetCurLastWinWaveID() == 0 then
			JumpTools.OpenPageByJump("/activityReforgeWaveView", {
				activityID = uv0.activityID_,
				chapterActivityID = uv0.chapterActivityID_,
				levelID = uv0.levelID_
			})
		elseif slot0[#slot0] == slot1 then
			JumpTools.OpenPageByJump("activityReforgeBattleInfoView", {
				activityID = uv0.activityID_,
				chapterActivityID = uv0.chapterActivityID_,
				levelID = uv0.levelID_,
				waveID = slot1
			})
		else
			JumpTools.OpenPageByJump("/activityReforgeTrimView", {
				activityID = uv0.activityID_,
				chapterActivityID = uv0.chapterActivityID_,
				levelID = uv0.levelID_
			})
		end
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if uv0.isShowRewardPanel_ then
			uv0.isShowRewardPanel_ = false
		else
			uv0.isShowRewardPanel_ = true
		end

		SetActive(uv0.rewardPanel_, uv0.isShowRewardPanel_)
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		if uv0.isSelectLevel_ then
			uv0.curLevelItemIndex_ = 0
			uv0.levelID_ = 0
			uv0.isSelectLevel_ = false

			uv0.isSelectController_:SetSelectedState("false")
			uv0:RefreshLevelItemSelect()
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.chapterActivityID_ = slot0.params_.chapterActivityID
	slot0.cfg_ = ActivityReforgeChapterCfg[slot0.chapterActivityID_]
	slot0.curLevelItemIndex_ = 0
	slot0.levelID_ = 0
	slot0.isSelectLevel_ = false

	slot0.isSelectController_:SetSelectedState("false")
	slot0:RefreshUI()
	slot0:CheckCacheAddGoldNum()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_REFORGE_GAMEHELPKEY")
end

function slot0.OnExit(slot0)
	slot0:StopAddGoldNumTimer()
	manager.windowBar:HideBar()
end

function slot0.RefreshUI(slot0)
	slot0.goldMaxNum_.text = ActivityReforgeData:GetGoldMaxNum(slot0.activityID_)
	slot0.rewardNum_.text = "+" .. slot0.cfg_.reward_money
	slot1 = ActivityReforgeData:GetChapterFinishLevelNum(slot0.chapterActivityID_)
	slot0.passSlider_.value = slot1 / #slot0.cfg_.level_list
	slot0.passNum_.text = slot1 .. "/" .. #slot0.cfg_.level_list
	slot0.chapterName_.text = slot0.cfg_.chapter_name

	if slot1 >= #slot0.cfg_.level_list then
		slot0.isGetAllRewardController_:SetSelectedState("true")
	else
		slot0.isGetAllRewardController_:SetSelectedState("false")
	end

	slot0:RefreshLevelItem()
	slot0:RefreshLevelInfoUI()
end

function slot0.RefreshLevelInfoUI(slot0)
	if slot0.isSelectLevel_ == false then
		return
	end

	if slot0.levelID_ == ActivityReforgeData:GetCurLevel() then
		slot0.isBattlingController_:SetSelectedState("true")
	else
		slot0.isBattlingController_:SetSelectedState("false")
	end

	slot0.isPassController_:SetSelectedState("false")

	if ActivityReforgeData:GetLevelIsFinish(slot0.chapterActivityID_, slot0.levelID_) then
		ActivityReforgeAction.RequestAllPlayerLevelData(slot0.chapterActivityID_, slot0.levelID_, function ()
			uv0:RefreshLevelFinishUI()
		end)
	end

	slot1 = ActivityReforgeLevelCfg[slot0.levelID_]
	slot0.levelName_.text = slot1.name
	slot0.levelDes_.text = slot1.description
	slot0.levelRewardNum_.text = "+" .. slot1.reward_money

	slot0.levelIndexController_:SetSelectedState(table.indexof(slot0.cfg_.level_list, slot0.levelID_))
end

function slot0.RefreshLevelFinishUI(slot0)
	slot0.isPassController_:SetSelectedState("true")

	slot1 = ActivityReforgeGameSettingCfg[slot0.activityID_].bar_num_min
	slot2 = ActivityReforgeData:GetBestFinishLevelServerData(slot0.levelID_)
	slot3 = ActivityReforgeData:GetLevelAllPlayerServerData(slot0.levelID_)
	slot0.levelName_.text = ActivityReforgeLevelCfg[slot0.levelID_].name

	slot0.timeInfoItem_:SetData(1, slot1, slot0.levelID_, slot2.minUseSeconds, slot3.minUseSeconds.rangeValue, slot3.minUseSeconds.rangeLength)
	slot0.pointInfoItem_:SetData(2, slot1, slot0.levelID_, slot2.minLosePoint, slot3.minLosePoint.rangeValue, slot3.minLosePoint.rangeLength)
	slot0.goldInfoItem_:SetData(3, slot1, slot0.levelID_, slot2.minUseGold, slot3.minUseGold.rangeValue, slot3.minUseGold.rangeLength)
end

function slot0.OnActivityReforgeGiveUpLevel(slot0)
	slot0:RefreshLevelItem()
	slot0:RefreshLevelInfoUI()
end

function slot0.CheckCacheAddGoldNum(slot0)
	if ActivityReforgeData:GetCacheAddGoldNum() > 0 then
		slot0.goldAddText_.text = "+" .. slot1

		SetActive(slot0.goldAddGo_, true)
		slot0:StopAddGoldNumTimer()

		slot0.addGoldNumCacheTimer_ = Timer.New(function ()
			uv0:StopAddGoldNumTimer()
			SetActive(uv0.goldAddGo_, false)

			uv0.goldMaxNum_.text = ActivityReforgeData:SubGoldMaxNum(uv0.activityID_, uv1)

			ActivityReforgeData:ClearCacheAddGoldNum()
		end, 2, 1)

		slot0.addGoldNumCacheTimer_:Start()
	else
		SetActive(slot0.goldAddGo_, false)
	end
end

function slot0.StopAddGoldNumTimer(slot0)
	if slot0.addGoldNumCacheTimer_ then
		slot0.addGoldNumCacheTimer_:Stop()

		slot0.addGoldNumCacheTimer_ = nil
	end
end

function slot0.Dispose(slot0)
	for slot4 = 1, 6 do
		slot0.levelItemList_[slot4]:Dispose()
	end

	slot0.levelItemList_ = nil
	slot0.levelItemClickHandler_ = nil

	slot0.timeInfoItem_:Dispose()
	slot0.pointInfoItem_:Dispose()
	slot0.goldInfoItem_:Dispose()

	slot0.timeInfoItem_ = nil
	slot0.pointInfoItem_ = nil
	slot0.goldInfoItem_ = nil

	slot0:StopAddGoldNumTimer()
	slot0.super.Dispose(slot0)
end

return slot0
