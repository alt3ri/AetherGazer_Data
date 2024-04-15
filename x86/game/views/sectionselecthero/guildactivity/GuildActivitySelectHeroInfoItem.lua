slot1 = class("GuildActivitySelectHeroInfoItem", import("game.views.sectionSelectHero.SectionSelectHeroInfoItem"))

function slot1.RefreshEnergyUI(slot0)
	if not GuildActivityTools:IsLastBossDefeated(slot0.sectionProxy_.activityClubCfg.id) and slot0.heroID_ ~= 0 then
		slot0.energyController_:SetSelectedState("true")

		slot0.energyText_.text = slot0:GetHeroEnergy()

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.energyBgTrans_)
	else
		slot0.energyController_:SetSelectedState("false")
	end
end

return slot1
