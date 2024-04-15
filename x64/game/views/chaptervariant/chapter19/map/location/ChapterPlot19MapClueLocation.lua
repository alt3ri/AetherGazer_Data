ChapterPlot19MapBaseLocation = import(".ChapterPlot19MapBaseLocation")
slot0 = class("ChapterPlot19MapClue", ChapterPlot19MapBaseLocation)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1, slot2)

	slot0.controller_ = slot0.controllerEx_:GetController("clue")
	slot0.onOpenClueInfoHandler_ = handler(slot0, slot0.OnOpenClueInfo)

	manager.notify:RegistListener(CHAPTER_GET_CLUE, slot0.onOpenClueInfoHandler_)
end

function slot0.Dispose(slot0)
	manager.notify:RemoveListener(CHAPTER_GET_CLUE, slot0.onOpenClueInfoHandler_)

	slot0.onOpenClueInfoHandler_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if not ChapterTools.IsEnableLocation(uv0.locationID_) then
			return
		end

		if ChapterLocationCfg[uv0.locationID_].need_scan == 0 then
			BattleStageAction.ReadLoacationClue(uv0.mapID_, uv0.locationID_, slot0.clue[1])
			JumpTools.OpenPageByJump("stageArchive", {
				isClue = true,
				archiveID = slot0.clue[1]
			})
		elseif slot0.type == BattleConst.LOCATION_TYPE.CLUE then
			if ChapterTools.IsReadClue(uv0.mapID_, uv0.locationID_) then
				JumpTools.OpenPageByJump("stageArchive", {
					isClue = true,
					archiveID = BattleStageData:GetMapLocationData(uv0.mapID_)[uv0.locationID_] or slot0.clue[1]
				})

				return
			end

			BattleStageAction.GetClueLocation(uv0.locationID_)
		elseif slot0.type == BattleConst.LOCATION_TYPE.BATTLE_CLUE then
			ChapterTools.DoReadyBattle(ChapterCfg[uv0.chapterID_].type, slot0.sub_stage_list[1])
		end
	end)
end

function slot0.UpdateLocation(slot0)
	uv0.super.UpdateLocation(slot0)

	slot1 = ChapterLocationCfg[slot0.locationID_]

	if ChapterTools.IsReadClue(slot0.mapID_, slot0.locationID_) then
		slot0.controller_:SetSelectedState("state2")
	elseif slot1.type == BattleConst.LOCATION_TYPE.CLUE then
		slot0.controller_:SetSelectedState("state0")
	else
		slot0.controller_:SetSelectedState("state1")
	end
end

function slot0.OnOpenClueInfo(slot0, slot1)
	if slot1 ~= slot0.locationID_ then
		return
	end

	slot0:UpdateLocation()
	JumpTools.OpenPageByJump("stageArchive", {
		archiveID = BattleStageData:GetMapLocationData(slot0.mapID_)[slot0.locationID_]
	})
end

function slot0.Show(slot0, slot1)
	uv0.super.Show(slot0, slot1)

	if slot1 and slot0.needRefreshAnimaor_ then
		slot0.animator_:Play("verClue", -1, 0)
	end

	slot0.needRefreshAnimaor_ = false
end

return slot0
