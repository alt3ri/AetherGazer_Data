slot0 = class("ZumaTalentInfoView", ReduxView)
slot1 = {
	showState = {
		name = "lock",
		canOpenNotConditon = "canOpenNotConditon",
		isUse = "isUse",
		canOpen = "canOpen",
		lock = "lock"
	}
}

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.showController = slot0.controllerexcollection_:GetController(uv0.showState.name)

	slot0:AddBtnListener(slot0.openBtn_, nil, function ()
		uv0:OnClickUpTalentBtn()
	end)
	slot0:AddBtnListener(slot0.lockBtn_, nil, function ()
		ShowTips("ACTIVITY_ZUMA_TALENT_LOCK")
	end)
end

function slot0.OnClickUpTalentBtn(slot0)
	if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_ZUMA) then
		ShowTips("TIME_OVER")

		return
	end

	if not ActivityZumaTalentCfg[slot0.useTalentID] then
		return
	end

	if ZumaData:GetZumaCoin() < slot2.need then
		ShowTips("ACTIVITY_ZUMA_TALENT_COST")

		return
	end

	ZumaAction.OpenZumaTalent(slot1)
end

function slot0.RefreshTalentInfoUi(slot0, slot1)
	slot0.useTalentID = slot1
	slot2 = ActivityZumaTalentCfg[slot1]
	slot0.costnumText_.text = slot2.need
	slot0.talentnameText_.text = slot2.name
	slot0.talentDescText_.text = slot2.desc

	if slot2.pre_id ~= 0 then
		slot0.conditiondescireText_.text = string.format(GetTips("ACTIVITY_ZUMA_TALENT_UNLOCK_CONDITION"), ActivityZumaTalentCfg[slot3].name)
	end

	if ZumaData:GetZumaTalentIsOpen(slot1) then
		slot0.showController:SetSelectedState(uv0.showState.isUse)
	elseif ZumaData:GetZumaTalentIsCanOpen(slot1) then
		if slot2.pre_id == 0 then
			slot0.showController:SetSelectedState(uv0.showState.canOpenNotConditon)
		else
			slot0.showController:SetSelectedState(uv0.showState.canOpen)
		end
	else
		slot0.showController:SetSelectedState(uv0.showState.lock)
	end
end

return slot0
