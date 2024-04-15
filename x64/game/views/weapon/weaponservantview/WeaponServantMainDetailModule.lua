slot0 = class("WeaponServantMainDetailModule", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.BuildContext(slot0)
	slot1 = slot0.gameObject_:GetComponent("ControllerExCollection")
	slot0.controller = {
		comps = slot1,
		state = {
			btnState = {
				beyond = "beyond",
				name = "btnState",
				callName = "callName",
				unReached = "unReached",
				no = "no",
				detail = "detail",
				comps = slot1:GetController("btnState")
			},
			equipBtnState = {
				False = "false",
				name = "equipBtnState",
				True = "true",
				comps = slot1:GetController("equipBtnState")
			},
			callNameBtnState = {
				False = "false",
				name = "callNameBtnState",
				True = "true",
				comps = slot1:GetController("callNameBtnState")
			},
			star = {
				Star1 = "star1",
				name = "star",
				Star4 = "star4",
				Star5 = "star5",
				Star3 = "star3",
				Star2 = "star2",
				comps = slot1:GetController("star")
			}
		}
	}
	slot0.data = {}
	slot0.constVar = {
		GACHA_POOL_SYSTEM_LINK_ID = 403,
		curBtnStyle = 1,
		descType = 1,
		rareBg = "",
		subDescColor = "#70767F",
		btnStyleMap = {
			slot0.controller.state.btnState.beyond,
			slot0.controller.state.btnState.callName,
			slot0.controller.state.btnState.detail
		},
		exchangeBtnLang = {
			Equip = GetTips("SERVANT_DETAIL_EQUIP"),
			Exchange = GetTips("TIP_CHANGE"),
			TakeOff = GetTips("SERVANT_DETAIL_UNLOAD"),
			Change = GetTips("TIP_CHANGE")
		},
		lockImg = {
			unlocked = "com_white_icon_26",
			locked = "com_white_icon_25"
		},
		proxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	}
end

function slot0.InitContext(slot0)
	slot0.data = {
		servantAddLv = 0,
		heroId = 0,
		info = {},
		servantMap = ServantTools.GetServantMap()
	}
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:BuildContext()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.detailBtn_, nil, function ()
		uv0:OnSwitchDescClick()
	end)
	slot0:AddBtnListener(slot0.detailsBtn_, nil, function ()
		uv0:OnServantDetailClick()
	end)
	slot0:AddBtnListener(slot0.gachaBtn_, nil, function ()
		uv0:OnGachaBtnClick()
	end)
	slot0:AddBtnListener(slot0.callNameBtn_, nil, function ()
		uv0:OnCallNameBtnClick()
	end)
	slot0:AddBtnListener(slot0.exchangeBtn_, nil, function ()
		uv0:OnExchangeBtnClick()
	end)
	slot0:AddBtnListener(slot0.beyondBtn_, nil, function ()
		uv0:OnBeyondBtnClick()
	end)
	slot0:AddBtnListener(slot0.lockBtn_, nil, function ()
		uv0:OnLockBtnClick()
	end)
	TerminologyTools.AddTerminologyHandler(slot0, slot0.descTxt_, nil, )
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
	slot0.constVar.descType = 1
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

function slot0.RegisteCallNameClickCallback(slot0, slot1)
	slot0.constVar.onCallNameClick = slot1
end

