SectionBaseView = import("game.views.sectionInfo.SectionInfoBaseView")
slot0 = class("SPHeroChallengeSectionView", SectionBaseView)

function slot0.Init(slot0)
	uv0.super.Init(slot0)
	slot0.hideStageDescController_:SetSelectedState("false")

	slot0.sectionInfoThreeStarBar_ = SectionInfoThreeStarBar.New(slot0.threeStarGo_)
end

function slot0.AddListeners(slot0)
	uv0.super.AddListeners(slot0)
	slot0:AddBtnListener(slot0.timeInfoBtn, nil, function ()
		if uv0.challengeTimeController_:GetSelectedState() == "show" then
			uv0.challengeTimeController_:SetSelectedState("showTip")

			uv0.infoTipText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_BATTLE_TIME_DESC")
		else
			uv0.challengeTimeController_:SetSelectedState("show")
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.info = SPHeroChallengeData:GetCurActivityInfo()

	uv0.super.OnEnter(slot0)
end

function slot0.UpdateBar(slot0)
end

function slot0.RefreshData(slot0)
	slot0.cfg_ = BattleStageTools.GetStageCfg(slot0.params_.sectionType, slot0.params_.section)

	slot0.hideFatigueController_:SetSelectedState("close")
	slot0.btnWebController_:SetSelectedState("close")

	if slot0.params_.challengeType == SpHeroChallengeConst.ChapterType.story then
		if SPHeroChallengeData:GetCurActivityInfo():CheckStoryFinState(slot0.params_.section) then
			slot0.challengeTimeController_:SetSelectedState("close")
		else
			slot0.challengeTimeController_:SetSelectedState("show")
		end
	elseif slot0.params_.sectionType == SpHeroChallengeConst.ChapterType.train then
		slot0.challengeTimeController_:SetSelectedState("show")
	elseif slot0.params_.sectionType == SpHeroChallengeConst.ChapterType.boss then
		slot0.challengeTimeController_:SetSelectedState("show")
		slot0.refreshTimeController_:SetSelectedState("show")
	end

	slot0.lock_, slot0.lockTips_ = SPHeroChallengeTools:CheckStageIsOpen(slot0.params_.section)
	slot0.cost_ = 0
	slot0.isFirstClear_ = slot0:CheckStageIsFirstClear(slot0.params_.section)
	slot0.dropLibID_ = BattleVerthandiExclusiveCfg[slot0.params_.section].drop_lib_id

	slot0:RefreshPlayTime()
end

function slot0.RefreshPlayTime(slot0)
	if SPHeroChallengeTools:CheckScheduleNeedCostTime(slot0.params_.section) then
		slot0.challengeTimeController_:SetSelectedState("close")

		slot0.totalNum = 0
		slot0.curNum = 0
	else
		slot0.totalNum, slot0.curNum = slot0.info:GetStartBattelScheduleByType(BattleVerthandiExclusiveCfg[slot0.params_.section].sub_type)

		slot0.challengeTimeController_:SetSelectedState("show")

		slot3 = nil
		slot0.challengeTime.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_REMAIN_TIME"), (slot0.totalNum - slot0.curNum > 0 or string.format("<color='#FF000B'>%d</color>", tostring(slot2))) and tostring(slot2), tonumber(slot0.totalNum))
	end
end

function slot0.CheckStageIsFirstClear(slot0, slot1)
	if BattleVerthandiExclusiveCfg[slot1].sub_type == SpHeroChallengeConst.ScheduleSubType.story then
		return not table.indexof(slot0.info.storyFinStageList, slot1)
	else
		return true
	end
end

function slot0.RefreshStageInfo(slot0)
	slot0.btnWebController_:SetSelectedState("notshow")

	slot0.cfg_ = BattleStageTools.GetStageCfg(slot0.params_.sectionType, slot0.params_.section)

	if slot0.cfg_ and slot0.oldCfgID_ ~= slot0.cfg_.id then
		slot0.sectionName_.text = GetI18NText(slot0.cfg_.name)
		slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot0.cfg_.background_1))
		slot0.oldCfgID_ = slot0.cfg_.id
		slot0.multiple_ = 1

		slot0.hideThreeStarController_:SetSelectedState("true")

		slot0.storyText_.text = BattleVerthandiExclusiveCfg[slot0.params_.section].tips

		if slot0.params_.challengeType == SpHeroChallengeConst.ChapterType.story then
			slot0.hideThreeStarController_:SetSelectedState("false")

			slot0.threeStarDataList_ = {
				{
					SPHeroChallengeData:GetCurActivityInfo():CheckStoryFinState(slot0.params_.section),
					{
						8
					}
				},
				{
					false
				},
				{
					false
				}
			}

			slot0.sectionInfoThreeStarBar_:SetData(slot0.threeStarDataList_)
		end
	end
end

function slot0.OnClickBtn(slot0)
	slot1, slot2 = SPHeroChallengeTools:CheckStoryStageCanBattle(slot0.params_.section)

	if slot1 then
		ShowTips(slot2)

		return
	end

	slot0:GoToSelectHero()
end

function slot0.GoToSelectHero(slot0)
	if not SPHeroChallengeTools:CheckActivityCloseWithTips() then
		if (slot0.params_.challengeType == SpHeroChallengeConst.ChapterType.train or slot0.params_.challengeType == SpHeroChallengeConst.ChapterType.boss) and slot0.totalNum - slot0.curNum <= 0 then
			slot1 = ""

			if slot0.params_.challengeType == SpHeroChallengeConst.ChapterType.train then
				slot1 = "ACTIVITY_HERO_CHALLENGE_NONE_TRAIN"
			elseif slot0.params_.challengeType == SpHeroChallengeConst.ChapterType.boss then
				slot1 = "ACTIVITY_HERO_CHALLENGE_NONE_BOSS"
			end

			ShowMessageBox({
				content = GetTips(slot1),
				OkCallback = function ()
					uv0:Go("/sectionSelectHero", {
						section = uv0.params_.section,
						sectionType = uv0.params_.sectionType,
						activityID = uv0.params_.activityId,
						multiple = uv0.multiple_,
						dest = uv0.params_.index
					})
				end,
				CancelCallback = function ()
				end
			})
		else
			slot0:Go("/sectionSelectHero", {
				section = slot0.params_.section,
				sectionType = slot0.params_.sectionType,
				activityID = slot0.params_.activityId,
				multiple = slot0.multiple_,
				dest = slot0.params_.index
			})
		end
	end
end

function slot0.Dispose(slot0)
	slot0.sectionInfoThreeStarBar_:Dispose()

	slot0.sectionInfoThreeStarBar_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
