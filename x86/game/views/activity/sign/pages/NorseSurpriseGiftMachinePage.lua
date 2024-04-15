slot0 = class("NorseSurpriseGiftMachinePage", ReduxView)
slot1 = {
	{
		"anim01_1",
		"anim01_2",
		"anim01_3"
	},
	{
		"anim02_1",
		"anim02_2",
		"anim02_3"
	},
	{
		"anim03_1",
		"anim03_2"
	},
	{
		"anim04_1",
		"anim04_2",
		"anim04_3"
	},
	{
		"anim05_1",
		"anim05_2"
	}
}

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftMachineUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.heroDataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, NorseSurpriseGiftMachineItem)
	slot0.onDrawHandler = handler(slot0, slot0.OnNorseGiftDrawSuccess)
	slot0.onReceiveHandler = handler(slot0, slot0.OnNorseGiftReceiveSuccess)
	slot0.onPlayAnimHandler = handler(slot0, slot0.OnNorseGiftPlayAnimDraw)
	slot0.stateCtrl = slot0.transform_:GetComponent("ControllerExCollection"):GetController("bottom_btn_switch")
end

function slot0.indexItem(slot0, slot1, slot2)
	HeroLongHead.SetProxy(slot2, slot0.heroDataProxy)
	slot2:SetData(slot0.draw_list[slot1])

	if slot0.heartList and #slot0.heartList > 0 then
		slot2:SetState(slot0.heartList, slot0.result_role_id)
	else
		slot2:ResetState()
	end

	if slot1 == slot0.needPlayDrawAnimIndex then
		slot2:PlayAnim(true)

		slot0.needPlayDrawAnimIndex = -1
	else
		slot2:PlayAnim(false)
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnReceive_, nil, function ()
		if #NorseSurpriseGiftReceiveData:GetDrawRoleData() <= 0 then
			ShowTips("ACTIVITY_OPTIONAL_RANDOM_TIPS_4")
		else
			JumpTools.OpenPageByJump("norseSurpriseGiftReceivePage")
		end
	end)
	slot0:AddBtnListener(slot0.btnStart_, nil, function ()
		slot1 = NorseSurpriseGiftReceiveData:GetDrawRoleData()

		if #NorseSurpriseGiftReceiveData:GetChooseRoleData() < 6 then
			JumpTools.OpenPageByJump("norseSurpriseGiftInStockPage")
		elseif ItemTools.getItemNum(CurrencyConst.CURRENCY_RANDOM_TARGET_COIN) < 1 then
			ShowTips("ACTIVITY_OPTIONAL_RANDOM_TIPS_3")
		elseif slot1 and #slot1 >= 5 then
			ShowTips("ACTIVITY_OPTIONAL_RANDOM_TIPS_6")
		else
			manager.windowBar:HideBar()

			uv0.btnStart_.interactable = false
			uv0.btnReceive_.interactable = false
			uv0.btnInfo_.interactable = false
			uv0.btnWish_.interactable = false
			uv0.startAnim_.enabled = true

			uv0.startAnim_:Play("Fx_niudanji_cx", -1, 0)
			uv0.startAnim_:Update(0)
			AnimatorTools.PlayAnimatorWithCallback(uv0.startAnim_, "Fx_niudanji_cx", function ()
				uv0.startAnim_.enabled = false

				if uv0.draw_list then
					for slot4, slot5 in ipairs(uv1[#uv0.draw_list + 1]) do
						uv0[slot5].enabled = true

						uv0[slot5]:Play("Fx_ball_saoguang")
					end

					uv0.animDrop_:Play("ball_trop", -1, 0)
					AnimatorTools.PlayAnimatorWithCallback(uv0.animDrop_, "ball_trop", function ()
						NorseSurpriseGiftReceiveAction.DrawCapsule(242832)

						uv0.btnStart_.interactable = true
						uv0.btnReceive_.interactable = true
						uv0.btnInfo_.interactable = true
						uv0.btnWish_.interactable = true
					end, false)
				end
			end, false)
		end
	end)
	slot0:AddBtnListener(slot0.btnInfo_, nil, function ()
		JumpTools.OpenPageByJump("norseSurpriseGiftChoosePage")
	end)
	slot0:AddBtnListener(slot0.btnWish_, nil, function ()
		JumpTools.OpenPageByJump("norseSurpriseGiftWishPoolPage")
	end)
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
	slot0:RegistEventListener(NORSE_GIFT_DRAW_SUCCESS, slot0.onDrawHandler)
	slot0:RegistEventListener(NORSE_GIFT_RECEIVE_SUCCESS, slot0.onReceiveHandler)
	slot0:RegistEventListener(NORSE_GIFT_PLAYANIM_DRAW, slot0.onPlayAnimHandler)
	manager.redPoint:bindUIandKey(slot0.btnStart_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW, ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW))
	manager.redPoint:bindUIandKey(slot0.btnReceive_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_RECEIVE, ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW))
	slot0:RefreshView()
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(slot0.btnStart_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW, ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW))
	manager.redPoint:unbindUIandKey(slot0.btnReceive_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_RECEIVE, ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW))
	manager.windowBar:HideBar()

	slot0.needPlayDrawAnimIndex = -1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end
