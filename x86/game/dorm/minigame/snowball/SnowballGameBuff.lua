slot0 = {
	all = {}
}

for slot5, slot6 in pairs({
	SlowdownAllTarget = 4,
	Slowdown = 6,
	AlwaysHeadShot = 3,
	FreezeNonHumanoidTarget = 2,
	FastShoot = 5,
	SpeedUp = 1,
	Freeze = 7
}) do
	table.insert(slot0.all, slot6)
end

table.sort(slot0.all)

function slot2(slot0, slot1, slot2)
	slot3.slowdownFactor = slot2 or (slot3.slowdownFactor or 1)
	slot3.speedUpFactor = slot1 or (DormUtils.GetEntityData(slot0).speedUpFactor or 1)
	slot6 = slot3.speed or defaultEntitySpeed
	slot7 = 1

	if slot2 then
		slot7 = 1 - slot2
	elseif slot1 then
		slot7 = 1 + slot1
	end

	print("SetGameEntitySpeedByScale", slot1, slot2, slot7)
	Dorm.DormEntityManager.SetEntitySpeed(slot0, slot6 * slot7)
end

slot3 = "minigame_snowball"
slot4 = "minigame_snowball_buff"
slot5 = -1

function slot6(slot0)
	manager.audio:PlayEffect("minigame_activity_2_6_snowball", slot0, "")
end

slot0.buff = {
	[slot1.SpeedUp] = {
		OnApply = function (slot0, slot1)
			uv0(slot0, slot1)
		end,
		OnRemove = function (slot0)
			uv0(slot0, 0)
		end
	},
	[slot1.FastShoot] = {
		OnApply = function (slot0, slot1)
			SnowballGameMgr.GetInstance().shootSpeedFactor = 1 + slot1
		end,
		OnRemove = function (slot0)
			SnowballGameMgr.GetInstance().shootSpeedFactor = 1
		end
	},
	[slot1.SlowdownAllTarget] = {
		OnApply = function (slot0, slot1)
			uv0("minigame_activity_2_6_snowball_wind")
			Dorm.LuaBridge.MiniGameBridge.ClearAllFullScreenEffect()
			Dorm.LuaBridge.MiniGameBridge.PlayFullScreenEffect("Dorm/Effect/snowball/fx_snow_effect_UI2", uv1)

			for slot5, slot6 in pairs(SnowballGameMgr.GetInstance().entityManager.managed) do
				uv2(slot6, nil, slot1)
			end
		end,
		OnRemove = function (slot0)
			Dorm.LuaBridge.MiniGameBridge.ClearAllFullScreenEffect()

			for slot4, slot5 in pairs(SnowballGameMgr.GetInstance().entityManager.managed) do
				uv0(slot5, nil, 0)
			end
		end,
		OnExtended = function (slot0)
			uv0("minigame_activity_2_6_snowball_wind")
			Dorm.LuaBridge.MiniGameBridge.ClearAllFullScreenEffect()
			Dorm.LuaBridge.MiniGameBridge.PlayFullScreenEffect("Dorm/Effect/snowball/fx_snow_effect_UI2", uv1)
		end
	},
	[slot1.FreezeNonHumanoidTarget] = {
		OnApply = function ()
			uv0("minigame_activity_2_6_snowball_freeze")
			Dorm.LuaBridge.MiniGameBridge.ClearAllFullScreenEffect()
			Dorm.LuaBridge.MiniGameBridge.PlayFullScreenEffect("Dorm/Effect/snowball/fx_snow_effect_UI1", uv1)

			SnowballGameTargetAI.GetInstance().pauseNonHumanoid = true
		end,
		OnRemove = function (slot0)
			Dorm.LuaBridge.MiniGameBridge.ClearAllFullScreenEffect()

			SnowballGameTargetAI.GetInstance().pauseNonHumanoid = false
		end,
		OnExtended = function (slot0)
			uv0("minigame_activity_2_6_snowball_freeze")
			Dorm.LuaBridge.MiniGameBridge.ClearAllFullScreenEffect()
			Dorm.LuaBridge.MiniGameBridge.PlayFullScreenEffect("Dorm/Effect/snowball/fx_snow_effect_UI1", uv1)
		end
	},
	[slot1.AlwaysHeadShot] = {
		OnApply = function ()
			SnowballGameMgr.GetInstance().lockHeadShot = true
		end,
		OnRemove = function ()
			SnowballGameMgr.GetInstance().lockHeadShot = false
		end
	},
	[slot1.Slowdown] = {
		IsDebuff = true,
		WillOverride = function (slot0)
			return slot0 == uv0.Freeze
		end,
		OnApply = function (slot0, slot1)
			uv0("minigame_activity_2_6_snowball_debuff01")

			slot2 = SnowballGameMgr.GetInstance()

			Dorm.DormEntityManager.PlayEffect(slot0, "root", uv1, "Dorm/Effect/snowball/fx_snow_effect_debuff_slow", uv2)
			Dorm.DormEntityManager.PlayEffect(slot0, "root", uv1, "Dorm/Effect/snowball/fx_snow_effect_dust", uv2)
			uv3(slot0, nil, slot1)
		end,
		OnRemove = function (slot0)
			slot1 = SnowballGameMgr.GetInstance()

			Dorm.DormEntityManager.ClearAllEffect(slot0, uv0)
			Dorm.DormEntityManager.PlayEffect(slot0, "root", uv0, "Dorm/Effect/snowball/fx_snow_effect_debuff_slow2", 1)
			uv1(slot0, nil, 0)
		end,
		OnExtended = function (slot0)
			uv0("minigame_activity_2_6_snowball_debuff01")
		end
	},
	[slot1.Freeze] = {
		IsDebuff = true,
		WillOverride = function (slot0)
			return slot0 == uv0.Slowdown
		end,
		OnApply = function (slot0)
			uv0("minigame_activity_2_6_snowball_debuff02")
			Dorm.DormEntityManager.SetFadeCMD(slot0, 0)
			Dorm.DormEntityManager.PlayEffect(slot0, "root", uv1, "Dorm/Effect/snowball/fx_snow_effect_debuff_freeze", uv2)
			Dorm.DormEntityManager.SetEntityMobility(slot0, false)
			Dorm.DormEntityManager.ClearAllEffect(slot0, uv3)
		end,
		OnRemove = function (slot0)
			uv0("minigame_activity_2_6_snowball_debuff02_off")
			Dorm.DormEntityManager.ClearAllEffect(slot0, uv1)
			Dorm.DormEntityManager.PlayEffect(slot0, "root", uv1, "Dorm/Effect/snowball/fx_snow_effect_debuff_freeze2", 1)
			Dorm.DormEntityManager.SetFadeCMD(slot0, 1)
			Dorm.DormEntityManager.SetEntityMobility(slot0, true)
			SnowballGameMgr.CreateHoldSnowballVfx(slot0)
		end,
		OnExtended = function (slot0)
			uv0("minigame_activity_2_6_snowball_debuff02")
		end
	}
}
slot0.buffType = slot1

return slot0
