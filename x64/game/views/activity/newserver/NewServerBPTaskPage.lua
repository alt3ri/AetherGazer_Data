slot0 = class("NewServerBPTaskPage", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot3 = Object.Instantiate(Asset.Load("Widget/System/NewServer/NewServerPasserUI"), slot1)
	slot0.gameObject_ = slot3
	slot0.transform_ = slot3.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.taskItemList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiList_, NewServerBPTaskItem)
	slot0.gsPayCallback_ = handler(slot0, slot0.OnPaySuccess)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.ReceiveBtn_, nil, function ()
		if not ActivityTools.ActivityOpenCheck(uv0.activityID_) then
			return
		end

		NewServerAction.ReceiveBPReward(uv0:GetCanReceiveTaskList(), handler(uv0, uv0.OnBPTaskReceive))
	end)
	slot0:AddBtnListener(slot0.UpgradeBtn_, nil, function ()
		if not ActivityTools.ActivityOpenCheck(uv0.activityID_) then
			return
		end

		PayAction.RequestGSPay(NewServerCfg[uv0.activityID_].bp_goods_id, 1)
	end)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.Dispose(slot0)
	if slot0.taskItemList_ then
		slot0.taskItemList_:Dispose()

		slot0.taskItemList_ = nil
	end

	slot0.gsPayCallback_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.activityID_ = slot1
	slot0.taskList_ = NewServerCfg[slot0.activityID_].bp
	slot3 = NewServerData:GetBPTaskIsRecharge()
	slot0.progressText_.text = NewServerData:GetAccumulateCurrency()
	slot5 = 1
	slot6 = false

	for slot10, slot11 in ipairs(slot0.taskList_) do
		if NewServerBPTaskCfg[slot11].need <= slot4 then
			if NewServerData:GetBPTaskStatus()[slot11] == nil then
				slot6 = true
			elseif slot2[slot11].is_receive_reward < 1 or slot3 >= 1 and slot2[slot11].is_receive_recharge_reward < 1 then
				slot6 = true
			end
		end

		if slot6 == true then
			slot5 = slot10

			break
		end
	end

	SetActive(slot0.recevieBtnGo_, slot6)
	SetActive(slot0.UpgradeGo_, slot3 < 1)
	slot0.taskItemList_:StartScroll(#slot0.taskList_, slot5)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.taskList_[slot1], slot0.activityID_, slot1 == 1, slot0.taskList_[slot1 - 1])
	slot2:SetReceiveHandler(handler(slot0, slot0.OnBPTaskReceive))
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.ReceiveBtn_.transform, RedPointConst.ACTIVITY_NEW_SERVER_BP)
	manager.notify:RegistListener(RECHARGE_SUCCESS, slot0.gsPayCallback_)
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.ReceiveBtn_.transform, RedPointConst.ACTIVITY_NEW_SERVER_BP)
	manager.notify:RemoveListener(RECHARGE_SUCCESS, slot0.gsPayCallback_)
end

function slot0.OnPaySuccess(slot0)
	NewServerAction.SetBPTaskIsRecharge()
	slot0:SetData(slot0.activityID_)
end

function slot0.OnBPTaskReceive(slot0)
	slot0:SetData(slot0.activityID_)
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.GetCanReceiveTaskList(slot0)
	slot1 = {}
	slot3 = NewServerData:GetBPTaskStatus()
	slot4 = NewServerData:GetBPTaskIsRecharge()

	for slot9, slot10 in ipairs(NewServerCfg[slot0.activityID_].bp) do
		if NewServerBPTaskCfg[slot10].need <= NewServerData:GetAccumulateCurrency() then
			if slot3[slot10] then
				if slot3[slot10].is_receive_reward < 1 then
					slot1[#slot1 + 1] = {
						receive_type = 1,
						id = slot10
					}
				end

				if slot4 >= 1 and slot3[slot10].is_receive_recharge_reward < 1 then
					slot1[#slot1 + 1] = {
						receive_type = 2,
						id = slot10
					}
				end
			else
				slot1[#slot1 + 1] = {
					receive_type = 1,
					id = slot10
				}

				if slot4 >= 1 then
					slot1[#slot1 + 1] = {
						receive_type = 2,
						id = slot10
					}
				end
			end
		end
	end

	return slot1
end

return slot0
