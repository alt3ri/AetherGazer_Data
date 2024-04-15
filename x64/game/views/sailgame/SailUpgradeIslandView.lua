slot0 = class("SailUpgradeIslandView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyageIslandUpgradeUI"
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

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.premissItemList_ = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.upgradeBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if not uv0.isEnough_ then
			ShowTips("ACTIVITY_SKADI_SEA_MATERIAL_NUM_NOT_ENOUGH")

			return
		end

		if not uv0.isComplete_ then
			ShowTips("ACTIVITY_SKADI_SEA_ISLAND_UPGRADE_NOT_ENOUGH")

			return
		end

		SailGameAction.UpgradeIsland(uv0.activityID_)
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID

	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.premissItemList_) do
		slot5:Dispose()
	end

	slot0.premissItemList = nil

	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0.curLevel_ = SailGameData:GetIslandLevel(slot0.activityID_)
	slot0.nextLevel_ = slot0.curLevel_ + 1

	if slot0.curLevel_ < #SailGameIslandLevelCfg.get_id_list_by_activity_id[slot0.activityID_] then
		slot0.nextLevelText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_ISLAND_UPGRADE_TIP"), NumberTools.IntToRomam(slot0.nextLevel_))
		slot0.nextLevelCfg_ = SailGameIslandLevelCfg[SailGameIslandLevelCfg.get_id_list_by_activity_id[slot0.activityID_][slot0.nextLevel_]]

		slot0:RefreshPremiss()
		slot0:RefreshCost()
		slot0:RefreshStatus()
	end
end

function slot0.RefreshPremiss(slot0)
	slot0.premissIDList_ = slot0.nextLevelCfg_.unlock_level_need

	for slot4, slot5 in ipairs(slot0.premissIDList_) do
		if not slot0.premissItemList_[slot4] then
			slot0.premissItemList_[slot4] = SailUpgradeIslandPremissItem.New(slot0.premissTemplateGo_, slot0.premissContentTrans_)
		end

		slot0.premissItemList_[slot4]:SetData(slot5, slot0.activityID_)
	end

	for slot4 = #slot0.premissIDList_ + 1, #slot0.premissItemList_ do
		slot0.premissItemList_[slot4]:SetActive(false)
	end

	slot0.isComplete_ = true

	for slot4, slot5 in ipairs(slot0.premissItemList_) do
		if not slot5:IsComplete() then
			slot0.isComplete_ = false

			break
		end
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.premissIDList_[slot1], slot0.activityID_)
end

function slot0.RefreshCost(slot0)
	slot1 = slot0.nextLevelCfg_.cost[1]
	slot0.isEnough_ = slot1[2] <= ItemTools.getItemNum(slot1[1])
	slot0.costNumText_.text = slot4
	slot0.costIcon_.sprite = ItemTools.getItemSprite(slot2)
end

function slot0.RefreshStatus(slot0)
	if slot0.isEnough_ then
		if slot0.isComplete_ then
			slot0.statusController_:SetSelectedState("enough")
		else
			slot0.statusController_:SetSelectedState("uncomplete")
		end
	else
		slot0.statusController_:SetSelectedState("not_enough")
	end
end

function slot0.OnIslandUpgrade(slot0)
	ShowTips("ACTIVITY_SKADI_SEA_ISLAND_UPGRADE_SUCCESS")
	slot0:Back()
end

return slot0
