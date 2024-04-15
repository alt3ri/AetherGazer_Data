slot0 = class("ChessHeroTeamHeadItem", HeroTeamHeadItem)
slot1 = {
	Team_3 = 3,
	Team_2 = 2,
	CurTeam = 4,
	Team_1 = 1,
	None = 0
}

function slot0.RefreshTeamTag(slot0, slot1, slot2, slot3)
	slot4 = uv0.None

	for slot8 = 1, slot3 do
		slot14 = {
			stageType = slot15
		}
		slot15 = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS

		for slot14, slot15 in ipairs(ReserveTools.GetHeroList(ReserveParams.New(ReserveConst.RESERVE_TYPE.MULTI_CHESS, slot1, slot8, slot14))) do
			if slot0.heroId_ == slot15 then
				slot4 = (slot8 ~= slot2 or uv0.CurTeam) and slot8
			end
		end
	end

	if slot4 == uv0.Team_1 then
		SetActive(slot0.teamMark_, true)
		slot0.bgStyleController_:SetSelectedState("purple")

		slot0.teamMarkText_.text = GetTips("TEAM_" .. slot4)
	elseif slot4 == uv0.Team_2 then
		SetActive(slot0.teamMark_, true)
		slot0.bgStyleController_:SetSelectedState("purple")

		slot0.teamMarkText_.text = GetTips("TEAM_" .. slot4)
	elseif slot4 == uv0.Team_3 then
		SetActive(slot0.teamMark_, true)
		slot0.bgStyleController_:SetSelectedState("purple")

		slot0.teamMarkText_.text = GetTips("TEAM_" .. slot4)
	elseif slot4 == uv0.CurTeam then
		SetActive(slot0.teamMark_, true)
		slot0.bgStyleController_:SetSelectedState("green")

		slot0.teamMarkText_.text = GetTips("IN_TEAM")
	else
		SetActive(slot0.teamMark_, false)
	end
end

return slot0
