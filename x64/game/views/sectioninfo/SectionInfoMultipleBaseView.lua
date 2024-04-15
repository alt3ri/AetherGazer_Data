slot0 = class("SectionInfoMultipleBaseView", import(".SectionInfoBaseView"))
slot1 = #GameSetting.challenge_multiple_count_unlock_level.value

function slot0.Init(slot0)
	uv0.super.Init(slot0)
	slot0.hideMultiplePanelController_:SetSelectedState("false")
end

function slot0.AddListeners(slot0)
	uv0.super.AddListeners(slot0)
	slot0:AddBtnListener(slot0.minMultipleBtn_, nil, function ()
		OperationRecorder.Record(uv0.class.__cname, "challenge_multiple")

		uv0.multiple_ = 1

		uv0:ChangeMultiple()
	end)
	slot0:AddBtnListener(slot0.subBtn_, nil, function ()
		OperationRecorder.Record(uv0.class.__cname, "single")

		uv0.multiple_ = uv0.multiple_ - 1

		uv0:ChangeMultiple()
	end)
	slot0:AddBtnListener(slot0.addBtn_, nil, function ()
		OperationRecorder.Record(uv0.class.__cname, "single")

		if uv0.challengeCnt_ <= uv0.multiple_ then
			ShowTips(uv0:GetChallengeCntMaxTip())

			return
		end

		uv0.multiple_ = uv0.multiple_ + 1

		uv0:ChangeMultiple()
	end)
	slot0:AddBtnListener(slot0.maxMultipleBtn_, nil, function ()
		OperationRecorder.Record(uv0.class.__cname, "challenge_multiple")

		slot0 = uv0.maxMultiple_

		if uv0.challengeCnt_ < uv0.maxMultiple_ then
			slot0 = uv0.challengeCnt_
		end

		uv0.multiple_ = slot0

		uv0:ChangeMultiple()
	end)
end

function slot0.RemoveListeners(slot0)
	uv0.super.RemoveListeners(slot0)
	slot0.minMultipleBtn_.onClick:RemoveAllListeners()
	slot0.subBtn_.onClick:RemoveAllListeners()
	slot0.addBtn_.onClick:RemoveAllListeners()
	slot0.maxMultipleBtn_.onClick:RemoveAllListeners()
end

function slot0.OnCurrencyChange(slot0)
	uv0.super.OnCurrencyChange(slot0)
	slot0:RefreshMultiple()
end

function slot0.RefreshData(slot0)
	slot1 = 1

	for slot5 = uv0, 1, -1 do
		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) >= slot0.cost_ * slot5 then
			slot1 = slot5

			break
		end
	end

	slot0.maxMultiple_ = slot1
	slot0.multiple_ = slot0.multiple_ or 1
	slot0.challengeCnt_ = slot0:GetUnlockChallengeCnt()
end

function slot0.RefreshUI(slot0)
	uv0.super.RefreshUI(slot0)
	slot0:RefreshMultiple()
end

function slot0.OnClickBtn(slot0)
end

function slot0.ChangeMultiple(slot0)
	slot0:RefreshMultiple()
	slot0:RefreshCost()
	slot0:RefreshBtn()
end

function slot0.RefreshMultiple(slot0)
	slot0.multipleText_.text = "x" .. slot0.multiple_

	if slot0.maxMultiple_ <= slot0.multiple_ or slot0.challengeCnt_ <= slot0.multiple_ then
		slot0.maxMultipleBtn_.interactable = false
		slot0.maxMultipleBtnCanvas_.alpha = 0.5
		slot0.minMultipleBtn_.interactable = true
		slot0.minMultipleCanvas_.alpha = 1
		slot0.subBtn_.interactable = true
		slot0.subBtnCanvas_.alpha = 1
	elseif slot0.multiple_ <= 1 then
		slot0.maxMultipleBtn_.interactable = true
		slot0.maxMultipleBtnCanvas_.alpha = 1
		slot0.minMultipleBtn_.interactable = false
		slot0.minMultipleCanvas_.alpha = 0.5
		slot0.subBtn_.interactable = false
		slot0.subBtnCanvas_.alpha = 0.5
	else
		slot0.maxMultipleBtn_.interactable = true
		slot0.maxMultipleBtnCanvas_.alpha = 1
		slot0.minMultipleBtn_.interactable = true
		slot0.minMultipleCanvas_.alpha = 1
		slot0.subBtn_.interactable = true
		slot0.subBtnCanvas_.alpha = 1
	end

	if slot0.multiple_ == uv0 then
		slot0.addBtn_.interactable = false
		slot0.addBtnCanvas_.alpha = 0.5
	else
		slot0.addBtn_.interactable = true
		slot0.addBtnCanvas_.alpha = 1
	end

	if slot0.multiple_ <= 1 then
		slot0.minMultipleBtn_.interactable = false
		slot0.minMultipleCanvas_.alpha = 0.5
		slot0.subBtn_.interactable = false
		slot0.subBtnCanvas_.alpha = 0.5
	end
end

function slot0.GetUnlockChallengeCnt(slot0)
	for slot6, slot7 in ipairs(GameSetting.challenge_multiple_count_unlock_level.value) do
		if PlayerData:GetPlayerInfo().userLevel < slot7 then
			return slot6 - 1
		end
	end

	return #slot1
end

function slot0.GetChallengeCntMaxTip(slot0)
	return string.format(GetTips("PLAYER_LEVEL_UNLOCK"), GameSetting.challenge_multiple_count_unlock_level.value[slot0.multiple_ + 1])
end

return slot0
