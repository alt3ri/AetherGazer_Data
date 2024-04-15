slot0 = class("PolyhedronSetAstrolabeItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1)
	if HeroAstrolabeCfg[slot1].hero_astrolabe_suit_id % 10 == 1 then
		slot0.m_astrolabeIcon.sprite = getSprite("Atlas/Polyhedron_BattleAtlas", "PolyhedronBattle_00097")
	elseif slot4 == 2 then
		slot0.m_astrolabeIcon.sprite = getSprite("Atlas/Polyhedron_BattleAtlas", "PolyhedronBattle_00098")
	else
		slot0.m_astrolabeIcon.sprite = getSprite("Atlas/Polyhedron_BattleAtlas", "PolyhedronBattle_00096")
	end

	slot0.m_name.text = slot2.name
	slot0.m_des.text = GetCfgDescription(AstrolabeEffectCfg[slot1].desc[1], 1)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_des.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
