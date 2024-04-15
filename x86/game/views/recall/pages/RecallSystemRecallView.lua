slot1 = class("RecallSystemRecallView", import("game.views.recall.pages.RecallPageBase"))

function slot1.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, RecallSystemRecallItem)
	slot0.sendCDStateController_ = slot0.mainControllerEx_:GetController("shareCD")
end

function slot1.indexItem(slot0, slot1, slot2)
	slot2:SetData(ActivityRecallData:GetDataByPara("recallReward")[slot1], slot1)
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.CopyBtn_, nil, function ()
		ActivityRecallAction.RequireRecallShareCode(ActivityRecallData:GetDataByPara("recallActivityID"))
		ShowTips("COPY_SUCCESS")
	end)
	slot0:AddBtnListener(slot0.recallInfoBtn_, nil, function ()
		ActivityRecallAction.RequireRecallInfo(ActivityRecallData:GetDataByPara("recallActivityID"))
	end)
	slot0:AddBtnListener(slot0.shareBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(ActivityRecallData:GetDataByPara("recallActivityID")) then
			ShowTips("TIME_OVER")

			return
		end

		if manager.time:GetServerTime() - ActivityRecallData:GetLastShareTimestamp() < GameSetting.recall_share_colddown.value[1] then
			ShowTips("SEND_MESSAGE_FREQUENTLY")

			return
		end

		if ChatData:IsMuted() then
			JumpTools.OpenPageByJump("chatMuted")

			return
		end

		ActivityRecallAction.RequireRecallShareCode(slot0)
		ActivityRecallAction.RecallShare(ActivityRecallData:GetDataByPara("recallCode"), function (slot0)
			if isSuccess(slot0.result) then
				ActivityRecallData:SetLastShareTimestamp()
				ChatAction.RequireRecallInfo()
				uv0:UpdateSendTimeCD()
				ShowTips("RECALLED_SHARE")
			else
				ShowTips(slot0.result)
			end
		end)
	end)
end

function slot1.OnRecallRewardUpdate(slot0)
	slot0:UpdateView()
end

function slot1.OnTop(slot0)
end

function slot1.UpdateView(slot0)
	slot0.list_:StartScroll(#ActivityRecallData:GetDataByPara("recallReward"))

	slot0.recallCodeTxt_.text = ActivityRecallData:GetDataByPara("recallCode")
	slot0.activityTimeTxt_.text = ActivityRecallData:GetDataByPara("recallTime")
end

function slot1.OnEnter(slot0)
	slot0:UpdateView()

	if not slot0.sendTipsCD_ then
		slot0.sendTipsCD_ = 0
	end

	slot0:UpdateSendTimeCD()

	if not slot0.sendTipsTimer_ then
		slot0.sendTipsTimer_ = Timer.New(function ()
			if uv0.sendTipsCD_ > 0 then
				uv0.sendTipsText_.text = uv0.sendTipsCD_ .. GetTips("SECOND")
				uv0.sendTipsCD_ = uv0.sendTipsCD_ - 1
			else
				uv0.sendCDStateController_:SetSelectedState("false")
			end
		end, 1, -1)

		slot0.sendTipsTimer_:Start()
	end
end

function slot1.UpdateSendTimeCD(slot0)
	if manager.time:GetServerTime() - ActivityRecallData:GetLastShareTimestamp() < GameSetting.recall_share_colddown.value[1] then
		slot0.sendTipsCD_ = GameSetting.recall_share_colddown.value[1] - manager.time:GetServerTime() + slot1
		slot0.sendTipsText_.text = slot0.sendTipsCD_ .. GetTips("SECOND")

		slot0.sendCDStateController_:SetSelectedState("true")
	else
		slot0.sendTipsCD_ = 0

		slot0.sendCDStateController_:SetSelectedState("false")
	end
end

function slot1.OnExit(slot0)
	if slot0.sendTipsTimer_ then
		slot0.sendTipsTimer_:Stop()

		slot0.sendTipsTimer_ = nil
	end
end

function slot1.Hide(slot0)
	uv0.super.Hide(slot0)
end

function slot1.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot1
