slot0 = class("HanafudaGameView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaGameUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:InitCardPoolItem()

	slot0.winBar = KagutsuchiSpecialWinBarItem.New(slot0, slot0.winBar_, {
		CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id,
		CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id
	})

	HanafudaData:InitTotalCardsList()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "gameState")
	slot0.bellController_ = ControllerUtil.GetController(slot0.transform_, "bell")
	slot0.turnController_ = ControllerUtil.GetController(slot0.trunChangeTrs_, "turn")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.playBtn_, nil, function ()
		SetActive(uv0.playBtn_.gameObject, false)
		uv0:PlayCardByIndex(uv0.selectedCardIndex_)
	end)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		slot0 = ActivityData:GetActivityData(HanafudaData:GetActivityID())
		uv0.startTime_ = slot0.startTime
		uv0.stopTime_ = slot0.stopTime

		if manager.time:GetServerTime() < uv0.startTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(uv0.startTime_, nil, true)))

			return
		end

		if uv0.stopTime_ <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		uv0:RefreshEnemyScoreUI()
		uv0:RefreshPlayerScoreUI()
		JumpTools.OpenPageByJump("hanafudaSelectFirstPopView", {
			type = 2,
			callback = function ()
				uv0:StartDealCards()
			end
		})

		uv0.leftCardNumText_.text = 24
	end)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		JumpTools.OpenPageByJump("hanafudaDescView")
	end)
	slot0:AddBtnListener(slot0.cardBtn_, nil, function ()
		JumpTools.OpenPageByJump("/kagutsuchiFishingGameCollection")
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("hanafudaRewardView")
	end)
	slot0:AddBtnListener(slot0.enemyCombineBtn_, nil, function ()
		JumpTools.OpenPageByJump("hanafudaCheckCombineView", {
			playerType = HanafudaData.CARD_PLACE_TYPE.ENEMYCOMBINE,
			callback = function ()
				uv0.isOpenCheck = false
			end
		})

		uv0.isOpenCheck = true
	end)
	slot0:AddBtnListener(slot0.enemyCombineCardBackBtn_, nil, function ()
		JumpTools.OpenPageByJump("hanafudaCheckCombineView", {
			playerType = HanafudaData.CARD_PLACE_TYPE.ENEMYCOMBINE,
			callback = function ()
				uv0.isOpenCheck = false
			end
		})

		uv0.isOpenCheck = true
	end)
	slot0:AddBtnListener(slot0.playerCombineBtn_, nil, function ()
		JumpTools.OpenPageByJump("hanafudaCheckCombineView", {
			playerType = HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE,
			callback = function ()
				uv0.isOpenCheck = false
			end
		})

		uv0.isOpenCheck = true
	end)
	slot0:AddBtnListener(slot0.combineCardBackBtn_, nil, function ()
		JumpTools.OpenPageByJump("hanafudaCheckCombineView", {
			playerType = HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE,
			callback = function ()
				uv0.isOpenCheck = false
			end
		})

		uv0.isOpenCheck = true
	end)
	slot0:AddBtnListener(slot0.bellBtn_, nil, function ()
		uv0.bellAni_.enabled = true

		uv0.bellAni_:Play("Fx_bell_cx", 0, 0)
		uv0.bellAni_:Update(0)

		if uv0.isOpenDetail then
			uv0.isOpenDetail = false

			uv0.bellController_:SetSelectedState("off")
		else
			uv0.isOpenDetail = true

			uv0.bellController_:SetSelectedState("on")
		end
	end)
	slot0:AddBtnListener(slot0.descGameBtn_, nil, function ()
		JumpTools.OpenPageByJump("hanafudaDescView", {
			callback = function ()
				uv0.isOpenDesc = false
			end
		})

		uv0.isOpenDesc = true
	end)
	slot0:AddBtnListener(slot0.giveUpBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.InitCardPoolItem(slot0)
	slot0.cardItemPool_ = {}

	for slot4 = 1, 24 do
		slot6 = HanafudaCardView.New(GameObject.Instantiate(slot0.cardGo_, slot0.cardPoolList_))

		table.insert(slot0.cardItemPool_, slot6)
		slot6:SetPlayerClickCallBack(function ()
			if not uv0.isDealingCard then
				uv0:ClickPlayerCard(uv1.index_)
			end
		end)
		slot6:SetPlaceClickCallBack(function ()
			if not uv0.isDealingCard then
				uv0:ClickPlaceCard(uv1.index_)
			end
		end)
	end
end

function slot0.PlayCardByIndex(slot0, slot1)
	slot3 = slot0.cardItemPool_[slot1].data_.placeType

	if not slot0.cardItemPool_[slot1].isFaceUp_ then
		slot2:FlipToFaceUp()
	end

	slot0:MoveCardToList(slot2.gameObject_, slot0.playAreaCardList_)
	HanafudaData:MoveCardToList(slot3, HanafudaData.CARD_PLACE_TYPE.PLACE, slot1)
	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_intable", "")

	if slot3 ~= HanafudaData.CARD_PLACE_TYPE.POOL then
		slot0:CheckPoolCards(slot2)
	else
		slot0.selectedCardIndex_ = 0

		HanafudaData:NextTurn()
		slot0:ShowChangeTrun()
	end
end

function slot0.ClickPlayerCard(slot0, slot1)
	if slot0.cardItemPool_[slot0.selectedCardIndex_] and slot0.cardItemPool_[slot0.selectedCardIndex_].data_.placeType == HanafudaData.CARD_PLACE_TYPE.POOL then
		return
	end

	slot0:ShowMatchingCard(slot1)

	if slot0.cardItemPool_[slot0.selectedCardIndex_] then
		slot0.cardItemPool_[slot0.selectedCardIndex_]:RefreshUI(slot1)
	end

	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_click", "")
	slot0.cardItemPool_[slot1]:RefreshUI(slot1)

	slot0.selectedCardIndex_ = slot1
end

function slot0.ShowMatchingCard(slot0, slot1)
	slot3 = HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.PLACE)
	slot0.gameState = HanafudaData:GetGameState()

	if slot1 ~= 0 and slot0.gameState == HanafudaData.GAME_STATE.PLAYER_TURN then
		SetActive(slot0.playBtn_.gameObject, table.isEmpty(HanafudaData:GetMatchingCardsIndexList(slot1)))
	end

	for slot7, slot8 in ipairs(slot3) do
		if table.indexof(slot2, slot8.index) then
			slot0.cardItemPool_[slot8.index]:RefreshUI(slot8.index, true, slot1)
		else
			slot0.cardItemPool_[slot8.index]:RefreshUI(0)
		end
	end
