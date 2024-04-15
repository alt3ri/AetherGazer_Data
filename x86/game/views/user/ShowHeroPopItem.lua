slot0 = class("ShowHeroPopItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroCampCon_ = ControllerUtil.GetController(slot0.transform_, "camp")
	slot0.heroStarCon_ = ControllerUtil.GetController(slot0.transform_, "grade")
	slot0.heroStateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.selfBtn_, nil, function ()
		if uv0.clickFunc_ then
			uv0.clickFunc_()
		end
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.isForeign_ = slot2

	if slot0.data_.hero_id == 0 then
		if not slot0.isForeign_ then
			slot0.heroStateCon_:SetSelectedState(1)
		else
			slot0.heroStateCon_:SetSelectedState(2)
		end
	else
		slot0.heroStateCon_:SetSelectedState(0)
		slot0:RefreshUI()
	end
end

function slot0.RefreshUI(slot0)
	slot0.headIcon_.sprite = getSpriteViaConfig("HeroIcon", slot0.data_.using_skin == 0 and slot0.data_.hero_id or slot0.data_.using_skin)

	slot0.heroStarCon_:SetSelectedState(HeroStarCfg[slot0.data_.star] ~= nil and slot1.star or 1)

	slot4 = HeroCfg[slot0.data_.hero_id].race
	slot0.campIcon_.sprite = HeroTools.GetHeroRaceIcon(slot0.data_.hero_id)
	slot0.levelText_.text = slot0.data_.level

	SetActive(slot0.lvGo_, not slot0.isForeign_)
end

function slot0.RegistClickFunction(slot0, slot1)
	slot0.clickFunc_ = slot1
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()
	uv0.super.Dispose(slot0)
end

return slot0
