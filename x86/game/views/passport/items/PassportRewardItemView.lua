slot0 = class("PassportRewardItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:AddEventListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.commonItem1_ = CommonItemView.New(slot0.commonItemGo1_)
	slot0.commonItem2_ = CommonItemView.New(slot0.commonItemGo2_)
	slot0.CommonData1 = clone(ItemTemplateData)
	slot0.CommonData2 = clone(ItemTemplateData)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(GET_BONUS_SUCCESS, handler(slot0, slot0.OnGetBonus))
	slot0:RegistEventListener(PASSPORT_BUYED, handler(slot0, slot0.OnPassportBuyed))
end

function slot0.OnPassportBuyed(slot0)
	slot0:UpdateView()
end

function slot0.OnGetBonus(slot0, slot1)
	if slot1 == slot0.cfg_.id or slot1 == 0 then
		slot0:UpdateView()
	end
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.cfg_ = BattlePassCfg[slot2]
	slot0.levelCfg_ = GameLevelSetting[slot0.index_]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.levelLabel_.text = string.format("%d", slot0.index_)
	slot0.bottomLabel_.text = string.format("%d", slot0.index_)
	slot1 = PassportData:GetRewardStatus(slot0.index_, slot0.cfg_.id)
	slot2 = {
		id = slot0.cfg_.reward_free[1][1],
		number = slot0.cfg_.reward_free[1][2],
		clickFun = function (slot0)
			uv0:OnItemClick(slot0.id, slot0.number, 1)
		end,
		highLight = false,
		completedFlag = false
	}

	if PassportData:GetPayLevel() <= 0 then
		-- Nothing
	end

	if slot1 == "payHaveGet" then
		slot3.completedFlag = true
		slot2.completedFlag = true
	elseif slot1 == "payCanGet" then
		slot3.highLight = true
		slot2.highLight = true
	elseif slot1 == "freeHaveGet" then
		slot2.completedFlag = true
	elseif slot1 == "freeCanGet" then
		slot2.highLight = true

		SetActive(slot0.redGo1_, true)
	end

	CommonTools.SetCommonData(slot0.commonItem1_, slot2, slot0.CommonData1)
	CommonTools.SetCommonData(slot0.commonItem2_, {
		id = slot0.cfg_.reward_pay[1][1],
		number = slot0.cfg_.reward_pay[1][2],
		clickFun = function (slot0)
			uv0:OnItemClick(slot0.id, slot0.number, 2)
		end,
		highLight = false,
		completedFlag = false,
		locked = false,
		locked = true
	}, slot0.CommonData2)
end

function slot0.AddUIListener(slot0)
end

function slot0.OnItemClick(slot0, slot1, slot2, slot3)
	if slot3 == 1 and PassportData:GetRewardStatus(slot0.index_, slot0.cfg_.id) ~= "freeCanGet" and PassportData:GetRewardStatus(slot0.index_, slot0.cfg_.id) ~= "payCanGet" then
		if slot1 ~= 0 and slot2 ~= 0 then
			ShowPopItem(POP_ITEM, {
				slot1,
				slot2
			})
		end

		return
	end

	if slot3 == 2 and PassportData:GetRewardStatus(slot0.index_, slot0.cfg_.id) ~= "payCanGet" and PassportData:GetRewardStatus(slot0.index_, slot0.cfg_.id) ~= "payHalfCanGet" then
		if slot1 ~= 0 and slot2 ~= 0 then
			ShowPopItem(POP_ITEM, {
				slot1,
				slot2
			})
		end

		return
	end

	PassportAction.RequestGetBonus(slot0.cfg_.id, PassportData:GetPayLevel() > 0 and 1 or 0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()

	if slot0.commonItem1_ then
		slot0.commonItem1_:Dispose()

		slot0.commonItem1_ = nil
	end

	if slot0.commonItem2_ then
		slot0.commonItem2_:Dispose()

		slot0.commonItem2_ = nil
	end

	slot0.CommonData1 = nil
	slot0.CommonData2 = nil

	uv0.super.Dispose(slot0)
end

return slot0
