slot0 = class("ActivityHeroEnhanceTalentItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.selController_ = slot0.controller_:GetController("select")
	slot0.lockController_ = slot0.controller_:GetController("lock")
	slot0.addController_ = slot0.controller_:GetController("add")
	slot0.useController_ = slot0.controller_:GetController("use")
	slot0.effectController_ = slot0.controller_:GetController("effect")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.onClickHandler_ then
			uv0.onClickHandler_(uv0.talentId_)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.activityId_ = slot1
	slot0.talentId_ = slot2
end

function slot0.SetSelected(slot0, slot1)
	slot0.selected_ = slot1
end

function slot0.SetUsed(slot0, slot1)
	slot0.used_ = slot1
end

function slot0.SetLock(slot0, slot1)
	slot0.locked_ = slot1
end

function slot0.SetFirstAddFlag(slot0, slot1)
	slot0.isFirstAdd_ = slot1
end

function slot0.SetClickHandler(slot0, slot1)
	slot0.onClickHandler_ = slot1
end

slot1 = {
	"Ⅰ",
	"Ⅱ",
	"Ⅲ",
	"Ⅳ",
	"Ⅴ",
	"Ⅵ",
	"Ⅶ",
	"Ⅷ",
	"Ⅸ"
}

function slot0.RefreshUI(slot0)
	if slot0.talentId_ then
		slot0.affixImage_.sprite = getAffixSprite({
			TalentTreeCfg[slot1].affix_id
		})

		if slot0.affixNameText_ then
			slot0.affixNameText_.text = GetI18NText(slot2.name)
		end

		slot0.affixLevelText_.text = uv0[table.indexof(ActivityHeroEnhanceTools.GetCfgTalentListByStage(ActivityHeroEnhanceTools.GetCfgByTalentId(slot0.activityId_, slot1), slot2.stage), slot1)]

		SetActive(slot0.affixLevelGo_, true)
		slot0.addController_:SetSelectedState("false")
	else
		if slot0.affixNameText_ then
			slot0.affixNameText_.text = ""
		end

		SetActive(slot0.affixLevelGo_, false)
		slot0.addController_:SetSelectedState("true")
	end

	if slot0.effectController_ then
		if slot0.isFirstAdd_ then
			slot0.effectController_:SetSelectedState("firstAdd")
		else
			slot0.effectController_:SetSelectedState("none")
		end
	end

	slot0.selController_:SetSelectedState(slot0.selected_ and "true" or "false")
	slot0.lockController_:SetSelectedState(slot0.locked_ and "true" or "false")
	slot0.useController_:SetSelectedState(slot0.used_ and "true" or "false")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
