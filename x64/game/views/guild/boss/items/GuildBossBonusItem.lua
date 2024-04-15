slot0 = class("GuildBossBonusItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemList = {}

	for slot4 = 1, 3 do
		slot0.itemList[slot4] = CommonItemView.New(slot0["commonitem_sGo_" .. slot4])
	end

	slot0.statusController_ = slot0.controller:GetController("status")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.getBtn, nil, function ()
		if uv0.remainHp_ <= uv0.needLessHp_ then
			GuildAction.GetGuildBossReward(GuildData:GetGuildInfo().id, 2, uv0.data_[1])
		end
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.remainHp_ = slot2
	slot0.needLessHp_ = ClubBossCfg[GuildData:GetBossDifficulty()].boss_hp * (100 - slot0.data_[1]) / 100
	slot0.bonusDataList_ = slot0.data_[2]
	slot4 = nil
	slot0.numText_.text = slot3 < 10 and "0" .. slot3 or slot3

	slot0:UpdateView()
	slot0:RefreshAwardItemList()
end

function slot0.UpdateView(slot0)
	if slot0.data_[1] == 100 then
		slot0.descLabel_.text = GetTips("CLUB_BOSS_BLOOD_CONDITION_TIP2")
	else
		slot0.descLabel_.text = string.format(GetTips("CLUB_BOSS_BLOOD_CONDITION_TIP1"), tostring(100 - slot0.data_[1] .. "%"))
	end

	if GuildData:HaveGetGuildBossCommonReward(slot0.data_[1]) then
		slot0.statusController_:SetSelectedState("haveGet")
	elseif slot0.remainHp_ <= slot0.needLessHp_ then
		slot0.statusController_:SetSelectedState("canGet")
	else
		slot0.statusController_:SetSelectedState("cannotGet")
	end
end

function slot0.RefreshAwardItemList(slot0)
	for slot4 = 1, 3 do
		if slot0.bonusDataList_[slot4] then
			slot0.itemList[slot4]:SetData({
				id = slot0.bonusDataList_[slot4][1],
				number = slot0.bonusDataList_[slot4][2],
				clickFun = function (slot0)
					ShowPopItem(POP_ITEM, {
						slot0.id
					})
				end
			})
		else
			slot0.itemList[slot4]:SetData()
		end
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil

	if slot0.itemList then
		for slot4, slot5 in ipairs(slot0.itemList) do
			slot5:Dispose()
		end

		slot0.itemList = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
