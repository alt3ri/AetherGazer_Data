slot0 = class("BattleBossInfoBaseView", ReduxView)

function slot0.UIName(slot0)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.heroLockList_ = {}
	slot0.skillList_ = {}
	slot0.bossModel_ = {}
	slot0.bossAnimatorList_ = {}
	slot0.cacheRootMotionList_ = {}
	slot0.animatorTimer_ = {}
	slot0.loadIndexList_ = {}
	slot0.challengeUpdateHandler_ = handler(slot0, slot0.UpdateBossChallenge)
end

function slot0.OnEnter(slot0)
	manager.ui:SetMainCamera("bossChallenge")
	slot0:InitBackScene()

	slot0.exitView_ = false
	slot0.currentBossTemplateID_ = nil

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.notify:RegistListener(BOSS_CHALLENGE_BACK_ENTRACE, slot0.challengeUpdateHandler_)
	BossTools.CheckTimeout()
	slot0:OnEnterExtend()
	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	slot0.exitView_ = true

	manager.notify:RemoveListener(BOSS_CHALLENGE_BACK_ENTRACE, slot0.challengeUpdateHandler_)
	slot0:UnloadModel()
	slot0:DestroyBackScene()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.challengeUpdateHandler_ = nil

	for slot4, slot5 in pairs(slot0.heroLockList_) do
		slot5:Dispose()
	end

	slot0.heroLockList_ = nil

	for slot4, slot5 in ipairs(slot0.skillList_) do
		slot5:Dispose()
	end

	slot0.skillList_ = nil
end

function slot0.AddListeners(slot0)
end

function slot0.RefreshData(slot0)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshText()
	slot0:LoadModel()
	slot0:RefreshSkill()
	slot0:RefreshLockHero()
end

function slot0.UpdateBossChallenge(slot0)
	BattleBossChallengeAction.BossChallengeBackEntrace()
end

function slot0.RefreshText(slot0)
	slot2 = BossChallengeUICfg[slot0.templateID_]
	slot0.textName_.text = GetI18NText(slot2.main_name)
	slot0.textDesc_.text = GetI18NText(slot2.descripe)
end

function slot0.RefreshSkill(slot0)
	slot1 = 1

	for slot5, slot6 in ipairs(BossChallengeUICfg[slot0.templateID_].boss_id_list) do
		slot7 = MonsterCfg[slot6]
		slot8 = GetMonsterSkillDesList({
			slot6
		})

		for slot12 = 1, 6 do
			if slot8[slot12] then
				if not slot0.skillList_[slot1] then
					slot0.skillList_[slot1] = BattleBossChallengeSkillItem.New(slot0.skillItem_, slot0.skillParent_)
				end

				slot0.skillList_[slot1]:RefreshUI(slot8[slot12])

				slot1 = slot1 + 1
			end
		end
	end

	for slot5 = slot1, #slot0.skillList_ do
		slot0.skillList_[slot5]:Hide()
	end
end

function slot0.RefreshLockHero(slot0)
	slot1 = slot0.lockHeroGroup_[slot0.bossIndex_] or {}

	for slot5 = 1, #slot1 do
		slot6 = slot1[slot5]

		if not slot0.heroLockList_[slot5] then
			slot0.heroLockList_[slot5] = BattleBossChallengeLockHeroItem.New(slot0.heroLockItem_, slot0.heroLockPanel_, slot6)
		end

		slot0.heroLockList_[slot5]:SetActive(true, slot6)
	end

	for slot5 = #slot1 + 1, #slot0.heroLockList_ do
		slot0.heroLockList_[slot5]:SetActive(false)
	end

	slot0.heroLockScroll_.normalizedPosition = Vector2(0, 1)
end

