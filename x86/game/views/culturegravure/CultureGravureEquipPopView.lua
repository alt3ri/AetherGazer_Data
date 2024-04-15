slot0 = class("CultureGravureEquipPopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero/HeroCultureGravurepopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.equipPreviewList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.previewListGo_, CultureGravureEquipPopItem)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnConfirm_, nil, function ()
		if uv0.params_.index and uv0.params_.index ~= 0 then
			if CultureGravureAction.EquipByEquiptID(uv0.heroId_, uv0.selectId_) then
				uv0:UpdateData(uv0.params_.index)
				uv0:Back()
				ShowTips("EQUIP_BIND")
			else
				ShowTips("ERROR_NO_EQUIP")
			end
		else
			CultureGravureAction.EquipByList(uv0.heroId_, uv0.params_.recommendIdList)
			uv0:Back()
		end
	end)
	slot0:AddBtnListener(slot0.btnBack_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.heroId_ = slot0.params_.heroId
	slot0.stateList_ = slot0.params_.stateList
	slot0.equiptDataList_ = {}

	slot0:UpdateData(slot0.params_.index)
	slot0.equipPreviewList_:StartScroll(#slot0.equiptDataList_)
end

function slot0.UpdateData(slot0, slot1)
	slot3 = slot0.params_.recommendIdList

	if slot1 and slot1 ~= 0 then
		table.insert(slot0.equiptDataList_, {
			equipedData = EquipData:GetEquipData(HeroTools.GetHeroEquipS(slot0.heroId_)[slot1].equip_id),
			recommendData = EquipData:GetEquipData(CultureGravureAction.GetRecommendEquip(slot0.heroId_, slot3[slot1]).id),
			state = slot0.stateList_[slot1]
		})

		slot0.selectId_ = slot3[slot1]
	else
		for slot8 = 1, 6 do
			table.insert(slot0.equiptDataList_, {
				equipedData = EquipData:GetEquipData(slot2[slot8].equip_id),
				recommendData = EquipData:GetEquipData(CultureGravureAction.GetRecommendEquipList(slot0.heroId_, slot3)[slot8].equip_id),
				state = slot0.stateList_[slot8]
			})
		end
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.equiptDataList_[slot1], slot0.params_.index ~= 0 and slot0.params_.index or slot1)
end

function slot0.Dispose(slot0)
	slot0.equipPreviewList_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
