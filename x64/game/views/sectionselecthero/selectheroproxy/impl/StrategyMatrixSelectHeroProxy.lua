slot1 = class("StrategyMatrixSelectHeroProxy", import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy"))

function slot1.InitCustomParams(slot0, slot1)
	slot0.matrix_activity_id = slot1.matrix_activity_id
	slot0.nodeId = slot1.nodeId
	slot0.needHeroPower = false
	slot0.needMimirPanel = false
	slot0.canChangeTeam = false
end

function slot1.GetRaceEffect(slot0)
	slot1 = {}
	slot2 = 0
	slot3 = false

	for slot8, slot9 in pairs(slot0:GetHeroIDList()) do
		if slot9 ~= 0 then
			slot1[slot10] = (slot1[HeroCfg[slot9].race] or 0) + 1

			if slot1[slot10] == 2 then
				slot2 = slot10

				if StrategyMatrixData:GetRaceEffect(slot0.matrix_activity_id) then
					slot3 = true
				end
			elseif slot1[slot10] == 3 then
				slot3 = true
			end
		end
	end

	return slot2, slot1[slot2] or 1, slot3
end

function slot1.CustomGetSkinCfg(slot0, slot1, slot2, slot3)
	if slot3 ~= 0 then
		return SkinCfg[HeroStandardSystemCfg[slot3].skin_id]
	else
		return StrategyMatrixData:GetHeroSkin(slot0.matrix_activity_id, slot2)
	end
end

function slot1.CustomChangeHeroTeam(slot0, slot1)
	StrategyMatrixData:SetMatrixBattleHeroTeam(slot0.matrix_activity_id, slot1)
end

function slot1.CustomGetComboSkillID(slot0)
	return ComboSkillData:GetComboSkillID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX, nil, 1)
end

function slot1.CustomSetComboSkillID(slot0, slot1)
	BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX, GetHeroTeamActivityID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX), slot1)
end

function slot1.StartBattle(slot0)
	if StrategyMatrixData:GetGameState(slot0.matrix_activity_id) == MatrixConst.STATE_TYPE.NOTSTARTED then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MATRIX_REFRESH_DATA"),
			OkCallback = function ()
				StrategyMatrixAction.GotoStrategyMatrixPrepare(uv0.matrix_activity_id)
			end
		})
	else
		slot4 = slot0.nodeId

		if StrategyMatrixData:GetMatrixPhaseData(slot0.matrix_activity_id):GetPhase() == 2 then
			StrategyMatrixAction.DoEvent(slot0.matrix_activity_id)
		else
			StrategyMatrixAction.QueryNextProgress(slot0.matrix_activity_id, {
				slot4
			})
		end
	end
end

return slot1
