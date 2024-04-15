slot0 = class("ActivityReforgeSkillView", ReduxView)
slot1 = "D46068"
slot2 = {
	USE = 2,
	ILLUSTRATED = 1
}
slot3 = {
	PASSIVE = 2,
	INITIATIVE = 1
}

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeSkillUI"
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

	slot0.initiativeSkillList_ = {
		{},
		{},
		{},
		{}
	}
	slot0.passiveSkillList_ = {}

	for slot4, slot5 in pairs(ActivityReforgeSkillCfg.all) do
		if ActivityReforgeSkillCfg[slot5].type == 1 then
			table.insert(slot0.initiativeSkillList_[slot6.slot], slot5)
		else
			table.insert(slot0.passiveSkillList_, slot5)
		end
	end

	slot0.viewStatusController_ = slot0.controllerEx_:GetController("viewStatus")
	slot0.curSkillStatusController_ = slot0.controllerEx_:GetController("curSkillStatus")
	slot4 = "skillStatus"
	slot0.skillStatusController_ = slot0.controllerEx_:GetController(slot4)
	slot0.initiativeList_ = {}

	for slot4 = 1, 4 do
		slot0.initiativeList_[slot4] = ActivityReforgeInitiativeSkillItem.New(slot0["initiativeSkillListGo" .. slot4 .. "_"])
	end

	slot0.passiveList_ = {}

	for slot4 = 1, 1 do
		slot0.passiveList_[slot4] = ActivityReforgePassiveSkillItem.New(slot0["passiveSkillListGo" .. slot4 .. "_"])
	end

	slot0.itemSelectHandler_ = handler(slot0, slot0.OnItemSelect)
end