function slot0.OnRenderServant(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot0:InitContext(slot0.data)

	slot0.data.info = slot1
	slot3 = slot1.stage
	slot4 = 0
	slot0.data.heroId = slot2

	if slot2 then
		slot4 = HeroTools.GetHeroWeaponAddLevel(slot0:GetHeroInfo(slot2))
	end

	slot0.data.servantAddLv = slot4

	if slot4 > 0 then
		slot0.stageTxt_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL"), slot3, slot4)
	else
		slot0.stageTxt_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL_1"), slot3)
	end

	slot5 = slot1.id
	slot6 = WeaponServantCfg[slot5]
	slot7 = ItemCfg[slot5]
	slot0.nameTxt_.text = ItemTools.getItemName(slot7.id)

	slot0:AsyncLoadIcon(slot5, function (slot0, slot1)
		if uv0.gameObject_ and not isNil(uv0.gameObject_) and slot0 == uv0.data.info.id then
			uv0.servantImg_.sprite = getSpriteWithoutAtlas("TextureConfig/WeaponServant/Icon/" .. slot0)
		end
	end)

	slot8 = slot7.rare
	slot0.gradeImg_.sprite = getSprite("Atlas/Com_DynamicAtlas", "ui_pop_grade_0" .. 6 - slot8)

	slot0:SwitchControllerState(slot0.controller.state.star.name, string.format("star%d", slot8))

	slot9 = string.format("com_white_icon_group_%d_c", slot6.race)
	slot0.groupImg_.sprite = getSprite("Atlas/SystemGroupAtlas", slot9)
	slot0.groupTitleImg_.sprite = getSprite("Atlas/SystemGroupAtlas", slot9)
	slot0.groupTitleTxt_.text = string.format(GetTips("EQUIP_RACE"), RaceEffectCfg[slot6.race].name)

	if slot1.locked == 1 then
		slot0.lockImg_.sprite = getSprite("Atlas/SystemCommonAtlas", slot0.constVar.lockImg.locked)
	else
		slot0.lockImg_.sprite = getSprite("Atlas/SystemCommonAtlas", slot0.constVar.lockImg.unlocked)
	end

	slot0.attackRatioTxt_.text = table.concat({
		"+",
		slot6.attrib_addition,
		"%"
	})
	slot0.subAttrNameTxt_.text, slot11, slot0.subAttrIconImg_.sprite = SkillTools.GetAttr(slot6.attribute)
	slot0.subAttrTxt_.text = "+" .. slot11

	slot0:RenderEquipStatus()
	slot0:RefreshEffectText()
	slot0:RefreshRecommend()
	slot0:RenderBtnLogic()
	slot0:RenderLockObj()
end

function slot0.SwitchControllerState(slot0, slot1, slot2)
	if slot0.controller.state[slot1] then
		slot4.comps:SetSelectedState(slot2)
	end
end

function slot0.AsyncLoadIcon(slot0, slot1, slot2)
	getSpriteWithoutAtlasAsync("TextureConfig/WeaponServant/Icon/" .. slot1, function (slot0)
		uv0(uv1, slot0)
	end)
end

function slot0.GetHeroInfo(slot0, slot1)
	if slot0.constVar.proxy and slot1 and slot1 ~= 0 then
		return slot0.constVar.proxy:GetHeroData(slot1)
	else
		return nil
	end
end

function slot0.GetServantInfo(slot0, slot1)
	if slot0.constVar.proxy and slot1 and slot1 ~= 0 then
		return slot0.constVar.proxy:GetHeroServantInfo(slot1)
	else
		return nil
	end
end

function slot0.RefreshEffectText(slot0)
	slot2 = ""
	slot5 = WeaponServantCfg[slot0.data.info.id].desc

	if slot0.constVar.descType == 1 then
		slot2 = slot0.constVar.proxy:GetServantEffect(slot3.id, nil, true)
		slot0.detailTxt_.text = GetTips("SERVANT_DETAIL_FULL")
	else
		slot2 = slot0.constVar.proxy:GetServantEffect(slot3.id, slot3.stage + slot0.data.servantAddLv)
		slot0.detailTxt_.text = GetTips("SERVANT_DETAIL_SIMPLE")
	end

	slot0.descTxt_.text = table.concat({
		slot2,
		"\n<color=",
		slot0.constVar.subDescColor,
		">",
		slot5,
		"</color>"
	})
end

function slot0.RefreshRecommend(slot0)
	slot3 = 0

	if WeaponServantCfg[slot0.data.info.id].effect[1] > 0 then
		slot3 = WeaponEffectCfg[slot2].spec_char[1]
	end

	if slot3 ~= nil and slot3 > 0 then
		SetActive(slot0.recommendObj_, true)

		slot0.heroImg_.sprite = HeroTools.GetSmallHeadSprite(slot3)
	else
		SetActive(slot0.recommendObj_, false)
	end
end

function slot0.RenderEquipStatus(slot0)
	if slot0.data.info.uid then
		if slot0.data.servantMap[slot1.uid] then
			SetActive(slot0.equipObj_, true)

			slot0.equipHeroIcon_.sprite = HeroTools.GetSmallHeadSprite(slot2)
			slot0.equipHeroTxt_.text = string.format(GetTips("SERVANT_EQUIPED"), GetI18NText(HeroCfg[slot2].name))
		else
			SetActive(slot0.equipObj_, false)
		end
	else
		SetActive(slot0.equipObj_, false)
	end
end

function slot0.RenderLockObj(slot0)
	if slot0.data.info.uid and slot1.uid ~= 0 then
		SetActive(slot0.lockImg_.gameObject, true)
	else
		SetActive(slot0.lockImg_.gameObject, false)
	end
end

function slot0.OnSwitchDescClick(slot0)
	slot0.constVar.descType = (slot0.constVar.descType + 1) % 2

	slot0:RefreshEffectText()
end

function slot0.OnServantDetailClick(slot0)
	if slot0.data.info then
		if slot0.constVar.curBtnStyle == 3 then
			JumpTools.OpenPageByJump("/showServantDetailsView", {
				servantData = slot0.data.info,
				heroId = slot0.data.heroId,
				openContext = {
					disableTabList = {
						[2.0] = true
					}
				}
			})
		elseif slot0:CheckCanCallName() then
			slot0:OnCallNameBtnClick()
		end
	end
end

function slot0.OnGachaBtnClick(slot0)
	if ServantTools.IsSleepServant(slot0.data.info.id) then
		slot0:OnServantDetailClick()

		return
	end

	DrawAction.SetPollUpIDIgnoreFail(DrawConst.WEAPON_SERVANT_POOL_ID, ServantTools.GetSleepyServantByServant(slot1.id))
end

function slot0.OnCallNameBtnClick(slot0)
	if ServantTools.IsSleepServant(slot0.data.info.id) then
		slot0:JumpToCallName()

		return
	end

	slot3 = WeaponServantCfg[slot2]
	slot4, slot5 = slot0:MaterialEnough(slot2)

	if not slot4 then
		ShowTips("SERVANT_MERGE_MATERIAL_NOT_ENOUGH")

		return
	end

	if not slot5 then
		ShowTips("ERROR_ITEM_NOT_ENOUGH_GOLD")

		return
	end

	slot6 = {}

	for slot10, slot11 in ipairs(GameSetting.exclusive_weapon_servant_cost.value) do
		if slot11[1] == slot3.race then
			slot6 = slot11[2]
		end
	end

	slot7 = WeaponServantData:GetWeaponServantById(slot6[1][1])
	slot8 = 0

	if slot0.data.heroId and slot0.data.heroId ~= 0 and slot0:GetHeroInfo(slot0.data.heroId) then
		slot8 = slot9.servant_uid or 0
	end

	table.sort(slot7, function (slot0, slot1)
		if slot0.locked ~= slot1.locked then
			return slot0.locked < slot1.locked
		end

		return slot0.uid < slot1.uid
	end)

	slot10 = 1

	if slot8 ~= 0 then
		for slot14, slot15 in ipairs(slot7) do
			if slot15.uid == slot8 then
				slot10 = slot14

				break
			end
		end
	end

	slot13 = slot7[slot10].uid

	if slot7[slot10].locked == 1 then
		slot15 = nil

		if slot11 then
			slot15 = string.format(GetTips("SERVANT_MATERIAL_LOCKED"), ItemTools.getItemName(slot7[slot10].id))
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = slot15,
			OkCallback = function ()
				uv0:Go("/weaponServantWakeUp", {
					race = uv0:GetCurServantRace(),
					servantID = uv1,
					uid = uv2,
					HeroId = uv0.data.heroId
				})
			end,
			CancelCallback = function ()
			end
		})
	else
		slot0:Go("/weaponServantWakeUp", {
			race = slot0:GetCurServantRace(),
			servantID = slot2,
			uid = slot13,
			HeroId = slot0.data.heroId
		})
	end
