slot0 = class("WeaponServantBeyondModule", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.BuildContext(slot0)
	slot0.eventHandler = {
		promoteHandler = handler(slot0, slot0.OnBeyondSuccess)
	}
	slot0.controller = {
		comps = slot0.gameObject_:GetComponent("ControllerExCollection"),
		state = {
			maxLevel = {
				False = "false",
				name = "maxLevel",
				True = "true"
			}
		}
	}
	slot0.data = {
		servantAddLv = 0,
		heroId = 0,
		curCostType = 1,
		descType = 1,
		info = {},
		servantS_ = {}
	}
	slot0.constVar = {
		red = "CD421E",
		yellow = "363A42",
		subDescColor = "#70767F",
		costItem = {
			costType = 1,
			entity = ServantBeyondViewConsumeModule.New(slot0.consumeRes1_)
		},
		costMaterial = {
			costType = 2,
			entity = ServantBeyondViewConsumeModule.New(slot0.consumeRes2_)
		},
		proxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	}

	slot0.constVar.costItem.entity:RegisteBtnListener(function ()
		uv0:OnCostItemClick()
	end)
	slot0.constVar.costMaterial.entity:RegisteBtnListener(function ()
		uv0:OnCostMaterialClick()
	end)
	slot0:RegistEventListener(SERVANT_PROMOTE, slot0.eventHandler.promoteHandler)
end

function slot0.InitContext(slot0)
	slot0.data = {
		servantAddLv = 0,
		heroId = 0,
		descType = 1,
		info = {},
		servantS_ = {}
	}
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:BuildContext()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.beyondBtn_, nil, function ()
		uv0:OnBeyondClick()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RegistEventListener(SERVANT_PROMOTE, slot0.eventHandler.promoteHandler)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0.constVar.costItem.entity:Dispose()

	slot0.constVar.costItem.entity = nil

	slot0.constVar.costMaterial.entity:Dispose()

	slot0.constVar.costMaterial.entity = nil

	slot0:RemoveAllEventListener()
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

function slot0.CheckIsArriveMax(slot0, slot1)
	return slot1.stage >= GameSetting.weapon_promote_max.value[WeaponServantCfg[slot1.id].starlevel] + 1
end

function slot0.OnRenderModule(slot0, slot1)
	slot0.isCanBarCurrency = true

	slot0:InitContext()

	slot2 = slot1.servantData
	slot4 = WeaponServantCfg[slot2.id].starlevel
	slot5 = slot2.stage
	slot0.data.info = slot2
	slot0.data.heroId = slot1.heroId
	slot0.data.servantS_ = ServantTools.GetServantByIDLimited(slot2.id, true, true, slot2.uid)

	if slot0:CheckIsArriveMax(slot2) then
		slot0:SwitchControllerState(slot0.controller.state.maxLevel.name, slot0.controller.state.maxLevel.True)

		slot0.curLevelTxt_.text = GameSetting.weapon_promote_max.value[slot4] + 1
		slot0.strdescText_.text = slot0.constVar.proxy:GetServantEffect(slot2.id, slot5)
		slot0.isCanBarCurrency = false

		return
	end

	slot0:SwitchControllerState(slot0.controller.state.maxLevel.name, slot0.controller.state.maxLevel.False)

	slot0.strdescText_.text = slot0.constVar.proxy:GetServantEffect(slot2.id, slot5 + 1)
	slot0.curLevelTxt_.text = slot5
	slot0.nextLevelTxt_.text = slot5 + 1
	slot0.costGoldTxt_.text = setTextColor(slot0.constVar.yellow, slot0.constVar.red, ServantTools.ServantBreakCost(slot4, slot5) or 0, ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) or 0)

	slot0:RenderStrengthItem()
	slot0:OnCostItemClick()
end

function slot0.RenderStrengthItem(slot0)
	slot1 = slot0.data.info

	slot0.constVar.costItem.entity:RefreshData({
		id = slot1.id,
		bottomText = table.concat({
			setTextColor(slot0.constVar.red, "FFFFFF", #slot0.data.servantS_, 1, function (slot0, slot1)
				return slot0 < slot1
			end),
			"/",
			1
		})
	})

	if WeaponServantCfg[slot1.id].starlevel > 3 then
		SetActive(slot0.consumeRes2_, true)

		slot5 = ServantTools.ServantBreakMaterialCost(slot1.id, slot4)
		slot6 = slot5[1]
		slot8 = slot5[2]

		slot0.constVar.costMaterial.entity:RefreshData({
			id = slot6,
			bottomText = table.concat({
				setTextColor(slot0.constVar.red, "FFFFFF", ItemTools.getItemNum(slot6), slot8, function (slot0, slot1)
					return slot0 < slot1
				end),
				"/",
				slot8
			})
		})
	else
		SetActive(slot0.consumeRes2_, false)
		slot0.constVar.costMaterial.entity:RefreshData(nil)
	end
