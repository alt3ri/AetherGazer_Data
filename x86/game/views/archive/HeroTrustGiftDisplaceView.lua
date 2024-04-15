slot0 = class("HeroTrustGiftDisplaceView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_coop/HeroCoopGiftUI"
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

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, HeroTrustGiftDisplaceItem)
	slot0.item = CommonItemView.New(slot0.m_item, true)
	slot0.rareController = ControllerUtil.GetController(slot0.transform_, "rare")
	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.changeController = ControllerUtil.GetController(slot0.transform_, "change")
	slot0.clickHandle = handler(slot0, slot0.ItemClick)
	slot0.unSelectHanld = handler(slot0, slot0.UnSelect)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_star2Btn, function ()
		uv0:SelectItem(2)
	end)
	slot0:AddBtnListener(nil, slot0.m_star3Btn, function ()
		uv0:SelectItem(3)
	end)
	slot0:AddBtnListener(nil, slot0.m_star4Btn, function ()
		uv0:SelectItem(4)
	end)
	slot0:AddBtnListener(nil, slot0.m_star5Btn, function ()
		uv0:SelectItem(5)
	end)
	slot0:AddBtnListener(nil, slot0.m_displaceBtn, function ()
		for slot4, slot5 in pairs(uv0.choice_item) do
			slot0 = 0 + slot5
		end

		slot2 = uv0:GetRatio(uv0:GetGiftItemId(uv0.rare))

		if slot2 > math.floor(slot0 / slot2) * slot2 then
			ShowTips("HERO_TRUST_DISPLACE_FAIL")

			return
		end

		if uv0:GetTrustGiftDisplaceMax(slot1) < slot3 + ArchiveData:GetTrustGiftDisplaceCount(slot1) then
			ShowTips("HERO_TRUST_DISPLACE_UP_LIMIT")

			return
		end

		slot7 = {
			[slot11] = slot12
		}

		for slot11, slot12 in pairs(uv0.choice_item) do
			-- Nothing
		end

		while slot0 - slot4 > 0 do
			if table.remove(uv0.operate_item) then
				if slot7[slot9] and slot7[slot9] > 0 then
					slot8 = slot8 - slot7[slot9]
					slot7[slot9] = math.max(0, slot7[slot9] - slot8)
				end
			else
				break
			end
		end

		if slot8 > 0 then
			ShowTips("HERO_TRUST_DISPLACE_FAIL")

			return
		end

		slot9 = {}

		for slot13, slot14 in pairs(slot7) do
			if slot14 ~= 0 then
				table.insert(slot9, {
					id = slot13,
					num = slot14
				})
			end
		end

		ArchiveAction.QueryExChangeTrustItem(slot9, {
			{
				id = slot1,
				num = slot3
			}
		})
		uv0:RefreshRight()
	end)
	slot0.m_slider.onValueChanged:AddListener(function ()
		slot0 = uv0.m_slider.value
		uv0.choice_item[uv0.select_item_id] = slot0
		uv0.m_selectNum.text = slot0

		if uv0.select_item_id ~= uv0.operate_item[#uv0.operate_item] then
			table.insert(uv0.operate_item, uv0.select_item_id)
		end

		uv0.list:Refresh()
		uv0:RefreshRight()
	end)
	slot0:AddBtnListener(nil, slot0.m_addBtn, function ()
		slot0 = ItemTools.getItemNum(uv0.select_item_id)

		if uv0.m_slider.maxValue <= (uv0.choice_item[uv0.select_item_id] or 0) then
			ShowTips("HERO_TRUST_DISPLACE_MAX")

			return
		end

		slot3 = uv0:GetRatio(uv0:GetGiftItemId(uv0.rare))

		for slot8, slot9 in pairs(uv0.choice_item) do
			slot4 = 0 + slot9
		end

		if slot4 ~= math.floor(slot4 / slot3) * slot3 then
			slot3 = slot3 - slot4 + slot6
		end

		uv0.m_slider.value = slot1 + math.min(slot3, slot0 - slot1)
	end)
	slot0:AddBtnListener(nil, slot0.m_delBtn, function ()
		if (uv0.choice_item[uv0.select_item_id] or 0) <= 0 then
			return
		end

		slot2 = uv0:GetRatio(uv0:GetGiftItemId(uv0.rare))

		for slot7, slot8 in pairs(uv0.choice_item) do
			slot3 = 0 + slot8
		end

		if slot3 ~= math.floor(slot3 / slot2) * slot2 then
			slot2 = slot3 - slot5
		end

		uv0.m_slider.value = slot0 - math.min(slot2, slot0)
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("HERO_TRUST_DISPLACE_TIP")
end

function slot0.OnEnter(slot0)
	slot0.gifts = slot0:GetGiftItemList()

	slot0.list:StartScroll(#slot0.gifts)

	slot0.select_item_id = 0
	slot0.choice_item = {}
	slot0.operate_item = {}

	slot0:RefreshSlider()
	slot0:SelectItem(2)
end

function slot0.GetGiftItemList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.ARCHIVE_GIFT]) do
		if ItemCfg[slot7].sub_type == 1 and ItemTools.getItemNum(slot7) > 0 then
			table.insert(slot1, slot7)
		end
	end

	table.sort(slot1, function (slot0, slot1)
		slot3 = uv0:GetLikeHero(slot1)
		slot4 = uv0:GetLikeHero(slot0) ~= 0 and ArchiveData:GetArchive(slot2).lv or 0
		slot5 = slot3 ~= 0 and ArchiveData:GetArchive(slot3).lv or 0

		if slot2 ~= slot3 then
			if slot4 ~= slot5 then
				return slot5 < slot4
			else
				return slot1 < slot0
			end
		else
			return slot1 < slot0
		end
	end)

	return slot1
end

function slot0.GetLikeHero(slot0, slot1)
	for slot5, slot6 in ipairs(HeroRecordCfg.all) do
		if table.indexof(HeroRecordCfg[slot6].gift_like_id1, slot1) then
			return slot6
		end
	end

	return 0
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.SelectItem(slot0, slot1)
	slot0.choice_item = {}
	slot0.operate_item = {}
	slot0.rare = slot1

	slot0.rareController:SetSelectedState(slot1)
	slot0:RefreshRight()

	slot0.select_item_id = 0

	slot0:RefreshSlider()
end

function slot0.RefreshSlider(slot0)
	if slot0.select_item_id == 0 then
		slot0.selectController:SetSelectedIndex(0)
	else
		slot1 = slot0.choice_item[slot0.select_item_id] or 0
		slot3 = slot0:GetRatio(slot0:GetGiftItemId(slot0.rare))

		for slot8, slot9 in pairs(slot0.choice_item) do
			if slot8 ~= slot0.select_item_id then
				slot4 = 0 + slot9
			end
		end

		if slot4 < (slot0:GetTrustGiftDisplaceMax(slot2) - ArchiveData:GetTrustGiftDisplaceCount(slot2)) * slot3 then
			slot0.selectController:SetSelectedIndex(1)

			slot0.m_slider.maxValue = math.min(ItemTools.getItemNum(slot0.select_item_id), slot7 - slot4)
		elseif slot1 == 0 then
			slot0.selectController:SetSelectedIndex(0)
		else
			slot0.selectController:SetSelectedIndex(1)

			slot0.m_slider.maxValue = slot1
		end

		slot0.m_slider.minValue = 1
		slot0.m_slider.value = slot1
		slot0.m_selectNum.text = slot1
	end

	slot0.list:Refresh()
	slot0:RefreshRight()
end

function slot0.RefreshRight(slot0)
	slot1 = slot0:GetGiftItemId(slot0.rare)
	slot2 = clone(ItemTemplateData)
	slot2.id = slot1
	slot2.number = 1

	function slot2.clickFun()
		ShowPopItem(POP_ITEM, {
			uv0,
			1
		})
	end

	slot0.item:SetData(slot2)

	slot0.m_itemName.text = ItemTools.getItemName(slot1)
	slot0.m_ratioLab.text = slot0:GetRatio(slot1)

	for slot8, slot9 in pairs(slot0.choice_item) do
		slot4 = 0 + slot9
	end

	if slot4 == 0 then
		slot0.m_displaceBtn.interactable = false

		slot0.changeController:SetSelectedIndex(0)
	else
		slot0.m_displaceBtn.interactable = true

		slot0.changeController:SetSelectedIndex(1)
	end

	slot5 = math.floor(slot4 / slot3)
	slot6 = slot5 * slot3
	slot0.m_displaceNum.text = slot5
	slot0.m_ceilLab.text = ArchiveData:GetTrustGiftDisplaceCount(slot1) .. "/" .. slot0:GetTrustGiftDisplaceMax(slot1)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layoutTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layoutTrs_)
