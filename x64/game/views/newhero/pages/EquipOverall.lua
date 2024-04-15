slot0 = class("EquipOverall", ReduxView)

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

	slot0.suitItems_ = {}
	slot0.attrItem_ = {}

	for slot4 = 1, 4 do
		slot0.attrItem_[slot4] = AttributeItem.New(slot0, slot0["attrItem_" .. slot4])
	end

	slot0.tabController_ = slot0.transCon_:GetController("tab")
	slot0.stateController_ = slot0.transCon_:GetController("btnActive")
	slot0.btnController_ = slot0.btnCon_:GetController("btnState")
	slot0.suitController_ = slot0.suitCon_:GetController("suit")
	slot0.skillScroller_ = LuaList.New(handler(slot0, slot0.indexSkillItem), slot0.skillListGo_, EquipNewSkillItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnSuit_, nil, function ()
		uv0.tabController_:SetSelectedState("suit")
	end)
	slot0:AddBtnListener(slot0.btnSkill_, nil, function ()
		uv0.tabController_:SetSelectedState("skill")
	end)
	slot0:AddBtnListener(slot0.btnSave_, nil, function ()
		uv0.saveFunc_()
	end)
	slot0:AddBtnListener(slot0.btnDelete_, nil, function ()
		uv0.deleteFunc_()
	end)
	slot0:AddBtnListener(slot0.btnEquip_, nil, function ()
		uv0.equipFunc_()
	end)
end

function slot0.OnEnter(slot0, slot1)
	slot0.heroViewProxy_ = slot1
end

function slot0.RefreshSuitItem(slot0)
	if #slot0.suitList_ ~= 0 then
		for slot4, slot5 in ipairs(slot0.suitList_) do
			if slot0.suitItems_[slot4] == nil then
				slot0.suitItems_[slot4] = EquipNewSuitItem.New(Object.Instantiate(slot0.suitGo_, slot0.suitContent_, false))
			end

			SetActive(slot6.gameObject_, true)
			slot6:RefreshData(slot0.heroViewProxy_:GetHeroData(slot0.heroID_), slot0.suitList_[slot4])
		end
	end

	for slot4 = #slot0.suitList_ + 1, #slot0.suitItems_ do
		SetActive(slot0.suitItems_[slot4].gameObject_, false)
	end

	slot0.suitController_:SetSelectedState(#slot0.suitList_ ~= 0 and "suit" or "empty")
end

function slot0.indexSkillItem(slot0, slot1, slot2)
	slot2:RefreshData(slot0, slot0.skillList_[slot1])
	slot2:RegistCallBack(function (slot0)
		uv0:SkillClick(uv1, slot0)
	end)
end

function slot0.RefreshHeroInfo(slot0, slot1, slot2, slot3)
	slot4 = slot1.id
	slot0.heroID_ = slot1.id

	slot0:RefreshAttr(slot2, slot4)
	slot0:RefreshSkill(slot2, slot1, slot4)
	slot0:RefreshSuit(slot2, slot4)
	slot0:RefreshBtn(slot3)
end

function slot0.RefreshAttr(slot0, slot1, slot2)
	slot7 = slot1

	for slot7 = 1, 4 do
		slot0.attrItem_[slot7]:RefreshData(slot0, {
			index = slot7,
			attrS = slot0.heroViewProxy_:CalHeroEquipAttribute(slot2, slot7)
		})
	end
end

function slot0.RefreshSkill(slot0, slot1, slot2, slot3)
	slot4 = slot0.heroViewProxy_:GetEquipDataList(slot3, slot1)
	slot5, slot0.isAdd_, slot7 = EquipTools.CountHeroTotalSkill(slot4, slot2, true)
	slot0.equipList_ = slot4
	slot0.skillList_ = {}

	for slot11, slot12 in pairs(slot5) do
		table.insert(slot0.skillList_, {
			unlockLevel = 0,
			id = slot11,
			num = slot12,
			isAdd = slot6,
			location = slot7[slot11]
		})
	end

	slot8 = HeroCfg[slot3].equip_skill

	table.sort(slot0.skillList_, function (slot0, slot1)
		slot3 = table.indexof(uv0, slot1.id)

		if table.indexof(uv0, slot0.id) and slot3 then
			return slot2 < slot3
		end

		return slot0.id < slot1.id
	end)
	slot0.skillScroller_:StartScroll(#slot0.skillList_)
end

function slot0.RefreshSuit(slot0, slot1, slot2)
	slot7 = slot1
	slot0.suitList_ = EquipTools.CountActiveSuit(slot0.heroViewProxy_:GetEquipDataList(slot2, slot7))

	for slot7 = #slot0.suitList_, 1, -1 do
		slot0.suitList_[slot7].heroId = slot2
	end

	slot0:RefreshSuitItem()
end

function slot0.RefreshBtn(slot0, slot1)
	if slot1 and slot0.heroViewProxy_.isSelf then
		slot0.stateController_:SetSelectedState("on")
		slot0.btnController_:SetSelectedState(slot1)
	else
		slot0.stateController_:SetSelectedState("off")
	end
end

function slot0.RegistSkillClick(slot0, slot1)
	slot0.skillClickFunc_ = slot1
end

function slot0.SkillClick(slot0, slot1, slot2)
	if slot0.lastSkillSelect_ then
		slot0.lastSkillSelect_:ShowSelect(false)
	end

	slot0.lastSkillSelect_ = slot1

	slot1:ShowSelect(true)
	slot0.skillClickFunc_(slot1, slot2)
end

function slot0.RegistOptionButton(slot0, slot1, slot2, slot3)
	slot0.saveFunc_ = slot1
	slot0.equipFunc_ = slot2
	slot0.deleteFunc_ = slot3
end

function slot0.DeSelect(slot0)
	if slot0.lastSkillSelect_ then
		slot0.lastSkillSelect_:ShowSelect(false)
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.suitItems_) do
		slot5:Dispose()
	end

	slot0.suitItems_ = nil

	if slot0.skillScroller_ then
		slot0.skillScroller_:Dispose()

		slot0.skillScroller_ = nil
	end

	if slot0.attrItem_ then
		for slot4, slot5 in pairs(slot0.attrItem_) do
			slot5:Dispose()
		end

		slot0.attrItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
