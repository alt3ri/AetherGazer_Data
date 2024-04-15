slot0 = class("CombineGamePoolPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfPrizeUI"
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

	slot0.list = LuaList.New(handler(slot0, slot0.SetRewardItem), slot0.listGo_, KagutsuchiGachaRewardItem)
end

function slot0.SetRewardItem(slot0, slot1, slot2)
	slot2:SetData(slot0.activityId, slot0.poolId, KagutsuchiGachaData:GetAllDrawItemIds(slot0.poolId)[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityId = slot0.params_.activityId
	slot0.poolId = slot0.params_.poolId

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.list:StartScroll(#KagutsuchiGachaData:GetAllDrawItemIds(slot0.poolId))

	slot0.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_POOL_NAME")
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.Dispose(slot0)
	if slot0.list then
		slot0.list:Dispose()

		slot0.list = nil
	end

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
