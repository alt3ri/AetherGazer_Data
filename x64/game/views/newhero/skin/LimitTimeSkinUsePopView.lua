slot0 = class("LimitTimeSkinUsePopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Recharge/LimitTimeSkinUsePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.skinOwnController_ = slot0.skinController_:GetController("owned2")
	slot0.dlcOwnController_ = slot0.dlcController_:GetController("owned2")
	slot0.stateController_ = slot0.controller_:GetController("state")
	slot0.tipsController_ = slot0.controller_:GetController("tips")
	slot0.btnController_ = slot0.controller_:GetController("btn")
	slot0.skinItem_ = CommonItemView.New(slot0.skinItemGo_)
	slot0.dlcItem_ = CommonItemView.New(slot0.dlcItemGo_)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.tipsBtn_, nil, function ()
		if uv0:HasOwnAllItem() then
			return
		end

		if uv0.showSkin_ then
			uv0.showSkin_ = false
		else
			uv0.showSkin_ = true
		end

		uv0.tipsController_:SetSelectedState(tostring(uv0.showSkin_))
	end)
	slot0:AddBtnListener(slot0.mask_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.noBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.hadBtn_, nil, function ()
		uv0:CheckCanUse()
	end)
	slot0:AddBtnListener(slot0.yesBtn_, nil, function ()
		slot0 = {
			item_info = {
				num = 1,
				id = uv0.itemId_,
				time_valid = uv0.timeValid
			},
			use_list = {}
		}

		if not uv0:CheckCanUse() then
			return
		end

		CommonAction.TryToUseItemWitchCallback({
			slot0
		}, function (slot0)
			uv0:UseItemSuccess(slot0)
		end)
	end)
end

function slot0.UseItemSuccess(slot0, slot1)
	slot0:Back()
	getReward(slot1.drop_list)
	HeroAction.SelectSkin(SkinCfg[slot0.skinId_].hero, slot0.skinId_)

	if slot0.showSkin_ then
		PlayerAction.ChangePosterGirl(SkinCfg[slot0.skinId_].hero)
	end
end

function slot0.OnEnter(slot0)
	slot0.itemId_ = slot0.params_.itemData.id
	slot0.timeValid = ItemTools.GetItemExpiredTimeByInfo(slot0.params_.itemData)
	slot0.cfg_ = ItemCfg[slot0.itemId_]
	slot0.reward_ = slot0.cfg_.param
	slot0.dlcId_ = nil
	slot0.skinId_ = nil
	slot0.LimitDlcId_ = nil
	slot0.LimitskinItemId_ = nil

	for slot4, slot5 in ipairs(slot0.reward_) do
		if ItemCfg[slot5].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			slot0.LimitskinItemId_ = slot5
		elseif slot6.type == ItemConst.ITEM_TYPE.SCENE then
			slot0.LimitDlcId_ = slot5
		end
	end

	if slot0.LimitskinItemId_ then
		slot0.LimitskinItemCfg_ = ItemCfg[slot0.LimitskinItemId_]

		if slot0.LimitskinItemCfg_ then
			slot0.skinId_ = slot0.LimitskinItemCfg_.param[1]
			slot0.heroId_ = SkinCfg[slot0.skinId_].hero
		end
	end

	if slot0.LimitDlcId_ then
		slot0.LimitDlcCfg_ = ItemCfg[slot0.LimitDlcId_]

		if slot0.LimitDlcCfg_ then
			slot0.dlcId_ = slot0.LimitDlcCfg_.param[1]
		end
	end

	slot0.showSkin_ = true

	slot0.tipsController_:SetSelectedState(tostring(slot0.showSkin_))
	slot0:UpdateView()
end

function slot0.HasOwnAllItem(slot0)
	slot1 = false
	slot2 = false

	if slot0.skinId_ and slot0.dlcId_ then
		if HomeSceneSettingData:IsHaveScene(slot0.dlcId_) and HeroTools.GetHasOwnedSkin(slot0.skinId_) then
			return true
		end
	elseif not slot0.skinId_ and slot0.dlcId_ then
		if HomeSceneSettingData:IsHaveScene(slot0.dlcId_) then
			return true
		end
	elseif slot0.skinId_ and not slot0.dlcId_ and HeroTools.GetHasOwnedSkin(slot0.skinId_) then
		return true
	end

	return false
