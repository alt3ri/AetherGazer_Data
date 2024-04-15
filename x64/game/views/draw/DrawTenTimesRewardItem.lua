slot0 = class("DrawTenTimesRewardItem", ReduxView)

function slot1(slot0)
	if slot0 then
		return true
	end

	return false
end

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.shareStartHandler_ = handler(slot0, slot0.ShareStart)
	slot0.shareEndHandler_ = handler(slot0, slot0.ShareEnd)

	manager.notify:RegistListener(SHAER_DAW_TEN_TIMES_START, slot0.shareStartHandler_)
	manager.notify:RegistListener(SHAER_DAW_TEN_TIMES_END, slot0.shareEndHandler_)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemController_ = ControllerUtil.GetController(slot0.transform_, "item")
	slot0.switchController_ = ControllerUtil.GetController(slot0.transform_, "switch")
	slot0.rateController_ = ControllerUtil.GetController(slot0.transform_, "rare")
	slot0.starController_ = ControllerUtil.GetController(slot0.transform_, "star")
	slot0.item = CommonItemView.New(slot0.m_item)
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index = slot1
	slot0.data_ = slot2
	slot4 = slot2.id
	slot6 = ItemCfg[slot4]
	slot8 = slot6.type
	slot9 = ItemCfg[ItemWillConvert(slot2) and slot2.convert_from.id or slot4].type
	slot10 = slot6.display_rare

	slot0.starController_:SetSelectedIndex(math.min(slot10, 5))

	if slot10 >= 5 then
		slot0.rateController_:SetSelectedIndex(0)
	elseif slot10 >= 4 then
		slot0.rateController_:SetSelectedIndex(1)
	else
		slot0.rateController_:SetSelectedIndex(2)
	end

	SetActive(slot0.m_newTag, uv0(slot2.newTag))

	if slot9 == ItemConst.ITEM_TYPE.HERO then
		slot0.itemController_:SetSelectedIndex(0)

		slot0.m_camp.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[HeroCfg[slot5].race].icon)
		slot0.m_portrait.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot7.id)
	elseif slot9 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		slot0.itemController_:SetSelectedIndex(1)

		slot0.m_camp.sprite = getSpriteWithoutAtlas("TextureConfig/Group_l/" .. RaceEffectCfg[WeaponServantCfg[slot5].race].icon2)
		slot0.m_weaponName.text = string.split(ItemTools.getItemName(slot7.id) or "", "·")[1]
		slot0.m_weaponImg.sprite = getSpriteWithoutAtlas("TextureConfig/WeaponServant/Icon/" .. slot7.icon)
	end

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	if ItemWillConvert(slot2) then
		if slot3 then
			CommonTools.SetCommonData(slot0.item, rewardToItemTemplate(slot2))
		else
			slot0.m_switchAnimator:Play("CommonItem_zhuanhua", 0, 0)

			slot0.timer = Timer.New(function ()
				if uv0.index == uv1 then
					CommonTools.SetCommonData(uv0.item, rewardToItemTemplate(uv2))
				end

				uv0.timer = nil
			end, 1, 1)

			slot0.timer:Start()
			CommonTools.SetCommonData(slot0.item, rewardToItemTemplate(slot2.convert_from))
		end

		slot0.switchController_:SetSelectedIndex(1)
	else
		CommonTools.SetCommonData(slot0.item, rewardToItemTemplate(slot2))
		slot0.switchController_:SetSelectedIndex(1)
		slot0.switchController_:SetSelectedIndex(0)
	end
end

function slot0.ShareStart(slot0)
	if ItemCfg[slot0.data_.id].type == ItemConst.ITEM_TYPE.HERO then
		slot0.switchController_:SetSelectedIndex(0)
	end
end

function slot0.ShareEnd(slot0)
	if ItemCfg[slot0.data_.id].type == ItemConst.ITEM_TYPE.HERO and slot1.convert then
		slot0.switchController_:SetSelectedIndex(1)
	end
end

function slot0.Dispose(slot0)
	manager.notify:RemoveListener(SHAER_DAW_TEN_TIMES_START, slot0.shareStartHandler_)
	manager.notify:RemoveListener(SHAER_DAW_TEN_TIMES_END, slot0.shareEndHandler_)

	slot0.shareStartHandler_ = nil
	slot0.shareEndHandler_ = nil

	if slot0.item then
		slot0.item:Dispose()

		slot0.item = nil
	end

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.OnExit(slot0)
	slot0.switchController_:SetSelectedIndex(0)
end

return slot0
