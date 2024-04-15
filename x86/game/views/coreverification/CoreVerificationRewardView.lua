slot0 = class("CoreVerificationRewardView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Core_Verification/CoreVerificationQuest"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectIndex_ = 1
	slot0.taskData_ = {}
	slot0.taskUILuaList_ = LuaList.New(handler(slot0, slot0.SetRewardItem), slot0.taskUilist_, CoreVerificationRewardItem)
	slot0.pageIndexController_ = slot0.mainControllerEx_:GetController("pageIndex")
	slot0.getAllController_ = slot0.mainControllerEx_:GetController("getAll")
	slot0.firstController_ = slot0.mainControllerEx_:GetController("first")
end

function slot0.SetRewardItem(slot0, slot1, slot2)
	slot2:SetData(slot0.taskData_[slot1], slot0.selectIndex_)
end

function slot0.OnEnter(slot0)
	slot0.selectIndex_ = 1

	slot0:ChangeButtonText()
	slot0:UpdateView()
	manager.redPoint:bindUIandKey(slot0.mainRewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD1)
	manager.redPoint:bindUIandKey(slot0.subRewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD2)
	manager.redPoint:bindUIandKey(slot0.diffRewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD3)
	manager.redPoint:bindUIandKey(slot0.firstRewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD4)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(slot0.mainRewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD1)
	manager.redPoint:unbindUIandKey(slot0.subRewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD2)
	manager.redPoint:unbindUIandKey(slot0.diffRewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD3)
	manager.redPoint:unbindUIandKey(slot0.firstRewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD4)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.mainRewardBtn_, nil, function ()
		if uv0.selectIndex_ == 1 then
			return
		end

		uv0.selectIndex_ = 1

		uv0:UpdateView()
	end)
	slot0:AddBtnListener(slot0.subRewardBtn_, nil, function ()
		if uv0.selectIndex_ == 2 then
			return
		end

		uv0.selectIndex_ = 2

		uv0:UpdateView()
	end)
	slot0:AddBtnListener(slot0.diffRewardBtn_, nil, function ()
		if uv0.selectIndex_ == 3 then
			return
		end

		uv0.selectIndex_ = 3

		uv0:UpdateView()
	end)
	slot0:AddBtnListener(slot0.firstRewardBtn_, nil, function ()
		if uv0.selectIndex_ == 4 then
			return
		end

		uv0.selectIndex_ = 4

		uv0:UpdateView()
	end)
	slot0:AddBtnListener(slot0.allBtn_, nil, function ()
		slot0 = {
			reward_list = {}
		}

		for slot4, slot5 in ipairs(uv0.taskData_) do
			slot6, slot7, slot8, slot9 = CoreVerificationData:GetTaskProcess(slot5)

			if slot8 and not slot9 then
				table.insert(slot0.reward_list, slot5)
			end
		end

		if #slot0.reward_list == 0 then
			return
		end

		CoreVerificationAction.GetReward(slot0)
	end)
end

function slot0.UpdateView(slot0)
	if CoreVerificationData:CheckFirstReward() == "false" and slot0.selectIndex_ == 4 then
		slot0.selectIndex_ = 1
	end

	slot3 = CoreVerificationData
	slot4 = slot3

	slot0.firstController_:SetSelectedState(slot3.CheckFirstReward(slot4))
	slot0.pageIndexController_:SetSelectedState(slot0.selectIndex_)

	slot0.taskData_ = CoreVerificationData:GetRewardListByType(slot0.selectIndex_)

	table.sort(slot0.taskData_, function (slot0, slot1)
		slot2, slot3, slot4, slot5 = CoreVerificationData:GetTaskProcess(slot0)
		slot6, slot7, slot8, slot9 = CoreVerificationData:GetTaskProcess(slot1)

		if slot5 ~= slot9 then
			return slot9
		end

		if slot4 ~= slot8 then
			return slot4
		end

		return slot0 < slot1
	end)
	slot0.getAllController_:SetSelectedState("false")

	for slot4, slot5 in ipairs(slot0.taskData_) do
		slot6, slot7, slot8, slot9 = CoreVerificationData:GetTaskProcess(slot5)

		if slot8 and not slot9 then
			slot0.getAllController_:SetSelectedState("true")

			break
		end
	end

	slot0.taskUILuaList_:StartScroll(#slot0.taskData_)
end

function slot0.ChangeButtonText(slot0)
	slot0.title1Text_.text = GetTips("CORE_VERIFICATION_BOSS_1")
	slot0.title11Text_.text = GetTips("CORE_VERIFICATION_BOSS_1")
	slot0.title2Text_.text = GetTips("CORE_VERIFICATION_BOSS_2")
	slot0.title22Text_.text = GetTips("CORE_VERIFICATION_BOSS_2")
	slot0.title3Text_.text = GetTips("CORE_VERIFICATION_LEVEL")
	slot0.title33Text_.text = GetTips("CORE_VERIFICATION_LEVEL")
	slot0.title4Text_.text = GetTips("CORE_VERIFICATION_FIRST_PASS")
	slot0.title44Text_.text = GetTips("CORE_VERIFICATION_FIRST_PASS")
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnCoreVerificationGetReward(slot0)
	slot0:UpdateView()
end

function slot0.Dispose(slot0)
	if slot0.taskUILuaList_ then
		slot0.taskUILuaList_:Dispose()

		slot0.taskUILuaList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
