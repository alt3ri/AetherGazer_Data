slot0 = class("SoloChallengeSelectItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0.affixList_ = {}

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.heroSelectController = ControllerUtil.GetController(slot0.transform_, "heroSelect")
	slot0.lockStateController_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.adaptImg_ = slot0:FindCom("AdaptImage", nil, slot0.bossTrans_)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.heroBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		HeroData:ResetSortValue()
		BattleFieldData:SetCurrentSelectHeroData(uv0.heroID_, uv0.trialID_)
		uv0:Go("/heroTeamInfoSoloChallenge", {
			isEnter = true,
			reorder = false,
			selectHeroPos = uv0.selectHeroPos_,
			stageID = uv0.stageID_,
			activityID = uv0.activityID_,
			stageType = BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE,
			difficultyIndex = uv0.difficultyIndex_,
			reserveParams = uv0.reserveParams_
		})
	end)

	if slot0.bossBtn_ ~= nil then
		slot0:AddBtnListener(slot0.bossBtn_, nil, function ()
			if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
				ShowTips("TIME_OVER")

				return
			end

			JumpTools.OpenPageByJump("soloChallengeBossInfo", {
				activityID = uv0.activityID_,
				bossID = ActivitySoloChallengeCfg[uv0.activityID_].boss_id_list[uv0.selectHeroPos_]
			})
		end)
	end
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.activityID_ = slot1
	slot0.stageID_ = slot2
	slot0.selectHeroPos_ = slot3
	slot0.difficultyIndex_ = slot4
	slot0.difficultId_ = ActivitySoloChallengeCfg[slot0.activityID_].stage_id[slot0.difficultyIndex_][1]
	slot0.reserveParams_ = ReserveParams.New(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE, slot0.difficultId_, slot0.selectHeroPos_, {
		stageType = BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE,
		stageID = slot0.stageID_,
		activityID = slot0.activityID_,
		difficultyIndex = slot0.difficultyIndex_
	})

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshAffix()
	slot0:RefreshHeroState()
	slot0:RefreshEnemyUI()
	slot0:RefreshLockState()
	slot0:RefreshTitle()
end

function slot0.RefreshAffix(slot0)
	slot5 = 0

	for slot9 = 1, SoloChallengeData:GetMaxAffixCount(slot0.activityID_) do
		slot5 = ReserveTools.GetReserveTemplate(BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE, slot0.stageID_):GetContDataTemplateById(slot0.difficultId_):GetAffixList(slot0.selectHeroPos_)[slot9] or 0

		if slot0.affixList_[slot9] == nil then
			slot0.affixList_[slot9] = SoloChallengeAffixItem.New(Object.Instantiate(slot0.affixItemTemplate_, slot0.affixListTrans_))
		end

		slot0.affixList_[slot9]:SetData(slot0.activityID_, slot5)
		slot0.affixList_[slot9]:SetState({
			stageID = slot0.stageID_,
			pos = slot9
		})
	end
end

function slot0.RefreshHeroState(slot0)
	slot1, slot2, slot3, slot4 = ReserveTools.GetHeroList(slot0.reserveParams_)
	slot0.heroID_ = slot1[1]
	slot0.trialID_ = slot4[1]

	if slot0.heroID_ ~= 0 then
		slot0.heroSelectController:SetSelectedState("on")

		slot5 = 0
		slot0.headIcon_.sprite = getSpriteViaConfig("HeroLittleIcon", SkinCfg[(slot0.trialID_ == 0 or HeroStandardSystemCfg[slot0.trialID_].skin_id) and HeroTools.HeroUsingSkinInfo(slot0.heroID_).id].picture_id)

		slot0.headIcon_:SetNativeSize()
	else
		slot0.heroSelectController:SetSelectedState("off")
	end
end

function slot0.RefreshEnemyUI(slot0)
	slot0.bossIcon_.sprite = getSpriteViaConfig("StoryHeadIcon", BattleSoloChallengeStageCfg[slot0.stageID_].hd_image)

	slot0.adaptImg_:AdaptImg()
end

function slot0.RefreshTitle(slot0)
	slot0.titleText_.text = GetTips(string.format("TEAM_%d", slot0.selectHeroPos_))
end

function slot0.RefreshLockState(slot0)
	if table.keyof(SoloChallengeData:GetCompletedStageList(slot0.activityID_)[slot0.difficultyIndex_], slot0.stageID_) then
		slot0.heroBtn_.interactable = false

		slot0.lockStateController_:SetSelectedState("lock")
	else
		slot0.heroBtn_.interactable = true

		slot0.lockStateController_:SetSelectedState("unlock")
	end
end

function slot0.Dispose(slot0)
	if slot0.affixList_ then
		for slot4, slot5 in pairs(slot0.affixList_) do
			slot5:Dispose()

			slot0.affixList_[slot4] = nil
		end

		slot0.affixList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
