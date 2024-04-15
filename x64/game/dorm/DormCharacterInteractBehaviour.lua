slot1 = {
	AnyPeer = 2,
	Source = 0,
	Target = 1
}

function slot2(slot0, slot1)
	if slot0 == uv0.Source then
		return slot1.entityID
	elseif slot0 == uv0.Target then
		return slot1.targetID
	elseif slot1.peerIDs and #slot1.peerIDs > 0 then
		return slot1.peerIDs[math.random(#slot1.peerIDs)]
	end

	return nil
end

slot3 = {
	play = function (slot0, slot1)
		Dorm.DormEntityManager.PlayAnimeDuringInteract(uv0(slot0.entity, slot1), slot0.animeActionName, slot0.animeActionSubName, slot0.crossFade)
	end,
	putAt = function (slot0, slot1)
		Dorm.DormEntityManager.PutEntityAt(uv0(slot0.entity, slot1), uv0(slot0.referenceTarget, slot1), slot0.referencePointName)
	end,
	attachTo = function (slot0, slot1)
		Dorm.DormEntityManager.AttachToEntityCMD(uv0(slot0.itemEntity, slot1), uv0(slot0.attachTo, slot1), slot0.attachPoint)
	end,
	detachFrom = function (slot0, slot1)
		Dorm.DormEntityManager.DetachFromEntityCMD(uv0(slot0.itemEntity, slot1), slot0.resetFacingDirection)
	end,
	grabPart = function (slot0, slot1)
		Dorm.DormEntityManager.GrabItemPartCMD(uv0(slot0.grabBy, slot1), uv0(slot0.grabFrom, slot1), slot0.itemPartName, slot0.attachPoint)
	end,
	restorePart = function (slot0, slot1)
		Dorm.DormEntityManager.RestoreItemPartCMD(uv0(slot0.itemPartHost, slot1), slot0.itemPartName)
	end,
	setPartVisible = function (slot0, slot1)
		Dorm.DormEntityManager.SetPartVisible(uv0(slot0.entity, slot1), slot0.itemPartName, slot0.visible)
	end,
	changeScheme = function (slot0, slot1)
		Dorm.DormEntityManager.ChangeEntityAnimeScheme(uv0(slot0.entity, slot1), slot0.scheme)
	end,
	setValue = function (slot0, slot1)
		Dorm.storage:GetData(DormEnum.Namespace.EntityData, uv0(slot0.entity, slot1))[slot0.field] = slot0.value
	end,
	setMobility = function (slot0, slot1)
		Dorm.DormEntityManager.SetEntityMobility(uv0(slot0.entity, slot1), slot0.value)
	end,
	setMouth = function (slot0, slot1)
		Dorm.DormEntityManager.SetFacialExpression(uv0(slot0.entity, slot1), slot0.value)
	end,
	restoreMouth = function (slot0, slot1)
		Dorm.DormEntityManager.RestoreFacialExpression(uv0(slot0.entity, slot1))
	end,
	setFace = function (slot0, slot1)
		Dorm.DormEntityManager.PlayNormalFacileExpression(uv0(slot0.entity, slot1), slot0.faceEmoteState, slot0.faceEmoteSubState, slot0.crossFade)
	end,
	keepAsInteract = function (slot0, slot1)
		Dorm.DormEntityManager.KeepAsInteractNotEnd(uv0(slot0.entity, slot1), uv0(slot0.target, slot1), slot0.value)
	end,
	setSpFace = function (slot0, slot1)
		Dorm.DormEntityManager.PlaySpacialFacileExpression(uv0(slot0.entity, slot1), slot0.faceEfxPath, slot0.duration)
	end,
	playEfx = function (slot0, slot1)
		Dorm.DormEntityManager.PlayEffect(uv0(slot0.entity, slot1), slot0.attachPoint, slot0.efxPath, slot0.offset or Vector3.zero, slot0.rotation or Quaternion.identity, slot0.scale or Vector3.one, slot0.duration)
	end,
	clearEfx = function (slot0, slot1)
		Dorm.DormEntityManager.ClearInteractEffectOnAttachPoint(uv0(slot0.entity, slot1), slot0.attachPoint)
	end,
	playVoice = function (slot0, slot1)
		manager.audio:Play(slot0.playerType, slot0.sheet, slot0.cue, slot0.awb)
	end,
	stopVoice = function (slot0, slot1)
		manager.audio:Stop(slot0.playerType)
	end,
	playSubtitle = function (slot0, slot1)
		manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, uv0(slot0.entity, slot1), slot0.subtitleID)
	end
}

function slot4(slot0)
	return Dorm.storage:GetData(DormEnum.Namespace.EntityData, slot0)
end

function slot5(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0) do
		table.insert(slot2, slot6)
	end

	table.sort(slot2, slot1)

	return slot2
end

function slot6(slot0, slot1)
	slot2 = nullable(DormUtils.GetEntityData(slot0), "interactEntities") or {}

	table.insert(slot2, slot1)

	return slot2
end

function slot7(slot0, slot1)
	if nullable(DormUtils.GetEntityData(slot0), "interactEntities") then
		for slot6 = #slot2, 1, -1 do
			if slot2[slot6] == slot1 then
				table.remove(slot2, slot6)

				break
			end
		end
	end
end

function slot8(slot0, slot1, slot2)
	Dorm.DormEntityManager.KeepAsInteractNotEnd(slot1.entityID, slot1.targetID, false)

	slot3 = slot1.entityID
	DormUtils.GetEntityData(slot3).isDuringInteract = true
	slot1.peers = uv0(slot1.targetID, slot1.entityID)

	slot0:SetCancellationSrc(function ()
		return uv0.canceled
	end)

	slot5 = slot0.onComplete

	slot0:SetOnComplete(function ()
		uv0(uv1.targetID, uv2)

		if uv1.continuous then
			Dorm.DormEntityManager.KeepAsInteractNotEnd(uv2, uv1.targetID, true)

			uv3.isDuringInteract = true
		else
			uv3.isDuringInteract = false

			DormUtils.ShowCharaSpecialVfx(uv2, Dorm.charaVfxActiveType)
			DormUtils.SetEntityInteractContext(uv2, nil)
		end

		uv4:Notify(true)

		if uv5 then
			uv5()
		end
	end)

	slot6 = slot0.onAbort

	slot0:SetOnAbort(function (slot0)
		if Dorm.DormEntityManager.IsValidEntityID(uv0) then
			DormUtils.SetEntityInteractContext(uv0, nil)

			if uv1.isDuringInteract then
				uv1.isDuringInteract = false

				DormUtils.ShowCharaSpecialVfx(uv0, Dorm.charaVfxActiveType)
			end

			uv2(uv3.targetID, uv0)
		end

		uv4:Notify(false)

		if uv5 then
			uv5()
		end
	end)
	slot0:Start(slot1.waitOneTick)

	slot1.curActionTask = slot0

	DormUtils.HideCharaSpecialVfx(slot3)

	return slot0
end

function slot9(slot0, slot1)
	if type(slot0) == "function" then
		return slot0(slot1)
	else
		return uv0.MakeInteractTask(slot0, slot1)
	end
end

return {
	DriveInteractSequenceNode = function (slot0, slot1)
		if type(slot0) == "table" then
			for slot5, slot6 in ipairs(slot0) do
				if type(slot6) == "table" then
					if uv0[slot6.action] then
						slot8(slot6, slot1)
					end
				else
					slot6(slot1)
				end
			end
		elseif type(slot0) == "function" then
			slot0(slot1)
		end
	end,
	MakeInteractTask = function (slot0, slot1, slot2)
		if slot0 then
			slot5 = slot0.keys or uv0(slot0.sequence)
			slot1.duration = slot0.duration
			slot2 = slot2 or DormCharacterActionManager.frameTaskRunner
			slot6 = slot2:NewTask({
				start = slot1.startTime or slot2:Now()
			})

			slot6:WaitUntil(function (slot0)
				slot3 = slot0.k
				slot4 = slot0.taskDataCtx.task.taskRunner:Now() - slot0.taskDataCtx.start

				while slot3 <= #uv0 and uv0[slot3] <= slot4 do
					uv2.DriveInteractSequenceNode(uv1[uv0[slot3]], uv3)

					slot3 = slot3 + 1
				end

				slot0.k = slot3
				uv3.playTime = slot4

				return slot3 > #uv0 or uv4 <= slot4
			end, false, {
				k = 1
			})
			slot6:WaitUntil(function (slot0)
				uv0.playTime = slot0.taskDataCtx.task.taskRunner:Now() - slot0.taskDataCtx.start

				return uv1 <= uv0.playTime
			end)

			if slot0.onAbort then
				slot6:SetOnAbort(function ()
					uv0.onAbort(uv1)
				end)
			end

			if slot0.onComplete then
				slot6:SetOnComplete(function ()
					uv0.playTime = uv0.duration

					uv1.onComplete(uv0)
				end)
			end

			return slot6
		end
	end,
	GetNextAction = function (slot0)
		if nullable(DormInteractSequence, slot0, "next_action") and next(slot1) then
			slot2 = slot1[math.random(#slot1)]

			return true, nullable(slot2, 1), nullable(slot2, 2)
		end

		return false
	end,
	MakeCtx = function (slot0, slot1, slot2)
		slot3 = slot2 or {}
		slot3.entityID = slot0
		slot3.targetID = slot1

		return slot3
	end,
	MakeDefaultCtx = function (slot0, slot1, slot2, slot3)
		slot4, slot5, slot6 = uv0.GetNextAction(slot2)
		slot7 = {
			nextAction = slot5,
			nextActionWaitTime = slot6,
			continuous = slot4
		}

		if slot3 ~= nil then
			for slot11, slot12 in pairs(slot3) do
				slot7[slot11] = slot12
			end
		end

		return uv0.MakeCtx(slot0, slot1, slot7)
	end,
	MakeCtxForInternalAction = function (slot0, slot1, slot2, slot3)
		slot3 = slot3 or {}
		slot4 = nullable(uv0(slot0), "cfgID")
		slot5 = nullable(uv0(slot1), "cfgID")
		slot3.targetCfg = slot5
		slot3.entityCfg = slot4
		slot6 = uv1.GetSequence(slot4, slot5, slot2)
		slot7 = uv1.MakeCtx(slot0, slot1, slot3)
		slot7.curActionTask = uv2(slot6, slot7)

		return slot7, slot6
	end,
	ValidateAction = function (slot0, slot1, slot2)
		return uv1.GetSequence(nullable(uv0(slot0), "cfgID"), nullable(uv0(slot1), "cfgID"), nullable(DormInteractSequence, slot2, "name"))
	end,
	Interact = function (slot0, slot1, slot2, slot3)
		if not nullable(uv0(slot0).interactCtx, "curActionTask") then
			slot5 = slot5 or uv1.MakeDefaultCtx(slot0, slot1, slot3)
			slot6 = slot5.curActionTask or uv2(uv1.ValidateAction(slot0, slot1, slot3), slot5)
		end

		if slot6 then
			uv3(slot6, slot5, slot2)
		else
			slot2:Notify(false)
		end
	end,
	GetSequencePath = function (slot0, slot1, slot2, slot3)
		slot3 = slot3 or "game.dorm.interacts"

		if slot2 ~= nil then
			slot4 = {}

			if slot0 then
				if slot1 then
					table.insert(slot4, string.format("%s.%d.%d_%s", slot3, slot0, slot1, slot2))
				end

				slot6 = slot0
				slot7 = nil

				if BackHomeHeroSkinCfg[slot0] then
					slot7 = slot5.style
					slot6 = slot5.hero_id
				end

				table.insert(slot4, string.format("%s.%d.%s", slot3, slot0, slot2))
				table.insert(slot4, string.format("%s.%d.%s", slot3, slot6, slot2))

				if slot7 then
					table.insert(slot4, string.format("%s.%s.%s", slot3, slot7, slot2))
				end
			end

			table.insert(slot4, string.format("%s.%s", slot3, slot2))

			return slot4
		end
	end,
	GetSequenceGroup = function (slot0, slot1, slot2, slot3, slot4)
		slot4 = slot4 or Dorm.InteractionGrouping

		if uv0.GetSequencePath(slot0, slot1, slot2, slot3) then
			for slot9, slot10 in ipairs(slot5) do
				if slot4[slot10] then
					return slot11
				end
			end
		end
	end,
	GetSequence = function (slot0, slot1, slot2, slot3, slot4)
		slot4 = slot4 or Dorm.InteractionGrouping

		if uv0.GetSequencePath(slot0, slot1, slot2, slot3) then
			for slot9, slot10 in ipairs(slot5) do
				if package.loaded[slot10] == nil and slot4[slot10] then
					slot11 = slot12[math.random(#slot12)]
				end

				if slot11 then
					return slot11
				end
			end
		end
	end,
	Init = function (slot0)
		manager.notify:RegistListener(ON_DORM_CHARACTER_INTERACT, slot0.Interact)
		manager.notify:RegistListener(ON_DORM_CHARACTER_GRAB_STARTED, slot0.OnCharaGrab)
		manager.notify:RegistListener(ON_DORM_CHARACTER_INTERACT_ABORTED, slot0.OnInteractAborted)
	end,
	Reset = function (slot0)
		manager.notify:RemoveListener(ON_DORM_CHARACTER_INTERACT, slot0.Interact)
		manager.notify:RemoveListener(ON_DORM_CHARACTER_GRAB_STARTED, slot0.OnCharaGrab)
		manager.notify:RemoveListener(ON_DORM_CHARACTER_INTERACT_ABORTED, slot0.OnInteractAborted)
	end,
	OnCharaGrab = function (slot0)
		if DormUtils.GetEntityData(slot0).isDuringInteract then
			DormUtils.ShowCharaSpecialVfx(slot0, Dorm.charaVfxActiveType)

			slot1.isDuringInteract = false
		end
	end,
	OnInteractAborted = function (slot0, slot1)
		if DormUtils.GetEntityData(slot0) == nil then
			return
		end

		if nullable(slot2, "interactCtx", "curActionTask") then
			slot3:Abort()
		end

		DormUtils.SetEntityInteractContext(slot0, nil)
	end
}
