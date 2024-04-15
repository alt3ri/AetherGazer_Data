slot0 = class("RewardView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Common/Pop/RewardpopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.uiList = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, CommonItemView)
	slot0.rowCountController_ = slot0.conExCollection_:GetController("rowCount")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0:ConvertToItemData(slot0.itemList_[slot1]))
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot1 = slot0:SortItemList(formatRewardCfgList(slot1))
		slot0.itemList_ = slot1
		slot0.itemPool_ = slot0.itemPool1_
		slot0.listScrollRect_.enabled = #slot1 > 10

		slot0.uiList:StartScroll(slot2)

		if slot2 > 5 then
			slot0.rowCountController_:SetSelectedState("2")
			slot0.uiList:SetAlignment(UIListAlignment.Center)
		else
			slot0.rowCountController_:SetSelectedState("1")
			slot0.uiList:SetAlignment(UIListAlignment.Center2)
		end
	end
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI(slot0.params_.list)
end

function slot0.OnExit(slot0)
	slot0:ShowVitalityBox(function ()
		uv0:ShowEquipBox(function ()
		end)
	end)
end

function slot0.ShowVitalityBox(slot0, slot1)
	if slot0.params_.needShowVitalityBox then
		showVitalitySendMail(slot1)
	else
		slot1()
	end
end

function slot0.ShowEquipBox(slot0, slot1)
	if slot0.params_.needShowEquipBox then
		showEquipSendMail(slot1)
	else
		slot1()
	end
end

function slot0.Dispose(slot0)
	if slot0.uiList ~= nil then
		slot0.uiList:Dispose()

		slot0.uiList = nil
	end

	if slot0.itemPool1_ ~= nil then
		slot0.itemPool1_:Dispose()

		slot0.itemPool1_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.DisablebgBtn(slot0)
	slot0.bgBtn_.enabled = false
end

function slot0.ConvertToItemData(slot0, slot1)
	slot2.number = rewardToItemTemplate(slot1).number or slot1.number

	function slot2.clickFun(slot0)
		ShowPopItem(POP_ITEM, slot0)
	end

	slot2.animatorType = ItemConst.ITEM_ANIMATOR_TYPE.ADVANCED

	return slot2
end

function slot0.Back(slot0, slot1)
	if manager.guide:IsPlaying() then
		uv0.super.Back(slot0)

		return
	end

	if slot0:IsAnimEnd() then
		uv0.super.Back(slot0)

		if slot1 then
			slot1()
		end
	else
		slot0:StopAllAnim()
	end
end

function slot1(slot0)
	if slot0 == nil then
		return true
	end

	if slot0:GetCurrentAnimatorStateInfo(0).normalizedTime >= 0.999 then
		return true
	end

	return false
end

function slot2(slot0)
	if slot0 == nil then
		return
	end

	slot0:Update(99999)
end

function slot0.IsAnimEnd(slot0)
	if #slot0.params_.list == 0 then
		return true
	end

	if not uv0(slot0.animator_) then
		return false
	end

	slot1, slot2 = slot0.uiList:GetHeadAndTail()

	if slot1 == 0 then
		return false
	end

	return uv0(slot0.uiList:GetItemByIndex(slot1).animator_)
end

function slot0.StopAllAnim(slot0)
	uv0(slot0.animator_)

	for slot5, slot6 in pairs(slot0.uiList:GetItemList()) do
		uv0(slot6.animator_)
	end
end

function slot3(slot0, slot1)
	if ItemCfg[slot0.id].rare ~= ItemCfg[slot1.id].rare then
		return slot7 < slot6
	end

	if slot4.type ~= slot5.type then
		return slot9 < slot8
	elseif slot8 == ItemConst.ITEM_TYPE.EQUIP then
		slot10 = 0
		slot11 = 0

		if EquipCfg[slot2].starlevel == EquipCfg[slot3].starlevel then
			return slot3 < slot2
		else
			return slot11 < slot10
		end
	else
		return slot3 < slot2
	end
end

function slot4(slot0, slot1, slot2)
	if table.indexof(slot0, slot2.type) and slot1[slot3] then
		if table.indexof(slot1[slot3], slot2.id) then
			return slot4, slot5
		else
			return false
		end
	end

	return slot4
end

function slot0.SortItemList(slot0, slot1)
	slot2 = {
		ItemConst.ITEM_TYPE.HERO,
		ItemConst.ITEM_TYPE.HERO_SKIN,
		ItemConst.ITEM_TYPE.SCENE,
		ItemConst.ITEM_TYPE.WEAPON_SERVANT,
		ItemConst.ITEM_TYPE.CURRENCY,
		ItemConst.ITEM_TYPE.PORTRAIT,
		ItemConst.ITEM_TYPE.FRAME,
		ItemConst.ITEM_TYPE.STICKER
	}
	slot3 = {
		[ItemConst.ITEM_TYPE.CURRENCY] = {
			1,
			30,
			31,
			32
		}
	}

	table.sort(slot1, function (slot0, slot1)
		slot6, slot7 = uv0(uv1, uv2, ItemCfg[slot0.id])
		slot8, slot9 = uv0(uv1, uv2, ItemCfg[slot1.id])

		if slot6 and slot8 then
			if slot6 == slot8 and slot7 and slot9 then
				return slot7 < slot9
			else
				return slot6 < slot8
			end
		elseif slot6 ~= slot8 then
			return slot8 == false
		end

		return uv3(slot0, slot1)
	end)

	return slot1
end

return slot0
