return {
	BackHomeNpcType = {
		cook = 1,
		waiter = 2,
		cashier = 3
	},
	GetNpcInfoListByConstJobType = function (slot0, slot1)
		slot2 = {}

		for slot7, slot8 in pairs(BackHomeNpcData:GetBackHomeNpcInfoList()) do
			if slot8.constJobType == slot1 then
				table.insert(slot2, slot7)
			end
		end

		return slot2
	end,
	CheckIDIsNpc = function (slot0, slot1)
		if BackHomeNpcCfg[slot1] then
			return true
		end
	end,
	GetNpcFatigue = function (slot0, slot1)
		if BackHomeNpcData:GetNpcInfoById(slot1) then
			return slot2.fatigue
		end

		CustomLog.Log("未找到npc数据，npcID为" .. slot1)
	end,
	GetNpcHeadSprite = function (slot0, slot1)
		return getSpriteViaConfig("DormNpcHeadIcon", slot1)
	end,
	CheckHasNpcWorkOnJob = function (slot0, slot1)
		for slot6, slot7 in ipairs(uv0:GetNpcInfoListByConstJobType(slot1)) do
			if DormData:GetCharacterInfo(slot7).jobType == slot1 then
				return true
			end
		end

		return false
	end
}
