slot0 = class("ZumaGameSettleView", ReduxView)
slot1 = {
	progress = {
		noStar = "noStar",
		name = "Progress",
		star2 = "state3",
		star1 = "state2",
		star0 = "state1",
		star3 = "state4"
	},
	state = {
		lose = "state0",
		name = "state",
		win = "state1"
	},
	gameState = {
		haveReward = "state0",
		name = "default",
		noReward = "state2"
	}
}

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaResultPopup"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.progressController = slot0.controllerexcollection_:GetController(uv0.progress.name)
	slot0.stateController = slot0.controllerexcollection_:GetController(uv0.state.name)
	slot0.gameStateController = slot0.controllerexcollection_:GetController(uv0.gameState.name)
	slot0.iconImg_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.confirmbtnBtn_, nil, function ()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.RefreshUI(slot0)
	slot1 = slot0.params_.isWin or false

	slot0.stateController:SetSelectedState(slot1 and uv0.state.win or uv0.state.lose)

	slot0.scoreTxt_.text = ZumaData:GetZumaScore()

	if slot1 then
		slot0:RefreshWinUi()

		slot4 = ZumaData:GetZumaGameId()

		ZumaAction.QueryZumaCompelet(ActivityZumaLevelCfg[slot4].main_activity_id, slot4, slot1 and 1 or 2, slot3, ZumaToLuaBridge.GetZumaGamePlayTime())
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter", "")
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_bingo", "")
	else
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_fail", "")
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_error", "")
	end
end

function slot0.RefreshWinUi(slot0)
	slot2 = ZumaData:GetZumaGameId()
	slot5, slot6 = ZumaData:GetZumaFinishPointList(ZumaData:GetZumaScore(), ActivityZumaLevelCfg[slot2].activity_point_reward)
	slot7 = #slot5
	slot9, slot10 = ZumaData:GetZumaFinishPointList(ZumaData:GetZumaStageScore(slot2) or 0, slot4)
	slot11 = math.max(slot6 - slot10, 0)

	if slot3.difficult == 3 then
		slot0.progressController:SetSelectedState(uv0.progress.noStar)
	elseif slot7 == 0 then
		slot0.progressController:SetSelectedState(uv0.progress.star0)
	elseif slot7 == 1 then
		slot0.progressController:SetSelectedState(uv0.progress.star1)
	elseif slot7 == 2 then
		slot0.progressController:SetSelectedState(uv0.progress.star2)
	elseif slot7 == 3 then
		slot0.progressController:SetSelectedState(uv0.progress.star3)
	end

	slot13 = 0

	if (slot8 == nil and slot3.first_reward + slot11 or slot3.repeat_reward + slot11) ~= 0 then
		slot0.gameStateController:SetSelectedState(uv0.gameState.haveReward)
	else
		slot0.gameStateController:SetSelectedState(uv0.gameState.noReward)
	end

	slot0.rewardNumsTxt_.text = slot13
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
