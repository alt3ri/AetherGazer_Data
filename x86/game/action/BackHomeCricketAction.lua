return {
	ParseCricketSettle = function (slot0, slot1)
		return {
			totalNum = slot1.sum_score or 0,
			peculiar = slot1.peculiarity_score or 0,
			skillAdd = slot1.skill_add_score or 0,
			skillDec = slot1.skill_decrease_score or 0
		}
	end,
	AskPvPBattleData = function (slot0, slot1, slot2, slot3)
		manager.net:SendWithLoadingNew(58160, {
			defender_uid = slot1,
			battle_type = slot2,
			stage_id = slot3
		}, 58161, uv0.OnAskPvPBattle)
	end,
	AskPvEBattleData = function (slot0, slot1)
		manager.net:SendWithLoadingNew(58186, {
			stage_id = slot1
		}, 58187, uv0.OnAskPvEBattle)
	end,
	OnAskPvPBattle = function (slot0, slot1)
		if isSuccess(slot0.result) then
			BackHomeCricketBattleData:InitSingleBattleData(slot0, slot1)
			BackHomeDataManager:GotoBackHomeCricketStage(BackHomeCricketConst.ROOM_TYPE.PVP_STAGE, slot1.stage_id)
		else
			ShowTips(slot0.result)
		end
	end,
	OnAskPvEBattle = function (slot0, slot1, slot2)
		if isSuccess(slot0.result) then
			slot1.battle_type = BackHomeCricketConst.ROOM_TYPE.PVE_STAGE

			BackHomeCricketBattleData:InitSingleBattleData(slot0, slot1)
			BackHomeDataManager:GotoBackHomeCricketStage(BackHomeCricketConst.ROOM_TYPE.PVE_STAGE, slot1.stage_id)
		else
			ShowTips(slot0.result)
		end
	end,
	SendBattleComplete = function (slot0, slot1)
		manager.net:SendWithLoadingNew(58164, {
			battle_type = slot0,
			acc_event = {
				give_flower_times = Dorm.storage:GetData(DanceGame.actionCountNamespace, "flower") or 0,
				light_fireworks_times = Dorm.storage:GetData(DanceGame.actionCountNamespace, "firework") or 0,
				reinforce_times = Dorm.storage:GetData(DanceGame.actionCountNamespace, "cheer") or 0
			}
		}, 58165, uv0.OnBattleResult(slot1))
	end,
	OnBattleResult = function (slot0)
		return function (slot0, slot1)
			if isSuccess(slot0.result) then
				if BackHomeCricketBattleData:GetSingleBattleData() then
					slot2:AddCompleteInfo(slot1, slot0)
				end

				if uv0 then
					uv0(slot1, slot0)
				end
			else
				ShowTips(slot0.result)
			end
		end
	end,
	AskBattleHistorySimpleData = function (slot0, slot1)
		if slot0 then
			manager.net:SendWithLoadingNew(58184, {
				battle_id = slot0
			}, 58185, function (slot0, slot1)
				if isSuccess(slot0.result) then
					BackHomeCricketBattleData:InitSingleBattleData(slot0, slot1, BackHomeCricketConst.ROOM_TYPE.Video)

					if uv0 then
						uv0()
					end

					BackHomeDataManager:GotoBackHomeCricketStage(BackHomeCricketConst.ROOM_TYPE.PVP_STAGE, slot0.stage_id, BackHomeCricketConst.ROOM_TYPE.Video)
				else
					ShowTips(slot0.result)
				end
			end)
		end
	end
}
