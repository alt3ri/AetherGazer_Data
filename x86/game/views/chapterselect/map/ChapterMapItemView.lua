slot0 = class("ChapterMapItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.parent_ = slot2
	slot0.viewportTransform_ = slot2.transform.parent
	slot0.width_ = slot0.viewportTransform_.rect.width / 2
	slot0.alphaScale_ = 0.0007692307692307692

	slot0:InitUI()
	slot0:AddListeners()
	slot0:Show(true)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
	if slot0.chapterClientID_ then
		manager.redPoint:unbindUIandKey(slot0.itemRect_, string.format("%s_%s", RedPointConst.COMBAT_PLOT, slot0.chapterClientID_))
	end

	slot0:StopTimer()
	slot0:StopTween()
	slot0:RemoveActivityTimer()
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.lockController_ = slot0.controllerEx_:GetController("lock")
	slot0.activityController_ = slot0.controllerEx_:GetController("activityFlag")
	slot0.selectController_ = slot0.controllerEx_:GetController("chapter")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		slot0 = uv0.hardLevel_
		slot1 = uv0.chapterClientID_
		slot2 = BattleFieldData:GetCacheChapter(slot1)

		if ChapterClientCfg[BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)].id ~= slot1 then
			manager.audio:PlayUIAudioByVoice("stage_slide")
			BattleFieldAction.ChangeSelectChapterID(slot2)

			return
		end

		slot5, slot6 = ChapterTools.IsFinishPreChapter(slot2)

		if not slot5 then
			ShowTips(ChapterTools.GetChapterLockText(slot2, slot6))

			return
		end

		ChapterTools.GotoChapterSection(slot2)
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.btn_.onClick:RemoveAllListeners()
end

function slot0.RefreshData(slot0)
	slot1 = slot0.chapterClientID_
	slot2 = ChapterClientCfg[slot1].chapter_list[1]
	slot0.collectRate_ = ChapterTools.GetChapterClientFinishPercentage(slot1)
	slot0.isLock_ = not ChapterTools.IsFinishPreChapter(slot2)
	slot0.hardLevel_ = ChapterCfg[slot2].type
end

function slot0.RefreshUI(slot0)
	slot0:RefreshItem()
	slot0:RefreshLock()
	slot0:RefreshActivity()
	slot0:RefreshCollect()
end

function slot0.RefreshItem(slot0)
	if slot0.oldChapterClientID_ ~= slot0.chapterClientID_ then
		slot2 = ChapterClientCfg[slot1]
		slot0.chapterName_.text = GetI18NText(slot2.name)
		slot0.chapterDesc_.text = GetI18NText(slot2.desc)

		getSpriteWithoutAtlasAsync(SpritePathCfg.ChapterPaint.path .. slot2.chapter_paint, function (slot0)
			if uv0.chapterPaint_ then
				uv0.chapterPaint_.sprite = slot0
			end
		end)

		slot0.oldChapterClientID_ = slot1
	end
end

function slot0.RefreshLock(slot0)
	slot0.lockController_:SetSelectedState(tostring(slot0.isLock_))
end

function slot0.RefreshActivity(slot0)
	slot0.activityController_:SetSelectedState(tostring(ActivityData:GetActivityIsOpen(ChapterCfg[ChapterClientCfg[slot0.chapterClientID_].chapter_list[1]].activity_id)))
end

function slot0.RefreshHardLevel(slot0)
	slot0.chapterLevelText_.text = GetTips(BattleConst.HARD_LANGUAGE[slot0.hardLevel_])
end

function slot0.RefreshCollect(slot0)
	slot0.collectText_.text = string.format("%s%%", math.floor(slot0.collectRate_ * 100))
end