end

function slot0.ClickPlaceCard(slot0, slot1)
	if slot0.selectedCardIndex_ == 0 then
		return
	end

	slot0.gameState = HanafudaData:GetGameState()
	slot2, slot3 = nil

	if slot0.gameState == HanafudaData.GAME_STATE.PLAYER_TURN then
		slot2 = HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE
		slot3 = slot0.playerCombineCardList_
	elseif slot0.gameState == HanafudaData.GAME_STATE.COMPUTER_TURN then
		slot2 = HanafudaData.CARD_PLACE_TYPE.ENEMYCOMBINE
		slot3 = slot0.enemyCombineCardList_
	end

	slot4 = slot0.cardItemPool_[slot0.selectedCardIndex_]
	slot5 = slot4.data_.placeType

	if slot0.cardItemPool_[slot1].data_.race == slot4.data_.race then
		slot0:ShowMatchingCard(0)

		if not slot4.isFaceUp_ then
			slot4:FlipToFaceUp()
		end

		slot7 = HanafudaData:GetNewCombineList(slot2, {
			slot0.selectedCardIndex_
		}, true)

		HanafudaData:MoveCardToList(slot4.data_.placeType, slot2, slot0.selectedCardIndex_)

		slot8 = HanafudaData:GetNewCombineList(slot2, {
			slot1
		}, true)

		HanafudaData:MoveCardToList(slot6.data_.placeType, slot2, slot1)
		manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_inbook", "")
		slot0:MoveCardToList(slot6.gameObject_, slot3)
		slot0:MoveCardToList(slot4.gameObject_, slot3)

		if slot0.gameState == HanafudaData.GAME_STATE.PLAYER_TURN and (not table.isEmpty(slot7) or not table.isEmpty(slot8)) then
			for slot12, slot13 in ipairs(slot8) do
				table.insert(slot7, slot13)
			end

			slot0.isShowingCombine = true

			JumpTools.OpenPageByJump("hanafudaShowCombinePopView", {
				combineIdList = slot7,
				callback = function ()
					uv0.isShowingCombine = false

					uv0:RefreshPlayerScoreUI()
					uv0:RefreshUI()

					if uv1 == HanafudaData.CARD_PLACE_TYPE.POOL then
						uv0.selectedCardIndex_ = 0

						HanafudaData:NextTurn()
						uv0:ShowChangeTrun()
					end
				end
			})
		else
			slot0:RefreshEnemyScoreUI()
			slot0:RefreshPlayerScoreUI()
		end

		if slot5 ~= HanafudaData.CARD_PLACE_TYPE.POOL then
			slot0:CheckPoolCards(slot4)
		elseif not slot0.isShowingCombine then
			slot0.selectedCardIndex_ = 0

			HanafudaData:NextTurn()
			slot0:ShowChangeTrun()
		end

		slot0:RefreshPoolLeftCardUI()
	end
