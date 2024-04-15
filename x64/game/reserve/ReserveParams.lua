slot0 = class("ReserveParams")

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4)
	slot0.customData = slot4 or {}
	slot0.stageType = slot0.customData.stageType
	slot0.stageID = slot0.customData.stageID
	slot0.reserveType = slot1 or ReserveTools.GetReserveType(slot0.stageType, slot0.stageID)
	slot0.contID = slot2 or ReserveTools.GetContID(slot0.stageType, slot0.stageID)
	slot0.teamIndex = slot3 or ReserveConst.DEFAULT_TEAM_INDEX
	slot0.needDefaultTeam = ReserveTools.NeedDefaultTeam(slot0.stageType, slot0.stageID)
end

return slot0
