slot0 = class("RestaurantCookUpView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dining/PotUpgradeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.sceneID = DormConst.CANTEEN_ID
	slot0.unlockScroll = LuaList.New(handler(slot0, slot0.unLockItem), slot0.materialListGo_, CommonItemView)
	slot0.conditionScroll = LuaList.New(handler(slot0, slot0.conditionItem), slot0.conditionListGo_, RestaurantCookConditionItem)
	slot0.skillScroll = LuaList.New(handler(slot0, slot0.skillItem), slot0.skillListGo_, RestaurantCookConditionItem)
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.skillListController = ControllerUtil.GetController(slot0.skillListGo_.transform, "empty")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.tree_ = LuaTree.New(slot0.uitreeGo_)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		CanteenConst.COOK_LEVEL_UP_CURRENCY
	})
	manager.windowBar:SetBarCanAdd(CanteenConst.COOK_LEVEL_UP_CURRENCY, true)
	slot0:RefreshTree()

	slot0.type = slot0.params_.type or 1
	slot0.furEID = slot0.params_.furEID or CanteenTools:GetFurEidByType(DormEnum.FurnitureTypeNum.Pan)
	slot0.unLockFlag = true

	slot0:RegisterEvent()

	slot0.furCfgID = BackHomeCanteenFurnitureIDCfg[slot0.furEID].type_id

	if not slot0.type then
		slot0.currentGroupIndex_ = 1
	else
		slot0.currentGroupIndex_ = slot0.type
	end

	slot0.currentItemIndex_ = 1

	if slot0.furEID then
		for slot5 = 0, slot0.treeData_.groupDatas[slot0.currentGroupIndex_ - 1].itemDatas.Count - 1 do
			if slot1.itemDatas[slot5].id == slot0.furEID then
				slot0.currentItemIndex_ = slot5 + 1

				break
			end
		end
	end

	slot0.tree_:SelectItem(slot0.currentGroupIndex_, slot0.currentItemIndex_)
	slot0:BindRedPoint()
end

function slot0.BindRedPoint(slot0)
	for slot4, slot5 in pairs(slot0.titles) do
		manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(slot4), string.format("%s_%s", RedPointConst.CANTEEN_UPGRADE_AVAILABLE, tostring(slot4)))
	end
end

function slot0.UnBindRedPoint(slot0)
	for slot4, slot5 in pairs(slot0.titles) do
		manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(slot4), string.format("%s_%s", RedPointConst.CANTEEN_UPGRADE_AVAILABLE, tostring(slot4)))
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.upFlag then
		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.Close then
			manager.notify:Invoke(DORM_RESTAURANT_UPDATE_SCENE_ITEM)
		elseif CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantAuto then
			manager.notify:Invoke(DORM_RESTAURANT_START_AUTO)
		end
	end

	slot0.upFlag = nil

	slot0:RemoveAllEventListener()
	slot0:UnBindRedPoint()
end

function slot0.RegisterEvent(slot0)
	slot0:RegistEventListener(CANTEEN_FUR_LEVEL_UP, function ()
		uv0.upFlag = true

		uv0.tree_:SelectItem(uv0.currentGroupIndex_, uv0.currentItemIndex_)
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.upBtn_, nil, function ()
		if uv0.furEID then
			if not uv0.unLockFlag then
				ShowTips(GetTips("DORM_CANTEEN_CANT_LEVEL_UP"))

				return
			end

			if uv0:CheckCurrency() then
				CanteenAction:CanteenFurnitureUpgrade(uv0.furEID)
			else
				ShowTips(GetTips("DORM_CANTEEN_LEVEL_NOT_ENOUGH"))
			end
		end
	end)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnGroupSelect(slot0, slot1, slot2)
	slot0.currentGroupIndex_ = slot1

	if not slot0.currentItemIndex_ then
		slot0.currentItemIndex_ = 1
	end

	DormRedPointTools:ConsumeNotification(string.format("%s_%s", RedPointConst.CANTEEN_UPGRADE_AVAILABLE, slot1), DormRedPointTools.RedPointType.Session)
	slot0:UpdataCookLevelUpInfo(slot0.currentGroupIndex_)
end

function slot0.OnItemSelect(slot0, slot1)
	slot0.currentItemIndex_ = slot1
	slot0.unLockFlag = true

	slot0:RefreshView()
end

