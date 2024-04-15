slot0 = class("NewWarChessDiceFrameItem", ReduxView)
slot1 = {
	EQUAL = 3,
	BETWEEN = 4,
	EVEN = 6,
	ODD = 5,
	GREATER = 1,
	SMALLER = 2
}

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.clickHandler_ = slot2
	slot0.index_ = slot3
	slot0.frameIndex_ = 0
	slot0.diceIndex_ = 0

	slot0:ResetData()
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "name")
	slot0.pointController_ = ControllerUtil.GetController(slot0.transform_, "points")
	slot0.symbolController_ = ControllerUtil.GetController(slot0.transform_, "symbol")
	slot0.combolController_ = ControllerUtil.GetController(slot0.transform_, "combo")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickHandler_ then
			uv0.clickHandler_(uv0.index_)
		else
			print("骰子框self.clickHandler_为空！！！！")
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.frameIndex_ = slot1

	slot0:ResetData()

	if slot0.frameIndex_ == 0 then
		return
	else
		slot0.frameCfg_ = NewWarChessDiceCfg[slot0.frameIndex_]
		slot0.type_ = slot0.frameCfg_.type
		slot0.inputRange_ = slot0.frameCfg_.input_range
		slot0.limitType_ = slot0.frameCfg_.limit_type
	end

	slot0:RefreshUI()
end

function slot0.SetInputDice(slot0, slot1)
	slot0.diceData_ = NewWarChessData.GetDiceContinuousList()[slot1]
	slot0.diceIndex_ = slot1
	slot0.dicePoint_ = slot0.diceData_[1]

	slot0:RefreshUI()
end

function slot0.ResetData(slot0)
	slot0.limitType_ = 0
	slot0.type_ = 0
	slot0.frameCfg_ = nil
	slot0.inputRange_ = {}

	slot0:ResetDiceData()
end

function slot0.ResetDiceData(slot0)
	slot0.diceIndex_ = 0
	slot0.diceData_ = nil
	slot0.dicePoint_ = 0
end

function slot0.CheckInputLimit(slot0, slot1)
	slot3 = NewWarChessData.GetDiceContinuousList()[slot1][1]

	if slot0.dicePoint_ ~= 0 then
		return false
	end

	if slot0.limitType_ <= 4 then
		if slot3 < slot0.inputRange_[1] or slot0.inputRange_[2] < slot3 then
			return false
		end
	elseif slot0.limitType_ == uv0.ODD then
		return slot3 % 2 == 1
	elseif slot0.limitType_ == uv0.EVEN then
		return slot3 % 2 == 0
	end

	return true
end

function slot0.RefreshUI(slot0)
	slot0.stateController_:SetSelectedIndex(slot0.dicePoint_)

	if slot0.dicePoint_ ~= 0 then
		slot0.combolController_:SetSelectedState("empty")
		slot0.symbolController_:SetSelectedState("empty")
		slot0.pointController_:SetSelectedIndex(0)

		return
	end

	if slot0.limitType_ <= 4 then
		slot0.combolController_:SetSelectedState("empty")
	else
		slot0.symbolController_:SetSelectedState("empty")
	end

	if slot0.limitType_ == uv0.GREATER then
		slot0.symbolController_:SetSelectedState("greater")
		slot0.pointController_:SetSelectedIndex(slot0.inputRange_[1])
	elseif slot0.limitType_ == uv0.SMALLER then
		slot0.symbolController_:SetSelectedState("smaller")
		slot0.pointController_:SetSelectedIndex(slot0.inputRange_[2])
	elseif slot0.limitType_ == uv0.EQUAL then
		slot0.symbolController_:SetSelectedState("empty")
		slot0.pointController_:SetSelectedIndex(slot0.inputRange_[1])
	elseif slot0.limitType_ == uv0.BETWEEN then
		slot0.symbolController_:SetSelectedState("empty")
		slot0.pointController_:SetSelectedIndex(0)
	elseif slot0.limitType_ == uv0.ODD then
		slot0.combolController_:SetSelectedState("odd")
		slot0.pointController_:SetSelectedIndex(0)
	elseif slot0.limitType_ == uv0.EVEN then
		slot0.combolController_:SetSelectedState("even")
		slot0.pointController_:SetSelectedIndex(0)
	else
		slot0.symbolController_:SetSelectedState("empty")
		slot0.combolController_:SetSelectedState("empty")
		slot0.pointController_:SetSelectedIndex(0)
	end
end

function slot0.Dispose(slot0)
	slot0.clickHandler_ = nil

	Object.Destroy(slot0.gameObject_)
	uv0.super.Dispose(slot0)
end

return slot0
