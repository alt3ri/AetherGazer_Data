slot1 = class("ActivityHeroEnhanceSectionInfoView", import("game.views.sectionInfo.SectionInfoBaseView"))

function slot1.Init(slot0)
	uv0.super.Init(slot0)

	slot0.sectionInfoThreeStarBar_ = SectionInfoThreeStarBar.New(slot0.threeStarGo_)

	slot0.hideThreeStarController_:SetSelectedState("false")
	slot0.hideStageDescController_:SetSelectedState("false")
	slot0.btnWebController_:SetSelectedState("notshow")
end

function slot1.OnClickBtn(slot0)
	slot3 = {
		[TalentTreeCfg[slot8].stage] = slot8
	}

	for slot7, slot8 in ipairs(ActivityHeroEnhanceTools.GetCfgActivatedTalentList(ActivityHeroEnhanceCfg[slot0.params_.heroEnhance_CfgID])) do
		-- Nothing
	end

	slot4 = nil

	for slot9 = 1, ActivityHeroEnhanceTools.GetCfgTalentMaxStage(slot1) do
		if not slot3[slot9] and not ActivityHeroEnhanceTools.IsCfgTalentStageLock(slot1, slot9) then
			slot4 = slot9

			break
		end
	end

	if slot4 then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_HERO_ENHANCE_TALENT_NOT_SELECT"),
			BtnText = {
				[2] = GetTips("ACTIVITY_HERO_ENHANCE_BUTTON_CONTINUE"),
				[3] = GetTips("ACTIVITY_HERO_ENHANCE_BUTTON_GO_SELECT")
			},
			OkCallback = function ()
				JumpTools.OpenPageByJump("/activityHeroEnhanceHero", {
					activityID = uv0.activity_id,
					cfgId = uv0.id,
					stageToView = uv1
				})
			end,
			CancelCallback = function ()
				uv0:GoBattle()
			end
		})
	else
		slot0:GoBattle()
	end
end

function slot1.GoBattle(slot0)
	slot1 = slot0.stageID_
	slot2 = BattleStageTools.GetStageCfg(slot0.stageType_, slot1)

	gameContext:Go("/sectionSelectHero", {
		section = slot1,
		sectionType = slot0.stageType_,
		activityID = slot0.params_.activityID,
		heroEnhance_CfgID = slot0.params_.heroEnhance_CfgID
	})
end

function slot1.RefreshData(slot0)
	uv0.super.RefreshData(slot0)

	slot0.lock_ = not ActivityHeroEnhanceTools.IsCfgStageUnlock(ActivityHeroEnhanceCfg[slot0.params_.heroEnhance_CfgID], slot0.stageID_)
	slot0.lockTips_ = GetTips("ERROR_STAGE_NOT_CLEAR")
	slot0.dropLibID_ = BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).drop_lib_id
	slot3 = ActivityHeroEnhanceData:IsStageClear(slot0.params_.activityID, slot0.stageID_)
	slot0.isFirstClear_ = not slot3
	slot0.cost = 0
	slot0.threeStarDataList_ = {
		{
			slot3,
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
end

function slot1.RefreshStageInfo(slot0)
	slot1 = BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_)
	slot0.sectionName_.text = GetI18NText(slot1.name)
	slot0.storyText_.text = GetI18NText(slot1.tips)
end

function slot1.RefreshUI(slot0)
	uv0.super.RefreshUI(slot0)
	slot0.sectionInfoThreeStarBar_:SetData(slot0.threeStarDataList_)
end

function slot1.Dispose(slot0)
	slot0.sectionInfoThreeStarBar_:Dispose()

	slot0.sectionInfoThreeStarBar_ = nil

	uv0.super.Dispose(slot0)
end

return slot1
