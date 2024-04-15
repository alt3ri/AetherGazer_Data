slot0 = class("SPHeroChallengeBossView", import(".SPHeroChallengeBattleStageBaseView"))

function slot0.UIName(slot0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeBossUI"
end

function slot0.Init(slot0)
	slot0.super.Init(slot0)

	slot0.lockController = slot0.controller:GetController("lock")
	slot0.openController = slot0.controller:GetController("open")
	slot0.stageInfoController = slot0.controller:GetController("stageInfo")
	slot0.buttonItem = {}

	for slot4 = 1, 2 do
		slot0.buttonItem[slot4] = SPHeroChallengeBossStageItem.New(slot0["bossitem" .. slot4 .. "Go_"])

		slot0.buttonItem[slot4]:RegisterClickCallBack(handler(slot0, slot0.ShowStageInfoView))
	end

	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot0:RegisterEvents()
	slot0:RefreshView()
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(SP_HERO_CHALLENGE_UPDATE_BOSS, function ()
		uv0:RefreshView()
	end)
end

function slot0.OnExit(slot0)
	slot0.selectStage = nil

	slot0:RemoveAllEventListener()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.equiptipBtn_, nil, function ()
		if uv0.equipSuit then
			ShowPopEquipSuit(uv0.equipSuit, true)
		end
	end)
end

function slot0.ShowStageInfoView(slot0, slot1)
	if SPHeroChallengeTools:CheckBossActivityIsOpen() then
		JumpTools.OpenPageByJump("spHeroChallengeSectionView", {
			section = slot1,
			sectionType = BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1,
			activityId = slot0.activityID,
			challengeType = SpHeroChallengeConst.ChapterType.boss
		})

		slot0.selectStage = slot1

		slot0:RefreshStageItem()
	else
		ShowTips("SOLO_NOT_OPEN")
	end
end

function slot0.RefreshView(slot0)
	slot0.info = SPHeroChallengeData:GetCurActivityInfo()
	slot0.activityID = SPHeroChallengeData:GetActivityID()

	slot0:RefreshLockState()
	slot0:RefreshOpenState()
	slot0:RefreshErosion()
	slot0:RefreshStageItem()
	slot0:RefreshEquipInfo()

	if slot0:IsOpenSectionView() then
		slot0.stageInfoController:SetSelectedState("open")
	else
		slot0.stageInfoController:SetSelectedState("close")
	end
end

function slot0.OnUpdate(slot0)
	if slot0:IsOpenSectionView() then
		slot0.stageInfoController:SetSelectedState("open")
	else
		slot0.stageInfoController:SetSelectedState("close")
	end
end

function slot0.IsOpenSectionView(slot0)
	return slot0:IsOpenRoute("spHeroChallengeSectionView")
end

function slot0.RefreshErosion(slot0)
	slot1 = slot0.info:GetBossErosiveness()
	slot0.percenttextText_.text = slot1 .. "%"
	slot0.sliderImg_.fillAmount = slot1 / 100
end

function slot0.RefreshOpenState(slot0)
	slot0.bossActivityID = SPHeroChallengeData.activityCfg[slot0.activityID].bossActivityID

	if ActivityData:GetActivityIsOpen(slot0.bossActivityID) and slot0.info.bossStart then
		slot0.openController:SetSelectedState("unlock")
	else
		slot0.openController:SetSelectedState("lock")

		slot0.lockdescText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_BOSS_OPEN_TIME")
	end
end

function slot0.RefreshLockState(slot0)
	if not slot0.params_.showFlag then
		slot0.lockController:SetSelectedState("not")

		if slot0.params_.reason then
			if not slot0.info.bossStart then
				slot0.lockText.text = GetTips("SOLO_NOT_OPEN")
			else
				slot0.lockText.text = GetTips(slot0.params_.reason)
			end
		end
	else
		slot0.lockController:SetSelectedState("open")
	end
end

function slot0.RefreshStageItem(slot0)
	if slot0.buttonItem then
		for slot5, slot6 in ipairs(slot0.buttonItem) do
			slot6:RefreshUI(BattleVerthandiExclusiveCfg.get_id_list_by_sub_type[SpHeroChallengeConst.BattleSubType.boss][slot5], slot0.selectStage)
		end
	end
end

function slot0.RefreshEquipInfo(slot0)
	if ActivityRewardPoolCfg.get_id_list_by_activity_id[slot0.bossActivityID][1] then
		slot5 = 1

		for slot9, slot10 in ipairs(ActivityRewardPoolItemCfg.get_id_list_by_activity_id[slot1]) do
			slot3 = 0 + ActivityRewardPoolItemCfg[slot10].reward[2] * ActivityRewardPoolItemCfg[slot10].total
			slot4 = 0 + ItemTools.getItemNum(ActivityRewardPoolItemCfg[slot10].reward[1])
			slot5 = ActivityRewardPoolItemCfg[slot10].reward[1]
		end

		slot0.numText_.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_EQUIP_NUM"), slot4, slot3)
		slot0.equipSuit = EquipCfg[slot5].suit

		if EquipSuitCfg[slot0.equipSuit] then
			SetSpriteWithoutAtlasAsync(slot0.iconImg_, SpritePathCfg.EquipIcon_s.path .. slot6.equip_skill_icon)

			slot0.nameText_.text = slot6.name
		end
	end
end

function slot0.Dispose(slot0)
	if slot0.buttonItem then
		for slot4, slot5 in pairs(slot0.buttonItem) do
			slot5:Dispose()
		end

		slot0.buttonItem = nil
	end

	slot0.super.Dispose(slot0)
end

return slot0
