slot0 = class("ActivitySkinDrawRewardView", ReduxView)

function slot0.UIName(slot0)
	return ActivitySkinDrawTools.GetDrawRewardUIName(slot0.params_.activityID)
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

	slot0.soundEffect_ = {
		sound_2 = "search_scene_03_purple",
		sound_3 = "search_scene_03_gold",
		sound_1 = "search_scene_03_blue",
		sound_special = "search_scene_03_special"
	}
	slot0.typeGo_ = {}
	slot0.typeItem_ = {}
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.nextBtn_, nil, function ()
		uv0:NextCode()
	end)
	slot0:AddBtnListener(slot0.skipBtn_, nil, function ()
		uv0:GotoResult()
	end)
end

function slot0.OnEnter(slot0)
	slot0.index_ = 0
	slot0.list_ = slot0.params_.list
	slot0.showList_ = slot0.params_.showList

	slot0:RefreshGoList()
	slot0:NextCode()
end

function slot0.RefreshGoList(slot0)
	if slot0.activityID_ ~= slot0.params_.activityID then
		slot0.typeGo_ = ActivitySkinDrawTools.GetTypeGo(slot0.params_.activityID)
		slot0.activityID_ = slot0.params_.activityID

		for slot4, slot5 in pairs(slot0.typeItem_) do
			slot5:Dispose()
		end

		slot0.typeItem_ = {}
	end
end

function slot0.NextCode(slot0)
	if slot0.curItem_ then
		slot0.curItem_:Hide()
	end

	if slot0.index_ < #slot0.showList_ then
		slot0.index_ = slot0.index_ + 1
		slot2 = ActivityLimitedDrawPoolCfg[slot0.showList_[slot0.index_]]
		slot4 = slot2.reward[1][2]
		slot5 = ItemCfg[slot2.reward[1][1]]
		slot6 = 1
		slot6 = slot2.minimum_guarantee == 2 and 3 or 2
		slot7 = false

		if ItemCfg[slot3].type == ItemConst.ITEM_TYPE.HERO_SKIN or slot8.type == ItemConst.ITEM_TYPE.SCENE then
			slot7 = true
		end

		if slot7 then
			if slot8.type == ItemConst.ITEM_TYPE.HERO_SKIN then
				slot0:ShowAni("special", slot8, slot4)
			else
				slot0:ShowReward("special", slot8, slot4)
			end
		else
			slot0:ShowReward(slot6, slot8, slot4)
		end
	else
		slot0:GotoResult()
	end
end

function slot0.ShowAni(slot0, slot1, slot2, slot3)
	manager.audio:PlayEffect("ui_system_search", "search_scene_musicdown", "")

	if not slot0.typeItem_.movie then
		slot0.typeItem_.movie = ActivitySkinDrawMovieView.New(Object.Instantiate(Asset.Load(slot0.typeGo_.movie), slot0.content_))
	end

	SetActive(slot0.skipBtn_, false)

	slot0.nextBtn_.interactable = false

	slot0.typeItem_.movie:SetData(slot2, function ()
		manager.audio:PlayEffect("ui_system_search", "search_scene_musicup", "")
		SetActive(uv0.skipBtn_, true)

		uv0.nextBtn_.interactable = true

		uv0:ShowReward(uv1, uv2, uv3)
	end)
end

function slot0.ShowReward(slot0, slot1, slot2, slot3)
	if not slot0.typeItem_[slot1] then
		slot0.typeItem_[slot1] = ActivitySkinDrawShowView.New(Object.Instantiate(Asset.Load(slot0.typeGo_[slot1]), slot0.content_))
	end

	slot0.typeItem_[slot1]:SetData(slot1, slot2, slot3)

	slot0.curItem_ = slot0.typeItem_[slot1]

	manager.audio:StopEffect()
	manager.audio:PlayEffect("ui_system_search", slot0.soundEffect_["sound_" .. slot1], "")
end

function slot0.GotoResult(slot0)
	if #slot0.list_ > 1 then
		JumpTools.OpenPageByJump("/activitySkinResultReward", {
			list = slot0.list_,
			activityID = slot0.params_.activityID
		})
	else
		JumpTools.OpenPageByJump("/activityskinDraw", {
			activityID = ActivityTools.GetMainActivityId(slot0.params_.activityID)
		})
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnExit(slot0)
	SetActive(slot0.skipBtn_, true)

	slot0.nextBtn_.interactable = true

	if slot0.curItem_ then
		slot0.curItem_:Hide()

		slot0.curItem_ = nil
	end

	for slot4, slot5 in pairs(slot0.typeItem_) do
		slot5:OnExit()
	end

	manager.audio:StopEffect()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in pairs(slot0.typeItem_) do
		slot5:Dispose()
	end

	slot0.super.Dispose(slot0)
end

return slot0
