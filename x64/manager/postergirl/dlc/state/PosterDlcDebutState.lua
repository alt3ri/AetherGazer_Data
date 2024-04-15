slot0 = class("PosterDlcDebutState", PosterDlcTimelineState)

function slot0.Ctor(slot0, slot1)
	uv0.super.Ctor(slot0, slot1)
end

function slot0.Enter(slot0)
	uv0.super.Enter(slot0)
	slot0.actor:SetSelfCamera(-1)
	slot0:PlayAni("debut")
end

function slot0.Exit(slot0, slot1)
	uv0.super.Exit(slot0, slot1)
	HomeSceneSettingData:SetIsPlay(slot0.actor:GetSkinId())
	manager.notify:CallUpdateFunc(HOME_DEBUT_OVER)
	slot0.actor:SetSelfCamera(0)
end

return slot0
