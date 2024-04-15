slot0 = class("HeroSkillViewItem", ReduxView)
slot1 = {
	selectState = {
		select = "true",
		name = "selectState",
		normal = "false"
	},
	upState = {
		up = "true",
		name = "upState",
		normal = "false"
	},
	nameAddState = {
		name = "nameAdd",
		add = "true",
		normal = "false"
	}
}

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:InitUI()
	slot0:Init()
	slot0:InitController()
end

function slot0.Init(slot0)
end

function slot0.InitController(slot0)
	slot0.selectController_ = slot0.controllerEx_:GetController(uv0.selectState.name)
	slot0.upController_ = slot0.controllerEx_:GetController(uv0.upState.name)
	slot0.addController_ = slot0.controllerEx_:GetController(uv0.nameAddState.name)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListener(nil, , "OnClick")
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.info = slot1

	if slot0.upController_ then
		if not slot0.heroViewDataProxy:CheckIsSelf() then
			slot0.upController_:SetSelectedState(uv0.upState.normal)
		else
			slot3 = slot1.isCanStarUp or slot1.isCanAttrUp

			if slot2 and slot2 == 1 then
				slot3 = slot1.isCanStarUp
			elseif slot2 and slot2 == 2 then
				slot3 = slot1.isCanAttrUp
			end

			slot0.upController_:SetSelectedState(slot3 and uv0.upState.up or uv0.upState.normal)
		end
	end

	if slot0.selectController_ then
		slot0:UpdateSelectState(slot0.handler_.selectSkillId == slot1.id)
	end

	slot0:RefreshUI(slot1)
end

function slot0.UpdateSelectState(slot0, slot1)
	if slot0.selectController_ then
		slot0.selectController_:SetSelectedState(slot1 and uv0.selectState.select or uv0.selectState.normal)
	end
end

function slot0.SetProxy(slot0, slot1)
	slot0.heroViewDataProxy = slot1
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot2 = slot0.heroViewDataProxy:GetRealSkillId(slot1.heroId, slot1.id)
		slot3 = HeroCfg[slot1.heroId]
		slot5 = HeroSkillCfg[slot2]
		slot0.skilliconImg_.sprite = getSprite("Atlas/" .. slot1.heroId, slot2)
		slot0.nameText_.text = slot3.skill_subhead[table.indexof(slot3.skills, slot1.id)]

		slot0:RefreshLv(slot1)

		if slot0.sliderSlr_ then
			slot0.sliderSlr_.value = slot0.heroViewDataProxy:GetSkillAtrrProgressValue(slot1.heroId, slot4)
		end
	end
end

function slot0.RefreshLv(slot0, slot1)
	if slot0.lvText_ then
		slot5 = slot1.tempAddLevel or 0
		slot5 = slot1.addEquipSkillLv or 0
		slot0.lvText_.text = string.format("%d", slot0.heroViewDataProxy:GetSkillLv(slot1.heroId, slot1.id) + slot5 + slot1.addSkillLv + slot5)

		slot0.addController_:SetSelectedState(slot5 > 0 and uv0.nameAddState.add or uv0.nameAddState.normal)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.OnClick(slot0)
	if slot0.clickFunc then
		slot0.clickFunc(slot0.info)
	end
end

function slot0.SetAniState(slot0, slot1)
	if slot0.animator_ then
		slot0.animator_.enabled = slot1
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
