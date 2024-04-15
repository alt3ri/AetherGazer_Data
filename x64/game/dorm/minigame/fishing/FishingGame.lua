slot0 = class("FishingGame")
slot1, slot2, slot3 = unpack(nullable(GameDisplayCfg.activity_kagutsuchi_fish_qte_anime, "value") or {
	"fishing_start",
	"fishing_bite",
	"fishing_finish"
})
slot4 = "fishingMinigame"
slot5 = "fishing"
slot6 = 1
slot7 = 2
slot8 = 3
slot9 = 4
slot10 = Dorm.DormEntityManager

function slot11(slot0)
	return slot0.model
end

function slot12(slot0)
	return Dorm.storage:GetData("fishing.pos." .. slot0.spawnAt, 1).transform
end

function slot0.Ctor(slot0)
	slot0.entityManager = EntityManager.New(EntityManager.CreateModel.New(uv0, uv1))
	slot0.listener = EventListener.New()
end

function slot0.Init(slot0)
	slot0.character = slot0.entityManager:Create(uv0, {
		model = "CharDorm/activity/fishing/9158_tpose",
		complex = true,
		spawnAt = "player"
	})

	uv1.ResetAnime(slot0.character)
	slot0.listener:Register(KAGUTSUCHI_FISHING_EVENT_GAME_START, handler(slot0, slot0.PlayStartAnimeAndWaitQte))
	slot0.listener:Register(KAGUTSUCHI_FISHING_EVENT_QTE_FINISH, handler(slot0, slot0.PlayEndAnimeAndWait))
end

function slot0.ResetAnime(slot0)
	uv0.StopAllCmd(slot0)
end

function slot0.PlayStartAnimeAndWaitQte(slot0)
	slot0.listener:Remove(ON_DORM_CHARACTER_WAIT_CMD)
	slot0.listener:Remove(KAGUTSUCHI_FISHING_EVENT_QTE_START)
	uv0.ResetAnime(slot0.character)

	if slot0.pole == nil then
		slot0.pole = slot0.entityManager:Create(uv1, {
			spawnAt = "player",
			pooled = true,
			model = "CharDorm/prop/diaoyugan",
			complex = true
		})
	end

	uv0.ResetAnime(slot0.pole)
	uv2.AttachToEntityCMD(slot0.pole, slot0.character, "gua_L_hand_bone")

	if slot0.float == nil then
		slot0.float = slot0.entityManager:Create(uv3, {
			spawnAt = "player",
			pooled = true,
			model = "CharDorm/prop/fupiao",
			complex = true
		})
	end

	uv0.ResetAnime(slot0.float)

	if slot0.fish == nil then
		slot0.fish = slot0.entityManager:Create(uv4, {
			spawnAt = "fish",
			pooled = false,
			model = "CharDorm/prop/fish",
			complex = true
		})
	end

	uv0.ResetAnime(slot0.fish)
	uv2.SendDoActionCMD(slot0.fish, "fishing_born", true)
	uv2.SendDoActionCMD(slot0.character, uv5, true)
	uv2.SendDoActionCMD(slot0.pole, uv5, true)
	uv2.SendDoActionCMD(slot0.float, uv5, true)
	uv2.ChangeEntityAnimeScheme(slot0.character, uv6)
	slot0.listener:Register(KAGUTSUCHI_FISHING_EVENT_QTE_START, function ()
		uv0.listener:Remove(KAGUTSUCHI_FISHING_EVENT_QTE_START)
		uv0:PlayQteAnimeAndWaitFinish()
	end)
end

function slot0.PlayQteAnimeAndWaitFinish(slot0)
	slot0.fishBite = true

	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_fish_loop", "")
	uv0.ResetAnime(slot0.character)
	uv0.ResetAnime(slot0.pole)
	uv0.ResetAnime(slot0.float)
	uv0.ResetAnime(slot0.fish)
	uv1.SendDoActionCMD(slot0.character, uv2, nil, true, false)
	uv1.SendDoActionCMD(slot0.pole, uv2, nil, true, false)
	uv1.SendDoActionCMD(slot0.float, uv2, nil, true, false)
	uv1.SendDoActionCMD(slot0.fish, uv2, nil, true, false)
end

function slot0.PlayEndAnimeAndWait(slot0, slot1, slot2)
	uv0.ResetAnime(slot0.character)
	uv0.ResetAnime(slot0.pole)
	uv0.ResetAnime(slot0.float)
	uv0.ResetAnime(slot0.fish)
	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_fish_end" .. (slot2 and "01" or "02"), "")
	uv1.RestoreEntityAnimeScheme(slot0.character)
	uv1.SendDoActionCMD(slot0.character, uv2, false)
	uv1.SendDoActionCMD(slot0.pole, uv2, false)
	uv1.SendDoActionCMD(slot0.float, uv2, false)

	if slot0.fishBite then
		uv1.SendDoActionCMD(slot0.fish, uv2, false)
	else
		slot0.entityManager:Remove(uv3)

		slot0.fish = nil
	end

	slot0.fishBite = false

	slot0.listener:Register(ON_DORM_CHARACTER_WAIT_CMD, function (slot0)
		if slot0 ~= uv0.character then
			return
		end

		uv0.listener:Remove(ON_DORM_CHARACTER_WAIT_CMD)
		uv0.entityManager:Remove(uv1)
		uv0.entityManager:Remove(uv2)

		uv0.pole = nil
		uv0.float = nil

		if uv0.fish then
			uv0.entityManager:Remove(uv3)

			uv0.fish = nil
		end
	end)
end

function slot0.Dispose(slot0)
	slot0.character = nil
	slot0.pole = nil
	slot0.float = nil
	slot0.fish = nil

	slot0.entityManager:Clear()
	slot0.listener:RemoveAll()
end

return slot0
