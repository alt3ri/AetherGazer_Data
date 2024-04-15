slot0 = class("WeaponServantFullListViewModule", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.InitDropDown(slot0)
	slot0.dropDown_ = slot0.dropDonwObj_:GetComponent("UIDropDown")

	slot0.dropDown_.options:Clear()
	slot0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("TIP_UPGRADE"), nil))
	slot0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("TIP_RARE"), nil))
	slot0.dropDown_:RefreshShownValue()
end

function slot0.BuildContext(slot0)
	slot0.controller = {
		state = {
			switchState = {
				Down = "down",
				name = "switchState",
				Up = "up",
				comps = slot0.rootController_:GetController("switchState")
			}
		}
	}
	slot0.filterController_ = slot0.filterColorController_:GetController("color")
	slot0.staticVar = {
		scrollHelper = LuaList.New(handler(slot0, slot0.OnRenderItem), slot0.selectviewGo_, WeaponServantHeadItem),
		sortLangMap = {
			GetTips("SERVANT_DETAIL_STAR_LEVEL"),
			GetTips("SERVANT_DETAIL_TRAIN")
		}
	}

	slot0:InitContext()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:InitDropDown()
	slot0:BuildContext()
	slot0:AddUIListener()
end

function slot0.InitContext(slot0)
	slot1 = WeaponServantData:GetSortConfig()
	slot0.context = {
		itemCount = 0,
		curSelectIndex = 0,
		curSelectServantUID = 0,
		itemList = {},
		itemEntity = {},
		itemMap = {},
		servantMap = ServantTools.GetServantMap(),
		curSortBaseIdx = slot1[1],
		sortDescOrder = slot1[2] == 0
	}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.openSortBtn_, nil, function ()
		uv0:OnOpenSortClick()
	end)
	slot0:AddBtnListener(slot0.switchBtn_, nil, function ()
		uv0:OnBtnSwitchClick()
	end)
	slot0:AddBtnListener(slot0.decomposeBtn_, nil, function ()
		uv0:OnDecomposeBtnClick()
	end)
	slot0:AddToggleListener(slot0.dropDown_, function (slot0)
		uv0:OnDropDonwTabClick(slot0 + 1)
	end)
end

function slot0.AddEventListener(slot0)
	slot0:RegistEventListener(COMMON_FILTER_OK, handler(slot0, slot0.OnFilterChange))
	slot0:RegistEventListener(SERVANT_REPLACE, handler(slot0, slot0.OnServantReplaced))
	slot0:RegistEventListener(SERVANT_LOCK, handler(slot0, slot0.OnServantLock))
end

function slot0.OnEnter(slot0)
	slot0:AddEventListener()
	slot0:RenderHoldCount()
	slot0:RenderFlterBtn()
end

function slot0.OnExit(slot0)
	CommonFilterData:ClearFilter(Filter_Root_Define.Servant_Filter_List.filter_id)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:RemoveAllEventListener()
	slot0.staticVar.scrollHelper:Dispose()

	slot0.filterController_ = nil
	slot0.controller = nil

	uv0.super.Dispose(slot0)
end

function slot0.RefreshList(slot0, slot1)
	slot8 = true

	for slot8, slot9 in ipairs(ServantTools:GetServantList(slot1.heroId, ServantTools.GetWeaponShowData(), slot8, slot9, nil, Filter_Root_Define.Servant_Filter_List.filter_id)) do
		if slot9.uid and slot9.uid ~= 0 then
			-- Nothing
		end
	end

	slot0:InitContext()

	slot0.context.heroId = slot1.heroId
	slot5 = #slot3
	slot0.context.itemList = slot3
	slot0.context.itemCount = slot5
	slot0.context.itemMap = {
		[slot9.uid] = slot8
	}
	slot6 = slot0:GetSelectIndex(slot1)

	slot0.staticVar.scrollHelper:StartScroll(slot5, slot6)
	slot0:SelectIndexItem(slot6)
	slot0:SelectServant(slot3[slot6])
end

function slot0.OnRenderItem(slot0, slot1, slot2)
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

function slot0.RenderHoldCount(slot0)
	slot0.haveTxt_.text = table.concat({
		GetTips("ALREADY_GET"),
		": ",
		ServantTools.GetServantShowCount(),
		"/",
		GameSetting.max_weapon_servant.value[1]
	})
end

function slot0.RenderFlterBtn(slot0)
	if CommonFilterData:AtLeastOneChoose(Filter_Root_Define.Servant_Filter_List.filter_id) then
		slot0.filterController_:SetSelectedState("orange")
	else
		slot0.filterController_:SetSelectedState("normal")
	end
end

function slot0.SelectIndexItem(slot0, slot1)
	slot0:HideIndexItem(slot0.context.curSelectIndex)
	slot0:ShowIndexItem(slot1)

	slot0.context.curSelectIndex = slot1

	if slot0.context.itemList[slot1] then
		slot0.context.curSelectServantUID = slot0.context.itemList[slot1].uid
	else
		slot0.context.curSelectServantUID = 0
	end
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

function slot0.GetSelectIndex(slot0, slot1)
	if slot1.jumpUid then
		for slot6, slot7 in ipairs(slot0.context.itemList) do
			if slot7.uid == slot2 then
				return slot6
			end
		end
	end

	return 1
end

function slot0.RegisterClickCallback(slot0, slot1)
	slot0.staticVar.clickCallback = slot1
end

function slot0.SelectServant(slot0, slot1)
	if slot0.staticVar.clickCallback then
		slot0.staticVar.clickCallback(slot1)
	end
end

function slot0.OnItemClick(slot0, slot1)
	slot2 = slot1:GetIndex()

	slot0:SelectServant(slot0.context.itemList[slot2])
	slot0:SelectIndexItem(slot2)
end

function slot0.OnDropDonwTabClick(slot0, slot1)
	slot0.context.curSortBaseIdx = slot1 - 1

	slot0:OnSortParamChange()
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

function slot0.RestoreListPostion(slot0)
end

function slot0.OnOpenSortClick(slot0)
	JumpTools.OpenPageByJump("commonFilterView", {
		filterGroup = Filter_Root_Define.Servant_Filter_List
	})
end

function slot0.OnBtnSwitchClick(slot0)
	slot0.context.sortDescOrder = not slot0.context.sortDescOrder
	slot2 = slot0.controller.state.switchState.Down

	if not slot0.context.sortDescOrder then
		slot2 = slot1.Up
	end

	slot1.comps:SetSelectedState(slot2)
	slot0:OnSortParamChange()
end

function slot0.OnDecomposeBtnClick(slot0)
	slot0:Go("/weaponServantDecomposeView")
end

function slot0.OnFilterChange(slot0)
	slot0:RefreshList({
		heroId = slot0.context.heroId
	})
	slot0:RenderFlterBtn()
end

function slot0.OnSortParamChange(slot0)
	slot1 = 0

	if not slot0.context.sortDescOrder then
		slot1 = 1
	end

	WeaponServantData:SetSortConfig(slot0.context.curSortBaseIdx, slot1)
	slot0:RefreshList({
		heroId = slot0.context.heroId
	})
end

return slot0
