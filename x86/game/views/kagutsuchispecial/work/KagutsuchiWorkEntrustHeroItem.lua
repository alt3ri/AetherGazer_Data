slot0 = class("KagutsuchiWorkEntrustHeroItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.heroItemBtn_, nil, function ()
		if uv0.onClickHandler_ then
			uv0.onClickHandler_(uv0.heroID, uv0.heroData)
		end
	end)
end

function slot0.SetClickHandler(slot0, slot1)
	if slot1 then
		slot0.onClickHandler_ = slot1
	end
end

function slot0.SetHeroData(slot0, slot1)
	slot0.heroID = slot1
end

function slot0.GetHeroData(slot0)
	return HeroData:GetHeroData(slot0.heroID)
end

function slot0.TrySetSelected(slot0, slot1)
	if slot0:IsLocked() or slot0:IsLevelLimited() or slot0:IsEntrusted() then
		return false
	end

	slot0.selected_ = slot1

	return slot0.selected_
end

function slot0.RefreshUI(slot0)
	slot2 = slot0.heroID
	slot0.heroIcon_.sprite = HeroTools.GetHeadSprite(slot2)
	slot0.raceIcon_.sprite = HeroTools.GetHeroRaceIcon(slot2)
	slot0.levelText_.text = slot0:GetHeroData().level
	slot0.imageLv_.sprite = getSprite("Atlas/Common", "star_" .. HeroCfg[slot2].rare)

	if slot0:IsLocked() then
		slot0.selController:SetSelectedState("absence")
	elseif slot0:IsLevelLimited() then
		slot0.selController:SetSelectedState("levelLimited")
	elseif slot0:IsEntrusted() then
		slot0.selController:SetSelectedState("entrusted")
	elseif slot0.selected_ then
		slot0.selController:SetSelectedState("selected")
	else
		slot0.selController:SetSelectedState("unselected")
	end
end

function slot0.IsLocked(slot0)
	return slot0:GetHeroData().unlock == 0
end

function slot0.IsLevelLimited(slot0)
	return slot0:GetHeroData().level < KagutsuchiWorkData:GetMinEntrustHeroLevel()
end

function slot0.IsEntrusted(slot0)
	return KagutsuchiWorkData:IsEntrusted(slot0.heroID)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
