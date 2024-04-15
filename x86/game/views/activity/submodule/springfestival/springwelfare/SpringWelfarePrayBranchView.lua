SpringPreheatPrayBranchView = import("game.views.activity.Submodule.springFestival.springPreheat.SpringPreheatPrayBranchView")
slot0 = class("SpringWelfarePrayBranchView", SpringPreheatPrayBranchView)

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.branch_ = SpringWelfarePrayBubbleView.New(slot0.branchGo_)
end

function slot0.OnEnter(slot0)
	slot0.day_ = slot0.params_.day or SpringWelfareData:GetCurPrayDay()

	slot0.branch_:SetData(slot0.day_)
	slot0.branch_:SetClickHandler(function (slot0, slot1, slot2, slot3)
		uv0:OnClickBubble(slot0, slot1, slot2, slot3)
	end)
	slot0.branch_:OnEnter()
	slot0:RefreshUI()
end

function slot0.OnClickBubble(slot0, slot1, slot2, slot3, slot4)
	if slot4 then
		ShowPopItem(POP_ITEM, {
			slot3:GetItemId()
		})
	end
end

return slot0
