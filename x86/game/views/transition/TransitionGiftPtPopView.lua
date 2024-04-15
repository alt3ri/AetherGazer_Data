slot0 = class("TransitionGiftPtPopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_jumps/HeroJumpsUpPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.tryToImproveTransitionGiftPtHandler_ = handler(slot0, slot0.OnTryToImproveTransitionGiftPt)
	slot0.icon_.sprite = ItemTools.getItemLittleSprite(CurrencyIdMapCfg.CURRENCY_TYPE_GOLD.item_id)
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, CommonItemView)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.cost_[slot1]
	slot4 = ""

	function slot3.clickFun()
		ShowPopItem(POP_SOURCE_ITEM, {
			uv0.id,
			uv0._num
		})
	end

	slot3.bottomText = {
		ItemTools.getItemNum(slot3.id),
		slot3._num
	}
	slot3.animatorType = ItemConst.ITEM_ANIMATOR_TYPE.NULL

	slot2:SetData(slot3)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.addLevel_ == 1 then
			for slot3, slot4 in ipairs(uv0.cost_) do
				if ItemTools.getItemNum(slot4.id) < slot4._num then
					ShowPopItem(POP_SOURCE_ITEM, {
						slot5,
						slot6
					})

					return
				end
			end

			if not checkGold(uv0.goldNeed_) then
				return
			end
		end

		table.insertto({
			{
				id = CurrencyIdMapCfg.CURRENCY_TYPE_GOLD.item_id,
				number = uv0.goldNeed_
			}
		}, uv0.cost_)

		if not _G.SkipTip.TransitionGiftPtImproveTip then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EXCLUSIVE_SKILL_POINT_UP_CONFIRMATION"),
				OkCallback = function ()
					_G.SkipTip.TransitionGiftPtImproveTip = uv0.TransitionGiftPtImproveTip_

					HeroAction.TryToImproveTransitionGiftPt(uv0.params_.heroID, uv0.params_.index, uv0.addLevel_, uv1)
					uv0:Back()
				end,
				CancelCallback = function ()
				end,
				ToggleCallback = function (slot0)
					uv0.TransitionGiftPtImproveTip_ = slot0
				end
			})

			return
		end

		HeroAction.TryToImproveTransitionGiftPt(uv0.params_.heroID, uv0.params_.index, uv0.addLevel_, slot0)
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.delBtn_, nil, function ()
		uv0.addLevel_ = uv0.addLevel_ - 1

		uv0:RefreshUI()
	end)
	slot0:AddBtnListener(slot0.addBtn_, nil, function ()
		uv0.addLevel_ = uv0.addLevel_ + 1

		uv0:RefreshUI()
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0.slider_.onValueChanged:AddListener(function (slot0)
		uv0:OnSliderValueChanged(slot0)
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SetAsLastSibling()
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)

	slot0.curLevel_ = slot0.params_.giftPt
	slot0.addLevel_ = slot0.params_.isEnter and 1 or slot0.params_.addLevel
	slot0.maxLevel_ = slot0:GetMaxLevel()
	slot0.maxLevel_ = slot0.maxLevel_ < slot0.curLevel_ + 1 and slot0.curLevel_ + 1 or slot0.maxLevel_

	slot0:RegistEventListener(CURRENCY_UPDATE, handler(slot0, slot0.OnGoldChange))
	slot0:RefreshUI()
end

function slot0.GetMaxLevel(slot0)
	slot1 = GameSetting.exclusive_skill_talent_strengthen_cost.value
	slot3 = {}

	for slot7 = slot0.curLevel_ + 1, GameSetting.exclusive_skill_talent_num_max.value[1] do
		for slot12, slot13 in ipairs(slot1[slot7]) do
			slot15 = slot13[2]

			if not slot3[slot13[1]] then
				slot3[slot14] = 0
			end

			if ItemTools.getItemNum(slot14) < slot3[slot14] + slot15 then
				return slot7 - 1
			end

			slot3[slot14] = slot3[slot14] + slot15
		end

		slot2 = slot7
	end

	return slot2
end

function slot0.RefreshUI(slot0)
	slot0:RefreshCost()
	slot0:RefreshGold()
	slot0:RefreshButton()
	slot0.scrollHelper_:StartScroll(#slot0.cost_)
end

function slot0.RefreshCost(slot0)
	slot0.cost_ = {}
	slot1 = {
		all = {}
	}

	if slot0.addLevel_ > 0 then
		slot2 = GameSetting.exclusive_skill_talent_strengthen_cost.value

		for slot6 = slot0.curLevel_ + 1, slot0.curLevel_ + slot0.addLevel_ do
			for slot11, slot12 in ipairs(slot2[slot6]) do
				slot14 = slot12[2]

				if not slot1[slot12[1]] then
					slot1[slot13] = 0

					table.insert(slot1.all, slot13)
				end

				slot1[slot13] = slot1[slot13] + slot14
			end
		end

		slot0.goldNeed_ = slot1[CurrencyConst.CURRENCY_TYPE_GOLD]
	else
		slot0.goldNeed_ = 0
	end

	table.sort(slot1.all, function (slot0, slot1)
		return slot1 < slot0
	end)

	for slot5, slot6 in ipairs(slot1.all) do
		if slot6 ~= CurrencyIdMapCfg.CURRENCY_TYPE_GOLD.item_id then
			slot7 = clone(ItemTemplateData)
			slot7.id = slot6
			slot7._num = slot1[slot6]
			slot7.number = nil

			table.insert(slot0.cost_, slot7)
		end
	end
end

function slot0.RefreshGold(slot0)
	if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < slot0.goldNeed_ then
		slot0.gold_.text = "<color=#CF3232>" .. slot0.goldNeed_ .. "</color>"
	else
		slot0.gold_.text = slot0.goldNeed_
	end
end

function slot0.RefreshButton(slot0)
	slot0.delBtn_.interactable = slot0.addLevel_ > 1
	slot0.addBtn_.interactable = slot0.curLevel_ + slot0.addLevel_ < slot0.maxLevel_
	slot0.slider_.value = slot0.addLevel_ / (slot0.maxLevel_ - slot0.curLevel_)
	slot0.numTxt1_.text = "+" .. slot0.addLevel_
	slot0.numTxt2_.text = "+" .. slot0.addLevel_
	slot0.enhanceCnt_.text = table.concat({
		GetTips("COMMON_ENHANCE_NUMBER"),
		":",
		slot0.addLevel_
	})
end

function slot0.OnSliderValueChanged(slot0, slot1)
	if math.floor((slot0.maxLevel_ - slot0.curLevel_) * slot1 + 0.5) == 0 then
		slot2 = 1
	end

	if slot2 == slot0.addLevel_ then
		slot0:RefreshButton()
	else
		slot0.addLevel_ = slot2

		slot0:RefreshUI()
	end
end

function slot0.OnGoldChange(slot0)
	slot0.maxLevel_ = slot0:GetMaxLevel()
	slot0.maxLevel_ = slot0.maxLevel_ < slot0.curLevel_ + 1 and slot0.curLevel_ + 1 or slot0.maxLevel_

	slot0:RefreshUI()
end

function slot0.OnTryToImproveTransitionGiftPt(slot0)
	if GameSetting.exclusive_skill_talent_num_max.value[1] <= slot0.level_ then
		slot0:Back()
	else
		slot0.level_ = slot0.level_ + 1

		slot0:RefreshUI()
	end
end

function slot0.OnExit(slot0)
	slot0.params_.addLevel = slot0.addLevel_
	slot0.params_.isEnter = false

	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()
	slot0:RemoveAllListeners()

	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Dispose()

		slot0.scrollHelper_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
