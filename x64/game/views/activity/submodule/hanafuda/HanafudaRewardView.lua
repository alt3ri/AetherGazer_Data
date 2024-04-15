slot0 = class("HanafudaGameView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaRewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.rewardList_, HanafudaRewardItem)
	slot0.cardUIList_ = LuaList.New(handler(slot0, slot0.IndexCardItem), slot0.cardList_, HanafudaCardView)
	slot0.checkController_ = ControllerUtil.GetController(slot0.transform_, "check")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.checkMaskBtn_, nil, function ()
		uv0.checkController_:SetSelectedState("false")
	end)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.combineCfgList_[slot1])
	slot2:SetCallBack(function ()
		uv0:RefreshUI()
	end)
	slot2:SetCheckCallBack(function (slot0)
		uv0.cardIdList_ = HanafudaCardCombineCfg[slot0].card_list

		uv0.cardUIList_:StartScroll(#uv0.cardIdList_)
		uv0.checkController_:SetSelectedState("true")

		uv0.titleText_.text = HanafudaCardCombineCfg[slot0].name

		uv0.imgTrs_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, 700 + 300 * #uv0.cardIdList_)
	end)
end

function slot0.IndexCardItem(slot0, slot1, slot2)
	slot2:SetData(slot1, HanafudaCardCfg[slot0.cardIdList_[slot1]])
	slot2:FlipToFaceUp()
end

function slot0.OnEnter(slot0)
	slot0.combineCfgList_ = deepClone(HanafudaData:GetCombineList())

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	table.sort(slot0.combineCfgList_, function (slot0, slot1)
		slot2 = HanafudaData:GetIsComplete(slot0.id)
		slot4 = HanafudaData:GetIsComplete(slot1.id)

		if HanafudaData:GetIsRewarded(slot0.id) ~= HanafudaData:GetIsRewarded(slot1.id) then
			return not slot3 and slot5
		elseif slot2 ~= slot4 then
			return slot2 and not slot4
		else
			return slot0.id < slot1.id
		end
	end)
	slot0.uiList_:StartScroll(#slot0.combineCfgList_)
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()
	end

	if slot0.cardUIList_ then
		slot0.cardUIList_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
