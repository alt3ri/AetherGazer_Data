slot0 = class("ServantCallNameListViewModule", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
	slot0:InitTab()
	slot0:BuildContext()
end

function slot0.BuildContext(slot0)
	slot0.staticVar = {
		scrollHelper = LuaList.New(handler(slot0, slot0.OnRenderHoldItem), slot0.selectviewGo_, WeaponServantHeadItem),
		tabRaceMap = {
			1,
			2,
			3,
			4,
			5,
			9
		}
	}

	slot0:InitContext()
end

function slot0.InitTab(slot0)
	slot0.tabModule = {}

	for slot5 = 1, 6 do
		slot7 = ServantCallNameTabModule.New(slot0[string.format("tab%dObj_", slot5)])

		slot7:RegisterClickCallback(function ()
			if uv0.context and uv0.context.curRaceTab == uv1 then
				return
			end

			uv0:OnTabClick(uv1)
		end)
		slot7:SetNumber(0)

		slot0.tabModule[slot5] = slot7
	end
end

function slot0.AddUIListener(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.staticVar.scrollHelper:Dispose()

	for slot4 = 1, 6 do
		slot0.tabModule[slot4]:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.InitContext(slot0)
	slot0.context = {
		curRaceTab = 1,
		itemCount = 0,
		curSelectIndex = 0,
		itemList = {},
		itemEntity = {}
	}
end

function slot0.EnterPage(slot0, slot1)
	slot0:InitContext()

	slot0.context.heroId = slot1.heroId
	slot0.context.curRaceTab = slot0:GetRaceTab(slot1.race or 1)

	slot0:OnTabClick(slot0.context.curRaceTab, slot1.servantID)
end

function slot0.RefreshList(slot0, slot1)
	slot0.context.curRaceTab = slot0:GetRaceTab(slot1.race or 1)
	slot0.context.heroId = slot1.heroId
	slot4 = #ServantTools:GetAwakeServantList(slot0.staticVar.tabRaceMap[slot0.context.curRaceTab])
	slot5 = 1
	slot6 = false
	slot7 = nil

	if slot1.servantID then
		for slot11, slot12 in ipairs(slot3) do
			if slot12.id == slot2 then
				slot5 = slot11
				slot6 = true
			end

			if ServantTools.ServantIsHeroRecom(slot12.id, slot0.context.heroId) then
				slot7 = slot11
			end
		end
	end

	if not slot6 and slot7 then
		slot5 = slot7
	end

	slot0.context.itemList = slot3
	slot0.context.itemCount = slot4

	slot0.staticVar.scrollHelper:StartScroll(slot4, slot5)

	slot0.callNameTxt_.text = slot0:GeSleeptName()

	slot0:SelectIndexItem(slot5)
	slot0:SelectServant(slot3[slot5])
	slot0:RefreshRaceTabNum()
end

function slot0.RefreshRaceTabNum(slot0)
	slot2 = {}

	for slot6, slot7 in pairs(WeaponServantData:GetWeaponServantList()) do
		slot8 = WeaponServantCfg[slot7.id].race

		if WeaponServantCfg[slot7.id].type == 3 then
			slot2[slot8] = (slot2[slot8] or 0) + 1
		end
	end

	for slot6 = 1, 6 do
		slot0.tabModule[slot6]:SetNumber(slot2[slot0.staticVar.tabRaceMap[slot6]] or 0)
	end
end

function slot0.OnRenderHoldItem(slot0, slot1, slot2)
	slot3 = slot0.context.itemList[slot1]
	slot0.context.itemEntity[slot1] = slot2

	slot2:OnRender({
		isAdd = false,
		isEquip = true,
		uid = slot3.uid,
		id = slot3.id,
		number = slot3.stage,
		index = slot1
	})
	slot2:ShowSelect(slot1 == slot0.context.curSelectIndex)
	slot2:ShowLock(slot3.locked == 1)
	slot2:ShowMask(false)
	slot2:RegistCallBack(function (slot0)
		uv0:OnItemClick(slot0)
	end)
	slot2:ShowLockObj(false)

	slot4 = false

	if slot0.context.heroId and slot0.context.heroId > 0 then
		slot6 = 0

		if WeaponServantCfg[slot3.id].effect[1] > 0 then
			slot6 = WeaponEffectCfg[slot5].spec_char[1]
		end

		if slot6 and slot6 > 0 and slot6 == slot0.context.heroId then
			slot2:ShowRecommendTag(true)

			slot4 = true
		end
	end

	if not slot4 then
		slot2:ShowRecommendTag(false)
	end

	slot2:RenderEquipStatus(false)
end

function slot0.OnItemClick(slot0, slot1)
	slot2 = slot1:GetIndex()

	slot0:SelectServant(slot0.context.itemList[slot2])
	slot0:SelectIndexItem(slot2)
end

function slot0.SelectIndexItem(slot0, slot1)
	slot0:HideIndexItem(slot0.context.curSelectIndex)
	slot0:ShowIndexItem(slot1)

	slot0.context.curSelectIndex = slot1
end

function slot0.HideIndexItem(slot0, slot1)
	if slot0.context.itemEntity[slot1] and slot2:GetIndex() == slot1 then
		slot2:ShowSelect(false)
	end
end

function slot0.ShowIndexItem(slot0, slot1)
	if slot0.context.itemEntity[slot1] and slot2:GetIndex() == slot1 then
		slot2:ShowSelect(true)
	end
end

function slot0.RestoreListPostion(slot0)
	slot0.staticVar.scrollHelper:ScrollToIndex(slot0.context.curSelectIndex)
end

function slot0.RegisterClickCallback(slot0, slot1)
	slot0.staticVar.clickCallback = slot1
end

function slot0.SelectServant(slot0, slot1)
	if slot0.staticVar.clickCallback then
		slot0.staticVar.clickCallback(slot1)
	end
end

function slot0.OnTabClick(slot0, slot1, slot2)
	slot6 = slot0.staticVar.tabRaceMap[slot1]

	slot0:RefreshList({
		heroId = slot0.context.heroId,
		race = slot6,
		servantID = slot2
	})

	for slot6, slot7 in pairs(slot0.tabModule) do
		if slot6 == slot1 then
			slot7:SetSelect(true)
		else
			slot7:SetSelect(false)
		end
	end
end

function slot0.GeSleeptName(slot0)
	slot2 = ""

	for slot6, slot7 in pairs(WeaponServantCfg) do
		if slot7.race == slot0:GetSelectRace() and slot7.type == 3 then
			slot2 = slot7.id

			break
		end
	end

	return ItemTools.getItemName(slot2)
end

function slot0.GetSelectRace(slot0)
	return slot0.staticVar.tabRaceMap[slot0.context.curRaceTab]
end

function slot0.GetRaceTab(slot0, slot1)
	for slot5, slot6 in pairs(slot0.staticVar.tabRaceMap) do
		if slot6 == slot1 then
			return slot5
		end
	end

	return 1
end

return slot0
