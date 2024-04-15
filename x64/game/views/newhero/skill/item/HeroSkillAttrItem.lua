slot0 = class("HeroSkillAttrItem", ReduxView)
slot1 = {
	showState = {
		max = "max",
		name = "showState",
		normal = "normal"
	}
}

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = slot0.controllerexcollection_:GetController(uv0.showState.name)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.descText_.text = PublicAttrCfg[slot1.attrType] and PublicAttrCfg[slot1.attrType].name or ""
	slot0.valuenowText_.text = slot1.nowValue / 10 .. "%"
	slot0.valuelaterText_.text = slot1.nextValue / 10 .. "%"
	slot3 = uv0.showState.normal

	slot0.stateController_:SetSelectedState((slot2 ~= false or uv0.showState.max) and (slot1.nextValue ~= 0 and uv0.showState.normal or uv0.showState.max))
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
