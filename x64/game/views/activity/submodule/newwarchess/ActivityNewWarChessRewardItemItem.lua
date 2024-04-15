slot0 = class("ActivityNewWarChessRewardItemItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:AddEventListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_list, CommonItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.cfg_[slot1]))
	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0.cfg_[uv1])
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_receiveBtn, nil, function ()
		NewWarChessAction.GetActivityReward(uv0.levelID_, uv0.activityId_, {
			uv0.exploreLevel_
		})
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(ACTIVITY_NEWWARCHESS_REWARD_UPDATE, function (slot0, slot1)
		if slot0 == uv0.levelID_ and table.indexof(slot1, uv0.exploreLevel_) then
			uv0:UpdateView()
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.index_ = slot1
	slot0.levelID_ = slot2
	slot0.activityId_ = slot3
	slot0.exploreLevel_ = slot4
	slot0.cfg_ = NewWarChessLevelCfg[slot0.levelID_].reward[table.indexof(NewWarChessLevelCfg[slot2].explore, slot0.exploreLevel_)]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.m_pointLab.text = slot0.exploreLevel_ .. "%"

	slot0.uiList_:StartScroll(#slot0.cfg_)

	slot1 = NewWarChessData:GetExploreValue(slot0.levelID_)

	if NewWarChessData:GetRewardIsGet(slot0.levelID_, slot0.exploreLevel_) then
		slot0.statusController_:SetSelectedState("rewarded")
	elseif slot0.exploreLevel_ <= slot1 then
		slot0.statusController_:SetSelectedState("complete")
	else
		slot0.statusController_:SetSelectedState("unfinished")
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()

	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
