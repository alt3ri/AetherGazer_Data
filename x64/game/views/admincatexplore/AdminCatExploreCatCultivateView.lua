slot0 = class("AdminCatExploreCatCultivateView", ReduxView)
slot1 = 56

function slot0.UIName(slot0)
	return "Widget/System/ExploreUI/ExplpreChipUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.adminCatList_ = LuaList.New(handler(slot0, slot0.SetItemData), slot0.listGo_, AdminCatExploreCultureItem)
	slot0.stateController = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
	slot0.conditionController1 = ControllerUtil.GetController(slot0.condition1_.transform, "state")
	slot0.conditionController2 = ControllerUtil.GetController(slot0.condition2_.transform, "state")
end

function slot0.SetItemData(slot0, slot1, slot2)
	table.insert(slot0.itemList, slot2)
	slot2:SetData(slot0.allAdminCatList[slot1], slot1, handler(slot0, slot0.ItemRegisterFunction), slot0.selectIndex)
end

function slot0.ItemRegisterFunction(slot0, slot1)
	slot0.selectIndex = slot1

	slot0:PlayAnimation()
	slot0:UpdateView()
end

function slot0.PlayAnimation(slot0)
	slot0.animPanelGo1_:Play("Fx_ExplpreChipUI_icon_cx", -1, 0)
	slot0.animPanelGo2_:Play("Fx_ExplpreChipUI_right_cx", -1, 0)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.unlockBtn_, nil, function ()
		uv0.sortId = uv0.allAdminCatList[uv0.selectIndex].id

		AdminCatExploreAction.UnlockAdminCat(uv0.sortId)
	end)
	slot0:AddBtnListener(slot0.levelUpBtn_, nil, function ()
		if uv0.stateController:GetSelectedState() == "normal" then
			if uv0.allAdminCatList[uv0.selectIndex].canLevelUp == false then
				ShowTips("EXPLORE_PROHIBIT_SKILL_UPGRADE")

				return
			end

			AdminCatExploreAction.AdminCatSkillLevelUp(uv0.allAdminCatList[uv0.selectIndex].id, uv0.skillID)
		else
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")
		end
	end)
end

function slot0.OnSkillLevelUpUpdate(slot0)
	slot0:UpdateView()
end

function slot0.OnUnlockAdminCatUpdate(slot0)
	AdminCatExploreData:ModifyData({
		slot0.skillConsume
	}, false)
	slot0:UpdateView()
end

function slot0.UpdateBar(slot0)
end

function slot0.CheckEnough(slot0)
	return slot0.skillConsume[2] <= ItemTools.getItemNum(slot0.skillConsume[1])
end

function slot0.UpdateView(slot0)
	slot0.selectIndex = slot0.selectIndex or 1
	slot0.allAdminCatList = AdminCatExploreData:SortAllAdminCatList()

	if slot0.sortId then
		for slot4, slot5 in ipairs(slot0.allAdminCatList) do
			if slot5.id == slot0.sortId then
				slot0.selectIndex = slot4
			end
		end

		slot0.sortId = nil
	end

	slot2 = AdminCatExploreData:GetDataByPara("level")
	slot3 = ExploreMeowCfg[slot0.allAdminCatList[slot0.selectIndex].id]
	slot5 = ExploreMeowInbornCfg[slot3.inborn]
	slot6 = AdminCatExploreData:GetDataByPara("totalAdminCat")
	slot7 = AdminCatExploreData:GetDataByPara("skillData")[ExploreMeowSkillCfg[slot3.skill].id] or 1
	slot8 = AdminCatExploreData:GetDataByPara("adminCatLockList")
	slot9 = AdminCatExploreData:GetDataByPara("accumulateC")
	slot0.skillID = slot4.id
	slot0.skillConsume = nil
	slot0.itemList = {}
	slot0.adminCatConsume = slot3.unlock_condition

	if slot1.canUse == false then
		slot0.stateController:SetSelectedState(slot8[slot1.id] and (slot2 < slot8[slot1.id] or AdminCatExploreData:CheckCanLock(slot0.adminCatConsume) == false) and "lock" or "unlock")

		slot0.conditionDesc1_.text = string.format(GetTips("EXPLORE_LEVEL"), slot8[slot1.id] or 1)
		slot0.conditionDesc2_.text = GetTips("EXPLORE_MEOW_DEBLOCKING_CONDITION") .. ItemTools.getItemName(uv0)
		slot0.conditionNum1_.text = slot2 .. "/" .. slot8[slot1.id]
		slot0.conditionNum2_.text = (slot0.adminCatConsume[1][2] < slot9 and slot0.adminCatConsume[1][2] or slot9) .. "/" .. slot0.adminCatConsume[1][2]

		slot0.conditionController1:SetSelectedState(slot8[slot1.id] <= slot2 and "can" or "cannot")
		slot0.conditionController2:SetSelectedState(slot0.adminCatConsume[1][2] <= slot9 and "can" or "cannot")
	elseif slot7 == #slot4.skill_effect then
		slot0.stateController:SetSelectedState("max")
	else
		slot0.skillConsume = slot4.skill_up_consume[slot7][1]

		slot0.stateController:SetSelectedState(slot0:CheckEnough() and "normal" or "lack")

		slot0.levelUpTxt_.text = "Lv" .. slot7 + 1
		slot0.consumeTxt_.text = (slot0:CheckEnough() and "<color=#ffffff>" or "<color=#B94A53>") .. ItemTools.getItemNum(slot0.skillConsume[1]) .. "</color>/" .. slot0.skillConsume[2]
		slot0.itemImage_.sprite = ItemTools.getItemSprite(slot0.skillConsume[1])
	end

	slot0.adminCatList_:StartScroll(slot6)

	slot0.inbornImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Chip/" .. slot5.inborn_icon)
	slot0.skillImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Chip/" .. slot4.skill_icon)
	slot0.adminCatImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Managecat_l/" .. slot3.meow_icon)
	slot0.lvImage_.sprite = getSpriteWithoutAtlas("TextureBg/ExploreUI/icon_" .. slot2)
	slot0.skillLv_.text = "Lv." .. slot7
	slot0.adminCatTxt_.text = GetI18NText(slot3.meow_name)
	slot0.inbornDescTxt_.text = GetI18NText(slot5.inborn_description)
	slot0.inbornNameTxt_.text = GetI18NText(slot5.inborn_name)
	slot0.skillNameTxt_.text = GetI18NText(slot4.skill_name)
	slot0.skillDescTxt_.text = string.format(GetI18NText(slot4.skill_description), tostring(slot4.skill_effect[slot7]))
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	slot0.selectIndex = nil

	if slot0.itemList then
		for slot4, slot5 in ipairs(slot0.itemList) do
			slot5:OnExit()
		end
	end

	manager.windowBar:HideBar()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		uv0
	})
end

function slot0.Dispose(slot0)
	if slot0.itemList then
		for slot4, slot5 in ipairs(slot0.itemList) do
			slot5:Dispose()
		end
	end

	slot0.itemList = {}

	if slot0.adminCatList_ then
		slot0.adminCatList_:Dispose()

		slot0.adminCatList_ = nil
	end

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
