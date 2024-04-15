BackHomeNpcTemplate = class("BackHomeNpcTemplate")

function BackHomeNpcTemplate.Ctor(slot0, slot1)
	slot0.npcID = slot1.id
	slot0.fatigue = -1
	slot0.jobType = slot1.jobType
	slot0.constJobType = slot1.constJobType
end

function BackHomeNpcTemplate.SetJob(slot0, slot1)
	if not slot1 then
		slot0.jobType = slot1
	elseif BackHomeNpcCfg[slot0.npcID].npc_work > 0 then
		if BackHomeNpcCfg[slot0.npcID].npc_work == slot1 then
			slot0.jobType = slot1
		else
			print("设置npc职业和设置职业不符")

			return
		end
	else
		slot0.jobType = slot1
	end

	slot0:DisposeRunSkill()
	slot0:OpenHeroSkill()
end

function BackHomeNpcTemplate.DisposeRunSkill(slot0)
	if slot0.npcID then
		if not BackHomeNpcCfg[slot0.npcID] then
			return
		end

		for slot5, slot6 in ipairs(BackHomeNpcCfg[slot0.npcID].skill_list) do
			if DormSkillData:CheckSkillIsRun(slot0.npcID, slot6, DormEnum.EntityType.Character) then
				DormSkillData:DisposeSkillComponent(slot0.npcID, slot6, DormEnum.EntityType.Character)
			end
		end
	end
end

function BackHomeNpcTemplate.OpenHeroSkill(slot0)
	if slot0.npcID then
		for slot5, slot6 in ipairs(BackHomeNpcCfg[slot0.npcID].skill_list) do
			if DormSkillData:CheckSkillIsOpen(slot0.npcID, slot6, DormEnum.EntityType.Character) then
				DormSkillData:AddSkillComponent(slot0.npcID, slot6, DormEnum.EntityType.Character)
			end
		end
	end
end

function BackHomeNpcTemplate.GetCurRoomID(slot0)
	if slot0.jobType then
		return DormConst.CANTEEN_ID
	end
end

function BackHomeNpcTemplate.GetHeroState(slot0)
	if slot0.jobType then
		return DormEnum.DormHeroState.InCanteenJob
	end
end

slot0 = singletonClass("BackHomeNpcData")
slot1 = nil

function slot0.InitNpcInfo(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(BackHomeNpcCfg.all) do
		uv0[slot6] = BackHomeNpcTemplate.New({
			id = slot6,
			constJobType = BackHomeNpcCfg[slot6].npc_work
		})
	end
end

function slot0.GetBackHomeNpcInfoList(slot0)
	return uv0
end

function slot0.GetNpcInfoById(slot0, slot1)
	if uv0 then
		return uv0[slot1]
	end
end

function slot0.CheckNpsIsWorkInCanteen(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		if slot6.jobType then
			table.insert(slot1, slot6)
		end
	end

	if #slot1 > 0 then
		return true, slot1
	else
		return false
	end
end

return slot0
