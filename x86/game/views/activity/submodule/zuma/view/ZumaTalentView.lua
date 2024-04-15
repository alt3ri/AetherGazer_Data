slot0 = class("ZumaTalentView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaTalentUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.selectTalentID = 0

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.leftRootTrsCanvas = slot0.leftRootTrs_:GetComponent(typeof(CanvasGroup))
	slot0.middleBeginPos = slot0.middleTrs_.anchoredPosition
	slot0.talentInfoView = ZumaTalentInfoView.New(slot0.chaptersectioninfouiGo_)

	slot0:InitTreeList()
	slot0:AddBtnListener(slot0.resetbtnBtn_, nil, function ()
		uv0:OnResetBtn()
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:RefreshZumaTalentSelectInfo()
	end)
	slot0:AddBtnListener(slot0.currencyBtn_, nil, function ()
		ShowPopItem(POP_SOURCE_ITEM, {
			ZumaConst.TalentCostID
		})
	end)

	slot0.tokeniconImg_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
	slot0.tokenImg_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
end

function slot0.OnResetBtn(slot0)
	if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_ZUMA) then
		ShowTips("TIME_OVER")

		return
	end

	if not ZumaData:GetTalentList() or not next(slot1) then
		ShowTips("ACTIVITY_ZUMA_TALENT_RESET_EMPTY")

		return
	end

	JumpTools.OpenPageByJump("ZumaTips", {
		textContent = GetTips("ACTIVITY_ZUMA_TALENT_RESET"),
		titleContent = GetTips("ACTIVITY_ZUMA_TALENT_RESET_TITLE"),
		sureCallback = function ()
			ZumaAction.ResetZumaTalent()
			JumpTools.Back()
		end,
		cancelCallback = function ()
			JumpTools.Back()
		end
	})
end

function slot0.RefreshZumaTalentSelectInfo(slot0, slot1)
	if slot1 then
		if slot1 == slot0.selectTalentID then
			return
		end

		if slot0.selectTalentID then
			slot0:UpdateTalentItemSelect(slot0.selectTalentID, false)
		end

		slot0.selectTalentID = slot1

		slot0.talentInfoView:RefreshTalentInfoUi(slot1)
		slot0:UpdateTalentItemSelect(slot0.selectTalentID, true)
		slot0:ShowInfoAni(true)

		slot0.leftRootTrsCanvas.blocksRaycasts = false
	else
		if slot0.selectTalentID then
			slot0:UpdateTalentItemSelect(slot0.selectTalentID, false)
		end

		slot0.selectTalentID = nil

		slot0:ShowInfoAni(false)

		slot0.leftRootTrsCanvas.blocksRaycasts = true
	end
end

function slot0.ShowInfoAni(slot0, slot1)
	SetActive(slot0.rootGo_, slot1)
	slot0:RemoveTween()

	slot2 = slot0.middleTrs_.anchoredPosition
	slot3 = slot0.middleBeginPos

	if slot1 == false then
		slot3 = Vector2(slot0.middleBeginPos.x + 200, 0)
	end

	slot0.tween_ = LeanTween.value(slot0.middleTrs_.gameObject, slot2, slot3, 0.5):setOnUpdate(LuaHelper.FloatAction(function (slot0)
		uv0.middleTrs_.anchoredPosition = Vector2(slot0, 0)
	end)):setOnComplete(System.Action(function ()
		uv0:RemoveTween()
	end)):setEase(LeanTweenType.easeOutSine)
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.tween_.id)

		slot0.tween_ = nil
	end
end

function slot0.RefreshZumaTalentView(slot0, slot1)
	if slot1 then
		slot0:UpdateTalentList(slot1)
		slot0.talentInfoView:RefreshTalentInfoUi(slot0.selectTalentID)
		slot0:UpdateCurrencyShow()
	else
		slot0:UpdateTalentList()
		slot0:RefreshZumaTalentSelectInfo()
		slot0:UpdateCurrencyShow()
	end
end

function slot0.UpdateTalentItemSelect(slot0, slot1, slot2)
	if slot0.talentList[slot0.talentIDToIndex[slot1]] then
		slot4:RefreshSelectState(slot2)
	end
end

function slot0.InitTreeList(slot0)
	slot0.talentTreeList = ZumaData:GetTalentTreeCfg()
	slot0.treeResList = {
		[0] = {
			1
		},
		{
			3,
			2,
			4
		},
		{
			5
		},
		{
			6
		},
		{
			7
		},
		{
			8
		},
		{
			9
		},
		{
			10
		}
	}
	slot0.talentIDToIndex = {}
	slot0.talentTreePosList = {}
	slot4 = 0

	slot0:InitTreeItemPos(0, slot4)

	slot0.talentList = {}

	for slot4, slot5 in pairs(slot0.talentTreePosList) do
		slot6, slot7 = slot0:CreateTalentItem(slot4)
		slot0.talentList[slot4] = ZumaTalentItem.New(slot6, slot7, slot5)
		slot0.talentIDToIndex[slot5] = slot4
	end

	slot0:DefaultSelectTalent()
end

function slot0.DefaultSelectTalent(slot0)
	slot0:RefreshZumaTalentSelectInfo()
end

function slot0.InitTreeItemPos(slot0, slot1, slot2)
	for slot8, slot9 in pairs(slot0.treeResList[slot1] or {}) do
		slot0:InitTreeItemPos(slot9, slot0.talentTreeList[slot2][slot8])
	end

	if targetIndex == 0 or slot2 == 0 then
		return
	end

	slot0.talentTreePosList[slot1] = slot2
end

function slot0.CreateTalentItem(slot0, slot1)
	slot2 = slot0.easystageTrs_:GetChild(slot1 - 1)

	return slot2:GetChild(0).gameObject, slot2:GetChild(1)
end

function slot0.UpdateTalentList(slot0, slot1)
	for slot5, slot6 in pairs(slot0.talentList) do
		if slot1 then
			if slot6 and slot6:GetTalentID() and slot6:GetTalentID() == slot1 then
				slot6:RefreshTalentState()
			end
		else
			slot6:RefreshTalentState()
		end
	end
end

function slot0.UpdateCurrencyShow(slot0)
	slot0.currencyTxt_.text = ZumaData:GetZumaCoin()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0:UpdateTalentList()
	slot0:UpdateCurrencyShow()
end

function slot0.OnExit(slot0)
	ZumaData:SetTalentReadList()
end

function slot0.Dispose(slot0)
	slot0:RemoveTween()

	for slot4, slot5 in pairs(slot0.talentList) do
		slot5:Dispose()
	end

	slot0.talentInfoView:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.Cacheable(slot0)
	return false
end

return slot0
