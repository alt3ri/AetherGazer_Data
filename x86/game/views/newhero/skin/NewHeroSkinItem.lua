slot0 = class("NewHeroSkinItem", ReduxView)
slot1 = 154
slot2 = 0.85
slot3 = 0.775

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.isActive = false

	slot0:BindCfgUI()
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.isUnlock(slot0, slot1)
	return HeroTools.GetHasOwnedSkin(slot1)
end

function slot0.isUnlockOrCanChange(slot0, slot1)
	return slot0:isUnlock(slot1) or HeroTools.CanChangeSkin(slot1)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	slot0.isActive = slot1
end

function slot0.SetOrder(slot0, slot1)
	slot0.spriterenderer_.sortingOrder = slot1
end

function slot0.isSelect(slot0, slot1)
	if HeroTools.HeroUsingSkinInfo(SkinCfg[slot1].hero).id == slot1 then
		return true
	end

	return false
end

function slot0.SetDelegate(slot0, slot1)
	slot0.delegate_ = slot1
end

function slot0.InitUI(slot0)
	slot0.selController_ = slot0.controllerEx_:GetController("sel")
	slot0.lockController_ = slot0.controllerEx_:GetController("lock")
	slot0.dlcController_ = slot0.controllerEx_:GetController("dlc")
	slot0.transform_.pivot = Vector2(0.5, 0.5)
	slot0.parentWidth_ = slot0.scrollTf_.rect.width / 2
	slot0.itemWidth_ = slot0.transform_.rect.width / 2 * (uv0 + uv1)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.itemBtn_, nil, function ()
		uv0:delegate_()
	end)
end

function slot0.Show(slot0, slot1, slot2)
	slot0.skinID_ = slot1
	slot0.index_ = slot2
	slot0.skinState_ = slot0:SkinState()
	slot3 = SkinCfg[slot1].hero

	manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.HERO_SKIN_ROUTE_ID .. slot0.skinID_)
	slot0:RefreshUI()
end

function slot0.PlayAni(slot0, slot1)
	if slot0.aniTimer_ then
		slot0.aniTimer_:Stop()

		slot0.aniTimer_ = nil
	end

	slot0.itemAni_.enabled = false
	slot0.itemTrs_.localPosition = Vector3(slot0.itemTrs_.localPosition.x, -562, slot0.itemTrs_.localPosition.z)
	slot0.aniTimer_ = Timer.New(function ()
		uv0.itemAni_.enabled = true

		uv0.itemAni_:Play("aniSkinUI_item")
	end, slot1, 1)

	slot0.aniTimer_:Start()
end

function slot0.GetSkinID(slot0)
	return slot0.skinID_
end

function slot0.RefreshUI(slot0)
	slot1 = SkinCfg[slot0.skinID_]
	slot0.roleImg_.sprite = getSpriteViaConfig("HeroIcon", slot1.picture_id)
	slot0.nameText_.text = GetI18NText(slot1.name)

	if slot0:isUnlock(slot0.skinID_) then
		slot0.lockController_:SetSelectedState("unlock")
	else
		slot0.lockController_:SetSelectedState("lock")
	end

	if slot0:isSelect(slot0.skinID_) then
		SetActive(slot0.iconGo_, true)
	else
		SetActive(slot0.iconGo_, false)
	end

	if slot0.skinState_ == 5 or manager.redPoint:getTipBoolean(RedPointConst.HERO_SKIN_ID_EXTEND .. slot0.skinID_) or manager.redPoint:getTipValue(RedPointConst.SKIN_GIFT .. "_" .. slot0.skinID_) == 1 then
		manager.redPoint:SetRedPointIndependent(slot0.itemTrs_, true)
	else
		manager.redPoint:SetRedPointIndependent(slot0.itemTrs_, false)
	end
end

function slot0.JudgeDLC(slot0, slot1)
	slot0.dlcID_ = nil

	if not HeroTools.GetShopIdBySkinId(slot1) then
		return false
	end

	if getShopCfg(slot2) and slot3.dlc and slot4 ~= 0 then
		slot0.dlcID_ = slot4

		return true
	end

	return false
end

function slot0.SkinState(slot0)
	if slot0:isUnlock(slot0.skinID_) then
		if slot0:isSelect(slot0.skinID_) then
			return 1
		end

		return 2
	else
		if HeroTools.GetIsLimitTimeSkin(slot0.skinID_) then
			if slot0:isSelect(slot0.skinID_) then
				if HeroTools.IsSkinOutOfDate(slot0.skinID_) or slot0.showDlcState_ == 1 then
					return 1
				else
					return 10
				end
			elseif HeroTools.IsSkinOutOfDate(slot0.skinID_) or slot0.showDlcState_ == 1 then
				return 2
			else
				return 11
			end
		end

		if HeroTools.CanChangeSkin(slot0.skinID_) then
			return 5
		end

		if HeroTools.GetSkinIsCanUnLock(slot0.skinID_) then
			return 6
		end

		if HeroTools.IsSkinOutOfDate(slot0.skinID_) then
			return 4
		end

		if ShopTools.IsPC() and ShopTools.IsRMB(HeroTools.GetShopIdBySkinId(slot0.skinID_)) then
			return 12
		end

		return 3
	end
end

function slot0.CheckDLC(slot0, slot1)
	slot0.dlcController_:SetSelectedState(slot1 and "haveDLC" or "noDLC")
end

function slot0.ShowSelect(slot0, slot1)
	slot0.selController_:SetSelectedState(slot1 and "true" or "false")
end

function slot0.RefreshShow(slot0)
	slot1 = slot0.scrollTf_.rect.width / 2
	slot4 = math.max(uv0 - (uv0 - uv1) * math.abs(slot0.scrollTf_:InverseTransformPoint(slot0.transform_:TransformPoint(Vector3.zero)).x) / slot0.itemWidth_, uv1)
	slot0.transform_.localScale = Vector3.New(slot4, slot4, slot4)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTf_)
end

function slot0.GetLocalPosition(slot0)
	return slot0.transform_.localPosition
end

function slot0.Dispose(slot0)
	if slot0.aniTimer_ then
		slot0.aniTimer_:Stop()

		slot0.aniTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(slot0.transform_)
	uv0.super.Dispose(slot0)
end

return slot0
