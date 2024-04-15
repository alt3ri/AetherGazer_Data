slot0 = class("WeaponLvupView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:buildController()
	slot0:buildContext()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.RenderItem), slot0.itemList_, CommonItemView)

	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0:RegistEventListener(COMMON_FILTER_OK, handler(slot0, slot0.OnFilterChange))
	slot0:RegistEventListener(WEAPON_STR, function (slot0, slot1)
		uv0:OnWeaponUpgrade(slot0, slot1)
	end)
end

function slot0.OnExit(slot0)
	CommonFilterData:ClearFilter(Filter_Root_Define.Weapon_LevelUp_Cost_List.filter_id)
	slot0:RemoveAllEventListener()
end

function slot0.buildController(slot0)
	slot0.controller_ = {
		comps = slot0.gameObject_:GetComponent("ControllerExCollection"),
		state = {
			levelMax = {
				Max = "max",
				name = "levelMax",
				Normal = "normal"
			}
		}
	}
	slot0.addStatusController = slot0.controller_.comps:GetController("addStatus")
end

function slot0.SwitchControllerState(slot0, slot1, slot2)
	if slot0.controller_.comps:GetController(slot1) then
		slot4:SetSelectedState(slot2)
	end
end

function slot0.buildContext(slot0, slot1)
	slot1 = slot1 or HeroConst.HERO_DATA_TYPE.DEFAULT
	slot0.context = {
		totalCount = 0,
		materialCount = 0,
		totalSelect = 0,
		heroId = 0,
		servantCount = 0,
		materialList = {},
		servantList = {},
		weaponInfo = {},
		type = slot1,
		dataPorxy = HeroViewDataProxy.New(slot1)
	}
	slot0.constVar = {
		yellow = "363A42",
		sliderBarWidth = 501,
		red = "CD421E"
	}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.quickSelectBtn_, nil, function ()
		uv0:QuickSelectBtnClick()
	end)
	slot0:AddBtnListener(slot0.upgradeBtn_, nil, function ()
		uv0:OnUpgradeBtnClick()
	end)
	slot0:AddBtnListener(slot0.filterBtn_, nil, function ()
		uv0:OnFilterBtnClick()
	end)
end

function slot0.ShowWeaponInfoLocal(slot0)
	slot0:UpdateWeaponInfo()
	slot0:ShowWeaponInfo(slot0.context.heroId, slot0.context.weaponInfo)
end

function slot0.ShowWeaponInfo(slot0, slot1, slot2, slot3)
	slot0:buildContext(slot3)

	slot0.context.weaponInfo = slot2
	slot0.context.heroId = slot1

	slot0:RenderView()

	if not slot0:CheckWeaponIsMaxLevel() then
		slot0:RefreshMaterialList()
		slot0.scrollHelper_:StartScroll(slot0.context.totalCount, 0)
	end
end

function slot0.RenderView(slot0)
	if not slot0:CheckWeaponIsMaxLevel() then
		slot0:SwitchControllerState(slot0.controller_.state.levelMax.name, slot0.controller_.state.levelMax.Normal)
		slot0:RenderNormalView()
	else
		slot0:SwitchControllerState(slot0.controller_.state.levelMax.name, slot0.controller_.state.levelMax.Max)
		slot0:RenderMaxView()
	end
end