end

function slot0.CheckCanUse(slot0)
	if HeroData:GetHeroData(slot0.heroId_).unlock == 0 then
		ShowTips("ERROR_HERO_NOT_UNLOCK")

		return false
	end

	if slot0:HasOwnAllItem() then
		ShowTips(string.format(GetTips("SKIN_LIMIT_TIME_DESC_4"), ItemCfg[slot0.itemId_].name))

		return false
	end

	return true
end

function slot0.UpdateItemView(slot0, slot1, slot2)
	slot3 = clone(ItemTemplateData)
	slot3.id = slot2
	slot3.number = nil

	slot1:SetData(slot3)
end

function slot0.UpdateView(slot0)
	if slot0.skinId_ then
		slot0:UpdateItemView(slot0.skinItem_, slot0.skinId_)
	end

	if slot0.dlcId_ then
		slot0:UpdateItemView(slot0.dlcItem_, slot0.dlcId_)
	end

	SetActive(slot0.tipsBtnGo_, not slot0:HasOwnAllItem())

	slot0.skinImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot0.skinId_)
	slot0.titleText_.text = SkinCfg[slot0.skinId_].name
	slot0.leftTimeText_.text = slot0.LimitskinItemCfg_.time[2][1] .. GetTips("DAY")

	if slot0.skinId_ and slot0.dlcId_ then
		slot0.stateController_:SetSelectedState("all")
	elseif slot0.skinId_ and not slot0.dlcId_ then
		slot0.stateController_:SetSelectedState("skin")
	elseif not slot0.skinId_ and slot0.dlcId_ then
		slot0.stateController_:SetSelectedState("dlc")
	end

	slot1 = false

	if slot0.dlcId_ then
		slot1 = HomeSceneSettingData:IsHaveScene(slot0.dlcId_)
	end

	slot2 = false

	if slot0.skinId_ then
		slot2 = HeroTools.GetHasOwnedSkin(slot0.skinId_)
	end

	if slot2 then
		slot0.skinOwnController_:SetSelectedState("on")
	else
		slot0.skinOwnController_:SetSelectedState("off")
	end

	if slot1 then
		slot0.dlcOwnController_:SetSelectedState("on")
	else
		slot0.dlcOwnController_:SetSelectedState("off")
	end

	slot0.btnController_:SetSelectedState(tostring(slot0:HasOwnAllItem()))

	if slot0.dlcId_ then
		if not slot2 and not slot1 then
			slot0.descText_.text = string.format(GetTips("SKIN_LIMIT_TIME_DESC_1"), ItemCfg[slot0.itemId_].name, HeroCfg[slot0.heroId_].name .. "·" .. HeroCfg[slot0.heroId_].suffix, SkinCfg[slot0.skinId_].name, HomeSceneSettingCfg[slot0.dlcId_].title)
		elseif slot2 and not slot1 then
			slot0.descText_.text = string.format(GetTips("SKIN_LIMIT_TIME_DESC_2"), ItemCfg[slot0.itemId_].name, SkinCfg[slot0.skinId_].name, HomeSceneSettingCfg[slot0.dlcId_].title)
		elseif not slot2 and slot1 then
			slot0.descText_.text = string.format(GetTips("SKIN_LIMIT_TIME_DESC_3"), ItemCfg[slot0.itemId_].name, slot3, SkinCfg[slot0.skinId_].name)
		else
			slot0.descText_.text = string.format(GetTips("SKIN_LIMIT_TIME_DESC_4"), ItemCfg[slot0.itemId_].name)
		end
	elseif not slot2 then
		slot0.descText_.text = string.format(GetTips("SKIN_LIMIT_TIME_DESC_3"), ItemCfg[slot0.itemId_].name, slot3, SkinCfg[slot0.skinId_].name)
	else
		slot0.descText_.text = string.format(GetTips("SKIN_LIMIT_TIME_DESC_4"), ItemCfg[slot0.itemId_].name)
	end
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
end

return slot0