function slot0.OnItemSelect(slot0, slot1)
	slot0.skillID_ = slot1

	if ActivityReforgeSkillCfg[slot0.skillID_].type == 1 then
		slot0.curViewStatus_ = uv0.INITIATIVE
	else
		slot0.curViewStatus_ = uv0.PASSIVE
	end

	slot0:RefreshUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.toggleBtn_, nil, function ()
		if uv0.curViewStatus_ == uv1.INITIATIVE then
			uv0.curViewStatus_ = uv1.PASSIVE
			uv0.skillID_ = uv0.passiveSkillList_[1]
		elseif uv0.curViewStatus_ == uv1.PASSIVE then
			uv0.curViewStatus_ = uv1.INITIATIVE
			uv0.skillID_ = uv0.initiativeSkillList_[1][1]
		end

		uv0:RefreshUI()
	end)
	slot0:AddBtnListener(slot0.buyBtn_, nil, function ()
		ActivityReforgeAction.BuySkill(uv0.chapterActivityID_, uv0.levelID_, uv0.skillID_, function ()
			ActivityReforgeAction.SelectSkill(uv0.chapterActivityID_, uv0.levelID_, uv0.skillID_, function ()
				ShowTips("ACTIVITY_REFORGE_BUY_SKILL")
			end)
		end)
	end)
	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		ActivityReforgeAction.SelectSkill(uv0.chapterActivityID_, uv0.levelID_, uv0.skillID_, function ()
			ShowTips("ACTIVITY_REFORGE_USE_SKILL")
		end)
	end)
	slot0:AddBtnListener(slot0.unUsebtn_, nil, function ()
		ActivityReforgeAction.UnSelectSkill(uv0.chapterActivityID_, uv0.levelID_, uv0.skillID_)
	end)
	slot0:AddBtnListener(slot0.panelUseBtn_, nil, function ()
		ActivityReforgeAction.SelectSkill(uv0.chapterActivityID_, uv0.levelID_, uv0.skillID_)
	end)
	slot0:AddBtnListener(slot0.panelUnUseBtn_, nil, function ()
		ActivityReforgeAction.UnSelectSkill(uv0.chapterActivityID_, uv0.levelID_, uv0.skillID_)
	end)
	slot0:AddBtnListener(slot0.panelSellBtn_, nil, function ()
		ActivityReforgeAction.SellSkill(uv0.chapterActivityID_, uv0.levelID_, uv0.skillID_)
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.chapterActivityID_ = slot0.params_.chapterActivityID
	slot0.levelID_ = slot0.params_.levelID
	slot0.viewType_ = slot0.params_.viewType

	if slot0.viewType_ == uv0.ILLUSTRATED then
		slot0.curViewStatus_ = uv1.INITIATIVE
		slot0.skillID_ = slot0.initiativeSkillList_[1][1]
	else
		slot0:InitEnterSelectSkill()
	end

	slot0:RefreshUI()
end

function slot0.OnTop(slot0)
	if slot0.viewType_ == uv0.USE then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_ACTIVITY_REFORGE
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function slot0.OnExit(slot0)
	for slot4 = 1, 4 do
		slot0.initiativeList_[slot4]:OnExit()
	end

	for slot4 = 1, 1 do
		slot0.passiveList_[slot4]:OnExit()
	end

	manager.windowBar:HideBar()
end

function slot0.InitEnterSelectSkill(slot0)
	if slot0.params_.skillID ~= nil and slot0.params_.skillID ~= 0 then
		slot0.skillID_ = slot0.params_.skillID

		if ActivityReforgeSkillCfg[slot0.skillID_].type == 1 then
			slot0.curViewStatus_ = uv0.INITIATIVE
		else
			slot0.curViewStatus_ = uv0.PASSIVE
		end
	elseif slot0.params_.slot_ and slot0.params_.viewStatus then
		if slot0.params_.viewStatus == uv0.INITIATIVE then
			if slot0.params_.slot_ < 1 or slot0.params_.slot_ > 4 then
				slot0.params_.slot_ = 1
			end

			slot0.skillID_ = slot0.initiativeSkillList_[slot0.params_.slot_][1]
		else
			slot0.skillID_ = slot0.passiveSkillList_[1]
		end
	elseif slot0.params_.viewStatus then
		slot0.curViewStatus_ = slot0.params_.viewStatus

		if slot0.params_.viewStatus == uv0.INITIATIVE then
			slot0.skillID_ = slot0.initiativeSkillList_[1][1]
		else
			slot0.skillID_ = slot0.passiveSkillList_[1]
		end
	end
end

function slot0.RefreshUI(slot0)
	if slot0.curViewStatus_ == uv0.INITIATIVE then
		slot4 = "initiative"

		slot0.viewStatusController_:SetSelectedState(slot4)

		for slot4 = 1, 4 do
			slot0.initiativeList_[slot4]:SetData(slot0.viewType_, slot0.initiativeSkillList_[slot4], slot0.itemSelectHandler_, slot0.activityID_, slot0.levelID_, slot4, slot0.skillID_)
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.initiativeSkillContentTrans_)
	else
		slot4 = "passive"

		slot0.viewStatusController_:SetSelectedState(slot4)

		for slot4 = 1, 1 do
			slot0.passiveList_[slot4]:SetData(slot0.viewType_, slot0.passiveSkillList_, slot0.itemSelectHandler_, slot0.activityID_, slot0.levelID_, slot0.skillID_)
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.passiveSkillContentTrans_)
	end

	if slot0.viewType_ == uv1.ILLUSTRATED then
		if ActivityReforgeData:GetSkillIsLock(slot0.activityID_, slot0.skillID_) then
			slot0.curSkillStatusController_:SetSelectedState("lock")

			slot0.lockDesText_.text = ActivityReforgeSkillCfg[slot0.skillID_].lock_des
		else
			slot0.skillImage_.sprite = getSprite("Atlas/ValhallaSkillAtlas", slot1.icon)
			slot0.skillBgImage_.sprite = getSprite("Atlas/ValhallaSkillAtlas", slot1.bg_name)
			slot0.skillName_.text = slot1.name
			slot0.buffText_.text = slot1.desc_effect
			slot0.debuffText_.text = slot1.desc_negative
			slot0.skillDesText_.text = slot1.desc_background
			slot0.costText_.text = slot1.cost

			if slot1.count == -1 then
				slot0.curSkillStatusController_:SetSelectedState("illustratedFreeNormal")
			else
				slot0.curSkillStatusController_:SetSelectedState("illustratedNormal")

				slot6 = "useNum" .. slot1.count

				slot0.skillStatusController_:SetSelectedState(slot6)

				for slot6 = 1, 3 do
					SetActive(slot0["useNumGo" .. slot6 .. "_"], true)
				end
			end
		end
	else
		slot0.skillStatus_, slot0.skillCanUseNum_ = ActivityReforgeData:GetSkillStatus(slot0.activityID_, slot0.levelID_, slot0.skillID_)

		slot0.curSkillStatusController_:SetSelectedState(slot0.skillStatus_)

		if slot0.skillStatus_ == "lock" then
			slot0.lockDesText_.text = slot1.lock_des
		end

		if slot0.skillStatus_ == "freeUsing" or slot0.skillStatus_ == "freeNormal" or slot0.skillStatus_ == "haveNot" or slot0.skillStatus_ == "using" or slot0.skillStatus_ == "haveNotFree" or slot0.skillStatus_ == "infiniteUsing" or slot0.skillStatus_ == "infiniteNormal" or slot0.skillStatus_ == "normal" then
			slot0.skillImage_.sprite = getSprite("Atlas/ValhallaSkillAtlas", slot1.icon)
			slot0.skillBgImage_.sprite = getSprite("Atlas/ValhallaSkillAtlas", slot1.bg_name)
			slot0.skillName_.text = slot1.name
			slot0.buffText_.text = slot1.desc_effect
			slot0.debuffText_.text = slot1.desc_negative
			slot0.skillDesText_.text = slot1.desc_background

			if ActivityReforgeAction.CheckGold(slot1.cost, false) then
				slot0.costText_.text = slot1.cost
			else
				slot0.costText_.text = "<color=#" .. uv2 .. ">" .. slot1.cost .. "</color>"
			end
		end

		if slot0.skillStatus_ == "haveNot" or slot0.skillStatus_ == "using" or slot0.skillStatus_ == "normal" then
			slot6 = "useNum" .. slot1.count

			slot0.skillStatusController_:SetSelectedState(slot6)

			for slot6 = 1, 3 do
				if slot6 <= slot0.skillCanUseNum_ then
					SetActive(slot0["useNumGo" .. slot6 .. "_"], true)
				else
					SetActive(slot0["useNumGo" .. slot6 .. "_"], false)
				end
			end
		end
	end
end

function slot0.OnActivityReforgeCurLevelUpdate(slot0)
	slot0:RefreshUI()

	if slot0.viewType_ == uv0.USE then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_ACTIVITY_REFORGE
		})
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.initiativeList_) do
		slot0.initiativeList_[slot4]:Dispose()

		slot0.initiativeList_[slot4] = nil
	end

	slot0.initiativeList_ = nil

	for slot4, slot5 in pairs(slot0.passiveList_) do
		slot0.passiveList_[slot4]:Dispose()

		slot0.passiveList_[slot4] = nil
	end

	slot0.passiveList_ = nil
	slot0.itemSelectHandler_ = nil

	slot0.super.Dispose(slot0)
end

return slot0
