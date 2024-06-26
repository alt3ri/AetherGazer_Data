manager.net:Bind(48001, function (slot0)
	if MatrixData:GetNextRefreshTime() ~= 0 and slot1 ~= slot0.matrix_system.next_refresh_timestamp then
		manager.notify:CallUpdateFunc(MATRIX_SYSTEM_OVERDUE)
	end

	MatrixData:InitMatrixSystem(slot0.matrix_system)
	manager.notify:CallUpdateFunc(MATRIX_SYSTEM_UPDATE)
end)
manager.net:Bind(48003, function (slot0)
	MatrixData:InitMatrixUser(slot0.user_matrix)
	manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
	uv0.CheckExchangeScoreRedPoint()
	uv0.CheckBeaconRedPoint()
	uv0.CheckTerminalGiftRedPoint(MatrixData:GetTerminalGift())
end)
manager.net:Bind(48005, function (slot0)
	MatrixData:MatrixOverData(slot0.end_info)
	manager.notify:CallUpdateFunc(MATRIX_OVER_UPDATE)
end)
manager.notify:RegistListener(CURRENCY_UPDATE, function (slot0)
	if slot0 == CurrencyConst.CURRENCY_TYPE_MATRIX_PT then
		uv0.CheckExchangeScoreRedPoint()
	elseif slot0 == CurrencyConst.CURRENCY_TYPE_MATRIX_TERMINAL_EXP then
		MatrixData:UpdateTerminalLevel()

		if MatrixData:GetTerminalLevel() ~= MatrixData:GetTerminalLevel() then
			MatrixTools.UpdateSortScoreList()
			uv0.CheckExchangeScoreRedPoint()
		end
	end
end)

slot1, slot2 = nil
slot3 = nil
slot4 = nil
slot5 = {}

