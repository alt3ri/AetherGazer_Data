SectionExtraAttachBaseView = import("game.views.sectionSelect.chapter.extraAttach.SectionExtraAttachBaseView")
slot0 = class("SectionExtraAttachTimelineView", SectionExtraAttachBaseView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.parent_ = slot1
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot2), slot3.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.playableDirector_ = slot0.gameObject_:GetComponent(typeof(PlayableDirector))
end

function slot0.OnEnter(slot0)
	slot0:AddMoveFollowTimer()
	SetActive(slot0.gameObject_, true)
end

function slot0.OnExit(slot0)
	slot0:StopMoveFollowTimer()
	SetActive(slot0.gameObject_, false)
end

function slot0.AddMoveFollowTimer(slot0)
	slot1 = slot0.parent_.chapterID_

	slot0:Play(BattleChapterStageCfg[ChapterCfg[slot1].section_id_list[#ChapterCfg[slot1].section_id_list]].position[1] - slot0.parent_.viewportRect_.rect.width + slot0.parent_.viewportRect_.rect.width / 4)

	slot0.moveFollowTimer_ = FrameTimer.New(function ()
		uv0:Play(uv1)
	end, 1, -1)

	slot0.moveFollowTimer_:Start()
end

function slot0.Play(slot0, slot1)
	slot3 = slot0.parent_.chapterID_
	slot4 = ChapterCfg[slot3]
	slot5 = ChapterTools.GetUnclearStageCnt(slot3)

	if -1 * slot0.parent_.contentRect_.localPosition.x / slot1 < 0 then
		slot2 = 0
	elseif slot2 > 1 then
		slot2 = 1
	end

	slot6 = 1
	slot7 = #slot4.section_id_list - slot5

	if type(slot4.unlock_scroll_rate) == "table" then
		for slot11, slot12 in ipairs(slot4.unlock_scroll_rate) do
			if slot7 < slot12[1] then
				slot6 = slot12[2]

				break
			end
		end
	end

	if slot6 < slot2 then
		slot2 = slot6
	end

	slot0.playableDirector_.time = slot0.playableDirector_.duration * slot2

	slot0.playableDirector_:Evaluate()
end

function slot0.StopMoveFollowTimer(slot0)
	if slot0.moveFollowTimer_ then
		slot0.moveFollowTimer_:Stop()

		slot0.moveFollowTimer_ = nil
	end
end

return slot0
