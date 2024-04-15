slot0 = class("FishingGameCollectionView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingIllustratedPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0, ...)
end

slot1 = -1

function slot2(slot0)
	slot1 = nil

	if slot0 == uv0 then
		slot1 = "icon_group_all_c"
	else
		for slot5, slot6 in ipairs(GameDisplayCfg.hero_race_type_tag.value) do
			if slot6[1] == slot0 then
				slot1 = slot6[2]

				break
			end
		end
	end

	return getSprite("Atlas/CampItemAtlas", slot1)
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.winBar = KagutsuchiSpecialWinBarItem.New(slot0, slot0.winBar_)
	slot0.showDetailController = ControllerUtil.GetController(slot0.transform_, "showDetail")
	slot1 = {}

	for slot5, slot6 in pairs(HanafudaCardCfg.get_id_list_by_race) do
		table.insert(slot1, slot5)
	end

	slot5 = uv0

	table.insert(slot1, slot5)
	table.sort(slot1)

	for slot5, slot6 in ipairs(slot1) do
		slot7 = Object.Instantiate(slot0.filterItemPrefab_, slot0.filterTabRoot_)
		slot7.name = slot6
		slot8 = {}

		slot0:BindCfgUI(slot7, slot8)

		slot8.img_.sprite = uv1(slot6)

		slot0:AddToggleListener(slot8.btn_, function (slot0)
			if slot0 then
				uv0.filter = uv1

				uv0:UpdateList()
			end
		end)

		if slot6 == uv0 then
			slot0.toggleFilterAcceptAllRace = slot9
			slot7.name = "all"
		end

		slot7:SetActive(true)
	end

	slot0.collectionItemList = LuaList.New(handler(slot0, slot0.RenderCollectionItem), slot0.collectionItemList_, HanafudaCardView)
	slot0.detailPanel = FishCollectionDetailItem.New(slot0.detailPanel_)

	slot0.detailPanel:SetClickOnMask(function ()
		uv0.showDetailController:SetSelectedState("false")
	end)
end

function slot0.OnEnter(slot0)
	slot0.toggleFilterAcceptAllRace.isOn = true

	if slot0.toggleFilterAcceptAllRace.isOn then
		slot0:UpdateList()
	end

	manager.windowBar:HideBar()
end

function slot0.OnExit(slot0)
	slot0.showDetailController:SetSelectedState("false")
end

function slot0.OnTop(slot0)
end

function slot0.OnBehind(slot0)
end

function slot0.Dispose(slot0)
	slot0.detailPanel:Dispose()
	uv0.super.Dispose(slot0)

	if slot0.collectionItemList then
		slot0.collectionItemList:Dispose()

		slot0.collectionItemList = nil
	end

	slot0.winBar:Dispose()
end

function slot0.UpdateList(slot0)
	slot1 = {}

	if slot0.filter == uv0 then
		for slot5, slot6 in ipairs(HanafudaCardCfg.all) do
			table.insert(slot1, slot6)
		end
	else
		slot5 = slot0.filter

		for slot5, slot6 in ipairs(HanafudaCardCfg.get_id_list_by_race[slot5]) do
			table.insert(slot1, slot6)
		end
	end

	CommonTools.UniversalSortEx(slot1, {
		map = function (slot0)
			return KagutsuchiFishingEventData:GetRarity(slot0).order
		end
	}, {
		ascend = true
	})

	slot0.fishCollectionIdList = slot1

	slot0.collectionItemList:StartScroll(#slot1, 0, false, true)
end

function slot3(slot0)
	manager.notify:CallUpdateFunc("OnFishCollectionItemClick", slot0.data_.id, slot0.index_)
end

function slot0.RenderCollectionItem(slot0, slot1, slot2)
	slot4 = HanafudaCardCfg[slot0.fishCollectionIdList[slot1]]

	slot2:SetData(slot1, {
		id = slot4.id,
		race = slot4.race,
		desc = slot4.desc,
		placeType = HanafudaData.CARD_PLACE_TYPE.COLLECTION,
		rarity = KagutsuchiFishingEventData:GetRarity(slot4.id).order
	})
	slot2:SetPlayerClickCallBack(uv0)
	slot2:RefreshUI()
end

function slot0.OnFishCollectionItemClick(slot0, slot1, slot2)
	slot0.select = slot2

	slot0.collectionItemList:Refresh()
	slot0.detailPanel:SetData(slot1)
	slot0.showDetailController:SetSelectedState("true")
end

return slot0
