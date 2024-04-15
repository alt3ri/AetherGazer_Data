NewWarChessEventIterator = class("NewWarChessEventIterator")

function NewWarChessEventIterator.Ctor(slot0, slot1, slot2, slot3, slot4)
	slot0.entityID_ = slot1
	slot0.chess_ = slot2
	slot0.eventList_ = slot3
	slot0.curEventIndex_ = 0
	slot0.disposeFunc_ = slot4
end

function NewWarChessEventIterator.MoveNext(slot0)
	slot0.curEventIndex_ = slot0.curEventIndex_ + 1

	if slot0.curEventIndex_ <= #slot0.eventList_ then
		if slot0.eventList_[slot0.curEventIndex_][1] == 10004 then
			slot3 = slot0.chess_

			manager.NewChessManager:ChangeGridByExtentID(slot3.x, slot3.z, slot1[2], false, function ()
				uv0:MoveNext()
			end)
		elseif slot2 == 10029 then
			slot3 = slot0.chess_

			manager.NewChessManager:PlayGridAnimation(slot3.x, slot3.z, slot1[2], slot1[3], function ()
				uv0:MoveNext()
			end)
		elseif slot2 == 10041 then
			NewChessLuaBridge.FixRoleY(slot1[2], slot1[3])
			slot0:MoveNext()
		elseif slot2 == 10046 then
			slot3 = slot0.chess_

			manager.NewChessManager:ChangeGridDirection(slot3.x, slot3.z, slot1[2], slot1[3], function ()
				uv0:MoveNext()
			end)
		elseif slot2 == 10052 then
			slot3 = slot0.chess_

			manager.NewChessManager:ChangeGridByExtentID(slot3.x, slot3.z, slot1[2], true, function ()
				uv0:MoveNext()
			end)
		end
	else
		slot0:Dispose()
	end
end

function NewWarChessEventIterator.Dispose(slot0)
	if slot0.disposeFunc_ then
		slot0.disposeFunc_(slot0.entityID_)

		slot0.entityID_ = nil
		slot0.chess_ = nil
		slot0.eventList_ = nil
		slot0.curEventIndex_ = nil
		slot0.disposeFunc_ = nil
	end
end

NewWarChessCheckEventIterator = class("NewWarChessCheckEventIterator")

function NewWarChessCheckEventIterator.Ctor(slot0, slot1, slot2, slot3)
	slot0.eventList_ = slot2
	slot0.curEventIndex_ = 0
	slot0.params_ = slot1
	slot0.disposeFunc_ = slot3
end

function NewWarChessCheckEventIterator.MoveNext(slot0)
	slot0.curEventIndex_ = slot0.curEventIndex_ + 1

	if slot0.curEventIndex_ <= #slot0.eventList_ then
		if slot0.eventList_[slot0.curEventIndex_][1] == 10041 then
			NewChessLuaBridge.FixRoleY(slot1[2], slot1[3])
			slot0:MoveNext()
		elseif slot2 == 10055 then
			manager.NewChessManager:ClearInteractChess()
			NewChessLuaBridge.TelePortRoleToPosition(slot0.params_.x, slot0.params_.z, function ()
				uv0:MoveNext()
			end)
		end
	else
		slot0:Dispose()
	end
end

function NewWarChessCheckEventIterator.Dispose(slot0)
	if slot0.disposeFunc_ then
		slot0.disposeFunc_()

		slot0.eventList_ = nil
		slot0.curEventIndex_ = nil
		slot0.params_ = nil
		slot0.disposeFunc_ = nil
	end
end

