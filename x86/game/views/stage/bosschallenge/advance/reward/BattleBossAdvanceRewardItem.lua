slot0 = class("BattleBossAdvanceRewardItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.rewardPanel_ = {}
	slot0.rewardList_ = {}

	for slot5 = 1, 3 do
		slot0.rewardPanel_[slot5] = slot0[string.format("rewardItem%s_", slot5)]
		slot0.rewardList_[slot5] = CommonItemView.New(slot0.rewardPanel_[slot5])
	end

	slot0.controller_ = slot0.transform_:GetComponent("ControllerExCollection"):GetController("status")
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
		if table.keyof(BattleBossChallengeAdvanceData:GetReceiveRewardList(), BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].reward[uv0.index_][1]) or BattleBossChallengeAdvanceData:GetTotalPoint() < slot1[1] then
			return
		end

		if #BattleBossChallengeAdvanceData:GetReceiveRewardList() <= 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("BOSS_CHALLENGE_REWARD_TIPS"),
				OkCallback = function ()
					uv0:ClickItem()
				end
			})
		else
			uv0:ClickItem()
		end
	end)
end

function slot0.ClickItem(slot0)
	BattleBossChallengeAction.RequireBossPointExchange(BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].reward[slot0.index_][1], function (slot0)
		if isSuccess(slot0.result) then
			getReward2(slot0.item_list)
			BattleBossChallengeAdvanceData:ModifyReceiveReward(uv0[1])
			manager.notify:Invoke(BOSS_CHALLENGE_RECEIVE_STAR_REWARD)
		else
			ShowTips(slot0.result)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.index_ = slot1
	slot3 = BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].reward[slot1]
	slot0.descText_.text = string.format(GetTips("CHALLENGE_MAX_POINT"), slot3[1])

	if table.keyof(BattleBossChallengeAdvanceData:GetReceiveRewardList(), slot3[1]) then
		slot0.controller_:SetSelectedState("state3")
	elseif slot3[1] <= BattleBossChallengeAdvanceData:GetTotalPoint() then
		slot0.controller_:SetSelectedState("state1")
	else
		slot0.controller_:SetSelectedState("state2")
	end

	for slot8, slot9 in pairs(getRewardFromDropCfg(slot3[2], true)) do
		slot11 = rewardToItemTemplate(slot9)

		function slot11.clickFun(slot0)
			ShowPopItem(POP_ITEM, slot0)
		end

		CommonTools.SetCommonData(slot0.rewardList_[slot8], slot11)
	end

	for slot8 = #slot4 + 1, #slot0.rewardList_ do
		slot0.rewardList_[slot8]:SetData()
	end
end

return slot0