end

function slot0.ShowChangeTrun(slot0)
	slot1 = HanafudaData:GetGameState()

	if slot0.turnTimer_ then
		SetActive(slot0.trunChangeTrs_.gameObject, false)
		slot0.turnTimer_:Stop()
	end

	if slot1 == HanafudaData.GAME_STATE.PLAYER_TURN then
		slot0.turnController_:SetSelectedState("player")
		SetActive(slot0.trunChangeTrs_.gameObject, true)
	elseif slot1 == HanafudaData.GAME_STATE.COMPUTER_TURN then
		slot0.turnController_:SetSelectedState("enemy")
		SetActive(slot0.trunChangeTrs_.gameObject, true)
	end

	slot0.turnTimer_ = Timer.New(function ()
		SetActive(uv0.trunChangeTrs_.gameObject, false)
	end, 1, 1, true)

	slot0.turnTimer_:Start()
	slot0:RefreshUI()
end

function slot0.RefreshEnemyScoreUI(slot0)
	slot0.enemyScoreText_.text = HanafudaData:GetScoreByType(HanafudaData.CARD_PLACE_TYPE.ENEMY)
end

function slot0.RefreshPlayerScoreUI(slot0)
	slot0.playerScoreText_.text = HanafudaData:GetScoreByType(HanafudaData.CARD_PLACE_TYPE.PLAYER)
end