return {
	[10002] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			slot2 = manager.NewChessManager:GetExecutingChess()

			getReward(getRewardFromDropCfg(slot1, true), nil, function ()
				return manager.NewChessManager:DoNextEvent()
			end, true)
		end
	},
	[10004] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			slot2 = manager.NewChessManager:GetExecutingChess()

			manager.NewChessManager:ChangeGridByExtentID(slot2.x, slot2.z, slot1, false, function ()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10005] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1, slot2, slot3)
			manager.NewChessManager:ChangeGridByExtentID(slot1, slot2, slot3, false, function ()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10006] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			NewWarChessAction.AddNewDice(slot0)

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10008] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			manager.NewChessManager:AddBuff(slot1)

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10009] = {
		[NewChessConst.TIMING_START] = function (slot0, slot1)
			if NewWarChessData:AddNewHero(slot1) then
				if NewWarChessHeroCfg[slot1].effect_type == NewChessConst.HERO_EFFECT_TYPE.BUFF then
					if slot3.effect_id ~= 0 then
						manager.NewChessManager:AddBuff(slot3.effect_id)
					else
						print("lrq 当前英雄配置了效果类型没配置效果ID")
					end
				elseif slot3.effect_type == NewChessConst.HERO_EFFECT_TYPE.DICESKILL then
					if slot3.effect_id ~= 0 then
						NewWarChessData:AddNewSkill(slot3.effect_id)
						manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_NEW_DICESKILL .. slot3.effect_id, 1)
					else
						print("lrq 当前英雄配置了效果类型没配置效果ID")
					end
				end
			end

			return manager.NewChessManager:DoNextEvent()
		end,
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			if NewWarChessData:AddNewHero(slot1) then
				if NewWarChessHeroCfg[slot1].effect_type == NewChessConst.HERO_EFFECT_TYPE.BUFF then
					if slot3.effect_id ~= 0 then
						manager.NewChessManager:AddBuff(slot3.effect_id)
					else
						print("lrq 当前英雄配置了效果类型没配置效果ID")
					end
				elseif slot3.effect_type == NewChessConst.HERO_EFFECT_TYPE.DICESKILL then
					if slot3.effect_id ~= 0 then
						NewWarChessData:AddNewSkill(slot3.effect_id)
						manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_NEW_DICESKILL .. slot3.effect_id, 1)
					else
						print("lrq 当前英雄配置了效果类型没配置效果ID")
					end
				end

				JumpTools.OpenPageByJump("newWarChessHeroPopView", {
					newChessHeroID = slot1,
					callBack = function ()
						return manager.NewChessManager:DoNextEvent()
					end
				})
			else
				return manager.NewChessManager:DoNextEvent()
			end
		end
	},
	[10010] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			NewWarChessData:AddNewSkill(slot1)
			manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_NEW_DICESKILL .. slot1, 1)

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10011] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			slot2 = manager.NewChessManager:GetExecutingChess()

			manager.NewChessManager:ChangeObjectByExtentID(slot2.x, slot2.z, slot1, function ()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10012] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1, slot2, slot3)
			manager.NewChessManager:ChangeObjectByExtentID(slot1, slot2, slot3, function ()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10013] = {
		[NewChessConst.TIMING_ALL] = function (slot0)
			slot1 = manager.NewChessManager:GetExecutingChess()

			manager.NewChessManager:DeleteObject(slot1.x, slot1.z, function ()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10014] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1, slot2)
			manager.NewChessManager:DeleteObject(slot1, slot2, function ()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10015] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			NewWarChessAction.AddNewDice(slot1)

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10016] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1, slot2, slot3)
			NewChessLuaBridge.OpenAreaFog(slot1, slot2, slot3, function ()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10017] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1, slot2)
			manager.NewChessManager:MoveToTarget(slot1, slot2, function ()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10018] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			manager.NewChessManager.taskManager_:AddNewTask(slot1)

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10019] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1, slot2)
			manager.NewChessManager.taskManager_:UpdateTask(slot1, slot2)

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10020] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1, slot2)
			NewChessLuaBridge.LookAtPlayer()
			manager.NewChessManager:ClearInteractChess()
			NewChessLuaBridge.TelePortRoleToPosition(slot1, slot2, function ()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10021] = {
		[NewChessConst.TIMING_ALL] = function (slot0)
			NewWarChessData:AddAllSkillCount()

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10022] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			slot2 = manager.NewChessManager:GetExecutingChess()

			NewChessLuaBridge.OpenAreaFog(slot2.x, slot2.z, slot1, function ()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10023] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			if slot0[1] and slot0[1] == 1 then
				slot2 = manager.NewChessManager:GetExecutingChess()
				slot3 = slot2.x
				slot4 = slot2.z
				slot5 = false

				if slot1 == 1 then
					slot5 = true
				end

				manager.NewChessManager:ShowBlock()
				manager.NewChessManager:ClearInteractChess()
				NewChessLuaBridge.MoveConveyor(slot3, slot4, slot5, function ()
					manager.NewChessManager:CloseBlock()

					return manager.NewChessManager:DoNextEvent()
				end)
			else
				return manager.NewChessManager:DoNextEvent()
			end
		end
	},
	[10024] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			slot2 = manager.NewChessManager:GetExecutingChess()

			manager.NewChessManager:ClearInteractChess()
			manager.NewChessManager:JumpBoard(slot2.x, slot2.z, slot1, slot0[1], function ()
				manager.NewChessManager:CloseBlock()

				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10026] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1, slot2)
			NewWarChessData:SubAttribute(slot1, slot2)

			if slot1 == NewWarChessAttributeCfg.GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT.id and slot2 > 0 and manager.NewChessManager then
				manager.NewChessManager:CreateTips({
					tipsType = NewChessConst.TIPS_TYPE.NORMAL,
					tipsText = string.format(GetTips("ACTIVITY_NEW_WARCHESS_GET_MOVEPOINT"), slot2)
				})
			end

			if slot1 == NewWarChessAttributeCfg.GAME_NEWCHESS_ATTRIBUTE_FINISH.id and slot2 > 0 then
				slot4 = nil

				for slot8, slot9 in pairs(NewWarChessLevelCfg.all) do
					if NewWarChessLevelCfg[slot9].front_level_id == NewWarChessData:GetCurrentWarChessMapID() then
						slot4 = NewWarChessLevelCfg[slot9].name_level

						break
					end
				end

				slot5 = nil

				ShowMessageBox({
					ButtonType = "SingleBtn",
					content = (slot4 == nil or string.format(GetTips("ACTIVITY_NEW_WARCHESS_UNLOCK_NEW_LEVEL"), slot4)) and GetTips("ACTIVITY_NEW_WARCHESS_LEVEL_FINISH")
				})
			end

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10027] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			manager.story:StartChessStoryLine(slot1, function (slot0)
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10028] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1, slot2)
			NewWarChessData:SetAttribute(slot1, slot2)

			if slot1 == NewWarChessAttributeCfg.GAME_NEWCHESS_ATTRIBUTE_FINISH.id and slot2 > 0 then
				slot4 = nil

				for slot8, slot9 in pairs(NewWarChessLevelCfg.all) do
					if NewWarChessLevelCfg[slot9].front_level_id == NewWarChessData:GetCurrentWarChessMapID() then
						slot4 = NewWarChessLevelCfg[slot9].name_level

						break
					end
				end

				slot5 = nil

				ShowMessageBox({
					ButtonType = "SingleBtn",
					content = (slot4 == nil or string.format(GetTips("ACTIVITY_NEW_WARCHESS_UNLOCK_NEW_LEVEL"), slot4)) and GetTips("ACTIVITY_NEW_WARCHESS_LEVEL_FINISH")
				})
			end

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10029] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1, slot2)
			slot3 = manager.NewChessManager:GetExecutingChess()

			manager.NewChessManager:PlayGridAnimation(slot3.x, slot3.z, slot1, slot2, function ()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10030] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1, slot2, slot3, slot4)
			manager.NewChessManager:PlayGridAnimation(slot1, slot2, slot3, slot4, function ()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	OperatorFunc = {
		function (slot0, slot1)
			return slot0 + slot1
		end,
		function (slot0, slot1)
			return math.abs(slot0 - slot1)
		end,
		function (slot0, slot1)
			return slot0 * slot1
		end,
		function (slot0, slot1)
			return math.floor(slot0 / slot1)
		end,
		sum = function (slot0)
			for slot5, slot6 in pairs(slot0) do
				slot1 = 0 + slot6
			end

			return slot1
		end
	},
	DiceTypeFunc = {
		function (slot0, slot1)
			return {
				uv0.OperatorFunc[slot0[2]](uv0.OperatorFunc.sum(slot1), slot0[3])
			}
		end,
		function (slot0, slot1)
			slot3 = {}

			for slot7 = 1, slot0[2] do
				if slot7 < slot0[2] then
					table.insert(slot3, math.floor(slot1[1] / slot0[2]))
				else
					table.insert(slot3, slot1[1] - slot2)
				end
			end

			return {
				slot3
			}
		end,
		function (slot0, slot1)
			slot3 = {}

			for slot7 = 1, uv0.OperatorFunc.sum(slot1) do
				table.insert(slot3, slot0[2])
			end

			return {
				slot3
			}
		end,
		function (slot0, slot1)
			slot3 = {}

			for slot7 = 1, slot0[2] do
				table.insert(slot3, uv0.OperatorFunc.sum(slot1))
			end

			return {
				slot3
			}
		end,
		function (slot0, slot1)
			slot2 = {}

			for slot6 = 1, #slot1 do
				table.insert(slot2, slot0[2])
			end

			return {
				slot2
			}
		end,
		function (slot0, slot1)
			slot2 = {}

			for slot6 = 1, #slot1 do
				table.insert(slot2, uv0.OperatorFunc[slot0[2]](slot1[slot6], slot0[3]))
			end

			return {
				slot2
			}
		end,
		function (slot0, slot1)
			if slot0[2] <= uv0.OperatorFunc.sum(slot1) then
				return {
					slot0[3]
				}
			else
				return {
					slot0[4]
				}
			end
		end,
		function (slot0, slot1)
			if slot1[1] and slot1[2] then
				return {
					uv0.OperatorFunc[slot0[2]](slot1[1], slot1[2]) * slot0[3]
				}
			else
				return {}
			end
		end,
		function (slot0, slot1)
			return {}
		end
	},
	[10031] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1, slot2, slot3)
			slot4 = NewWarChessDiceEventTypeCfg[slot1].param
			slot6 = 1
			slot7 = slot2[1]
			slot8 = {}

			for slot12, slot13 in pairs(slot2) do
				if slot12 > 1 then
					if type(slot13) == "table" and slot13[1] == -1 then
						table.insert(slot8, uv0.DiceTypeFunc[slot4[1]](slot4, slot3)[slot6])

						slot6 = slot6 + 1
					else
						table.insert(slot8, slot13)
					end
				end
			end

			uv0[slot7][NewChessConst.TIMING_ALL](unpack(slot8))
		end
	},
	[10032] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			NewWarChessData:SubAllHeroHp(slot1 / 100 * NewChessConst.HERO_HP_RATE)

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10033] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			NewWarChessData:SubDiceListNum(slot1)

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10034] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1, slot2)
			slot3 = manager.NewChessManager:GetExecutingChess()

			NewChessLuaBridge.OpenBarFog(slot3.x, slot3.z, slot1, slot2, function ()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10035] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1, slot2, slot3, slot4)
			NewChessLuaBridge.OpenBarFog(slot1, slot2, slot3, slot4, function ()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10036] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			NewWarChessAction.AddNewDice(slot0)
			NewWarChessData:SubAttribute(slot1, slot0[1])

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10037] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			NewWarChessData:RemoveFrontDice(slot1)
			manager.NewChessManager:CreateTips({
				tipsType = NewChessConst.TIPS_TYPE.DANGEROUS,
				tipsText = string.format(GetTips("ACTIVITY_NEW_WARCHESS_LOST_DICE"), slot1)
			})

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10038] = {
		[NewChessConst.TIMING_ALL] = function (slot0)
			NewWarChessData:RemoveAllDice()
			NewWarChessAction.AddNewDice(slot0)

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10039] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			NewWarChessData:SetAllDice(slot1)

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10040] = {
		[NewChessConst.TIMING_ALL] = function (slot0)
			NewWarChessAction.AddNewDice(slot0)

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10041] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1, slot2)
			NewChessLuaBridge.FixRoleY(slot1, slot2)

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10042] = {
		[NewChessConst.TIMING_ALL] = function (slot0)
			manager.NewChessManager:ClearEndPoint()
			NewChessLuaBridge.StopRoleMoving()

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10043] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			manager.NewChessManager:DeleteTask(slot1)
			manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATETASK)

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10044] = {
		[NewChessConst.TIMING_ALL] = function (slot0)
			if slot0[1] and slot0[1] == 1 then
				slot1 = manager.NewChessManager:GetExecutingChess()

				manager.NewChessManager:ShowBlock()
				manager.NewChessManager:ClearInteractChess()

				if slot0[2] then
					NewChessLuaBridge.MoveByDir(slot1.x, slot1.z, slot0[2], function ()
						manager.NewChessManager:CloseBlock()

						return manager.NewChessManager:DoNextEvent()
					end)
				else
					error(slot2, " ", slot3, "格子服务器下发的数据中触发冰面滑动事件没有下发方向")
				end
			else
				return manager.NewChessManager:DoNextEvent()
			end
		end
	},
	[10045] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1, slot2)
			manager.NewChessManager:ShowBlock()

			slot3 = manager.NewChessManager:GetExecutingChess()
			slot4 = slot3.x
			slot5 = slot3.z
			slot6 = {}
			slot7 = 0

			for slot11 = -slot1, slot1 do
				slot15 = slot1

				for slot15 = math.max(-slot1, slot11 - slot1), math.min(slot15, slot11 + slot1) do
					slot16 = NewChessLuaBridge.GetNewGridData(slot4 + slot11, slot5 + slot15)

					for slot20, slot21 in pairs(slot2) do
						if slot16.typeID == slot21[1] then
							slot7 = slot7 + 1
							slot6[slot7] = NewWarChessEventIterator.New(slot7, slot16, slot21[2], function (slot0)
								uv0[slot0] = nil
								uv1 = uv1 - 1

								if uv1 <= 0 then
									manager.NewChessManager:CloseBlock()

									uv0 = nil

									return manager.NewChessManager:DoNextEvent()
								end
							end)

							break
						end
					end
				end
			end

			if slot7 == 0 then
				return manager.NewChessManager:DoNextEvent()
			else
				for slot11, slot12 in pairs(slot6) do
					slot12:MoveNext()
				end
			end
		end
	},
	[10046] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1, slot2)
			slot3 = manager.NewChessManager:GetExecutingChess()

			manager.NewChessManager:ChangeGridDirection(slot3.x, slot3.z, slot1, slot2, function ()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10047] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1, slot2, slot3, slot4)
			slot5 = NewChessLuaBridge.GetGridData(slot1, slot2)

			manager.NewChessManager:ChangeGridDirection(slot1, slot2, slot3, slot4, function ()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10048] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			if slot0[1] == 1 then
				slot2 = slot0[2]
				slot3 = nil

				for slot7, slot8 in pairs(slot1) do
					for slot12, slot13 in pairs(slot8[1]) do
						if slot13 == slot2 then
							slot3 = slot8[2]

							break
						end
					end
				end

				if slot3 then
					NewWarChessCheckEventIterator.New({
						x = slot0[3],
						z = slot0[4]
					}, slot3, function ()
						return manager.NewChessManager:DoNextEvent()
					end):MoveNext()
				else
					return manager.NewChessManager:DoNextEvent()
				end
			else
				return manager.NewChessManager:DoNextEvent()
			end
		end
	},
	[10049] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1, slot2)
			NewChessLuaBridge.LookAtPlayer()

			slot3 = manager.NewChessManager:GetExecutingChess()

			NewChessLuaBridge.TelePortRoleToPosition(slot3.x + slot1, slot3.z + slot2, function ()
				manager.NewChessManager:ClearInteractChess()

				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10050] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			JumpTools.OpenPageByJump("newWarChessTextPopView", {
				ID = slot1,
				callBack = function ()
					return manager.NewChessManager:DoNextEvent()
				end
			})
		end
	},
	[10051] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			slot2 = #slot1

			for slot6, slot7 in pairs(slot1) do
				manager.NewChessManager:PlayGridAnimation(slot7[1], slot7[2], slot7[3], slot7[4], function ()
					uv0 = uv0 - 1

					if uv0 <= 0 then
						return manager.NewChessManager:DoNextEvent()
					end
				end)
			end
		end
	},
	[10052] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			slot2 = manager.NewChessManager:GetExecutingChess()

			manager.NewChessManager:ChangeGridByExtentID(slot2.x, slot2.z, slot1, true, function ()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10053] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1, slot2, slot3)
			manager.NewChessManager:ChangeGridByExtentID(slot1, slot2, slot3, true, function ()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	},
	[10054] = {
		[NewChessConst.TIMING_ALL] = function (slot0, slot1)
			manager.NewChessManager.globalManager_:InsertNextInitGlobalEvent(slot1)

			return manager.NewChessManager:DoNextEvent()
		end
	},
	[10055] = {
		[NewChessConst.TIMING_ALL] = function (slot0)
			manager.NewChessManager:ClearInteractChess()
			NewChessLuaBridge.TelePortRoleToPosition(slot0[1], slot0[2], function ()
				return manager.NewChessManager:DoNextEvent()
			end)
		end
	}
}
