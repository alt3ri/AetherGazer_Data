manager.net:Bind(35011, function (slot0)
	EquipSeizureData:InitData(slot0)
	manager.notify:Invoke(EQUIP_SEIZURE_UPDATE)
end)
manager.net:Bind(35013, function (slot0)
	EquipSeizureData:RefreshBattleScore(slot0)
end)
manager.notify:RegistListener(ZERO_REFRESH, function ()
	uv0.InitRedPointEveryDay()
end)

return {
	SendReceiveReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(35014, {
			id_list = slot0
		}, 35015, function (slot0)
			if isSuccess(slot0.result) then
				getReward(mergeReward(slot0.reward_list))
				EquipSeizureData:ReceiveReward(uv0)
				uv1(slot0)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	InitRedPointEveryDay = function ()
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_EQUIP_SEIZURE) then
			return
		end

		if (getData("EquipSeizure", "lastClickTime") or 0) < manager.time:GetTodayFreshTime() and #EquipSeizureData:GetReceiveList() < #EquipSeizurePointRewardCfg.all and EquipSeizureData:GetTodayMaxScore() <= 0 then
			manager.redPoint:setTip(RedPointConst.EQUIP_SEIZURE_UNREAD, 1)
		end
	end,
	OpenWindow = function ()
		if manager.redPoint:getTipValue(RedPointConst.EQUIP_SEIZURE_UNREAD) == 1 then
			manager.redPoint:setTip(RedPointConst.EQUIP_SEIZURE_UNREAD, 0)
			saveData("EquipSeizure", "lastClickTime", manager.time:GetServerTime())
		end
	end
}
