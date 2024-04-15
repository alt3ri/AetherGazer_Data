slot0 = class("DrawAllHeroSelectView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Pool/pool_3000304_SelectPop"
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

	slot0.tapBtn_ = {}
	slot0.tapSort_ = {}
	slot0.tapType_ = {
		[1.0] = -1,
		[2] = HeroConst.HERO_ATTACK_TYPE.PYISICS,
		[3] = HeroConst.HERO_ATTACK_TYPE.WIND,
		[4] = HeroConst.HERO_ATTACK_TYPE.FLAME,
		[5] = HeroConst.HERO_ATTACK_TYPE.THUNDER,
		[6] = HeroConst.HERO_ATTACK_TYPE.DARK,
		[7] = HeroConst.HERO_ATTACK_TYPE.LIGHT,
		[8] = HeroConst.HERO_ATTACK_TYPE.FREEZE,
		[9] = HeroConst.HERO_ATTACK_TYPE.WATER
	}

	for slot4 = 1, 9 do
		slot0.tapBtn_[slot4] = slot0["tapBtn_" .. slot4]
	end

	slot0.btnCon_ = slot0.collection_:GetController("btn")
	slot0.tapCon_ = slot0.collection_:GetController("tap")
	slot0.tipCon_ = slot0.collection_:GetController("tips")
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, DrawAllHeroSelectItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot3 = slot0.curList_[slot1]
	slot2.gameObject_.name = tostring(slot3)

	slot2:SetHeroID(slot3, slot0.type_)
	slot2:SetSelected(slot2.heroID_ == slot0.curHeroId_)
	slot2:RegisterClickListener(handler(slot0, slot0.OnHeroClick))
end

function slot0.OnHeroClick(slot0, slot1)
	slot0.curHeroId_ = slot1

	slot0:UpdateBtnState()
	slot0.scrollHelper_:Refresh()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnLock_, nil, function ()
		ShowTips("DRAW_NOT_SELECT_TIPS")
	end)

	slot4 = nil

	function slot5()
		if uv0.curHeroId_ == nil or uv0.curHeroId_ == 0 then
			return
		end

		if uv0.curHeroId_ == uv0.params_.heroId then
			uv0:Back()
		else
			if uv0.params_.isFirst then
				slot0 = DrawPoolCfg[uv0.params_.poolId]

				DrawAction.SetPollUpID(uv0.params_.poolId, slot0.optional_lists_poolId[table.indexof(slot0.optional_detail, uv0.curHeroId_)])

				return
			end

			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("DRAW_SWITCH_LIMIT_CONFIRM_TIP"),
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
	end

	slot0:AddBtnListener(slot0.btnrenewalBtn_, slot4, slot5)

	for slot4, slot5 in ipairs(slot0.tapBtn_) do
		slot0:AddBtnListener(slot5, nil, function ()
			uv0:RefreshList(uv0.tapType_[uv1], uv1)
		end)
	end
end

function slot0.OnEnter(slot0)
	slot0.upID = DrawData:GetPollUpID(slot0.params_.poolId)
	slot0.upHeroID = DrawData:ConvertUpId(slot0.params_.poolId, slot0.upID, 0)
	slot0.curHeroId_ = slot0.upHeroID

	slot0:RefreshData()
	slot0:UpdateBtnState()
	slot0:UpdateTipState()
	slot0:RefreshList(-1, 1)
	slot0:AddEventListeners()

	if slot0.curHeroId_ == 0 then
		slot0.btnCon_:SetSelectedState("false")
	else
		slot0.btnCon_:SetSelectedState("current")
	end
end

function slot0.RefreshData(slot0)
	if slot0.poolID_ ~= slot0.params_.poolId then
		slot0.allHeroList_ = slot0.params_.heroIdList
		slot0.poolID_ = slot0.params_.poolId
		slot0.tapSort_ = {}
	end
end

function slot0.UpdateBtnState(slot0)
	slot0.btnCon_:SetSelectedState(slot0.curHeroId_ ~= DrawData:ConvertUpId(slot0.params_.poolId, DrawData:GetPollUpID(slot0.params_.poolId), 0) and "true" or "current")
end

function slot0.UpdateTipState(slot0)
	if DrawPoolCfg[slot0.params_.poolId].pool_change == 0 or slot0.params_.isFirst then
		slot0.tipCon_:SetSelectedState("true")
	else
		slot0.tipCon_:SetSelectedState("false")

		slot0.timesText_.text = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(DrawPoolCfg[slot0.params_.poolId].pool_change - DrawData:GetPoolUpTimes(slot0.params_.poolId)))
	end
end

function slot0.RefreshList(slot0, slot1, slot2)
	if slot1 == -1 then
		slot0.curList_ = slot0.allHeroList_
	else
		if not slot0.tapSort_[slot1] then
			slot3 = {}

			for slot7, slot8 in ipairs(slot0.allHeroList_) do
				if slot1 == HeroCfg[slot8].ATK_attribute[1] then
					table.insert(slot3, slot8)
				end
			end

			slot0.tapSort_[slot1] = slot3
		end

		slot0.curList_ = slot0.tapSort_[slot1]
	end

	slot0.tapCon_:SetSelectedState(slot2)
	slot0.scrollHelper_:StartScroll(#slot0.curList_)
end

function slot0.AddEventListeners(slot0)
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

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Dispose()

		slot0.scrollHelper_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
