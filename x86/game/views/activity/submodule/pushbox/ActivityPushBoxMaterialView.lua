slot0 = class("ActivityPushBoxMaterialView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/JapanRegionUI_2_10MaterialCollectionUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.materialPreviewTbl_ = {
		"CAKE_INDEX_MATERIAL_1",
		"CAKE_INDEX_MATERIAL_2",
		"CAKE_INDEX_MATERIAL_3",
		"CAKE_INDEX_MATERIAL_4",
		"CAKE_INDEX_MATERIAL_5",
		"CAKE_INDEX_MATERIAL_6",
		"CAKE_INDEX_MATERIAL_7"
	}
	slot1 = 0

	for slot6, slot7 in ipairs(ActivityCelebrationOrderCfg.get_id_list_by_main_activity[slot0.params_.activityID]) do
		slot1 = ActivityCelebrationOrderCfg[slot7].index < slot1 and slot1 or slot8
	end

	slot0.eventItem_ = {}

	for slot6 = 1, slot1 do
		if slot0["eventItemGo_" .. slot6] == nil then
			error("场景布置数量不足")
		end

		slot0.eventItem_[slot6] = ActivityPushBoxEventItem.New(slot0["eventItemGo_" .. slot6])

		slot0.eventItem_[slot6]:RegistClickFunc(function (slot0, slot1)
			uv0:ClickEvent(slot0, slot1)
		end)
	end

	slot0.materialGo_ = {}
	slot0.materialTxt_ = {}
	slot0.materialIcon_ = {}

	for slot6 = 1, 3 do
		slot0.materialGo_[slot6] = slot0["materialGo_" .. slot6]
		slot0.materialTxt_[slot6] = slot0["materialTxt_" .. slot6]
		slot0.materialIcon_[slot6] = slot0["materialIcon_" .. slot6]
	end

	slot0.idleCon_ = ControllerUtil.GetController(slot0.transform_, "idle")
	slot0.refreshCon_ = ControllerUtil.GetController(slot0.transform_, "refresh")
	slot0.materialCon_ = ControllerUtil.GetController(slot0.transform_, "material")
	slot0.sectionView_ = ActivityPushBoxSectionView.New(slot0.scetionGo_)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:SetSelectItem(0)
		uv0.sectionView_:Show(false)
		SetActive(uv0.bgBtn_.gameObject, false)
	end)
	slot0:AddBtnListener(slot0.refreshBtn_, nil, function ()
		if ActivityPushBoxData:GetRefreshTime(uv0.activityID_) > 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("ORDER_REFRESH_TIPS1") .. "\n" .. GetTips("ORDER_REFRESH_TIPS2") .. slot0,
				OkCallback = function ()
					ActivityPushBoxAction.ResetEvent(uv0.activityID_)
				end
			})
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID

	slot0:RefreshData()
	slot0:RefreshTime()
	slot0:RefreshMaterial()
	slot0:RefreshEventMap()
	slot0.sectionView_:Show(false)
	SetActive(slot0.bgBtn_.gameObject, false)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_BOX_FATIGUE .. "_" .. slot0.activityID_, 0)
	slot0:RegistEventListener(MATERIAL_MODIFY, handler(slot0, slot0.RefreshMaterial))
end

function slot0.RefreshData(slot0)
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
end