function slot0.RefreshTree(slot0)
	slot0.titles = {
		GetTips("DORM_CANTEEN_FURNITURE_KITCHEN"),
		GetTips("DORM_CANTEEN_FURNITURE")
	}

	slot0.tree_:SetSelectedHandler(nil, slot5)

	slot1 = UITreeData.New()

	for slot5 = 1, #slot0.titles do
		slot6 = UITreeGroupData.New()
		slot6.id = slot5
		slot6.text = GetI18NText(slot0.titles[slot5])

		if slot5 == 1 then
			slot7, slot8 = nil
			slot7 = UITreeItemData.New()
			slot7.id = CanteenTools:GetFurEidByType(DormEnum.FurnitureTypeNum.Pan)
			slot8 = BackHomeCanteenFurnitureIDCfg[slot7.id].type_id
			slot7.text = ItemTools.getItemName(slot8)
			slot7.extraData = BackHomeCanteenFurnitureCfg[slot8].type

			slot6.itemDatas:Add(slot7)

			slot7 = UITreeItemData.New()
			slot7.id = CanteenTools:GetFurEidByType(DormEnum.FurnitureTypeNum.Oven)
			slot8 = BackHomeCanteenFurnitureIDCfg[slot7.id].type_id
			slot7.text = ItemTools.getItemName(slot8)
			slot7.extraData = BackHomeCanteenFurnitureCfg[slot8].type

			slot6.itemDatas:Add(slot7)

			slot7 = UITreeItemData.New()
			slot7.id = CanteenTools:GetFurEidByType(DormEnum.FurnitureTypeNum.Steamer)
			slot8 = BackHomeCanteenFurnitureIDCfg[slot7.id].type_id
			slot7.text = ItemTools.getItemName(slot8)
			slot7.extraData = BackHomeCanteenFurnitureCfg[slot8].type

			slot6.itemDatas:Add(slot7)

			slot7 = UITreeItemData.New()
			slot7.id = CanteenTools:GetFurEidByType(DormEnum.FurnitureTypeNum.Pot)
			slot8 = BackHomeCanteenFurnitureIDCfg[slot7.id].type_id
			slot7.text = ItemTools.getItemName(slot8)
			slot7.extraData = BackHomeCanteenFurnitureCfg[slot8].type

			slot6.itemDatas:Add(slot7)
		end

		if slot5 == 2 then
			for slot10, slot11 in ipairs(BackHomeCanteenFurnitureCfg.all) do
				if BackHomeCanteenFurnitureCfg[slot11].type == 2 then
					slot13 = nil
					slot13 = UITreeItemData.New()
					slot13.id = CanteenTools:GetCanteenEIDByFurCfgID(slot11)
					slot14 = BackHomeCanteenFurnitureIDCfg[slot13.id].type_id
					slot13.text = ItemTools.getItemName(slot14)
					slot13.extraData = BackHomeCanteenFurnitureCfg[slot14].type

					slot6.itemDatas:Add(slot13)
				end
			end
		end

		slot1.groupDatas:Add(slot6)
	end

	slot0.tree_:SetData(slot1)

	slot5 = handler(slot0, slot0.OnGroupSelect)

	slot0.tree_:SetSelectedHandler(slot5, handler(slot0, slot0.OnItemSelect))

	slot0.treeData_ = slot1
	slot0.upControllerList = {}

	for slot5 = 1, slot0.treeData_.groupDatas.Count do
		for slot10 = 1, slot0.treeData_.groupDatas[slot5 - 1].itemDatas.Count do
			slot13 = ControllerUtil.GetController(slot0.tree_:GetItemGameObjectById(slot5, slot6.itemDatas[slot10 - 1].id).transform, "levelUp")

			if not slot0.upControllerList[slot5] then
				slot0.upControllerList[slot5] = {}
			end

			table.insert(slot0.upControllerList[slot5], slot13)
		end
	end
end

function slot0.skillItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.skillList[slot1], 1)
end

function slot0.unLockItem(slot0, slot1, slot2)
	slot2:SetData(slot0.materialList[slot1])

	slot3 = slot0.materialList[slot1]

	slot2:RefreshBottomText({
		ItemTools.getItemNum(slot3.id),
		slot3.number
	})
end

