slot0 = class("TangramPuzzleBlackboard", ReduxView)

function slot0.Ctor(slot0)
	slot0:Reset()
end

function slot0.Reset(slot0)
	slot0.isAutoPutPuzzle_ = false
	slot0.isMovePuzzle_ = false
	slot0.moveOriginPuzzleIndex_ = -1
	slot0.moveTargetPuzzleIndex_ = -1
	slot0.isMoveImmediately_ = false
	slot0.isRotateRegion_ = false
	slot0.rotateRegionID_ = -1
	slot0.rotateTimes_ = 0
	slot0.newEditIndex_ = -1
	slot0.isReceivedRegionReward_ = false
	slot0.isOnlyRegionRewardPop_ = false
	slot0.receivedRegionList_ = {}
	slot0.rewardList_ = {}
	slot0.needCheckAllRightRegionType_ = false
	slot0.checkAllRightRegionTypeDic_ = {}
	slot0.allRightRegionTypeList_ = {}
	slot0.regionTypeAllRight_ = -1
	slot0.needSwitchToPlay_ = false
	slot0.needSwitchToEdit_ = false
	slot0.needSwitchToFinal_ = false
end

return slot0
