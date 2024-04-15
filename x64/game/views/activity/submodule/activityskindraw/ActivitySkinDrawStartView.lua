slot0 = class("ActivitySkinDrawStartView", ReduxView)

function slot0.UIName(slot0)
	return ActivitySkinDrawTools.GetDrawStartUIName(slot0.params_.activityID)
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
		sound_2 = "search_scene_02_purple",
		sound_3 = "search_scene_02_gold",
		sound_1 = "search_scene_02_blue",
		sound_special = "search_scene_02_special"
	}
	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.skipBtn_, nil, function ()
		uv0.skip_ = true

		if uv0.isPlaying_ then
			if uv0.playable_ then
				uv0.playable_:Stop()
			end
		else
			uv0:SkipFunc()
		end
	end)
	slot0:AddBtnListener(slot0.drawInteractBtn_, nil, function ()
		uv0.isPlaying_ = true
		uv0.drawInteractBtn_.enabled = false

		manager.audio:PlayEffect("ui_system_search", uv0.effect_, "")

		if uv0.playable_ then
			TimelineTools.PlayTimelineWithCallback(uv0.playable_, uv0.playable_.playableAsset, function ()
				if not uv0.skip_ then
					uv0:AfterTimeline(uv0.list_)
				else
					uv0:SkipFunc()
				end
			end)
		else
			uv0:AfterTimeline(uv0.list_)
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.skip_ = false
	slot0.isPlaying_ = false

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.drawInteractBtn_.enabled = true
	slot1 = slot0.params_.draw_list or {}
	slot0.list_ = {}
	slot0.maxRare_ = 0
	slot0.isSkin_ = false
	slot0.isScene_ = false
	slot2 = {}

	for slot6 = #slot1, 1, -1 do
		if ItemCfg[ActivityLimitedDrawPoolCfg[slot1[slot6]].reward[1][1]].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			slot0.isSkin_ = true
			slot0.skinDropID_ = slot7
		elseif slot12 == ItemConst.ITEM_TYPE.SCENE then
			slot0.isScene_ = true
		end

		table.insert(slot0.list_, slot7)
		table.insert(slot2, slot9)

		slot13 = 1
		slot13 = slot11.rare >= 5 and 3 or slot11.rare == 4 and 2 or 1
		slot0.maxRare_ = slot13 < slot0.maxRare_ and slot0.maxRare_ or slot13
	end

	slot3 = nil

	if slot0.isSkin_ or slot0.isScene_ then
		slot0.typeCon_:SetSelectedState("special")

		slot3 = slot0.timelineGo_special
		slot0.effect_ = slot0.soundEffect_.sound_special
	else
		slot0.typeCon_:SetSelectedState(slot0.maxRare_)

		slot3 = slot0["timelineGo_" .. slot0.maxRare_]
		slot0.effect_ = slot0.soundEffect_["sound_" .. slot0.maxRare_]
	end

	if slot3 then
		slot0.playable_ = slot3:GetComponent("PlayableDirector")

		slot0.playable_:Evaluate()

		slot0.playable_.time = 0
	end
end

function slot0.SkipFunc(slot0)
	if #slot0.list_ > 1 then
		if slot0.isSkin_ then
			slot0:AfterTimeline({
				slot0.skinDropID_
			})
		else
			JumpTools.OpenPageByJump("/activitySkinResultReward", {
				list = slot0.list_,
				activityID = slot0.params_.activityID
			})
		end
	else
		slot0:AfterTimeline(slot0.list_)
	end
end

function slot0.AfterTimeline(slot0, slot1)
	JumpTools.OpenPageByJump("/activitySkinDrawReward", {
		showList = slot1,
		list = slot0.list_,
		activityID = slot0.params_.activityID
	})
end

function slot0.OnTop(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnExit(slot0)
	slot0.playable_.time = 0
	slot0.playable_ = nil
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
