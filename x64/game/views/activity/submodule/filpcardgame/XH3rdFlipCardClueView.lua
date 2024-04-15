slot0 = class("XH3rdFlipCardClueView", ReduxView)

function slot0.UIName(slot0)
	return XH3rdFlipCardTool.GetClueUI()
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	if slot0.clueListTrans_ ~= nil then
		slot0.clueItemList = {}

		for slot5 = 0, slot0.clueListTrans_.childCount - 1 do
			table.insert(slot0.clueItemList, XH3rdFlipCardClueItem.New(slot0.clueListTrans_:GetChild(slot5).gameObject, slot5 + 1))
		end
	end

	slot0.checkController_ = ControllerUtil.GetController(slot0.transform_, "check")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backMask_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.detailMask_, nil, function ()
		uv0.checkController_:SetSelectedState("false")
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityId = slot0.params_.activityId
	slot0.titleText_ = slot0.titleText_
	slot0.descText_ = slot0.descText_

	for slot6, slot7 in ipairs(FlipCardCfg[slot0.activityId].details) do
		slot0.clueItemList[slot6]:SetData(FlipCardClueCfg[slot7], slot0.activityId)
	end

	slot0.receiveHandler_ = handler(slot0, slot0.OpenClueDetailView)

	manager.notify:RegistListener(FLIP_CARD_VIEW_CLUE_RESULT, slot0.receiveHandler_)
end

function slot0.OpenClueDetailView(slot0, slot1)
	slot0.checkController_:SetSelectedState("true")

	slot2 = FlipCardClueCfg[slot1]
	slot0.titleText_.text = slot2.name
	slot0.descText_.text = slot2.description
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(FLIP_CARD_VIEW_CLUE_RESULT, slot0.receiveHandler_)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.clueItemList) do
		slot5:Dispose()
	end

	slot0.clueListTrans_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
