slot0 = class("NewbieDrawHeroSelectView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Pool/NewbiePoolSelectPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.btnController_ = slot0.controller_:GetController("btn")
	slot0.limitController_ = slot0.controller_:GetController("tips")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, NewBieDrawHeroItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.idList_[slot1])
	slot2:RegistClickFunc(function ()
		uv0:OnHeroClick(uv0.idList_[uv1])
	end)
	slot2:RefreshSelect(slot0.curHeroId_ == slot0.idList_[slot1])
end

function slot0.OnHeroClick(slot0, slot1)
	if slot0.upHeroID == slot1 then
		slot0.btnController_:SetSelectedState("current")
	else
		slot0.btnController_:SetSelectedState(slot0.upID ~= slot1 and "true" or "current")
	end

	slot0.curHeroId_ = slot1

	slot0.uiList_:Refresh()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnrenewalBtn_, nil, function ()
		if uv0.curHeroId_ == nil or uv0.curHeroId_ == 0 then
			return
		end

		if uv0.curHeroId_ == uv0.upHeroID then
			uv0:Back()

			return
		end

		if uv0.params_.isFirst then
			slot0 = DrawPoolCfg[uv0.params_.poolId]

			DrawAction.SetPollUpID(uv0.params_.poolId, slot0.optional_lists_poolId[table.indexof(slot0.optional_detail, uv0.curHeroId_)])

			return
		end

		if uv0.upHeroID == 0 then
			slot0 = DrawPoolCfg[uv0.params_.poolId]

			DrawAction.SetPollUpID(uv0.params_.poolId, slot0.optional_lists_poolId[table.indexof(slot0.optional_detail, uv0.curHeroId_)])
		else
			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("DRAW_POOL_SCREEN_TYPE_4"),
				SecondTip = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), ""),
				SecondValue = DrawData:GetUpRemainTime(uv0.params_.poolId),
				OkCallback = function ()
					slot0 = DrawPoolCfg[uv0.params_.poolId]

					DrawAction.SetPollUpID(uv0.params_.poolId, slot0.optional_lists_poolId[table.indexof(slot0.optional_detail, uv0.curHeroId_)])
				end,
				CancelCallback = function ()
				end
			})
		end
	end)
	slot0:AddBtnListener(slot0.btnLock_, nil, function ()
		if uv0.curHeroId_ == nil or uv0.curHeroId_ == 0 then
			ShowTips("DRAW_NOT_SELECT_TIPS")

			return
		end
	end)
end

function slot0.OnSetPollUpID(slot0, slot1, slot2)
	slot0:Back()
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.upID = DrawData:GetPollUpID(slot0.params_.poolId)
	slot0.upHeroID = DrawData:ConvertUpId(slot0.params_.poolId, slot0.upID, 0)
	slot0.curHeroId_ = slot0.upHeroID

	if slot0.curHeroId_ == 0 then
		slot0.btnController_:SetSelectedState("false")
	else
		slot0.btnController_:SetSelectedState("current")
	end

	slot0:UpdateList()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()

	slot0.params_.heroId = slot0.curHeroId_
	slot0.params_.poolId = slot0.params_.poolId
	slot0.params_.isFirst = slot0.params_.isFirst

	manager.windowBar:HideBar()
end

function slot0.UpdateList(slot0)
	slot0.idList_ = slot0.params_.heroIdList

	slot0.uiList_:StartScroll(#slot0.idList_)

	if DrawPoolCfg[slot0.params_.poolId].pool_change == 0 or slot0.params_.isFirst then
		slot0.limitController_:SetSelectedState("false")
	else
		slot0.limitController_:SetSelectedState("true")

		slot0.timesText_.text = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(DrawPoolCfg[slot0.params_.poolId].pool_change - DrawData:GetPoolUpTimes(slot0.params_.poolId)))
	end
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
