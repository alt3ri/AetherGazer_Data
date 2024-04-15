slot0 = class("MythicSectionRewardItem", ReduxView)
slot1 = 0
slot2 = 1
slot3 = 2

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.rewardIndex_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardItemList_ = {}

	for slot4 = 1, 3 do
		slot0.rewardItemList_[slot4] = CommonItemView.New(slot0["rewardItem" .. slot4 .. "_"])
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if uv0.rewardState_ == uv1 then
			if MythicData:GetStarRewardCount() == 0 then
				ShowMessageBox({
					content = GetTips("MYTHIC_REWARD_LOACK_DIFFICULTY"),
					OkCallback = function ()
						MythicAction.QueryMythicStar(uv0.rewardIndex_)
					end
				})
			else
				MythicAction.QueryMythicStar(uv0.rewardIndex_)
			end
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0:RefreshData(slot1)
	slot0:RefreshUI()
	slot0:RefreshState()
	slot0:RefreshItem()
end

function slot0.RefreshData(slot0, slot1)
	slot0.difficulty_ = slot1
	slot0.rewradCfg_ = getRewardFromDropCfg(MythicNormalCfg[slot0.difficulty_].star_reward_list[slot0.rewardIndex_] or 0, true)
	slot0.curStarCnt_ = MythicData:GetStarCount()
	slot0.totalStarCnt_ = slot0.rewardIndex_

	slot0:GetRewardState()
end

function slot0.GetRewardState(slot0)
	slot2 = nil
	slot0.rewardState_ = slot0.curStarCnt_ < slot0.totalStarCnt_ and uv0 or MythicData:GetStarRewardState(slot0.rewardIndex_) and uv1 or uv2
end

function slot0.RefreshUI(slot0)
	slot1 = slot0.rewardIndex_
	slot0.progressCntText_.text = slot0.totalStarCnt_
	slot2 = slot0.totalStarCnt_ < slot0.curStarCnt_ and slot0.totalStarCnt_ or slot0.curStarCnt_
	slot0.progressText_.text = string.format("%s/%s", slot2, slot0.totalStarCnt_)
	slot0.progressBar_.normalizedValue = slot2 / slot0.totalStarCnt_
end

function slot0.RefreshState(slot0)
	SetActive(slot0.mask_, slot0.rewardState_ == uv0)
	SetActive(slot0.unlockGo_, slot0.rewardState_ == uv1)
	SetActive(slot0.receiveBtnGo_, slot0.rewardState_ == uv2)
end

function slot0.RefreshItem(slot0)
	for slot5, slot6 in pairs(slot0.rewradCfg_) do
		if slot5 > 3 then
			return
		end

		slot7 = rewardToItemTemplate(slot6)

		if slot0.rewardState_ == uv0 then
			slot7.grayFlag = true
		end

		function slot7.clickFun(slot0)
			ShowPopItem(POP_ITEM, slot0)
		end

		slot0.rewardItemList_[slot5]:SetData(slot7)
	end

	for slot5 = #slot1 + 1, 3 do
		slot0.rewardItemList_[slot5]:SetData(nil)
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	slot0.rewardItemList_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
