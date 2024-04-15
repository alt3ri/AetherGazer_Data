slot0 = class("ActivityReforgeTeamItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.levelUpController_ = slot0.controllerEx_:GetController("levelUp")
	slot0.usingcontroller_ = slot0.controllerEx_:GetController("using")
	slot0.recommendcontroller_ = slot0.controllerEx_:GetController("recommend")
	slot4 = "curSelect"
	slot0.curSelectcontroller_ = slot0.controllerEx_:GetController(slot4)
	slot0.heroHeadItemList_ = {}

	for slot4 = 1, 3 do
		slot0.heroHeadItemList_[slot4] = ActivityReforgeHeroHeadItem.New(slot0["heroHeadGo" .. slot4 .. "_"])
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.resetTeamLevelBtn_, nil, function ()
		if uv0.teamInfo_ and uv0.teamInfo_.level > 1 then
			ActivityReforgeAction.ResetTeamLevel(uv0.chapterActivityID_, uv0.levelID_, uv0.teamInfo_.teamID)
		else
			ShowTips("ACTIVITY_REFORGE_TEAM_NO_LEVELUP")
		end
	end)
	slot0:AddBtnListener(slot0.teamLevelUpBtn_, nil, function ()
		if uv0.teamInfo_ and uv0.teamInfo_.level < #uv0.teamCfg_.team_info then
			ActivityReforgeAction.TeamLevelUp(uv0.chapterActivityID_, uv0.levelID_, uv0.teamInfo_.teamID, function ()
				uv0.teamInfoAni_:Play("LevelUp")
			end)
		else
			ShowTips("ACTIVITY_REFORGE_TEAM_LEVEL_MAX")
		end
	end)
	slot0:AddBtnListener(slot0.selectBtn_, nil, function ()
		if uv0.curWaveID_ == uv0.curUsingWaveID_ then
			return
		end

		if uv0.curUsingWaveID_ ~= 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("ACTIVITY_REFORGE_TEAM_USED"),
				OkCallback = function ()
					ActivityReforgeAction.SetWaveTeam(uv0.chapterActivityID_, uv0.levelID_, uv0.curWaveID_, uv0.teamInfo_.teamID, function ()
						JumpTools.Back()
					end)
				end
			})
		else
			ActivityReforgeAction.SetWaveTeam(uv0.chapterActivityID_, uv0.levelID_, uv0.curWaveID_, uv0.teamInfo_.teamID, function ()
				JumpTools.Back()
			end)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.chapterActivityID_ = slot1
	slot0.levelID_ = slot2
	slot0.curWaveID_ = slot3
	slot0.teamID_ = slot4
	slot0.teamInfo_ = ActivityReforgeData:GetTeamInfo(slot0.teamID_)
	slot0.teamCfg_ = ActivityReforgeTeamCfg[slot0.teamID_]
	slot0.curUsingWaveID_ = ActivityReforgeData:GetTeamCurUsingWaveID(slot0.teamID_)

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	for slot7, slot8 in pairs(ActivityReforgeTeamCfg[slot0.teamInfo_.teamID].team_info[slot0.teamInfo_.level]) do
		table.insert({}, slot8)
	end

	for slot7 = 1, 3 do
		slot0.heroHeadItemList_[slot7]:SetData(slot2[slot7])
		slot0.heroHeadItemList_[slot7]:SetClickCallBack(function (slot0)
			JumpTools.OpenPageByJump("/newHero", {
				isEnter = true,
				hid = slot0,
				type = HeroConst.HERO_DATA_TYPE.TRIAL,
				tempHeroList = uv0
			})
		end)
	end

	slot0.levelText_.text = slot0.teamInfo_.level
	slot0.levelDesText.text = slot0.teamCfg_.description

	if slot0.teamCfg_.combo_skill_id > 0 then
		SetActive(slot0.comboSkillGo_, true)

		slot5 = ComboSkillCfg[slot0.teamCfg_.combo_skill_id]
		slot0.comboName_.text = GetI18NText(HeroSkillCfg[slot5.skill_id].name)
		slot0.comboLevelText_.text = slot5.maxLevel
		slot0.comboIcon_.sprite = getSpriteViaConfig("ComboSkill", slot5.skill_id)
	else
		SetActive(slot0.comboSkillGo_, false)
	end

	slot0.teamLevelUpCost_.text = slot0.teamCfg_.cost[slot0.teamInfo_.level]
	slot4 = #slot0.teamCfg_.team_info

	if slot0.teamInfo_.level == 1 then
		slot0.levelUpController_:SetSelectedState("noDown")
	elseif slot4 <= slot0.teamInfo_.level then
		slot0.levelUpController_:SetSelectedState("noUp")
	else
		slot0.levelUpController_:SetSelectedState("mid")
	end

	if table.indexof(ActivityReforgeWaveCfg[slot0.curWaveID_].recommend_team, slot0.teamID_) then
		slot0.recommendcontroller_:SetSelectedState("true")
	else
		slot0.recommendcontroller_:SetSelectedState("false")
	end

	if slot0.curUsingWaveID_ == 0 then
		slot0.usingcontroller_:SetSelectedState("false")
		slot0.curSelectcontroller_:SetSelectedState("false")
	elseif slot0.curWaveID_ == slot0.curUsingWaveID_ then
		slot0.usingcontroller_:SetSelectedState("false")
		slot0.curSelectcontroller_:SetSelectedState("true")
	else
		slot0.usingcontroller_:SetSelectedState("true")
		slot0.curSelectcontroller_:SetSelectedState("false")

		slot0.usingWaveText_.text = string.format(GetTips("ACTIVITY_REFORGE_WAVE_USED"), table.indexof(ActivityReforgeLevelCfg[slot0.levelID_].wave_list, slot0.curUsingWaveID_))
	end
end

function slot0.Dispose(slot0)
	for slot4 = 1, 3 do
		slot0.heroHeadItemList_[slot4]:Dispose()

		slot0.heroHeadItemList_[slot4] = nil
	end

	slot0.heroHeadItemList_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
