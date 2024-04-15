slot1 = class("ActivityRaceReservesView", import("game.views.stage.bossChallenge.normal.info.ReservesView"))

function slot1.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.reservesTempTeams_[slot1].hero_list

	slot2:RefreshUI(slot0.reservesTempTeams_[slot1], slot0:IsCurTeam(slot0.reservesTempTeams_[slot1]), slot0:IsInList(slot1, slot0.reservesTempTeams_[slot1]), slot1 == slot0.setCurTeamIndex_)
	slot2:RegistChangeBtn(function (slot0)
		for slot5, slot6 in ipairs(BattleTeamData:GetReservesTeam(slot0)) do
			if slot6 ~= 0 and table.indexof(uv0.lockList_, slot6) then
				ShowTips("FORMATION_PLAN_CHANGE_FAILED")

				return
			end

			if uv0.params_.race and slot6 ~= 0 and HeroCfg[slot6].race ~= uv0.params_.race then
				ShowTips("FORMATION_PLAN_CHANGE_FAILED")

				return
			end
		end

		slot2 = BattleTeamData:GetReservesTeamList()[slot0]

		ReserveTools.SetTeam(uv0.reserveParams_, slot1, {
			0,
			0,
			0
		}, slot2.comboSkill, slot2.chipInfo.id, slot2.chipInfo.list)
		uv0:Back(1, {
			isReserves = true,
			index = slot0
		})
		ShowTips("FORMATION_PLAN_CHANGED")
	end)
end

return slot1
