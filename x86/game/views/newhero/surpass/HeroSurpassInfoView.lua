slot0 = class("HeroSurpassInfoView", ReduxView)
slot1 = {
	infoEx = {
		upState = {
			finish = "finish",
			name = "btnState",
			lock = "lock",
			up = "up"
		}
	}
}

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.upBtnController = slot0.rootControllerexcollection_:GetController(uv0.infoEx.upState.name)
	slot0.costItem = CommonItemView.New(slot0.costitem_)
	slot0.attrItemGrowList = {}

	for slot4 = 1, 3 do
		slot0.attrItemGrowList[slot4] = HeroSurpassAttrItem.New(slot0["attr" .. slot4 .. "Go_"])
	end

	slot0.attrItemBaseList = {}

	for slot4 = 1, 5 do
		slot0.attrItemBaseList[slot4] = HeroSurpassAttrItem.New(slot0["attrbase" .. slot4 .. "Go_"])
	end
end

function slot0.OnTop(slot0)
	slot0:ChangeBar()
end

function slot0.CheckIsShowGold(slot0)
	if not slot0.heroInfo then
		return false
	end

	if SurpassTools.GetNextSurpassStarID(slot0.heroInfo.star) and slot0.selectStarID < slot2 then
		return true
	end

	return false
end

function slot0.ChangeBar(slot0)
	if slot0:CheckIsShowGold() then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_GOLD
		})
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.upbtnBtn_, nil, function ()
		uv0:OnUpBtn()
	end)
	slot0:AddBtnListener(slot0.btnnodeBtn_, nil, function ()
		uv0:OnGoToAstrolabe()
	end)
end

function slot0.OnGoldChange(slot0)
	if slot0.selectStarID then
		slot0:UpdateCost(slot0.selectStarID)
	end
end

function slot0.OnGoToAstrolabe(slot0)
	JumpTools.OpenPageByJump("/newHero", {
		isEnter = true,
		pageIndex = 6,
		hid = slot0.heroInfo.id,
		type = HeroConst.HERO_DATA_TYPE.DEFAULT
	})
end

function slot0.OnUpBtn(slot0)
	if slot0.heroInfo.piece < HeroStarCfg[slot0.heroInfo.star].star_up then
		ShowTips("ERROR_ITEM_NOT_ENOUGH_HERO_PIECE")

		return
	end

	if not checkGold(slot1.gold_cost, true) then
		return
	end

	HeroAction.HeroStarUp(slot0.heroInfo.id)
end

function slot0.SetDataProxy(slot0, slot1)
	slot0.dataProxy = slot1
end

function slot0.SetHeroId(slot0, slot1)
	slot0.heroID = slot1
	slot0.heroCfg = HeroCfg[slot0.heroID]
	slot0.titlenameText_.text = slot0.heroCfg.name
	slot0.nameText_.text = slot0.heroCfg.suffix
end

function slot0.RefreshUi(slot0, slot1)
	slot0.heroInfo = slot0.dataProxy:GetHeroData(slot0.heroID)

	SurpassTools.ChangeIconStarSpirte(slot0.iconImg_, HeroStarCfg[slot1 or slot0.selectStarID].star)

	if SurpassTools.GetNextSurpassStarID(slot0.heroInfo.star) and slot3 == slot1 then
		slot0.upBtnController:SetSelectedState(uv0.infoEx.upState.up)
	elseif slot3 and slot1 < slot3 then
		slot0.upBtnController:SetSelectedState(uv0.infoEx.upState.finish)
	else
		slot0.upBtnController:SetSelectedState(uv0.infoEx.upState.lock)
	end

	slot0:RefreshDescInfo(slot1)
	slot0:UpdateCost(slot1)

	slot5 = SurpassTools.GetSmallStageShow(slot1)
	slot0.lvtextText_.text = slot5

	SetActive(slot0.lvnodeGo_, slot5 ~= "" and true or false)

	if slot1 ~= slot0.selectStarID then
		slot0.rootAni_:Play("Fx_Common_right_cx", 0, 0)
	end

	slot0.selectStarID = slot1

	slot0:ChangeBar()
