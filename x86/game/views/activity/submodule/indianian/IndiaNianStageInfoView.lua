slot0 = class("IndiaNianStageInfoView", ReduxView)

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaNianUI/IndiaNianStageInforUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.itemList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.dropList_, CommonItem)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
		uv0.params_.callback()
	end)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		if ItemTools.getItemNum(IndiaNianData:GetSelectedStageCost()[1]) < uv0.cost_ then
			uv0:PopCurrencyWindow()
		else
			uv0:OnClickBtn()
		end
	end)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData(rewardToItemTemplate(slot0.rewardList_[slot1]))
	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)
end

function slot0.OnClickBtn(slot0)
	slot2 = BattleIndiaNianCfg[slot0.stageID_]

	slot0:Go("/sectionSelectHeroIndiaNianView", {
		section = slot0.stageID_,
		sectionType = slot0.stageType_,
		activityID = IndiaNianData:GetActivityID(),
		destID = IndiaNianData:GetSelectedDestID()
	})
end

function slot0.PopCurrencyWindow(slot0)
	ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemCfg[IndiaNianData:GetSelectedStageCost()[1]].name))
end

function slot0.OnEnter(slot0)
	slot0.stageID_ = slot0.params_.section
	slot0.stageType_ = slot0.params_.sectionType

	manager.windowBar:RegistBackCallBack(function ()
		if uv0.params_.callback then
			uv0:Back()
			uv0.params_.callback()
		end
	end)
	slot0:RefreshData()
end

function slot0.RefreshData(slot0)
	slot0.drop_lib_id_ = BattleIndiaNianCfg[slot0.stageID_].drop_lib_id
	slot0.isFirstClear_ = true
	slot0.cost_ = IndiaNianData:GetSelectedStageCost()[2] or 0
	slot0.rewardList_ = getRewardFromDropCfg(slot0.drop_lib_id_, slot0.isFirstClear_)

	slot0:RefreshStageInfo()
end

function slot0.RefreshStageInfo(slot0)
	if slot0.oldCfgID_ ~= BattleIndiaNianCfg[slot0.stageID_].id then
		slot0.sectionName_.text = slot1.name
		slot0.textStory_.text = slot1.tips
		slot0.oldCfgID_ = slot1.id
		slot0.costImg_.sprite = ItemTools.getItemLittleSprite(IndiaNianData:GetSelectedStageCost()[1])
		slot0.costText_.text = "x" .. slot0.cost_
	end

	slot0.itemList_:StartScroll(#slot0.rewardList_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.itemList_ then
		slot0.itemList_:Dispose()

		slot0.itemList_ = nil
	end
end

return slot0
