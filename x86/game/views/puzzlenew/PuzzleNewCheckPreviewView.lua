slot0 = class("PuzzleNewCheckPreviewView", ReduxView)

function slot0.UIName(slot0)
	return PuzzleNewTools.GetCheckPreviewUIName(slot0.params_.activityID)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backMask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot1 = PuzzleNewCfg[slot0.activityID_]
	slot0.originImg_.sprite = getSpriteWithoutAtlas(slot1.preview_album_id)
	slot0.checkImg_.sprite = getSpriteWithoutAtlas(slot1.album_id)
	slot2 = #slot1.clue_id

	for slot8, slot9 in pairs(PuzzleNewData:GetCurCheckList(slot0.activityID_)) do
		slot4 = 0 + 1
	end

	slot0.progressText_.text = string.format("%d/%d", slot4, slot2)
end

return slot0
