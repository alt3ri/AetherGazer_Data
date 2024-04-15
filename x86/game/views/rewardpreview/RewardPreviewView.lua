slot0 = class("RewardPreviewView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Common/Pop/RewardPreviewPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollList = LuaList.New(handler(slot0, slot0.indexAwardItem), slot0.itemListGo_, CommonItemView)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	if slot0.scrollList then
		slot0.scrollList:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0.rewardList = formatRewardCfgList(slot0.params_.rewardList)

	slot0.scrollList:StartScroll(#slot0.rewardList)
end

function slot0.indexAwardItem(slot0, slot1, slot2)
	slot3 = rewardToItemTemplate(slot0.rewardList[slot1])

	if slot0.params_.extraItemTemplateDataList and slot0.params_.extraItemTemplateDataList[slot3.id] then
		for slot8, slot9 in pairs(slot0.params_.extraItemTemplateDataList[slot3.id]) do
			slot3[slot8] = slot9
		end
	end

	function slot3.clickFun(slot0)
		ShowPopItem(POP_ITEM, slot0)
	end

	slot2:SetData(slot3)
end

return slot0
