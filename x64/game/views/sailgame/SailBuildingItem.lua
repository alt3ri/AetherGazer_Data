slot0 = class("SailBuildingItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.durringTime_ = SailGameTools.GetBuildingTimePerReward()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if uv0.curStatus_ == SailGameConst.BUILDING_STATUS.LOCK then
			ShowTips(string.format(GetTips("ACTIVITY_SKADI_SEA_BUILD_UNLOCK_NEED"), NumberTools.IntToRomam(SailGameBuildingCfg[uv0.id_].unlock_level_need)))
		else
			JumpTools.OpenPageByJump("sailBuilding", {
				ID = uv0.id_,
				activityID = uv0.activityID
			})
		end
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if uv0.curStatus_ == SailGameConst.BUILDING_STATUS.REWARD then
			SailGameAction.ReceiveBuildingReward(uv0.activityID_)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.id_ = slot1
	slot0.activityID_ = slot2

	if slot0.unlock_ == false and SailGameData:GetUnLockBuilding(slot0.activityID_)[slot0.id_] == true == true then
		slot0.unlockAnim_.enabled = true

		slot0.unlockAnim_:Play("buildingIcon", -1, 0)
		slot0.unlockAnim_:Update(0)
		manager.audio:PlayEffect("minigame_activity_2_2_summer_sea", "minigame_activity_2_2_summer_sea_explore", "")
	else
		slot0.unlockAnim_.enabled = false
	end

	slot0.unlock_ = slot3

	if slot0.unlock_ then
		slot0.lastReceiveTime_ = SailGameData:GetBuildingLastReceiveTimeList(slot2)[slot1]
		slot0.leftTime_ = slot0.durringTime_ - (manager.time:GetServerTime() - slot0.lastReceiveTime_) % slot0.durringTime_ + 1
	end

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshStatus()
	slot0:RefreshTitle()
	slot0:RefreshReward()
end

function slot0.RefreshTitle(slot0)
	slot0.nameText_.text = SailGameBuildingCfg[slot0.id_].name

	if getSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/" .. SailGameBuildingCfg[slot0.id_].picture) then
		slot0.buildingIcon_.sprite = slot1
	end
end

function slot0.RefreshStatus(slot0)
	slot1 = 0
	slot0.unlock_ = SailGameData:GetUnLockBuilding(slot0.activityID_)[slot0.id_] == true

	if slot0.unlock_ == true then
		if SailGameData:GetIslandLevel(slot0.activityID_) < #SailGameIslandLevelCfg.get_id_list_by_activity_id[slot0.activityID_] then
			if manager.time:GetServerTime() - slot0.lastReceiveTime_ < slot0.durringTime_ then
				slot1 = SailGameConst.BUILDING_STATUS.NORMAL
			else
				slot1 = SailGameConst.BUILDING_STATUS.REWARD
			end
		else
			slot1 = SailGameConst.BUILDING_STATUS.NORMAL
		end
	else
		slot3 = SailGameBuildingCfg[slot0.id_]
		slot5 = slot3.cost[1]
		slot1 = (SailGameData:GetIslandLevel(slot0.activityID_) >= slot3.unlock_level_need or SailGameConst.BUILDING_STATUS.LOCK) and (ItemTools.getItemNum(slot5[1]) >= slot5[2] or SailGameConst.BUILDING_STATUS.NOT_ENOUGH) and SailGameConst.BUILDING_STATUS.CAN_BUILD
	end

	slot0.curStatus_ = slot1

	slot0.statusController_:SetSelectedIndex(slot1)
end

function slot0.RefreshReward(slot0)
	slot0.rewardIcon_.sprite = ItemTools.getItemSprite(SailGameBuildingCfg[slot0.id_].token_get[1][1])
	slot0.numText_.text = SailGameTools.GetBuildingTotalReward(slot0.activityID_, slot0.id_)
end

function slot0.RefreshTime(slot0)
	if slot0.unlock_ and (slot0.curStatus_ == SailGameConst.BUILDING_STATUS.NORMAL or slot0.curStatus_ == SailGameConst.BUILDING_STATUS.REWARD) then
		slot0.leftTime_ = slot0.leftTime_ - 1

		if slot0.leftTime_ <= 0 then
			slot0.leftTime_ = slot0.durringTime_

			slot0:RefreshStatus()
			slot0:RefreshReward()
			SailGameAction.UpdateBuildingAFKRewardRedPoint(slot0.activityID_)
		end
	end
end

return slot0
