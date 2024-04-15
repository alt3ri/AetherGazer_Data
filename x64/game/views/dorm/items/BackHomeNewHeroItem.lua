slot0 = class("BackHomeNewHeroItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.fatigueController = ControllerUtil.GetController(slot0.transform_, "fatigue")
	slot0.jobController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.curPositionController = ControllerUtil.GetController(slot0.transform_, "currentPosition")
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 and slot1 > 0 then
		slot0.jobController:SetSelectedState("hero")

		if DormNpcTools:CheckIDIsNpc(slot1) then
			slot0:RefreshNpcInfo(slot1)
		else
			slot0:RefreshHeroInfo(slot1)
		end
	elseif slot0.showJobState then
		slot0.jobController:SetSelectedState("vacancy")
	end
end

function slot0.RefreshNpcInfo(slot0, slot1)
	slot0.heroID = slot1
	slot0.iconImg_.sprite = DormNpcTools:GetNpcHeadSprite(slot1)

	if slot0.showFatigue then
		slot0.fatigueController:SetSelectedState("suff")
	else
		slot0.fatigueController:SetSelectedState("none")
	end

	if slot0.showState then
		slot0.state = BackHomeNpcData:GetNpcInfoById(slot1):GetHeroState()

		if slot0.state == DormEnum.DormHeroState.InCanteenEntrust then
			slot0.jobController:SetSelectedState("busy")
		elseif slot0.state == DormEnum.DormHeroState.InCanteenJob then
			slot0.curPositionController:SetSelectedState("canteen")
		elseif slot0.state == DormEnum.DormHeroState.InPublicDorm then
			slot0.curPositionController:SetSelectedState("lobby")
		elseif slot0.state == DormEnum.DormHeroState.InPrivateDorm then
			slot0.curPositionController:SetSelectedState("dorm")
		elseif slot0.state == DormEnum.DormHeroState.OutDorm then
			slot0.curPositionController:SetSelectedState("dorm")
		elseif slot0.state == DormEnum.DormHeroState.InIdolTraineeCamp then
			slot0.curPositionController:SetSelectedState("idolCamp")
		end
	else
		slot0.curPositionController:SetSelectedState("no")
	end
end

function slot0.RefreshHeroInfo(slot0, slot1, slot2)
	slot0.heroID = slot1
	slot0.archiveID = DormData:GetHeroArchiveID(slot1)
	slot0.iconImg_.sprite = DormHeroTools.GetBackHomeHeadSprite(slot1)
	slot3 = DormData:GetHeroTemplateInfo(slot0.heroID)

	if slot0.showFatigue then
		slot4 = slot3:GetFatigue()

		if slot3:GetFatigue() <= GameDisplayCfg.dorm_hero_fatigue_level.value[1] then
			slot0.fatigueController:SetSelectedState("low")
		elseif slot5[1] < slot3:GetFatigue() and slot3:GetFatigue() <= slot5[2] then
			slot0.fatigueController:SetSelectedState("middle")
		else
			slot0.fatigueController:SetSelectedState("suff")
		end
	else
		slot0.fatigueController:SetSelectedState("none")
	end

	if slot0.showState then
		slot0.state = slot3:GetHeroState()

		if slot0.state == DormEnum.DormHeroState.InCanteenEntrust then
			slot0.jobController:SetSelectedState("busy")
		elseif slot0.state == DormEnum.DormHeroState.InCanteenJob then
			slot0.curPositionController:SetSelectedState("canteen")
		elseif slot0.state == DormEnum.DormHeroState.InPublicDorm then
			slot0.curPositionController:SetSelectedState("lobby")
		elseif slot0.state == DormEnum.DormHeroState.InPrivateDorm then
			slot0.curPositionController:SetSelectedState("dorm")
		elseif slot0.state == DormEnum.DormHeroState.OutDorm then
			slot0.curPositionController:SetSelectedState("dorm")
		elseif slot0.state == DormEnum.DormHeroState.InIdolTraineeCamp then
			slot0.curPositionController:SetSelectedState("idolCamp")
		end
	else
		slot0.curPositionController:SetSelectedState("no")
	end
end

function slot0.SetItemFunction(slot0, slot1)
	if slot1 then
		slot0.showState = slot1.showState
		slot0.showFatigue = slot1.showFatigue
		slot0.showJobState = slot1.showJobState
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
