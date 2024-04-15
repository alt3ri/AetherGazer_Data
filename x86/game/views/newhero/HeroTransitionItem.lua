slot0 = class("HeroTransitionItem", ReduxView)

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
	TerminologyTools.AddTerminologyHandler(slot0, slot0.descText_, nil, )
end

function slot0.SetData(slot0, slot1)
	slot0.data_ = slot1
	slot0.cfg_ = EquipSkillCfg[slot1.skill_id or slot1.skillId]
	slot0.level_ = slot1.skill_level or slot1.level

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.nameText_.text = slot0.cfg_.name
	slot0.descText_.text = slot0:GetDesc()
	slot0.iconImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. slot0.cfg_.icon or "")
	slot0.levelText_.text = GetTips("LEVEL") .. slot0.level_
end

function slot0.GetDesc(slot0)
	return EquipTools.GetSkillDescWithoutHero(slot0.data_.skill_id or slot0.data_.skillId, slot0.level_, true)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