function slot0.conditionItem(slot0, slot1, slot2)
	slot2:UpdataCondition(function (slot0)
		uv0.unLockFlag = slot0
	end)
	slot2:RefreshUI(slot0.conditionList[slot1], 2)

	if slot0.unLockFlag and slot0:CheckCurrency() then
		slot0.stateController:SetSelectedState("false")
	else
		slot0.stateController:SetSelectedState("no")
	end
end

function slot0.UpdataCookLevelUpInfo(slot0, slot1)
	for slot6 = 1, #slot0.upControllerList[slot1] do
		if CanteenTools:CheckFurCanLevelUp(slot0.treeData_.groupDatas[slot1 - 1].itemDatas[slot6 - 1].id) then
			slot0.upControllerList[slot1][slot6]:SetSelectedState("true")
		else
			slot0.upControllerList[slot1][slot6]:SetSelectedState("false")
		end
	end
end

function slot0.RefreshView(slot0)
	slot0.furEID = slot0.treeData_.groupDatas[slot0.currentGroupIndex_ - 1].itemDatas[slot0.currentItemIndex_ - 1].id

	slot0:RefreshFurInfo(slot0.furEID)
end

function slot0.RefreshFurInfo(slot0, slot1)
	slot2 = BackHomeCanteenFurnitureIDCfg[slot1].type_id
	slot3 = CanteenData:GetFurnitureLevel(slot1)
	slot0.num0Text_.text = string.format(GetTips("DORM_CANTEEN_LEVEL"), slot3)
	slot0.titleText_.text = ItemTools.getItemName(slot2)
	slot0.iconImg_.sprite = ItemTools.getItemSprite(slot2)

	slot0:RefreshSkillEffectList(slot2, slot3)

	if slot3 ~= #BackHomeCanteenFurnitureCfg[slot2].cost_material then
		slot0.stateController:SetSelectedState("false")

		slot0.num1Text_.text = string.format(GetTips("DORM_CANTEEN_LEVEL"), slot3 + 1)

		if slot3 == 0 then
			slot0.conditionTitle.text = GetTips("DORM_CANTEEN_UNLOCK_CONDITION")
			slot0.btnText.text = GetTips("DORM_CANTEEN_LEVEL_UNLOCK")
		else
			slot0.conditionTitle.text = GetTips("DORM_CANTEEN_LEVEL_CONDITION")
			slot0.btnText.text = GetTips("TEXT_UPGRADE")
		end

		slot0:RefreshLevelUpInfo(slot2, slot4)
		slot0:RefreshMaterialList(slot2, slot4)
	else
		slot0.stateController:SetSelectedState("true")
	end
end