end

function slot0.RefreshCurrency(slot0)
	if ItemTools.getItemNum(CurrencyConst.CURRENCY_RANDOM_TARGET_COIN) < 1 then
		slot0.currencyTxt_.text = "<color=#FF000B>x1</color>"
	else
		slot0.currencyTxt_.text = "<color=#262626>x1</color>"
	end
end

function slot0.RefreshView(slot0)
	slot0.draw_list = NorseSurpriseGiftReceiveData:GetDrawRoleData()
	slot0.heartList = NorseSurpriseGiftReceiveData:GetChooseRoleData()
	slot0.result_role_id = NorseSurpriseGiftReceiveData:GetResultRoleId()

	slot0:RefreshBtn()
	slot0:RefreshCurrency()

	if slot0.draw_list and #slot0.draw_list > 0 and slot0.uiList_ then
		slot0.uiList_:StartScroll(#slot0.draw_list)
	end

	slot0:RefreshBall(#slot0.draw_list)
end

function slot0.RefreshBall(slot0, slot1)
	for slot5 = 1, slot1 do
		for slot9, slot10 in ipairs(uv0[slot5]) do
			SetActive(slot0[slot10].gameObject, false)
		end
	end
end

function slot0.RefreshBtn(slot0)
	if slot0.result_role_id and slot0.result_role_id ~= 0 then
		slot0.stateCtrl:SetSelectedIndex(1)
		SetActive(slot0.costGo_, false)
	end
end

function slot0.OnNorseGiftDrawSuccess(slot0, slot1)
	NorseSurpriseGiftReceiveData:UpdateRedPointData(ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW)
	JumpTools.OpenPageByJump("norseSurpriseGiftResultsview", {
		data = slot1
	})
end

function slot0.OnNorseGiftReceiveSuccess(slot0, slot1, slot2)
	slot3 = HeroCfg[slot2.role_id]
	slot0.result_role_id = slot2.role_id
	slot0.item_list = slot1.item_list

	HeroAction.UnlockHeroSuccess(slot3.id)
	print("--->播放获取角色动画")
	gameContext:Go("obtainView", {
		itemList = {
			slot3
		},
		doNextHandler = handler(slot0, slot0.JumpToReward)
	})
end

function slot0.JumpToReward(slot0)
	getReward2(slot0.item_list)
	print("奖励弹窗---->", slot0.result_role_id)
	slot0:RefreshView()
end

function slot0.OnNorseGiftPlayAnimDraw(slot0)
	slot0.draw_list = NorseSurpriseGiftReceiveData:GetDrawRoleData()
	slot0.heartList = NorseSurpriseGiftReceiveData:GetChooseRoleData()
	slot0.result_role_id = NorseSurpriseGiftReceiveData:GetResultRoleId()

	slot0:RefreshBtn()
	slot0:RefreshCurrency()

	slot0.needPlayDrawAnimIndex = #slot0.draw_list

	if slot0.draw_list and #slot0.draw_list > 0 and slot0.uiList_ then
		slot0.uiList_:StartScroll(#slot0.draw_list)
	end

	if ItemTools.getItemNum(CurrencyConst.CURRENCY_RANDOM_TARGET_COIN) < 1 then
		slot0.currencyTxt_.text = "<color=#FF000B>x1</color>"
	else
		slot0.currencyTxt_.text = "<color=#262626>x1</color>"
	end
end

return slot0
