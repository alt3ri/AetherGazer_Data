slot0 = class("HeroInteractView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dorm/DormInteractionUI"
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

	slot0.touchController = ControllerUtil.GetController(slot0.touchbtnBtn_.gameObject.transform, "lock")
	slot0.gameController = ControllerUtil.GetController(slot0.gameBtn_.gameObject.transform, "lock")
	slot0.feedController = ControllerUtil.GetController(slot0.feedfoodbtnBtn_.gameObject.transform, "lock")
	slot0.giftController = ControllerUtil.GetController(slot0.giftbtnBtn_.gameObject.transform, "lock")
	slot0.skinController = ControllerUtil.GetController(slot0.changeclothesBtn_.gameObject.transform, "lock")
	slot0.feedAllController = ControllerUtil.GetController(slot0.transform_, "feedAll")
	slot0.subtitleBubbleView = SubtitleBubbleView.New(slot0.subtitleView, true)
	slot0.stateController = slot0.mianController:GetController("state")
end

function slot0.OnEnter(slot0)
	Dorm.DormEntityManager.EnablePlayerInput = false
	slot0.heroEID = slot0.params_.heroEID or slot0.heroEID

	if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.CricketBattle then
		slot0.stateController:SetSelectedState("dance")

		slot0.heroID = DormUtils.GetEntityData(slot0.heroEID).heroID
		slot0.skinID = slot0.heroID
	else
		slot0.stateController:SetSelectedState("dorm")

		slot0.skinID = DormUtils.GetEntityData(slot0.heroEID).cfgID
		slot0.heroID = BackHomeHeroSkinCfg[slot0.skinID].hero_id
	end

	slot0.canInteractFlag = true
	slot0.archiveID = DormData:GetHeroArchiveID(slot0.heroID)
	slot0.heroInfo = DormData:GetHeroInfo(slot0.archiveID)

	slot0:RefreshView()
	slot0:RegisterEvent()
	slot0.subtitleBubbleView:SetEntityFilter({
		[slot0.heroEID] = true
	})
	slot0.subtitleBubbleView:OnEnter()
end

function slot0.OnExit(slot0)
	if slot0.timer then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.timer)

		slot0.timer = nil

		if slot0.imageGo then
			SetActive(slot0.imageGo, false)

			slot0.imageGo = nil
		end

		if slot0.group then
			slot0.group.alpha = 1
			slot0.group = nil
		end
	end

	slot1 = BackHomeDataManager:GetCurSystem()

	slot0.subtitleBubbleView:OnExit()
end

function slot0.RegisterEvent(slot0)
	slot0:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, function ()
		uv0:RefreshFatigue()
	end)
end

function slot0.PickFeedFoodAnime(slot0, slot1)
	slot3 = nil

	if BackHomeDataManager.GetInstance():GetCurSystem() == DormEnum.DormSystemType.CricketBattle then
		slot5 = string.format("dorm_idol_camp_pos%d_interaction_feed", IdolTraineeCampBridge.GetPosByCharacter(slot1))

		print("偶像经营喂食", slot5)

		slot3 = nullable(GameDisplayCfg, slot5, "value")
	elseif slot2 == DormEnum.DormSystemType.Dormitory then
		print("宿舍喂食")

		slot3 = GameDisplayCfg.dorm_interaction_feed.value
	else
		print("缺省喂食")

		slot3 = GameDisplayCfg.dorm_interaction_feed.value
	end

	return DormHeroTemplate.PickInteractAction(slot3)
end

