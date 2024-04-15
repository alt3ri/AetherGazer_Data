slot0 = class("PassportRewardPageView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.HeadTailChangeHandler(slot0, slot1, slot2)
	slot2 = math.max(1, slot2 + 1)

	if not slot0.minEndIndex_ then
		slot0.minEndIndex_ = slot2
	end

	slot0.nearestBonusIndex_ = slot0:GetNextBonusIndex(slot2)

	slot0:UpdateNextBonus()
end

function slot0.UpdateNextBonus(slot0)
	slot1 = BattlePassCfg[slot0.rewardIdList_[slot0.nearestBonusIndex_]]
	slot2 = GameLevelSetting[slot0.nearestBonusIndex_]
	slot0.nextBonusLevelLabel_.text = string.format("%d", slot0.nearestBonusIndex_)
	slot0.nextBonusBottomLabel_.text = string.format("%d", slot0.nearestBonusIndex_)

	slot0.nextCommonItem1_:RefreshData({
		id = slot1.reward_free[1][1],
		number = slot1.reward_free[1][2]
	})
	slot0.nextCommonItem2_:RefreshData({
		id = slot1.reward_pay[1][1],
		number = slot1.reward_pay[1][2]
	})

	slot3 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP)

	if PassportData:HaveGetBonus(slot1.id) then
		slot0.statusController_:SetSelectedState((PassportData:GetPayLevel() > 0 and "pay" or "free") .. "HaveGet")
	elseif slot2.battlepass_lv_exp_sum <= slot3 then
		if slot6 == "free" then
			slot0.statusController_:SetSelectedState(slot6 .. "CanGet")
		elseif PassportData:HaveReceiveInfo(slot1.id) then
			slot0.statusController_:SetSelectedState(slot6 .. "HalfCanGet")
		else
			slot0.statusController_:SetSelectedState(slot6 .. "CanGet")
		end
	else
		slot0.statusController_:SetSelectedState(slot6 .. "CannotGet")
	end
end

function slot0.OnEnter(slot0)
	slot0:AdaptScreen()
	slot0:AddEventListeners()
end

function slot0.Show(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.OnBuyPassportLevel(slot0)
	slot0.list_:Refresh()
	slot0:UpdateView()
	slot0:UpdateNextBonus()
end

return slot0
