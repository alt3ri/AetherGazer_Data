slot0 = class("HeroWeaponPage", HeroPageBase)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.weaponInfo_ = {}
	slot0.heroInfo_ = {}
	slot0.servantInfo_ = {}

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.lockController_ = slot0.controller_:GetController("lock")
	slot0.isSelfController_ = slot0.controller_:GetController("isSelf")
end

function slot0.SetHeroInfo(slot0, slot1)
	slot0.type_ = slot0.heroViewProxy_:GetViewDataType()
	slot0.heroInfo_ = slot1

	if slot0.heroViewProxy_.showRedPoint then
		manager.redPoint:bindUIandKey(slot0.weaponstrengthTrs_, RedPointConst.HERO_WEAPON_BREAK_ID .. slot0.heroInfo_.id)
	end
end

function slot0.UpdateView(slot0)
	slot0.servantInfo_ = slot0.heroViewProxy_:GetHeroServantInfo(slot0.heroInfo_.id)

	slot0:RefreshServant(slot0.servantInfo_)
	slot0:RefreshWeapon()
	slot0:RefreshStrengthText()
end

function slot0.RefreshStrengthText(slot0)
	slot1 = ""
	slot0.weaponstrengthText_.text = (HeroData:GetHeroList()[slot0.heroInfo_.id].weapon_info.level ~= HeroConst.WEAPON_LV_MAX or GetTips("TIP_DETAIL")) and (GameSetting.weapon_exp_limit.value[slot0.weaponInfo_.breakthrough + 1] ~= slot0.weaponInfo_.level or slot0.weaponInfo_.level == HeroConst.WEAPON_LV_MAX or GetTips("TIP_BREAK")) and GetTips("TIP_STRENGTH")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.weaponstrengthBtn_, nil, function ()
		if HeroData:GetHeroList()[uv0.heroInfo_.id].weapon_info.level == HeroConst.WEAPON_LV_MAX then
			uv0:Go("/weapon", {
				state = "detail",
				HeroID = uv0.heroInfo_.id
			})

			return
		end

		uv0:Go("/weapon", {
			state = "strength",
			HeroID = uv0.heroInfo_.id
		})
	end)
	slot0:AddBtnListener(slot0.servantcontentBtn_, nil, function ()
		if not uv0.heroViewProxy_.isSelf then
			return
		end

		slot2 = {}

		for slot6, slot7 in pairs(WeaponServantData:GetWeaponServantList()) do
			if WeaponServantCfg[slot7.id].race == HeroCfg[uv0.heroInfo_.id].race then
				table.insert(slot2, slot7)
			end
		end

		slot3 = #slot2

		if HeroTools.GetHeroServantInfo(uv0.heroInfo_.id) then
			if uv0:CheckCanEnterServant() then
				uv0:Go("/weaponServant", {
					state = "onlydetail",
					HeroID = uv0.heroInfo_.id,
					id = slot4.id
				})
			end
		elseif uv0:CheckCanEnterServant() then
			uv0:Go("/weaponServant", {
				state = "onlydetail",
				HeroID = uv0.heroInfo_.id
			})
		end
	end)
end

function slot0.CheckCanEnterServant(slot0)
	slot3 = {}

	for slot7, slot8 in pairs(WeaponServantData:GetWeaponServantList()) do
		if WeaponServantCfg[slot8.id].race == HeroCfg[slot0.heroInfo_.id].race then
			table.insert(slot3, slot8)
		end
	end

	if #slot3 == 0 then
		ShowTips("NO_SERVANT_CAN_BE_EQUIPED")

		return false
	end

	return true
end

function slot0.OnServantLock(slot0, slot1, slot2)
	slot0.servantInfo_ = HeroTools.GetHeroServantInfo(slot0.heroInfo_.id)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.servantRareController_ = ControllerUtil.GetController(slot0.servantGo_.transform, "servantrare")
	slot0.servantController = ControllerUtil.GetController(slot0.servantGo_.transform, "hasservant")
	slot0.btnStatus_ = "MERGE"
end

