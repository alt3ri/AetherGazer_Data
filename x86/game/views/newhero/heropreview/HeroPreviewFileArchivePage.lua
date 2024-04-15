slot0 = class("HeroPreviewFileArchivePage", HeroFileArchivePage)

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		3
	}, slot0.displayGo_)
end

function slot0.BindRedPoint(slot0, slot1)
end

return slot0
