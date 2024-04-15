slot0 = class("NewWarChessChanceView", ReduxView)

function slot0.UIName(slot0)
	return "UI/NewWarChess/NewWarChessChanceUI"
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

	slot0.executeChanceItemHandle_ = handler(slot0, slot0.ExecuteChanceItem)
	slot0.itemList_ = {}
	slot0.diceList_ = LuaList.New(handler(slot0, slot0.IndexDiceItem), slot0.diceListGo_, NewWarChessDiceItem)
	slot0.isShowingBuff_ = false
	slot0.curShowBuffIndex_ = 0
	slot0.buffList_ = LuaList.New(handler(slot0, slot0.IndexBuffItem), slot0.buffList_, NewWarChessBuffItem)
	slot0.clickBuffHandler_ = handler(slot0, slot0.OnClickBuff)
end

function slot0.IndexDiceItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.diceDataList_[slot1])
	slot2:SetClickCallBack(function (slot0)
		NewWarChessData:ClearAniCache()
		ShowMessageBox({
			content = string.format(GetTips("ACTIVITY_NEW_WARCHESS_CHECK_DICE_TO_MOVEPOINT"), uv0.dicePoint_, uv0.dicePoint_),
			OkCallback = function ()
				NewWarChessAction.DiceToMovePoint(uv0.dicePoint_, function ()
					slot0 = math.floor(uv0 * NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_DICE_TO_MOVE_POINT_TIMES") / 1000)

					NewWarChessData:SubAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT", slot0)
					manager.NewChessManager:CreateTips({
						tipsType = NewChessConst.TIPS_TYPE.SWITCH,
						tipsText = string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_TO_MOVEPOINT"), uv0, slot0),
						tipsDiceNum = uv0
					})
					NewWarChessData:RemoveDice({
						uv1.dicePoint_
					})
					uv2:GoNewChance(uv2.chanceID_)
				end)
			end
		})
	end)
end

function slot0.IndexBuffItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.curShowBuffIndex_, slot0.buffEntityList_[slot1])
	slot2:SetClickCallBack(slot0.clickBuffHandler_)
end

function slot0.OnClickBuff(slot0, slot1, slot2, slot3)
	if slot0.isShowingBuff_ then
		SetActive(slot0.buffInfoGo_, false)

		slot0.curShowBuffIndex_ = 0

		slot0.buffList_:Refresh()

		slot0.isShowingBuff_ = false
	else
		SetActive(slot0.buffInfoGo_, true)

		slot0.curShowBuffIndex_ = slot1
		slot0.buffInfoNameText_.text = slot2
		slot0.buffInfoDesText_.text = slot3

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.infoContentTrans_)

		slot0.isShowingBuff_ = true
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.buffinfoBtn_, nil, function ()
		if uv0.isShowingBuff_ then
			uv0.isShowingBuff_ = false
			uv0.curShowBuffIndex_ = 0

			SetActive(uv0.buffInfoGo_, false)
			uv0.buffList_:Refresh()
		end
	end)
	slot0:AddBtnListener(slot0.exitBtn_, nil, function ()
		NewChessTools.ExitNewChessScene(false)
	end)
end

function slot0.OnEnter(slot0)
	if slot0.params_.chanceItemID then
		slot0:ExecuteChanceItem(slot0.params_.chanceItemID)

		slot0.params_.chanceItemID = nil
	else
		if slot0.params_.chanceID then
			slot0.chanceID_ = slot0.params_.chanceID
			slot0.params_.chanceID = nil
		end

		slot0:GoNewChance(slot0.chanceID_)
	end
end

function slot0.OnTop(slot0)
end