function slot0.RefreshPoolLeftCardUI(slot0, slot1)
	if slot0.isDealingCard then
		slot0.leftCardNumText_.text = slot1
	else
		slot0.leftCardNumText_.text = #HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.POOL)
	end

	slot0.enemyCombineCardNumText_.text = #HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.ENEMYCOMBINE)
	slot0.playerCombineCardNumText_.text = #HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE)
	slot3 = HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE)

	SetActive(slot0.enemyCombineGo_, #HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.ENEMYCOMBINE) > 0)
	SetActive(slot0.enemyCombineRaceTypeGo_, #slot2 > 0)
	SetActive(slot0.playerCombineGo_, #slot3 > 0)
	SetActive(slot0.playerCombineRaceTypeGo_, #slot3 > 0)

	if #slot2 > 0 then
		slot4 = slot2[#slot2]
		slot0.enemyCombineIconImg_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/Hanafuda/" .. slot4.id)
		slot0.enemyCombineRaceTypeImg_.sprite = getSprite("Atlas/CampItemAtlas", string.format("icon_group_%d_c", slot4.race))
	end

	if #slot3 > 0 then
		slot4 = slot3[#slot3]
		slot0.playerCombineIconImg_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/Hanafuda/" .. slot4.id)
		slot0.playerCombineRaceTypeImg_.sprite = getSprite("Atlas/CampItemAtlas", string.format("icon_group_%d_c", slot4.race))
	end
end

function slot0.CheckPoolCards(slot0, slot1)
	slot0.gameState = HanafudaData:GetGameState()

	if #HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.POOL) > 0 and #HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.PLACE) > 0 and slot1.data_.type ~= HanafudaData.CARD_PLACE_TYPE.POOL then
		slot4 = slot2[#slot2].index
		slot0.selectedCardIndex_ = slot4

		slot0:ShowMatchingCard(slot4)

		if slot0.gameState == HanafudaData.GAME_STATE.PLAYER_TURN then
			slot0.cardItemPool_[slot4]:SetFlipCallBack(function ()
				uv0:MovePoolCardToList(uv0.cardItemPool_[uv1].gameObject_, uv0.playerCardList_)
			end)
		else
			slot0.cardItemPool_[slot4]:SetFlipCallBack(function ()
				uv0:MovePoolCardToList(uv0.cardItemPool_[uv1].gameObject_, uv0.enemyCardList_)
			end)
		end

		slot0.cardItemPool_[slot4]:PlayFlipCardAni()
	end
end

function slot0.UpdateSelectCardIndex(slot0, slot1)
	slot0.selectedCardIndex_ = slot1
end

function slot0.OnEnter(slot0)
	slot1 = HanafudaData:GetActivityID()

	slot0.winBar:SetGameHelpKey("ACTIVITY_KAGUTSUCHI_CARD_DESCRIBE")
	slot0.winBar:RegistBackCallBack(function ()
		uv0:Back()
	end)
	slot0:ResetAnimator(slot0.bellAni_, "Fx_bell_cx")

	slot0.isOpenCheck = false
	slot0.isOpenDesc = false
	slot0.isOpenDetail = false

	SetActive(slot0.playBtn_.gameObject, false)
	HanafudaData:ResetGameData()
	HanafudaData:ResetGameState()
	slot0:ResetCardUI()
	slot0:RefreshUI()

	slot0.leftCardNumText_.text = 24

	if (getData("HanafudaGame", "hasPop") or 0) == 0 then
		saveData("HanafudaGame", "hasPop", 1)
		JumpTools.OpenPageByJump("hanafudaDescView")
	end

	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.KAGUTUSUCHI_HANAFUDA_REWARDED, slot1))
	slot0:AddTimer()
end

function slot0.AddTimer(slot0)
	slot0.leftTimeText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(KagutsuchiFishingEventData.activityID).stopTime)
	slot0.leftTimeTimer_ = Timer.New(function ()
		if uv0 <= manager.time:GetServerTime() then
			uv1.leftTimeText_.text = GetTips("TIME_OVER")

			return
		end

		uv1.leftTimeText_.text = manager.time:GetLostTimeStr2(uv0)
	end, 1, -1, true)

	slot0.leftTimeTimer_:Start()
end

function slot0.ResetAnimator(slot0, slot1, slot2)
	slot1:Play(slot2, 0, 0)
	slot1:Update(0)

	slot1.enabled = false
end

function slot0.StartDealCards(slot0)
	slot0.selectedCardIndex_ = 0

	slot0:RefreshUI()

	slot0.isDealingCard = true
	slot8 = 24

	slot0:RefreshPoolLeftCardUI(slot8)

	for slot8 = 24, 1, -1 do
		slot0.cardItemPool_[slot8]:SetData(slot8, HanafudaData:DealCards(HanafudaData:ShuffleCardList(HanafudaData:GetTotoalCardsList()))[slot8])
		slot0.cardItemPool_[slot8]:FlipToBackUp()
	end

	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_start", "")

	slot0.timer_ = Timer.New(function ()
		if uv1 > 20 then
			uv0:MoveCardToList(uv0.cardItemPool_[uv1].gameObject_, uv0.playerCardList_)
			uv0.cardItemPool_[uv1]:PlayFlipCardAni()
		elseif uv1 > 16 then
			uv0:MoveCardToList(slot0, uv0.enemyCardList_)
		elseif uv1 > 8 then
			uv0:MoveCardToList(slot0, uv0.playAreaCardList_)
			uv0.cardItemPool_[uv1]:PlayFlipCardAni()
		end

		uv1 = uv1 - 1

		uv0:RefreshPoolLeftCardUI(uv1)

		if uv1 == 8 then
			if uv0.isOpenCheck or uv0.isOpenDesc then
				uv0:Back()

				uv0.isOpenCheck = false
				uv0.isOpenDesc = false
			end

			uv0.isDealingCard = false

			uv0:CheckPlayerCards()

			if HanafudaData:GetGameState() ~= HanafudaData.GAME_STATE.GAMEOVER then
				JumpTools.OpenPageByJump("hanafudaSelectFirstPopView", {
					type = 1,
					callback = function ()
						uv0:RefreshEnemyCardsUI()
						uv0:ShowChangeTrun()
					end
				})
			end
		end
	end, 0.2, 16, false)
	slot0.aniTimer_ = Timer.New(function ()
		uv0.timer_:Start()
	end, 0.7, 1, true)

	slot0.aniTimer_:Start()
end

function slot0.RefreshEnemyCardsUI(slot0)
	for slot6, slot7 in ipairs(HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.ENEMY)) do
		if HanafudaData:GetComputerDiffculty() == 1 then
			slot0.cardItemPool_[slot7.index]:PlayFlipCardAni()
		else
			slot0.cardItemPool_[slot7.index].gameObject_.transform.localEulerAngles = Vector3.zero
		end
	end
end

function slot0.CheckPlayerCards(slot0)
	HanafudaData:CheckPlayerCards(HanafudaData.CARD_PLACE_TYPE.PLAYER)

	if HanafudaData:GetGameState() ~= HanafudaData.GAME_STATE.GAMEOVER then
		HanafudaData:CheckPlayerCards(HanafudaData.CARD_PLACE_TYPE.ENEMY)
	end

	slot0:RefreshUI()
end

function slot0.MoveCardToList(slot0, slot1, slot2)
	LeanTween.move(slot1, slot2.position, 0.4):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function ()
		if uv0.callback then
			uv0.callback()
		end

		uv1.transform:SetParent(uv2, false)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv2)
	end))
