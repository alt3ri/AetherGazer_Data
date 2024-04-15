function slot1(slot0, slot1, slot2)
	slot3 = nil

	return slot0[slot2 and slot0.Length - slot1 or slot1 - 1]
end

slot2 = {
	DormEnum.SpecialVfx.Hungry,
	DormEnum.SpecialVfx.Tired
}
slot3 = {
	[DormEnum.SpecialVfx.Hungry] = {
		attachPoint = "gua_Hp",
		duration = -1,
		path = "Dorm/Effect/houzhai/fx_HZ04_hungry"
	},
	[DormEnum.SpecialVfx.Tired] = {
		attachPoint = "root",
		duration = -1,
		path = "Dorm/Effect/houzhai/fx_nengliang"
	}
}
slot4 = DormEnum.Namespace.HeroShowSpecialVfx
slot5 = {
	[DormEnum.SpecialVfx.Hungry] = function (slot0)
		return not DormVisitTools:CheckCurIsVisitRoom() and DormHeroTools:CheckFeedTime(slot0) and not DormHeroTools:CheckDormFatigueLevel(slot0)
	end,
	[DormEnum.SpecialVfx.Tired] = function (slot0)
		return not DormVisitTools:CheckCurIsVisitRoom() and not DormHeroTools:CheckCanteenFatigueLevel(slot0)
	end
}

function slot6(slot0)
	slot1 = uv0.GetEntityData(slot0)
	slot2 = slot1.cfgID

	if slot1.heroID == nil then
		return
	end

	if Dorm.storage:GetData(uv1, slot3) == nil then
		slot4 = {
			vfxStatus = {}
		}

		if Dorm.charaVfxActiveType then
			for slot8, slot9 in ipairs(Dorm.charaVfxActiveType) do
				slot4.vfxStatus[slot9] = uv2[slot9] and slot10(slot3)
			end
		end

		Dorm.storage:RecordData(uv1, slot3, slot4)
	end

	return slot4
end

slot7 = "status"

return {
	EIdNamespace = function (slot0)
		return "entity." .. slot0 .. ".eid"
	end,
	IdxNamespace = function (slot0)
		return "entity." .. slot0 .. ".idx"
	end,
	GetEntityData = function (slot0)
		return Dorm.storage:GetData(DormEnum.Namespace.EntityData, slot0)
	end,
	EnumerateInteractEntities = function (slot0)
		return pairs(nullable(DormUtils.GetEntityData(slot0), "interactEntities") or {})
	end,
	CallOnNextUpdate = function (slot0)
		DormCharacterActionManager.taskRunner:NewTimer(slot0, 0):Start()
	end,
	MapSceneItemTagInfo = function ()
		for slot3, slot4 in pairs(Dorm.sceneItemInfo) do
			Dorm.storage:MapToData(slot3, slot4)
		end
	end,
	SetEntityInteractContext = function (slot0, slot1)
		uv0.GetEntityData(slot0).interactCtx = slot1
	end,
	MoveByPath = function (slot0, slot1, slot2, slot3)
		if slot2 then
			Dorm.DormEntityManager.PutEntityAt(slot0, uv0(slot1, 1, slot3))

			slot4 = 2
		end

		for slot8 = slot4, slot1.Length do
			Dorm.DormEntityManager.SendMoveCMD(slot0, uv0(slot1, slot8, slot3), true, true)
		end
	end,
	ShowCharaSpecialVfx = function (slot0, slot1)
		if slot1 == nil then
			return
		end

		if next(slot1) then
			if uv0(slot0).hideVfx then
				slot2.hideVfx = slot2.hideVfx - 1

				if slot2.hideVfx == 0 then
					slot2.hideVfx = nil
				end
			end

			for slot6, slot7 in ipairs(slot1) do
				if uv1[slot7] and slot2.vfxStatus[slot7] and not slot2.hideVfx then
					Dorm.DormEntityManager.PlayEffect(slot0, slot8.attachPoint, uv2, slot8.path, slot8.duration)

					return
				end
			end
		end
	end,
	ResetCharaSpecialVfx = function (slot0)
		if nullable(uv0(slot0), "hideVfx") then
			slot1.hideVfx = nil

			uv1.ShowCharaSpecialVfx(slot0, Dorm.charaVfxActiveType)
		end
	end,
	HideCharaSpecialVfx = function (slot0)
		if uv0(slot0) then
			slot1.hideVfx = (slot1.hideVfx or 0) + 1
		end

		Dorm.DormEntityManager.ClearAllEffect(slot0, uv1)
	end,
	ClearCharaHasSpecialVfx = function (slot0)
		if uv0(slot0).vfxStatus then
			for slot5, slot6 in ipairs(uv1) do
				slot1[slot6] = false
			end
		end
	end,
	ClearSingleSpecialVfx = function (slot0, slot1)
		if uv0(slot0).vfxStatus then
			for slot6, slot7 in ipairs(uv1) do
				if slot7 == slot1 then
					slot2[slot7] = false
				end
			end
		end
	end,
	CharaVfxEnabled = function ()
		return Dorm.charaVfxActiveType and next(Dorm.charaVfxActiveType)
	end
}
