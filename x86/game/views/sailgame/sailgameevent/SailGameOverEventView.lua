slot1 = class("SailGameOverEventView", import("game.views.sailGame.sailGameEvent.SailGameEventBaseView"))

function slot1.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyageTreasureChestUI"
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.rewardItemList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiList_, CommonItem)
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.openBoxBtn_, nil, function ()
		if not uv0.isOpend_ then
			uv0.isOpend_ = true

			SailGameAction.EventOperate(uv0.activityID_, uv0.stageIndex_)
		end
	end)
	slot0:AddBtnListener(slot0.overBtn_, nil, function ()
		uv0:RefreshSettlement()
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		SailGameTools.ShutDown()
		JumpTools.OpenPageByJump("/sailMain", {
			activityID = uv0.activityID_
		})
	end)
end

function slot1.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.stageIndex_ = SailGameData:GetCurGameData(slot0.activityID_).curStageIndex
	slot0.isOpend_ = false

	slot0:RefreshUI()
	manager.audio:PlayEffect("minigame_activity_2_2_summer_sea", "minigame_activity_2_2_summer_sea_pop2", "")
end

function slot1.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	uv0.super.OnExit(slot0)
end

function slot1.Dispose(slot0)
	slot0.rewardItemList_:Dispose()

	slot0.rewardItemList_ = nil

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot1.RefreshUI(slot0)
	slot0.statusController_:SetSelectedState("start")
	slot0:RefreshReward()
end

function slot1.RefreshReward(slot0)
	slot0.rewardCfgList_ = {
		GameSetting.activity_skadi_sea_be_out_end_reward.value
	}

	slot0.rewardItemList_:StartScroll(#slot0.rewardCfgList_)
end

function slot1.OnEventOperateSuccess(slot0)
	slot0:PlayBoxAnim(0, function ()
		uv0.statusController_:SetSelectedState("end")
	end)
end

function slot1.RefreshSettlement(slot0)
	slot0.rewardCfgList_ = {}

	for slot5, slot6 in pairs(SailGameData:GetTempSettlementData(slot0.activityID_).getDic) do
		slot0.rewardCfgList_[#slot0.rewardCfgList_ + 1] = {
			slot5,
			slot6
		}
	end

	slot0.rewardItemList_:StartScroll(#slot0.rewardCfgList_)
	slot0.statusController_:SetSelectedState("settlement")
end

function slot1.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.rewardCfgList_[slot1]))
	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0.rewardCfgList_[uv1])
	end)
	slot2.starController_:SetSelectedState(0)
end

function slot1.PlayBoxAnim(slot0, slot1, slot2)
	slot0.animator_:Play("XH3rdVoyageTreasureChestUI_icon", -1, slot1)
	slot0.animator_:Update(0)

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0.timer_ = Timer.New(function ()
		if uv0.animator_:GetCurrentAnimatorStateInfo(0):IsName(uv1) and slot0.normalizedTime >= 1 then
			if uv0.timer_ ~= nil then
				uv0.timer_:Stop()

				uv0.timer_ = nil
			end

			if uv2 then
				uv2()
			end
		end
	end, 0.033, -1)

	slot0.timer_:Start()
	manager.audio:PlayEffect("minigame_activity_2_2_summer_sea", "minigame_activity_2_2_summer_sea_award", "")
end

return slot1
