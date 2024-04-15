slot0 = class("HanafudaRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.itemList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.rewardList_, CommonItem)
	slot0.rewardState_ = ControllerUtil.GetController(slot0.transform_, "stateBtn")
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.cfg_ = slot2

	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		KagutsuchiHanafudaAction.SendGetCombineReward(uv0.cfg_.activity_id, uv0.cfg_.id, uv0.callback)
	end)
	slot0:AddBtnListener(slot0.checkBtn_, nil, function ()
		if uv0.checkCallBack_ then
			uv0.checkCallBack_(uv0.cfg_.id)
		end
	end)
end

function slot0.SetCallBack(slot0, slot1)
	slot0.callback = slot1
end

function slot0.SetCheckCallBack(slot0, slot1)
	slot0.checkCallBack_ = slot1
end

function slot0.RefreshUI(slot0)
	slot0:RefreshItem()
	slot0:RefreshState()
end

function slot0.RefreshItem(slot0)
	slot0.rewardCfg = slot0.cfg_.reward_item_list

	slot0.itemList_:StartScroll(#slot0.rewardCfg)

	slot0.nameText_.text = slot0.cfg_.name
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.rewardCfg[slot1]))
	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)
end

function slot0.RefreshState(slot0)
	slot2 = HanafudaData:GetIsRewarded(slot0.cfg_.id)

	if not HanafudaData:GetIsComplete(slot0.cfg_.id) then
		slot0.rewardState_:SetSelectedState("unfinished")
	elseif not slot2 then
		slot0.rewardState_:SetSelectedState("complete")
	else
		slot0.rewardState_:SetSelectedState("rewarded")
	end
end

function slot0.Dispose(slot0)
	if slot0.itemList_ then
		slot0.itemList_:Dispose()

		slot0.itemList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
