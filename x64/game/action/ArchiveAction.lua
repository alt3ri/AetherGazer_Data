manager.net:Bind(73005, function (slot0)
	ArchiveData:InitTrustGiftDisplaceCount(slot0)
end)
manager.net:Bind(73007, function (slot0)
	ArchiveData:InitRelationStory(slot0)
end)
manager.notify:RegistListener(ZERO_REFRESH, function ()
	ArchiveData:ClearTrustGiftDisplaceCount()
	manager.notify:CallUpdateFunc(HERO_TRUST_ITEM_DISPLACE)
end)
manager.net:Bind(71111, function (slot0)
	if slot0.hero_id_list then
		for slot4, slot5 in ipairs(slot0.hero_id_list) do
			ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[slot5][1]).hero_story_list[slot5] = {
				is_viewed = false,
				hero_id = slot5
			}
		end
	end
end)
manager.net:Bind(71113, function (slot0)
	if slot0.archive_id and slot0.index_list then
		for slot4, slot5 in ipairs(slot0.index_list) do
			ArchiveData:GetArchive(slot0.archive_id).super_heart_link_list[slot5] = {
				is_viewed = false,
				index = slot5
			}
		end
	end
end)

slot1 = nil

return {
	QueryExChangeTrustItem = function (slot0, slot1)
		manager.net:SendWithLoadingNew(73010, {
			use_item_list = slot0,
			reward_item_list = slot1
		}, 73011, uv0.OnExChangeTrustItemBack)
	end,
	OnExChangeTrustItemBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = {}

			for slot6, slot7 in pairs(slot1.reward_item_list) do
				table.insert(slot2, {
					id = slot7.id,
					num = slot7.num
				})
				ArchiveData:UpdateTrustGiftDisplaceCount(slot7.id, slot7.num)
			end

			getReward(slot2)
			manager.notify:CallUpdateFunc(HERO_TRUST_ITEM_DISPLACE)
		else
			ShowTips(slot0.result)
		end
	end,
	QuerySendTrustItem = function (slot0, slot1)
		manager.net:SendWithLoadingNew(73012, {
			hero_id = slot0,
			item_list = slot1
		}, 73013, uv0.OnSendTrustItemBack)
	end,
	OnSendTrustItemBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			manager.notify:CallUpdateFunc(HERO_TRUST_UPDATE)
			uv0.CheckHeroTrustUpLvRedPoint(slot1.hero_id)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryUpgradeTrustLevel = function (slot0)
		manager.net:SendWithLoadingNew(73014, {
			hero_id = slot0
		}, 73015, uv0.OnUpgradeTrustLevelBack)
	end,
	OnUpgradeTrustLevelBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = slot1.hero_id

			getReward2(slot0.reward_list)
			HeroData:UpgradeTrustLevel(slot1.hero_id)
			manager.notify:CallUpdateFunc(HERO_TRUST_UPDATE)
			uv0.CheckAllRelationRedPoint(slot1.hero_id)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryUnlockTrust = function (slot0)
		manager.net:SendWithLoadingNew(73020, {
			hero_id = slot0
		}, 73021, uv0.OnUnlockTrustBack)
	end,
	OnUnlockTrustBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			HeroData:UnlockTrust(slot1.hero_id, slot0.mood)
			manager.notify:CallUpdateFunc(HERO_TRUST_UPDATE)
			uv0.CheckAllRelationRedPoint(slot1.hero_id)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryUnlockRelationNet = function (slot0, slot1)
		manager.net:SendWithLoadingNew(73016, {
			id = slot0,
			group_index = slot1
		}, 73017, uv0.OnUnlockRelationNetBack)
	end,
	OnUnlockRelationNetBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = HeroRelationNetCfg[slot1.id]

			HeroData:UnlockRelationNet(slot2.hero_id, slot2.index, slot1.group_index)
			manager.notify:CallUpdateFunc(HERO_RELATION_NET_UNLOCK)
			uv0.CheckHeroRelationUnLockRedPoint(slot2.hero_id)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryRelationStoryReward = function (slot0)
		manager.net:SendWithLoadingNew(73022, {
			id = slot0
		}, 73023, uv0.OnRelationStoryRewardBack)
	end,
	OnRelationStoryRewardBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = slot1.id

			ArchiveData:UpdateRelationStory(slot2)
			getReward2(slot0.reward_list)
			Debug.Log(slot0.reward_list and #slot0.reward_list or "???")
			manager.notify:CallUpdateFunc(HERO_RELATION_STORY_REWARD)
			uv0.CheckHeroRelationStoryRedPoint(HeroRelationCfg[slot2].main_hero_id)
		else
			ShowTips(slot0.result)
		end
	end,
	SendSetWallPaper = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(71106, {
			archive_id = slot0,
			type = slot2,
			id = slot1
		}, 71107, uv0.OnSendSetWallPaperBack)
		ArchiveData:SetSelectPictrue(slot0, slot1, slot2)
	end,
	OnSendSetWallPaperBack = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		else
			manager.notify:Invoke(UPDATE_WALLPAPER)
		end
	end,
	SendViewArchiveStory = function (slot0, slot1)
		manager.net:SendWithLoadingNew(71108, {
			hero_id = slot1
		}, 71109, function (slot0)
			if isSuccess(slot0.result) then
				if slot0.reward_list then
					getReward2(slot0.reward_list or {})
				end

				ArchiveData:SetArchiveStoryRead(uv0, uv1)
			else
				ShowTips(slot0.result)
			end

			HeroAction.UpdateSuperStoryRedPoint()
			manager.notify:Invoke(UPDATE_ANDOTE)
		end)
	end,
	SendViewSuperHeart = function (slot0, slot1)
		manager.net:SendWithLoadingNew(71114, {
			archive_id = slot0,
			index = slot1
		}, 71115, uv0.OnSendViewSuperHeartBack)
	end,
	OnSendViewSuperHeartBack = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	CheckAllRelationRedPoint = function (slot0)
		ArchiveAction.CheckHeroRelationUnLockRedPoint(slot0)
		ArchiveAction.CheckHeroRelationStoryRedPoint(slot0)
		ArchiveAction.CheckHeroTrustUpLvRedPoint(slot0)
		ArchiveAction.CheckComboSkillRedPoint(slot0)
	end,
	CheckHeroRelationUnLockRedPoint = function (slot0)
		if not HeroTools.GetHeroIsUnlock(slot0) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_REALTION_UNLOCK, slot0), 0)

			return
		end

		for slot6, slot7 in ipairs(HeroRelationNetCfg.get_id_list_by_hero_id[slot0] or {}) do
			if HeroRelationNetCfg[slot7].index <= ArchiveData:GetTrustLevel(slot0) then
				for slot12, slot13 in ipairs(slot8.relation_upgrade_group) do
					if not HeroData:GetHeroData(slot0).relation:GetIsUnlock(slot8.index, slot12) and ArchiveTools.CheckRelationUpgradeCondition(HeroRelationUpgradeCfg[slot13].condition_id, slot8.intimate) then
						manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_REALTION_UNLOCK, slot0), 1)

						return
					end
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_REALTION_UNLOCK, slot0), 0)
	end,
	CheckHeroRelationStoryRedPoint = function (slot0)
		if not HeroTools.GetHeroIsUnlock(slot0) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_RELATION_STORY, slot0), 0)

			return
		end

		for slot5, slot6 in ipairs(HeroRelationCfg.get_id_list_by_main_hero_id[slot0] or {}) do
			slot10 = 0

			for slot14, slot15 in ipairs(HeroRelationNetCfg.get_id_list_by_hero_id[slot0] or {}) do
				if table.indexof(HeroRelationNetCfg[slot15].intimate, HeroRelationCfg[slot6].relate_hero_id) then
					slot10 = slot16.index
				end
			end

			if slot10 ~= 0 and slot10 <= ArchiveData:GetTrustLevel(slot0) then
				if slot7.story_id ~= 0 and IsConditionAchieved(slot7.story_condtion_id, {
					heroId = slot0
				}) and not ArchiveData:GetRelationStoryRead(slot7.id) then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_RELATION_STORY, slot0), 1)

					return
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_RELATION_STORY, slot0), 0)
	end,
	CheckAllHeroTrustUpLvRedPoint = function ()
		for slot3, slot4 in pairs(HeroCfg.get_id_list_by_private[0]) do
			uv0.CheckHeroTrustUpLvRedPoint(slot4)
		end
	end,
	GetGiftMaxExp = function ()
		if uv0 == nil then
			uv0 = 0

			for slot3 = 1, HeroConst.HERO_LOVE_LV_MAX do
				uv0 = uv0 + GameLevelSetting[slot3].hero_love_exp
			end
		end

		return uv0
	end,
	CheckHeroTrustUpLvRedPoint = function (slot0)
		if not HeroRelationNetCfg.get_id_list_by_hero_id[slot0] or not HeroTools.GetHeroIsUnlock(slot0) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, slot0), 0)

			return
		end

		slot1, slot2, slot3 = ArchiveData:GetTrustLevel(slot0)

		if ArchiveData:GetArchive(HeroTools.GetHeroOntologyID(slot0)).exp < uv0.GetGiftMaxExp() or HeroConst.HERO_TRUST_LV_MAX <= slot1 then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, slot0), 0)

			return
		end

		if slot1 == 0 then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, slot0), 1)

			return
		end

		if HeroTrustLevelCfg[slot1].exp <= slot2 then
			for slot10, slot11 in ipairs(HeroTrustCfg.get_id_list_by_hero_id[slot0]) do
				if slot1 == HeroTrustCfg[slot11].trust_level then
					slot13 = true

					for slot17, slot18 in ipairs(slot12.condition_list) do
						if not IsConditionAchieved(slot18, {
							heroId = slot0
						}) then
							slot13 = false

							break
						end
					end

					if slot13 then
						manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, slot0), 1)

						return
					end
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, slot0), 0)
	end,
	CheckComboSkillRedPoint = function (slot0)
		if not HeroRelationNetCfg.get_id_list_by_hero_id[slot0] or not HeroTools.GetHeroIsUnlock(slot0) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_RELATION_COMBO_SKILL, slot0), 0)

			return
		end

		for slot5, slot6 in ipairs(ComboSkillTools.GetHeroComboSkill(slot0)) do
			if ComboSkillData:GetCurComboSkillLevel(slot6) < ComboSkillTools.GetMaxComboSkillLevel(slot6) then
				slot10 = true

				for slot14, slot15 in ipairs(ComboSkillLevelCfg.get_id_list_by_level[slot8]) do
					if not ComboSkillTools.CheckComboSkillUpContion(slot15, slot6) then
						slot10 = false

						break
					end
				end

				if slot10 then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_RELATION_COMBO_SKILL, slot0), 1)

					return
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_RELATION_COMBO_SKILL, slot0), 0)
	end
}
