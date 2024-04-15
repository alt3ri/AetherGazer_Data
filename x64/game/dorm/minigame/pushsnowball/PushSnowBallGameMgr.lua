slot0 = singletonClass("PushSnowballGameMgr")

function slot1(slot0)
	return slot0.model
end

function slot2(slot0)
	return slot0.spawnAt
end

function slot3(slot0)
	return BackHomeHeroSkinCfg[slot0]
end

slot4 = "minigame_snowball"

function slot0.Ctor(slot0)
	slot0.playerManager = EntityManager.New(EntityManager.CreatePlayer.New(uv0, uv1))

	function slot0.playerManager.OnRemove(slot0, slot1)
		manager.notify:Invoke(DORM_CHARACTER_DISPOSE, slot1)
	end

	slot0.managers = {
		slot0.playerManager
	}
	slot0.listener = EventListener.New()
end

function slot0.Init(slot0)
	slot0.listener:Register(DORM_CLICK_ENTITY, handler(slot0, slot0.OnClickEntity))
end

function slot0.Dispose(slot0)
	slot0.listener:RemoveAll()
	slot0.playerManager:Clear(true)
end

slot5 = -1

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
		model = "CharDorm/" .. slot3.model,
		spawnAt = slot0.playerSpawnPos
	}, {
		type = "player",
		cfgID = slot3.id
	}), UnityEngine.Camera.main and slot5.transform.forward or Vector3(0, 0, -1))
	Dorm.LuaBridge.MiniGameBridge.PlayEffect(Dorm.DormEntityManager.QueryPosition(slot4), Quaternion.Euler(0, 0, 0), Vector3(0.1, 0.1, 0.1), "Effect/tongyong/fx_appear_UI", 1)
end

function slot0.GetPlayerEID(slot0)
	return slot0.playerManager:GetEntityID(uv0)
end

function slot0.GetPlayerCfgID(slot0)
	return slot0.player
end

function slot0.ClearVfxOnEntity(slot0)
	Dorm.DormEntityManager.ClearAllEffect(slot0, uv0)
end

return slot0
