slot0 = class("HanafudaCheckCombineView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaCheckUI"
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

	slot0.uiList = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListGo_, HanafudaCardView)
	slot0.uiCombineList_ = LuaList.New(handler(slot0, slot0.IndexCombineItem), slot0.combineList_, HanafudaCombineItem)
	slot0.titleController_ = ControllerUtil.GetController(slot0.transform_, "title")
	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "changeBtn")
	slot0.btnController_ = ControllerUtil.GetController(slot0.changeBtn_.transform, "btn")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.changeBtn_, nil, function ()
		if uv0.state == 1 then
			uv0.state = 2
		else
			uv0.state = 1
		end

		uv0:RefreshState()
	end)
end

function slot0.IndexCombineItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.cardCombineDataList_[slot1], slot0.playerType_)
end

function slot0.OnEnter(slot0)
	slot0.playerType_ = slot0.params_.playerType
	slot0.callback_ = slot0.params_.callback
	slot0.state = 1

	slot0:RefreshState()

	if slot0.playerType_ == HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE then
		slot0.titleController_:SetSelectedState("player")

		slot0.scoreText_.text = HanafudaData:GetScoreByType(HanafudaData.CARD_PLACE_TYPE.PLAYER)
	else
		slot0.titleController_:SetSelectedState("enemy")

		slot0.scoreText_.text = HanafudaData:GetScoreByType(HanafudaData.CARD_PLACE_TYPE.ENEMY)
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.cardDataList_[slot1])
end

function slot0.RefreshState(slot0)
	if slot0.state == 1 then
		slot0.stateController_:SetSelectedState("list")
		slot0.btnController_:SetSelectedState("combination")

		slot0.cardDataList_ = HanafudaData:GetCardsListByType(slot0.playerType_)

		slot0.uiList:StartScroll(#slot0.cardDataList_)
	elseif slot0.state == 2 then
		slot0.stateController_:SetSelectedState("combination")
		slot0.btnController_:SetSelectedState("deck")

		slot0.cardCombineDataList_ = HanafudaData:GetCombineList()

		slot0.uiCombineList_:StartScroll(#slot0.cardCombineDataList_)
	end
end

function slot0.OnExit(slot0)
	if slot0.callback_ then
		slot0.callback_()
	end
end

function slot0.Dispose(slot0)
	if slot0.uiList then
		slot0.uiList:Dispose()
	end

	if slot0.uiCombineList_ then
		slot0.uiCombineList_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
