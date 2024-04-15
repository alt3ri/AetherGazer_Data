slot0 = class("GuildBossChallengeView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Club_boss/ClubBossChallengeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.titleGo_.transform, "status")
	slot0.bonusLockController_ = ControllerUtil.GetController(slot0.bonusLockGo_.transform, "bonusLock")
	slot0.btnOpenController_ = ControllerUtil.GetController(slot0.prepareBtn_.transform, "btnOpen")
	slot0.difficultyController_ = ControllerUtil.GetController(slot0.difficultyGo_.transform, "difficulty")
	slot0.bonusList_ = LuaList.New(handler(slot0, slot0.indexBonusItem), slot0.bonusListGo_, GuildBossChallengeRewardItemView)
	slot0.buffList_ = LuaList.New(handler(slot0, slot0.indexAffixItem), slot0.buffListGo_, AffixItemView)
	slot0.avatarView_ = GuildBossAvatarView.New(slot0.displayGo_)
	slot0.itemList_ = {}
end

function slot0.indexBonusItem(slot0, slot1, slot2)
	slot2:SetData(slot0.bonusDataList_[slot1], GuildData:GetBossPersonalScore())
end

function slot0.indexAffixItem(slot0, slot1, slot2)
	slot2:SetData(slot0.haveGetBuffList_[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.prepareBtn_, nil, function ()
		slot0, slot1 = GuildData:GetLastTime()

		if slot0 == "prepose" then
			ShowTips("CLUB_BOSS_CHALLENGE_NOT_OPEN_TIP")

			return
		end

		uv0:Go("/sectionSelectHero", {
			dest = 6,
			section = GuildData:GetCurrentBossStageId(),
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE
		})
	end)
	slot0:AddBtnListener(slot0.rankBtn_, nil, function ()
		JumpTools.OpenPageByJump("/guildBossRank", {})
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("guildBossReward", {})
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		manager.notify:Invoke(CLICK_AFFIX)
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(GUILD_BOSS_PERSONAL_REWARD_GET, function ()
		uv0:UpdateView()
	end)
	slot0:RegistEventListener(GUILD_EXIT, function ()
		uv0:Go("/home")
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(GetTips("CLUB_BOSS_DESCRIPE"))
end

function slot0.InitData(slot0)
	slot0.haveGetBuffList_ = GuildData:GetHaveGetBossBuffList()
	slot0.bonusDataList_ = deepClone(ClubBossCfg[GuildData:GetBossDifficulty()].personal_reward)

	table.sort(slot0.bonusDataList_, function (slot0, slot1)
		return slot1[1] < slot0[1]
	end)
end

function slot0.OnEnter(slot0)
	slot0:InitData()
	slot0:AddEventListeners()
	manager.ui:SetMainCamera("clubBoss")

	if slot0.avatarView_ then
		slot0.avatarView_:OnEnter()
	end

	slot0:UpdateView()
	saveData("guild_boss", "challenge", 0)
	GuildAction.GetAssistBriefInfo(GuildData:GetGuildInfo().id)
	manager.redPoint:setTip(RedPointConst.GUILD_BOSS_CHALLENGE_OPEN, 0)
	manager.redPoint:bindUIandKey(slot0.rewardNoticeContainer_, RedPointConst.GUILD_BOSS_COMMON_BONUS, {
		x = 0,
		y = 0
	})
	slot0:AddGuildBossTimer()
end

function slot0.OnExit(slot0)
	manager.ui:ResetMainCamera()
	manager.redPoint:unbindUIandKey(slot0.rewardNoticeContainer_, RedPointConst.GUILD_BOSS_COMMON_BONUS)
	slot0:RemoveAllEventListener()

	if slot0.avatarView_ then
		slot0.avatarView_:OnExit()
	end

	slot0:StopGuildBossTimer()
	manager.windowBar:HideBar()
end

function slot0.OnMainHomeViewTop(slot0)
end

slot1 = {
	"CLUB_BOSS_DIFFICULTY_1",
	"CLUB_BOSS_DIFFICULTY_2",
	"CLUB_BOSS_DIFFICULTY_3",
	"CLUB_BOSS_DIFFICULTY_4"
}

function slot0.UpdateView(slot0)
	slot1 = GuildData:GetCurBossId()
	slot0.bossNameLabel_.text = GetMonsterName({
		slot1
	})
	slot0.bossDescribeLabel_.text = GetI18NText(MonsterCfg[slot1].desc)

	slot0.bonusList_:StartScroll(#slot0.bonusDataList_)
	slot0.buffList_:StartScroll(#slot0.haveGetBuffList_)
	slot0.avatarView_:SetBossID(GuildData:GetBossData().challengeInfo.boss_id)

	slot0.scoreSlider.fillAmount = math.min(GuildData:GetBossPersonalScore() / ClubBossCfg[GuildData:GetBossDifficulty()].personal_reward[4][1], 1)
	slot0.currentScoreLabel_.text = GuildData:GetBossPersonalScore()
	slot4 = ClubBossCfg[GuildData:GetBossDifficulty()].boss_hp
	slot5 = GuildData:GetCurrentBossDamage()
	slot6 = GuildData:GetCurrentBossRemainHp()
	slot0.expProgressLabel_.text = slot6
	slot0.expProgressLabel2_.text = "/ " .. slot4

	slot0.sliderGo_:GetComponent("SplineProgressBar"):SetValue(slot6 / slot4)

	slot8 = false

	for slot12 = #deepClone(ClubBossCfg[GuildData:GetBossDifficulty()].personal_reward), 1, -1 do
		if slot7[slot12][1] <= GuildData:GetBossPersonalScore() then
			slot0.bonusLockController_:SetSelectedIndex(slot12)

			slot8 = true

			break
		end
	end

	if not slot8 then
		slot0.bonusLockController_:SetSelectedIndex(0)
	end

	slot0:UpdateGuildBossTimer()

	slot9 = GuildData:GetBossDifficulty()

	slot0.difficultyController_:SetSelectedIndex(slot9 - 1)

	slot0.difficulty_.text = GetTips(uv0[slot9])

	slot0:UpdateData()
	slot0:RefreshSkill()
end

function slot0.UpdateData(slot0)
	slot0.skillList_ = GetMonsterSkillDesList({
		GuildData:GetCurBossId()
	})
end

function slot0.RefreshSkill(slot0)
	slot1 = GuildData:GetCurBossId()

	for slot5 = 1, 6 do
		if slot0.skillList_[slot5] then
			slot0:UpdateItem(slot5, slot0.skillList_[slot5])
		elseif slot0.itemList_[slot5] then
			slot0.itemList_[slot5]:Hide()
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.skillContainer_)
end

function slot0.UpdateItem(slot0, slot1, slot2)
	if not slot0.itemList_[slot1] then
		slot0.itemList_[slot1] = BattleBossChallengeSkillItem.New(slot0.skillItemGo_, slot0.skillContainer_)
	end

	slot0.itemList_[slot1]:RefreshUI(slot2)
end

function slot0.UpdateGuildBossTimer(slot0)
	slot1, slot2 = GuildData:GetLastTime()

	slot0.statusController_:SetSelectedState(slot1)

	if slot1 == "prepose" then
		slot0.stageLabel_.text = GetTips("CLUB_BOSS_PREPOSE_TIP")
		slot0.titleText_.text = GetTips("CLUB_BOSS_OPEN_1")
		slot0.lastTimeLabel_.text = manager.time:GetLostTimeStr(slot2)

		slot0.btnOpenController_:SetSelectedState("false")
	else
		slot0.stageLabel_.text = GetTips("CLUB_BOSS_CHALLENGE_TIP")
		slot0.titleText_.text = GetTips("CLUB_BOSS_OPEN_2")
		slot0.lastTimeLabel_.text = manager.time:GetLostTimeStr(slot2)

		slot0.btnOpenController_:SetSelectedState("true")
	end
end

function slot0.AddGuildBossTimer(slot0)
	if slot0.guildBossTimer_ == nil then
		slot0.guildBossTimer_ = Timer.New(function ()
			uv0:UpdateGuildBossTimer()
		end, 1, -1)
	end

	slot0.guildBossTimer_:Start()
end

function slot0.StopGuildBossTimer(slot0)
	if slot0.guildBossTimer_ then
		slot0.guildBossTimer_:Stop()

		slot0.guildBossTimer_ = nil
	end
end

function slot0.Dispose(slot0)
	if slot0.bonusList_ then
		slot0.bonusList_:Dispose()

		slot0.bonusList_ = nil
	end

	if slot0.buffList_ then
		slot0.buffList_:Dispose()

		slot0.buffList_ = nil
	end

	if slot0.avatarView_ then
		slot0.avatarView_:Dispose()

		slot0.avatarView_ = nil
	end

	if slot0.itemList_ then
		for slot4, slot5 in pairs(slot0.itemList_) do
			slot5:Dispose()
		end

		slot0.itemList_ = {}
	end

	uv0.super.Dispose(slot0)
end

return slot0
