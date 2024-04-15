ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")
slot0 = class("SpringFestivalMainViewV2", ActivityMainBaseView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaSpringMainUI/IndiaSpringMainUI"
end

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	slot0.clickBtnHandler_ = handler(slot0, slot0.ClickBtn)
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.InitSubmoduleButton(slot0)
	slot0.submoduleBtnList_ = {
		ActivitySubmoduleWithAnimationItem.New(slot0.btn1_, ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_COMBINE_GAME_TASK),
		ActivitySubmoduleWithAnimationItem.New(slot0.btn2_, ActivityConst.ACTIVITY_INDIA_NIAN),
		ActivitySubmoduleWithAnimationItem.New(slot0.btn3_, ActivityConst.ACTIVITY_2_8_QUIZ),
		ActivitySubmoduleWithAnimationItem.New(slot0.btn4_, ActivityConst.ACTIVITY_PUSH_SNOW_BALL),
		ActivitySubmoduleWithAnimationItem.New(slot0.btn5_, ActivityConst.ACTIVITY_2_8_SPRING_MEMORY),
		ActivitySubmoduleWithAnimationItem.New(slot0.btn6_, ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_WELFARE)
	}
end

function slot0.GetActivityID(slot0)
	return ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2
end

function slot0.OnEnter(slot0)
	slot0.stateCon_:SetSelectedState(0)
	uv0.super.OnEnter(slot0)

	if slot0.params_.isEnter then
		slot0:CheckStory()

		slot0.params_.isEnter = false
	end

	manager.notify:RegistListener(ACTIVITY_MAIN_CLICK_BTN, slot0.clickBtnHandler_)
end

function slot0.CheckStory(slot0)
	slot0.enterStoryID_ = GameSetting.spring_festival_memory_story_start.value[2]
	slot0.activityStoryID_ = GameSetting.spring_festival_memory_story_process.value[2]
	slot0.collectStoryID_ = GameSetting.spring_festival_memory_story_end.value[2]

	if slot0:CheckEnterStory() then
		slot0:PlayStory(slot0.enterStoryID_, function ()
			uv0.stateCon_:SetSelectedStateWithCallback(1, function ()
				ActivityTools.JumpToSubmodulePage(ActivityConst.ACTIVITY_2_8_SPRING_MEMORY)
			end)
		end)

		return
	end

	if slot0:CheckActivityStory() then
		slot0:PlayStory(slot0.activityStoryID_, function ()
			uv0.stateCon_:SetSelectedState(2)
		end)

		return
	end

	if slot0:CheckCollectStory() then
		slot0:PlayStory(slot0.collectStoryID_)

		return
	end
end

function slot0.CheckEnterStory(slot0)
	return slot0.enterStoryID_ and not manager.story:IsStoryPlayed(slot0.enterStoryID_)
end

function slot0.CheckActivityStory(slot0)
	if not slot0.activityStoryID_ or manager.story:IsStoryPlayed(slot0.activityStoryID_) then
		return false
	end

	return ActivityData:GetActivityData(GameSetting.spring_festival_memory_story_process.value[1]) and slot2:IsActivitying()
end

function slot0.CheckCollectStory(slot0)
	if not slot0.collectStoryID_ or manager.story:IsStoryPlayed(slot0.collectStoryID_) then
		return false
	end

	slot2 = ActivityConst.ACTIVITY_2_8_SPRING_MEMORY_TASK

	for slot7, slot8 in ipairs(SpringFestivalMemoryCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_2_8_SPRING_MEMORY]) do
		slot10 = SpringFestivalMemoryCfg[slot8].task_id

		if TaskData2:GetTask(slot10) and AssignmentCfg[slot10].need <= slot12.progress then
			slot1 = 0 + 1
		end
	end

	return GameSetting.spring_festival_memory_story_end.value[1] <= slot1
end

function slot0.PlayStory(slot0, slot1, slot2)
	manager.story:StartStoryById(slot1, function ()
		if uv0 then
			uv0()
		end
	end)
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.notify:RemoveListener(ACTIVITY_MAIN_CLICK_BTN, slot0.clickBtnHandler_)
	slot0:CancelTween()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.clickBtnHandler_ = nil
end

function slot0.RefreshUI(slot0)
end

function slot0.ClickBtn(slot0)
	manager.windowBar:HideBar()
	slot0:ShowBtnList(false)
	slot0:CancelTween()

	slot0.leanTween_ = LeanTween.scale(slot0.scrollTf_, Vector3(1.1, 1.1, 1.1), 0.5):setEase(LeanTweenType.easeOutCubic)
	slot0.scrollView_.enabled = false
end

function slot0.OnTop(slot0)
	slot0:ShowBtnList(true)

	slot0.scrollView_.enabled = true

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.ShowBtnList(slot0, slot1)
	SetActive(slot0.btn1_.transform, slot1)
	SetActive(slot0.btn2_.transform, slot1)
	SetActive(slot0.btn3_.transform, slot1)
	SetActive(slot0.btn4_.transform, slot1)
	SetActive(slot0.btn5_.transform, slot1)
	SetActive(slot0.btn6_.transform, slot1)

	slot0.scrollTf_.localScale = Vector3(1, 1, 1)
end

function slot0.CancelTween(slot0)
	if slot0.leanTween_ then
		LeanTween.cancel(slot0.scrollTf_)

		slot0.leanTween_ = nil
	end
end

return slot0
