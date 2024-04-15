slot0 = class("AstrolabeSuitDesItem", ReduxView)

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

	slot0.stateController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "name")

	TerminologyTools.AddTerminologyHandler(slot0, slot0.text3Text_, nil, )
end

function slot0.SetData(slot0, slot1, slot2)
	slot3 = HeroAstrolabeCfg[slot1]
	slot0.text2Text_.text = string.format("%s·%s", GetI18NText(slot3.suit_name), GetI18NText(slot3.name))
	slot0.text3Text_.text = GetI18NText(slot0.heroViewProxy_:GetAstrolabeDesc(slot1, slot2.id))

	slot0.stateController_:SetSelectedState(AstrolabeConst.NodeColorCfg[AstrolabeTools.GetAstrolabeItemPos(slot1, slot2.id)] or slot6[1])

	if HeroTools.IsSpHero(slot2.id) then
		SetActive(slot0.spDes_.gameObject, false)
	else
		slot0.nodeDes_.text = GetI18NText(GetTips("ASTROLABE_NODE_DESC_" .. slot3.pos))

		SetActive(slot0.spDes_.gameObject, true)
	end
end

function slot0.SetActive(slot0, slot1)
	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, slot1)
	end
end

function slot0.SetProxy(slot0, slot1)
	slot0.heroViewProxy_ = slot1
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
