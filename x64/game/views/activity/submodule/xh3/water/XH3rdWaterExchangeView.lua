slot0 = class("XH3rdWaterExchangeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdWaterparkUI/XH3rdWPPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uilistGo_, XH3rdWaterExchangeItemView)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.taskIdList_[slot1], slot0.params_.activityID)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(ACTIVITY_WATER_SELF_ASSISTANT_REWARD_UPDATE, function ()
		uv0:UpdateView()
	end)
end

function slot0.OnWaterResult(slot0, slot1)
	JumpTools.OpenPageByJump("/xH3rdWaterResult", {
		activityID = slot1
	})
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	slot0:ShowDefaultBar()
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.UpdateView(slot0)
	slot0.taskIdList_ = ActivityPointRewardCfg.get_id_list_by_activity_id[slot0.params_.activityID]

	slot0.uiList_:StartScroll(#slot0.taskIdList_)
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
