slot0 = class("MythicFinalRewardItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.rewardPanel_ = {}
	slot0.rewardList_ = {}
	slot0.controller_ = slot0.transform_:GetComponent("ControllerExCollection"):GetController("status")
end

function slot0.Init(slot0, slot1)
	slot0.index_ = MythicData:GetRealIndex(slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.rewardList_) do
		slot5:Dispose()
	end

	slot0.rewardList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if MythicData:GetFinalIsReward() == 0 then
			ShowMessageBox({
				content = GetTips("MYTHIC_REWARD_LOACK_DIFFICULTY"),
				OkCallback = function ()
					MythicAction:GetFinalReward(uv0.index_)
				end
			})
		else
			MythicAction:GetFinalReward(uv0.index_)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0:Init(slot1)
	slot0:RefreshData()
	slot0:RefreshUI()
	slot0:RefreshState()
	slot0:RefreshItem()
end

function slot0.RefreshData(slot0)
	slot0.rewradCfg_ = MythicFinalCfg[slot0.index_].reward_list

	for slot4 = 1, 4 do
		if not slot0.rewardList_[slot4] then
			slot0.rewardPanel_[slot4] = Object.Instantiate(slot0.rewardItem, slot0.contentTrs_)
			slot0.rewardList_[slot4] = CommonItemView.New(slot0.rewardPanel_[slot4])
		end
	end

	for slot4 = #slot0.rewradCfg_ + 1, #slot0.rewardList_ do
		slot0.rewardList_[slot4]:SetData()
	end
end

function slot0.RefreshUI(slot0)
	slot0.descText_.text = string.format(GetTips("MYTHIC_FINAL_REWARD_TIPS"), slot0.index_)
end

function slot0.RefreshState(slot0)
	if MythicData:GetPassHotLevel() < slot0.index_ then
		slot0.controller_:SetSelectedState("state2")
	elseif MythicData:GetFinalRewardStateByHotLevel(slot0.index_) then
		slot0.controller_:SetSelectedState("state3")
	else
		slot0.controller_:SetSelectedState("state1")
	end
end

function slot0.RefreshItem(slot0)
	for slot5, slot6 in pairs(slot0.rewradCfg_) do
		if slot5 > 6 then
			return
		end

		slot7 = rewardToItemTemplate(formatReward(slot6))

		if MythicData:GetFinalRewardStateByHotLevel(slot0.index_) then
			slot7.grayFlag = true
		end

		function slot7.clickFun(slot0)
			ShowPopItem(POP_ITEM, slot0)
		end

		CommonTools.SetCommonData(slot0.rewardList_[slot5], slot7)
	end
end

return slot0
