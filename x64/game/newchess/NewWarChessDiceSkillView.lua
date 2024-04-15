slot0 = class("NewWarChessDiceSkillView", ReduxView)

function slot0.UIName(slot0)
	return "UI/NewWarChess/NewWarChessDiceSkillView"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.diceFrameClickHandler_ = handler(slot0, slot0.OnDiceFrameClick)
	slot0.diceClickHandler_ = handler(slot0, slot0.OnDiceClick)
	slot0.diceFramActiveController_ = ControllerUtil.GetController(slot0.diceframeListGo_.transform, "num")
	slot0.diceFramSymbolController_ = ControllerUtil.GetController(slot0.diceframeListGo_.transform, "symbol")
	slot4 = "enabled"
	slot0.yesBtnController_ = ControllerUtil.GetController(slot0.yesBtn_.transform, slot4)
	slot0.diceFrameItem_ = {}

	for slot4 = 1, 3 do
		slot0.diceFrameItem_[slot4] = NewWarChessDiceFrameItem.New(slot0["diceframe" .. slot4 .. "_"], slot0.diceFrameClickHandler_, slot4)
	end

	slot0.diceList_ = LuaList.New(handler(slot0, slot0.IndexDice), slot0.diceListGo_, NewWarChessDiceItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.yesBtn_, nil, function ()
		if not uv0.yesBtnClickAble_ then
			return
		end

		slot0 = {}

		for slot4 = 1, #uv0.diceFrameIDList_ do
			table.insert(slot0, uv0.diceFrameItem_[slot4].dicePoint_)
		end

		NewWarChessAction.UseDiceSkill(uv0.skillID_, slot0, function ()
			NewWarChessData:RemoveDice(uv0)
			NewWarChessData:UseSkill(uv1.skillID_)
			JumpTools.Back()
		end)
	end)
	slot0:AddBtnListener(slot0.mask_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.IndexSkill(slot0, slot1, slot2)
	slot2:SetData(slot1)
end

function slot0.OnDiceClick(slot0, slot1)
	NewWarChessData:ClearAniCache()

	slot2 = #slot0.diceFrameIDList_

	if slot0.diceDataList_[slot1].hasInput == true then
		for slot6 = 1, slot2 do
			if slot0.diceFrameItem_[slot6].diceIndex_ == slot1 then
				slot0.diceDataList_[slot1].hasInput = false

				slot0.diceFrameItem_[slot6]:ResetDiceData()
				slot0.diceFrameItem_[slot6]:RefreshUI()
				slot0:RefreshDiceList()
				slot0:RefreshBtn()
				slot0:RefreshUIText()

				return
			end
		end
	end

	slot3 = slot0.diceDataList_[slot1][1]

	for slot9 = 1, slot2 do
		if slot0.diceFrameItem_[slot9].dicePoint_ > 0 then
			slot4 = 0 + slot0.diceFrameItem_[slot9].dicePoint_
			slot5 = 0 + 1
		end
	end

	if slot5 < slot2 then
		if slot0.diceLimitType_ == NewChessConst.DICE_LIMIT_TYPE.TWAIN then
			slot6 = 0

			for slot10 = 1, slot2 do
				if slot0.diceFrameItem_[slot10].dicePoint_ ~= 0 then
					slot6 = slot0.diceFrameItem_[slot10].dicePoint_

					break
				end
			end

			if slot6 > 0 and slot3 ~= slot6 then
				ShowTips("ACTIVITY_NEW_WARCHESS_DICE_NOT_IS_TWAIN")

				return
			end
		end

		if slot0.outputLimit_ ~= 0 then
			if slot0.outputLimit_ < slot4 + slot3 then
				ShowTips(string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_SUM_GREATER"), slot0.outputLimit_))

				return
			end

			if slot5 == slot2 - 1 then
				if slot4 + slot3 < slot0.outputLimit_ then
					ShowTips(string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_SUM_SMALLER"), slot0.outputLimit_))

					return
				elseif slot0.outputLimit_ < slot4 + slot3 then
					ShowTips(string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_SUM_GREATER"), slot0.outputLimit_))

					return
				end
			end
		end

		for slot9 = 1, slot2 do
			if slot0.diceFrameItem_[slot9]:CheckInputLimit(slot1) then
				slot0.diceFrameItem_[slot9]:SetInputDice(slot1)

				slot0.diceDataList_[slot1].hasInput = true

				slot0:RefreshDiceList()
				slot0:RefreshBtn()
				slot0:RefreshUIText()

				return
			end
		end

		ShowTips("ACTIVITY_NEW_WARCHESS_DICE_UNDESIRABLE")
	end
end

function slot0.OnDiceFrameClick(slot0, slot1)
	if slot0.diceFrameItem_[slot1].diceIndex_ ~= 0 then
		slot0.diceDataList_[slot2.diceIndex_].hasInput = false

		slot2:ResetDiceData()
		slot2:RefreshUI()
		slot0:RefreshUI()
	end
end

function slot0.OnEnter(slot0)
	slot0.skillID_ = slot0.params_.skillID
	slot0.skillCfg_ = NewWarChessDiceSkillCfg[slot0.skillID_]
	slot0.data_ = NewWarChessData:GetSkillInfo(slot0.skillID_)
	slot0.leftUseLimit_ = slot0.data_.useLimit
	slot0.totalUseLimit_ = slot0.skillCfg_.use_limit

	if slot0.skillCfg_.dice_type > 0 then
		slot0.diceEventCfg_ = NewWarChessDiceEventCfg[slot0.skillCfg_.dice_type]
		slot0.diceFrameIDList_ = slot0.diceEventCfg_.dice_configuration
		slot0.diceLimitType_ = slot0.diceEventCfg_.dice_limit_type
		slot0.outputLimit_ = slot0.diceEventCfg_.dice_limit_output
	end

	slot0:RefreshUI()
	slot0:RefreshDiceFrameList()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshUIText()
	slot0:RefreshBtn()
	slot0:RefreshDiceList()
end

function slot0.RefreshBtn(slot0)
	for slot4 = 1, #slot0.diceFrameIDList_ do
		if slot0.diceFrameItem_[slot4].dicePoint_ == 0 then
			slot0.yesBtnController_:SetSelectedState("false")

			slot0.yesBtnClickAble_ = false

			return
		end
	end

	slot0.yesBtnClickAble_ = true

	slot0.yesBtnController_:SetSelectedState("true")
end

function slot0.RefreshUIText(slot0)
	slot0.skillDescText_.text = slot0.skillCfg_.description
	slot0.skillNameText_.text = slot0.skillCfg_.name
	slot0.iconImage_.sprite = getSprite("Atlas/NewWarChess", slot0.skillCfg_.icon)
	slot0.useText_.text = slot0.leftUseLimit_ .. "/" .. slot0.totalUseLimit_
	slot0.simpleDescText_.text = slot0.skillCfg_.simple_description
end

function slot0.RefreshDiceList(slot0)
	slot0.diceDataList_ = NewWarChessData:GetDiceContinuousList()

	slot0.diceList_:StartScroll(#slot0.diceDataList_)
end

function slot0.IndexDice(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.diceDataList_[slot1])
	slot2:SetClickCallBack(slot0.diceClickHandler_)
end

function slot0.RefreshDiceFrameList(slot0)
	if slot0.skillCfg_.dice_type > 0 then
		slot0.diceDescText_.text = slot0.diceEventCfg_.dice_description

		SetActive(slot0.relesGo_, true)

		if slot0.diceLimitType_ == 1 then
			slot0.diceFramSymbolController_:SetSelectedState("double")
		elseif slot0.outputLimit_ ~= 0 then
			slot0.diceFramSymbolController_:SetSelectedState("add")
		else
			slot0.diceFramSymbolController_:SetSelectedState("empty")
		end

		slot4 = tostring

		slot0.diceFramActiveController_:SetSelectedState(slot4(#slot0.diceFrameIDList_))

		for slot4 = 1, 3 do
			slot0.diceFrameItem_[slot4]:SetData(slot0.diceFrameIDList_[slot4] or 0)
		end
	else
		SetActive(slot0.relesGo_, false)
	end
end

function slot0.OnExit(slot0)
	NewWarChessData:ClearDiceContinuousList()

	for slot4 = 1, 3 do
		slot0.diceFrameItem_[slot4]:ResetData()
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.diceFrameItem_) do
		slot5:Dispose()
	end

	if slot0.diceList_ then
		slot0.diceList_:Dispose()

		slot0.diceList_ = nil
	end

	slot0.diceFrameItem_ = nil
	slot0.diceFrameClickHandler_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
