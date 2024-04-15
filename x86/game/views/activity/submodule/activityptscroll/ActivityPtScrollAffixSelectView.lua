slot0 = class("ActivityPtScrollAffixSelectView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Common/Pop/SuitSelectUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.tgl_ = {}
	slot0.tglCon_ = {}
	slot0.todayCon_ = {}

	for slot4 = 1, 7 do
		slot5 = Object.Instantiate(slot0.tempBtn_.gameObject, slot0.contentGo_.transform)
		slot5.transform:Find("text").gameObject:GetComponent("Text").text = GetTips("ACTIVITY_ROULETTE_WEEK_" .. slot4)
		slot5.name = "tgl_" .. slot4

		SetActive(slot5, true)

		slot0.tgl_[slot4] = slot5.transform:GetComponent("Toggle")
		slot0.tglCon_[slot4] = ControllerUtil.GetController(slot0.tgl_[slot4].transform, "toggle")
		slot0.todayCon_[slot4] = ControllerUtil.GetController(slot0.tgl_[slot4].transform, "isToday")
	end

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.itempanelGo_, SuitSelectItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:ShowSelect(slot0.curSuitList_[slot1] == slot0.selectSuitId_)
	slot2:ShowCurrentUp(slot3 == slot0.upID_ and slot0.selectDay_ == slot0.nowDay_)
	slot2:RefreshData(slot0, {
		id = slot3
	})
	slot2:RegistCallBack(function (slot0)
		uv0:SetSelect(slot0)
	end)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.bgMaskBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListenerScale(slot0.upBtn_, nil, function ()
		ActivityPtScrollAction.SetSelectSuit(uv0.activityID_, uv0.selectSuitId_)
	end)

	slot4 = nil

	function slot5()
		if uv0.buttonUp_ and uv0.buttonUp_ > 0 then
			uv0:HidePop()
			FuncTimerManager.inst:RemoveFuncTimer(uv0.clickTimer_)

			uv0.clickTimer_ = nil

			return
		end

		SetActive(uv0.contentGo_, true)
		uv0:AddClickTimer()
	end

	slot0:AddBtnListener(slot0.selectBtn_, slot4, slot5)

	for slot4, slot5 in ipairs(slot0.tgl_) do
		slot0:AddToggleListener(slot5, function (slot0)
			if slot0 then
				uv0:RefreshDay(uv1)
			end
		end)
	end
end

function slot0.OnEnter(slot0)
	slot0.scrollList_ = {}
	slot0.activityID_ = slot0.params_.mainActivityID

	for slot5, slot6 in ipairs(ActivityPtRouletteStageCfg.get_id_list_by_activity_id[slot0.activityID_]) do
		if ActivityPtRouletteStageCfg[slot6].mode == 2 then
			slot0.scrollList_ = ActivityPtRouletteStageCfg[slot6].roulette_id

			break
		end
	end

	slot0.isSelect_, slot0.upID_ = ActivityPtScrollData:GetUpSelect(slot0.activityID_)
	slot0.nowDay_ = ActivityPtRouletteRandomCfg[ActivityPtScrollData:GetPoolID(slot0.activityID_)].time

	slot0:RefreshDay(slot0.nowDay_)
	slot0:ResetSort()
	saveData("activityPtScroll", "last_check_up", manager.time:GetServerTime())
	manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. slot0.activityID_, 0)
end

function slot0.RefreshDay(slot0, slot1)
	slot0.selectDay_ = slot1
	slot0.selectText_.text = GetTips("ACTIVITY_ROULETTE_WEEK_" .. slot0.selectDay_)

	slot0:RefreshList()
	slot0:RefreshInfo()
end

function slot0.ResetSort(slot0)
	slot0.tgl_[slot0.selectDay_].isOn = true

	for slot4, slot5 in ipairs(slot0.tglCon_) do
		slot5:SetSelectedState(slot4 == slot0.selectDay_ and "on" or "off")
		slot0.todayCon_[slot4]:SetSelectedState(slot4 == slot0.selectDay_ and "true" or "false")
	end
end

function slot0.RefreshList(slot0)
	slot0.curSuitList_ = {}

	for slot4, slot5 in ipairs(slot0.scrollList_) do
		if ActivityPtRouletteRandomCfg[slot5].time == slot0.selectDay_ then
			slot0.curSuitList_ = slot6.equip_suit_list

			break
		end
	end

	slot0.selectSuitId_ = slot0.selectDay_ == slot0.nowDay_ and slot0.upID_ or slot0.curSuitList_[1]

	slot0.scrollHelper_:StartScroll(#slot0.curSuitList_)
end

function slot0.RefreshInfo(slot0)
	if not EquipSuitCfg[slot0.selectSuitId_] then
		SetActive(slot0.infoGo_, false)

		return
	end

	SetActive(slot0.infoGo_, true)

	slot0.nameText_.text = slot1.name
	slot0.numText_.text = slot1.need
	slot0.contentText_.text = EquipTools.GetEffectDesc(slot1.suit_effect[1])

	SetActive(slot0.upBtn_.gameObject, slot0.selectSuitId_ ~= slot0.upID_ and slot0.selectDay_ == slot0.nowDay_)
	SetActive(slot0.tipGo_, slot0.selectDay_ ~= slot0.nowDay_)
end

function slot0.SetSelect(slot0, slot1)
	slot0.selectSuitId_ = slot1.id

	for slot5, slot6 in ipairs(slot0.scrollHelper_:GetItemList()) do
		slot6:ShowSelect(slot6.info_.id == slot0.selectSuitId_)
	end

	slot0:RefreshInfo()
end

function slot0.AddClickTimer(slot0)
	slot0:StopTimer()

	slot0.buttonUp_ = 0
	slot0.clickTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function ()
		if Input.GetMouseButtonUp(0) then
			uv0.buttonUp_ = uv0.buttonUp_ + 1

			if uv0.buttonUp_ >= 2 then
				uv0:HidePop()
				FuncTimerManager.inst:RemoveFuncTimer(uv0.clickTimer_)

				uv0.clickTimer_ = nil
			end
		end
	end, -1, true)
end

function slot0.StopTimer(slot0)
	if slot0.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.clickTimer_)

		slot0.clickTimer_ = nil
	end
end

function slot0.HidePop(slot0)
	slot0.buttonUp_ = 0

	SetActive(slot0.contentGo_, false)
end

function slot0.OnSetSelectSuit(slot0)
	slot0.isSelect_, slot0.upID_ = ActivityPtScrollData:GetUpSelect(slot0.activityID_)

	slot0:RefreshDay(slot0.nowDay_)
end

function slot0.OnExit(slot0)
	slot0.selectSuitId_ = nil
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
