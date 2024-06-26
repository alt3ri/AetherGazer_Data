slot0 = class("PassportBuyLevelView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Passport/PassportBuyLevelUI"
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

	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, CommonItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	CommonTools.SetCommonData(slot2, {
		id = slot0.rewardList_[slot1].id,
		number = slot0.rewardList_[slot1].num,
		clickFun = function ()
			ShowPopItem(POP_ITEM, uv0.rewardList_[uv1])
		end
	})
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.delBtn_, nil, function ()
		uv0:UpdateByNum(math.min(uv0.num_ - 1), 1)
	end)
	slot0:AddBtnListener(slot0.addBtn_, nil, function ()
		uv0:UpdateByNum(math.max(uv0.num_ + 1), uv0:GetMaxNum())
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buyBtn_, nil, function ()
		slot0 = math.min(uv0.num_, uv0:GetMaxNum())

		JumpTools.OpenPageByJump("passportBuyLevelConfirm", {
			num = slot0,
			level = PassportData:GetLevel() + slot0,
			cost = GameSetting.battlepass_level_price.value[2] * slot0,
			callback = function ()
				uv0:Back()
			end
		})
	end)
	slot0.slider_.onValueChanged:AddListener(function ()
		uv0:UpdateByNum(math.max(math.floor(uv0.slider_.value), 1))
	end)
end

function slot0.UpdateByNum(slot0, slot1)
	slot0.num_ = slot1
	slot0.delBtn_.interactable = slot0.num_ > 1
	slot0.addBtn_.interactable = slot0.num_ < slot0:GetMaxNum()
	slot0.slider_.value = slot1

	slot0:CalculateReward()
	slot0.list_:StartScroll(#slot0.rewardList_)

	slot0.costLabel_.text = GameSetting.battlepass_level_price.value[2] * slot1
	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(GameSetting.battlepass_level_price.value[1])
	slot0.buyNumLabel_.text = slot1
	slot0.levelTxt_.text = string.format(GetTips("BATTLEPASS_BUY_TITLE"), PassportData:GetLevel() + slot1)
end

function slot0.CalculateReward(slot0)
	slot0.rewardList_ = {}

	for slot7 = 1, math.min(slot0.num_, slot0:GetMaxNum()) do
		table.insertto(slot0.rewardList_, BattlePassCfg[BattlePassCfg.get_id_list_by_type[BattlePassListCfg[PassportData:GetId()].battlepass_type][PassportData:GetLevel() + slot7]].reward_free)

		if PassportData:GetPayLevel() > 0 then
			table.insertto(slot0.rewardList_, BattlePassCfg[slot9].reward_pay)
		end
	end

	slot0.rewardList_ = mergeReward(formatRewardCfgList(slot0.rewardList_))

	table.sort(slot0.rewardList_, function (slot0, slot1)
		if ItemCfg[slot0.id].rare ~= ItemCfg[slot1.id].rare then
			return slot3.rare < slot2.rare
		end

		return slot3.id < slot2.id
	end)
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function slot0.OnEnter(slot0)
	slot1 = slot0.params_.notRemainLevel or true
	slot0.params_.notRemainLevel = nil
	slot0.slider_.maxValue = slot0:GetMaxNum()
	slot0.slider_.value = slot1 and 1 or slot0.num_

	slot0:UpdateByNum(slot1 and 1 or slot0.num_)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.GetMaxNum(slot0)
	return PassportData:GetMaxLevel() - PassportData:GetLevel()
end

function slot0.OnExitInput(slot0)
	slot0.expressionView_:TryExitSaveData()

	return true
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
