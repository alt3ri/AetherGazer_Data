slot0 = class("BarbuceGame")

function slot1(slot0)
	return slot0.model
end

function slot2(slot0)
	return slot0.spawnAt
end

function slot0.Ctor(slot0, slot1)
	slot2 = SPHeroChallengeData:GetActivityID()
	slot0.gameFinish = slot1
	slot0.playerManager = EntityManager.New(EntityManager.CreatePlayer.New(uv0, uv1))

	function slot0.playerManager.OnRemove(slot0, slot1)
		manager.notify:Invoke(DORM_CHARACTER_DISPOSE, slot1)
	end

	slot0.managers = {
		slot0.playerManager
	}
	slot0.player = slot0.playerManager:Create(1, {
		complex = true,
		model = "CharDorm/activity/Barbuce/" .. ActivityHeroChallengeCfg[slot2].hero_prefab_id,
		spawnAt = Dorm.storage:PickData("barbuce.spawn.player").transform
	}, {
		type = "player",
		cfgID = ActivityHeroChallengeCfg[slot2].hero_id or 1084
	})
	slot0.brickItem = Dorm.DormEntityManager.Instance:SpawnEntity("CharDorm/prop/kaoroujia", Dorm.storage:PickData("barbuce.spawn.player").transform, false, true)
	slot0.brickItemSucess = GameObject.Find("kaorou_success"):GetComponent("PlayableDirector")
	slot0.brickItemFaile = GameObject.Find("kaorou_fail"):GetComponent("PlayableDirector")

	Dorm.DormEntityManager.PlayAnimeDuringInteract(slot0.brickItem, "barbecue_start")
	Dorm.DormEntityManager.PlayAnimeDuringInteract(slot0.player, "barbecue_start")
end

slot3 = "barbecue_successed"
slot4 = "barbecue_failed"

function slot5(slot0)
	slot1 = DormCharacterActionManager.taskRunner:NewTask()

	slot1:Then(function ()
	end):WaitUntil(function (slot0)
		slot1, slot0.taskDataCtx.result = uv0.gameFinish()

		if slot1 then
			-- Nothing
		end

		return slot1
	end):Then(function (slot0)
		slot2 = slot0.taskDataCtx.result and uv0 or uv1

		if slot1 then
			uv2.brickItemSucess:Play()
		else
			uv2.brickItemFaile:Play()
		end

		Dorm.DormEntityManager.PlayAnimeDuringInteract(uv2.brickItem, slot2)
		Dorm.DormEntityManager.PlayAnimeDuringInteract(uv2.player, slot2)
	end):WaitUntil(function (slot0)
		if slot0.taskDataCtx.finish == true or uv0.gameTask:IsFinished() then
			slot0.taskDataCtx = nil
			uv0.gameTask = nil

			return true
		end
	end)

	return slot1
end

function slot0.StopPlayable(slot0)
	slot0.brickItemSucess:Stop()

	slot0.brickItemSucess.time = 0

	slot0.brickItemSucess:Evaluate()
	slot0.brickItemFaile:Stop()

	slot0.brickItemFaile.time = 0

	slot0.brickItemFaile:Evaluate()
end

function slot0.Start(slot0)
	if slot0.gameTask then
		slot0.gameTask:Abort()
	end

	slot1 = uv0(slot0)

	slot1:SetOnComplete(function ()
		uv0:StopPlayable()
		Dorm.DormEntityManager.PlayAnimeDuringInteract(uv0.brickItem, "barbecue_start")
		Dorm.DormEntityManager.PlayAnimeDuringInteract(uv0.player, "barbecue_start")
	end)
	slot1:SetOnAbort(function ()
		uv0:StopPlayable()
	end)

	slot0.gameTask = slot1

	slot0.gameTask:Start()
end

function slot0.PlayStartAnim(slot0)
	slot0:StopPlayable()
	Dorm.DormEntityManager.PlayAnimeDuringInteract(slot0.brickItem, "barbecue_start")
	Dorm.DormEntityManager.PlayAnimeDuringInteract(slot0.player, "barbecue_start")
end

function slot0.OnQte(slot0, slot1)
end

function slot0.Abort(slot0)
	if slot0.gameTask then
		slot0.gameTask:Abort()

		slot0.gameTask = nil
	end
end

return slot0
