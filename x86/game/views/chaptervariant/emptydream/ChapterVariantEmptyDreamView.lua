ChapterVariantBaseView = import("game.views.chapterVariant.base.ChapterVariantBaseView")
slot0 = class("ChapterVariantEmptyDreamView", ChapterVariantBaseView)

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	slot0.skuldBtnController_ = ControllerUtil.GetController(slot0.skuldbtn_.transform, "isbreach")
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	SetActive(slot0.gameObject_, not slot0.isLock_)
	SetActive(slot0.skuldbtn_.gameObject, SkuldTravelData:GetSkuldTravelIsOpen())
	slot0.skuldBtnController_:SetSelectedState(SkuldTravelData:GetSkuldBtnIsBreach() and "true" or "false")
	manager.redPoint:bindUIandKey(slot0.skuldbtn_.transform, RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.skuldbtn_.transform, RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
end

function slot0.GetItemClass(slot0)
	return ChapterVariantEmptyDreamItem
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.skuldbtn_, nil, function ()
		if SkuldTravelData:GetSkuldTravelIsOpen() then
			JumpTools.GoToSystem("/skuldTravelView")
		else
			slot0 = GameSetting.travel_skuld_unlock.value[1]
			slot2, slot3 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, slot0)

			ShowTips(string.format(GetTips("MISSION_PROGRESS_UNLOCK_EX"), getChapterDifficulty(slot0), slot2 .. "-" .. slot3))
		end
	end)
end

return slot0
