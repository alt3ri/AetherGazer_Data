slot0 = class("HeroPreviewFileVoicePage", HeroFileVoicePage)

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		3
	}, slot0.displayGo_)
end

return slot0
