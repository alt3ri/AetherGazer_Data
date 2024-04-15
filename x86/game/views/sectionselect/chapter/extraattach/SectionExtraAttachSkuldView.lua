SectionExtraAttachBaseView = import("game.views.sectionSelect.chapter.extraAttach.SectionExtraAttachBaseView")
slot0 = class("SectionSkuldExtraAttachView", SectionExtraAttachBaseView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.parent_ = slot1
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot2), slot3.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot0:AddMoveFollowTimer()
	SetActive(slot0.gameObject_, true)
end

function slot0.OnExit(slot0)
	slot0:StopMoveFollowTimer()

	slot0.imageFlag_ = nil

	slot0:RemoveTween()
	SetActive(slot0.gameObject_, false)
end

function slot0.AddListeners(slot0)
end

function slot0.RefreshUI(slot0)
end

function slot0.CheckSkuldBtn(slot0)
end

function slot0.AddMoveFollowTimer(slot0)
	slot1 = slot0.parent_.chapterID_
	slot0.imagePanelTf_.localPosition = Vector3(slot0.parent_.contentRect_.localPosition.x * (ChapterCfg[slot1].max_width == 0 and (slot0.parent_.bgTf_.rect.width - slot0.parent_.viewportRect_.rect.width) / 2 or slot4 - ChapterCfg[slot1].max_width / 2) / (BattleChapterStageCfg[ChapterCfg[slot1].section_id_list[#ChapterCfg[slot1].section_id_list]].position[1] - slot0.parent_.viewportRect_.rect.width / 2), 0, 0)

	slot0:StopMoveFollowTimer()

	slot0.moveFollowTimer_ = FrameTimer.New(function ()
		uv0.imagePanelTf_.localPosition = Vector3(uv0.parent_.contentRect_.localPosition.x * uv1 / uv2, 0, 0)

		uv0:CheckImage()
	end, 1, -1)

	slot0.moveFollowTimer_:Start()
end

function slot0.StopMoveFollowTimer(slot0)
	if slot0.moveFollowTimer_ then
		slot0.moveFollowTimer_:Stop()

		slot0.moveFollowTimer_ = nil
	end
end

function slot0.CheckImage(slot0)
	if ChapterCfg[slot0.parent_.chapterID_].switch_bg_index == 0 then
		return
	end

	slot3 = ChapterCfg[slot1].section_id_list[slot2]
	slot5 = ChapterCfg[slot1].section_id_list[slot2 + 1]

	if slot0.parent_.contentRect_.localPosition.x * -1 < BattleChapterStageCfg[ChapterCfg[slot1].section_id_list[slot2 - 1]].position[1] - slot0.parent_.viewportRect_.rect.width / 2 and slot0.imageFlag_ ~= 1 then
		slot0.imageFlag_ = 1

		slot0:SwitchMiddleGB(1)
	elseif slot0.parent_.contentRect_.localPosition.x * -1 > BattleChapterStageCfg[slot5].position[1] - slot6 and slot0.imageFlag_ ~= 2 then
		slot0.imageFlag_ = 2

		slot0:SwitchMiddleGB(2)
	end
end

function slot0.SwitchMiddleGB(slot0, slot1)
	if slot0.imageFlag_ == nil then
		slot0.bgCanvas1_.alpha = slot1 ~= 1 and 1 or 0
		slot0.bgCanvas2_.alpha = slot1 == 1 and 1 or 0

		return
	end

	slot0:RemoveTween()

	if slot1 == 1 then
		slot0.tween_ = LeanTween.value(slot0.gameObject_, 1, 0, 0.5):setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.bgCanvas2_.alpha = slot0
			uv0.bgCanvas1_.alpha = 1 - slot0
		end)):setOnComplete(System.Action(function ()
			uv0.bgCanvas2_.alpha = 0

			uv0:RemoveTween()
		end)):setEase(LeanTweenType.easeOutSine)
	else
		slot0.tween_ = LeanTween.value(slot0.gameObject_, 1, 0, 0.5):setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.bgCanvas1_.alpha = slot0
			uv0.bgCanvas2_.alpha = 1 - slot0
		end)):setOnComplete(System.Action(function ()
			uv0.bgCanvas1_.alpha = 0

			uv0:RemoveTween()
		end)):setEase(LeanTweenType.easeOutSine)
	end
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.tween_.id)

		slot0.tween_ = nil
	end
end

return slot0
