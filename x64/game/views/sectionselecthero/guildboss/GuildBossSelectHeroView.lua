slot0 = class("GuildBossSelectHeroView", SectionSelectHeroBaseView)

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	slot0.heroInfoList_ = {}

	for slot4 = 1, 3 do
		slot0["assistantController" .. slot4] = ControllerUtil.GetController(slot0["heroRect_" .. slot4], "assistant")
	end
end

function slot0.GoHeroInfoUI(slot0, slot1)
	slot0:Go("/guildBossTeamInfo", {
		isEnter = true,
		selectHeroPos = slot1,
		stageID = slot0.stageID_,
		activityID = slot0.params_.activityID,
		stageType = slot0.stageType_,
		heroList = slot0.heroInfoList_,
		reserveParams = slot0.reserveParams_
	})
end

function slot0.GetSelectHero(slot0)
	slot1 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.GUILD_BOSS)
	slot0.cacheHeroTeam_, slot0.lockStateList_, slot0.lockList_, slot0.heroTrialList_, _ = slot1:GetHeroList(slot0.reserveParams_)
	slot0.heroInfoList_ = slot1:GetCurHeroInfoList()

	slot0:RefreshAssistantHero()
end

function slot0.SaveTeamInfo(slot0)
	slot0:GuildBossChangeHeroTeam(slot0.heroInfoList_)
end

function slot0.OnHeroChange(slot0, slot1, slot2)
	if slot2 == nil then
		slot2 = 0
	end

	if slot2 == 0 then
		for slot6 = slot1, 2 do
			slot0.heroInfoList_[slot6] = slot0.heroInfoList_[slot6 + 1]
		end

		slot0.heroInfoList_[3] = nil
	else
		if slot0.heroInfoList_[1] ~= nil and slot3.type == 1 and slot3.heroId == slot2 and slot0.heroInfoList_[slot1] == nil then
			return
		end

		if slot2 ~= nil and slot2 > 0 then
			slot0.heroInfoList_[slot1] = {
				type = 1,
				heroId = slot2
			}
		else
			slot0.heroInfoList_[slot1] = nil
		end
	end

	slot0:GuildBossChangeHeroTeam(slot0.heroInfoList_)
end

function slot0.OnAssistantHeroChange(slot0, slot1, slot2)
	if slot2 == nil then
		for slot6 = slot1, 2 do
			slot0.heroInfoList_[slot6] = slot0.heroInfoList_[slot6 + 1]
		end

		slot0.heroInfoList_[3] = nil
	else
		if slot0.heroInfoList_[1] ~= nil and slot3.type == 2 and slot3.info.assist_hero_id == slot2.assist_hero_id and slot3.info.member_id == slot2.member_id and slot0.heroInfoList_[slot1] == nil then
			return
		end

		if slot2 ~= nil then
			slot0.heroInfoList_[slot1] = {
				type = 2,
				info = slot2
			}
		else
			slot0.heroInfoList_[slot1] = nil
		end
	end

	slot0:GuildBossChangeHeroTeam(slot0.heroInfoList_)
end

function slot0.GetHeroPower(slot0, slot1)
	if slot0.heroInfoList_[slot1] and slot0.heroInfoList_[slot1].type == 2 then
		return slot0.heroInfoList_[slot1].info.fight_capacity
	end

	return getHeroPower(slot0.heroInfoList_[slot1].heroId, false)
end

function slot0.GetSkinCfg(slot0, slot1)
	if slot0.heroInfoList_[slot1] and slot0.heroInfoList_[slot1].type == 2 then
		if slot0.heroInfoList_[slot1].info.assist_hero_skin == 0 then
			slot2 = slot0.heroInfoList_[slot1].info.assist_hero_id
		end

		return SkinCfg[slot2]
	end

	return slot0:GetHeroCfg(slot0.heroInfoList_[slot1].heroId)
end

