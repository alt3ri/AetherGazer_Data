slot0 = class("IlluPlot", ReduxView)
slot1 = {
	MAIN_STORY = 1,
	BRITHDAY_STORY = 3,
	ACTIVITY_STORY = 2
}

function slot0.UIName(slot0)
	return "Widget/System/IllustratedHandbook/IlluplotUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scroll_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, IlluPlotItem)
	slot0.btn1Controller = ControllerUtil.GetController(slot0.btn1trs_, "name")
	slot0.btn2Controller = ControllerUtil.GetController(slot0.btn2trs_, "name")
	slot0.btn3Controller = ControllerUtil.GetController(slot0.btn3trs_, "name")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_1, nil, function ()
		uv0.params_.index = 1
		uv0.selType_ = 1

		uv0:RefreshUI(1)
	end)
	slot0:AddBtnListener(slot0.btn_2, nil, function ()
		uv0.params_.index = 2
		uv0.selType_ = 2

		uv0:RefreshUI(2)
	end)
	slot0:AddBtnListener(slot0.btn_3, nil, function ()
		uv0.params_.index = 3
		uv0.selType_ = 3

		uv0:RefreshUI(3)
	end)
end

function slot0.UpdateDate(slot0, slot1)
	slot0.itemList_ = {}
	slot2 = {}
	slot3 = {}

	if not CollectStoryCfg.get_id_list_by_type[slot1] then
		return
	end

	if slot1 == uv0.MAIN_STORY then
		slot4 = {}

		for slot8, slot9 in ipairs(CollectStoryCfg.get_id_list_by_type[slot1]) do
			if StoryCfg[slot9] and slot10.trigger[2] and getChapterIDByStageID(slot10.trigger[2]) then
				if not slot4[slot12] then
					slot4[slot12] = {
						chapterID = slot12,
						storyList = {}
					}
				end

				table.insert(slot4[slot12].storyList, slot10.id)
			end
		end

		for slot8, slot9 in pairs(slot4) do
			if ChapterClientCfg[slot8] then
				slot11 = {
					chapterID = slot8,
					storyList = {}
				}

				for slot15, slot16 in ipairs(slot10.chapter_list) do
					if slot4[slot16] then
						table.insertto(slot11.storyList, slot4[slot16].storyList)
					end
				end

				table.insert(slot0.itemList_, slot11)

				slot2[slot8] = #slot11.storyList
			end
		end
	elseif slot1 == uv0.ACTIVITY_STORY then
		for slot7, slot8 in ipairs(CollectStoryCfg.get_id_list_by_type[slot1]) do
			if not slot3[CollectStoryCfg[slot8].activity] then
				slot3[slot9] = {}
			end

			table.insert(slot3[slot9], slot8)
		end

		for slot7, slot8 in pairs(slot3) do
			for slot12, slot13 in ipairs(slot8) do
				if IllustratedData:GetPlotInfo()[slot13] then
					table.insert(slot0.itemList_, {
						chapterID = slot7,
						storyList = slot8
					})

					slot2[slot7] = #slot8

					break
				end
			end
		end
	elseif slot1 == uv0.BRITHDAY_STORY then
		for slot7, slot8 in ipairs(CollectStoryCfg.get_id_list_by_type[slot1]) do
			slot9 = CollectStoryCfg[slot8].order

			table.insert(slot0.itemList_, {
				chapterID = slot9,
				storyList = {
					slot8
				}
			})

			slot2[slot9] = 1
		end
	end

	for slot7, slot8 in ipairs(slot0.itemList_) do
		slot8.all = slot2[slot8.chapterID]
	end

	table.sort(slot0.itemList_, function (slot0, slot1)
		slot3 = table.indexof(ChapterCfg.all, slot1.chapterID)

		if table.indexof(ChapterCfg.all, slot0.chapterID) and slot3 then
			return slot2 < slot3
		else
			return slot0.chapterID < slot1.chapterID
		end
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.itemList_[slot1], slot0.selType_)
end

function slot0.IsShowToggleByType(slot0, slot1)
	for slot5, slot6 in ipairs(CollectStoryCfg.get_id_list_by_type[slot1] or {}) do
		if IllustratedData:GetPlotInfo()[slot6] then
			return true
		end
	end

	return false
end

function slot0.RefreshUI(slot0, slot1)
	SetActive(slot0.btn2trs_, slot0:IsShowToggleByType(uv0.ACTIVITY_STORY))
	SetActive(slot0.btn3trs_, slot0:IsShowToggleByType(uv0.BRITHDAY_STORY))
	slot0:UpdateDate(slot1)
	slot0.scroll_:StartScroll(#slot0.itemList_)
	slot0.btn1Controller:SetSelectedIndex(slot1 == 1 and 0 or 1)
	slot0.btn2Controller:SetSelectedIndex(slot1 == 2 and 0 or 1)
	slot0.btn3Controller:SetSelectedIndex(slot1 == 3 and 0 or 1)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.selType_ = slot0.params_.index or 1

	slot0:RefreshUI(slot0.selType_)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0.scroll_:Dispose()

	slot0.scroll_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
