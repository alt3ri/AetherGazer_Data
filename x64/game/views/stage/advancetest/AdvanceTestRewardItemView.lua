slot0 = class("AdvanceTestRewardItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.index = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.rewardListGo_, CommonItem)
end

function slot0.OnTop(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.startRank = slot1
	slot0.endRank = ActivityPointRewardCfg[slot2].need
	slot0.rewardCfg = ActivityPointRewardCfg[slot2].reward_item_list

	slot0:RefreshUI()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.rewardCfg[slot1]))
	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)
end

function slot0.RefreshUI(slot0)
	slot0.descText_.text = string.format("排名:%s", slot0.startRank .. "-" .. slot0.endRank)

	slot0.itemList_:StartScroll(#slot0.rewardCfg)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	if slot0.itemList_ then
		slot0.itemList_:Dispose()

		slot0.itemList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