end

function slot0.Dispose(slot0)
	slot0.item:Dispose()
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.GetGiftItemId(slot0, slot1)
	if slot1 == 2 then
		return 30012
	elseif slot1 == 3 then
		return 30013
	elseif slot1 == 4 then
		return 30014
	else
		return 30015
	end
end

function slot0.GetRatio(slot0, slot1)
	for slot6, slot7 in ipairs(GameSetting.hero_trust_exchange_need.value) do
		if slot1 == slot7[1] then
			return slot7[2]
		end
	end

	return 1
end

function slot0.GetTrustGiftDisplaceMax(slot0, slot1)
	for slot6, slot7 in ipairs(GameSetting.hero_trust_exchange_up_limit.value) do
		if slot1 == slot7[1] then
			return slot7[2]
		end
	end

	return 0
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot3, slot0.choice_item[slot0.gifts[slot1]] or 0)
	slot2:SetSelect(slot0.select_item_id)
	slot2:RegistCallBack(slot0.clickHandle)
	slot2:RegistCallBack2(slot0.unSelectHanld)
end

function slot0.ItemClick(slot0, slot1)
	slot0.select_item_id = slot1

	for slot6, slot7 in pairs(slot0.list:GetItemList()) do
		slot7:SetSelect(slot0.select_item_id)
	end

	if not slot0.choice_item[slot1] or slot0.choice_item[slot1] == 0 then
		slot4 = slot0:GetRatio(slot0:GetGiftItemId(slot0.rare))

		for slot9, slot10 in pairs(slot0.choice_item) do
			slot5 = 0 + slot10
		end

		if slot5 < (slot0:GetTrustGiftDisplaceMax(slot3) - ArchiveData:GetTrustGiftDisplaceCount(slot3)) * slot4 then
			slot0.choice_item[slot1] = math.min(slot4, math.min(slot8 - slot5, ItemTools.getItemNum(slot1)))

			table.insert(slot0.operate_item, slot1)
		else
			ShowTips("HERO_TRUST_DISPLACE_MAX")
		end
	end

	slot0:RefreshSlider()
end

function slot0.UnSelect(slot0, slot1)
	slot0.select_item_id = 0

	for slot6, slot7 in pairs(slot0.list:GetItemList()) do
		slot7:SetSelect(slot0.select_item_id)
	end

	slot0.choice_item[slot1] = 0

	slot0:RefreshSlider()
end

function slot0.OnHeroTrustItemDisplace(slot0)
	slot0.gifts = slot0:GetGiftItemList()

	slot0.list:StartScrollWithoutAnimator(#slot0.gifts, slot0.list:GetScrolledPosition())

	slot0.select_item_id = 0
	slot0.choice_item = {}
	slot0.operate_item = {}

	slot0:RefreshSlider()
end

return slot0
