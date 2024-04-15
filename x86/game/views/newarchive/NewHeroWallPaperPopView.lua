slot0 = class("NewHeroWallPaperPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroArchive/ArchiveStoryWallpaperPopUI_new"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.clickItemHandler = handler(slot0, slot0.ClickItem)
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.wallPaperList_, NewHeroWallPaperItemView)
end

function slot0.ClickItem(slot0, slot1, slot2)
	ArchiveAction.SendSetWallPaper(slot0.data_.archive_id, slot1, slot2)
	slot0.uiList_:Refresh()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.wallPaperIdList_[slot1], slot1, slot0.data_.archive_id)
	slot2:SetClickFunc(slot0.clickItemHandler)
end

function slot0.OnEnter(slot0)
	slot0.data_ = slot0.params_.data
	slot0.recordData_ = HeroRecordCfg[slot0.data_.archive_id]
	slot0.plotIDList_ = slot0.recordData_.plot_id
	slot0.superplotIDList_ = slot0.recordData_.super_plot_id

	slot0:RegistEventListener(UPDATE_WALLPAPER, function ()
		ShowTips(GetTips("DORM_CANTEEN_HERO_CHANGE_SUCCESS"))
		uv0:Back()
	end)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.wallPaperIdList_ = {}

	for slot5, slot6 in pairs(slot0.recordData_.hero_id) do
		for slot11, slot12 in pairs(SkinCfg.get_id_list_by_hero[slot6]) do
			slot13 = nil

			if SkinCfg[slot12].portrait ~= 0 then
				table.insert(slot0.wallPaperIdList_, {
					id = slot12,
					type = slot12 == slot6 and 1 or 2
				})
			end
		end
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot0.plotIDList_) do
		if CollectPictureCfg.get_id_list_by_additional_parameter[slot7] and CollectPictureCfg.get_id_list_by_group_id[CollectPictureCfg[slot8[1]].group_id] and not slot2[CollectPictureCfg[slot8[1]].group_id] then
			table.insert(slot0.wallPaperIdList_, {
				type = 3,
				id = slot9[1]
			})

			slot2[CollectPictureCfg[slot8[1]].group_id] = true
		end
	end

	for slot6, slot7 in ipairs(slot0.superplotIDList_) do
		if CollectPictureCfg.get_id_list_by_additional_parameter[slot7] and CollectPictureCfg.get_id_list_by_group_id[CollectPictureCfg[slot8[1]].group_id] and not slot2[CollectPictureCfg[slot8[1]].group_id] then
			table.insert(slot0.wallPaperIdList_, {
				type = 3,
				id = slot9[1]
			})

			slot2[CollectPictureCfg[slot8[1]].group_id] = true
		end
	end

	table.sort(slot0.wallPaperIdList_, function (slot0, slot1)
		if ArchiveTools.CheckWallPaperIsUnlock(slot0) and not ArchiveTools.CheckWallPaperIsUnlock(slot1) then
			return true
		elseif not slot2 and slot3 then
			return false
		end

		if slot0.type < slot1.type then
			return true
		elseif slot1.type < slot0.type then
			return false
		end

		return slot0.id < slot1.id
	end)
	slot0.uiList_:StartScroll(#slot0.wallPaperIdList_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgMask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