return {
	CheckExchangeScoreRedPoint = function ()
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MATRIX) then
			manager.redPoint:setTip(RedPointConst.MATRIX_EXCHANGE_BONUS, 0)

			return
		end

		slot0 = false

		for slot7, slot8 in ipairs(MatrixData:GetPointRewardList()) do
			if MatrixPointRankCfg[slot8.rank] and slot9.point <= ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_MATRIX_PT) and slot8.is_got_reward <= 0 and slot8.need_level <= MatrixData:GetTerminalLevel() then
				slot0 = true

				break
			end
		end

		manager.redPoint:setTip(RedPointConst.MATRIX_EXCHANGE_BONUS, slot0 and 1 or 0)
	end,
	CheckBeaconRedPoint = function ()
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MATRIX) then
			manager.redPoint:setTip(RedPointConst.MATRIX_BEACON_UNLOCK, 0)

			return
		end

		for slot4, slot5 in ipairs(MatrixBeaconCfg.all) do
			if MatrixData:GetBeaconIsLock(slot5) then
				slot6 = MatrixBeaconCfg[slot5]

				if MatrixTools.GetBeaconIsUnlockCondition(slot5) then
					manager.redPoint:setTip(RedPointConst.MATRIX_BEACON_UNLOCK, 1)

					return
				end
			end
		end

		manager.redPoint:setTip(RedPointConst.MATRIX_BEACON_UNLOCK, 0)
	end,
	CheckTerminalGiftRedPoint = function (slot0)
		slot1 = 0

		for slot5, slot6 in pairs(slot0) do
			for slot11 = 1, slot6 do
				slot1 = slot1 + MatrixTerminalGiftCfg[slot5].cost[slot11]
			end
		end

		slot4 = MatrixTerminalLevelCfg[MatrixData:GetTerminalLevel()].point - slot1

		return MatrixAction.CheckSubTerminalGiftRedPoint(slot0, slot4, 1, RedPointConst.MATRIX_TERMINAL_GIFT_STRUGGLE) or MatrixAction.CheckSubTerminalGiftRedPoint(slot0, slot4, 2, RedPointConst.MATRIX_TERMINAL_GIFT_SHELTER)
	end,
	CheckSubTerminalGiftRedPoint = function (slot0, slot1, slot2, slot3)
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MATRIX) then
			manager.redPoint:setTip(slot3, 0)

			return false
		end

		if slot1 <= 0 then
			manager.redPoint:setTip(slot3, 0)

			return false
		end

		for slot9, slot10 in ipairs(MatrixTerminalGiftCfg.get_id_list_by_group[slot2] or {}) do
			if (MatrixTerminalGiftCfg[slot10].pre_id == 0 or slot0[slot12] and slot0[slot12] > 0) and #slot11.effect_id_list > (slot0[slot10] or 0) and slot1 >= (slot11.cost[slot14 + 1] or 0) and slot11.limit_level <= MatrixData:GetTerminalLevel() then
				manager.redPoint:setTip(slot3, 1)

				return true
			end
		end

		manager.redPoint:setTip(slot3, 0)

		return false
	end,
	QueryStartMatrix = function (slot0, slot1, slot2, slot3)
		return manager.net:SendWithLoadingNew(48012, {
			hero_id_list = slot0,
			difficulty = slot1,
			custom_affix_id_list = slot2,
			beacon_id_list = slot3
		}, 48013, uv0.StartMatrixCallBack)
	end,
	StartMatrixCallBack = function (slot0)
		if isSuccess(slot0.result) then
			BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX, GetHeroTeamActivityID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX), 0)
			ComboSkillData:SetMatrixNeedRefresh(true)
			JumpTools.GoToSystem("/matrixBlank/matrixOrigin")
			MatrixData:SetMatrixBattleHeroTeam(nil)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryNextProgress = function (slot0)
		uv0 = MatrixData:GetMatrixPhaseData()
		uv1 = MatrixData:GetTierID()

		manager.net:SendWithLoadingNew(48010, {
			params = slot0 or {
				0
			}
		}, 48011, uv2.NextProgressCallBack)
	end,
	NextProgressCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if MatrixData:GetGameState() == MatrixConst.STATE_TYPE.STARTED then
				if MatrixConst.PHASE_TYPE.REWARD == uv0:GetPhase() then
					slot5 = false

					if not (slot1.params and slot1.params[1]) then
						slot5 = true
						slot4 = uv0:GetGiveUpItemId() or 0
					end

					uv1.DoReward(slot4, slot5)
				elseif MatrixConst.PHASE_TYPE.ACTION == slot3 then
					if MatrixConst.EVENT_TYPE.INCIDENT == MatrixEventCfg[uv0:GetParams()[1]].event_type then
						uv1.DoEffect(MatrixChanceCfg[slot4].toll)
					end

					uv1.DoAfterEvnet(uv2)
				end

				if MatrixData:GetMatrixPhaseData():GetPhase() == 2 then
					uv1.DoEvent()
				end
			elseif slot2 == MatrixConst.STATE_TYPE.SUCCESS or slot2 == MatrixConst.STATE_TYPE.FAIL then
				OpenPageUntilLoaded("/matrixBlank/matrixOver")
			else
				OpenPageUntilLoaded("/matrixBlank/matrixPrepare")
			end
		else
			ShowTips(slot0.result)
		end

		cur_phase = nil
		uv2 = nil
	end,
	DoEvent = function ()
		if not (MatrixData:GetMatrixPhaseData():GetParams()[1] and MatrixEventCfg[slot1]) then
			error("MatrixEventCfg cant find event by id :" .. slot1)

			return
		end

		if MatrixConst.EVENT_TYPE.SHOP == slot2.event_type then
			JumpTools.GoToSystem("/matrixBlank/matrixProcessShop", {
				shops = slot0:GetShops()
			})
		elseif MatrixConst.EVENT_TYPE.INCIDENT ~= slot2.event_type then
			MatrixData:SetBattleTier(MatrixData:GetTierID())
			BattleController.GetInstance():LaunchBattle(BattleMatrixStageTemplate.New(slot0:GetData()))
		end
	end,
	DoReward = function (slot0, slot1)
		if not MatrixItemCfg[slot0] then
			return
		end

		if MatrixConst.ITEM_TYPE.ITEM == slot2.matrix_item_type then
			-- Nothing
		elseif MatrixConst.ITEM_TYPE.EFFECT == slot2.matrix_item_type then
			uv0.DoEffect(slot2.params[1] or 0)
		end
	end,
	DoAfterEvnet = function (slot0)
	end,
	DoEffect = function (slot0)
		if not MatrixEffectCfg[slot0] then
			return
		end
	end,
	QueryMatrixOver = function (slot0)
		manager.net:SendWithLoadingNew(48020, {}, 48021, slot0)
	end,
	QueryMatrixGiveUp = function (slot0)
		manager.net:SendWithLoadingNew(48024, {}, 48025, slot0)
	end,
	QuerySetMatrixTerminalGift = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0) do
			table.insert(slot1, {
				id = slot5,
				level = slot6
			})
		end

		manager.net:SendWithLoadingNew(48022, {
			gift_list = slot1
		}, 48023, uv0.SetMatrixTerminalGiftCallBack)
	end,
	SetMatrixTerminalGiftCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			for slot7, slot8 in ipairs(slot1.gift_list) do
				-- Nothing
			end

			MatrixData:SetTerminalGift({
				[slot8.id] = slot8.level
			})
		else
			ShowTips(slot0.result)
		end
	end,
	BuyShopItem = function (slot0, slot1, slot2)
		slot4, slot5 = MatrixData:GetMatrixPhaseData():GetData()

		for slot9, slot10 in ipairs(slot5) do
			if slot10.index == slot0 then
				uv0 = slot10

				manager.net:SendWithLoadingNew(48010, {
					params = {
						2,
						slot0,
						slot1,
						slot2 or 0
					}
				}, 48011, uv1.OnBuyShopItem)

				return
			end
		end
	end,
	OnBuyShopItem = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ShowTips("TRANSACTION_SUCCESS")
			manager.notify:CallUpdateFunc(MATRIX_SHOP_BUY_SUCCESS)

			if uv0 ~= nil then
				uv1.DoReward(uv0.id)

				uv0 = nil
			end
		else
			ShowTips(slot0.result)
		end
	end,
	QueryRefreshShopItem = function ()
		slot1, slot2 = MatrixData:GetMatrixPhaseData():GetData()
		slot4 = MatrixData:GetShopFressRefreshTimes()

		if slot1 < MatrixData:GetShoRefreshTimes() then
			slot5 = GameSetting.matrix_shop_refresh_cost_item_list.value

			if slot4 <= slot1 then
				slot8 = slot5[math.min(slot1 - slot4 + 1, #slot5)]

				if ItemTools.getItemNum(slot8[1]) < slot8[2] then
					ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")

					return
				end

				uv0 = slot8

				manager.net:SendWithLoadingNew(48010, {
					params = {
						1
					}
				}, 48011, uv1.OnRefrshShopItem)
			else
				uv0 = nil

				manager.net:SendWithLoadingNew(48010, {
					params = {
						1
					}
				}, 48011, uv1.OnRefrshShopItem)
			end
		end
	end,
	OnRefrshShopItem = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ShowTips("ASTROLABE_RESET")
		else
			ShowTips(slot0.result)
		end
	end,
	GetBonus = function (slot0)
		uv0 = {}

		for slot4, slot5 in ipairs(slot0.reward) do
			table.insert(uv0, {
				slot5.item_id,
				slot5.item_num
			})
		end

		manager.net:SendWithLoadingNew(48014, {
			rank = slot0.rank
		}, 48015, uv1.OnGetBonusCallback)
	end,
	OnGetBonusCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			getReward(mergeReward(formatRewardCfgList(uv0)))

			uv0 = {}

			manager.notify:CallUpdateFunc(MATRIX_ON_GET_BONUS)
		else
			ShowTips(slot0.result)
		end
	end,
	OneKeyGetBonus = function ()
		slot2 = {}
		uv0 = {}
		slot5 = MatrixData
		slot7 = slot5

		for slot6, slot7 in pairs(slot5.GetPointRewardList(slot7)) do
			if MatrixPointRankCfg[slot7.rank].point <= ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_MATRIX_PT) and slot7.is_got_reward == 0 and slot7.need_level <= MatrixData:GetTerminalLevel() then
				for slot12, slot13 in ipairs(slot7.item_list) do
					table.insert(uv0, {
						slot13.item_id,
						slot13.item_num
					})
				end

				table.insert(slot2, slot7.rank)
			end
		end

		manager.net:SendWithLoadingNew(48016, {
			rank_list = slot2
		}, 48017, uv1.OnOneKeyGetBonusCallback)
	end,
	OnOneKeyGetBonusCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			getReward(mergeReward(formatRewardCfgList(uv0)))

			uv0 = {}

			manager.notify:CallUpdateFunc(MATRIX_ON_GET_BONUS)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryUnlockBeacon = function (slot0)
		manager.net:SendWithLoadingNew(48018, {
			beacon_id = slot0
		}, 48019, uv0.OnUnlockBeacon)
	end,
	OnUnlockBeacon = function (slot0)
		if isSuccess(slot0.result) then
			ShowTips(GetTips("MATRIX_BEACON_UNLOCK_SUCCESS"))
		else
			ShowTips(slot0.result)
		end
	end
}
