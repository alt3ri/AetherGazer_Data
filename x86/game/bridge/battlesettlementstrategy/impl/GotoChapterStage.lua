slot0 = class("GotoChapterStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot0:GotoChapterStage(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult)
end

function slot0.GotoChapterStage(slot0, slot1, slot2, slot3, slot4)
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
					slot1 = uv0:GetStageId()
					slot5 = nil

					if BattleStageTools.GetStageCfg(uv0:GetType(), slot1).auto_next_stage_group ~= 0 then
						slot5 = BattleStageTools.GetStageCfg(slot0, StageTools.GetChapterNextStageID(getChapterIDByStageID(slot1), slot1))
					end

					slot6 = BattleStageData:GetStageData()[slot1]
					slot7 = false

					if slot5 and slot5.auto_next_stage_group ~= 0 then
						slot7 = slot4.auto_next_stage_group == slot5.auto_next_stage_group
					end

					if slot4.auto_next_stage_group ~= 0 and slot7 and (BattleStageData:GetAutoNextBattle() or slot4.auto_next_stage_group > 10) and StageTools.HasStageCost(slot0, slot3) and not StageTools.IsLockStage(slot2, slot3) then
						if BattleConst.BATTLE_TAG.STORY == slot5.tag then
							BattleController.GetInstance():LaunchStoryBattle(slot0, slot3, uv0:GetActivityID())
						else
							BattleController.GetInstance():LaunchBattle(BattleStageFactory.Produce(slot0, slot3, uv0:GetActivityID()))
						end

						return
					end

					JumpTools.OpenPageByJump("/battleChapterResult", {
						result = uv1,
						rewardList = uv2,
						stageData = uv0,
						starMissionData = uv3,
						battleResult = uv4
					})
					EndBattleLogic(uv1)
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
			elseif slot0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT or slot0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT then
				manager.story:CheckBattleStory(uv0:GetStageId(), manager.story.WIN, uv1, false)
			else
				manager.story:CheckBattleStory(uv0:GetStageId(), manager.story.WIN, uv1)
			end
		end
	else
		slot0:GotoBattleFaild(slot1, slot2, slot3, slot4)
	end
end

return slot0
