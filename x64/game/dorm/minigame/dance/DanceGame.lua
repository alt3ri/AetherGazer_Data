local var_0_0 = singletonClass("DanceGame")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = DormCharacterInteractBehaviour
local var_0_4 = Dorm.DormEntityManager

local function var_0_5(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.round

	print("Round:", var_1_0, "Start")
	manager.notify:Invoke(BACKHOME_CRICKET_ROUND_START, var_1_0)
end

local function var_0_6(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.round

	print("Round:", var_2_0, "End")
	manager.notify:Invoke(BACKHOME_CRICKET_ROUND_END, var_2_0)
end

local function var_0_7(arg_3_0)
	if arg_3_0 == nil then
		return nil
	end

	local var_3_0 = arg_3_0[1]

	for iter_3_0 = 2, #arg_3_0 do
		var_3_0 = var_3_0 .. arg_3_0[iter_3_0]
	end

	return var_3_0
end

local function var_0_8()
	DormMinigame.Launch("WT_RK")
end

local function var_0_9(arg_5_0, arg_5_1)
	manager.notify:Invoke(BACKHOME_CRICKET_REFRESH_BUFF, arg_5_1.round)
end

local function var_0_10(arg_6_0)
	return arg_6_0 ~= nil and arg_6_0 ~= 0
end

local function var_0_11(arg_7_0)
	local var_7_0 = arg_7_0.myAction.skillID
	local var_7_1 = arg_7_0.enemyAction.skillID
	local var_7_2 = math.random()
	local var_7_3 = var_0_10(var_7_0)
	local var_7_4 = var_0_10(var_7_1)
	local var_7_5
	local var_7_6

	if var_7_3 and var_7_4 then
		var_7_6 = BOTH_USING_SKILL_CHANCE
	elseif var_7_3 then
		var_7_5 = var_0_1
		var_7_6 = ONE_USING_SKILL_CHANCE
	elseif var_7_4 then
		var_7_5 = var_0_2
		var_7_6 = ONE_USING_SKILL_CHANCE
	else
		var_7_5 = var_0_1
		var_7_6 = ADVANCE_NORMAL_ACTION_CHANCE
	end

	var_7_6 = var_7_6 or 0

	if var_7_2 < var_7_6 then
		return nil
	end

	return var_7_5
end

local function var_0_12(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = {}
	local var_8_1 = nullable(DormUtils.GetEntityData(arg_8_0), "cfgID")
	local var_8_2 = nullable(DormUtils.GetEntityData(arg_8_1), "cfgID")

	var_8_0.entityCfg, var_8_0.targetCfg = var_8_1, var_8_2

	local var_8_3

	if arg_8_3 == nil then
		var_8_3 = var_0_3.GetSequence(var_8_1, var_8_2, arg_8_2, "game.dorm.interacts.dance")
	else
		local var_8_4 = var_0_3.GetSequenceGroup(var_8_1, var_8_2, arg_8_2, "game.dorm.interacts.dance")

		arg_8_3 = (arg_8_3 - 1) % #var_8_4 + 1
		var_8_3 = var_8_4[arg_8_3]
	end

	return var_0_3.MakeCtx(arg_8_0, arg_8_1, var_8_0), var_8_3
end

local function var_0_13(arg_9_0, arg_9_1)
	if arg_9_1 == nil then
		return arg_9_0
	end

	local var_9_0 = arg_9_0.duration / arg_9_1
	local var_9_1 = {
		duration = arg_9_1,
		sequence = {
			[0] = {
				function(arg_10_0)
					DanceGameController.SetEntityAnimeSpeed(arg_10_0.entityID, var_9_0)
				end
			}
		}
	}

	for iter_9_0, iter_9_1 in pairs(arg_9_0.sequence) do
		local var_9_2 = iter_9_0 / var_9_0
		local var_9_3 = var_9_1.sequence[var_9_2] or {}

		if type(iter_9_1) == "function" then
			table.insert(var_9_3, iter_9_1)
		elseif type(iter_9_1) == "table" then
			for iter_9_2, iter_9_3 in ipairs(iter_9_1) do
				table.insert(var_9_3, iter_9_3)
			end
		end

		var_9_1.sequence[var_9_2] = var_9_3
	end

	return var_9_1
end

local function var_0_14(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_2 == nil then
		print("No action, no wait", arg_11_0)

		return nil
	end

	local var_11_0, var_11_1 = var_0_12(arg_11_0, arg_11_1, arg_11_2, arg_11_3)

	if var_11_1 then
		local var_11_2 = var_0_13(var_11_1, arg_11_4)

		var_11_0.curActionTask = var_0_3.MakeInteractTask(var_11_2, var_11_0)
	else
		var_11_0.curActionTask = var_0_0.DebugAction(arg_11_2, var_11_0)
	end

	var_0_4.StopAllCmd(arg_11_0)
	DormUtils.SetEntityInteractContext(arg_11_0, var_11_0)
	var_0_4.SendInteractToEntityCMD(arg_11_0, arg_11_1, true)

	return var_11_0.curActionTask
end

local function var_0_15(arg_12_0, arg_12_1, arg_12_2, ...)
	local var_12_0 = {
		...
	}
	local var_12_1 = var_0_0.StartActionTurn
	local var_12_2 = var_0_0.TurnSettlement
	local var_12_3 = arg_12_0.actionRound[arg_12_1]
	local var_12_4 = var_12_3.start
	local var_12_5 = var_12_3.finish
	local var_12_6 = {
		round = arg_12_1,
		player = arg_12_0:GetPlayerCharaEID(),
		opponent = arg_12_0:GetOpponentCharaEID(),
		roundMusicInfo = var_12_3,
		duration = var_12_5 - var_12_4,
		removedBuff = {}
	}
	local var_12_7 = var_0_11(arg_12_2)
	local var_12_8 = arg_12_0.taskRunner:NewTask()

	var_12_8:WaitUntil(function()
		return arg_12_0.bgmPlayback and arg_12_0.taskRunner:Now() >= var_12_4
	end):Then(function()
		if var_12_7 then
			arg_12_0:ActiveShootToCharaCam(var_12_7)
		end

		arg_12_0.curRound = arg_12_1

		var_0_5(arg_12_0, var_12_6)

		var_12_6.playerTask, var_12_6.opponentTask = var_12_1(arg_12_0, var_12_6, arg_12_2, unpack(var_12_0))
	end):WaitUntil(function()
		return arg_12_0.taskRunner:Now() >= var_12_5
	end):Then(function()
		if var_12_7 then
			arg_12_0:RestoreCam()
		end

		var_12_2(arg_12_0, var_12_6, arg_12_2, unpack(var_12_0))
		var_0_6(arg_12_0, var_12_6)
		DanceGameController.SetEntityAnimeSpeed(var_12_6.player, 1)
		DanceGameController.SetEntityAnimeSpeed(var_12_6.opponent, 1)
	end)
	var_12_8:Start(true)

	return var_12_8
end

local function var_0_16(arg_17_0, arg_17_1)
	local var_17_0 = var_0_0.StartPrepareTurn

	local function var_17_1(arg_18_0, arg_18_1)
		var_0_9(arg_18_0, arg_18_1)
	end

	local var_17_2 = DormCharacterActionManager.frameTaskRunner:NewTask()
	local var_17_3 = 0
	local var_17_4 = {
		round = var_17_3,
		player = arg_17_0:GetPlayerCharaEID(),
		opponent = arg_17_0:GetOpponentCharaEID(),
		removedBuff = {}
	}

	Dorm.storage:RecordData("dance.flags", "start", false)
	var_17_2:Then(function()
		manager.notify:CallUpdateFunc("OnDanceGameStart")
	end):WaitUntil(function()
		return Dorm.storage:GetData("dance.flags", "start")
	end):Then(function()
		arg_17_0.curRound = var_17_3

		var_0_5(arg_17_0, var_17_4)

		var_17_4.playerTask, var_17_4.opponentTask = var_17_0(arg_17_0, var_17_4, arg_17_1)
	end):WaitUntil(function()
		if var_17_4.playerTask and not var_17_4.playerTask:IsFinished() then
			return false
		end

		if var_17_4.opponentTask and not var_17_4.opponentTask:IsFinished() then
			return false
		end

		return true
	end):Then(function()
		var_17_1(arg_17_0, var_17_4, arg_17_1)
		var_0_6(arg_17_0, var_17_4)
		print("准备阶段结束")

		arg_17_0.bgmPlayback = arg_17_0.bgmPlayer:Play()

		arg_17_0.taskRunner:SetPlayback(arg_17_0.bgmPlayback)
		arg_17_0:StartMainCamDirector()
		manager.notify:CallUpdateFunc("OnStartCountDownTimer")
	end)
	var_17_2:Start(true)

	return var_17_2
end

local function var_0_17(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = DormCharacterActionManager.frameTaskRunner:NewTask()
	local var_24_1 = {
		player = arg_24_0:GetPlayerCharaEID(),
		opponent = arg_24_0:GetOpponentCharaEID(),
		removedBuff = {}
	}
	local var_24_2 = "curtain_call_"
	local var_24_3 = 1.25

	var_24_0:WaitTask(arg_24_1):Then(function()
		manager.notify:CallUpdateFunc("OnDanceGameFinish")
		manager.audio:PlayEffect("ui_battle", "ui_battle_stopbgm")
	end):WaitUntil(function(arg_26_0)
		if arg_26_0.startTime == nil then
			arg_26_0.startTime = var_24_0.taskRunner:Now()
		end

		local var_26_0 = var_24_0.taskRunner:Now()

		if not arg_26_0.alreadyShowResult and var_26_0 - arg_26_0.startTime >= var_24_3 then
			arg_26_0.alreadyShowResult = true

			if arg_24_2 then
				arg_24_2()
			end
		end

		local var_26_1 = arg_26_0.player
		local var_26_2 = arg_26_0.opponent

		if arg_26_0.playerTask == nil or arg_26_0.playerTask:IsFinished() then
			arg_26_0.playerTask = var_0_14(var_26_1, var_26_2, var_24_2)
		end

		if arg_26_0.opponentTask == nil or arg_26_0.opponentTask:IsFinished() then
			arg_26_0.opponentTask = var_0_14(var_26_2, var_26_1, var_24_2)
		end

		return false
	end, false, var_24_1)
	var_24_0:Start(true)
end

function var_0_0.GotoResultView(arg_27_0)
	if not arg_27_0.isGotoResult then
		arg_27_0.isGotoResult = true

		local var_27_0 = BackHomeCricketBattleData:GetSingleBattleData()

		if var_27_0.settleType == BackHomeCricketConst.ROOM_TYPE.Video then
			JumpTools.OpenPageByJump("/backHomeCricketBattleResuleView", {
				data = var_27_0
			})
		else
			BackHomeCricketAction.SendBattleComplete(arg_27_0.battleType, function(arg_28_0, arg_28_1)
				JumpTools.OpenPageByJump("/backHomeCricketBattleResuleView", {
					data = arg_28_1
				})
			end)
		end
	end
end

function var_0_0.ProcessDanceSeq(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_0:GetPlayerCharaEID()
	local var_29_1 = arg_29_0:GetOpponentCharaEID()

	DanceGameController.SetEntityAnimeSpeed(var_29_0, 1)
	DanceGameController.SetEntityAnimeSpeed(var_29_1, 1)
	var_0_16(arg_29_0, arg_29_1)

	local var_29_2

	arg_29_0.totalRound = arg_29_3

	for iter_29_0 = 1, arg_29_3 do
		local var_29_3 = arg_29_2[iter_29_0]

		var_29_2 = var_0_15(arg_29_0, iter_29_0, var_29_3)
	end

	var_0_17(arg_29_0, var_29_2, function()
		arg_29_0:GotoResultView()
	end)
end

function var_0_0.SkipShow(arg_31_0)
	arg_31_0:GotoResultView()
end

function var_0_0.DebugAction(arg_32_0, arg_32_1)
	return var_0_3.MakeInteractTask({
		duration = 1,
		sequence = {
			[0] = function()
				print("普通动作", arg_32_0, 0)
			end,
			[0.5] = function()
				print("普通动作", arg_32_0, 0.5, "InProgress")
			end,
			function()
				print("普通动作", arg_32_0, 1, "Finish")
			end
		}
	}, arg_32_1)
end

local function var_0_18(arg_36_0)
	return arg_36_0 and arg_36_0 ~= "" and not IsAllSpace(arg_36_0)
end

local function var_0_19(arg_37_0)
	local var_37_0 = IdolTraineeSkillCfg[arg_37_0].action

	return var_0_18(var_37_0)
end

local function var_0_20(arg_38_0)
	local var_38_0 = IdolTraineeSkillCfg[arg_38_0].counter_action

	return var_0_18(var_38_0)
end

local var_0_21 = 0
local var_0_22 = 1
local var_0_23 = {
	"type1",
	"type2",
	"type3",
	"type4",
	"type5"
}
local var_0_24 = {
	"b8",
	"b16"
}

local function var_0_25(arg_39_0, arg_39_1)
	local var_39_0 = nullable(DormUtils.GetEntityData(arg_39_0), "cfgID")
	local var_39_1

	for iter_39_0, iter_39_1 in ipairs(arg_39_1) do
		if (var_39_1 == nil or iter_39_1 < var_39_1) and var_0_19(iter_39_1) then
			var_39_1 = iter_39_1
		end
	end

	return nullable(IdolTraineeSkillCfg, var_39_1, "action")
end

local function var_0_26(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	local var_40_0 = nullable(DormUtils.GetEntityData(arg_40_0), "cfgID")
	local var_40_1
	local var_40_2

	if arg_40_2 and var_0_10(arg_40_2.skillID) then
		var_40_1 = arg_40_2.skillID
	end

	if arg_40_3 and var_0_10(arg_40_3.skillID) then
		var_40_2 = arg_40_3.skillID
	end

	local var_40_3

	if var_40_1 then
		var_40_3 = IdolTraineeSkillCfg[var_40_1].action
	elseif var_40_2 then
		var_40_3 = IdolTraineeSkillCfg[var_40_2].counter_action
	end

	local var_40_4 = true

	if not var_0_18(var_40_3) then
		var_40_3 = var_0_23[arg_40_2.actionID]
		var_40_4 = false
	end

	local var_40_5 = var_0_24[arg_40_1.roundMusicInfo.type]

	return string.format("%s_%s_", var_40_3, var_40_5), var_40_4
end

local var_0_27 = 1
local var_0_28 = 2

local function var_0_29(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5, arg_41_6)
	local var_41_0 = IdolTraineeSkillEffectCfg[arg_41_0]
	local var_41_1
	local var_41_2

	if var_41_0.object == var_0_27 then
		local var_41_3 = arg_41_2

		var_41_2 = arg_41_3
	elseif var_41_0.object == var_0_28 then
		local var_41_4 = arg_41_4

		var_41_2 = arg_41_5
	end

	table.insert(var_41_2.buff, {
		id = arg_41_0,
		skill = arg_41_1,
		duration = var_41_0.round,
		triggerRound = var_41_0.trigger_time + arg_41_6.round
	})
end

local function var_0_30(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	local var_42_0 = DormUtils.GetEntityData(arg_42_0)
	local var_42_1 = DormUtils.GetEntityData(arg_42_1)

	if arg_42_3.action then
		local var_42_2 = arg_42_3.action

		for iter_42_0, iter_42_1 in ipairs(var_42_2.effectList) do
			local var_42_3 = nullable(IdolTraineeSkillCfg, var_42_2.actionID, "skill_effect", iter_42_1)

			if var_42_3 then
				var_0_29(var_42_3, var_42_2, arg_42_0, var_42_0, arg_42_1, var_42_1, arg_42_2)
			end
		end
	else
		for iter_42_2, iter_42_3 in ipairs(arg_42_3.passive) do
			var_0_29(iter_42_3, action, arg_42_0, var_42_0, arg_42_1, var_42_1, arg_42_2)
		end
	end
end

local function var_0_31(arg_43_0)
	local var_43_0 = {}
	local var_43_1 = nullable(BackHomeHeroCfg, arg_43_0, "idol_passive_skill_list")

	if var_43_1 then
		for iter_43_0, iter_43_1 in ipairs(var_43_1) do
			table.insert(var_43_0, iter_43_1[1])
		end
	else
		local var_43_2 = nullable(IdolPveNpcCfg, arg_43_0, "idol_passive_skill_list")

		if var_43_2 then
			for iter_43_2, iter_43_3 in ipairs(var_43_2) do
				table.insert(var_43_0, iter_43_3)
			end
		end
	end

	return var_43_0
end

function var_0_0.StartPrepareTurn(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_1.player
	local var_44_1 = arg_44_1.opponent
	local var_44_2 = DormUtils.GetEntityData(var_44_0).heroID
	local var_44_3 = DormUtils.GetEntityData(var_44_1).heroID
	local var_44_4 = var_0_31(var_44_2)
	local var_44_5 = var_0_31(var_44_3)
	local var_44_6 = {
		passive = arg_44_2.myActiveBuffList
	}
	local var_44_7 = {
		passive = arg_44_2.enemyActiveBuffList
	}

	var_0_30(var_44_0, var_44_1, arg_44_1, var_44_6)
	var_0_30(var_44_1, var_44_0, arg_44_1, var_44_7)
	var_0_9(arg_44_0, arg_44_1)

	return var_0_14(var_44_0, var_44_1, var_0_25(var_44_0, arg_44_1, var_44_4)), var_0_14(var_44_1, var_44_0, var_0_25(var_44_1, arg_44_1, var_44_5))
end

function var_0_0.StartActionTurn(arg_45_0, arg_45_1, arg_45_2)
	print("回合开始：", arg_45_1.round)

	local var_45_0 = arg_45_1.player
	local var_45_1 = arg_45_1.opponent
	local var_45_2 = {
		action = arg_45_2.myAction,
		score = arg_45_2.myScore
	}
	local var_45_3 = {
		action = arg_45_2.enemyAction,
		score = arg_45_2.enemyScore
	}

	var_0_30(var_45_0, var_45_1, arg_45_1, var_45_2)
	var_0_30(var_45_1, var_45_0, arg_45_1, var_45_3)
	var_0_9(arg_45_0, arg_45_1)

	local var_45_4 = nullable(DormUtils.GetEntityData(var_45_0), "cfgID")
	local var_45_5 = nullable(DormUtils.GetEntityData(var_45_1), "cfgID")
	local var_45_6
	local var_45_7
	local var_45_8
	local var_45_9

	if arg_45_1.round == 1 then
		local var_45_10
		local var_45_11
		local var_45_12

		var_45_6, var_45_12 = var_0_26(var_45_0, arg_45_1, var_45_2.action, var_45_3.action)

		local var_45_13

		var_45_7, var_45_13 = var_0_26(var_45_1, arg_45_1, var_45_3.action, var_45_2.action)

		if not var_45_12 and not var_45_13 then
			var_45_7 = var_45_6

			local var_45_14 = var_0_3.GetSequenceGroup(var_45_4, var_45_5, var_45_6, "game.dorm.interacts.dance")
			local var_45_15 = math.random(#var_45_14)

			var_45_8, var_45_9 = var_45_15, var_45_15
		end
	elseif arg_45_1.round == arg_45_0.totalRound then
		local var_45_16
		local var_45_17
		local var_45_18

		var_45_6, var_45_18 = var_0_26(var_45_0, arg_45_1, var_45_2.action, var_45_3.action)

		local var_45_19

		var_45_7, var_45_19 = var_0_26(var_45_1, arg_45_1, var_45_3.action, var_45_2.action)

		if not var_45_18 and not var_45_19 then
			var_45_6 = var_45_7

			local var_45_20 = var_0_3.GetSequenceGroup(var_45_5, var_45_4, var_45_7, "game.dorm.interacts.dance")
			local var_45_21 = math.random(#var_45_20)

			var_45_8, var_45_9 = var_45_21, var_45_21
		end
	else
		var_45_6 = var_0_26(var_45_0, arg_45_1, var_45_2.action, var_45_3.action)
		var_45_7 = var_0_26(var_45_1, arg_45_1, var_45_3.action, var_45_2.action)
	end

	return var_0_14(var_45_0, var_45_1, var_45_6, var_45_8, arg_45_1.duration), var_0_14(var_45_1, var_45_0, var_45_7, var_45_9, arg_45_1.duration)
end

local function var_0_32(arg_46_0, arg_46_1)
	local var_46_0 = DormUtils.GetEntityData(arg_46_0)
	local var_46_1 = {}

	for iter_46_0, iter_46_1 in pairs(var_46_0.buff) do
		local var_46_2 = iter_46_1.id
		local var_46_3 = iter_46_1.duration

		if iter_46_1.triggerRound <= arg_46_1.round then
			if var_46_3 > 0 then
				if not iter_46_1.activated then
					iter_46_1.activated = true
				end

				iter_46_1.duration = var_46_3 - 1
			end

			if iter_46_1.duration <= 0 then
				table.insert(var_46_1, iter_46_0)
			end
		end
	end

	for iter_46_2 = #var_46_1, 1, -1 do
		var_46_1[iter_46_2] = table.remove(var_46_0.buff, var_46_1[iter_46_2]).id
	end

	arg_46_1.removedBuff[arg_46_0] = var_46_1
end

function var_0_0.TurnSettlement(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = arg_47_1.player
	local var_47_1 = arg_47_1.opponent

	var_0_32(var_47_0, arg_47_1)
	var_0_32(var_47_1, arg_47_1)
	var_0_9(arg_47_0, arg_47_1)
end

local function var_0_33(arg_48_0)
	return "CharDorm/dance/" .. arg_48_0.model
end

local function var_0_34(arg_49_0)
	local var_49_0 = "dance.pos." .. arg_49_0.spawnAt

	return Dorm.storage:GetData(var_49_0, 1).transform
end

function var_0_0.Ctor(arg_50_0)
	local var_50_0 = EntityManager.CreateModel.New(var_0_33, var_0_34)

	arg_50_0.charaMgr = EntityManager.New(var_50_0)
	arg_50_0.taskRunner = DanceGameTaskRunner.New()
end

function var_0_0.Init(arg_51_0, arg_51_1)
	arg_51_0:InitGame(arg_51_1)

	local var_51_0 = arg_51_1.stageID
	local var_51_1 = arg_51_1.battleType == BackHomeCricketConst.ROOM_TYPE.PVE_STAGE and IdolTraineePveBattleCfg[var_51_0] or IdolTraineePvpBattleCfg[var_51_0]

	arg_51_0:InitScene(var_51_1)
	DormCharacterActionManager:RegisterTaskRunner(arg_51_0.taskRunner, 2, 1)
	arg_51_0:ProcessDanceSeq(arg_51_1.prepareInfo, arg_51_1.roundList, arg_51_1.lastRound)
end

var_0_0.actionCountNamespace = "dance.action.cnt"

function var_0_0.InitGame(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_1.mySkinID
	local var_52_1 = arg_52_1.enemySkinID

	arg_52_0.battleType = arg_52_1.battleType

	arg_52_0:SetCharacter(var_0_1, var_52_0)
	arg_52_0:SetCharacter(var_0_2, var_52_1)

	arg_52_0.isGotoResult = nil

	Dorm.storage:ClearData(var_0_0.actionCountNamespace)
end

function var_0_0.SetCharacter(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = BackHomeHeroSkinCfg[arg_53_2] or IdolPveNpcCfg[arg_53_2]
	local var_53_1 = nullable(var_53_0, "model")
	local var_53_2 = nullable(var_53_0, "hero_id") or arg_53_2
	local var_53_3 = {
		complex = true,
		model = var_53_1,
		spawnAt = arg_53_1
	}

	arg_53_0.charaMgr:Update(arg_53_1, var_53_3, {
		cfgID = arg_53_2,
		heroID = var_53_2,
		buff = {}
	})
end

function var_0_0.GetPlayerCharaEID(arg_54_0)
	return arg_54_0.charaMgr:GetEntityID(var_0_1)
end

function var_0_0.GetOpponentCharaEID(arg_55_0)
	return arg_55_0.charaMgr:GetEntityID(var_0_2)
end

function var_0_0.Reset(arg_56_0, arg_56_1, arg_56_2)
	arg_56_0.charaMgr:Clear(true)
	arg_56_0.taskRunner:Reset()

	arg_56_0.bgmPlayback = nil
	arg_56_0.totalRound = nil

	if not arg_56_2 then
		arg_56_0.actionRound = nil
	end

	if arg_56_1 then
		arg_56_0.danceGameController = nil
		arg_56_0.shootCam = nil
		arg_56_0.cinemachineBrain = nil
	end
end

function var_0_0.InitBgmPlayer(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	local var_57_0 = GameObject.Find("bgmPlayer"):GetComponent("CriAtomSource")

	DanceGameController.AddCue(arg_57_1, arg_57_3)

	var_57_0.cueSheet = arg_57_1
	var_57_0.cueName = arg_57_2
	arg_57_0.bgmPlayer = var_57_0
end

local var_0_35 = 2

function var_0_0.InitScene(arg_58_0, arg_58_1)
	if arg_58_0.danceGameController == nil then
		local var_58_0 = arg_58_1.cam_director_prefab

		arg_58_0.danceGameController = DanceGameController.Load("IdolTrainee/Stage/" .. var_58_0)

		arg_58_0:InitCam()
	end

	local var_58_1 = arg_58_1.scene_name
	local var_58_2 = IdolStageMusicCfg[arg_58_1.bgm]

	if arg_58_0.actionRound == nil then
		local var_58_3 = var_58_2.music_json
		local var_58_4 = AssetEx.LoadText(var_58_3)
		local var_58_5 = require("cjson").decode(var_58_4)
		local var_58_6 = {}

		for iter_58_0 = 1, var_0_35 do
			local var_58_7 = var_58_5["track" .. iter_58_0]

			for iter_58_1, iter_58_2 in pairs(var_58_7) do
				table.insert(var_58_6, {
					type = iter_58_0,
					start = iter_58_2[1] / 1000,
					finish = iter_58_2[2] / 1000
				})
			end
		end

		table.sort(var_58_6, function(arg_59_0, arg_59_1)
			return arg_59_0.start < arg_59_1.start
		end)

		arg_58_0.actionRound = var_58_6
	end

	arg_58_0:InitBgmPlayer(var_58_2.cue_sheet, var_58_2.cue_name, var_58_2.awb_name)
end

function var_0_0.InitCam(arg_60_0)
	arg_60_0.danceGameController:InitCinemachineBrain()

	arg_60_0.cinemachineBrain = arg_60_0.danceGameController.brain
	arg_60_0.cinemachineBrain.m_DefaultBlend = DanceGameController.cut
	arg_60_0.shootCam = GameObject.Find("shoot"):GetComponent("CinemachineVirtualCamera")

	local var_60_0 = arg_60_0:GetPlayerCharaEID()
	local var_60_1 = arg_60_0:GetOpponentCharaEID()

	arg_60_0.danceGameController:SetDummyFollowEntity("player1", var_60_0)
	arg_60_0.danceGameController:SetDummyFollowEntity("player2", var_60_1)

	arg_60_0.cinemachineBrain.enabled = true

	local var_60_2 = var_0_34({
		spawnAt = var_0_1
	})
	local var_60_3 = var_0_34({
		spawnAt = var_0_2
	})

	arg_60_0.shootCamCfg = {
		[var_0_1] = {
			lookAt = arg_60_0.danceGameController:GetDummy("player1") or var_60_2,
			pos = var_60_2:Find("shootPos")
		},
		[var_0_2] = {
			lookAt = arg_60_0.danceGameController:GetDummy("player2") or var_60_3,
			pos = var_60_3:Find("shootPos")
		}
	}
end

function var_0_0.ActiveShootToCharaCam(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0.shootCamCfg[arg_61_1]

	if var_61_0 then
		arg_61_0.shootCam.Follow = var_61_0.pos
		arg_61_0.shootCam.LookAt = var_61_0.lookAt
		arg_61_0.shootCam.enabled = true
	end
end

function var_0_0.RestoreCam(arg_62_0)
	arg_62_0.shootCam.enabled = false
end

function var_0_0.StartMainCamDirector(arg_63_0)
	local var_63_0 = arg_63_0.danceGameController.director

	if var_63_0 then
		var_63_0:Play()
	end
end

function var_0_0.StopMainCamDirector(arg_64_0)
	local var_64_0 = arg_64_0.danceGameController.director

	if var_64_0 then
		var_64_0:Stop()

		var_64_0.time = var_64_0.initialTime

		var_64_0:Evaluate()
	end
end

function var_0_0.Restart(arg_65_0, arg_65_1)
	arg_65_0:Reset(nil, true)
	arg_65_0:InitGame(arg_65_1)
	arg_65_0.bgmPlayer:Stop()
	DormCharacterActionManager:RegisterTaskRunner(arg_65_0.taskRunner, 2, 1)
	arg_65_0:ProcessDanceSeq(arg_65_1.prepareInfo, arg_65_1.roundList, arg_65_1.lastRound)
end

return var_0_0
