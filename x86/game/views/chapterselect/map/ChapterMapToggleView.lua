slot0 = class("ChapterMapToggleView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if table.keyof(ChapterMainPlotToggleCfg[uv0.id_].chapter_client_list, uv0.selectChapterClientID_) then
			return
		end

		BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, slot0.chapter_client_list[1])
		manager.notify:Invoke(CHANGE_PLOT_SELECT_CHAPTER)
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.id_ = slot1

	slot0:RefreshUI()
	slot0:Show(true)
end

function slot0.SetSelectID(slot0, slot1)
	slot0.selectChapterClientID_ = slot1

	if table.keyof(ChapterMainPlotToggleCfg[slot0.id_].chapter_client_list, slot1) then
		slot0.controller_:SetSelectedState("yes")
	else
		slot0.controller_:SetSelectedState("no")
	end
end

function slot0.RefreshUI(slot0)
	slot0.text_.text = ChapterMainPlotToggleCfg[slot0.id_].name
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.GetTransform(slot0)
	return slot0.transform_
end

return slot0
