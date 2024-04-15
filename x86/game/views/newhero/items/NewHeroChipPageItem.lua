slot0 = class("NewHeroChipPageItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.chipID_ = slot1
	slot0.heroID_ = slot2
	slot0.type_ = slot3

	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = slot0.itemCon_:GetController("ishavechip")
	slot0.iconController_ = slot0.itemCon_:GetController("icon")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		uv0:Go("/newHeroChipView", {
			heroID = uv0.heroID_,
			type = uv0.type_,
			chipID = uv0.chipID_
		})
	end)
end

function slot0.RefreshUI(slot0)
	slot0.iconController_:SetSelectedState(slot0.type_)

	slot0.typeText_.text = GetTips("CHIP_HERO_TYPE_" .. slot0.type_)

	if slot0.chipID_ and slot0.chipID_ > 0 then
		slot0.scrollRect_.verticalNormalizedPosition = 1

		slot0.controller_:SetSelectedState("on")

		slot1 = ChipCfg[slot0.chipID_]
		slot0.nameText_.text = slot1.suit_name
		slot0.desText_.text = slot1.desc

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrans_)

		slot0.iconImage_.sprite = getSpriteViaConfig("ChipSkillIcon", slot1.picture_id)
	else
		slot0.controller_:SetSelectedState("off")
	end
end

function slot0.SetIsShow(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.BindRedPoint(slot0)
	if slot0.extra_ then
		SetActive(slot0.redGo_, false)
	else
		slot1 = RedPointConst.CHIP_HERO_CHIP .. "_all_" .. slot0.heroID_ .. "_" .. slot0.type_

		manager.redPoint:addGroup(slot1, {
			RedPointConst.CHIP_HERO_CHIP .. "_" .. slot0.heroID_ .. "_" .. slot0.type_,
			RedPointConst.CHIP_HERO_CURRENCY_CHIP .. "_" .. slot0.heroID_ .. "_" .. slot0.type_
		})
		manager.redPoint:bindUIandKey(slot0.transform_, slot1)
	end
end

function slot0.UnBindRedPoint(slot0)
	if not slot0.extra_ then
		manager.redPoint:unbindUIandKey(slot0.transform_)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
