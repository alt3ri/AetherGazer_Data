slot0 = class("NewWarChessDiceEventView", ReduxView)

function slot0.UIName(slot0)
	return "UI/NewWarChess/NewWarChessDiceUI"
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

	slot0.diceFrameClickHandler_ = handler(slot0, slot0.OnDiceFrameClick)
	slot0.diceClickHandler_ = handler(slot0, slot0.OnDiceClick)
	slot0.skillClickHandler_ = handler(slot0, slot0.OnSkillItemClick)
	slot0.diceFramActiveController_ = ControllerUtil.GetController(slot0.diceframeListGo_.transform, "num")
	slot0.diceFramSymbolController_ = ControllerUtil.GetController(slot0.diceframeListGo_.transform, "symbol")
	slot4 = "disable"
	slot0.yesBtnController_ = ControllerUtil.GetController(slot0.yesbtn_.transform, slot4)
	slot0.diceFrameItem_ = {}

	for slot4 = 1, 3 do
		slot0.diceFrameItem_[slot4] = NewWarChessDiceFrameItem.New(slot0["diceframe" .. slot4 .. "_"], slot0.diceFrameClickHandler_, slot4)
	end

	slot0.diceList_ = LuaList.New(handler(slot0, slot0.IndexDice), slot0.diceListGo_, NewWarChessDiceItem)
	slot0.skillList_ = LuaList.New(handler(slot0, slot0.IndexSkill), slot0.skillListGo_, NewWarChessSkillItem)
end

function slot0.OnDiceUpdate(slot0)
	slot0:RefreshDiceList()
	slot0:RefreshDiceFrameList()
end

function slot0.RefreshDiceList(slot0)
	slot0.diceDataList_ = NewWarChessData:GetDiceContinuousList()

	slot0.diceList_:StartScroll(#slot0.diceDataList_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backbtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.yesbtn_, nil, function ()
		if not uv0.yesBtnClickAble_ then
			return
		end

		for slot4 = 1, #uv0.diceFrameIDList_ do
			table.insert({}, uv0.diceFrameItem_[slot4].dicePoint_)
		end

		if uv0.chanceItemCfg_.jump_event[1] == NewChessConst.CHANCE_JUMP_TYPE.BATTLE then
			NewWarChessAction.SelectChanceItem(uv0.chanceItemID_, slot0, function ()
				if not BattleNewWarChessStageCfg[uv0.chanceItemCfg_.jump_event[2]] then
					-- Nothing
				end

				if NewWarChessData:CheckIsAllDie() then
					ShowTips("ACTIVITY_NEW_WARCHESS_ALL_HERO_DIE")

					return
				end

				slot1 = {}

				if uv0.chanceItemCfg_.jump_event[5] then
					for slot6, slot7 in pairs(uv1) do
						slot2 = 0 + slot7
					end

					for slot6, slot7 in pairs(uv0.chanceItemCfg_.jump_event[5]) do
						slot8 = deepClone(slot7)
						slot8[2] = slot2

						table.insert(slot1, slot8)
					end
				end

				manager.NewChessManager:BattleStart(uv0.chanceID_, uv0.chanceItemID_, uv1, slot1)
				gameContext:Go("/sectionSelectHero", {
					section = slot0,
					sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS,
					activityID = NewWarChessData:GetCurrentActivity()
				})
			end)
		else
			NewWarChessAction.SelectChanceItem(uv0.chanceItemID_, slot0, function ()
				uv0:ExecuteChanceItem(uv0.chanceItemID_)
			end)
		end
	end)
end

function slot0.IndexSkill(slot0, slot1, slot2)
	slot2:SetData(slot0.skillDataList_[slot1])
	slot2:SetClickCallBack(slot0.skillClickHandler_)
	slot2:BindSkillRedPoint()
end

function slot0.OnSkillItemClick(slot0, slot1)
	JumpTools.OpenPageByJump("/newWarChessDiceSkillView", {
		skillID = slot1
	})
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
		slot0:RefreshBtn()
		slot0:RefreshUIText()
		slot0:RefreshDiceList()
	end
end

function slot0.OnEnter(slot0)
	slot0.chanceID_ = slot0.params_.chanceID
	slot0.chanceCfg_ = NewWarChessChanceCfg[slot0.chanceID_]
	slot0.chanceItemID_ = slot0.params_.chanceItemID
	slot0.chanceItemCfg_ = NewWarChessChanceItemCfg[slot0.chanceItemID_]
	slot0.eventPoolCfg_ = NewWarChessEventPoolCfg[slot0.chanceItemCfg_.new_warchess_event]
	slot0.diceEventCfg_ = NewWarChessDiceEventCfg[slot0.chanceItemCfg_.dice_type]
	slot0.diceFrameIDList_ = slot0.diceEventCfg_.dice_configuration
	slot0.diceLimitType_ = slot0.diceEventCfg_.dice_limit_type
	slot0.outputLimit_ = slot0.diceEventCfg_.dice_limit_output

	slot0:RefreshUI()
