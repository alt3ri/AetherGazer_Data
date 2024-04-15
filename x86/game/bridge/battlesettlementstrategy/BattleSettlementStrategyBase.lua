slot0 = class("BattleSettlementStrategyBase")

function slot0.BuildTempData(slot0, slot1)
	slot0.tempData = {
		isHalfWay_ = slot1.isHalfWay_
	}
end

function slot0.GotoSettlement(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:BuildTempData({
		isHalfWay_ = slot5
	})

	slot6 = {}

	if slot1:GetThreeStar() and type(slot7) == "table" then
		for slot11 = 1, #slot7 do
			slot13 = slot7[slot11]

			if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == slot1:GetType() then
				if slot3 and slot3[slot11] then
					table.insert(slot6, {
						id = slot13[1],
						total = slot3[slot11].need_progress,
						current = slot3[slot11].now_progress,
						xData = slot13[2],
						yData = slot13[3],
						isComplete = slot3[slot11].is_achieve == 1 and true or false
					})

					if slot3[slot11].is_achieve == 1 and (isSuccess(slot2) or slot13[1] == 15 or slot13[1] == 16) then
						MythicData:UpdateStarIndex(slot11)
					end
				end
			elseif slot3 and slot3[slot11] then
				table.insert(slot6, {
					id = slot13[1],
					total = slot3[slot11].need_progress,
					current = slot3[slot11].now_progress,
					xData = slot13[2],
					yData = slot13[3],
					isComplete = slot3[slot11].is_achieve == 1 and true or false
				})
			end
		end
	end

	if isSuccess(slot2) and isSuccess(slot4.errorCode) then
		slot8, slot9 = slot1:GetHeroTeam()

		for slot16 = 1, #slot8 do
			if slot1:GetSystemHeroTeam()[slot16] == nil and slot8[slot16] ~= 0 and (slot9[slot16] == nil or slot9[slot16] == 0) then
				HeroData:HeroClearTimesModify(slot8[slot16], slot4.clear_times * GameSetting.mastery_gain.value[1])
				ArchiveData:AddExp(HeroTools.GetHeroOntologyID(slot8[slot16]), GameSetting.hero_love_exp_gain.value[1] * slot1:GetMultiple())
			end
		end

		HeroAction.UpdateHeartRedPoint()
		HeroAction.UpdateStoryRedPoint()
		HeroAction.UpdateSuperStoryRedPoint()
	end

	slot0:OnGotoSettlement({
		num = slot2,
		starList = slot3,
		battleResult = slot4,
		stageData = slot1,
		starMissionData = slot6,
		isHalfWay_ = slot5
	})
end

function slot0.OnGotoSettlement(slot0, slot1)
end

function slot0.GotoStage(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = GetResultReward()

	function slot7()
		slot0 = {}

		for slot4, slot5 in pairs(uv0) do
			if ItemCfg[slot5[1]] then
				if ItemConst.ITEM_TYPE.HERO == slot6.type then
					table.insert(slot0, {
						id = slot5[1]
					})
				elseif ItemConst.ITEM_TYPE.WEAPON_SERVANT == slot6.type and (not IllustratedData:GetExistServant(slot5[1]) or slot6.display_rare > 3) then
					table.insert(slot0, {
						id = slot5[1]
					})
				end
			end
		end

		manager.story:RemovePlayer()

		if #slot0 > 0 then
			gameContext:Go("obtainView", {
				doNextHandler = function ()
					JumpTools.OpenPageByJump("/newSettlement", {
						result = uv0,
						rewardList = uv1,
						stageData = uv2,
						starMissionData = uv3,
						battleResult = uv4
					})
					EndBattleLogic(uv0)
				end,
				itemList = slot0
			})
		else
			slot1()
		end
	end

	if isSuccess(slot1) then
		function BattleCallLuaCallBack()
			if uv0:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
				manager.story:CheckChessBattleStory(manager.story.WIN, uv1)
			else
				manager.story:CheckBattleStory(uv0:GetStageId(), manager.story.WIN, uv1)
			end
		end
	else
		slot0:GotoBattleFaild(slot1, slot2, slot3, slot4)
	end
end

function slot0.GotoBattleFaild(slot0, slot1, slot2, slot3, slot4)
	function BattleCallLuaCallBack()
		manager.story:CheckBattleStory(uv0:GetStageId(), manager.story.LOSE, function ()
			if uv0 and uv0:GetType() == BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON then
				JumpTools.OpenPageByJump("/battlefailedWithButton", {
					stageData = uv0,
					battleResult = uv1,
					isHalfWay_ = uv2.tempData.isHalfWay_
				})
			else
				JumpTools.OpenPageByJump("/battlefailed", {
					stageData = uv0,
					starMissionData = uv3,
					battleResult = uv1,
					isHalfWay_ = uv2.tempData.isHalfWay_
				})
			end

			manager.story:RemovePlayer()
			EndBattleLogic(uv4)
		end)
	end
end

return slot0
