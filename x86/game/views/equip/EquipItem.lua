slot0 = class("EquipItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.starController_ = slot0.equipController_:GetController("star")
	slot0.posController_ = slot0.equipController_:GetController("equippos")
	slot0.lvController_ = slot0.equipController_:GetController("lv")
	slot0.selectController_ = slot0.equipController_:GetController("sel")
	slot0.emptyController_ = slot0.equipController_:GetController("empty")
	slot0.detailController_ = slot0.equipController_:GetController("lvstate")

	slot0:AddUIListeners()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		uv0:OnClick()
	end)
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.info_ = slot1
	slot0.isShowDetail_ = slot2

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.isEquip_ = slot0.info_ and slot0.info_.prefab_id ~= 0

	slot0.emptyController_:SetSelectedState(slot0.isEquip_ and "notEmpty" or "empty")
	slot0.detailController_:SetSelectedState(slot0.isEquip_ and slot0.isShowDetail_ and "show" or "hide")

	if slot0.isEquip_ then
		slot0:RefreshDetail()

		slot0.equipIcon_.sprite = ItemTools.getItemSprite(slot0.info_.prefab_id)
	end
end

function slot0.RefreshDetail(slot0)
	if slot0.isEquip_ then
		slot1 = EquipCfg[slot0.info_.prefab_id]

		slot0.starController_:SetSelectedState(slot1.starlevel)
		slot0.posController_:SetSelectedState(slot1.pos)

		slot0.level_.text = string.format(GetTips("DORM_LEVEL_TIPS"), slot0.info_:GetLevel())

		if slot0.info_.race == 0 then
			slot0.lvController_:SetSelectedState("level")
		elseif table.keyof(RaceEffectCfg.all, slot0.info_.race) ~= nil then
			if RaceEffectCfg[slot0.info_.race] then
				slot0.imgGroup_.sprite = getSprite("Atlas/SystemGroupAtlas", slot2.icon2)

				slot0.lvController_:SetSelectedState("group")
			end
		elseif HeroCfg[slot0.info_.race] then
			slot0.imgHeroIcon_.sprite = HeroTools.GetSmallHeadSprite(slot0.info_.race)

			slot0.lvController_:SetSelectedState("hero")
		end
	end
end

function slot0.ShowSelect(slot0, slot1)
	slot0.selectController_:SetSelectedState(slot1 and "select" or "unselect")
end

function slot0.OnClick(slot0)
	if slot0.clickFunc then
		slot0.clickFunc(slot0.info_, slot0)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.GetItemInfo(slot0)
	return slot0.info_
end

function slot0.ShowAnim(slot0)
	slot0.emptyController_:SetSelectedState("notEmpty")

	if slot0.info_ and slot0.info_.prefab_id ~= 0 then
		slot0.effectAnim_:Play("Fx_icon_qiehuan")
	else
		slot0.iconAnim_:Play("Fx_icon_chuandai")
		slot0.effectAnim_:Play("Fx_icon_chuandai")
	end
end

function slot0.Hide(slot0)
	slot0.emptyController_:SetSelectedState("empty")
end

function slot0.Dispose(slot0)
	slot0.clickFunc = nil

	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
