slot0 = class("HanafudaShowCombinePopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaCombinationUI"
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

	slot0.uiList_ = {}

	for slot4 = 1, 6 do
		slot5 = Object.Instantiate(slot0.cardGo_, slot0.listTrs_)

		table.insert(slot0.uiList_, HanafudaCardView.New(slot5))
		SetActive(slot5, false)
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:GoNextCombine()
	end)
end

function slot0.OnEnter(slot0)
	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_success", "")

	slot0.combineIdList_ = slot0.params_.combineIdList
	slot0.curCombineIdIndex_ = 1
	slot0.callback_ = slot0.params_.callback
	slot0.timer_ = Timer.New(function ()
		uv0:GoNextCombine()
	end, 1, -1, true)

	slot0.timer_:Start()
	slot0:RefreshUI()
end

function slot0.GoNextCombine(slot0)
	if slot0.curCombineIdIndex_ == #slot0.combineIdList_ then
		slot0:Back()

		if slot0.callback_ then
			slot0:callback_()
		end
	else
		manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_success", "")

		slot0.curCombineIdIndex_ = slot0.curCombineIdIndex_ + 1

		slot0:RefreshUI()
	end
end

function slot0.RefreshUI(slot0)
	slot2 = HanafudaCardCombineCfg[slot0.combineIdList_[slot0.curCombineIdIndex_]]
	slot0.cardIdList_ = slot2.card_list
	slot0.combineNameText_.text = slot2.name
	slot0.scoreText_.text = slot2.score

	slot0:IndexItem()
end

function slot0.IndexItem(slot0)
	for slot4 = 1, 6 do
		slot5 = slot0.uiList_[slot4]

		if slot0.cardIdList_[slot4] then
			slot5:SetData(slot4, HanafudaCardCfg[slot0.cardIdList_[slot4]])
			slot5:FlipToFaceUp()
			SetActive(slot5.gameObject_, true)
		else
			SetActive(slot5.gameObject_, false)
		end
	end

	slot0.imgTrs_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, 700 + 300 * #slot0.cardIdList_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.listTrs_)
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		for slot4, slot5 in ipairs(slot0.uiList_) do
			slot5:Dispose()
		end
	end

	uv0.super.Dispose(slot0)
end

return slot0