function slot0.RenderNormalView(slot0)
	slot1 = slot0.context.weaponInfo
	slot2 = slot1.breakthrough
	slot3 = WeaponTools.WeaponAtk(slot1.level, slot2)
	slot4, slot5, slot6, slot7 = WeaponTools.AddWeaponExp(slot1.exp, slot2, slot0.context.totalSelect)
	slot8 = GameLevelSetting[slot5].weapon_level_exp
	slot9 = WeaponTools.WeaponAtk(slot5, slot2)
	slot0.originatkText_.text = string.format("%d", slot3)
	slot0.originatk2Text_.text = string.format("%d", slot3)
	slot0.afteratkText_.text = string.format("%d", slot9)

	if slot9 ~= slot3 then
		slot0.atkArrowImg_.color = Color.New(1, 0.4431373, 0, 1)
	else
		slot0.atkArrowImg_.color = Color.New(0.2117647, 0.227451, 0.2588235, 1)
	end

	slot11, slot12, slot13 = WeaponTools.AddWeaponExp(slot1.exp, slot1.breakthrough, 0)
	slot14 = slot11 / GameLevelSetting[slot1.level].weapon_level_exp * slot0.constVar.sliderBarWidth

	if slot1.level < slot5 then
		slot0.realExpTrans_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, 0)
		slot0.fakeExpTrans_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, slot4 / slot8 * slot0.constVar.sliderBarWidth)
	else
		slot0.realExpTrans_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, slot14)
		slot0.fakeExpTrans_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, slot10)
	end

	slot0.afterlvText_.text = slot5

	if HeroConst.WEAPON_LV_MAX <= slot5 then
		slot0.exptextText_.text = "-/-"
	else
		slot0.exptextText_.text = slot4 .. "/" .. slot8
	end

	slot0.totalexpText_.text = "+" .. slot0.context.totalSelect
	slot0.originlvText_.text = slot1.level

	if slot0.context.totalSelect == 0 and slot1.level == slot5 then
		slot0.addStatusController:SetSelectedState("normal")
	else
		SetActive(slot0.showMax_, slot7)
		slot0.addStatusController:SetSelectedState("add")
	end

	slot0:RenderCost()
end

function slot0.RenderMaxView(slot0)
	slot2 = slot0.context.weaponInfo
	slot0.maxSubNameTxt_.text, slot0.maxSubNumTxt_.text = SkillTools.GetAttr(HeroCfg[slot0.context.heroId].weapon_break_attribute[slot2.breakthrough])
	slot0.maxLevelTxt_.text = HeroConst.WEAPON_LV_MAX
	slot0.maxAttackNumTxt_.text = math.floor(WeaponTools.WeaponAtk(slot2.level, slot2.breakthrough))
end

function slot0.RenderItem(slot0, slot1, slot2)
	slot3 = 1

	if slot0.context.materialCount < slot1 then
		slot3 = 2
		slot1 = slot1 - slot0.context.materialCount
	end

	slot4 = nil

	if slot3 == 1 then
		slot4 = slot0.context.materialList[slot1]
	elseif slot3 == 2 then
		slot4 = slot0.context.servantList[slot1]
	end

	slot4.index = slot1

	if slot4.type == ItemConst.ITEM_TYPE.MATERIAL then
		function slot4.longClickFun(slot0)
			uv0:RenderView(true)

			return uv0:OnMaterialLongPress(uv1, uv2)
		end
	elseif slot4.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		function slot4.clickFun(slot0)
			uv0:OnServantClick(uv1, uv2)
			uv0:RenderView(true)
		end
	end

	function slot4.clickAmountFun(slot0)
		uv0:RenderView(true)

		return uv0:OnMaterialCutClick(uv1, uv2)
	end

	slot2:SetData(slot4)
	slot2:RefreshGray(slot4.topAmountValue and slot4.topAmountValue > 0)

	slot2.infoProxy = slot4
end

function slot0.RenderCost(slot0)
	slot0.tokenTxt_.text = setTextColor(slot0.constVar.yellow, slot0.constVar.red, slot0.context.totalSelect * GameSetting.weapon_strengthen_gold_cost.value[1], ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD))
end

function slot0.OnGoldChange(slot0)
	slot0:RenderCost()
	slot0:RenderView()
end

