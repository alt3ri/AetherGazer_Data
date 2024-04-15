slot0 = class("SectionSelectHeroCoreVerificationView", SectionSelectHeroBaseView)

function slot0.GoHeroInfoUI(slot0, slot1)
	slot0:Go("/heroTeamInfoCoreVerification", {
		isEnter = true,
		selectHeroPos = slot1,
		stageID = slot0.stageID_,
		stageType = slot0.stageType_,
		reserveParams = slot0.reserveParams_
	})
end

function slot0.StartBattle(slot0)
	slot1 = BattleStageFactory.Produce(slot0.stageType_, slot0.stageID_, nil, slot0.reserveParams_)

	slot1:SetMultiple(slot0.multiple_)
	BattleController.GetInstance():LaunchBattle(slot1)
end

return slot0
