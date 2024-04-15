slot1 = class("ActivityToggleSpecialRewardConditionItemView", import("game.views.mardukSpecial.items.MardukSpecialRewardConditionItemView"))

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, CommonItem)
end

function slot1.indexItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.cfg_.reward_item_list[slot1]))
	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0.cfg_.reward_item_list[uv1])
	end)
end

return slot1