end

function slot0.RefreshSkillList(slot0)
	slot0.skillDataList_ = NewWarChessData:GetSkillList()

	slot0.skillList_:StartScroll(#slot0.skillDataList_)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshBtn()
	slot0:RefreshUIText()
	slot0:RefreshDiceList()
	slot0:RefreshDiceFrameList()
	slot0:RefreshSkillList()
end

function slot0.RefreshBtn(slot0)
	for slot4 = 1, #slot0.diceFrameIDList_ do
		if slot0.diceFrameItem_[slot4].dicePoint_ == 0 then
			slot0.yesBtnController_:SetSelectedState("true")

			slot0.yesBtnClickAble_ = false

			return
		end
	end

	slot0.yesBtnClickAble_ = true

	slot0.yesBtnController_:SetSelectedState("false")
end

function slot0.RefreshUIText(slot0)
	slot0.nameText_.text = slot0.chanceItemCfg_.name
	slot0.destext_.text = NewChessTools.GetChanceDes(slot0.chanceCfg_)
	slot0.diceDescText_.text = slot0.diceEventCfg_.dice_description
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.diceFrameItem_) do
		if slot6.dicePoint_ ~= 0 then
			table.insert(slot1, slot6.dicePoint_)
		end
	end

	slot0.eventDescText_.text = NewChessTools.GetDiceEventDes(slot0.chanceItemCfg_, slot1, slot0.yesBtnClickAble_)
end

function slot0.IndexDice(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.diceDataList_[slot1])
	slot2:SetClickCallBack(slot0.diceClickHandler_)
end

function slot0.RefreshDiceFrameList(slot0)
	if slot0.diceLimitType_ == NewChessConst.DICE_LIMIT_TYPE.TWAIN then
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
end

function slot0.ExecuteChanceItem(slot0, slot1)
	slot0:ExecuteNewWarChessEvent(slot1)
	slot0:ExecuteChanceJumpEvent(NewWarChessChanceItemCfg[slot1].jump_event)
end

function slot0.ExecuteNewWarChessEvent(slot0, slot1)
	slot2 = {}

	for slot6 = 1, #slot0.diceFrameIDList_ do
		table.insert(slot2, slot0.diceFrameItem_[slot6].dicePoint_)
	end

	NewWarChessData:RemoveDice(slot2)

	if NewWarChessChanceItemCfg[slot1].new_warchess_event ~= 0 then
		manager.NewChessManager:ExecutChess(NewChessConst.TIMING_CHANCE_CHOOSE, manager.NewChessManager:GetChanceInteracChess(), NewWarChessData:GetServerEvent(NewChessConst.TIMING_CHANCE_CHOOSE, {
			slot1
		}))
		manager.NewChessManager:StartExecuteEvent()
	end
end

function slot0.ExecuteChanceJumpEvent(slot0, slot1)
	if slot1[1] then
		if slot1[1] == NewChessConst.CHANCE_JUMP_TYPE.NEW_CHANCE or slot1[1] == NewChessConst.CHANCE_JUMP_TYPE.BATTLE or slot1[1] == NewChessConst.CHANCE_JUMP_TYPE.SELECT_CHANCE or slot1[1] == NewChessConst.CHANCE_JUMP_TYPE.DICE_SWITCH_CHANCE or slot1[1] == NewChessConst.CHANCE_JUMP_TYPE.DICE_SUM_SWITCH_CHANCE or slot1[1] == NewChessConst.CHANCE_JUMP_TYPE.ATTRIBUTE_SWITCH_CHANCE then
			JumpTools.OpenPageByJump("/newWarChessChanceView", {
				chanceID = NewWarChessData:GetServerChanceID()
			})
		elseif slot1[1] == NewChessConst.CHANCE_JUMP_TYPE.LEFT_WITHOUTSAVE or slot1[1] == NewChessConst.CHANCE_JUMP_TYPE.LEFT_WITHSAVE then
			JumpTools.OpenPageByJump("/newWarChessHome")
		end
	end
end

function slot0.OnTop(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	NewWarChessData:ClearDiceContinuousList()

	for slot4 = 1, 3 do
		slot0.diceFrameItem_[slot4]:ResetData()
	end
end

function slot0.Dispose(slot0)
	slot0.diceFrameClickHandler_ = nil
	slot0.skillClickHandler_ = nil

	for slot4, slot5 in pairs(slot0.diceFrameItem_) do
		slot5:Dispose()
	end

	slot0.diceFrameItem_ = nil

	if slot0.diceList_ then
		slot0.diceList_:Dispose()

		slot0.diceList_ = nil
	end

	if slot0.skillList_ then
		slot0.skillList_:Dispose()

		slot0.skillList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
