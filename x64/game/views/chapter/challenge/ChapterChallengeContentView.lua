slot0 = class("ChapterChallengeContentView", import("..ChapterBaseContentView"))

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	uv0.super.OnCtor(slot0, slot1, slot2)

	slot0.initedItemIdList = {}
	slot0.refreshSortItemHandler_ = handler(slot0, slot0.RefreshSortItem)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.notify:RegistListener(CHALLENGE_CONTENT_REFRESH, slot0.refreshSortItemHandler_)
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.notify:RemoveListener(CHALLENGE_CONTENT_REFRESH, slot0.refreshSortItemHandler_)
end

function slot0.RefreshMapItems(slot0)
	for slot6 = 1, #ChapterClientCfg.get_id_list_by_toggle[slot0.chapterToggle_] do
		if ChapterTools.IsChapterSystemLock(slot2[slot6]) then
			-- Nothing
		elseif slot7 == BattleConst.DAMAGE_TEST_CHAPTER_ID and OperationData:IsFunctionStoped(OperationConst.OPERATION_STOP.DAMAGE_TEST) then
			-- Nothing
		elseif slot0.initedItemIdList[slot7] then
			-- Nothing
		elseif slot0:CreateItem(slot7) then
			table.insert(slot0.itemList_, {
				virtualItem = ChapterBaseVirtualItemView.New(slot0.mapVirtualItem_, slot0.itemParent_),
				renderItem = slot8
			})

			slot0.initedItemIdList[slot7] = true
		end
	end
end

function slot0.CreateItem(slot0, slot1)
	slot2 = nil

	if ChapterCfg[ChapterClientCfg[slot1].chapter_list[1]].type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER then
		slot2 = ChapterChallengeTownItemView.New(slot0.mapItem_, slot0.itemParent_, slot1, slot0.chapterToggle_)
	elseif slot4.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE then
		slot2 = ChapterChallengeBossItemView.New(slot0.mapItem_, slot0.itemParent_, slot1, slot0.chapterToggle_)
	elseif slot4.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC then
		slot2 = ChapterChallengeMythicItemView.New(slot0.mapItem_, slot0.itemParent_, slot1, slot0.chapterToggle_)
	elseif slot4.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
		slot2 = ChapterChallengeMatrixItemView.New(slot0.mapItem_, slot0.itemParent_, slot1, slot0.chapterToggle_)
	elseif slot4.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING or slot4.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING then
		slot2 = ChapterChallengeTeachItemView.New(slot0.mapItem_, slot0.itemParent_, slot1, slot0.chapterToggle_)
	elseif slot4.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		slot2 = ChapterChallengeWarChessItemView.New(slot0.mapItem_, slot0.itemParent_, slot1, slot0.chapterToggle_)
	elseif slot4.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAMAGE_TEST then
		slot2 = ChapterChallengeDamageTestItemView.New(slot0.mapItem_, slot0.itemParent_, slot1, slot0.chapterToggle_)
	elseif slot4.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ABYSS then
		slot2 = ChapterChallengeAbyssItemView.New(slot0.mapItem_, slot0.itemParent_, slot1, slot0.chapterToggle_)
	elseif slot4.type == BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON then
		slot2 = ChapterChallengeSoloHeartDemonItemView.New(slot0.mapItem_, slot0.itemParent_, slot1, slot0.chapterToggle_)
	elseif slot4.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST then
		if AdvanceTestData:GetisActivityOpen() then
			slot2 = ChapterChallengeAdvanceTestItemView.New(slot0.mapItem_, slot0.itemParent_, slot1, slot0.chapterToggle_)
		end
	elseif slot4.type == BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1 then
		if SPHeroChallengeTools:CheckActivityIsOpen(ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1) then
			slot2 = ChapterSPHeroChallengeItemView.New(slot0.mapItem_, slot0.itemParent_, slot1, slot0.chapterToggle_)
		end
	else
		slot2 = (slot4.type ~= BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION or ChapterChallengeCoreVerificationItemView.New(slot0.mapItem_, slot0.itemParent_, slot1, slot0.chapterToggle_)) and ChapterChallengeItemView.New(slot0.mapItem_, slot0.itemParent_, slot1, slot0.chapterToggle_)
	end

	return slot2
end

function slot0.Dispose(slot0)
	slot0.refreshSortItemHandler_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
