slot0 = class("AstrolabeInfoView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "name")
end

function slot0.AddUIListener(slot0)
	TerminologyTools.AddTerminologyHandler(slot0, slot0.text3Text_, nil, )
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot2 = HeroAstrolabeCfg[slot1.id]
		slot0.text2Text_.text = string.format("%s·%s", GetI18NText(slot2.suit_name), GetI18NText(slot2.name))
		slot0.text3Text_.text = GetI18NText(slot0.heroViewProxy_:GetAstrolabeDesc(slot1.id, slot1.heroId))

		slot0.stateController_:SetSelectedState(AstrolabeConst.NodeColorCfg[AstrolabeTools.GetAstrolabeItemPos(slot1.id, slot1.heroId)] or slot4[1])

		if HeroTools.IsSpHero(slot1.heroId) then
			SetActive(slot0.spDes_, false)
		else
			slot0.nodeDes_.text = GetI18NText(GetTips("ASTROLABE_NODE_DESC_" .. slot2.pos))

			SetActive(slot0.spDes_, true)
		end
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.SetProxy(slot0, slot1)
	slot0.heroViewProxy_ = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
