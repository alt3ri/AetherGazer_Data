slot0 = class("HeroClueMainView", ReduxView)

function slot0.UIName(slot0)
	return HeroClueTools.GetMainViewUIName(slot0.params_.activtiyID)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.clueItemList_ = {}
	slot2 = nil

	for slot6 = 1, slot0.clueContentTrans_.childCount do
		slot2 = slot0.clueContentTrans_:GetChild(slot6 - 1).gameObject
		slot0.clueItemList_[slot6] = HeroClueItem.New(slot2, tonumber(slot2.name), slot0.params_.activityID, slot6)
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.drawBtn_, nil, function ()
		if not ActivityTools.ActivityOpenCheck(uv0.activityID_) then
			return
		end

		slot0 = true

		for slot5, slot6 in ipairs(uv0.clueIdList_) do
			if not HeroClueData:GetUnlockClueDataDic()[slot6] then
				slot0 = false

				break
			elseif slot1[slot6].level < #HeroClueCfg[slot6].level then
				slot0 = false

				break
			end
		end

		if slot0 == true then
			ShowTips("ACTIVITY_HERO_CLUE_ALL_COLLECTED")

			return
		end

		if ItemTools.getItemNum(HeroCluePoolCfg[uv0.cluePoolID_].item_id) < 1 then
			ShowTips("ACTIVITY_HERO_CLUE_PACKAGE_NULL")

			return
		end

		HeroClueAction.Draw(uv0.activityID_, uv0.cluePoolID_, 1)
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if not ActivityTools.ActivityOpenCheck(uv0.activityID_) then
			return
		end

		JumpTools.OpenPageByJump("heroClueTask", {
			activityID = HeroClueTools.GetPlayTaskActivityID(uv0.activityID_),
			mainActivityID = uv0.activityID_
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.cluePoolID_ = HeroCluePoolCfg.get_id_list_by_activity_id[slot0.activityID_][1]
	slot0.clueIdList_ = HeroClueCfg.get_id_list_by_clue_pool[slot0.cluePoolID_]

	for slot4, slot5 in pairs(slot0.clueItemList_) do
		slot5:OnEnter()
	end

	slot0:RefreshUI()
	slot0:BindRedPoint()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		HeroCluePoolCfg[slot0.cluePoolID_].item_id
	})
	manager.windowBar:SetBarCanClick(HeroCluePoolCfg[slot0.cluePoolID_].item_id, true)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in pairs(slot0.clueItemList_) do
		slot5:OnExit()
	end

	slot0:UnBindRedPoint()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.clueItemList_) do
		slot5:Dispose()
	end

	slot0.clueItemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshCoin()
	slot0:RefreshClue()
end

function slot0.RefreshClue(slot0)
	for slot4, slot5 in pairs(slot0.clueItemList_) do
		slot5:RefreshUI()
	end
end

function slot0.RefreshCoin(slot0)
	slot0.coinNum_.text = 1
	slot0.coinIcon_.sprite = ItemTools.getItemSprite(HeroCluePoolCfg[slot0.cluePoolID_].item_id)
end

function slot0.OnClueDraw(slot0, slot1)
	slot0:RefreshUI()
	JumpTools.OpenPageByJump("heroClueDrawResult", {
		activityID = slot0.activityID_,
		rewardList = slot1
	})
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, string.format("%s_%d", RedPointConst.ACTIVITY_TASK, ActivityCfg[slot0.activityID_].sub_activity_list[2]))
	manager.redPoint:bindUIandKey(slot0.drawBtn_.transform, string.format("%s_%d", RedPointConst.HERO_CLUE_DRAW, slot0.activityID_))
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, string.format("%s_%d", RedPointConst.ACTIVITY_TASK, ActivityCfg[slot0.activityID_].sub_activity_list[2]))
	manager.redPoint:unbindUIandKey(slot0.drawBtn_.transform, string.format("%s_%d", RedPointConst.HERO_CLUE_DRAW, slot0.activityID_))
end

return slot0
