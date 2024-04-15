slot0 = class("SnowballGameResultPopup", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/SnowballGameResultPopup"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.modeController = ControllerUtil.GetController(slot0.transform_, "mode")
	slot0.rewardController = ControllerUtil.GetController(slot0.transform_, "reward")

	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		JumpTools.Back()

		if uv0.OkCallback then
			uv0.OkCallback()
		end
	end)
end

slot1 = {
	"normal",
	"hard",
	"infinite"
}

function slot2(slot0, slot1)
	slot2 = nil

	for slot7 = 1, #slot1.level_score + 1 do
		if slot0 <= (slot1.level_score[slot7] or math.huge) then
			return slot1.level_reward[slot7] or slot1.level_reward[#slot1.level_score]
		end
	end
end

function slot0.OnEnter(slot0)
	slot2 = SnowballGameCfg[slot0.params_.level]
	slot3 = slot0.params_.hitGuestCount or 0

	slot0.modeController:SetSelectedState(uv0[slot2.level_mode])

	slot0.OkCallback = slot0.params_.OkCallback
	slot4 = GameSetting.activity_snowball_score_difficulty_factor.value[slot2.level_mode] or 1
	slot7 = slot0.params_.score + math.floor(math.ceil(slot0.params_.extraTime) * GameSetting.activity_snowball_score_countdown_bonus.value[1])
	slot8 = math.ceil(slot7 * slot4)
	slot0.score_.text = slot7

	if slot4 == 1 then
		slot0.scale_.gameObject:SetActive(false)
	else
		slot0.scale_.gameObject:SetActive(true)

		slot0.scale_.text = "x" .. slot4

		if slot0.textAni then
			LeanTween.cancel(slot0.textAni.id)
		end

		slot9 = LeanTween.value(slot7, slot8, 2):setEase(LeanTweenType.easeInOutQuad):setDelay(1.5)

		slot9:setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.score_.text = math.floor(slot0)
		end))
		slot9:setOnComplete(System.Action(function ()
			uv0.score_.text = uv1
			uv0.textAni = nil
		end))

		slot0.textAni = slot9
	end

	slot0.time_.text = manager.time:DescCDTime(slot2.time_limit - slot5)

	slot0.rewardController:SetSelectedState(uv1(slot8, slot2) ~= nil and "show" or "hide")

	if slot9 then
		slot0.rewardIcon_.sprite = ItemTools.getItemLittleSprite(slot9[1])
		slot0.reward_.text = string.format("+%d", slot9[2])
	end

	slot11 = 1

	for slot15, slot16 in pairs(slot0.params_.enemyList) do
		slot11 = slot11 + 1
	end

	SnowballGameAction.LevelClearAction({
		level = slot1,
		score = slot8,
		seconds = slot2.time_limit - slot5,
		heroId = SnowballGameMgr.GetInstance():GetPlayerCfgID(),
		enemy_list = {
			[slot11] = {
				id = slot15,
				count = slot16
			},
			[slot11] = {
				count = slot3,
				id = SnowballGameMgr.GetInstance():GetGuestCfgID()
			}
		}
	})
end

function slot0.OnExit(slot0)
	if slot0.textAni then
		LeanTween.cancel(slot0.textAni.id)

		slot0.textAni = nil
	end
end

return slot0
