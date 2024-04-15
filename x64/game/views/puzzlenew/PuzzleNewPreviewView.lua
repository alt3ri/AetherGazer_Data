slot0 = class("PuzzleNewRewardView", ReduxView)

function slot0.UIName(slot0)
	return PuzzleNewTools.GetPreviewUIName(slot0.params_.activityID)
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
	slot0.img_.sprite = getSpriteWithoutAtlas(PuzzleNewCfg[slot0.activityID_].preview_album_id)
end

return slot0
