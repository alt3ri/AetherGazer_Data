slot1 = class("CoreVerificationSelectHeroProxy", import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy"))

function slot1.GetHeroTeamInfoRoute(slot0)
	return "/heroTeamInfoCoreVerification"
end

function slot1.InitCustomParams(slot0, slot1)
	slot0.updateHandler = handler(slot0, slot0.UpdateCoreVerification)
end

function slot1.OnSectionSelectEnter(slot0)
	manager.notify:RegistListener(CORE_VERIFICATION_CYCLE_UPDATE, slot0.updateHandler)
end

function slot1.OnSectionSelectExit(slot0)
	manager.notify:RemoveListener(CORE_VERIFICATION_CYCLE_UPDATE, slot0.updateHandler)
end

function slot1.UpdateCoreVerification(slot0)
	CoreVerificationData:InvokeUpdateCycleCallBack()
end

function slot1.CustomCheckBeforeBattle(slot0)
	if manager.time:GetServerTime() >= CoreVerificationData:GetRefreshTime() - 600 then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("NEARLY_OVER"),
			OkCallback = function ()
				return false
			end,
			MaskCallback = function ()
				return false
			end
		})

		return false
	end

	return true
end

return slot1
