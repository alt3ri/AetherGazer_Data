slot0 = class("SectionSmallHeroItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = slot0.controllerExCollection_:GetController("state")
	slot0.emptyController_ = slot0.controllerExCollection_:GetController("empty")
end

function slot0.SetData(slot0, slot1)
	slot0:Show(true)

	slot0.heroID_ = slot1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if slot0.heroID_ and slot0.heroID_ ~= 0 then
		slot0.heroIcon_.sprite = getSpriteViaConfig("HeroLittleIcon", slot0.heroID_)

		slot0.emptyController_:SetSelectedState("false")
	else
		slot0.emptyController_:SetSelectedState("true")
	end
end

function slot0.RefreshState(slot0, slot1)
	slot0.stateController_:SetSelectedState(slot1 == true and "on" or "off")
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
