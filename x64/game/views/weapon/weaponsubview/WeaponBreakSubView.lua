slot0 = class("WeaponBreakSubView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:Init()

	slot0.pageIsInOpen = false
end

function slot0.Init(slot0)
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.RenderItem), slot0.consumeList_, CommonItemView)

	slot0:AddUIListener()

	slot0.conditionController = slot0.conditionController_:GetController("conditionItem")
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.buildContext(slot0, slot1)
	slot1 = slot1 or HeroConst.HERO_DATA_TYPE.DEFAULT
	slot0.context = {
		cost = 0,
		itemCount = 0,
		heroId = 0,
		isActive = false,
		weaponInfo = {},
		itemList = {},
		type = slot1,
		dataPorxy = HeroViewDataProxy.New(slot1)
	}
	slot0.constVar = {
		yellow = "363A42",
		red = "CD421E"
	}
end

function slot0.ShowWeaponInfoLocal(slot0)
	slot0:UpdateWeaponInfo()
	slot0:ShowWeaponInfo(slot0.context.heroId, slot0.context.weaponInfo)
end

function slot0.ShowWeaponInfo(slot0, slot1, slot2, slot3)
	slot0:buildContext(slot3)
	slot0:SetPageStatus(true)

	slot0.context.heroId = slot1
	slot0.context.weaponInfo = slot2

	slot0:RefreshMaterialList()
	slot0.scrollHelper_:StartScroll(slot0.context.itemCount)
	slot0:RenderView()
end

function slot0.RenderItem(slot0, slot1, slot2)
	slot3 = slot0.context.itemList[slot1]
	slot3.index = slot1
	slot5 = clone(ItemTemplateData)
	slot5.index = slot1
	slot5.bottomText = {
		ItemTools.getItemNum(slot3[1]),
		slot3[2]
	}
	slot5.id = slot3[1]
	slot5.number = nil

	function slot5.clickFun(slot0)
		ShowPopItem(POP_SOURCE_ITEM, {
			slot0.id,
			uv0
		})
	end

	slot2:SetData(slot5)
end

function slot0.RenderView(slot0)
	slot1 = slot0.context.heroId
	slot2 = slot0.context.weaponInfo
	slot3 = slot2.level
	slot4 = slot2.breakthrough
	slot5 = GameSetting.weapon_user_limit.value[slot4 + 1]
	slot6 = GameSetting.weapon_exp_limit.value[slot4 + 2]
	slot7 = HeroCfg[slot1].weapon_break_attribute[slot2.breakthrough + 1][2]
	slot8 = HeroCfg[slot1].weapon_break_attribute[slot2.breakthrough + 2][2]
	slot9 = string.format("%d", WeaponTools.WeaponAtk(slot3, slot4))
	slot10 = string.format("%d", WeaponTools.WeaponAtk(slot3, slot4 + 1))

	slot0:RenderCost()
	SetActive(slot0.markObj_, GameSetting.weapon_user_limit.value[slot4 + 1] <= PlayerData:GetPlayerInfo().userLevel)

	if slot12 <= slot11 then
		slot0.conditionTxt_.text = string.format(GetTips("UPGRADE_LIMIT_LEVEL"), slot12)

		slot0.conditionController:SetSelectedState("achieve")
	else
		slot0.conditionTxt_.text = string.format(GetTips("UPGRADE_LIMIT_LEVEL_RED"), slot12)

		slot0.conditionController:SetSelectedState("unsuccessful")
	end

	slot0.beforeLvTxt_.text = slot3
	slot0.afterLvTxt_.text = slot6
	slot0.beforeAtkTxt_.text = slot9
	slot0.afterAtkTxt_.text = slot10
	slot13, slot0.beforeSubTxt_.text = SkillTools.GetAttr(HeroCfg[slot1].weapon_break_attribute[slot2.breakthrough + 1])
	slot0.subDescTxt_.text, slot0.afterSubTxt_.text = SkillTools.GetAttr(HeroCfg[slot1].weapon_break_attribute[slot2.breakthrough + 2])
end

function slot0.RefreshMaterialList(slot0)
	slot0.context.cost, slot3 = WeaponTools.BreakMaterial(slot0.context.weaponInfo.breakthrough)
	slot0.context.itemList = slot3
	slot0.context.itemCount = #slot3
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.breakUpBtn_, nil, function ()
		uv0:OnBreakBtnClick()
	end)
end

function slot0.RenderCost(slot0)
	slot3, slot4 = WeaponTools.BreakMaterial(slot0.context.weaponInfo.breakthrough)
	slot0.tokenTxt_.text = setTextColor(slot0.constVar.yellow, slot0.constVar.red, slot3, ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD))
end

function slot0.OnGoldChange(slot0)
	slot0:RefreshMaterialList()
	slot0.scrollHelper_:StartScroll(slot0.context.itemCount)
	slot0:RenderView()
end

function slot0.OnBreakBtnClick(slot0)
	if WeaponAction.CheckBreak(slot0.context.heroId, true) then
		WeaponAction.WeaponBreak(slot0.context.heroId)
	end
end

function slot0.UpdateWeaponInfo(slot0)
	if slot0.context.heroId and slot1 ~= 0 then
		slot0.context.weaponInfo = deepClone(slot0.context.dataPorxy:GetHeroWeaponInfo(slot1))
	end
end

function slot0.SetPageStatus(slot0, slot1)
	slot0.pageIsInOpen = slot1
end

function slot0.GetPageOpenStatus(slot0)
	return slot0.pageIsInOpen
end

function slot0.OnExit(slot0)
	slot0:SetPageStatus(false)
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
