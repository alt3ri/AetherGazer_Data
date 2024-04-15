slot0 = class("ChapterPlot19MapBaseLocation", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.selectController_ = slot0.controllerEx_:GetController("select")
end

function slot0.OnUpdate(slot0)
	slot0:UpdateLocation()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.AddListeners(slot0)
end

function slot0.SetLocationID(slot0, slot1, slot2, slot3)
	slot0.chapterID_ = slot1
	slot0.locationID_ = slot3

	if slot0.mapID_ ~= slot2 then
		slot0.needRefreshAnimaor_ = true
	else
		slot0.needRefreshAnimaor_ = false
	end

	slot0.mapID_ = slot2
	slot0.disabled_ = false

	slot0:UpdateLocation()
end

function slot0.UpdateLocation(slot0)
	slot0:Show(ChapterTools.NeedShowLocation(slot0.mapID_, slot0.locationID_))

	slot2 = ChapterLocationCfg[slot0.locationID_]
	slot0.transform_.localPosition = Vector3(slot2.position[1], slot2.position[2], slot2.position[3])
end

function slot0.Disabled(slot0)
	slot0.disabled_ = true

	slot0:Show(false)
end

function slot0.IsDisabled(slot0)
	return slot0.disabled_
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.RefreshSelectState(slot0, slot1)
	if slot0.locationID_ == BattleFieldData:GetChapterLocationID(slot0.chapterID_) and slot1 then
		slot0.selectController_:SetSelectedState("yes")
	else
		slot0.selectController_:SetSelectedState("no")
	end
end

return slot0