end

function slot0.JumpToCallName(slot0)
	ServantTools.JumpToCallName(slot0.data.heroId, slot0.data.info.id)
end

function slot0.OnExchangeBtnClick(slot0)
	if not slot0:CheckRaceSame() then
		ShowTips("ERROR_SERVANT_RACE_NO_MATCH")

		return
	end

	slot3 = slot0.data.info.uid
	slot6 = slot0.data.servantMap

	if slot0:GetHeroInfo(slot0.data.heroId) and slot3 == slot5.servant_uid then
		ServantAction.ServantReplace(slot4, 0)

		return
	end

	if slot6[slot3] then
		ShowMessageBox({
			title = "Warning",
			content = string.format(GetTips("SERVANT_IS_USING"), GetI18NText(HeroCfg[slot6[slot3]].name)),
			OkCallback = function ()
				ServantAction.ServantReplace(uv0, uv1)
			end
		})

		return
	end

	ServantAction.ServantReplace(slot4, slot3)
end

function slot0.OnBeyondBtnClick(slot0)
	if slot0.data.info then
		if ServantTools.IsSleepServant(slot0.data.info.id) then
			ServantTools.JumpToCallName(slot0.data.heroId, slot0.data.info.id)
		else
			JumpTools.OpenPageByJump("/showServantDetailsView", {
				servantData = slot0.data.info,
				heroId = slot0.data.heroId,
				openContext = {
					tabIndex = 2
				}
			})
		end
	end
