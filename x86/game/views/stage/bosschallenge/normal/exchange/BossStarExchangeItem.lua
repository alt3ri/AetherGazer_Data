slot0 = class("BossStarExchangeItem", ReduxView)
slot1 = "notclear"
slot2 = "clear"
slot3 = "received"

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardPanel_ = {}
	slot0.rewardItemList_ = {}

	for slot4 = 1, 3 do
		slot0.rewardPanel_[slot4] = slot0[string.format("rewardItem%s_", slot4)]
		slot0.rewardItemList_[slot4] = CommonItemView.New(slot0.rewardPanel_[slot4])
	end

	slot0.controller_ = slot0.transform_:GetComponent("ControllerExCollection"):GetController("default0")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if uv0.rewardState_ == uv1 then
			if table.length(BattleBossChallengeNormalData:GetReceiveStarList()) <= 0 then
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
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.rewardIndex_ = slot3
	slot0.rewardCfg_ = getRewardFromDropCfg(slot1[2], true)
	slot0.totalStarCnt_ = slot1[1]
	slot0.curStarCnt_ = slot1[1] < slot2 and slot1[1] or slot2

	slot0:GetRewardState()
	slot0:RefreshUI(slot2)
	slot0:RefreshState()
	slot0:RefreshItem()
end

function slot0.RefreshUI(slot0, slot1)
	slot0.progressCntText_.text = string.format(GetTips("COMPLETE_TARGET"), slot0.totalStarCnt_)
	slot0.progressText_.text = string.format("%s/%s", slot1, slot0.totalStarCnt_)
	slot0.progressBar_.value = slot1 / slot0.totalStarCnt_

	if slot0.rewardIndex_ < 10 then
		slot0.textPhase_.text = 0 .. tostring(slot2)
	else
		slot0.textPhase_.text = slot2
	end
end

function slot0.RefreshState(slot0)
	slot0.controller_:SetSelectedState(tostring(slot0.rewardState_))
end

function slot0.RefreshItem(slot0)
	for slot5, slot6 in pairs(slot0.rewardCfg_) do
		slot8 = rewardToItemTemplate(slot6)

		function slot8.clickFun(slot0)
			ShowPopItem(POP_ITEM, {
				slot0.id
			})
		end

		CommonTools.SetCommonData(slot0.rewardItemList_[slot5], slot8)
		slot0.rewardItemList_[slot5]:RefreshGray(slot0.rewardState_ == uv0)
	end

	for slot5 = #slot1 + 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot5]:SetData()
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rewardContent_)
end

function slot0.ClickItem(slot0)
	slot1 = slot0.rewardState_

	BattleBossChallengeAction.RequireBossExchange(slot0.curStarCnt_, function (slot0)
		if isSuccess(slot0.result) then
			BattleBossChallengeNormalData:SetReceiveStarList(uv0.totalStarCnt_)
			uv0:GetRewardState()
			getReward2(slot0.item_list)

			if uv1 == uv2 and uv0.rewardState_ == uv3 then
				uv0:RefreshState()
				manager.notify:Invoke(BOSS_CHALLENGE_RECEIVE_STAR_REWARD)
			end
		else
			ShowTips(slot0.result)
		end
	end)
end

function slot0.GetRewardState(slot0)
	slot1 = slot0.rewardIndex_
	slot2 = slot0.chapterID_
	slot3 = nil
	slot0.rewardState_ = slot0.curStarCnt_ < slot0.totalStarCnt_ and uv0 or table.keyof(BattleBossChallengeNormalData:GetReceiveStarList(), slot0.totalStarCnt_) and uv1 or uv2
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in ipairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	slot0.rewardItemList_ = nil
	slot0.rewardPanel_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
