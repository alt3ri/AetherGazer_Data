slot0 = class("FishingGameQteView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingHomeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.modeController = ControllerUtil.GetController(slot0.transform_, "mode")
	slot0.winBar = KagutsuchiSpecialWinBarItem.New(slot0, slot0.winBar_)

	slot0:InitBtnListeners()
end

function slot0.Dispose(slot0)
	if slot0.gameTicker then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.gameTicker)

		slot0.gameTicker = nil
	end

	uv0.super.Dispose(slot0)
	slot0.winBar:Dispose()
end

function slot1(slot0, slot1)
	function slot2()
		uv0[uv1] = nil
	end

	return function ()
		if not uv0[uv1] then
			uv0[uv1] = true

			uv1(uv2)
		end
	end
end

function slot0.InitBtnListeners(slot0)
	slot0:AddBtnListener(slot0.qteBtn_, nil, uv0(handler(slot0, uv1.OnQTE), {}))
end

function slot2(slot0)
	slot2, slot3, slot4 = unpack(GameDisplayCfg.activity_kagutsuchi_fish_qte.value[HanafudaCardCfg[slot0].qte_type])

	return slot2 / 100, slot3, slot4
end

function slot3(slot0, slot1, slot2, slot3, slot4)
	if slot2 == KagutsuchiFishingEventData.EnumFishRarity.B then
		JumpTools.OpenPageByJump("kagutsuchiFishingGetNew", {
			fishID = slot0,
			staminaRecover = slot3,
			callback = function ()
				if uv0 then
					uv0()
				end

				if uv1 then
					JumpTools.OpenPageByJump("kagutsuchiFishingGet", {
						fishID = uv2,
						staminaRecover = uv3,
						lastRarity = uv4
					})
				else
					JumpTools.OpenPageByJump("kagutsuchiFishingGetFailed")
				end
			end
		})
	else
		slot5()
	end
end

function slot0.EndFishingGame(slot0, slot1, slot2, slot3, slot4)
	if slot0.gameTicker then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.gameTicker)

		slot0.gameTicker = nil
	end

	slot0.gameStarted = false

	if slot2 ~= nil then
		uv0(slot1, slot2, slot4, slot3, JumpTools.Back)
	else
		JumpTools.Back()
	end
end

slot4 = 4

function slot0.OnEnter(slot0)
	slot0.fishID = slot0.params_.fishID
	slot0.factor = 0
	slot1, slot2, slot3 = uv0(slot0.fishID)
	slot0.pause = false
	slot0.gameStarted = true
	slot4 = uv1
	slot0.gameTicker = FuncTimerManager.inst:CreateFuncFrameTimer(function ()
		uv0 = uv0 - Time.deltaTime

		if uv0 <= 0 and not uv1.pause then
			FuncTimerManager.inst:RemoveFuncTimer(uv1.gameTicker)

			uv1.gameTicker = nil

			uv1:InitGame(uv2, uv3, uv4)
		end
	end, -1, true)

	slot0.modeController:SetSelectedState("wait")
	slot0:RegisterEvents()
	slot0:ResetWindowBar()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.RegisterEvents(slot0)
end

function slot0.ResetWindowBar(slot0)
	manager.windowBar:HideBar()

	if slot0.backFunc == nil then
		function slot0.backFunc()
			uv0.pause = true

			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("ACTIVITY_KAGUTSUCHI_FISH_EXIT"),
				OkCallback = function ()
					uv0.gameStarted = false

					uv0.modeController:SetSelectedState("waitResult")
					manager.notify:Invoke(KAGUTSUCHI_FISHING_EVENT_QTE_FINISH, uv0.fishID, nil)
				end,
				CancelCallback = function ()
					uv0.pause = false
				end,
				MaskCallback = function ()
					uv0.pause = false
				end
			})
		end
	end

	slot0.winBar:RegistBackCallBack(slot0.backFunc)
end

function slot0.InitGame(slot0, slot1, slot2, slot3)
	if not slot0.gameStarted then
		return
	end

	slot0.sign = 1
	slot0.factor = 0
	slot3 = math.min(math.max(slot3, 0), 1)
	slot0.qteSpan = slot3
	slot0.gameTime = slot1
	slot4 = math.random() * (1 - slot3)
	slot0.range = {
		left = slot4,
		right = slot4 + slot3
	}
	slot0.pointerInRange = nil

	function slot5()
		slot0 = uv0.pause and 0 or Time.deltaTime

		uv0:UpdateFactorValue(slot0, 1 / uv1)
		uv0:UpdateDrawGameBar()
		uv0:UpdateTimeCountdown(slot0)
	end

	slot0.gameTicker = FuncTimerManager.inst:CreateFuncFrameTimer(slot5, -1, true)

	slot0.modeController:SetSelectedState("game")
	slot0:ResetWindowBar()
	slot5()
	manager.notify:Invoke(KAGUTSUCHI_FISHING_EVENT_QTE_START)
end

function slot0.UpdateFactorValue(slot0, slot1, slot2)
	if slot0.factor + slot1 * slot2 * slot0.sign > 1 then
		slot0.sign = -1
		slot3 = 2 - slot3
	elseif slot3 < 0 then
		slot0.sign = 1
		slot3 = -slot3
	end

	slot0.factor = slot3
end

function slot5(slot0, slot1, slot2)
	slot0.localPosition = slot0.parent:InverseTransformPoint(slot1:TransformPoint(slot2))
end

function slot6(slot0, slot1)
	return slot1.left <= slot0 and slot0 <= slot1.right
end

function slot0.UpdateDrawGameBar(slot0)
	if slot0.pointerInRange ~= uv0(slot0.factor, slot0.range) then
		slot0.successAreaAnimator_:Play(slot1 and "JapanRegionFishingHomeUI_glow" or "JapanRegionFishingHomeUI_glow02")
	end

	slot0.pointerInRange = slot1
	slot2 = slot0.qteIndicator_.rect

	uv1(slot0.area_, slot0.qteIndicator_, Vector2(slot0.range.left * slot2.width, 0))

	slot0.area_.sizeDelta = Vector2(slot0.qteSpan * slot2.width, slot2.height)

	uv1(slot0.pointer_, slot0.qteIndicator_, Vector2(slot0.qteIndicator_.rect.width * slot0.factor, 0))
end

function slot0.UpdateTimeCountdown(slot0, slot1)
	slot0.gameTime = slot0.gameTime - slot1
	slot0.countdown_.text = math.floor(math.max(slot0.gameTime, 0))

	if slot0.gameStarted and slot0.gameTime <= 0 and not slot0.pause then
		slot0.gameStarted = false

		slot0.modeController:SetSelectedState("waitResult")
		manager.notify:Invoke(KAGUTSUCHI_FISHING_EVENT_QTE_FINISH, slot0.fishID, false)
	end
end

function slot0.OnQTE(slot0, slot1)
	slot0.pause = true

	slot0.modeController:SetSelectedState("waitResult")

	slot0.gameStarted = false

	if uv0(slot0.factor, slot0.range) then
		KagutsuchiFishingEventAction.SendFishingSuccess(slot0.fishID, slot1)
	else
		manager.notify:Invoke(KAGUTSUCHI_FISHING_EVENT_QTE_FINISH, slot0.fishID, false)
		slot1()
	end
end

return slot0
