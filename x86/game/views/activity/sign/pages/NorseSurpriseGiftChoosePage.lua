slot0 = class("NorseSurpriseGiftChoosePage", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftChooseUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.heroDataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, NorseSurpriseGiftChooseItem)
	slot0.stateCtrl = slot0.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function slot0.indexItem(slot0, slot1, slot2)
	HeroLongHead.SetProxy(slot2, slot0.heroDataProxy)
	slot2:SetData(slot0.heroList[slot1])

	if slot0.heartList and #slot0.heartList > 0 then
		slot2:SetHeart(slot0.heartList)
	end

	if slot0.deleteList and #slot0.deleteList > 0 then
		slot2:SetDelete(slot0.deleteList)
	end

	if slot0.drawList and #slot0.drawList > 0 then
		slot2:SetDraw(slot0.drawList)
	end

	if slot0.result_role_id then
		slot2:SetResultRoleId(slot0.result_role_id)
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnClose_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.btnAll_, nil, function ()
		uv0.heroList = GameSetting.activity_optional_random_role_list.value
		uv0.heroList = uv0:SortList(uv0.heroList)

		uv0.uiList_:StartScroll(#uv0.heroList)
		uv0.stateCtrl:SetSelectedIndex(0)

		uv0.btnIndex = -1
	end)
	slot0:AddBtnListener(slot0.btn_0, nil, function ()
		uv0:RefreshHeroList(0)
		uv0.stateCtrl:SetSelectedIndex(1)

		uv0.btnIndex = 0
	end)
	slot0:AddBtnListener(slot0.btn_2, nil, function ()
		uv0:RefreshHeroList(2)
		uv0.stateCtrl:SetSelectedIndex(2)

		uv0.btnIndex = 2
	end)
	slot0:AddBtnListener(slot0.btn_4, nil, function ()
		uv0:RefreshHeroList(4)
		uv0.stateCtrl:SetSelectedIndex(3)

		uv0.btnIndex = 4
	end)
	slot0:AddBtnListener(slot0.btn_14, nil, function ()
		uv0:RefreshHeroList(14)
		uv0.stateCtrl:SetSelectedIndex(4)

		uv0.btnIndex = 14
	end)
	slot0:AddBtnListener(slot0.btn_10, nil, function ()
		uv0:RefreshHeroList(10)
		uv0.stateCtrl:SetSelectedIndex(5)

		uv0.btnIndex = 10
	end)
	slot0:AddBtnListener(slot0.btn_12, nil, function ()
		uv0:RefreshHeroList(12)
		uv0.stateCtrl:SetSelectedIndex(6)

		uv0.btnIndex = 12
	end)
	slot0:AddBtnListener(slot0.btn_6, nil, function ()
		uv0:RefreshHeroList(6)
		uv0.stateCtrl:SetSelectedIndex(7)

		uv0.btnIndex = 6
	end)
	slot0:AddBtnListener(slot0.btn_8, nil, function ()
		uv0:RefreshHeroList(8)
		uv0.stateCtrl:SetSelectedIndex(8)

		uv0.btnIndex = 8
	end)
end

function slot0.SortList(slot0, slot1)
	if slot1 == nil then
		return {}
	end

	slot2 = {}
	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		slot9 = {
			type = 6,
			id = slot8,
			type = 5
		}

		for slot13, slot14 in ipairs(slot0.deleteList) do
			if slot8 == slot14 then
				-- Nothing
			end
		end

		for slot13, slot14 in ipairs(slot0.drawList) do
			if slot8 == slot14 then
				slot9.type = 4
			end
		end

		for slot13, slot14 in ipairs(slot0.heartList) do
			if slot8 == slot14 and slot9.type == 4 then
				slot9.type = 2
			elseif slot8 == slot14 then
				slot9.type = 3
			end
		end

		if slot8 == slot0.result_role_id then
			slot9.type = 1
		end

		table.insert(slot3, slot9)
	end

	table.sort(slot3, function (slot0, slot1)
		return slot0.type < slot1.type
	end)

	for slot7, slot8 in ipairs(slot3) do
		table.insert(slot2, slot8.id)
	end

	return slot2
end

function slot0.RefreshHeroList(slot0, slot1)
	slot0.heroList = GameSetting.activity_optional_random_role_list.value
	slot2 = {}
	slot3 = {}

	for slot7, slot8 in ipairs(slot0.heroList) do
		if HeroCfg[slot8].ATK_attribute[1] == slot1 then
			table.insert(slot2, slot8)
		end
	end

	slot0.heroList = slot0:SortList(slot2)

	slot0.uiList_:StartScroll(#slot0.heroList)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot0.heartList = NorseSurpriseGiftReceiveData:GetChooseRoleData()
	slot0.deleteList = NorseSurpriseGiftReceiveData:GetDelRoleData()
	slot0.drawList = NorseSurpriseGiftReceiveData:GetDrawRoleData()
	slot0.result_role_id = NorseSurpriseGiftReceiveData:GetResultRoleId()

	if slot0.btnIndex and slot0.btnIndex >= 0 then
		slot0:RefreshHeroList(slot0.btnIndex)
	else
		slot0.heroList = GameSetting.activity_optional_random_role_list.value
		slot0.heroList = slot0:SortList(slot0.heroList)

		slot0.uiList_:StartScroll(#slot0.heroList)
		slot0.stateCtrl:SetSelectedIndex(0)
	end
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
end

function slot0.Dispose(slot0)
	if slot0.heroDataProxy then
		slot0.heroDataProxy = nil
	end

	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
