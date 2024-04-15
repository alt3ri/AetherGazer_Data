slot0 = class("ColorPuzzleGameView", ReduxView)
slot1 = 53100

function slot0.GetLevelRoot(slot0)
	return "Widget/System/SPHeroChallenge/ColorPuzzle/Levels/"
end

function slot0.UIName(slot0)
	return "Widget/System/SPHeroChallenge/ColorPuzzle/ColorPuzzleGameView"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
	slot0.level = nil
	slot0.totalTry = nil
	slot0.letMeTry = nil
	slot0.gameLevel = nil
	slot0.useAutoComplete = nil
	slot0.time = nil
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:InitUI()
end

function slot2()
	return nullable(GameSetting, "activity_hero_challenge_color_cost", "value", 1) or 0
end

function slot3(slot0)
	if uv0() <= ItemTools.getItemNum(uv1) then
		return true
	elseif slot0 then
		ShowTips("ACTIVITY_HERO_CHALLENGE_COIN_LACK")
	end

	return false
end

function slot0.InitUI(slot0)
	slot0.costItemIcon_.sprite = ItemTools.getItemLittleSprite(uv0)

	if not uv2() then
		slot1 = "<color=#FF0000>" .. uv1() .. "</color>"
	end

	slot0.costAmount_.text = slot1
	slot0.autoCompleteController = slot0.controllers_:GetController("autoComplete")
	slot0.completeHighlightController = slot0.controllers_:GetController("complete")

	slot0:AddBtnListenerScale(slot0.autoCompleteBtn_, nil, function ()
		if uv0.gameLevel and not uv0.gameLevel:CheckComplete() and uv0.autoCompleteController:GetSelectedState() == "ready" and uv1(true) then
			uv0.gameLevel:AutoComplete()

			uv0.useAutoComplete = true

			uv0.completeHighlightController:SetSelectedState("true")
		end
	end)
	slot0:AddBtnListenerScale(slot0.clearAllBtn_, nil, function ()
		if uv0.gameLevel then
			uv0.gameLevel:ClearNodes()

			if not uv0.reset then
				uv0.reset = true

				uv0:ReportClear()
			end
		end
	end)
	slot0:AddBtnListenerScale(slot0.checkCompleteBtn_, nil, function ()
		if uv0.gameLevel and uv0.gameLevel:CheckComplete(true) then
			uv0:StopTimeWatch()
			uv0:EndGame()
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.level = slot0.params_.level
	slot1 = ActivityHeroChallengeColor[slot0.level]

	slot0:DisposeGame()

	slot0.gameLevel = Object.Instantiate(Asset.Load(slot0:GetLevelRoot() .. slot1.level_asset_name), slot0.levelContainer_):GetComponent("ColorPuzzle")

	slot0.autoCompleteController:SetSelectedState("lock")

	slot0.totalTry = slot1.attempt
	slot0.letMeTry = slot1.attempt

	slot0:SetupGameCallbacks()
	slot0:ResetGame()

	slot0.pause = false

	slot0:StartTimeWatch()
	slot0:SetTips(slot1)
end

function slot0.OnExit(slot0)
	slot0:StopTimeWatch()
	slot0:DisposeGame()
end

function slot4(slot0)
	if not slot0.pause then
		slot0.pause = true

		ShowMessageBox({
			content = GetTips("ACTIVITY_HERO_COLOR_EXIT"),
			OkCallback = function ()
				uv0.pause = false

				uv0:EndGame(true)
			end,
			CancelCallback = function ()
				uv0.pause = false
			end
		})
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		uv0
	})
	manager.windowBar:RegistBackCallBack(handler(slot0, uv1))
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.DisposeGame(slot0)
	if slot0.gameLevel then
		Object.Destroy(slot0.gameLevel.gameObject)

		slot0.gameLevel = nil
	end
end

function slot0.SetupGameCallbacks(slot0)
	slot0.gameLevel:SetBeforeApplyValueCallback(function (slot0, slot1)
		if slot0 ~= slot1 then
			uv0.letMeTry = uv0.letMeTry - 1

			uv0:UpdateAutoComplete()
		end
	end)
	slot0.gameLevel:SetOnNodeClickCallback(function (slot0)
		uv0.completeHighlightController:SetSelectedState(slot0 and "true" or "false")
	end)
end

function slot0.UpdateAutoComplete(slot0)
	if slot0.letMeTry > 0 then
		slot0.autoCompleteProgress_.fillAmount = 1 - slot0.letMeTry / slot0.totalTry

		slot0.autoCompleteController:SetSelectedState("lock")
	else
		slot0.autoCompleteProgress_.fillAmount = 1

		if not slot0.gameLevel:CheckComplete() then
			slot0.autoCompleteController:SetSelectedState("ready")
		else
			slot0.autoCompleteController:SetSelectedState("lock")
		end
	end
end

function slot0.StartTimeWatch(slot0)
	slot0:StopTimeWatch()

	slot0.time = 0
	slot0.updateTicker = FuncTimerManager.inst:CreateFuncFrameTimer(handler(slot0, slot0.Update), -1, true)
end

function slot0.StopTimeWatch(slot0)
	if slot0.updateTicker then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.updateTicker)

		slot0.updateTicker = nil
	end
end

function slot0.Update(slot0)
	slot0.time = (slot0.time or 0) + (slot0.pause and 0 or Time.unscaledDeltaTime)
end

function slot0.EndGame(slot0, slot1)
	slot3 = nil

	slot0:ResetGame()

	if not slot1 then
		ColorPuzzleAction.LevelClearAction({
			stage_id = slot0.level,
			result = slot1 and 3 or 1,
			useseconds = slot0.time,
			auto_completed = slot0.useAutoComplete and 1 or 0
		}, function (slot0, slot1)
			gameContext:Go("colorPuzzleResultPopup", {
				level = slot0.stage_id,
				time = slot0.useseconds,
				autoComplete = slot0.auto_completed == 1,
				rewards = slot1.reward_list,
				okCallback = JumpTools.Back
			})
		end)
	else
		JumpTools.Back()
	end

	slot0:SendSdkMsg(slot2)
end

function slot0.ResetGame(slot0)
	slot0.time = 0
	slot0.useAutoComplete = false

	slot0.gameLevel:ClearNodes()
	slot0:UpdateAutoComplete()
	slot0.completeHighlightController:SetSelectedState("false")
end

function slot0.ReportClear(slot0)
	slot0:SendSdkMsg({
		auto_completed = 0,
		result = 4,
		stage_id = slot0.level,
		useseconds = slot0.time
	})
end

function slot0.SendSdkMsg(slot0, slot1)
	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = SPHeroChallengeData.activityCfg[SPHeroChallengeData:GetActivityID()].colorPuzzleActiVityID,
		stage_id = slot1.stage_id,
		result = slot1.result,
		use_seconds = slot1.useseconds,
		is_help = slot0.useAutoComplete or false
	})
end

function slot0.SetTips(slot0, slot1)
	if nullable(slot1, "tips_icon") == "" then
		SetActive(slot0.tipsIcon_, false)
	else
		SetActive(slot0.tipsIcon_, true)

		slot0.tipsIcon_.sprite = getSpriteWithoutAtlas(slot2)
	end

	slot0.tipsContent_.text = GetI18NText(slot1.tips)
end

return slot0