function slot0.RefreshTime(slot0)
	slot0:StopTimer()

	if manager.time:GetServerTime() < slot0.startTime_ then
		slot0.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		slot0.timer_ = Timer.New(function ()
			if uv0.startTime_ <= manager.time:GetServerTime() then
				uv0:StopTimer()
				uv0:RefreshTime()

				return
			end
		end, 1, -1)

		slot0.timer_:Start()
	elseif slot1 < slot0.stopTime_ then
		slot0.timeLable_.text = manager.time:GetLostTimeStr2(slot0.stopTime_)
		slot0.timer_ = Timer.New(function ()
			if uv0.stopTime_ <= manager.time:GetServerTime() then
				uv0:StopTimer()
				uv0:RefreshTime()

				return
			end

			uv0.timeLable_.text = manager.time:GetLostTimeStr2(uv0.stopTime_)
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.timeLable_.text = GetTips("TIME_OVER")
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshMaterial(slot0)
	slot3 = nil

	if ActivityPushBoxData:GetCurIndex(slot0.activityID_) >= #ActivityCelebrationCakeCfg.get_id_list_by_activity_id[slot0.activityID_] then
		slot0.materialListText_.text = GetTips(slot0.materialPreviewTbl_[slot1])
		slot3 = ActivityCelebrationCakeCfg[slot2[slot1]]
	else
		slot0.materialListText_.text = GetTips(slot0.materialPreviewTbl_[slot1 + 1])
		slot3 = ActivityCelebrationCakeCfg[slot2[slot1 + 1]]
	end

	slot5 = "<color=#FF0000>%d</color>"

	for slot9, slot10 in ipairs(slot3.cost_list) do
		slot11 = slot10[1]
		slot0.materialIcon_[slot9].sprite = ItemTools.getItemSprite(slot11)

		if slot10[2] <= ItemTools.getItemNum(slot11) then
			slot0.materialTxt_[slot9].text = slot13 .. "/" .. slot12
		else
			slot0.materialTxt_[slot9].text = string.format(slot5, slot13) .. "/" .. slot12
		end
	end

	slot0.materialCon_:SetSelectedState(#slot4)
end

function slot0.RefreshEventMap(slot0)
	slot1 = ActivityPushBoxData:GetPushBoxEmptyList(slot0.activityID_)
	slot2 = ActivityPushBoxData

	table.sort(slot2:GetMapEventList(slot0.activityID_), function (slot0, slot1)
		return ActivityCelebrationOrderCfg[slot0].index < ActivityCelebrationOrderCfg[slot1].index
	end)

	slot3 = 1

	for slot7, slot8 in ipairs(slot0.eventItem_) do
		if not slot2[slot3] then
			break
		end

		if slot7 == ActivityCelebrationOrderCfg[slot2[slot3]].index then
			slot8:Show(true)
			slot8:SetData(slot9)

			slot3 = slot3 + 1
		else
			slot8:Show(false)
		end
	end

	for slot8 = ActivityCelebrationOrderCfg[slot2[#slot2]].index + 1, #slot0.eventItem_ do
		slot0.eventItem_[slot8]:Show(false)
	end

	for slot8, slot9 in ipairs(slot1) do
		slot11 = ActivityCelebrationOrderCfg[slot9].index

		slot0.eventItem_[slot11]:Show(true)
		slot0.eventItem_[slot11]:RefreshCountDown(slot9)
	end

	slot5 = ActivityPushBoxData:GetRefreshTime(slot0.activityID_)
	slot0.refreshText_.text = GetTips("ACTIVITY_PUSH_BOX_REFRESH") .. slot5

	slot0.refreshCon_:SetSelectedState(slot5 > 0 and "true" or "false")
	slot0:SetSelectItem(0)
end

function slot0.SetSelectItem(slot0, slot1)
	slot0.idleCon_:SetSelectedState(slot1 == 0 and "true" or "false")

	for slot5, slot6 in ipairs(slot0.eventItem_) do
		slot6:SetSelect(slot1)
	end
end

function slot0.ClickEvent(slot0, slot1, slot2)
	slot0:SetSelectItem(slot1)
	slot0.sectionView_:Show(true)
	slot0.sectionView_:SetData(slot1, slot2)
	SetActive(slot0.bgBtn_.gameObject, true)
end

function slot0.OnPushBoxMapRefresh(slot0)
	slot0.ani_:Play("JapanRegionUI_2_10MaterialCollectionUI", -1, 0)
	slot0:RefreshEventMap()
	slot0.sectionView_:Show(false)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		ACTIVITY_COIN
	})
	manager.windowBar:SetActivityId(ACTIVITY_COIN, slot0.activityID_)
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	slot0.sectionView_:OnExit()
	manager.windowBar:HideBar()

	for slot4, slot5 in ipairs(slot0.eventItem_) do
		slot5:OnExit()
	end

	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.sectionView_:Dispose()

	for slot4, slot5 in ipairs(slot0.eventItem_) do
		slot5:Dispose()
	end

	slot0.super.Dispose(slot0)
end

return slot0
