slot1 = 15

function slot2(slot0)
	slot1 = {}

	if DrawPoolCfg[slot0].pool_type == 3 then
		if #slot2.unoption_up_items[1] == 0 then
			for slot6, slot7 in ipairs(slot2.optional_detail) do
				table.insert(slot1, slot7)
			end
		else
			for slot6, slot7 in ipairs(slot2.unoption_up_items[1]) do
				table.insert(slot1, slot7)
			end
		end

		for slot6, slot7 in ipairs(slot2.unoption_up_items[2]) do
			table.insert(slot1, slot7)
		end
	end

	return slot1
end

return {
	GetRechargeDrawGiftList = function (slot0)
		if not DrawPoolCfg[slot0] or slot1.recharge_shop_list == "" then
			return {}
		else
			slot2 = {}

			for slot6, slot7 in pairs(slot1.recharge_shop_list) do
				if ShopCfg[slot7] and ShopTools.IsGoodCanDisplay(slot8.shop_id, slot7) then
					table.insert(slot2, slot7)
				end
			end

			table.sort(slot2, function (slot0, slot1)
				slot2 = getShopCfg(slot0)
				slot3 = getShopCfg(slot1)

				if uv0.GetGoodStatus(slot0) ~= uv0.GetGoodStatus(slot1) then
					return slot4 < slot5
				end

				if slot2.shop_sort ~= slot3.shop_sort then
					return slot3.shop_sort < slot2.shop_sort
				end

				return slot3.goods_id < slot2.goods_id
			end)

			return slot2
		end
	end,
	GetGoodStatus = function (slot0)
		slot1 = false
		slot4 = ShopData.GetShop(getShopCfg(slot0).shop_id)[slot0]

		if ShopData.IsGoodOutOfDate(slot0) then
			return 2
		end

		if slot4 ~= nil and slot2.limit_num ~= nil and slot2.limit_num ~= -1 and slot2.limit_num - slot4.buy_times <= 0 then
			slot1 = true
		end

		if slot1 then
			return 2
		end

		if ShopData.IsGoodUnlock(slot0) == 0 then
			return 1
		end

		return 0
	end,
	GetCostTicket = function (slot0, slot1)
		slot2 = uv0.GetCostTicketList(slot0)

		for slot6, slot7 in ipairs(slot2) do
			if (slot1 or 1) <= ItemTools.getItemNum(slot7) then
				return slot7
			end
		end

		return slot2[#slot2]
	end,
	GetCostTicketList = function (slot0)
		slot1 = {}

		for slot6, slot7 in ipairs({
			DrawPoolCfg[slot0].cost_once[1]
		}) do
			if ItemTools.getItemNum(slot7) > 0 then
				table.insert(slot1, slot7)
			end
		end

		if not table.keyof(slot1, slot2[#slot2]) then
			table.insert(slot1, slot3)
		end

		return slot1
	end,
	GetActivityCostTicket = function (slot0)
		return DrawPoolCfg[slot0].cost_once_activity_material[1] or 0
	end,
	GetActivityPoolIdByTicketId = function (slot0)
		for slot4, slot5 in pairs(DrawPoolCfg) do
			if DrawPoolCfg[slot4].cost_once_activity_material and slot6.cost_once_activity_material[1] == slot0 then
				return slot4
			end
		end

		return nil
	end,
	LoadDrawLevel = function (slot0)
		if SceneManager.GetSceneByName("X102") and slot1.isLoaded == true then
			return
		end

		if slot0.operation_ then
			return
		end

		slot0.operation_ = Asset.LoadLevelAsync("Levels/X102", true)

		if slot0.timer_ then
			slot0.timer_:Stop()

			slot0.timer_ = nil
		end

		slot0.timer_ = FrameTimer.New(handler(slot0, slot0.Process), 1, -1)

		slot0.timer_:Start()
	end,
	Process = function (slot0)
		if slot0.operation_:IsDone() then
			if not gameContext:GetOpenPageHandler("draw") and SceneManager.GetSceneByName("X102") and slot1.isLoaded == true then
				SceneManager.UnloadSceneAsync("X102")
			end

			if slot0.timer_ then
				slot0.timer_:Stop()

				slot0.timer_ = nil
			end

			slot0.operation_ = nil
		end
	end,
	UnLoadDrawLevel = function (slot0)
		if slot0.operation_ then
			return
		end

		if SceneManager.GetSceneByName("X102") and slot1.isLoaded == true then
			SceneManager.UnloadSceneAsync("X102")
		end
	end,
	LevelIsDone = function (slot0)
		if slot0.operation_ then
			return slot0.operation_:IsDone()
		end

		return true
	end,
	GetNowAllPool = function (slot0)
		slot1 = {}

		for slot6, slot7 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.DRAW] or {}) do
			if ActivityData:GetActivityIsOpen(slot7) and ActivityDrawPoolCfg[slot7] then
				for slot12, slot13 in ipairs(slot8.config_list) do
					table.insert(slot1, slot13)
				end
			end
		end

		return slot1
	end,
	GetNowAllRolePool = function (slot0)
		slot2 = {}

		for slot6, slot7 in ipairs(DrawData:GetPoolList()) do
			if DrawPoolCfg[slot7].pool_type ~= 2 then
				table.insert(slot2, slot7)
			end
		end

		return slot2
	end,
	GetNowAllServantPool = function (slot0)
		slot2 = {}

		for slot6, slot7 in ipairs(uv0:GetNowAllPool()) do
			if DrawPoolCfg[slot7].pool_type == 2 then
				table.insert(slot2, slot7)
			end
		end

		return slot2
	end,
	GetRoleUpPoolID = function (slot0, slot1)
		for slot6, slot7 in ipairs(uv0:GetNowAllPool()) do
			for slot11, slot12 in ipairs(uv1(slot7)) do
				if slot12 == slot1 then
					return slot7
				end
			end
		end

		return false
	end
}
