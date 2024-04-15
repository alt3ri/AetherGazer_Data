ChapterPlot19MapBaseLocation = import(".ChapterPlot19MapBaseLocation")
slot0 = class("ChapterPlot19MapNormalLocation", ChapterPlot19MapBaseLocation)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1, slot2)

	slot0.controller_ = slot0.controllerEx_:GetController("stage")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if not ChapterTools.IsEnableLocation(uv0.locationID_) then
			return
		end

		BattleFieldData:SetChapterLocationID(uv0.chapterID_, uv0.locationID_)
		manager.notify:Invoke(CHAPTER_SELECT_LOCATION)
		uv0:Go("chapterPlot19MapLocationInfo", {
			chapterID = uv0.chapterID_,
			locationID = uv0.locationID_
		})
	end)
end

function slot0.UpdateLocation(slot0)
	uv0.super.UpdateLocation(slot0)

	slot1 = slot0.locationID_
	slot0.nameText_.text = GetI18NText(ChapterLocationCfg[slot1].name)

	if ChapterTools.HasNewLocationMainStage(slot1) then
		slot0.controller_:SetSelectedState("state1")
	elseif ChapterTools.HasNewLocationStage(mapID, slot1) then
		slot0.controller_:SetSelectedState("state0")
	else
		slot0.controller_:SetSelectedState("state2")
	end
end

function slot0.Show(slot0, slot1)
	uv0.super.Show(slot0, slot1)

	if slot1 and slot0.needRefreshAnimaor_ then
		slot0.animator_:Play("verStage", -1, 0)
	end

	slot0.needRefreshAnimaor_ = false
end

return slot0
