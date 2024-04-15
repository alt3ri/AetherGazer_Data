slot0 = class("BossChallengeRewardPreviewView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Challenge_Boss/BossIntegralGoPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListGo_, CommonItemView)
end

function slot0.OnEnter(slot0)
	slot0.rewardList_ = slot0.params_.rewardList
	slot0.subTitleNameText_.text = slot0.params_.titleText or ""
	slot0.targetText_.text = slot0.params_.targetText or ""

	slot0.uiList_:StartScroll(#slot0.rewardList_)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.uiList_:Dispose()

	slot0.uiList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.rewardList_[slot1]

	CommonTools.SetCommonData(slot2, {
		id = slot3.id,
		number = slot3.num,
		clickFun = function (slot0)
			ShowPopItem(POP_ITEM, {
				slot0.id,
				slot0.number,
				0,
				slot0.time_valid
			})
		end
	})
end

function slot0.Cacheable(slot0)
	return false
end

return slot0