function slot0.RefreshWeapon(slot0)
	slot0.weaponInfo_ = deepClone(slot0.heroViewProxy_:GetHeroWeaponInfo(slot0.heroInfo_.id))
	slot2, slot0.nowlvText_.text = WeaponTools.AddWeaponExp(slot0.weaponInfo_.exp, slot0.weaponInfo_.breakthrough, 0)

	SetActive(slot0.servantGo_, not slot0.heroViewProxy_.hideServant)

	slot0.nameText_.text = HeroCfg[slot0.heroInfo_.id].weapon_name
	slot0.toplvText_.text = "/" .. GameSetting.weapon_exp_limit.value[slot0.weaponInfo_.breakthrough + 1] or HeroConst.WEAPON_LV_MAX

	if slot3 == HeroConst.WEAPON_LV_MAX then
		slot0:RefreshExpBar(1)

		slot0.expText_.text = "-/-"
	else
		slot4 = GameLevelSetting[slot3].weapon_level_exp

		slot0:RefreshExpBar(slot2 / slot4)

		slot0.expText_.text = slot2 .. "/" .. slot4
	end

	slot5 = nil

	if slot0.servantInfo_.id == 0 or slot0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
		slot0.atkText_.text = string.format("%d", WeaponTools.WeaponAtk(slot0.weaponInfo_.level, slot0.weaponInfo_.breakthrough))
	else
		slot0.atkText_.text = string.format("%d<color=#E78300>+%d</color>", slot4, WeaponServantCfg[slot0.servantInfo_.id].attrib_addition * slot4 / 100)
	end

	slot6, slot0.criText_.text = SkillTools.GetAttr(HeroCfg[slot1].weapon_break_attribute[slot0.weaponInfo_.breakthrough + 1])

	slot0:CheckLocked()
end

function slot0.CheckLocked(slot0)
	slot0.lockController_:SetSelectedState(tostring(not slot0.heroViewProxy_.isSelf))
end

function slot0.RefreshExpBar(slot0, slot1)
	slot0.expSlider_.value = slot1
end

function slot0.RefreshServantModel(slot0)
	if not slot0.servantInfo_ or not slot0.servantInfo_.id or slot0.servantInfo_.id == 0 then
		manager.heroRaiseTrack:PlayServantAnim("Fade")

		return
	end

	manager.heroRaiseTrack:PlayServantAnim("Gray")

	if slot0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
		manager.heroRaiseTrack:SetWeaponServantID(nil)
	else
		manager.heroRaiseTrack:SetWeaponServantID(slot0.servantInfo_.id)
	end
end

function slot0.RefreshServant(slot0, slot1)
	if not slot1 or slot1.id == 0 then
		slot0.servantController:SetSelectedState("false")

		return
	end

	slot0.servantController:SetSelectedState("true")

	slot0.servantnameText_.text = ItemTools.getItemName(slot1.id)

	slot0.servantRareController_:SetSelectedState(tostring(WeaponServantCfg[slot1.id].starlevel))

	slot0.servanticonImg_.sprite = getSpriteWithoutAtlas(SpritePathCfg.ServantIcon438.path .. slot1.id)
	slot0.raceImg_.sprite = getSprite("Atlas/CampItemAtlas", string.format("icon_group_%d_c", WeaponServantCfg[slot1.id].race))

	if HeroTools.GetHeroWeaponAddLevel(slot0.heroInfo_) > 0 then
		slot0.refinetextText_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL"), slot1.stage, slot6)
	else
		slot0.refinetextText_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL_1"), slot7)
	end

	slot0.isSelfController_:SetSelectedState(tostring(slot0.heroViewProxy_.isSelf))
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
	HeroTools.StopTalk()
end

function slot0.Show(slot0)
	uv0.super.Show(slot0)
	SetActive(slot0.gameObject_, true)
	slot0:UpdateView()
end

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		3,
		0,
		0
	}, slot0.displayGo_)
	slot0:RefreshServantModel()
end

function slot0.OnEnter(slot0, slot1)
	slot0.heroViewProxy_ = slot1
end

function slot0.Dispose(slot0)
	manager.redPoint:unbindUIandKey(slot0.weaponstrengthTrs_)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