function slot0.OnWeaponUpgrade(slot0, slot1, slot2)
	slot3 = slot0.context.weaponInfo
	slot4, slot5, slot6 = WeaponTools.AddWeaponExp(slot3.exp, slot3.breakthrough, slot0.context.totalSelect)

	if slot3.level == slot5 then
		ShowTips("SUCCESS_STRENGTHEN")
		slot0:ShowWeaponInfoLocal()

		return
	end

	slot0:ShowWeaponInfoLocal()
	JumpTools.OpenPageByJump("weaponStr", {
		oriLv = slot7,
		afterLv = slot8,
		breakthrough = slot0.context.weaponInfo.breakthrough,
		callback = function ()
			getReward(formatRewardCfgList(MaterialTools.materialGiveBack(uv0, ItemConst.STR_ITEM.WEAPON)))
		end
	})
end

function slot0.OnMaterialLongPress(slot0, slot1, slot2)
	slot3 = slot0.context.weaponInfo
	slot5, slot6, slot7, slot8 = WeaponTools.AddWeaponExp(slot3.exp, slot3.breakthrough, slot0.context.totalSelect)

	if slot8 then
		ShowTips("LEVEL_MAX")

		return false
	end

	if slot1.topAmountValue < slot1.number then
		slot1.topAmountValue = slot1.topAmountValue + 1
		slot0.context.totalSelect = slot0.context.totalSelect + ItemCfg[slot1.id].param[1]

		manager.audio:PlayUIAudio(2)
		slot2:RefreshTopAmount(slot1.topAmountValue)

		return true
	else
		return false
	end
end

function slot0.OnServantClick(slot0, slot1, slot2)
	slot3 = slot0.context.weaponInfo
	slot7, slot8, slot9, slot10 = WeaponTools.AddWeaponExp(slot3.exp, slot3.breakthrough, slot0.context.totalSelect)

	if slot1.topAmountValue == 1 then
		slot1.topAmountValue = 0
		slot0.context.totalSelect = slot0.context.totalSelect - GameSetting.base_exp_weapon_servant.value[ItemCfg[slot1.id].rare]
	elseif slot1.topAmountValue == 0 then
		if slot10 then
			ShowTips("LEVEL_MAX")

			return false
		end

		slot1.topAmountValue = 1
		slot0.context.totalSelect = slot0.context.totalSelect + slot6
	end

	slot2:RefreshTopAmount(slot1.topAmountValue)
end

function slot0.OnMaterialCutClick(slot0, slot1, slot2)
	if slot1.type == ItemConst.ITEM_TYPE.MATERIAL then
		if slot1.topAmountValue >= 1 then
			slot1.topAmountValue = slot1.topAmountValue - 1
			slot0.context.totalSelect = slot0.context.totalSelect - ItemCfg[slot1.id].param[1]

			slot2:RefreshTopAmount(slot1.topAmountValue)
			manager.audio:PlayUIAudio(2)

			return true
		end
	elseif slot1.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		slot1.topAmountValue = math.max(slot1.topAmountValue - 1, 0)
		slot0.context.totalSelect = slot0.context.totalSelect - GameSetting.base_exp_weapon_servant.value[ItemCfg[slot1.id].rare]

		slot2:RefreshTopAmount(slot1.topAmountValue)
	end

	return false
end

function slot0.QuickSelectBtnClick(slot0)
	slot1 = slot0.context.weaponInfo
	slot7 = slot0.context.servantList
	slot8 = WeaponTools.CurMaxExp(slot1.breakthrough) - slot1.exp
	slot0.context.totalSelect = slot0:QuickSelectList(slot0.context.materialList, slot7, slot8)

	for slot7, slot8 in pairs(slot0.scrollHelper_:GetItemList()) do
		slot8:RefreshTopAmount(slot8.infoProxy.topAmountValue)
	end

	slot0:RenderView()
end

