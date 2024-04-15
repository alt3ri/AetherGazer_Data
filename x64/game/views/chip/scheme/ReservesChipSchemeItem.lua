slot0 = class("ReservesChipSchemeItem", ChipSchemeItem)

function slot0.OnEnabledBtn(slot0)
	slot0.dataTemplate.useChipIdList = slot0.schemeData_.chipList

	BattleTeamData:ReservesTempTeamEnabledSchemeID(slot0.dataTemplate.reservesIndex_, slot0.schemeData_.chipList)
end

return slot0