end

function slot0.OnLockBtnClick(slot0)
	if slot0.data.info.uid and slot0.data.info.uid ~= 0 then
		ServantAction.ServantLock(slot0.data.info.uid)
	end
end

function slot0.SwitchBtnStyle(slot0, slot1)
	slot0.constVar.curBtnStyle = slot1

	slot0:SwitchControllerState(slot0.controller.state.btnState.name, slot0.constVar.btnStyleMap[slot1])
	slot0:RenderBtnLogic()
end

function slot0.RenderBtnLogic(slot0)
	if slot0.constVar.curBtnStyle == 1 then
		slot0:RenderBeyondBtnState()
	end

	if slot0.constVar.curBtnStyle == 2 then
		SetActive(slot0.callNameToken_, true)

		slot0.gachaBtnIcon_.sprite = getSprite("Atlas/Hero_servantAtlas", "icon_detection")
		slot0.gachaBtnTxt_.text = GetTips("SERVANT_MAIN_PAGE_GACHA")

		slot0:RenderCallNameBtn()
	else
		slot0:SwitchControllerState(slot0.controller.state.callNameBtnState.name, slot0.controller.state.callNameBtnState.True)
	end

	if slot0.constVar.curBtnStyle == 3 then
		if slot0.data.info and ServantTools.IsSleepServant(slot1.id) then
			slot0:SwitchControllerState(slot0.controller.state.btnState.name, slot0.constVar.btnStyleMap[2])
			SetActive(slot0.callNameToken_, false)

			slot0.gachaBtnIcon_.sprite = getSprite("Atlas/SystemCommonAtlas", "com_white_icon_08")
			slot0.gachaBtnTxt_.text = GetTips("TIP_DETAIL")
		else
			slot0:SwitchControllerState(slot0.controller.state.btnState.name, slot0.constVar.btnStyleMap[3])
		end

		slot0.upBtnTxt_.text = GetTips("SERVANT_MAIN_PAGE_DETAIL")
	end

	if slot0.constVar.curBtnStyle == 4 then
		slot0:SwitchControllerState(slot0.controller.state.btnState.name, slot0.controller.state.btnState.no)
	end
end