function slot0.GoNewChance(slot0, slot1)
	slot0.animator_:Play("ani")

	slot0.chanceID_ = slot1
	slot0.cfg_ = NewWarChessChanceCfg[slot0.chanceID_]
	slot0.nametext_.text = slot0.cfg_.name
	slot0.desText_.text = NewChessTools.GetChanceDes(slot0.cfg_)
	slot0.chanceItemList_ = NewWarChessData:GetCurChanceItemList()
	slot2 = 1

	for slot6, slot7 in pairs(slot0.chanceItemList_) do
		if not slot0.itemList_[slot2] then
			slot0.itemList_[slot2] = NewWarChessChanceItem.New(Object.Instantiate(slot0.chanceItemGo_, slot0.content_))

			slot0.itemList_[slot2]:SetNewChanceHandle(slot0.executeChanceItemHandle_)
		end

		slot0.itemList_[slot2]:SetIsShow(true)
		slot0.itemList_[slot2]:SetData(slot0.chanceID_, slot0.chanceItemList_[slot2].chanceItemID)

		slot2 = slot2 + 1
	end

	for slot6, slot7 in pairs(slot0.itemList_) do
		if slot2 <= slot6 then
			slot7:SetIsShow(false)
		end
	end

	SetActive(slot0.buffInfoGo_, false)

	slot0.curShowBuffIndex_ = 0
	slot0.isShowingBuff_ = false

	slot0:RefreshDiceList()
	slot0:RefreshBuffList()
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.content_)
end

function slot0.OnNewWarChessBuffUpDate(slot0)
	slot0:RefreshBuffList()
end

function slot0.OnDiceUpdate(slot0)
	slot0:RefreshDiceList()
end

function slot0.RefreshDiceList(slot0)
	slot0.diceDataList_ = NewWarChessData:GetDiceContinuousList()

	slot0.diceList_:StartScroll(#slot0.diceDataList_)
end

function slot0.RefreshBuffList(slot0)
	slot0.buffEntityList_ = manager.NewChessManager.buffManager_:GetActiveBuffEntityList()

	slot0.buffList_:StartScroll(#slot0.buffEntityList_)
end

function slot0.ExecuteChanceItem(slot0, slot1)
	slot0:ExecuteNewWarChessEvent(slot1)
	slot0:ExecuteChanceJumpEvent(NewWarChessChanceItemCfg[slot1].jump_event)
end

function slot0.ExecuteNewWarChessEvent(slot0, slot1)
	if NewWarChessChanceItemCfg[slot1].new_warchess_event ~= 0 then
		manager.NewChessManager:ExecutChess(NewChessConst.TIMING_CHANCE_CHOOSE, manager.NewChessManager:GetChanceInteracChess(), NewWarChessData:GetServerEvent(NewChessConst.TIMING_CHANCE_CHOOSE, {
			slot1
		}))
		manager.NewChessManager:StartExecuteEvent()
	end
end

function slot0.ExecuteChanceJumpEvent(slot0, slot1)
	if slot1[1] then
		if slot1[1] == NewChessConst.CHANCE_JUMP_TYPE.NEW_CHANCE then
			slot0:GoNewChance(slot1[2])
		elseif slot1[1] == NewChessConst.CHANCE_JUMP_TYPE.LEFT_WITHOUTSAVE then
			JumpTools.OpenPageByJump("/newWarChessHome")
		elseif slot1[1] == NewChessConst.CHANCE_JUMP_TYPE.LEFT_WITHSAVE then
			JumpTools.OpenPageByJump("/newWarChessHome")
		elseif slot1[1] == NewChessConst.CHANCE_JUMP_TYPE.BATTLE then
			slot0:GoNewChance(slot1[3])
		elseif slot1[1] == NewChessConst.CHANCE_JUMP_TYPE.SELECT_CHANCE then
			if slot1[3] <= NewWarChessData:GetAttribute(slot1[2]) then
				slot0:GoNewChance(slot1[4])
			else
				slot0:GoNewChance(slot1[5])
			end
		end
	end
end

function slot0.OnExit(slot0)
	NewWarChessData:ClearDiceContinuousList()
	slot0.diceList_:StopRender()
	slot0.buffList_:StopRender()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = {}
	slot0.executeChanceItemHandle_ = nil

	if slot0.diceList_ then
		slot0.diceList_:Dispose()

		slot0.diceList_ = nil
	end

	if slot0.buffList_ then
		slot0.buffList_:Dispose()

		slot0.buffList_ = nil
	end

	slot0.clickBuffHandler_ = nil

	slot0.super.Dispose(slot0)
end

return slot0
