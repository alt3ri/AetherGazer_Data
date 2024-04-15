slot0 = class("ActivityPushBoxSectionView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroAffixItem_ = {}
	slot0.enemyAffixItem_ = {}
	slot0.statusCon_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.levelCon_ = ControllerUtil.GetController(slot0.transform_, "level")
	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.costCon_ = ControllerUtil.GetController(slot0.transform_, "cost")
	slot0.boxStateCon_ = ControllerUtil.GetController(slot0.transform_, "boxOrder")
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, CommonItem)
	slot0.boxScrollHelper_ = LuaList.New(handler(slot0, slot0.BoxIndexItem), slot0.boxListGo_, PushBoxReplayItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.list_[slot1]))
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_MERGE_ITEM, {
			slot0.id
		})
	end)
end

function slot0.BoxIndexItem(slot0, slot1, slot2)
	slot2:RefreshData(slot0.boxList_[slot1])
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.battleBtn_, nil, function ()
		if not uv0:CheckTime() then
			return
		end

		if ActivityPushBoxData:GetFatigue(uv0.mainActivityID_) < uv0.cfg_.cost then
			ShowTips("ORDER_FATIGUE_NOT_ENOUGH")

			return
		end

		JumpTools.OpenPageByJump("/sectionSelectHero", {
			section = uv0.cfg_.param,
			sectionType = BattleConst.STAGE_TYPE_NEW.PUSH_BOX_BATTLE,
			activityID = uv0.mainActivityID_,
			dest_id = uv0.id_
		})
	end)
	slot0:AddBtnListener(slot0.boxBtn_, nil, function ()
		if not uv0:CheckTime() then
			return
		end

		JumpTools.OpenPageByJump("/pushBox", {
			map_id = uv0.cfg_.param,
			activityID = uv0.mainActivityID_,
			id = uv0.id_
		})
	end)
	slot0:AddBtnListener(slot0.boxTypeBtn_, nil, function ()
		uv0.boxType_ = 1 - uv0.boxType_

		uv0:RefreshBoxType()
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.id_ = slot1
	slot0.isClose_ = slot2
	slot0.cfg_ = ActivityCelebrationOrderCfg[slot0.id_]

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.RefreshData(slot0)
	slot0.activityID_ = slot0.cfg_.activity_id
	slot0.mainActivityID_ = slot0.cfg_.main_activity
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
end

function slot0.RefreshUI(slot0)
	if slot0.cfg_.type == PushBoxConst.EVENT_TYPE.BATTLE then
		slot0:RefreshBattle()
	elseif slot0.cfg_.type == PushBoxConst.EVENT_TYPE.PUSH_BOX then
		slot0:RefreshBox()
	end

	slot0:RefreshReward()
end

function slot0.RefreshBattle(slot0)
	slot0.battleDesc_.text = slot0.cfg_.order_desc
	slot0.battleTitle_.text = slot0.cfg_.order_title
	slot1 = slot0.cfg_.cost
	slot0.battleCost_.text = slot1
	slot0.battleIcon_.sprite = ItemTools.getItemLittleSprite(PushBoxTool:GetFatigueID(slot0.activityID_))

	slot0.costCon_:SetSelectedState(slot1 <= ActivityPushBoxData:GetFatigue(slot0.mainActivityID_) and "true" or "false")

	slot5 = getMosterAffix(slot0.cfg_.affix_list)

	for slot9, slot10 in ipairs(getHeroAffixs(slot0.cfg_.affix_list)) do
		if not slot0.heroAffixItem_[slot9] then
			slot0.heroAffixItem_[slot9] = PushBoxAffixItem.New(slot0.affixGo_, slot0.heroAffixContent_)
		end

		slot0.heroAffixItem_[slot9]:SetData(slot10)
	end

	for slot9 = #slot4 + 1, #slot0.heroAffixItem_ do
		slot0.heroAffixItem_[slot9]:SetActive(false)
	end

	for slot9, slot10 in ipairs(slot5) do
		if not slot0.enemyAffixItem_[slot9] then
			slot0.enemyAffixItem_[slot9] = PushBoxAffixItem.New(slot0.affixGo_, slot0.enemyAffixContent_)
		end

		slot0.enemyAffixItem_[slot9]:SetData(slot10)
	end

	for slot9 = #slot5 + 1, #slot0.enemyAffixItem_ do
		slot0.enemyAffixItem_[slot9]:SetActive(false)
	end

	slot0.statusCon_:SetSelectedState("normal")
	slot0.typeCon_:SetSelectedState("challenge")
	slot0.levelCon_:SetSelectedState(slot0.cfg_.hard)
	slot0.boxStateCon_:SetSelectedState("normal")
end

function slot0.RefreshBox(slot0)
	slot0.boxType_ = 1
	slot0.boxDesc_.text = slot0.cfg_.order_desc
	slot0.boxTitle_.text = slot0.cfg_.order_title

	slot0:RefreshTime()
	slot0:RefreshHistory()
	slot0:RefreshBoxType()
	slot0.typeCon_:SetSelectedState("box")
	slot0.statusCon_:SetSelectedState(slot0.isClose_ and "complete" or "normal")
end

function slot0.RefreshTime(slot0)
	slot0:StopTimer()

	if ActivityPushBoxData:GetNextID(slot0.mainActivityID_, slot0.id_) == 0 then
		SetActive(slot0.timeGo_, false)

		return
	end

	SetActive(slot0.timeGo_, true)

	slot0.countDownTxt_.text = manager.time:DescCDTime(manager.time:GetNextFreshTime() - manager.time:GetServerTime())
	slot0.timer_ = Timer.New(function ()
		uv0 = manager.time:GetServerTime()
		uv1.countDownTxt_.text = manager.time:DescCDTime(uv2 - uv0)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshHistory(slot0)
	slot0.boxList_ = ActivityPushBoxData:GetFinishList(slot0.mainActivityID_)

	table.sort(slot0.boxList_, function (slot0, slot1)
		return slot0 < slot1
	end)
	slot0.boxScrollHelper_:StartScroll(#slot0.boxList_)
end

function slot0.RefreshBoxType(slot0)
	slot0.boxStateCon_:SetSelectedState(slot0.boxType_ == 1 and "normal" or "pastRecords")
end

function slot0.RefreshReward(slot0)
	slot0.list_ = slot0.cfg_.award_list

	slot0.scrollHelper_:StartScroll(#slot0.list_)
end

function slot0.CheckTime(slot0)
	if manager.time:GetServerTime() < slot0.startTime_ then
		ShowTips("SOLO_NOT_OPEN")

		return false
	end

	if slot0.stopTime_ <= slot1 then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.OnExit(slot0)
	slot0:StopTimer()

	slot3 = slot0.scrollHelper_
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.GetItemList(slot5)) do
		slot5:OnExit()
	end

	slot3 = slot0.boxScrollHelper_
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.GetItemList(slot5)) do
		slot5:OnExit()
	end

	for slot4, slot5 in ipairs(slot0.heroAffixItem_) do
		slot5:OnExit()
	end

	for slot4, slot5 in ipairs(slot0.enemyAffixItem_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot3 = slot0.scrollHelper_
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.GetItemList(slot5)) do
		slot5:Dispose()
	end

	slot0.scrollHelper_:Dispose()

	slot3 = slot0.boxScrollHelper_
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.GetItemList(slot5)) do
		slot5:Dispose()
	end

	slot0.boxScrollHelper_:Dispose()

	for slot4, slot5 in ipairs(slot0.heroAffixItem_) do
		slot5:Dispose()
	end

	for slot4, slot5 in ipairs(slot0.enemyAffixItem_) do
		slot5:Dispose()
	end

	slot0.super.Dispose(slot0)
end

return slot0
