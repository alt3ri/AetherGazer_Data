slot0 = class("HeroSkillItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.info_ = slot3

	slot0:InitUI()
	slot0:Init()
end

function slot0.RefreshData(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.info_ = slot2
	slot0.heroViewProxy_ = slot3

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListener(nil, , "OnClick")
end

function slot0.Init(slot0)
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot2 = slot0:GetRealSkillId(slot1)
		slot0.iconImg_.sprite = getSprite("Atlas/" .. slot1.heroId, slot2)
		slot0.nameText_.text = GetI18NText(HeroSkillCfg[slot2].name)

		SetActive(slot0.upGo_, slot1.isCanUp)
		slot0:RefreshLv(slot1)

		slot4 = HeroCfg[slot1.heroId]
		slot0.subnameText_.text = GetI18NText(slot4.skill_subhead[table.indexof(slot4.skills, slot1.id)])
	end
end

function slot0.RefreshLv(slot0, slot1)
	slot2 = 0

	if slot0.heroViewProxy_:GetTransitionAddLevel(slot1.heroId) <= 0 then
		slot0.lvText_.text = string.format("%d", slot1.lv + slot1.addSkillLv)
	else
		slot0.lvText_.text = string.format("<color=#F3DC5A>%d</color>", slot1.lv + slot1.addSkillLv + slot2)
	end
end

function slot0.GetRealSkillId(slot0, slot1)
	return slot0.heroViewProxy_:GetRealSkillId(slot1.heroId, slot1.id)
end

function slot0.OnClick(slot0)
	if slot0.clickFunc then
		slot0.clickFunc(slot0.info_)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.GetItemInfo(slot0)
	return slot0.info_
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