end

function slot0.SwitchControllerState(slot0, slot1, slot2)
	if slot0.controller.comps:GetController(slot1) then
		slot4:SetSelectedState(slot2)
	end
end

function slot0.GetHeroInfo(slot0, slot1)
	return slot0.constVar.proxy:GetHeroData(slot1)
end

function slot0.OnBeyondSuccess(slot0, slot1, slot2)
	if WeaponServantData:GetServantDataByUID(slot0.data.info.uid) then
		slot3.locked = slot4.locked
		slot3.stage = slot4.stage
	end

	slot0:OnRenderModule({
		servantData = slot3,
		heroId = slot0.data.heroId
	})
	slot0:Go("servantBreak", {
		stage = slot3.stage - 1
	})
end

function slot0.OnCostItemClick(slot0)
	slot0.constVar.costMaterial.entity:SetSelect(false)
	slot0.constVar.costItem.entity:SetSelect(true)

	slot0.data.curCostType = slot0.constVar.costItem.costType
end

function slot0.OnCostMaterialClick(slot0)
	slot0.constVar.costMaterial.entity:SetSelect(true)
	slot0.constVar.costItem.entity:SetSelect(false)

	slot0.data.curCostType = slot0.constVar.costMaterial.costType
end

function slot0.OnBeyondClick(slot0)
	slot0:CheckCost()
end

function slot0.CheckCost(slot0)
	slot3 = nil
	slot4 = slot0.data.info

	slot0:sortList(ServantTools.GetServantByIDLimited(slot4.id, true, true, slot4.uid))

	if slot0.data.curCostType == slot0.constVar.costItem.costType then
		if not slot5[1] then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")

			return
		end

		if WeaponServantData:GetServantDataByUID(slot3).stage > 1 then
			ShowMessageBox({
				content = string.format(GetTips("SERVANT_CONSUME_CONFIRM"), slot6.stage),
				OkCallback = function ()
					uv0:OnBeyondAction(uv1)
				end
			})

			return
		end

		if not _G.SkipTip.SkipServantPromoteRefineTip and SettingData:GetRemindSettingData().servant_promote_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("SERVANT_TRANSCEND_BY_SERVANT"), ItemTools.getItemName(slot4.id)),
				OkCallback = function ()
					_G.SkipTip.SkipServantPromoteRefineTip = uv0.SkipServantPromoteRefineTip_

					uv0:OnBeyondAction(uv1)
				end,
				ToggleCallback = function (slot0)
					uv0.SkipServantPromoteRefineTip_ = slot0
				end
			})

			return
		end
	else
		if not ServantTools.ServantBreakMaterialCost(slot4.id, WeaponServantCfg[slot4.id].starlevel) then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")

			return
		end

		if ItemTools.getItemNum(slot7[1]) < slot7[2] then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")

			return
		end

		if not _G.SkipTip.SkipSpiritRefineTip and SettingData:GetRemindSettingData().spirit_refine_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("SERVANT_TRANSCEND"), ServantTools.ServantBreakMaterialCost(slot4.id, slot6)[2]),
				OkCallback = function ()
					_G.SkipTip.SkipSpiritRefineTip = uv0.SkipSpiritRefineTip_

					uv0:OnBeyondAction(uv1)
				end,
				ToggleCallback = function (slot0)
					uv0.SkipSpiritRefineTip_ = slot0
				end
			})

			return
		end
	end

	slot0:OnBeyondAction(slot3)
end

function slot0.OnBeyondAction(slot0, slot1)
	slot2 = slot0.data.info
	slot5 = ServantTools.ServantBreakCost(WeaponServantCfg[slot2.id].starlevel, slot2.stage)
	slot6 = 1

	if slot1 then
		slot6 = 0
	end

	if checkGold(slot5) then
		ServantAction.ServantPromote(slot6, slot2.uid, slot1, slot5)
	end
end

function slot0.sortList(slot0, slot1)
	table.sort(slot1, function (slot0, slot1)
		if WeaponServantData:GetServantDataByUID(slot0).stage ~= WeaponServantData:GetServantDataByUID(slot1).stage then
			return slot2.stage < slot3.stage
		end

		return slot2.uid < slot3.uid
	end)
end

return slot0