function slot0.RenderCallNameBtn(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(GameSetting.exclusive_weapon_servant_cost.value) do
		if slot7[1] == slot0:GetCurServantRace() then
			slot1 = slot7[2]
		end
	end

	slot4 = 0

	if WeaponServantData:GetWeaponServantById(slot1[1][1]) then
		slot4 = #slot3
	end

	slot5 = ItemTools.getItemNum(slot1[2][1])

	if slot4 < slot1[1][2] then
		slot6 = "<color='#FF0000'>" .. tostring(slot4) .. "</color>"
	end

	slot6 = slot6 .. "/" .. tostring(slot1[1][2])
	slot7 = tostring(slot1[2][2])

	if slot5 < slot1[2][2] then
		slot7 = "<color='#FF0000'>" .. tostring(slot1[2][2]) .. "</color>"
	end

	slot0.costmoneyText_.text = slot7

	if slot1[1][2] <= slot4 and slot1[2][2] <= slot5 then
		slot0:SwitchControllerState(slot0.controller.state.callNameBtnState.name, slot0.controller.state.callNameBtnState.True)
	else
		slot0:SwitchControllerState(slot0.controller.state.callNameBtnState.name, slot0.controller.state.callNameBtnState.False)
	end
end

function slot0.RenderBeyondBtnState(slot0)
	slot3 = slot0.controller.state.btnState

	if slot0.data.info.isRecommend then
		if slot0:CheckCanCallName() then
			slot0:SwitchControllerState(slot3.name, slot3.detail)

			slot0.upBtnTxt_.text = GetTips("SERVANT_MAIN_PAGE_CALLNAME")
		else
			slot0:SwitchControllerState(slot3.name, slot3.unReached)
		end
	else
		slot0:SwitchControllerState(slot3.name, slot3.beyond)

		if slot0.data.heroId then
			if not slot0.data.servantMap[slot1.uid] then
				if slot0:GetServantInfo(slot0.data.heroId) and slot6.id ~= 0 then
					slot0.exchangeEquipTxt_.text = slot0.constVar.exchangeBtnLang.Change
				else
					slot0.exchangeEquipTxt_.text = slot0.constVar.exchangeBtnLang.Equip
				end
			elseif slot0.data.heroId == slot5 then
				slot0.exchangeEquipTxt_.text = slot0.constVar.exchangeBtnLang.TakeOff
			else
				slot0.exchangeEquipTxt_.text = slot0.constVar.exchangeBtnLang.Exchange
			end
		end

		slot7 = slot0.controller.state.equipBtnState.False

		if slot0:CheckRaceSame() then
			slot7 = slot0.controller.state.equipBtnState.True
		end

		slot0:SwitchControllerState(slot0.controller.state.equipBtnState.name, slot7)

		if ServantTools.IsSleepServant(slot1.id) then
			slot0.beyondBtnTxt_.text = GetTips("SERVANT_MAIN_PAGE_CALLNAME")
		else
			slot0.beyondBtnTxt_.text = GetTips("PROMOTE")
		end
	end
end

function slot0.MaterialEnough(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(GameSetting.exclusive_weapon_servant_cost.value) do
		if slot8[1] == WeaponServantCfg[slot1].race then
			slot3 = slot8[2]
		end
	end

	slot5 = 0

	if WeaponServantData:GetWeaponServantById(slot3[1][1]) then
		slot5 = #slot4
	end

	return slot3[1][2] <= slot5, slot3[2][2] <= ItemTools.getItemNum(slot3[2][1])
end

function slot0.CheckRaceSame(slot0)
	if not slot0.data.heroId then
		return false
	end

	return slot0:GetCurServantRace() == HeroCfg[slot0.data.heroId].race
end

function slot0.GetCurServantRace(slot0)
	return WeaponServantCfg[slot0.data.info.id].race
end

function slot0.CheckCanCallName(slot0)
	slot2, slot3 = slot0:MaterialEnough(slot0.data.info.id)

	return slot2
end

return slot0