function slot0.RefreshSkillEffectList(slot0, slot1, slot2)
	slot0.skillList = {}

	slot0:AddSkillList(slot1, slot2)
	slot0:AddUnSkillList(slot1, slot2)
	CommonTools.UniversalSortEx(slot0.skillList, {
		ascend = true,
		map = function (slot0)
			return slot0.type
		end
	})

	if slot0.skillList then
		slot0.skillScroll:StartScroll(#slot0.skillList)
	else
		slot0.skillScroll:StartScroll(0)
		slot0.skillListController:SetSelectedState("false")
	end
end

function slot0.AddSkillList(slot0, slot1, slot2)
	if BackHomeCanteenFurnitureCfg[slot1].skill[slot2] then
		for slot7, slot8 in ipairs(slot3) do
			if BackHomeHeroSkillCfg[slot8] then
				table.insert(slot0.skillList, {
					type = 1,
					cfgID = slot8,
					level = slot2,
					furID = slot1
				})
			end
		end
	end

	if BackHomeCanteenFurnitureCfg[slot1].skill[slot2 + 1] then
		for slot8, slot9 in ipairs(slot4) do
			slot10 = false

			if slot3 then
				for slot14, slot15 in ipairs(slot3) do
					if BackHomeHeroSkillCfg[slot9].type == BackHomeHeroSkillCfg[slot15].type then
						if BackHomeHeroSkillCfg[slot9].type == 2 or BackHomeHeroSkillCfg[slot9].type == 1 then
							if BackHomeHeroSkillCfg[slot9].param[1] == BackHomeHeroSkillCfg[slot15].param[1] then
								slot10 = true

								break
							end
						else
							slot10 = true

							break
						end
					end
				end
			end

			if not slot10 then
				table.insert(slot0.skillList, {
					type = 4,
					cfgID = slot9,
					level = slot2 + 1
				})
			end
		end
	end
end

function slot0.AddUnSkillList(slot0, slot1, slot2)
	if BackHomeCanteenFurnitureCfg[slot1].canteen_storage_max[slot2] and slot3 > 0 then
		table.insert(slot0.skillList, {
			type = 3,
			effectType = CanteenConst.FurEffectType.Storage,
			level = slot2,
			cfgID = slot1
		})
	elseif BackHomeCanteenFurnitureCfg[slot1].canteen_storage_max[slot2 + 1] and slot4 > 0 then
		table.insert(slot0.skillList, {
			type = 4,
			effectType = CanteenConst.FurEffectType.Storage,
			level = slot2 + 1,
			cfgID = slot1
		})
	end

	if BackHomeCanteenFurnitureCfg[slot1].canteen_sell_max[slot2] and slot4 > 0 then
		table.insert(slot0.skillList, {
			type = 3,
			effectType = CanteenConst.FurEffectType.SellMax,
			level = slot2,
			cfgID = slot1
		})
	elseif BackHomeCanteenFurnitureCfg[slot1].canteen_sell_max[slot2 + 1] and slot5 > 0 then
		table.insert(slot0.skillList, {
			type = 4,
			effectType = CanteenConst.FurEffectType.SellMax,
			level = slot2 + 1,
			cfgID = slot1
		})
	end

	if #DormSkillData:GetCookCanUnlockFoodList(slot1, slot2) and slot5 > 0 then
		table.insert(slot0.skillList, {
			type = 3,
			effectType = CanteenConst.FurEffectType.UnLockFood,
			level = slot2,
			cfgID = slot1,
			unLockNum = slot5
		})
	elseif #DormSkillData:GetCookCanUnlockFoodList(slot1, slot2 + 1) and slot6 > 0 then
		table.insert(slot0.skillList, {
			type = 4,
			effectType = CanteenConst.FurEffectType.UnLockFood,
			level = slot2 + 1,
			cfgID = slot1,
			unLockNum = slot6
		})
	end
end

function slot0.RefreshLevelUpInfo(slot0, slot1, slot2)
	slot0.conditionList = {}

	for slot7, slot8 in ipairs(BackHomeCanteenFurnitureCfg[slot1].condition[slot2]) do
		table.insert(slot0.conditionList, {
			type = 2,
			cfgID = slot8
		})
	end

	if slot0.conditionList then
		slot0.conditionScroll:StartScroll(#slot0.conditionList)
	else
		slot0.conditionScroll:StartScroll(0)
	end
end

function slot0.RefreshMaterialList(slot0, slot1, slot2)
	if BackHomeCanteenFurnitureCfg[slot1].cost_material[slot2] then
		slot0.materialList = {}

		for slot7, slot8 in ipairs(slot3) do
			table.insert(slot0.materialList, {
				id = slot8[1],
				number = slot8[2],
				clickFun = function (slot0)
					ShowPopItem(POP_ITEM, {
						slot0.id,
						slot0.num
					})
				end
			})
		end

		slot0.unlockScroll:StartScroll(#slot0.materialList)

		slot0.curIcon.sprite = ItemTools.getItemSprite(slot3[1][1])
		slot0.costText_.text = slot3[1][2]

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.costTrs_)
	else
		slot0.unlockScroll:StartScroll(0)
	end
end

function slot0.CheckCurrency(slot0)
	slot1 = BackHomeCanteenFurnitureIDCfg[slot0.furEID].type_id
	slot3 = 0

	if CanteenData:GetFurInfoList()[slot0.furEID] then
		slot3 = slot2.level
	end

	for slot8, slot9 in ipairs(BackHomeCanteenFurnitureCfg[slot1].cost_material[slot3 + 1]) do
		if ItemTools.getItemNum(slot9[1]) < slot9[2] then
			return false
		end
	end

	return true
end

function slot0.Dispose(slot0)
	if slot0.tree_ then
		slot0.tree_:Dispose()

		slot0.tree_ = nil
	end

	if slot0.unlockScroll then
		slot0.unlockScroll:Dispose()

		slot0.unlockScroll = nil
	end

	if slot0.conditionScroll then
		slot0.conditionScroll:Dispose()

		slot0.conditionScroll = nil
	end

	if slot0.skillScroll then
		slot0.skillScroll:Dispose()

		slot0.skillScroll = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
