slot0 = class("NorseSurpriseGiftWishPoolPage", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftWishPoolUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.onChooseHandler = handler(slot0, slot0.OnNorseGiftChooseSuccess)
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, NorseSurpriseGiftWishPoolItem)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_info, nil, function ()
		JumpTools.OpenPageByJump("norseSurpriseGiftChoosePage")
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	if slot0.choose_list and #slot0.choose_list >= 6 then
		slot2:SetData(slot0.choose_list[slot1])

		if slot0.draw_list and #slot0.draw_list > 0 then
			slot2:SetDrawState(slot0.draw_list)
		end

		if slot0.result_role_id and slot0.result_role_id > 0 then
			slot2:SetGetState(slot0.result_role_id)
		end
	end
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_RANDOM_TARGET_COIN
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_RANDOM_TARGET_COIN, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_OPTIONAL_RANDOM_RULE")
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.notify:RegistListener(NORSE_GIFT_CHOOSE_SUCCESS, slot0.onChooseHandler)

	slot0.choose_list = NorseSurpriseGiftReceiveData:GetChooseRoleData()

	if slot0.params_.choose_list then
		slot0.choose_list = slot0.params_.choose_list
	end

	slot0.draw_list = NorseSurpriseGiftReceiveData:GetDrawRoleData()
	slot0.result_role_id = NorseSurpriseGiftReceiveData:GetResultRoleId()

	slot0:RefreshView()
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.notify:RemoveListener(NORSE_GIFT_CHOOSE_SUCCESS, slot0.onChooseHandler)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end
end

function slot0.RefreshView(slot0)
	TimeTools.StartAfterSeconds(0.033, function ()
		if uv0.choose_list and #uv0.choose_list >= 6 then
			uv0.uiList_:StartScroll(#uv0.choose_list)
		else
			uv0.uiList_:StartScroll(6)
		end
	end, {})
end

function slot0.OnNorseGiftChooseSuccess(slot0, slot1)
	slot0.choose_list = slot1
	slot0.draw_list = NorseSurpriseGiftReceiveData:GetDrawRoleData()
	slot0.result_role_id = NorseSurpriseGiftReceiveData:GetResultRoleId()

	slot0:RefreshView()
end

return slot0