function slot0.OnUpgradeBtnClick(slot0)
	if slot0.context.totalSelect == 0 then
		ShowTips("PLEASE_SELECT_ITEM")

		return
	end

	slot1 = slot0.context.weaponInfo
	slot2, slot3, slot4 = WeaponTools.AddWeaponExp(slot1.exp, slot1.breakthrough, slot0.context.totalSelect)

	if not checkGold((slot0.context.totalSelect - slot4) * GameSetting.weapon_strengthen_gold_cost.value[1], true) then
		return
	end

	slot7 = false
	slot8 = slot0.context.heroId

	for slot13, slot14 in pairs(slot0.context.materialList) do
		if slot14.topAmountValue ~= 0 then
			table.insert({}, {
				id = slot14.id,
				num = slot14.topAmountValue
			})
		end
	end

	slot10 = {}

	for slot14, slot15 in pairs(slot0.context.servantList) do
		if slot15.topAmountValue ~= 0 then
			if ItemCfg[slot15.id].rare == 5 then
				slot7 = true
			end

			table.insert(slot10, slot15.uid)
		end
	end

	slot11 = nil

	if #MaterialTools.materialGiveBack(slot4, ItemConst.STR_ITEM.WEAPON) > 0 then
		slot0:Go("materialPreview", {
			content = (not slot7 or string.format(GetTips("WEAPON_STRENGTH_EXP_OVERFLOW_AND_RARE"))) and string.format(GetTips("WEAPON_STRENGTH_EXP_OVERFLOW")),
			OkCallback = function ()
				WeaponAction.WeaponStr(uv0, uv1, uv2, uv3.context.totalSelect)
			end,
			itemList = slot12
		})

		return
	end

	if slot7 then
		ShowMessageBox({
			title = "Warning",
			content = string.format(GetTips("WEAPON_STRENGTH_COST_RARE")),
			OkCallback = function ()
				OperationRecorder.Record("hero", "weaponOKUpgrade")
				WeaponAction.WeaponStr(uv0, uv1, uv2, uv3.context.totalSelect)
			end,
			CancelCallback = function ()
				OperationRecorder.Record("hero", "weaponCancelUpgrade")
			end
		})

		return
	end

	WeaponAction.WeaponStr(slot8, slot9, slot10, slot0.context.totalSelect)
end

function slot0.OnFilterBtnClick(slot0)
	JumpTools.OpenPageByJump("commonFilterView", {
		filterGroup = Filter_Root_Define.Weapon_LevelUp_Cost_List
	})
end

function slot0.OnFilterChange(slot0)
	slot0:ShowWeaponInfoLocal()
end

function slot0.CheckWeaponIsMaxLevel(slot0)
	if slot0.context.weaponInfo then
		return slot1.level == HeroConst.WEAPON_LV_MAX
	end

	return false
end

