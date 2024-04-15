slot0 = singletonClass("DormCharacterManager")
slot2 = function (slot0)
	return function (slot0)
		return "CharDorm/" .. nullable(uv0, nullable(slot0, "heroSkinID"), "model")
	end
end(BackHomeHeroSkinCfg)
slot3 = 1.25
slot4 = DormEnum.CharacterType.DormNormalHero

function slot0.Ctor(slot0)
	slot0.listener = EventListener.New()
	slot2 = EntityManager.New(EntityManager.CreatePlayer.New(uv0))

	function slot2.OnCreate(slot0, slot1, slot2)
		Dorm.DormEntityManager.SetDefaultMouth(slot1, nullable(BackHomeHeroSkinCfg, nullable(slot2, "heroSkinID"), "default_mouth") or 0)

		if not slot2.skipFade then
			Dorm.DormEntityManager.StartFadeInCMD(slot1, uv0, function ()
				DormUtils.ShowCharaSpecialVfx(uv0, Dorm.charaVfxActiveType)
			end)
		else
			DormUtils.ShowCharaSpecialVfx(slot1, Dorm.charaVfxActiveType)
		end

		uv1:RecordEntityInfo(slot1, slot2)
		uv1.dormHeroAI:AddCharacterAI(slot1)
	end

	function slot2.OnRemove(slot0, slot1)
		uv0.dormHeroAI:RemoveCharacterAI(slot1)
		uv0:RemoveEntityInfo(slot1)
		manager.notify:Invoke(DORM_CHARACTER_DISPOSE, slot1, uv1)
	end

	slot0.entityManager = slot2
end

function slot0.RecordEntityInfo(slot0, slot1, slot2)
	Dorm.storage:RecordData(DormEnum.Namespace.EntityType, slot1, uv0)
end

function slot0.RemoveEntityInfo(slot0, slot1)
	Dorm.storage:RecordData(DormEnum.Namespace.EntityType, slot1, nil)
	slot0:OnCharaGrabReleased(slot1)
end

function slot0.Init(slot0)
	slot0:RegisterEvent()

	slot0.dormHeroAI = DormHeroAI.GetInstance()

	slot0.dormHeroAI:Init()
	slot0.entityManager:Clear()
	slot0.entityManager:MapToDormStorageData(DormUtils.EIdNamespace(uv0), DormUtils.IdxNamespace(uv0))
end

function slot0.Reset(slot0)
	slot0:RemoveEvent()
	slot0.dormHeroAI:Dispose()
	slot0:Clear()
end

function slot0.RegisterEvent(slot0)
	slot0.listener:Register(ON_DORM_CHARACTER_GRAB_STARTED, handler(slot0, slot0.OnCharaGrabStart))
	slot0.listener:Register(ON_DORM_CHARACTER_GRAB_RELEASED, handler(slot0, slot0.OnCharaGrabReleased))
end

function slot0.RemoveEvent(slot0)
	slot0.listener:RemoveAll()
end

function slot0.OnBeginStory(slot0, slot1)
	if DormEnum.HasFlag(slot1, DormEnum.BeginStoryFlag.HideCharacter) then
		slot0:Clear()
	end
end

function slot0.OnFinishStory(slot0, slot1)
	if DormEnum.HasFlag(slot1, DormEnum.BeginStoryFlag.HideCharacter) then
		DormHeroTools:GenerateHeroWhenEnterScene()
	end
end

function slot0.Generate(slot0, slot1, slot2)
	slot3, slot4 = slot0.entityManager:Update(slot1, {
		heroSkinID = slot1,
		skipFade = slot2
	}, {
		cfgID = slot1,
		heroID = nullable(BackHomeHeroSkinCfg, slot1, "hero_id")
	})

	Dorm.DormEntityManager.SetEntitySpeed(slot3, 0.5)

	return slot3, slot4
end

function slot0.Remove(slot0, slot1)
	return slot0.entityManager:Remove(slot1)
end

function slot0.Clear(slot0)
	slot0.entityManager:Clear()
end

function slot0.FindAndRemove(slot0)
	EntityManager.FindAndRemoveEntity({
		uv0.GetInstance().entityManager
	}, slot0)
end

slot0.curGrabbingInfoNamespace = "dorm.curGrabbing"

function slot0.OnCharaGrabStart(slot0, slot1)
	slot2 = uv0.curGrabbingInfoNamespace

	Dorm.storage:RecordData(slot2, "eid", slot1)
	manager.notify:Invoke(DORM_CUR_GRABBING_CHARACTER_CHANGE, Dorm.storage:GetData(slot2, "eid"), slot1)
end

function slot0.OnCharaGrabReleased(slot0, slot1)
	if Dorm.storage:GetData(uv0.curGrabbingInfoNamespace, "eid") == slot1 then
		Dorm.storage:RecordData(slot2, "eid", nil)
		manager.notify:Invoke(DORM_CUR_GRABBING_CHARACTER_CHANGE, slot1, nil)
	end
end

function slot0.GetCharacterNum(slot0)
	return slot0.entityManager.managedEntityNum
end

return slot0
