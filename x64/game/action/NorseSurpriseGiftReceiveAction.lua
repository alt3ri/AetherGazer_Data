manager.net:Bind(65429, function (slot0)
	NorseSurpriseGiftReceiveData:InitData(slot0)
end)

return {
	DrawCapsule = function (slot0)
		manager.net:SendWithLoadingNew(65432, {
			activity_id = slot0
		}, 65433, uv0.OnDrawCapsule)
	end,
	OnDrawCapsule = function (slot0, slot1)
		if isSuccess(slot0.result) then
			NorseSurpriseGiftReceiveData:SetRoleData(slot1.activity_id, slot0)
			manager.notify:Invoke(NORSE_GIFT_DRAW_SUCCESS, slot0)
		else
			ShowTips(slot0.result)
		end
	end,
	ChooseHeartList = function (slot0, slot1)
		manager.net:SendWithLoadingNew(65430, {
			activity_id = slot0,
			choose_list = slot1
		}, 65431, uv0.OnChooseHeartList)
	end,
	OnChooseHeartList = function (slot0, slot1)
		if isSuccess(slot0.result) then
			NorseSurpriseGiftReceiveData:SetChooseRoleData(slot1.choose_list)
			manager.notify:Invoke(NORSE_GIFT_CHOOSE_SUCCESS, slot1.choose_list)
		else
			ShowTips(slot0.result)
		end
	end,
	ReceiveRewardRole = function (slot0, slot1)
		manager.net:SendWithLoadingNew(65434, {
			activity_id = slot0,
			role_id = slot1
		}, 65435, uv0.OnReceiveRole)
	end,
	OnReceiveRole = function (slot0, slot1)
		if isSuccess(slot0.result) then
			NorseSurpriseGiftReceiveData:SetResultRoleId(slot1.role_id)
			NorseSurpriseGiftReceiveData:UpdateRedPointData2(ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW)
			print("领取成功---->", slot1.role_id)
			manager.notify:Invoke(NORSE_GIFT_RECEIVE_SUCCESS, slot0, slot1)
		else
			ShowTips(slot0.result)
		end
	end
}
