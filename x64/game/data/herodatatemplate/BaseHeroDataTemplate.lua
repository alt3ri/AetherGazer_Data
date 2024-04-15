slot0 = class("BaseHeroDataTemplate")

function slot0.Ctor(slot0, slot1)
	slot3 = {
		{
			pos = 1,
			equip_id = 0
		},
		{
			pos = 2,
			equip_id = 0
		},
		{
			pos = 3,
			equip_id = 0
		},
		{
			pos = 4,
			equip_id = 0
		},
		{
			pos = 5,
			equip_id = 0
		},
		{
			pos = 6,
			equip_id = 0
		}
	}
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in ipairs(HeroCfg[slot1].skills) do
		table.insert(slot4, {
			skill_level = 1,
			skill_id = slot10
		})

		if slot9 <= 5 then
			table.insert(slot5, {
				level = 0,
				index = slot9
			})
		end
	end

	slot0.id = slot1
	slot0.exp = 0
	slot0.level = 1
	slot0.star = slot2.unlock_star
	slot0.using_skin = 0
	slot0.break_level = 0
	slot0.unlock = 0
	slot0.unlocked_astrolabe = {}
	slot0.using_astrolabe = {}
	slot0.equip = slot3
	slot0.skill = slot4
	slot0.skillAttrList = slot5
	slot0.weapon_info = {
		exp = 0,
		breakthrough = 0,
		level = 1
	}
	slot0.servant_uid = 0
	slot0.servantInfo = {
		id = 0,
		uid = 0,
		lock = true,
		stage = 1
	}
	slot0.transition = {}
	slot0.moduleLevel = 0
	slot0.moduleAssignment = 0
end

function slot0.Init(slot0, slot1)
	Debug.LogError("heroDataTeamplate Type：" .. slot0:GetType() .. "need to override function Init(data)")
end

function slot0.ModifyHero(slot0, slot1)
	Debug.LogError("heroDataTeamplate Type：" .. slot0:GetType() .. "need to override function ModifyHero()")
end

function slot0.GetServantInfo(slot0)
	Debug.LogError("heroDataTeamplate Type：" .. slot0:GetType() .. "need to override function GetServantInfo()")
end

function slot0.GetWeaponInfo(slot0)
	Debug.LogError("heroDataTeamplate Type：" .. slot0:GetType() .. "need to override function GetWeaponInfo()")
end

function slot0.GetEquipInfoList(slot0)
	Debug.LogError("heroDataTeamplate Type：" .. slot0:GetType() .. "need to override function GetEquipInfoList()")
end

function slot0.GetSkillInfoList(slot0)
	Debug.LogError("heroDataTeamplate Type：" .. slot0:GetType() .. "need to override function GetSkillInfoList()")
end

function slot0.GetSkillAttrList(slot0)
	Debug.LogError("heroDataTeamplate Type：" .. slot0:GetType() .. "need to override function GetSkillAttrList()")
end

function slot0.GetTransitionInfoList(slot0)
	Debug.LogError("heroDataTeamplate Type：" .. slot0:GetType() .. "need to override function GetTransitionInfoList()")
end

function slot0.GetType(slot0)
	Debug.LogError("heroDataTeamplate Type：" .. slot0:GetType() .. "need to override function GetType()")

	return HeroConst.HERO_DATA_TYPE.UNDEFINED
end

return slot0
