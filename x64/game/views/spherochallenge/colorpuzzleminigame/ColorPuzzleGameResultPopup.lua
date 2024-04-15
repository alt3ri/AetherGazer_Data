slot0 = class("ColorPuzzleGameResultPopup", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/SPHeroChallenge/ColorPuzzle/ColorPuzzleResultPopup"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot4 = slot0.maskBtn_

	slot0:AddBtnListener(slot4, nil, function ()
		JumpTools.Back()

		if uv0.okCallback then
			uv0.okCallback()
		end
	end)

	slot0.rewardItem = {}

	for slot4 = 1, slot0.reward_.childCount do
		slot5 = slot0.reward_:GetChild(slot4 - 1).gameObject
		slot6 = {
			gameObject = slot5
		}

		slot0:BindCfgUI(slot5, slot6)

		slot0.rewardItem[slot4] = slot6
	end
end

function slot0.OnEnter(slot0)
	slot0.okCallback = slot0.params_.okCallback
	slot0.levelName_.text = GetI18NText(ActivityHeroChallengeColor[slot0.params_.level].name)
	slot4 = manager.time
	slot6 = slot4
	slot7 = slot0.params_.time
	slot0.time_.text = slot4.DescCDTime(slot6, slot7)

	for slot6, slot7 in ipairs(slot0.rewardItem) do
		slot9 = nullable(nullable(slot0.params_.rewards, slot6), "num") or 0

		if slot8 and slot9 > 0 then
			SetActive(slot7.gameObject, true)

			slot7.icon_.sprite = ItemTools.getItemLittleSprite(slot8.id)
			slot7.count_.text = slot9
		else
			SetActive(slot7.gameObject, false)
		end
	end
end

return slot0
