slot0 = class("CoreVerificationInfoView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Core_Verification/CoreVerificationInfo"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.bossModel_ = {}
	slot0.loadIndexList_ = {}
	slot0.bossAnimatorList_ = {}
	slot0.cacheRootMotionList_ = {}
	slot0.animatorTimer_ = {}
	slot0.affixGoList_ = {
		slot0.affix1Go_,
		slot0.affix2Go_,
		slot0.affix3Go_
	}
	slot0.affixImgList_ = {
		slot0.affix1Img_,
		slot0.affix2Img_,
		slot0.affix3Img_
	}
	slot0.affixTextList_ = {
		slot0.affix1Text_,
		slot0.affix2Text_,
		slot0.affix3Text_
	}
	slot4 = CoreVerificationInfoTabItem
	slot0.tabList_ = LuaList.New(handler(slot0, slot0.IndexTabItem), slot0.tabUilist_, slot4)
	slot0.heroHeadItem_ = {}

	for slot4 = 1, 6 do
		slot0.heroHeadItem_[slot4] = CoreVerificationRoleIcon.New(slot0["hero" .. slot4 .. "Go_"])
	end

	slot0.passController_ = slot0.mainControllerEx_:GetController("passState")
end

function slot0.IndexTabItem(slot0, slot1, slot2)
	slot2:SetData(slot0.bossType_, slot1, slot0.curTab_, function ()
		slot1 = CoreVerificationData:GetStageInfoByTypeAndDiff(uv0.bossType_, uv1 - 1)

		if PlayerData:GetPlayerInfo().userLevel < CoreVerificationData:GetInfoCfgByTypeAndDiff(uv0.bossType_, uv1).unlock_level then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot0.unlock_level))

			return
		end

		if uv1 > 1 and not slot1 then
			ShowTips(string.format(GetTips("SOLO_HEART_DEMON_LOCK"), slot0.unlock_level))

			return
		end

		if uv0.tabList_:GetItemByIndex(uv0.curTab_) then
			slot3:Select(false)
		end

		uv2:Select(true)

		uv0.curTab_ = uv1

		uv0:UpdateView()
	end)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.battleBtn_, nil, function ()
		uv0:Go("/sectionSelectHero", {
			section = uv0.curStageID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION,
			reserveParams = ReserveParams.New(ReserveConst.RESERVE_TYPE.CORE_VERIFICATION, uv0.bossType_, nil, {
				stageType = BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION,
				stageID = uv0.curStageID_
			}),
			activityID = uv0.infoID_
		})
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("CORE_VERIFICATION_DES")
	manager.ui:SetMainCamera("bossChallenge")

	slot0.exitView_ = false
	slot0.bossType_ = slot0.params_.bossType
	slot0.curTab_ = CoreVerificationData:GetMaxUnlockByBossType(slot0.bossType_)

	slot0:UpdateView()
	slot0.tabList_:StartScroll(#CoreVerificationData:GetDiffListByBossType(slot0.bossType_))
	slot0.tabList_:ScrollToIndex(slot0.curTab_)

	slot0.nameText_.text = GetI18NText(CoreVerificationData:GetBossUICfgByBossType(slot0.bossType_).main_name)

	if CoreVerificationData:GetRecommendByBossType(slot0.bossType_)[1] then
		SetActive(slot0.recommend1Img_.gameObject, true)

		slot0.recommend1Img_.sprite = HeroTools.GetSkillAttributeIcon(slot3[1])
	else
		SetActive(slot0.recommend1Img_.gameObject, false)
	end

	if slot3[2] then
		SetActive(slot0.recommend2Img_.gameObject, true)

		slot0.recommend2Img_.sprite = HeroTools.GetSkillAttributeIcon(slot3[2])
	else
		SetActive(slot0.recommend2Img_.gameObject, false)
	end

	slot0:LoadModel()
	slot0:LoadBackScene()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()

	slot0.exitView_ = true

	slot0:UnloadModel()
	slot0:UnloadBackScene()
end

function slot0.UpdateView(slot0)
	slot2 = getMosterAffix(CoreVerificationData:GetAffixByTypeAndDiff(slot0.bossType_, slot0.curTab_)) or getHeroAffixs(slot1)

	for slot6 = 1, 3 do
		if slot2[slot6] then
			SetActive(slot0.affixGoList_[slot6], true)

			slot0.affixImgList_[slot6].sprite = getAffixSprite(slot2[slot6])
			slot0.affixTextList_[slot6].text = GetI18NText(getAffixDesc(slot2[slot6]))
		else
			SetActive(slot0.affixGoList_[slot6], false)
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.affixRoot_)

	slot3 = CoreVerificationData:GetInfoCfgByTypeAndDiff(slot0.bossType_, slot0.curTab_)
	slot0.curStageID_ = slot3.stage_id
	slot0.infoID_ = slot3.id
	slot0.lockHero_ = CoreVerificationData:GetLockHeroByBossType(slot0.bossType_)

	if CoreVerificationData:GetStageInfoByTypeAndDiff(slot0.bossType_, slot0.curTab_) and slot4.passState then
		slot0.passController_:SetSelectedState("complete")

		slot8 = slot4.passTime
		slot0.timeText_.text = manager.time:DescCdTime2(slot8)

		for slot8 = 1, 6 do
			slot0.heroHeadItem_[slot8]:SetData(slot0.lockHero_[slot8])
		end
	elseif slot4 then
		slot0.passController_:SetSelectedState("empty")
	elseif slot0.curTab_ == 1 or CoreVerificationData:GetStageInfoByTypeAndDiff(slot0.bossType_, slot0.curTab_ - 1) then
		slot0.passController_:SetSelectedState("empty")
	else
		slot0.passController_:SetSelectedState("lock")
	end
end

function slot0.Dispose(slot0)
	for slot4 = 1, 6 do
		if slot0.heroHeadItem_[slot4] then
			slot0.heroHeadItem_[slot4]:Dispose()

			slot0.heroHeadItem_[slot4] = nil
		end
	end

	if slot0.tabList_ then
		slot0.tabList_:Dispose()

		slot0.tabList_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.LoadModel(slot0)
	slot0:UnloadModel()

	for slot5, slot6 in pairs(CoreVerificationData:GetBossUICfgByBossType(slot0.bossType_).boss_id_list) do
		slot0.loadIndexList_[slot5] = manager.resourcePool:AsyncLoad("Char/" .. MonsterCfg[slot6].model_name, ASSET_TYPE.TPOSE, function (slot0)
			if uv0.exitView_ then
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

	if type(CoreVerificationData:GetBossUICfgByBossType(slot0.bossType_).appear_ani) == "table" and slot3.appear_ani[slot1] ~= "" then
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

function slot0.LoadBackScene(slot0)
	slot0.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	slot0.backGroundTrs_ = slot0.backGround_.transform

	slot0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	slot2 = GameDisplayCfg.boss_background_pos.value
	slot0.backGroundTrs_.localPosition = Vector3(slot2[1], slot2[2], slot2[3])
	slot0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	slot3 = GameDisplayCfg.boss_background_pos.scale
	slot0.backGroundTrs_.localScale = Vector3(2, 2, 2)
	slot0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureBg/Core_Verification/bg2")
end

function slot0.UnloadBackScene(slot0)
	if slot0.backGround_ then
		manager.resourcePool:DestroyOrReturn(slot0.backGround_, ASSET_TYPE.SCENE)

		slot0.backGround_ = nil
	end
end

return slot0
