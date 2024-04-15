slot0 = {
	function (slot0)
		if NewWarChessData:GetAttribute(slot0) >= 1 then
			return true
		else
			return false
		end
	end,
	function (slot0)
		if NewWarChessData:GetAttribute(slot0) == 0 then
			return true
		else
			return false
		end
	end,
	function ()
		if not NewWarChessData:CheckIsAllDie() then
			return true
		else
			return false
		end
	end,
	function ()
		if NewWarChessData:CheckIsAllDie() then
			return true
		else
			return false
		end
	end,
	function (slot0, slot1)
		if slot1 <= NewWarChessData:GetAttribute(slot0) then
			return true
		else
			return false
		end
	end,
	function (slot0, slot1)
		if NewWarChessData:GetAttribute(slot0) < slot1 then
			return true
		else
			return false
		end
	end,
	function (slot0)
		if slot0 <= NewWarChessData:GetDiceNum() then
			return true
		else
			return false
		end
	end,
	function (slot0)
		if NewWarChessData:GetDiceNum() < slot0 then
			return true
		else
			return false
		end
	end
}
slot1 = class("NewWarChessChanceItem", ReduxView)

function slot1.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		uv0:OnChanceItemClick()
	end)
end

function slot1.SetNewChanceHandle(slot0, slot1)
	slot0.executeChanceItemHandle_ = slot1
end

function slot1.SetData(slot0, slot1, slot2)
	slot0.chanceID_ = slot1
	slot0.chanceItemID_ = slot2
	slot0.chanceItemCfg_ = NewWarChessChanceItemCfg[slot0.chanceItemID_]
	slot0.stateInfo_ = NewWarChessData:GetChanceItemState(slot0.chanceItemID_)
	slot0.realState_ = 0

	if slot0.stateInfo_.ispre == 0 then
		if slot0.chanceItemCfg_.self_state_event[1] then
			if slot3[1] == 1 or slot3[1] == 2 or slot3[1] == 7 or slot3[1] == 8 then
				if uv0[slot3[1]](slot3[2]) then
					slot0.realState_ = slot3[3]
				else
					slot0.realState_ = slot0.stateInfo_.state
				end
			elseif slot3[1] == 3 or slot3[1] == 4 then
				if uv0[slot3[1]]() then
					slot0.realState_ = slot3[2]
				else
					slot0.realState_ = slot0.stateInfo_.state
				end
			elseif slot3[1] == 5 or slot3[1] == 6 then
				if uv0[slot3[1]](slot3[2], slot3[3]) then
					slot0.realState_ = slot3[4]
				else
					slot0.realState_ = slot0.stateInfo_.state
				end
			end
		else
			slot0.realState_ = slot0.stateInfo_.state
		end
	elseif slot0.stateInfo_.ispre == 1 then
		slot0.realState_ = slot0.stateInfo_.state
	else
		print("123 , 服务地传来的机遇选项机遇是否屏蔽前置条件字段有误")
	end

	slot0:RefreshUI()
end

function slot1.RefreshUI(slot0)
	slot0.name_.text = slot0.chanceItemCfg_.name

	if slot0.realState_ == NewChessConst.CHANCE_ITEM_STATUS.HIDE then
		SetActive(slot0.gameObject_, false)
	else
		SetActive(slot0.gameObject_, true)
		slot0.stateController_:SetSelectedIndex(slot0.realState_)
	end

	if slot0.chanceItemCfg_.dice_type ~= 0 then
		SetActive(slot0.diceiconGo_, true)
	else
		SetActive(slot0.diceiconGo_, false)
	end
end

function slot1.OnChanceItemClick(slot0)
	if slot0.realState_ == NewChessConst.CHANCE_ITEM_STATUS.NORMAL then
		slot0:ExecuteChanceItemClick()
	elseif slot0.realState_ == NewChessConst.CHANCE_ITEM_STATUS.LOCK then
		ShowTips(slot0.chanceItemCfg_.lock_tips)
	end
end

function slot1.ExecuteChanceItemClick(slot0)
	if slot0.chanceItemCfg_.dice_type ~= 0 then
		JumpTools.OpenPageByJump("/newWarChessDiceEventView", {
			chanceID = slot0.chanceID_,
			chanceItemID = slot0.chanceItemID_
		})

		return
	elseif slot0.chanceItemCfg_.jump_event[1] == NewChessConst.CHANCE_JUMP_TYPE.BATTLE then
		NewWarChessAction.SelectChanceItem(slot0.chanceItemID_, {}, function ()
			if not BattleNewWarChessStageCfg[uv0.chanceItemCfg_.jump_event[2]] then
				-- Nothing
			end

			if NewWarChessData:CheckIsAllDie() then
				ShowTips("ACTIVITY_NEW_WARCHESS_ALL_HERO_DIE")

				return
			end

			manager.NewChessManager:BattleStart(uv0.chanceID_, uv0.chanceItemID_, {}, {})
			gameContext:Go("/sectionSelectHero", {
				section = slot0,
				sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS,
				activityID = NewWarChessData:GetCurrentActivity()
			})
		end)
	else
		NewWarChessAction.SelectChanceItem(slot0.chanceItemID_, {}, function ()
			if uv0.executeChanceItemHandle_ then
				uv0.executeChanceItemHandle_(uv0.chanceItemID_)
			else
				print("executeChanceItemHandle_丢失！！")
			end
		end)
	end
end

function slot1.SetIsShow(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot1.Dispose(slot0)
	slot0.executeChanceItemHandle_ = nil

	Object.Destroy(slot0.gameObject_)
	uv0.super.Dispose(slot0)
end

return slot1
