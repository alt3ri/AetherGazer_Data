slot0 = class("NorseSurpriseGiftInStockPage", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftInStockUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.heroDataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, NorseSurpriseGiftInStockItem)
	slot0.stateCtrl = slot0.transform_:GetComponent("ControllerExCollection"):GetController("state")
	slot0.btnCtrl = slot0.transform_:GetComponent("ControllerExCollection"):GetController("choosebtn")
	slot0.sortList = {}
	slot0.isSel = {}
end

function slot0.indexItem(slot0, slot1, slot2)
	HeroLongHead.SetProxy(slot2, slot0.heroDataProxy)
	slot2:SetData(slot0.heroList[slot1])

	slot2.isChoose = slot0.isSel[slot1]

	slot2:SetChoose(slot0.sortList)
	slot2:RegistCallBack(function (slot0)
		uv0.scroPos = uv0.uiList_:GetScrolledPosition()

		if uv1.isChoose == 1 then
			uv1.isChoose = 0
			slot1 = {}

			for slot5, slot6 in ipairs(uv0.sortList) do
				if slot6.id ~= slot0 then
					table.insert(slot1, slot6)
				end
			end

			uv0.sortList = slot1
		elseif uv0.sortList and #uv0.sortList >= 6 then
			ShowTips("ACTIVITY_OPTIONAL_RANDOM_TIPS_1")
		else
			uv1.isChoose = 1

			table.insert(uv0.sortList, {
				id = slot0,
				flag = uv1.isChoose
			})
		end

		uv0.isSel[uv2] = uv1.isChoose

		uv0.uiList_:StartScroll(#uv0.heroList)
		uv0.uiList_:SetScrolledPosition(uv0.scroPos)
		uv0:RefreshChooseBtn()
	end)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_choose, nil, function ()
		if #uv0.sortList == 6 then
			JumpTools.OpenPageByJump("norseSurpriseGiftChooseAgainPage", {
				sortList = uv0.sortList
			})
		else
			ShowTips("ACTIVITY_OPTIONAL_RANDOM_TIPS_2")
		end
	end)
	slot0:AddBtnListener(slot0.btnClose_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.btnAll_, nil, function ()
		uv0.heroList = GameSetting.activity_optional_random_role_list.value

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

function slot0.RefreshHeroList(slot0, slot1)
	slot0.heroList = GameSetting.activity_optional_random_role_list.value
	slot2 = {}
	slot3 = {}

	for slot7, slot8 in ipairs(slot0.heroList) do
		if HeroCfg[slot8].ATK_attribute[1] == slot1 then
			table.insert(slot2, slot8)
		end
	end

	slot0.heroList = slot2

	slot0.uiList_:StartScroll(#slot2)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot0.sortList = {}
	slot0.isSel = {}
	slot0.heartList = NorseSurpriseGiftReceiveData:GetChooseRoleData()

	slot0:RefreshView()

	if slot0.btnIndex and slot0.btnIndex >= 0 then
		slot0:RefreshHeroList(slot0.btnIndex)
	else
		slot0.heroList = GameSetting.activity_optional_random_role_list.value

		slot0.uiList_:StartScroll(#slot0.heroList)
		slot0.stateCtrl:SetSelectedIndex(0)
	end
end

function slot0.RefreshView(slot0)
	slot0.btnCtrl:SetSelectedState("false")

	slot0.chooseTxt_.text = GetTips("ACTIVITY_OPTIONAL_RANDOM_WINDOW_TIPS_2")
	slot0.tipsTxt_.text = GetTips("ACTIVITY_OPTIONAL_RANDOM_WINDOW_TIPS_3")
end

function slot0.RefreshChooseBtn(slot0)
	if #slot0.sortList == 6 then
		slot0.btnCtrl:SetSelectedState("true")
	else
		slot0.btnCtrl:SetSelectedState("false")
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

	if slot0.heartList then
		slot0.heartList = nil
	end

	if slot0.heroList then
		slot0.heroList = nil
	end

	if slot0.sortList then
		slot0.sortList = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
