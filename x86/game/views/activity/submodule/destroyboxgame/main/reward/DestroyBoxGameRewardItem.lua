slot0 = class("DestroyBoxGameRewardItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, CommonItem)
	slot0.buttonController = ControllerUtil.GetController(slot0.m_btnController, "stateBtn")
end

function slot0.SetData(slot0, slot1)
	slot0.rewardID_ = slot1
	slot2 = DestroyBoxGameRewardCfg[slot1]
	slot0.m_pointLab.text = string.format(slot2.desc, slot2.complete_num)
	slot0.rewardList_ = slot2 and slot2.item_list or {}

	slot0.list_:StartScroll(#slot0.rewardList_)

	if table.keyof(DestroyBoxGameData:GetReceiveRewardList(slot2.main_activity_id), slot1) then
		slot0.buttonController:SetSelectedIndex(2)
	elseif DestroyBoxGameTools.IsUnlockReward(slot1) then
		slot0.buttonController:SetSelectedIndex(0)
	else
		slot0.buttonController:SetSelectedIndex(1)
	end
end

function slot0.Dispose(slot0)
	slot0.list_:Dispose()

	slot0.list_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.m_receiveBtn, nil, function ()
		DestroyBoxGameAction.RequestReward(DestroyBoxGameRewardCfg[uv0.rewardID_].main_activity_id, {
			uv0.rewardID_
		}, function ()
			manager.notify:Invoke(DESTROY_BOX_GAME_REWARD_REFRESH)
		end)
	end)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.rewardList_[slot1]))
	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)
end

return slot0
