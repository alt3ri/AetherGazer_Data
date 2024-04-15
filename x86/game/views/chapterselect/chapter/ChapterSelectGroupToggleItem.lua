slot0 = class("ChapterSelectGroupToggleItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.finishAllController_ = slot0.controllerEx_:GetController("finishAll")
end

function slot0.SetData(slot0, slot1)
	slot0.groupID_ = slot1
	slot0.nameText_.text = ChapterMainPlotToggleCfg[slot1].name

	slot0.finishAllController_:SetSelectedState(tostring(slot0:IsCollectAllStar()))
	slot0.transform_:SetAsLastSibling()
	slot0:Show(true)
end

function slot0.IsCollectAllStar(slot0)
	for slot5, slot6 in ipairs(ChapterMainPlotToggleCfg[slot0.groupID_].chapter_client_list) do
		if ChapterTools.GetChapterClientFinishPercentage(slot6) ~= 1 then
			return false
		end
	end

	return true
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		BattleFieldAction.ChangeSelectChapterID(ChapterClientCfg[ChapterMainPlotToggleCfg[uv0.groupID_].chapter_client_list[1]].chapter_list[1])
	end)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
