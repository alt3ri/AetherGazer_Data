slot0 = class("IndiaNianDetailView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaNianUI/IndiaNianExplainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.stageItemList_ = {}

	for slot4 = 1, 8 do
		table.insert(slot0.stageItemList_, IndiaNianStageDescItem.New(slot0["stageGo_" .. slot4]))
	end

	slot0.iconController_ = ControllerUtil.GetController(slot0.transform_, "icon")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bossBtn_, nil, function ()
		_G.IndiaNianDescSelectedIndex = 0
		uv0.selectedIndex_ = 0

		IndiaNianData:SetSelectedDescIndex(uv0.selectedIndex_)
		uv0:RefreshBossUI()
	end)
end

function slot0.OnDataUpdate(slot0)
	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.RefreshData(slot0)
	slot0.bossCfgIDList_ = IndiaNianCfg.get_id_list_by_activity_id[slot0.activityID_]
	slot0.round = IndiaNianData:GetRound()
	slot1 = {}
	slot2 = 1

	for slot6, slot7 in ipairs(slot0.bossCfgIDList_) do
		if IndiaNianCfg[slot7].group_id == 100 and not slot1[slot8.group_id] then
			slot0.bossCfg_ = slot8

			IndiaNianData:SetSelectedStage(slot0.bossCfg_.stage_id)
		elseif not slot1[slot8.group_id] then
			slot0.stageItemList_[slot2]:SetData(slot2, slot8)
			slot0.stageItemList_[slot2]:SetCallBack(function (slot0)
				_G.IndiaNianDescSelectedIndex = slot0
				uv0.selectedIndex_ = slot0

				uv0:RefreshUI()
			end)

			slot2 = slot2 + 1
		end

		slot1[slot8.group_id] = true
	end
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = IndiaNianData:GetActivityID()
	slot0.selectedIndex_ = _G.IndiaNianDescSelectedIndex or 0

	slot0:RefreshData()
	slot0:RefreshUI()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnExit(slot0)
	if slot0.stageItemList_ then
		for slot4 = 1, 8 do
			slot0.stageItemList_[slot4]:OnExit()
		end
	end
end

function slot0.RefreshUI(slot0)
	if slot0.selectedIndex_ == 0 then
		slot0:RefreshBossUI()

		return
	end

	slot1 = slot0.stageItemList_[slot0.selectedIndex_].cfg_
	slot0.descText_.text = slot1.desc
	slot0.nameText_.text = slot1.name

	slot0.iconController_:SetSelectedState("subBoss")

	slot5 = "Atlas/IndiaUI_2_8"
	slot6 = slot1.icon
	slot0.titleImg_.sprite = getSprite(slot5, slot6)

	for slot5, slot6 in ipairs(slot0.stageItemList_) do
		slot6:RefreshState()
	end
end

function slot0.RefreshBossUI(slot0)
	slot1 = slot0.bossCfg_
	slot0.descText_.text = slot1.desc
	slot0.nameText_.text = slot1.name
	slot5 = "boss"

	slot0.iconController_:SetSelectedState(slot5)

	for slot5, slot6 in ipairs(slot0.stageItemList_) do
		slot6:RefreshState()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.stageItemList_) do
		slot5:Dispose()
	end

	slot0.stageItemList_ = nil
end

return slot0
