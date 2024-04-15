slot1 = class("AffixSelectDetailJapanRegionView", import("game.views.AffixSelect.AffixSelectDetailView"))

function slot1.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionAffixSelect/AffixSelectStageDetailsUI"
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.checkBtn_, nil, function ()
		JumpTools.OpenPageByJump("affixSelectBossInfoJapanRegion", {
			bossIDList = uv0.cfg_.boss_id,
			index = uv0.params_.index
		})
	end)
	slot0:AddBtnListener(slot0.challengeBtn_, nil, function ()
		gameContext:Go("/sectionSelectHero", {
			section = uv0.cfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT,
			activityID = uv0.params_.activityId
		})
	end)
end

return slot1
