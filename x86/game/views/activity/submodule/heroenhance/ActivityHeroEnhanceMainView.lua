slot1 = class("ActivityHeroEnhanceMainView", import("game.views.activity.Main.toggle.ActivityMainBasePanel"))

function slot1.GetUIName(slot0)
	return ActivityHeroEnhanceTools.GetEnterUI(slot0.activityID_)
end

function slot1.Init(slot0)
	uv0.super.Init(slot0)

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListGo_, CommonItemView)
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		JumpTools.GoToSystem("/activityHeroEnhanceHero", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		slot0 = "ACTIVITY_HERO_ENHANCE_DESC"

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(slot0),
			key = slot0
		})
	end)
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot1 = slot0.activityID_

	manager.redPoint:bindUIandKey(slot0.goBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_HERO_ENHANCE_STAGE_REWARD, ActivityTools.GetRedPointKey(slot1) .. slot1))
	slot0:RefreshUI()
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)

	slot1 = slot0.activityID_

	manager.redPoint:unbindUIandKey(slot0.goBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_HERO_ENHANCE_STAGE_REWARD, ActivityTools.GetRedPointKey(slot1) .. slot1))
end

function slot1.RefreshUI(slot0)
	slot0.descText_.text = GetTips("ACTIVITY_HERO_ENHANCE_ENTER_TIP")

	if slot0.itemList_ == nil then
		slot0.itemList_ = {}

		for slot5, slot6 in pairs(sortReward(ActivityHeroEnhanceTools.GetAllRewardList(slot0.activityID_))) do
			slot7 = clone(ItemTemplateData)
			slot7.id = slot6.id
			slot7.number = slot6.num

			table.insert(slot0.itemList_, slot7)
		end
	end

	slot0.uiList_:StartScroll(#slot0.itemList_, 1)
end

function slot1.IndexItem(slot0, slot1, slot2)
	slot0.itemList_[slot1].clickFun = function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	slot2:SetData(slot0.itemList_[slot1])
end

function slot1.Dispose(slot0)
	slot0.uiList_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot1
