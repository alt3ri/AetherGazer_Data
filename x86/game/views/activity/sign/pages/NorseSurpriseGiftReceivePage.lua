slot0 = class("NorseSurpriseGiftReceivePage", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftReceiveUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, NorseSurpriseGiftReceiveItem)
	slot0.btnCtrl = slot0.transform_:GetComponent("ControllerExCollection"):GetController("btn")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnClose_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.btn_true, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_OPTIONAL_RANDOM_TIPS_5"),
			OkCallback = function ()
				NorseSurpriseGiftReceiveAction.ReceiveRewardRole(242832, uv0.infocfg.id)
				uv0:Back()
			end,
			CancelCallback = function ()
			end
		})
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.draw_list[slot1], slot1)
	slot2:SetSelect(slot0.infocfg)

	if slot0.heart_list and #slot0.heart_list > 0 then
		slot2:SetHeart(slot0.heart_list)
	end

	slot2:RegistCallBack(function (slot0)
		if slot0 == uv0.infocfg.id then
			uv0.infocfg = {
				id = 0,
				flag = 1
			}
		else
			uv0.infocfg = {
				flag = 0,
				id = slot0
			}
		end

		for slot5, slot6 in ipairs(uv0.uiList_:GetItemList()) do
			slot6:SetSelect(uv0.infocfg)

			if uv0.heart_list and #uv0.heart_list > 0 then
				slot6:SetHeart(uv0.heart_list)
			end
		end

		uv0:RefreshChooseBtn(uv0.infocfg.flag)
	end)
end

function slot0.RefreshChooseBtn(slot0, slot1)
	slot0.btnCtrl:SetSelectedIndex(slot1)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot0.infocfg = {
		id = 0,
		flag = 1
	}

	slot0:RefreshView()
	slot0.btnCtrl:SetSelectedIndex(1)

	slot0.tipsTxt_.text = GetTips("ACTIVITY_OPTIONAL_RANDOM_WINDOW_TIPS_4")
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
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
	slot0.draw_list = NorseSurpriseGiftReceiveData:GetDrawRoleData()
	slot0.heart_list = NorseSurpriseGiftReceiveData:GetChooseRoleData()

	TimeTools.StartAfterSeconds(0.033, function ()
		uv0.uiList_:StartScroll(#uv0.draw_list)
	end, {})
end

return slot0
