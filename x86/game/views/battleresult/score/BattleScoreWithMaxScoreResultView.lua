slot1 = class("BattleScoreWithMaxScoreResultView", import("game.views.battleResult.BattleResultBaseView"))

function slot1.UIName(slot0)
	return "UI/BattleResult/BattleResultSlayerUI"
end

function slot1.RefreshUI(slot0)
	slot0:SetLevelTitle()
	slot0:RefreshMyExpS()
	slot0:RefreshHeroS()
	slot0:RefreshCommonUI()
	slot0:RefreshBattleTime()
	SetActive(slot0.repulsionQuantity_, false)

	slot2 = slot0.params_.score
	slot0.m_slayerCur.text = slot2

	if slot0.params_.maxScore < slot2 then
		SetActive(slot0.m_slayerNew, true)

		slot0.m_slayerMax.text = slot2
	else
		SetActive(slot0.m_slayerNew, false)

		slot0.m_slayerMax.text = slot1
	end
end

return slot1
