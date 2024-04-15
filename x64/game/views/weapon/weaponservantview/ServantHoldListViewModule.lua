slot0 = class("ServantHoldListViewModule", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:BuildContext()
	slot0:AddUIListener()
end

function slot0.BuildContext(slot0)
	slot0.eventHandler = {
		replaceHandler = handler(slot0, slot0.OnServantReplaced),
		lockHandler = handler(slot0, slot0.OnServantLock)
	}
	slot0.staticVar = {
		scrollHelper = LuaList.New(handler(slot0, slot0.OnRenderHoldItem), slot0.selectviewGo_, WeaponServantHeadItem)
	}

	slot0:InitContext()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.openFullListBtn_, nil, function ()
		uv0:OnFullListBtnClick()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RegistEventListener(SERVANT_REPLACE, slot0.eventHandler.replaceHandler)
	slot0:RegistEventListener(SERVANT_LOCK, slot0.eventHandler.lockHandler)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:RemoveAllEventListener()
	slot0.staticVar.scrollHelper:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.InitContext(slot0)
	slot0.context = {
		curSelectIndex = 0,
		itemCount = 0,
		heroId = 0,
		itemList = {},
		itemEntity = {},
		itemMap = {},
		servantMap = ServantTools.GetServantMap()
	}
end

function slot0.RefreshList(slot0, slot1)
	slot2 = {}
	slot2 = (not slot1.heroId or ServantTools:GetServantList(slot1.heroId, nil, true)) and ServantTools:GetServantList(nil, ServantTools.GetWeaponShowData())
	slot3 = {
		[slot8.uid] = slot7
	}

	for slot7, slot8 in ipairs(slot2) do
		if slot8.uid and slot8.uid ~= 0 then
			-- Nothing
		end
	end

	slot0:InitContext()

	slot0.context.heroId = slot1.heroId
	slot4 = #slot2
	slot5 = slot3[slot1.jumpUid or -1] or 1
	slot0.context.itemList = slot2
	slot0.context.itemCount = slot4
	slot0.context.itemMap = slot3

	slot0.staticVar.scrollHelper:StartScroll(slot4, slot5)
	slot0:SelectIndexItem(slot5)
	slot0:SelectServant(slot2[slot5])

	if slot1.emptyCallback then
		slot6(slot4 == 0)
	end

	SetActive(slot0.openFullListBtn_.gameObject, slot4 ~= 0)
	SetActive(slot0.selectviewGo_, slot4 ~= 0)
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
	slot2:RegistCallBack(function (slot0)
		uv0:OnItemClick(slot0)
	end)
	slot2:ShowMask(slot3.isRecommend or false)

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

	if slot3.uid and slot3.uid ~= 0 then
		if slot0.context.servantMap[slot3.uid] then
			slot2:RenderEquipStatus(true, slot5)
		else
			slot2:RenderEquipStatus(false)
		end
	else
		slot2:RenderEquipStatus(false)
	end
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
		slot2(slot1)
	end
end

function slot0.RegisterFullScreenCallback(slot0, slot1)
	slot0.staticVar.fullScreenClickCallback = slot1
end

function slot0.OnFullListBtnClick(slot0)
	if slot0.staticVar.fullScreenClickCallback then
		slot1()
	end
end

function slot0.OnServantReplaced(slot0, slot1, slot2, slot3)
	slot0.context.servantMap = ServantTools.GetServantMap()

	slot0:OnServantChanged(slot3)
	slot0:OnServantChanged(slot2.servant_id)
end

function slot0.OnServantLock(slot0, slot1)
	slot0:OnServantChanged(slot1)
end

function slot0.OnServantChanged(slot0, slot1)
	if not slot1 or slot1 == 0 then
		return
	end

	slot2 = deepClone(WeaponServantData:GetServantDataByUID(slot1))

	if not slot0.context.itemMap[slot1] then
		return
	end

	if not slot0.context.itemList[slot3] or slot4.uid ~= slot2.uid then
		return
	end

	slot0.context.itemList[slot3] = slot2

	if slot0.context.curSelectIndex == slot3 then
		slot0:SelectServant(slot2)
	end

	if not slot0.context.itemEntity[slot3] or slot5:GetIndex() ~= slot3 then
		return
	end

	slot5:OnRender({
		isAdd = false,
		isEquip = true,
		uid = slot2.uid,
		id = slot2.id,
		number = slot2.stage,
		index = slot3
	})
	slot5:ShowLock(slot2.locked == 1)

	if slot0.context.servantMap[slot1] then
		slot5:RenderEquipStatus(true, slot6)
	else
		slot5:RenderEquipStatus(false)
	end
end

return slot0