function slot0.LoadModel(slot0)
	if slot0.currentBossTemplateID_ == slot0.templateID_ then
		return
	end

	slot0.currentBossTemplateID_ = slot0.templateID_

	slot0:UnloadModel()

	for slot5, slot6 in pairs(BossChallengeUICfg[slot0.templateID_].boss_id_list) do
		slot0.loadIndexList_[slot5] = manager.resourcePool:AsyncLoad("Char/" .. MonsterCfg[slot6].model_name, ASSET_TYPE.TPOSE, function (slot0)
			if uv0.exitView_ or uv0.currentBossTemplateID_ ~= uv0.templateID_ then
				manager.resourcePool:DestroyOrReturn(slot0, ASSET_TYPE.TPOSE)

				return
			end

			slot1 = uv1.model_pos[uv2]
			slot2 = uv1.model_rot[uv2]
			slot3 = uv1.model_scale[uv2]
			uv0.bossModel_[uv2] = slot0
			uv0.bossModel_[uv2].transform.localPosition = Vector3(slot1[1], slot1[2], slot1[3])
			uv0.bossModel_[uv2].transform.localEulerAngles = Vector3(slot2[1], slot2[2], slot2[3])
			uv0.bossModel_[uv2].transform.localScale = Vector3(slot3[1], slot3[2], slot3[3])
			uv0.bossAnimatorList_[uv2] = uv0.bossModel_[uv2]:GetComponent(typeof(Animator))

			uv0:PlayAppearAnimation(uv2, function ()
				uv0.bossAnimatorList_[uv1]:CrossFadeInFixedTime("stand", 0.01)
			end)
		end)
	end
end

function slot0.UnloadModel(slot0)
	for slot4, slot5 in pairs(slot0.bossModel_) do
		slot0.bossAnimatorList_[slot4].applyRootMotion = slot0.cacheRootMotionList_[slot4]

		manager.resourcePool:DestroyOrReturn(slot5, ASSET_TYPE.TPOSE)
	end

	slot0.bossModel_ = {}
	slot0.bossAnimatorList_ = {}

	for slot4, slot5 in pairs(slot0.loadIndexList_) do
		manager.resourcePool:StopAsyncQuest(slot5)
	end

	slot0.loadIndexList_ = {}

	slot0:StopAllAnimatorTimer()
end

function slot0.PlayAppearAnimation(slot0, slot1, slot2)
	slot4 = slot0.bossAnimatorList_[slot1]
	slot0.cacheRootMotionList_[slot1] = slot0.bossAnimatorList_[slot1].applyRootMotion
	slot0.bossAnimatorList_[slot1].applyRootMotion = false

	if type(BossChallengeUICfg[slot0.templateID_].appear_ani) == "table" and slot3.appear_ani[slot1] ~= "" then
		slot0.bossAnimatorList_[slot1]:Play(slot3.appear_ani[slot1])

		slot5 = nil
		slot5 = FrameTimer.New(function ()
			if uv0:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
				uv1:Stop()
				table.removebyvalue(uv2.animatorTimer_, uv1)

				uv1 = nil

				uv3()
			end
		end, 1, -1)

		table.insert(slot0.animatorTimer_, slot5)
		slot5:Start()

		return
	end

	slot2()
end

function slot0.StopAllAnimatorTimer(slot0)
	for slot4 = #slot0.animatorTimer_, 1, -1 do
		slot0.animatorTimer_[slot4]:Stop()

		slot0.animatorTimer_[slot4] = nil
	end
end

function slot0.InitBackScene(slot0)
	slot0.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	slot0.backGroundTrs_ = slot0.backGround_.transform

	slot0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	slot2 = GameDisplayCfg.boss_background_pos.value
	slot0.backGroundTrs_.localPosition = Vector3(slot2[1], slot2[2], slot2[3])
	slot0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	slot3 = GameDisplayCfg.boss_background_pos.scale
	slot0.backGroundTrs_.localScale = Vector3(slot3[1], slot3[2], slot3[3])
	slot0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureBg/Challenge_Boss/" .. CameraCfg.bossChallenge.pictureName)
end

function slot0.DestroyBackScene(slot0)
	if slot0.backGround_ then
		manager.resourcePool:DestroyOrReturn(slot0.backGround_, ASSET_TYPE.SCENE)

		slot0.backGround_ = nil
	end
end

return slot0
