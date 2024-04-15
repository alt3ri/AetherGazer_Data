slot1 = class("ReserveGuildActivityTemplate", import("game.reserve.template.ReserveBaseTemplate"))

function slot1.FilterInvalidTeamData(slot0, slot1, slot2)
	uv0.super.FilterInvalidTeamData(slot0, slot1, slot2)

	slot3 = nil
	slot3 = (slot1.stageType ~= BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY or GuildActivityData:GetFightHeroList()) and GuildActivitySPData:GetFightHeroList()

	for slot7, slot8 in ipairs(slot2.resultHeroList) do
		slot9 = false

		for slot13, slot14 in ipairs(slot3) do
			if slot14.id == slot8 then
				slot9 = true

				break
			end
		end

		if not slot9 then
			slot2.resultHeroList[slot7] = 0
		end
	end
end

function slot1.GetLockHero(slot0, slot1, slot2)
	if slot1.stageType == BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP then
		slot2.lockHeroList = GuildActivitySpTools.GetCantUseHeroList()
	end
end

return slot1