end

function slot0.UpdateCost(slot0, slot1)
	if HeroStarCfg[HeroStarCfg.all[table.indexof(HeroStarCfg.all, slot1) - 1]] then
		slot4 = ItemCfg[slot0.heroID].fragment
		slot6 = slot3.star_up
		slot7 = clone(ItemTemplateData)
		slot7.id = slot4
		slot7.number = slot6

		function slot7.clickFun(slot0)
			ShowPopItem(POP_SOURCE_ITEM, {
				slot0.id,
				slot0.number
			})
		end

		slot0.costItem:SetData(slot7)
		slot0.costItem:RefreshBottomText({
			ItemTools.getItemNum(slot4),
			slot6
		})
		slot0.costItem:RefreshBottomRightText(true)

		if not checkGold(slot3.gold_cost, false) then
			slot0.goldCostText_.text = string.format("<color=#FF000B>%d</color>", slot3.gold_cost)
		else
			slot0.goldCostText_.text = string.format("%d", slot3.gold_cost)
		end
	end
end

function slot0.RefreshDescInfo(slot0, slot1)
	slot3 = HeroStarCfg[slot1].star

	for slot7, slot8 in pairs(slot0.attrItemGrowList) do
		slot8:SetActive(false)
	end

	for slot7, slot8 in pairs(slot0.attrItemBaseList) do
		slot8:SetActive(false)
	end

	slot4, slot5, slot6, slot7 = SurpassTools.GetStarUpAttrShowDesc(slot0.heroCfg, slot1, true)

	if slot2.phase == 0 then
		slot8 = math.max(slot3 - 1, 0)

		slot0.attrItemGrowList[1]:RefreshUI(slot0.heroCfg.atk_ratio[slot8], slot0.heroCfg.atk_ratio[slot3], 1, true)
		slot0.attrItemGrowList[2]:RefreshUI(slot0.heroCfg.arm_ratio[slot8], slot0.heroCfg.arm_ratio[slot3], 2, true)
		slot0.attrItemGrowList[3]:RefreshUI(slot0.heroCfg.sta_ratio[slot8], slot0.heroCfg.sta_ratio[slot3], 3, true)
	end

	for slot11, slot12 in pairs(slot7) do
		if slot0.attrItemBaseList[slot11] then
			slot0.attrItemBaseList[slot11]:RefreshUI(nil, slot12.value, slot12.attrId)
		end
	end

	SetActive(slot0.attributeGo_, slot2.phase == 0)
	SetActive(slot0.attrbasenodeGo_, slot7 and #slot7 > 0)
	SetActive(slot0.btnnodeGo_, false)

	slot9 = false

	if HeroTools.IsSpHero(slot0.heroInfo.id) then
		SetActive(slot0.btnnodeGo_, AstrolabeTools.GetSpAstrolabeNodeBySurpass(slot0.heroInfo.id, slot1) ~= 0)

		if HeroAstrolabeCfg[slot10] then
			slot9 = true
			slot0.txt_dyn_name02Text_.text = string.format(GetTips("SP_SURPASS_DES"), HeroAstrolabeCfg[slot10].name)
		end
	end

	for slot14, slot15 in pairs(slot4) do
		slot10 = string.format("%s%s\n", "", slot15)
	end

	slot0.describetextText_.text = string.format("%s%s\n", slot10, slot5)

	SetActive(slot0.specialGo_, #slot4 > 0 or slot5 ~= "" or slot9)
end

function slot0.Dispose(slot0)
	if slot0.costItem then
		slot0.costItem:Dispose()

		slot0.costItem = nil
	end

	for slot4, slot5 in pairs(slot0.attrItemGrowList) do
		if slot5 then
			slot5:Dispose()
		end
	end

	for slot4, slot5 in pairs(slot0.attrItemBaseList) do
		if slot5 then
			slot5:Dispose()
		end
	end

	uv0.super.Dispose(slot0)
end

return slot0
