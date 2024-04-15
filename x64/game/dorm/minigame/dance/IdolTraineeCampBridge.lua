function slot1(slot0)
	return "CharDorm/idolCamp/" .. BackHomeHeroSkinCfg[DormHeroTools:GetCurSkinID(slot0)].model
end

function slot2(slot0)
	return uv0(slot0.heroID)
end

function slot3(slot0)
	if slot0.spawnAt == nil then
		return nil
	end

	return nullable(Dorm.storage:PickData("idol.camp.pos." .. slot0.spawnAt), "transform")
end

slot4 = {
	"pos1",
	"pos2",
	"pos3",
	"pos4",
	"pos5"
}

return {
	Enter = function (slot0)
		slot0.listener = EventListener.New()

		slot0.listener:Register(ON_FINISH_STORY, uv0.OnFinishStory)
		slot0.listener:Register(IDOL_TRAINEE_TRAIN_HERO_PROPERTY_CALLBACK, uv0.OnTrainingStart)

		uv0.cinemachineBrain = manager.ui.mainCamera:GetComponent("CinemachineBrain")
		uv0.cinemachineBrain.enabled = true
		uv0.cinemachineBrain.m_DefaultBlend = DanceGameController.cut
		uv0.cinemachineBrain.m_CustomBlends = Asset.Load("IdolTrainee/Camp/VCamBlendSetting")
		uv0.camera = {}
		slot3 = Dorm.storage
		slot5 = slot3

		for slot5 = 1, nullable(slot3.PickData(slot5, "idol.camp.camera"), "gameObject").transform.childCount do
			slot6 = slot1.transform:GetChild(slot5 - 1)
			uv0.camera[slot6.gameObject.name] = slot6.gameObject
		end

		slot2 = EntityManager.CreateModel.New(uv1, uv2)
		uv0.entityManager = EntityManager.New(slot2)

		function uv0.entityManager.OnCreate(slot0, slot1)
			DanceGameController.InitCampEntity(slot1)
		end

		function uv0.entityManager.OnRemove(slot0, slot1)
			if table.keyof(uv0.charaAtPos, slot1) then
				uv0.charaAtPos[slot2] = nil
			end
		end

		uv0.trainerEntityManager = EntityManager.New(slot2)

		gameContext:Go("idolTraineeCamp")

		uv0.walls = {}
		slot6 = "idol.camp.wall"
		slot7 = pairs

		for slot6, slot7 in Dorm.storage:ForeachData(slot6, slot7) do
			table.insert(uv0.walls, slot7.transform:GetComponent("Collider"))
		end

		uv0.charaAtPos = {}

		uv0.RefreshCharacterAtPos(true)
		uv0.GenerateAttackHero()
		manager.windowBar:SetWhereTag("danceGame")
	end,
	RefreshCharacterAtPos = function (slot0)
		slot1 = {
			[slot5] = slot6
		}

		for slot5, slot6 in pairs(uv0.charaAtPos) do
			-- Nothing
		end

		for slot6, slot7 in pairs(IdolTraineeData:GetHeroPosList()) do
			if slot0 or uv0.GetCharacterHeroID(uv0.charaAtPos[slot6]) ~= slot7 then
				uv0.SetPosOfCharacter(uv0.GenCharacter(slot7, slot6), slot6)
			end

			slot1[slot6] = nil
		end

		for slot6, slot7 in pairs(slot1) do
			uv0.RemoveEntity(slot7)
		end
	end,
	GenerateAttackHero = function (slot0)
		if not slot0 then
			slot1, slot0 = IdolTraineeData:GetCurAttackHeroInfo()
		end

		uv0.SetTrainingCharacter(slot0)
	end,
	Exit = function (slot0)
		uv0.entityManager:Clear()
		uv0.trainerEntityManager:Clear()

		uv0.entityManager = nil
		uv0.trainerEntityManager = nil
		uv0.cinemachineBrain = nil
		uv0.camera = nil
		uv0.walls = nil
		uv0.charaAtPos = nil

		slot0.listener:RemoveAll()

		slot0.listener = nil
	end,
	GenCharacter = function (slot0, slot1)
		if uv0.entityManager then
			slot2 = DormData:GetHeroArchiveID(slot0)

			return uv0.entityManager:Update(slot2, {
				complex = true,
				heroID = slot0,
				archiveID = slot2,
				spawnAt = slot1
			})
		end
	end,
	RemoveEntity = function (slot0)
		if uv0.entityManager and slot1:Find(slot0) then
			slot1:Remove(slot2)
		end
	end,
	GetCharacterHeroID = function (slot0)
		return nullable(DormUtils.GetEntityData(slot0), "heroID")
	end,
	GetCharacterArchiveID = function (slot0)
		return nullable(DormUtils.GetEntityData(slot0), "archiveID")
	end,
	SetPosOfCharacter = function (slot0, slot1)
		if uv0.charaAtPos[slot1] then
			uv0.entityManager:Remove(uv0.GetCharacterArchiveID(slot2))
			DormData:GetHeroTemplateInfo(uv0.GetCharacterHeroID(slot2)):GoToDance(nil)
		end

		uv0.charaAtPos[slot1] = slot0
		DormUtils.GetEntityData(slot0).pos = slot1

		if slot0 and Dorm.DormEntityManager.IsValidEntityID(slot0) then
			Dorm.DormEntityManager.ChangeEntityAnimeScheme(slot0, uv1[slot1])
			Dorm.DormEntityManager.SetNextIdleNoCrossFade(slot0, true)
			Dorm.DormEntityManager.StopAllCmd(slot0)
		end

		DormData:GetHeroTemplateInfo(uv0.GetCharacterHeroID(slot0)):GoToDance(slot1)
	end,
	GetPosByCharacter = function (slot0)
		return nullable(DormUtils.GetEntityData(slot0), "pos")
	end,
	SetTrainingCharacter = function (slot0)
		if uv0.trainerEntityManager then
			return uv0.trainerEntityManager:Update(1, {
				complex = true,
				spawnAt = "training",
				heroID = slot0,
				archiveID = DormData:GetHeroArchiveID(slot0)
			})
		end
	end,
	RemoveTrainingCharacter = function ()
		if uv0.trainerEntityManager then
			uv0.trainerEntityManager:Clear()
		end
	end,
	SetVCamActive = function (slot0, slot1)
		SetActive(uv0.camera[slot0], slot1)
	end,
	OnFinishStory = function ()
		Dorm.LuaBridge.MiniGameBridge.StopStory(true)

		if uv0.OnFinishStoryCallback then
			uv0.OnFinishStoryCallback()

			uv0.OnFinishStoryCallback = nil
		end
	end,
	OnTrainingStart = function (slot0, slot1)
		slot3 = nullable(GameDisplayCfg, string.format("dorm_idol_train_prefab_type%02d", slot1), "value")

		Dorm.LuaBridge.MiniGameBridge.PlayStory(slot3[math.random(#slot3)], {
			slot0
		}, {
			uv0(slot0)
		}, false)
	end
}
