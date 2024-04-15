slot0 = class("HanafudaGameOverPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaWinUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.wincontroller_ = ControllerUtil.GetController(slot0.transform_, "result")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.callback_ = slot0.params_.callback
	slot0.playerScore = HanafudaData:GetScoreByType(HanafudaData.CARD_PLACE_TYPE.PLAYER)
	slot0.enemyScore = HanafudaData:GetScoreByType(HanafudaData.CARD_PLACE_TYPE.ENEMY)

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.rewardText_.text = math.max(0, math.min(GameSetting.activity_kagutsuchi_fatigue_hanafuda_card_recover.value[1], GameSetting.activity_kagutsuchi_battle_fatigue_max.value[1] - KagutsuchiWorkData:GetStamina()))
	slot0.currencyImg_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id)
	slot0.playerScoreText_.text = slot0.playerScore
	slot0.enemyScoreText_.text = slot0.enemyScore

	if slot0.enemyScore <= slot0.playerScore then
		SDKTools.SendMessageToSDK("activity_kagutsuchi_hanafuda_card", {
			result = 1,
			reach_group_id = table.toString(HanafudaData:GetPlayerCombineIDList()),
			activity_id = HanafudaData:GetActivityID()
		})
		manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_fish_win", "")
		slot0.wincontroller_:SetSelectedState("win")
	elseif slot0.playerScore < slot0.enemyScore then
		SDKTools.SendMessageToSDK("activity_kagutsuchi_hanafuda_card", {
			result = 2,
			reach_group_id = table.toString(HanafudaData:GetPlayerCombineIDList()),
			activity_id = HanafudaData:GetActivityID()
		})
		manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_fish_fail", "")
		slot0.wincontroller_:SetSelectedState("lose")
	end
end

function slot0.OnExit(slot0)
	HanafudaData:ResetGameData()
	HanafudaData:ResetGameState()
	slot0.callback_()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
