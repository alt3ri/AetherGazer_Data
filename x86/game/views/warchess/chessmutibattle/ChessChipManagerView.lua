slot0 = class("ChessChipManagerView", ChipManagerView)

function slot0.OnEnter(slot0)
	slot0.stageType_ = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS
	slot0.teamID_ = slot0.params_.chessTeamID
	slot0.activityID_ = slot0.params_.activityID

	slot0.chipManagerUnlockView_:SetTeamInfo(slot0.stageType_, slot0.activityID_, nil, slot0.teamID_)
	uv0.super.OnEnter(slot0)
end

function slot0.GetManagerUnlockView(slot0)
	return ChessChipManagerUnlockView
end

function slot0.RefreshChipManagerItem(slot0, slot1, slot2)
	slot2:SetTeamID(slot0.teamID_)
	uv0.super.RefreshChipManagerItem(slot0, slot1, slot2)
end

function slot0.GetChipManagerItem(slot0)
	return ChessChipManagerItem
end

function slot0.GetChipManagerList(slot0)
	return ChipTools.SortChipManager(BattleTeamData:GetMimirInfo(slot0.stageType_, slot0.activityID_, nil, slot0.teamID_))
end

function slot0.EnableChipIDFunc(slot0, slot1)
	BattleFieldAction.SetMimirIDInfo(slot0.stageType_, slot0.activityID_, slot1, nil, slot0.teamID_)
end

return slot0
