slot1 = class("ReserveGuildBossTemplate", import("game.reserve.template.ReserveBaseTemplate"))

function slot1.SetOwnerID(slot0, slot1)
	for slot8, slot9 in ipairs(slot0:GetContDataTemplateById():GetSingleTeamData():GetHeroList()) do
		if slot1[slot8] then
			slot9:SetOwnerID(slot1[slot8])
		end
	end
end

function slot1.FormatHeroList(slot0, slot1, slot2, slot3)
	slot4 = GuildData:GetAssistantBriefList()
	slot5 = {}

	for slot9, slot10 in ipairs(slot3) do
		if slot10:GetHeroType() == 3 then
			slot11 = false
			slot12 = nil

			for slot16, slot17 in ipairs(slot4) do
				if slot17.member_id == slot10:GetOwnerID() then
					slot12 = slot17

					if slot17.assist_hero_id == slot10:GetHeroID() then
						slot11 = true

						break
					end
				end
			end

			if slot11 and slot12 ~= nil then
				table.insert(slot5, {
					type = 2,
					info = slot12
				})
			end
		elseif slot10:GetHeroType() == 1 then
			table.insert(slot5, {
				type = 1,
				heroId = slot10:GetHeroID()
			})
		else
			error("不支持试用角色")
		end
	end

	slot0.heroInfoList_ = slot5

	for slot9 = 1, 3 do
		if slot0.heroInfoList_[slot9] ~= nil then
			if slot0.heroInfoList_[slot9].type == 1 then
				slot2.resultHeroList[slot9] = slot0.heroInfoList_[slot9].heroId
			else
				slot2.resultHeroList[slot9] = slot0.heroInfoList_[slot9].info.assist_hero_id
			end
		else
			slot2.resultHeroList[slot9] = 0
		end
	end
end

function slot1.GetCurHeroInfoList(slot0)
	return slot0.heroInfoList_ or {}
end

return slot1
