slot0 = singletonClass("SnowballGameMgr")

function slot1(slot0)
	manager.audio:PlayEffect("minigame_activity_2_6_snowball", slot0, "")
end

function slot2(slot0)
	return slot0.model
end

function slot3(slot0)
	return slot0.spawnAt
end

function slot4(slot0, slot1)
	return SnowballGameUnitCfg[slot0 * 100 + (slot1 or 0)] or SnowballGameUnitCfg[slot0]
end

function slot5(slot0)
	return slot0[math.random(#slot0)]
end

slot6 = 3
slot7 = "snowball_fight"
slot8 = "snowball_gift"
slot9 = "snowball_get_sign"
slot10 = "minigame_snowball"
slot11 = "minigame_snowball_buff"
slot12 = 0.2
slot14 = 0.7
slot15 = 1.6
slot16 = 1
slot17 = "idle"
slot18 = "happy"

function slot19(...)
	return DormCharacterActionManager.frameTaskRunner:NewTask(...)
end

slot20 = Dorm.LuaBridge.MiniGameBridge.PlayEffect
slot21 = Dorm.DormEntityManager.QueryPosition
slot22 = Dorm.DormEntityManager.QueryForwardDir
slot23 = Dorm.DormEntityManager.QueryEntityAttachPointWorldPos

function slot0.Ctor(slot0)
	slot0.entityManager = EntityManager.New(EntityManager.CreateModel.New(uv0, uv1, uv2))

	function slot0.entityManager.OnCreate(slot0, slot1)
		Dorm.DormEntityManager.PlayEffect(slot1, "root", uv0, "Dorm/Effect/snowball/fx_snow_effect_spawn", 1)
		Dorm.DormEntityManager.SetFadeCMD(slot1, 0)
		uv1():WaitForSec(0.25):Then(function ()
			if Dorm.DormEntityManager.IsValidEntityID(uv0) then
				Dorm.DormEntityManager.SetFadeCMD(uv0, 1)
			end
		end):Start()
	end

	function slot0.entityManager.OnRemove(slot0, slot1)
		if DormUtils.GetEntityData(slot1).isHumanoidTarget then
			Dorm.DormEntityManager.StartFadeOutCMD(slot1, uv0)
		else
			Dorm.DormEntityManager.SetFadeCMD(slot1, 0)
		end

		Dorm.DormEntityManager.PlayEffectDetached(slot1, "root", "Dorm/Effect/snowball/fx_snow_effect_death", 1)
	end

	slot0.playerManager = EntityManager.New(EntityManager.CreatePlayer.New(uv0, uv1))

	function slot0.playerManager.OnRemove(slot0, slot1)
		manager.notify:Invoke(DORM_CHARACTER_DISPOSE, slot1)
	end

	slot0.managers = {
		slot0.entityManager,
		slot0.playerManager
	}
	slot0.listener = EventListener.New()
end

function slot0.Init(slot0)
	slot0.targetIdx = 0
	slot0.shootSpeedFactor = 1
	slot0.playerSpawnPos = Dorm.storage:PickData("snowball.pos.player").transform
	slot0.guestSpawnPos = Dorm.storage:PickData("snowball.pos.guest").transform

	slot0.listener:Register(SNOWBALL_GAME_AIM_FINISH, handler(slot0, slot0.OnSnowballAimFinish))
	slot0.listener:Register(SNOWBALL_GAME_TARGET_NEW_WAVE, handler(slot0, slot0.SpawnTarget))
	slot0.listener:Register(SNOWBALL_GAME_INFINITY_POOL_CLICK_MODEL, handlerArg1(slot0, slot0.PlayerPlayAction, uv0))
	slot0.listener:Register(SNOWBALL_GAME_INFINITY_POOL_CLICK_ICE, handlerArg1(slot0, slot0.PlayerPlayAction, uv1))
	slot0.listener:Register(ON_BEGIN_STORY, handler(slot0, slot0.OnBeginStory))
	slot0.listener:Register(ON_FINISH_STORY, handler(slot0, slot0.OnFinishStory))
end

function slot0.Dispose(slot0)
	slot0.listener:RemoveAll()
	slot0.entityManager:Clear(true)
	slot0.playerManager:Clear(true)

	slot0.targetIdx = nil
end

function slot0.OnBeginStory(slot0, slot1)
	if DormEnum.HasFlag(slot1, DormEnum.BeginStoryFlag.HideCharacter) then
		slot0.playerManager:Clear(true)
	end
end

function slot0.OnFinishStory(slot0, slot1)
	if DormEnum.HasFlag(slot1, DormEnum.BeginStoryFlag.HideCharacter) then
		slot0:SetPlayer(slot0.player)
		slot0:SetGuest(slot0.guest)
	end
end

function slot0.PlayerPlayAction(slot0, slot1, slot2)
	slot3 = slot0:GetPlayerEID()

	if slot2 then
		Dorm.DormEntityManager.StopAllCmd(slot3)
	end

	Dorm.DormEntityManager.SendDoActionCMD(slot3, slot1, false)
end

function slot24(slot0, slot1)
	Dorm.DormEntityManager.SetEntitySpeed(slot0, slot1)

	DormUtils.GetEntityData(slot0).speed = slot1
end

slot25 = {
	Guest = 4,
	Player = 0,
	RewardTarget = 2,
	NormalTarget = 1,
	PanishTarget = 3
}

function slot26(slot0, slot1, slot2, slot3)
	if slot2 and slot2 ~= 0 then
		slot5 = uv0(slot2, slot1).unit_type == uv1.PanishTarget
		slot0.targetCountByType[slot4.unit_type] = (slot0.targetCountByType[slot4.unit_type] or 0) + 1
		slot0.targetCountByRow[slot1] = (slot0.targetCountByRow[slot1] or 0) + 1
		slot0.targetIdx = slot0.targetIdx + 1

		Dorm.DormEntityManager.ChangeEntityAnimeScheme(slot0.entityManager:Create(slot0.targetIdx, {
			complex = true,
			type = "target",
			model = slot4.model,
			spawnAt = slot3
		}, {
			type = "target",
			cfgID = slot4.id,
			isHumanoidTarget = slot5,
			row = slot1
		}), "snowball_target_move_L")

		if slot5 then
			Dorm.LuaBridge.MiniGameBridge.InitDefaultEntityCollider(slot6)
			Dorm.LuaBridge.MiniGameBridge.SetEntityIgnoreBeamcast(slot6, false)
			Dorm.LuaBridge.MiniGameBridge.InitMoveController(slot6)
			Dorm.LuaBridge.MiniGameBridge.SetMoveLookAtEntity(slot6, slot0:GetPlayerEID())
		else
			Dorm.LuaBridge.MiniGameBridge.SetEntityIgnoreBeamcast(slot6, false)
			Dorm.LuaBridge.MiniGameBridge.InitMoveController(slot6)
			Dorm.LuaBridge.MiniGameBridge.SetMoveLookAtDir(slot6, Vector3(0, 0, 1))
		end

		SnowballGameTargetAI.GetInstance():AddEntityToRow(slot6, slot1)
		uv2(slot6, slot4.speed)

		return slot6
	end
end

function slot27(slot0, slot1)
	if DormUtils.GetEntityData(slot1).type == "target" then
		SnowballGameTargetAI.GetInstance():Remove(slot1)

		slot2 = DormUtils.GetEntityData(slot1)
		slot3 = uv0(slot2.cfgID)
		slot0.targetCountByType[slot3.unit_type] = slot0.targetCountByType[slot3.unit_type] - 1
		slot0.targetCountByRow[slot2.row] = slot0.targetCountByRow[slot2.row] - 1
	end

	EntityManager.FindAndRemoveEntity(slot0.managers, slot1)
end

function slot0.GetNormalTargetCount(slot0)
	return nullable(slot0.targetCountByType, uv0.NormalTarget) or 0
end

function slot0.GetRewardTargetCount(slot0)
	return nullable(slot0.targetCountByType, uv0.RewardTarget) or 0
end

function slot0.GetPanishTargetCount(slot0)
	return nullable(slot0.targetCountByType, uv0.PanishTarget) or 0
end

slot28 = -1
slot29 = -2

function slot0.SetPlayer(slot0, slot1)
	if slot0:GetPlayerEID() then
		uv0.ClearVfxOnEntity(slot2)
		slot0.playerManager:Remove(uv1)
	end

	slot0.player = slot1

	if slot1 == nil then
		return
	end

	slot3 = uv2(slot1)

	Dorm.DormEntityManager.PlayerControlEntity(slot0.playerManager:Create(uv1, {
		complex = true,
		model = slot3.model,
		spawnAt = slot0.playerSpawnPos
	}, {
		type = "player",
		cfgID = slot3.id
	}), UnityEngine.Camera.main and slot5.transform.forward or Vector3(0, 0, -1))
	Dorm.LuaBridge.MiniGameBridge.SetEntityIgnoreBeamcast(slot4, true)
	Dorm.DormEntityManager.ChangeEntityAnimeScheme(slot4, "snowball_move_L")
	uv3(slot4, slot3.speed)
	uv0.CreateHoldSnowballVfx(slot4)
end

function slot0.SetGuest(slot0, slot1)
	slot0.guest = slot1

	if slot1 == nil then
		return
	end

	slot0.playerManager:Remove(uv0)

	slot2 = uv1(slot1)
	slot3 = slot0.playerManager:Create(uv0, {
		complex = true,
		model = slot2.model,
		spawnAt = slot0.guestSpawnPos
	}, {
		row = 0,
		type = "guest",
		cfgID = slot1
	})

	Dorm.LuaBridge.MiniGameBridge.SetEntityIgnoreBeamcast(slot3, false)
	uv2(slot3, slot2.speed)
end

function slot0.RemoveGuest(slot0)
	slot0.guest = nil

	slot0.playerManager:Remove(uv0)
end

function slot0.ClearAllTargets(slot0)
	SnowballGameTargetAI.GetInstance():Clear()
	slot0.entityManager:Clear(true)

	slot0.targetCountByType = {}
	slot0.targetCountByRow = {}
end

slot30 = {
	slot25.NormalTarget,
	slot25.RewardTarget,
	slot25.PanishTarget
}

function slot0.SetLevel(slot0, slot1)
	slot0:ClearAllTargets()

	slot0.level = slot1
	slot0.targets = {}

	for slot6, slot7 in ipairs(SnowballGameCfg[slot1].enemy_set) do
		slot0.targets[uv0[slot6]] = {
			total = slot7[1],
			weight = slot7[2]
		}
	end

	slot0.debuffList = slot2.level_debuff
	slot0.buffList = slot2.level_buff

	slot0:SetGuest(uv1(slot2.hero_id))
end

function slot31(slot0, slot1)
	if slot1 == uv0.NormalTarget then
		return SnowballGameCfg[slot0].enemy_normal
	elseif slot1 == uv0.RewardTarget then
		return slot2.enemy_reward
	elseif slot1 == uv0.PanishTarget then
		return slot2.enemy_punish
	end
end

function slot32(slot0)
	for slot5, slot6 in pairs(slot0.targets) do
		if slot6.total > 0 then
			slot1 = 0 + slot6.weight
		end
	end

	if slot1 == 0 then
		return nil
	end

	for slot6, slot7 in pairs(slot0.targets) do
		if slot7.total > 0 and math.random() * slot1 - slot7.weight <= 0 then
			return slot6
		end
	end
end

function slot33(slot0)
	return nullable(uv0(DormUtils.GetEntityData(slot0).cfgID), "unit_type") == uv1.PanishTarget
end

function slot34(slot0)
	return nullable(uv0(DormUtils.GetEntityData(slot0).cfgID), "unit_type") == uv1.RewardTarget
end

function slot0.GetEachWaveGenLimitPerRow(slot0, slot1, slot2)
	return nullable(SnowballGameCfg[slot0.level].refresh_enemy, slot1, slot2) or math.huge
end

function slot0.GetTotalGenLimit(slot0)
	return GameSetting.activity_snowball_maxsnowman.value[1]
end

function slot35(slot0)
	return string.format("snowball.pos.row%d", slot0)
end

function slot36(slot0)
	slot1 = {}
	slot5 = pairs

	for slot5, slot6 in Dorm.storage:ForeachData(slot0, slot5) do
		table.insert(slot1, slot6)
	end

	for slot5 = 1, #slot1 do
		slot6 = math.random(#slot1)
		slot1[slot6] = slot1[slot5]
		slot1[slot5] = slot1[slot6]
	end

	return slot1
end

function slot0.SpawnTarget(slot0, slot1)
	slot2 = false

	if slot1 == 0 then
		for slot8, slot9 in ipairs(SnowballGameCfg[slot0.level].snowman_pos) do
			for slot13, slot14 in ipairs(slot9) do
				if nullable(Dorm.storage:GetData(uv0(slot8), slot14[2]), "transform") then
					slot2 = slot2 or uv1(slot0, slot8, slot14[1], slot15) ~= nil
				end
			end
		end
	else
		if slot0.targets == nil then
			return
		end

		for slot6 = 1, uv2 do
			slot7 = 0

			for slot12, slot13 in ipairs(uv3(uv0(slot6))) do
				if not Dorm.LuaBridge.MiniGameBridge.CheckPosBlocked(slot13.transform.position) and slot7 < slot0:GetEachWaveGenLimitPerRow(slot1, slot6) and (slot0.targetCountByRow[slot6] or 0) < slot0:GetTotalGenLimit() then
					if uv4(slot0) then
						slot0.targets[slot17].total = math.max(0, slot0.targets[slot17].total - 1)
						slot2 = slot2 or uv1(slot0, slot6, uv5(uv6(slot0.level, slot17)), slot14) ~= nil
						slot7 = slot7 + 1
					elseif slot7 == 0 then
						manager.notify:Invoke(SNOWBALL_GAME_ALL_TARGET_SPAWNED)
					end
				end
			end
		end
	end

	if slot2 then
		uv7("minigame_activity_2_6_snowball_refresh")
	end
end

function slot0.GetPlayerEID(slot0)
	return slot0.playerManager:GetEntityID(uv0)
end

function slot0.GetPlayerCfgID(slot0)
	return slot0.player
end

function slot0.GetGuestEID(slot0)
	return slot0.playerManager:GetEntityID(uv0)
end

function slot0.GetGuestCfgID(slot0)
	return slot0.guest
end

function slot0.ClearVfxOnEntity(slot0)
	Dorm.DormEntityManager.ClearAllEffect(slot0, uv0)
end

function slot0.ClearBuffVfxOnEntity(slot0)
	Dorm.DormEntityManager.ClearAllEffect(slot0, uv0)
end

function slot0.CreateHoldSnowballVfx(slot0)
	Dorm.DormEntityManager.PlayEffect(slot0, "gua_R_hand_bone", uv0, "Dorm/Effect/snowball/fx_snow_effect_xueqiu_static", -1)
end

slot37 = {
	[2.0] = 1,
	[3.0] = 4
}
slot38 = {
	duration = 1.933,
	sequence = {
		[0] = function (slot0)
			uv0.CreateHoldSnowballVfx(slot0.entityID)

			slot0.targetID = slot0._targetID

			Dorm.DormEntityManager.PlayAnimeDuringInteract(slot0.entityID, uv1)
			uv2("minigame_activity_2_6_snowball_attack")

			if Dorm.DormEntityManager.INVALID_ENTITY_ID == slot0.targetID then
				uv2("minigame_activity_2_6_snowball_hit03")
			end
		end,
		[0.35] = function (slot0)
			uv0.ClearVfxOnEntity(slot0.entityID)

			slot1 = uv1(slot0.entityID)
			slot2 = nil

			if Dorm.DormEntityManager.INVALID_ENTITY_ID == slot0.targetID then
				Dorm.DormEntityManager.PlayEffect(slot0.entityID, "gua_biaoqing_bone", uv2, "Dorm/Effect/tongyong/fx_jingxia_0501", Vector3(-0.25, 0.25, 0), Quaternion.Euler(0, 0, 60), Vector3.one, 0.25)
				uv4(slot1, (slot0.hitPos:Magnitude() == math.huge or Quaternion.LookRotation(slot0.hitPos - slot1)) and Quaternion.LookRotation(uv3(slot0.entityID)), Vector3.one, "Dorm/Effect/snowball/fx_snow_effect_xueqiu2", 1)
			else
				slot3 = uv1(slot0.targetID)
				slot3.y = slot3.y + (nullable(uv5, DormUtils.GetEntityData(slot0.targetID).row) or 0)

				uv4(slot1, Quaternion.LookRotation(slot3 - slot1), Vector3.one, "Dorm/Effect/snowball/fx_snow_effect_xueqiu", 0.167)
			end
		end,
		[slot14 - 0.1] = function (slot0)
			if slot0.targetID == SnowballGameMgr.GetInstance():GetPlayerEID() or slot0.targetID == slot1:GetGuestEID() then
				Dorm.DormEntityManager.PlayEffect(slot0.targetID, "gua_biaoqing_bone", uv0, "Dorm/Effect/tongyong/fx_jingxia_0501", Vector3(-0.25, 0.25, 0), Quaternion.Euler(0, 0, 60), Vector3.one, 0.25)
			end
		end,
		[slot14] = function (slot0)
			if slot0.hitAction then
				slot0.hitAction()
			end
		end,
		[1.433] = function (slot0)
			Dorm.DormEntityManager.SetCurInteractToLowPriority(slot0.entityID)
		end
	}
}

function slot39(slot0, slot1, slot2, slot3)
	Dorm.DormEntityManager.StopAllCmd(slot0)

	slot4 = DormCharacterInteractBehaviour.MakeCtx(slot0, slot0, {
		hitAction = slot3,
		hitPos = slot2,
		_targetID = slot1
	})
	slot4.curActionTask = DormCharacterInteractBehaviour.MakeInteractTask(uv0, slot4)

	DormUtils.SetEntityInteractContext(slot0, slot4)
	Dorm.DormEntityManager.SendInteractToEntityCMD(slot0, slot0, false)
end

function slot40(slot0, slot1)
	Dorm.DormEntityManager.StopAllCmd(slot0)
	Dorm.DormEntityManager.SendDoActionCMD(slot0, uv0, nil, false, 0, false)
	Dorm.DormEntityManager.PlayEffect(slot0, "gua_R_hand_bone", uv1, "Dorm/Effect/snowball/fx_snow_effect_liwu", 2.833)
	uv2():WaitForSec(uv3):Then(slot1):Start()
end

function slot0.GuestPlaySubtitle(slot0, slot1)
	manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, slot0:GetGuestEID(), GetTips(slot1))
end

function slot41(slot0, slot1, slot2, slot3)
	if slot1 == Dorm.DormEntityManager.INVALID_ENTITY_ID then
		return
	end

	uv0(slot2, "Dorm/Effect/snowball/fx_snow_effect_snowhit", 1)

	if DormUtils.GetEntityData(slot1).type == "target" then
		slot0:OnSnowballHitTarget(slot1, slot4, slot2, slot3)
	elseif slot5 == "guest" then
		uv1("minigame_activity_2_6_snowball_hit04")
		manager.notify:Invoke(SNOWBALL_GAME_PLAYER_HIT_GUEST)
		slot0:GuestPlaySubtitle("ACTIVITY_SNOWBALL_HIT_NPC_TALK01")
		slot0:GuestBeatPlayer()
	end
end

function slot0.OnSnowballAimFinish(slot0, slot1, slot2, slot3)
	slot4 = slot0:GetPlayerEID()

	DormLuaBridge.ResetJoystick(false)
	uv0.ClearVfxOnEntity(slot4)
	uv1(slot4, slot1, slot2, function ()
		uv0.ClearVfxOnEntity(uv1)
		uv0.CreateHoldSnowballVfx(uv1)

		if uv2:Magnitude() ~= math.huge then
			uv3(uv4, uv5, uv2, uv6)
		end
	end)
end

function slot0.OnSnowballHitTarget(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot2.cfgID
	slot6 = slot0.lockHeadShot or slot4 == "head"

	if DormUtils.GetEntityData(slot1).isHumanoidTarget then
		Dorm.DormEntityManager.PlaySpacialFacileExpression(slot1, "Effect/Dorm/faint01", 1)
	end

	uv0(slot6 and "minigame_activity_2_6_snowball_hit01" or "minigame_activity_2_6_snowball_hit02")

	if uv1(slot1) then
		slot0:GuestPlaySubtitle("ACTIVITY_SNOWBALL_HIT_PUNISH_TALK01")
		slot0:GuestBeatPlayer()
	elseif uv2(slot1) then
		slot0:GuestSendGift()
	else
		slot0:GuestLiftSign(slot6)
	end

	manager.notify:Invoke(SNOWBALL_GAME_HIT, slot2, slot6, slot3)
	uv3(slot0, slot1)
end

function slot0.GetBuffFactor(slot0, slot1)
	return SnowballGameCfg[slot0.level].buff_intensity[slot1]
end

function slot0.GetBuffDuration(slot0, slot1)
	if type(SnowballGameCfg[slot0.level].buff_duration[slot1]) == "table" then
		return slot3[1] + (slot3[2] - slot3[1]) * math.random()
	else
		return slot3
	end
end

function slot0.GuestBeatPlayer(slot0)
	slot1 = slot0:GetPlayerEID()
	slot2 = slot0:GetGuestEID()
	slot3 = uv0(slot0.debuffList)

	Dorm.DormEntityManager.PutEntityLookAt(slot2, slot0.guestSpawnPos.position, uv1(slot1))
	Dorm.DormEntityManager.PlaySpacialFacileExpression(slot2, "Effect/Dorm/anger03", 0.5)
	uv2(slot2, slot1, uv3(slot1, "gua_Hit"), function ()
		manager.notify:Invoke(SNOWBALL_GAME_PLAYER_GET_BUFF, uv1, uv0:GetBuffDuration(uv1), uv0:GetBuffFactor(uv1))
	end)
end

function slot0.GuestSendGift(slot0)
	uv0("minigame_activity_2_6_snowball_present")

	slot2 = slot0:GetGuestEID()
	slot3 = uv1(slot0.buffList)

	Dorm.DormEntityManager.ClearAllEffectOnAttachPoint(slot2, "gua_R_hand_bone")
	Dorm.DormEntityManager.PutEntityLookAt(slot2, slot0.guestSpawnPos.position, uv2(slot0:GetPlayerEID()))
	Dorm.DormEntityManager.PlaySpacialFacileExpression(slot2, "Effect/Dorm/laugh02", 0.5)
	uv3(slot2, function ()
		Dorm.DormEntityManager.PlayEffectDetached(uv0, "gua_R_hand_bone", "Dorm/Effect/snowball/fx_snow_effect_liwu_boom", 2)
		manager.notify:Invoke(SNOWBALL_GAME_PLAYER_GET_BUFF, uv2, uv1:GetBuffDuration(uv2), uv1:GetBuffFactor(uv2))
	end)
end

function slot0.GuestLiftSign(slot0, slot1)
	slot4 = slot0:GetGuestEID()

	Dorm.DormEntityManager.PutEntityLookAt(slot4, slot0.guestSpawnPos.position, uv0(slot0:GetPlayerEID()))
	Dorm.DormEntityManager.StopAllCmd(slot4)
	Dorm.DormEntityManager.SendDoActionCMD(slot4, uv1, nil, false, 0, false)
	Dorm.DormEntityManager.ClearAllEffectOnAttachPoint(slot4, "gua_R_hand_bone")
	Dorm.DormEntityManager.PlayEffect(slot4, "gua_R_hand_bone", uv2, slot1 and "Dorm/Effect/snowball/fx_snowball_hit_sign_head_shot" or "Dorm/Effect/snowball/fx_snowball_hit_sign", 3.5)
	slot0:GuestPlaySubtitle(slot1 and "ACTIVITY_SNOWBALL_HIT_HEAD" or "ACTIVITY_SNOWBALL_HIT_BODY")
end

return slot0
