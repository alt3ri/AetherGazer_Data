slot0 = class("WeaponServantDetailModule", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.BuildContext(slot0)
	slot0.controller = {
		comps = slot0.gameObject_:GetComponent("ControllerExCollection"),
		state = {
			btnState = {
				beyond = "beyond",
				name = "btnState",
				equipped = "equipped",
				detail = "detail"
			}
		}
	}
	slot0.data = {}
	slot0.constVar = {
		rareBg = "",
		subDescColor = "#70767F",
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
		descType = 1,
		info = {}
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
	slot0:AddBtnListener(slot0.lockBtn_, nil, function ()
		uv0:OnLockBtnClick()
	end)
	slot0:RegistEventListener(SERVANT_LOCK, handler(slot0, slot0.OnServantLock))
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:RemoveAllEventListener()
	uv0.super.Dispose(slot0)
end

function slot0.OnRenderModule(slot0, slot1)
	slot0:InitContext()

	slot2 = slot1.heroId
	slot3 = clone(slot1.servantData)
	slot0.data.info = slot3
	slot4 = slot3.stage
	slot5 = 0
	slot0.data.heroId = slot2

	if slot2 then
		slot5 = HeroTools.GetHeroWeaponAddLevel(slot0:GetHeroInfo(slot2))
	end

	slot0.data.servantAddLv = slot5

	if slot5 > 0 then
		slot0.stageTxt_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL"), slot4, slot5)
	else
		slot0.stageTxt_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL_1"), slot4)
	end

	slot6 = slot3.id
	slot7 = WeaponServantCfg[slot6]
	slot0.nameTxt_.text = ItemTools.getItemName(ItemCfg[slot6].id)
	slot9 = string.format("com_white_icon_group_%d_c", slot7.race)
	slot0.groupImg_.sprite = getSprite("Atlas/SystemGroupAtlas", slot9)
	slot0.groupTitleImg_.sprite = getSprite("Atlas/SystemGroupAtlas", slot9)
	slot0.groupTitleTxt_.text = string.format(GetTips("EQUIP_RACE"), RaceEffectCfg[slot7.race].name)

	slot0:RenderLock()
	slot0:RefreshEffectText()
	slot0:RefreshRecommend()

	slot0.attackRatioTxt_.text = table.concat({
		"+",
		slot7.attrib_addition,
		"%"
	})
	slot0.subAttrNameTxt_.text, slot11, slot0.subAttrIconImg_.sprite = SkillTools.GetAttr(slot7.attribute)
	slot0.subAttrTxt_.text = "+" .. slot11

	slot0:RenderEquipStatus()
	slot0:RenderLockObj()
end

function slot0.RenderLock(slot0)
	if slot0.data.info.locked == 1 then
		slot0.lockImg_.sprite = getSprite("Atlas/SystemCommonAtlas", slot0.constVar.lockImg.locked)
	else
		slot0.lockImg_.sprite = getSprite("Atlas/SystemCommonAtlas", slot0.constVar.lockImg.unlocked)
	end
end

function slot0.RenderLockObj(slot0)
	if slot0.data.info.uid then
		SetActive(slot0.lockImg_.gameObject, true)
	else
		SetActive(slot0.lockImg_.gameObject, false)
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

function slot0.RefreshEffectText(slot0)
	slot2 = ""
	slot5 = WeaponServantCfg[slot0.data.info.id].desc

	if slot0.data.descType == 1 then
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
		if ServantTools.GetServantMap()[slot2.uid] then
			SetActive(slot0.equipObj_, true)

			slot0.equipHeroIcon_.sprite = HeroTools.GetSmallHeadSprite(slot3)
			slot0.equipHeroTxt_.text = string.format(GetTips("SERVANT_EQUIPED"), GetI18NText(HeroCfg[slot3].name))
		else
			SetActive(slot0.equipObj_, false)
		end
	else
		SetActive(slot0.equipObj_, false)
	end
end

function slot0.OnSwitchDescClick(slot0)
	slot0.data.descType = (slot0.data.descType + 1) % 2

	slot0:RefreshEffectText()
end

function slot0.OnLockBtnClick(slot0)
	if slot0.data.info.uid and slot0.data.info.uid ~= 0 then
		ServantAction.ServantLock(slot0.data.info.uid)
	end
end

function slot0.OnServantLock(slot0, slot1, slot2)
	if slot0.data.info.uid and slot0.data.info.uid ~= 0 and slot1 == slot0.data.info.uid then
		slot0.data.info.locked = slot2

		slot0:RenderLock()
	end
end

return slot0
