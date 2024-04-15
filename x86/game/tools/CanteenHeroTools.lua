slot1 = nil

return {
	InitCanteenJobState = function (slot0, slot1)
		for slot5, slot6 in ipairs(slot1) do
			if DormNpcTools:CheckIDIsNpc(slot6.hero_id) then
				if BackHomeNpcData:GetNpcInfoById(slot7) then
					slot8:SetJob(slot6.type)
				end
			elseif DormData:GetHeroInfoList()[DormData:GetHeroArchiveID(slot7)] then
				slot10:SetJob(slot6.type)
				slot10:SetCurHeroID(slot7)
			end
		end

		CanteenHeroTools:RefreshCanteenJobList()
	end,
	GetCurWorkIDListByJobType = function (slot0, slot1)
		for slot7, slot8 in pairs(DormData:GetHeroInfoList()) do
			if slot8.jobType == slot1 then
				table.insert({}, slot7)
			end
		end

		for slot8, slot9 in pairs(BackHomeNpcData:GetBackHomeNpcInfoList()) do
			if slot9.jobType == slot1 then
				table.insert(slot3, slot8)
			end
		end

		return slot3
	end,
	HasJobAssignedToHero = function (slot0, slot1)
		if DormData:GetHeroInfoList() then
			slot3 = DormEnum.RestaurantJobToServerMap[slot1]

			for slot7, slot8 in pairs(slot2) do
				if slot8.jobType == slot3 then
					return true
				end
			end

			if DormNpcTools:CheckHasNpcWorkOnJob(slot3) then
				return true
			end
		end

		return false
	end,
	GetCanteenJobList = function (slot0)
		if uv0 then
			return uv0
		end
	end,
	GetJobTypeByHeroID = function (slot0, slot1)
		if DormData:GetHeroInfoList()[DormData:GetHeroArchiveID(slot1)] then
			return slot4.jobType
		end
	end,
	RefreshCanteenJobList = function (slot0)
		slot2 = BackHomeNpcData:GetBackHomeNpcInfoList()
		slot3 = {
			{},
			{},
			{}
		}

		if DormData:GetHeroInfoList() then
			for slot7, slot8 in pairs(slot1) do
				if slot8.jobType then
					slot9 = slot1[slot7]:GetHeroId()
					slot3[slot8.jobType].heroID = slot9
					slot3[slot8.jobType].skinID = DormHeroTools:GetCurSkinID(slot9)
				end
			end
		end

		if slot2 then
			for slot7, slot8 in pairs(slot2) do
				if slot8.jobType then
					slot3[slot8.jobType].heroID = slot7
					slot3[slot8.jobType].skinID = slot7
				end
			end
		end

		uv0 = slot3
	end,
	GetJobDispatchMaxCount = function (slot0, slot1)
		if slot1 == DormEnum.CharacterType.RestaurantCook then
			return 1
		elseif slot1 == DormEnum.CharacterType.RestaurantWaiter then
			return 1
		elseif slot1 == DormEnum.CharacterType.RestaurantCashier then
			return 1
		end
	end,
	CheckHeroConcertTag = function (slot0, slot1, slot2, slot3)
		if slot2 == 1 then
			if slot3 == CharactorParamCfg[slot1].RangeType then
				return true
			end
		elseif slot2 == 2 then
			if slot3 == HeroCfg[slot1].race then
				return true
			end
		elseif slot2 == 3 then
			if slot3 == HeroCfg[slot1].ATK_attribute[1] then
				return true
			end
		elseif slot2 == 4 and slot3 == HeroCfg[slot1].mechanism_type[1] then
			return true
		end

		return false
	end
}
