slot0 = class("NorseSurpriseGiftResultsview", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftResultsUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.heroDataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, NorseSurpriseGiftResultsItem)
	slot0.uiList_2 = LuaList.New(handler(slot0, slot0.indexItem2), slot0.listGo_2, NorseSurpriseGiftResultsItem)
	slot0.effectCtrl = slot0.transform_:GetComponent("ControllerExCollection"):GetController("Effects")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_bg, nil, function ()
		uv0:Back()
		manager.notify:Invoke(NORSE_GIFT_PLAYANIM_DRAW)
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	HeroLongHead.SetProxy(slot2, slot0.heroDataProxy)
	slot2:SetData(slot0.draw_list[slot1])

	if slot0.heartList and #slot0.heartList > 0 then
		slot2:SetHeart(slot0.heartList)
	end
end

function slot0.indexItem2(slot0, slot1, slot2)
	HeroLongHead.SetProxy(slot2, slot0.heroDataProxy)
	slot2:SetData(slot0.delete_list[slot1])

	if slot0.delete_list and #slot0.delete_list > 0 then
		slot2:SetDelete(slot0.delete_list)
	end
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	if slot0.params_.data then
		slot0.data = slot0.params_.data
	end

	slot0.heartList = NorseSurpriseGiftReceiveData:GetChooseRoleData()

	slot0:RefreshView()

	slot0.tipsTxt_.text = GetTips("ACTIVITY_OPTIONAL_RANDOM_WINDOW_TIPS_5")
	slot0.tipsTxt2_.text = GetTips("ACTIVITY_OPTIONAL_RANDOM_WINDOW_TIPS_6")
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.heroDataProxy then
		slot0.heroDataProxy = nil
	end

	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	if slot0.uiList_2 then
		slot0.uiList_2:Dispose()

		slot0.uiList_2 = nil
	end
end

function slot0.RefreshView(slot0)
	slot0.delete_list = slot0.data.delete_list
	slot0.draw_list = slot0.data.draw_list
	slot1 = 1

	for slot5, slot6 in ipairs(slot0.heartList) do
		if slot6 == slot0.draw_list[1] then
			slot1 = 0

			break
		end
	end

	slot0.effectCtrl:SetSelectedIndex(slot1)
	slot0.uiList_:StartScroll(#slot0.draw_list)
	slot0.uiList_2:StartScroll(#slot0.delete_list)
end

return slot0
