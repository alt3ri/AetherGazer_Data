slot0 = class("PassportShowRewardView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Passport/PassportRewardUI"
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

	slot0.itemViewList = {}
	slot0.normalController = ControllerUtil.GetController(slot0.gameObject_.transform, "contract")
	slot0.lockController = ControllerUtil.GetController(slot0.gameObject_.transform, "lock")
	slot0.normalList = LuaList.New(handler(slot0, slot0.NormalIndexItem), slot0.list1Go_, CommonItemView)
	slot0.payList = LuaList.New(handler(slot0, slot0.PayIndexItem), slot0.list2Go_, CommonItemView)
end

function slot0.NormalIndexItem(slot0, slot1, slot2)
	slot3 = slot0.normalRewardList[slot1]

	CommonTools.SetCommonData(slot2, {
		id = slot3.id,
		number = slot3.number,
		clickFun = function (slot0)
			ShowPopItem(POP_OTHER_ITEM, {
				slot0.id
			})
		end
	})
end

function slot0.PayIndexItem(slot0, slot1, slot2)
	slot3 = slot0.payRewardList[slot1]

	CommonTools.SetCommonData(slot2, {
		id = slot3.id,
		number = slot3.number,
		clickFun = function (slot0)
			ShowPopItem(POP_OTHER_ITEM, {
				slot0.id
			})
		end
	})
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.unlockBtn_, nil, function ()
		uv0:Back()
		JumpTools.OpenPageByJump("/passportBuy")
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.UpdateView(slot0)
	slot0.rewardIdList_ = BattlePassCfg.get_id_list_by_type[BattlePassListCfg[PassportData:GetId()].battlepass_type]

	slot0.normalController:SetSelectedState(slot0.type == 2 and "expand2" or "base")

	slot0.nameTxt_.text = GetTips(slot0.type == 1 and "BATTLEPASS_FREE" or "BATTLEPASS_CHARGE")

	if slot0.type == 2 and PassportData:GetLevel() > 0 and PassportData:GetPayLevel() <= 0 and not slot0.isPassPortBuy then
		slot0.normalController:SetSelectedState("expand")

		slot0.nameTxt_.text = GetTips("BATTLEPASS_CHARGE")
	end

	slot0.lockController:SetSelectedState((PassportData:GetPayLevel() > 0 or slot0.type == 1 or slot0.isPassPortBuy) and "unlock" or "lock")

	if slot0.type == 2 then
		slot0.payRewardList = slot0:GetPayList()

		slot0.payList:StartScroll(#slot0.payRewardList)
	end

	slot0.normalRewardList = slot0:GetNormalList()

	slot0.normalList:StartScroll(#slot0.normalRewardList)
end

function slot0.GetNormalList(slot0)
	slot1 = {}
	slot2 = {}

	for slot6 = 1, PassportData:GetMaxLevel() do
		slot8 = BattlePassCfg[slot0.rewardIdList_[slot6]]["reward_" .. (slot0.type == 1 and "free" or "pay")]
		slot1[slot8[1][1]] = (slot1[slot8[1][1]] or 0) + slot8[1][2]
	end

	for slot6, slot7 in pairs(slot1) do
		table.insert(slot2, {
			id = slot6,
			number = slot7
		})
	end

	table.sort(slot2, function (slot0, slot1)
		if ItemCfg[slot0.id].rare ~= ItemCfg[slot1.id].rare then
			return slot3.rare < slot2.rare
		end

		return slot1.id < slot0.id
	end)

	return slot2
end

function slot0.GetPayList(slot0)
	if PassportData:GetLevel() == 0 then
		return {}
	end

	slot2 = {}
	slot3 = {}

	for slot7 = 1, slot1 do
		slot8 = BattlePassCfg[slot0.rewardIdList_[slot7]]
		slot2[slot8.reward_pay[1][1]] = (slot2[slot8.reward_pay[1][1]] or 0) + slot8.reward_pay[1][2]
	end

	for slot7, slot8 in pairs(slot2) do
		table.insert(slot3, {
			id = slot7,
			number = slot8
		})
	end

	table.sort(slot3, function (slot0, slot1)
		if ItemCfg[slot0.id].rare ~= ItemCfg[slot1.id].rare then
			return slot3.rare < slot2.rare
		end

		return slot1.id < slot0.id
	end)

	return slot3
end

function slot0.OnEnter(slot0)
	slot0.type = slot0.params_.type
	slot0.isPassPortBuy = slot0.params_.isPassPortBuy
	slot0.params_.isPassPortBuy = nil

	slot0:UpdateView()
end

function slot0.OnExploreUpdate(slot0)
	slot0:UpdateView()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.normalList then
		slot0.normalList:Dispose()

		slot0.normalList = nil
	end

	if slot0.payList then
		slot0.payList:Dispose()

		slot0.payList = nil
	end

	Object.Destroy(slot0.gameObject_)
end

return slot0
