slot0 = class("NewServerCapsuleToysPage", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot3 = Object.Instantiate(Asset.Load("Widget/System/NewServer/NewServerGashaponUI"), slot1)
	slot0.gameObject_ = slot3
	slot0.transform_ = slot3.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.rewardItemList_ = {}
	slot0.itemDataList_ = {}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.drawOnceBtn_, nil, function ()
		if not ActivityTools.ActivityOpenCheck(uv0.activityID_) then
			return
		end

		if NewServerCfg[uv0.activityID_].coin_num <= ItemTools.getItemNum(NewServerCfg[uv0.activityID_].coin_id) then
			manager.audio:PlayEffect("ui_system", "back_niudan")
			NewServerAction.CapsuleToysDraw(1, handler(uv0, uv0.OnCapsuleToysDraw))
		else
			ShowTips("ITEM_NOT_ENOUGH_RETURN_MATERIAL")
		end
	end)
	slot0:AddBtnListener(slot0.drawMultipleBtn_, nil, function ()
		if not ActivityTools.ActivityOpenCheck(uv0.activityID_) then
			return
		end

		if ItemTools.getItemNum(NewServerCfg[uv0.activityID_].coin_id) >= NewServerCfg[uv0.activityID_].coin_num * 2 then
			manager.audio:PlayEffect("ui_system", "back_niudan")
			NewServerAction.CapsuleToysDraw(math.floor(slot2 / slot1) <= 10 and slot3 or 10, handler(uv0, uv0.OnCapsuleToysDraw))
		else
			ShowTips("ITEM_NOT_ENOUGH_RETURN_MATERIAL")
		end
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("newServerCapsuleToysReward", {
			activityID = uv0.activityID_
		})
	end)
end

function slot0.Dispose(slot0)
	if slot0.rewardItemList_ then
		for slot4, slot5 in ipairs(slot0.rewardItemList_) do
			slot5:Dispose()
		end

		slot0.rewardItemList_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 == false then
		if slot0.timer_ ~= nil then
			slot0.timer_:Stop()

			slot0.timer_ = nil
		end

		manager.ui:UIEventEnabledByUI(true, false)
	end
end

function slot0.SetData(slot0, slot1)
	slot0.activityID_ = slot1
	slot0.rewardCfgList_ = {}

	for slot7, slot8 in ipairs(NewServerCfg[slot0.activityID_].gashapon) do
		if NewServerCapsuleToysCfg[slot8].reward_type == 1 then
			slot0.rewardCfgList_[#slot0.rewardCfgList_ + 1] = slot8
		end
	end

	for slot7, slot8 in ipairs(slot0.rewardCfgList_) do
		if not slot0.rewardItemList_[slot7] then
			slot0.rewardItemList_[slot7] = NewServerCapsuleToysItem.New(Object.Instantiate(slot0.rewardGo_, slot0.rewardPanelTrans_))
		end

		slot0.rewardItemList_[slot7]:SetData(slot8)
	end

	for slot7 = #slot0.rewardCfgList_ + 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot7]:Show(false)
	end

	slot4 = NewServerCfg[slot0.activityID_].coin_id
	slot5 = NewServerCfg[slot0.activityID_].coin_num
	slot0.drawOnceIcon_.sprite = ItemTools.getItemSprite(slot4)
	slot0.drawOnceCostText_.text = "x" .. slot5
	slot0.drawMultiIcon_.sprite = ItemTools.getItemSprite(slot4)
	slot0.drawMultiCostText_.text = "x" .. tostring(slot5 * 10)

	slot0:RefreshMultiDrawBtn()
end

function slot0.OnCapsuleToysDraw(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		slot3 = {}
		slot4 = {}

		for slot8, slot9 in ipairs(slot1.item_list) do
			slot10 = slot9.id
			slot3[#slot3 + 1] = {
				slot10,
				slot9.num
			}
			slot12 = nil
			slot12 = (slot10 ~= 0 or NewServerCfg[slot0.activityID_].gashapon_default) and NewServerCapsuleToysCfg[slot10].reward
			slot4[#slot4 + 1] = {
				id = slot12[1],
				num = slot12[2] * slot11
			}
		end

		NewServerData:SetCapsuleToysStatus(slot3)
		slot0:GetCapsuleReward(slot4)
	else
		ShowTips(slot1.result)
	end
end

function slot0.GetCapsuleReward(slot0, slot1)
	manager.ui:UIEventEnabledByUI(false, true)
	slot0:RefreshMultiDrawBtn()
	slot0.animator_:Play("Fx_niudanji_cx", -1, 0)
	slot0.animator_:Update(0)

	if slot0.timer_ ~= nil then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0.timer_ = Timer.New(function ()
		if uv0.animator_:GetCurrentAnimatorStateInfo(0):IsName(uv1) and slot0.normalizedTime >= 1 then
			if uv0.timer_ ~= nil then
				uv0.timer_:Stop()

				uv0.timer_ = nil
			end

			uv0:SetData(uv0.activityID_)

			for slot4, slot5 in ipairs(uv2) do
				if slot5.id == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_IOS or slot5.id == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_NOT_IOS then
					slot5.id = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE
				end
			end

			manager.ui:UIEventEnabledByUI(true, false)
			getReward(uv2)
		end
	end, 0.033, -1)

	slot0.timer_:Start()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NewServerCfg[slot0.activityID_].coin_id
	})
	manager.windowBar:SetBarCanClick(NewServerCfg[slot0.activityID_].coin_id, true)
end

function slot0.RefreshMultiDrawBtn(slot0)
	slot4 = 2

	if ItemTools.getItemNum(NewServerCfg[slot0.activityID_].coin_id) >= NewServerCfg[slot0.activityID_].coin_num * 2 then
		slot4 = math.floor(slot3 / slot2) <= 10 and slot5 or 10
	end

	slot0.multiDrawTimesText_.text = string.format(GetTips("REGRESSION_GASHAPON_EXTRACT"), slot4)
	slot0.drawMultiCostText_.text = "x" .. tostring(slot2 * slot4)
end

function slot0.OnExit(slot0)
	if slot0.timer_ ~= nil then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