function slot0.GetAllHeroInScene(slot0)
	slot1 = {}

	if BackHomeDataManager.GetInstance():GetCurSystem() == DormEnum.DormSystemType.CricketBattle then
		for slot6, slot7 in pairs(IdolTraineeCampBridge.charaAtPos) do
			slot1[slot7] = IdolTraineeCampBridge.GetCharacterHeroID(slot7)
		end
	elseif slot2 == DormEnum.DormSystemType.Dormitory then
		slot3 = DormData:GetHeroInfoList()
		slot5 = DormData:GetCurrectSceneID()

		for slot9, slot10 in pairs(DormHeroTools:GetAllHeroEIDInCurScene()) do
			slot1[slot10] = BackHomeHeroSkinCfg[slot9].hero_id
		end
	else
		error("未实现")
	end

	return slot1
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.giftbtnBtn_, nil, function ()
		if uv0.canInteractFlag then
			if not DormRoomTools:GetDormIDViaArchive(uv0.archiveID) then
				ShowTips(GetTips("DORM_HERO_NOT_SET"))

				return
			end

			JumpTools.OpenPageByJump("/dormHeroGiftView", {
				archiveID = uv0.archiveID,
				heroEID = uv0.heroEID
			})
		end
	end)
	slot0:AddBtnListenerScale(slot0.touchbtnBtn_, nil, function ()
		if uv0.canInteractFlag then
			if DormHeroTools:GetDormLevelByHeroID(uv0.archiveID) < GameSetting.dorm_menu_touch_unlock.value[1] then
				return
			end

			if uv0.heroInfo and uv0.skinID then
				uv0.canInteractFlag = false
				slot2 = nil

				if BackHomeDataManager.GetInstance():GetCurSystem() == DormEnum.DormSystemType.CricketBattle then
					slot4 = string.format("dorm_idol_camp_pos%d_interaction_stroke", IdolTraineeCampBridge.GetPosByCharacter(uv0.heroEID))

					print("偶像经营摸头", slot4)

					slot2 = nullable(GameDisplayCfg, slot4, "value")
				elseif slot1 == DormEnum.DormSystemType.Dormitory then
					print("宿舍摸头")

					slot2 = GameDisplayCfg.dorm_interaction_stroke.value
				else
					print("缺省摸头")

					slot2 = GameDisplayCfg.dorm_interaction_stroke.value
				end

				if uv0.heroInfo:TouchHero(uv0.heroEID, DormHeroTemplate.PickInteractAction(slot2)) then
					uv0:InitInteractTimer(slot4, uv0.touchBar, uv0.touchGo, uv0.touchGroup)
				else
					uv0.canInteractFlag = true
				end
			end
		end
	end)
	slot0:AddBtnListenerScale(slot0.replacebtnBtn_, nil, function ()
	end)

	function slot1(slot0, slot1, slot2)
		slot3 = nil

		if (slot0 ~= 1 or DormHeroTools:FeedMultipleHero(uv0:GetAllHeroInScene(), slot1, handler(uv0, uv0.PickFeedFoodAnime))) and DormData:GetHeroTemplateInfo(slot1):FeedFood(slot2, uv0:PickFeedFoodAnime(slot2)) then
			uv0:InitInteractTimer(slot3, uv0.feedBar, uv0.feedGo, uv0.feedGroup)
		else
			uv0.canInteractFlag = true
		end

		uv0:RefreshView()
	end

	slot0:AddBtnListenerScale(slot0.feedfoodbtnBtn_, nil, function ()
		if uv0.canInteractFlag then
			slot1, slot2 = DormData:GetHeroTemplateInfo(uv0.heroID):CheckCanFeedFood()

			if not slot1 then
				if slot2 == "feedTime" then
					ShowTips(GetTips("DORM_FEED_MAX"))
				elseif slot2 == "fatigue" then
					ShowTips(GetTips("DORM_CANT_FEED"))
				end

				return
			end

			if DormitoryData:GetAllFeedFlag() then
				uv0.canInteractFlag = false

				DormAction:GiftFoodToHero(uv0.heroID, nil, 1, uv1)
			else
				uv0.canInteractFlag = false

				DormAction:GiftFoodToHero(uv0.heroID, uv0.heroEID, 2, uv1)
			end
		end
	end)
	slot0:AddBtnListenerScale(slot0.closebtnBtn_, nil, function ()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Dormitory then
			Dorm.DormEntityManager.EnablePlayerInput = true

			DormLuaBridge.ChangeCameraMode(0, false)
			manager.notify:Invoke(DORM_RESET_HERO_AI, uv0.heroEID)
			Dorm.DormEntityManager.SetPlayerEntityFaceToCam(uv0.heroEID, false)
			JumpTools.OpenPageByJump("/dorm")

			slot5 = pairs

			for slot5, slot6 in Dorm.storage:ForeachData(DormUtils.EIdNamespace(DormEnum.CharacterType.DormNormalHero), slot5) do
				if slot6 ~= uv0.heroEID then
					Dorm.DormEntityManager.ClearFadeOutPoint(slot6)
				end
			end

			uv0:StopImageTimer()
		elseif slot0 == DormEnum.DormSystemType.CricketBattle then
			uv0:StopImageTimer()
			JumpTools.Back()
		end
	end)
	slot0:AddBtnListenerScale(slot0.gameBtn_, nil, function ()
		if uv0.canInteractFlag then
			JumpTools.OpenPageByJump("/dormRhythmGameView", {
				heroID = uv0.heroID,
				heroEID = uv0.heroEID
			})
		end
	end)
	slot0:AddBtnListenerScale(slot0.changeclothesBtn_, nil, function ()
		if uv0.canInteractFlag then
			JumpTools.OpenPageByJump("/dormHeroChangeSkinView", {
				heroID = uv0.heroID,
				heroEID = uv0.heroEID
			})
		end
	end)
	slot0:AddBtnListenerScale(slot0.allFeedBtn_, nil, function ()
		slot0 = DormitoryData:GetAllFeedFlag()

		DormitoryData:SetAllFeedFlag(not slot0)

		if not slot0 then
			uv0.feedAllController:SetSelectedState("on")
		else
			uv0.feedAllController:SetSelectedState("off")
		end
	end)
	slot0:AddBtnListenerScale(slot0.trainBtn_, nil, function ()
		JumpTools.OpenPageByJump("/idolTraineeTrain", {
			heroID = uv0.heroID
		})
	end)