end

function slot0.MovePoolCardToList(slot0, slot1, slot2)
	slot3 = 0

	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_hand", "")
	LeanTween.move(slot1, Vector3(0, slot2.position.y + (slot0.gameState == HanafudaData.GAME_STATE.PLAYER_TURN and 0.2 or -0.2), slot2.position.z), 0.4):setEase(LeanTweenType.easeOutCubic)
end

function slot0.RefreshUI(slot0)
	if HanafudaData:GetGameState() == HanafudaData.GAME_STATE.STOP then
		slot0.stateController_:SetSelectedState("stop")

		slot5 = "off"

		slot0.bellController_:SetSelectedState(slot5)

		for slot5, slot6 in ipairs(slot0.cardItemPool_) do
			slot6.gameObject_.transform:SetParent(slot0.cardPoolList_, false)
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.cardPoolList_)
		slot0:ResetAnimator(slot0.bgAni_, "Fx_JapanRegionHanafudaGameUI_cx")
	else
		slot0.bgAni_.enabled = true

		slot0.stateController_:SetSelectedState("start")
	end

	if slot1 == HanafudaData.GAME_STATE.GAMEOVER and not slot0.isShowingCombine and not slot0.isDealingCard then
		KagutsuchiHanafudaAction.SendHanafudaGameOver(HanafudaData:GetActivityID(), HanafudaData:GetIsSuccess(), HanafudaData:GetPlayerCombineIDList())

		if slot0.isOpenCheck or slot0.isOpenDesc then
			slot0:Back()

			slot0.isOpenCheck = false
			slot0.isOpenDesc = false
		end

		JumpTools.OpenPageByJump("hanafudaGameOverPopView", {
			callback = function ()
				uv0:RefreshUI()
			end
		})
	end

	slot0:RefreshPoolLeftCardUI()
end

function slot0.ResetCardUI(slot0)
	for slot4, slot5 in ipairs(slot0.cardItemPool_) do
		slot0:MoveCardToList(slot5.gameObject_, slot0.cardPoolList_)

		slot5.gameObject_.transform.localEulerAngles = Vector3.zero
		slot5.flipCallBack = nil
	end
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	if slot0.aniTimer_ then
		slot0.aniTimer_:Stop()

		slot0.aniTimer_ = nil
	end

	if slot0.leftTimeTimer_ then
		slot0.leftTimeTimer_:Stop()

		slot0.leftTimeTimer_ = nil
	end

	HanafudaComputer.Stop()
	slot0:ResetCardUI()
	manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.KAGUTUSUCHI_HANAFUDA_REWARDED, HanafudaData:GetActivityID()))
	HanafudaData:ResetGameData()
	HanafudaData:ResetGameState()
	slot0:ResetCardUI()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.cardItemPool_) do
		slot5:Dispose()
	end

	slot0.cardItemPool_ = nil

	slot0.winBar:Dispose()
end

return slot0
