slot0 = class("HeroSurpassPreviewItem", ReduxView)
slot1 = {
	lockState = {
		lock = "lock",
		normal = "normal"
	},
	showTypeState = {
		special = "special",
		normal = "normal"
	}
}

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.isBigNode_ = slot2

	slot0:InitUI()
end

function slot0.SetClickCheckCallback(slot0, slot1)
	slot0.clickCheckCallback = slot1
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.lockController = slot0.controllerexcollection_:GetController("lock")

	if slot0.isBigNode_ then
		slot0.showController = slot0.controllerexcollection_:GetController("showType")
	end
end

function slot0.AddUIListener(slot0)
	if slot0.isBigNode_ then
		slot0:AddBtnListener(slot0.checkbtnBtn_, nil, function ()
			if uv0.clickCheckCallback then
				uv0:clickCheckCallback()
			end
		end)
	end
end

function slot0.RefreshUI(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = slot1.isBeginStar

	if slot0.showController then
		slot0.showController:SetSelectedState(slot1.isBeginStar and uv0.showTypeState.special or uv0.showTypeState.normal)
	end

	slot0.lockController:SetSelectedState(slot1.isLock and uv0.lockState.lock or uv0.lockState.normal)

	slot4 = slot1.cfg
	slot0.heroStarCfg = slot4
	slot0.textText_.text, slot6 = slot0:UpdateDescShow(slot1.heroCfg, slot4)

	if not slot0.isBigNode_ then
		-- Nothing
	else
		SurpassTools.ChangeIconStarSpirte(slot0.iconImg_, slot4.star)

		if slot6 == "" then
			SetActive(slot0.additem2Go_, false)
		else
			SetActive(slot0.additem2Go_, true)

			slot0.addtext2Text_.text = slot6
		end

		slot7 = HeroTools.IsSpHero(slot1.heroCfg and slot1.heroCfg.id or 0)

		SetActive(additem3Go_, slot7)

		if slot7 then
			SetActive(slot0.additem3Go_, AstrolabeTools.GetSpAstrolabeNodeBySurpass(slot1.heroCfg.id, slot4) ~= 0)

			if HeroAstrolabeCfg[slot8] then
				slot0.addtext3Text_.text = string.format("解锁[%s]神格", HeroAstrolabeCfg[slot8].name)
			end
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.showgroupTrs_)

		slot8 = slot0.checkbtnTrs_.position
		slot8.y = slot0.additem1Go_.transform.position.y
		slot0.checkbtnTrs_.position = slot8
	end
end

function slot0.UpdateDescShow(slot0, slot1, slot2)
	slot4, slot5 = SurpassTools.GetStarUpAttrShowDesc(slot1, slot2.id)

	for slot9, slot10 in pairs(slot4) do
		slot3 = string.format("%s%s\n", "", slot10)
	end

	return slot3, slot5
end

function slot0.SetActive(slot0, slot1)
	slot0.gameObject_:SetActive(slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