end

function slot0.StopWaitCamBlend(slot0)
	if slot0.camTimer then
		slot0.camTimer:Stop()

		slot0.camTimer = nil
	end
end

function slot0.RefreshView(slot0)
	if DormHeroTools:GetDormLevelByHeroID(slot0.archiveID) == 0 then
		slot0.giftController:SetSelectedState("lock")
	else
		slot0.giftController:SetSelectedState("normal")
	end

	if slot1 < GameSetting.dorm_menu_feed_unlock.value[1] then
		slot0.feedController:SetSelectedState("lock")
	else
		slot0.feedController:SetSelectedState("normal")
	end

	if slot1 < GameSetting.dorm_menu_touch_unlock.value[1] then
		slot0.touchController:SetSelectedState("lock")
	else
		slot0.touchController:SetSelectedState("normal")
	end

	slot0.skinController:SetSelectedState("normal")
	slot0.gameController:SetSelectedState("normal")
	slot0:RefreshFatigue()

	if DormitoryData:GetAllFeedFlag() then
		slot0.feedAllController:SetSelectedState("on")
	else
		slot0.feedAllController:SetSelectedState("off")
	end
end

function slot0.RefreshFatigue(slot0)
	slot0.maxFatigue.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
	slot0.curFaitigue.text = slot0.heroInfo:GetFatigue()
	slot0.coverNum.text = string.format(GetTips("DORM_FATIGUE_PER_HOUR"), slot0.heroInfo:GetRecoverFatigueNum())
end

function slot0.InitInteractTimer(slot0, slot1, slot2, slot3, slot4)
	if slot0.timer then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.timer)

		slot0.timer = nil
	end

	slot0.group = slot4
	slot0.imageGo = slot3

	if slot3 and slot2 then
		slot2.fillAmount = 1

		SetActive(slot0.imageGo, true)
	end

	slot5 = math.ceil(slot1)
	slot6 = math.ceil(slot1)
	slot0.group.alpha = 0.6
	slot0.timer = FuncTimerManager.inst:CreateFuncFrameTimer(function ()
		uv0 = uv0 - Time.deltaTime
		slot0 = uv1 > 0 and uv0 / uv1 or 1

		if uv0 <= 0 then
			uv2.canInteractFlag = true

			FuncTimerManager.inst:RemoveFuncTimer(uv2.timer)

			uv2.timer = nil

			SetActive(uv2.imageGo, false)

			uv2.group.alpha = 1
		end

		if uv3 and uv4 then
			uv3.fillAmount = slot0
		end
	end, -1, true)
end

function slot0.StopImageTimer(slot0)
	if slot0.timer then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.timer)

		slot0.timer = nil

		if slot0.imageGo then
			SetActive(slot0.imageGo, false)

			slot0.imageGo = nil
		end

		if slot0.group then
			slot0.group.alpha = 1
			slot0.group = nil
		end
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