function slot0.PlayAnimate(slot0)
	slot0:AddUpdate()
	slot0:StopTween()

	slot0.collectProgress_.fillAmount = 0
	slot0.tweenValue_ = LeanTween.value(slot0.gameObject_, 0, slot0.collectRate_, 0.5):setOnUpdate(LuaHelper.FloatAction(function (slot0)
		uv0.collectProgress_.fillAmount = slot0
	end)):setOnComplete(LuaHelper.VoidAction(function ()
		uv0.tweenValue_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

		uv0.tweenValue_ = nil
	end)):setEase(LeanTweenType.easeOutQuad):setDelay(0.2)
end

function slot0.StopTween(slot0)
	if slot0.tweenValue_ then
		slot0.tweenValue_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.gameObject_)

		slot0.tweenValue_ = nil
	end
end

function slot0.SetChapterClientID(slot0, slot1)
	if slot0.chapterClientID_ then
		manager.redPoint:unbindUIandKey(slot0.itemRect_, string.format("%s_%s", RedPointConst.COMBAT_PLOT, slot0.chapterClientID_))
	end

	slot0.chapterClientID_ = slot1
	slot0.transform_.name = slot1

	manager.redPoint:bindUIandKey(slot0.itemRect_, string.format("%s_%s", RedPointConst.COMBAT_PLOT, slot0.chapterClientID_))
	slot0:RefreshData()
	slot0:RefreshUI()

	if not (slot0.chapterClientID_ == slot1) then
		slot0:PlayAnimate()
	end

	slot0:AddActivityTimer()
	slot0:Show(true)
end

function slot0.SetLocalPosition(slot0, slot1)
	slot0.transform_.localPosition = slot1
end

function slot0.GetLocalPosition(slot0)
	return slot0.transform_.localPosition + slot0.parent_.transform.localPosition
end

function slot0.Show(slot0, slot1)
	if slot1 == false then
		slot0:SetLocalPosition(Vector3(1000000000000.0, 1000000000000.0, 1000000000000.0))
	else
		SetActive(slot0.gameObject_, slot1)
	end
end

function slot0.Hide(slot0, slot1)
	slot1 = slot1 and ChapterTools.HasChapterStage(slot0.chapterClientID_)

	SetActive(slot0.gameObject_, slot1)

	if slot1 then
		slot0:PlayAnimate()
	end
end

function slot0.Scale(slot0, slot1)
	slot0.transform_.localScale = Vector3(slot1, slot1, 1)
end

function slot0.SetAlpha(slot0, slot1)
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.AddUpdate(slot0)
	slot0:StopTimer()
	slot0:CalcScale()

	slot0.timer_ = FrameTimer.New(function ()
		uv0:CalcScale()
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.CalcScale(slot0)
	if math.abs(slot0:GetLocalPosition().x - slot0.width_) < slot0.width_ * 2 then
		slot0:Scale(1 - slot2 / (slot0.width_ * 10))
	end
end

function slot0.SetSelectID(slot0, slot1)
	if slot0.chapterClientID_ == slot1 then
		slot0.selectController_:SetSelectedState("select")
		slot0:PlayAnimate()
	else
		slot0.selectController_:SetSelectedState("normal")
	end
end

function slot0.GetChapterClientID(slot0)
	return slot0.chapterClientID_
end

function slot0.IsLock(slot0)
	return slot0.isLock_
end

function slot0.AddActivityTimer(slot0)
	slot0:RemoveActivityTimer()

	if ChapterCfg[ChapterClientCfg[slot0.chapterClientID_].chapter_list[1]].activity_id == 0 then
		return
	end

	slot5 = ActivityData:GetActivityData(slot3):IsActivitying()
	slot0.activityTimer_ = Timer.New(function ()
		if ActivityData:GetActivityData(uv0):IsActivitying() ~= uv1 then
			uv1 = slot1
			uv2.isLock_ = not ChapterTools.IsFinishPreChapter(uv3)

			uv2:RefreshLock()
			uv2:RefreshActivity()
		end
	end, 1, -1)

	slot0.activityTimer_:Start()
end

function slot0.RemoveActivityTimer(slot0)
	if slot0.activityTimer_ then
		slot0.activityTimer_:Stop()

		slot0.activityTimer_ = nil
	end
end

return slot0
