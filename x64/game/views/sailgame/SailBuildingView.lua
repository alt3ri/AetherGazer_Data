slot0 = class("SailBuildingView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyageBuildingUnlockUI"
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

	slot0.costController_ = ControllerUtil.GetController(slot0.transform_, "cost")
	slot0.unlockController_ = ControllerUtil.GetController(slot0.transform_, "unlock")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buildBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if not uv0.isEnough_ then
			ShowTips("ACTIVITY_SKADI_SEA_MATERIAL_NUM_NOT_ENOUGH")

			return
		end

		SailGameAction.UnlockBuilding(uv0.activityID_, uv0.id_)
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.id_ = slot0.params_.ID
	slot0.buildingCfg_ = SailGameBuildingCfg[slot0.id_]
	slot0.unlock_ = SailGameData:GetUnLockBuilding(slot0.activityID_)[slot0.id_]

	slot0.unlockController_:SetSelectedState(slot0.unlock_ and "true" or "false")
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshTitle()
	slot0:RefreshReward()
	slot0:RefreshCost()
end

function slot0.RefreshTitle(slot0)
	slot1 = SailGameBuildingCfg[slot0.id_]

	if slot0.unlock_ then
		slot0.titleText_.text = slot1.name
		slot0.descText_.text = slot1.desc
	else
		slot0.titleText_.text = GetTips("ACTIVITY_SKADI_SEA_BUILDING_NOT_FOUND_NAME")
		slot0.descText_.text = GetTips("ACTIVITY_SKADI_SEA_BUILDING_NOT_FOUND_DESCRIBE")

		if getSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/" .. slot1.picture_unlock) then
			slot0.lockIcon_.sprite = slot2
		end
	end

	if getSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/" .. slot1.picture_pop) then
		slot0.normalIcon_.sprite = slot2
	end
end

function slot0.RefreshReward(slot0)
	slot1 = slot0.buildingCfg_.token_get[1]
	slot0.rewardNumText_.text = string.format("+%d/%s", slot1[2] * 60 / GameSetting.activity_skadi_sea_building_calculate_time.value[1], GetTips("HOUR"))
	slot0.rewardIcon_.sprite = ItemTools.getItemSprite(slot1[1])
end

function slot0.RefreshCost(slot0)
	if slot0.unlock_ then
		return
	end

	slot1 = slot0.buildingCfg_.cost[1]
	slot0.isEnough_ = false

	if slot1[2] <= ItemTools.getItemNum(slot1[1]) then
		slot0.isEnough_ = true

		slot0.costController_:SetSelectedState("true")
	else
		slot0.costController_:SetSelectedState("false")
	end

	slot0.costNumText_.text = slot3
	slot0.costIcon_.sprite = ItemTools.getItemSprite(slot2)
end

function slot0.OnBuildingUnlock(slot0)
	ShowTips(string.format(GetTips("ACTIVITY_SKADI_SEA_BUILD_SUCCESS"), slot0.buildingCfg_.name))
	slot0:Back()
end

return slot0
