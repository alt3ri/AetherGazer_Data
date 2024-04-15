slot0 = class("MythicHeroTeamHeadItem", HeroTeamHeadItem)
slot1 = {
	Team_3 = 3,
	Team_2 = 2,
	CurTeam = 4,
	Team_1 = 1,
	None = 0
}

function slot0.RefreshTeamTag(slot0, slot1, slot2)
	slot3 = uv0.None

	for slot7 = 1, slot2 do
		for slot13, slot14 in ipairs(ReserveTools.GetHeroList(ReserveParams.New(ReserveConst.RESERVE_TYPE.MYTHIC_FINAL, ReserveConst.MYTHIC_CONT_ID.FINAL_MULTI, slot7))) do
			if slot0.heroId_ == slot14 then
				slot3 = (slot7 ~= slot1 or uv0.CurTeam) and slot7
			end
		end
	end

	if slot3 == uv0.Team_1 then
		SetActive(slot0.teamMark_, true)
		slot0.bgStyleController_:SetSelectedState("purple")

		slot0.teamMarkText_.text = GetTips("TEAM_" .. slot3)
	elseif slot3 == uv0.Team_2 then
		SetActive(slot0.teamMark_, true)
		slot0.bgStyleController_:SetSelectedState("purple")

		slot0.teamMarkText_.text = GetTips("TEAM_" .. slot3)
	elseif slot3 == uv0.Team_3 then
		SetActive(slot0.teamMark_, true)
		slot0.bgStyleController_:SetSelectedState("purple")

		slot0.teamMarkText_.text = GetTips("TEAM_" .. slot3)
	elseif slot3 == uv0.CurTeam then
		SetActive(slot0.teamMark_, true)
		slot0.bgStyleController_:SetSelectedState("green")

		slot0.teamMarkText_.text = GetTips("IN_TEAM")
	else
		SetActive(slot0.teamMark_, false)
	end
end

return slot0