function slot0.ChangeHeroTeam(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		for slot11, slot12 in ipairs(slot0.heroInfoList_) do
			if slot12.type == 2 and slot12.info.assist_hero_id == slot7 then
				slot2[slot7] = slot12
			elseif slot12.type == 1 and slot12.heroId == slot7 then
				slot2[slot7] = slot12
			end
		end
	end

	for slot7, slot8 in pairs(slot1) do
		-- Nothing
	end

	slot0.heroInfoList_ = {
		[slot7] = slot2[slot8]
	}

	slot0:GuildBossChangeHeroTeam(slot0.heroInfoList_)
	slot0:RefreshAddBtn()
end

function slot0.RefreshAssistantHero(slot0)
	for slot4 = 1, 3 do
		slot0["assistantController" .. slot4]:SetSelectedState("false")
	end

	if slot0.heroInfoList_ then
		for slot4, slot5 in ipairs(slot0.heroInfoList_) do
			if slot5.type == 2 then
				slot0["assistantController" .. slot4]:SetSelectedState("true")
			else
				slot0["assistantController" .. slot4]:SetSelectedState("false")
			end
		end
	end
end

function slot0.GuildBossChangeHeroTeam(slot0, slot1)
	slot3 = {
		0,
		0,
		0
	}
	slot4 = {}
	slot5 = {}
	slot6 = 1

	for slot10 = 1, 3 do
		if slot1[slot10] then
			if slot1[slot10].type == 1 then
				-- Nothing
			elseif slot11.type == 2 then
				slot2[slot6] = slot11.info.assist_hero_id
				slot4[slot6] = slot11.info.member_id
			end

			slot6 = slot6 + 1
		end
	end

	slot7 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.GUILD_BOSS)

	slot7:SetHeroList(slot0.reserveParams_, {
		[slot6] = slot11.heroId
	}, slot3)
	slot7:SetOwnerID(slot4)
end

function slot0.CheckComboSkillExist(slot0, slot1)
	return true
end

function slot0.StartBattle(slot0)
	slot1 = BattleStageFactory.Produce(slot0.stageType_, slot0.stageID_, 1, slot0.reserveParams_)
	slot2 = {}
	slot3 = {}
	slot4 = {}

	for slot9, slot10 in ipairs(slot0.heroInfoList_) do
		if slot10.type == 2 then
			table.insert(slot2, slot10.info.assist_hero_id)
			table.insert(slot3, slot10.info.member_id)
			table.insert(slot4, slot10.info.assist_hero_id)
			table.insert({}, slot10.info.member_id)
		else
			table.insert(slot2, slot10.heroId)
			table.insert(slot3, "0")
		end
	end

	slot6 = 0

	slot1:SetGuildBossTeam(slot2, slot3)
	slot1:SetMultiple(slot0.multiple_)
	slot1:SetDest(slot0.params_.dest)
	slot1:InitChipData()

	if #slot4 > 0 then
		for slot10, slot11 in ipairs(slot4) do
			ForeignInfoAction:TryToCheckForeignHeroInfo(slot5[slot10], slot11, 2, function ()
				uv0 = uv0 + 1

				if uv0 >= #uv1 then
					slot0 = {}

					for slot4, slot5 in ipairs(uv1) do
						slot7 = {}

						if ForeignInfoData:GetHeroInfo(slot5).using_hero_chip then
							for slot11, slot12 in ipairs(slot6.using_hero_chip) do
								if slot12 > 0 then
									table.insert(slot7, slot12)
								end
							end
						end

						slot0[slot5] = slot7
					end

					uv2:SetChipDic(slot0)
					BattleController.GetInstance():LaunchBattle(uv2)
				end
			end)
		end
	else
		BattleController.GetInstance():LaunchBattle(slot1)
	end
end

function slot0.GotoReservesUI(slot0)
	if slot0.heroInfoList_ then
		slot1 = slot0.cacheHeroTeam_

		for slot5, slot6 in ipairs(slot0.heroInfoList_) do
			if slot6.type == 2 then
				slot1 = {}

				break
			end
		end

		JumpTools.OpenPageByJump("/reservesUI", {
			isInit = true,
			stage_type = slot0.stageType_,
			activityID = slot0.params_.activityID,
			hero_list = slot1,
			hero_trial_list = slot0.heroTrialList_,
			lockList = slot0.lockList_,
			comboSkill = slot0.comboSkillView_:GetCurComboSkill(),
			chipInfo = {
				enabledID = slot0.chipView_:GetCurEnabledID(),
				chipList = slot0.chipView_:GetCurChipList()
			},
			reserveParams = slot0.reserveParams_
		})
	end
end

function slot0.GetHeroId(slot0, slot1)
	if slot0.heroInfoList_[slot1] == nil then
		return 0
	end

	if slot0.heroInfoList_[slot1].type == 1 then
		return slot0.heroInfoList_[slot1].heroId
	end

	return slot0.heroInfoList_[slot1].assist_hero_id
end

return slot0