function slot0.RefreshMaterialList(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = CommonFilterData:HasIndexFlag(Filter_Root_Define.Weapon_LevelUp_Cost_List.filter_id, Filter_Group_Define.TYPE.groupID, Filter_Tags_Define.Train)
	slot4 = CommonFilterData:HasIndexFlag(Filter_Root_Define.Weapon_LevelUp_Cost_List.filter_id, Filter_Group_Define.TYPE.groupID, Filter_Tags_Define.StarLevel)
	slot9 = Filter_Tags_Define.DESCending
	slot5 = CommonFilterData:HasIndexFlag(Filter_Root_Define.Weapon_LevelUp_Cost_List.filter_id, Filter_Group_Define.SORT.groupID, slot9)

	for slot9, slot10 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.MATERIAL]) do
		slot11 = ItemTools.getItemNum(slot10)

		if ItemCfg[slot10].sub_type == MaterialConst.MATERIAL_TYPE.WEAPON_LEVEL_UP and slot11 > 0 then
			slot13 = clone(ItemTemplateData)
			slot13.type = ItemConst.ITEM_TYPE.MATERIAL
			slot13.id = slot10
			slot13.number = slot11
			slot13.index = 0
			slot13.selectStyle = false

			table.insert(slot1, slot13)
		end
	end

	table.sort(slot1, function (slot0, slot1)
		return ItemCfg[slot0.id].rare < ItemCfg[slot1.id].rare
	end)

	for slot10, slot11 in ipairs(ServantTools.GetServantLimited(true, true)) do
		slot12 = clone(ItemTemplateData)
		slot12.type = ItemConst.ITEM_TYPE.WEAPON_SERVANT
		slot12.uid = slot11.uid
		slot12.id = slot11.id
		slot12.number = slot11.stage
		slot12.addLevel = slot11.stage
		slot12.index = 0
		slot12.selectStyle = false

		table.insert(slot2, slot12)
	end

	table.sort(slot2, function (slot0, slot1)
		slot2 = WeaponServantCfg[slot0.id].starlevel
		slot3 = WeaponServantCfg[slot1.id].starlevel
		slot4 = slot0.number
		slot5 = slot1.number
		slot6 = WeaponServantCfg[slot0.id].race
		slot7 = WeaponServantCfg[slot1.id].race
		slot8 = slot0.id
		slot9 = slot1.id

		if not uv0 and slot2 ~= slot3 then
			if uv1 then
				return slot3 < slot2
			else
				return slot2 < slot3
			end
		end

		if slot4 ~= slot5 then
			if uv1 then
				return slot5 < slot4
			else
				return slot4 < slot5
			end
		end

		if uv0 and slot2 ~= slot3 then
			if uv1 then
				return slot3 < slot2
			else
				return slot2 < slot3
			end
		end

		if slot6 ~= slot7 then
			return slot6 < slot7
		end

		if slot8 ~= slot9 then
			if uv1 then
				return slot9 < slot8
			else
				return slot8 < slot9
			end
		end

		return slot0.uid < slot1.uid
	end)

	slot0.context.servantList = slot2
	slot0.context.materialList = slot1
	slot0.context.totalCount = #slot2 + #slot1
	slot0.context.materialCount = #slot1
	slot0.context.servantCount = #slot2
end

function slot0.QuickSelectList(slot0, slot1, slot2, slot3)
	slot4 = slot3

	for slot9 = 1, #slot1 do
		slot10 = slot1[slot9]
		slot11 = ItemCfg[slot10.id].param[1]

		if slot4 - ({
			[slot9] = math.max(math.min(math.ceil(slot4 / slot11), slot10.number), 0)
		})[slot9] * slot11 < 0 and slot9 > 1 then
			slot12 = -slot4

			for slot16 = slot9 - 1, 1, -1 do
				slot18 = ItemCfg[slot1[slot16].id].param[1]
				slot19 = math.modf(slot12 / slot18)
				slot5[slot16] = math.max(0, slot5[slot16] - slot19)
				slot12 = slot12 - slot18 * slot19
				slot4 = slot4 + slot18 * slot19
			end
		end

		if slot4 <= 0 then
			break
		end
	end

	for slot9 = 1, #slot1 do
		if slot5[slot9] == nil then
			slot5[slot9] = 0
		end

		slot1[slot9].selectNum_ = slot5[slot9]
		slot1[slot9].topAmountValue = slot5[slot9]
	end

	for slot9 = 1, #slot2 do
		if not (ItemCfg[slot2[slot9].id].rare >= 4 or slot10.number ~= 1) then
			slot13 = GameSetting.base_exp_weapon_servant.value[ItemCfg[slot10.id].rare]

			if slot4 <= 0 then
				slot10.topAmountValue = 0
			else
				slot10.topAmountValue = 1
				slot4 = slot4 - slot13
			end
		else
			slot10.topAmountValue = 0
		end
	end

	return slot3 - slot4
end

function slot0.UpdateWeaponInfo(slot0)
	if slot0.context.heroId and slot1 ~= 0 then
		slot0.context.weaponInfo = deepClone(slot0.context.dataPorxy:GetHeroWeaponInfo(slot1))
	end
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
