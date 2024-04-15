slot1 = class("ActivityToggleSpecialRewardView", import("game.views.mardukSpecial.MardukSpecialRewardView"))

function slot1.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdEscortUI/XH3rdEscortRewardUI"
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, ActivityToggleSpecialRewardItemView)
end

return slot1
