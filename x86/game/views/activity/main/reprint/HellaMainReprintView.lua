HellaMainView = import("game.views.activity.Main.HellaMainView")
slot0 = class("HellaMainReprintView", HellaMainView)

function slot0.Init(slot0)
	uv0.super.Init(slot0)
	SetActive(slot0.skinTrialGo_, false)
	SetActive(slot0.tryGo_, false)
end

return slot0
