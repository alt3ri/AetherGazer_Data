slot0 = class("DormCharacterItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.characterStateController = ControllerUtil.GetController(slot0.transform_, "name")
	slot0.fatigueController = ControllerUtil.GetController(slot0.transform_, "fatigue")
	slot0.positionController = ControllerUtil.GetController(slot0.transform_, "position")
	slot0.curPisitionController = ControllerUtil.GetController(slot0.transform_, "currentPosition")
	slot0.maskController = ControllerUtil.GetController(slot0.transform_, "mask")
	slot0.sameNameController = ControllerUtil.GetController(slot0.transform_, "sameName")
end

function slot0.AddUIListener(slot0)
	slot0.onClickCom_ = slot0:FindCom("OnClickDownListener")

	slot0.onClickCom_.onValueChanged:AddListener(function ()
		if not uv0.canClick and uv0.dragFunc then
			uv0.dragFunc(uv0.heroID)
		end
	end)
	slot0:AddBtnListener(slot0.heroitemBtn_, nil, function ()
		if not uv0.canClick and uv0.downFunc then
			uv0.downFunc(uv0.heroID)
		end
	end)
	slot0:AddBtnListenerScale(slot0.recallbtnBtn_, nil, function ()
		if not uv0.canClick and uv0.recallHero then
			uv0.recallHero(uv0.heroID)
		end
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	if DormNpcTools:CheckIDIsNpc(slot1) then
		slot0:RefreshNpcInfo(slot1, slot2)
	else
		slot0:RefreshHeroInfo(slot1, slot2)
	end
end

function slot0.RefreshNpcInfo(slot0, slot1, slot2)
	slot0.heroID = slot1
	slot0.iconImg_.sprite = DormNpcTools:GetNpcHeadSprite(slot1)

	if DormNpcTools:GetNpcFatigue(slot1) < 0 then
		slot0.fatigueController:SetSelectedState("infinitew")
	end
end

slot1 = import("game.dorm.DormEnum")
slot2 = {
	[slot1.DormHeroState.InCanteenJob] = "canteen",
	[slot1.DormHeroState.InCanteenEntrust] = "task",
	[slot1.DormHeroState.InPublicDorm] = "lobby",
	[slot1.DormHeroState.InIdolTraineeCamp] = "idolCamp"
}
slot3 = {
	[slot1.DormHeroState.InCanteenJob] = true,
	[slot1.DormHeroState.InCanteenEntrust] = true,
	[slot1.DormHeroState.InPublicDorm] = true,
	[slot1.DormHeroState.InPrivateDorm] = true,
	[slot1.DormHeroState.InIdolTraineeCamp] = true
}

function slot0.EnableRecall(slot0)
	if nullable(BackHomeCfg, DormData:GetCurrectSceneID(), "type") == DormConst.BACKHOME_TYPE.PublicDorm and DormHeroTools:CheckHeroInRoom(slot1, slot0.archiveID) then
		return true
	end

	return false
end

function slot0.RefreshHeroInfo(slot0, slot1, slot2)
	if slot1 then
		slot0.heroID = slot1
		slot0.archiveID = DormData:GetHeroArchiveID(slot1)

		if DormData:GetHeroTemplateInfo(slot0.heroID) then
			slot0.iconImg_.sprite = DormHeroTools.GetBackHomeHeadSprite(slot1)

			if not slot0.showFatigue then
				slot0.maxText_.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
				slot4 = slot3:GetFatigue()
				slot0.curText_.text = slot4
				slot0.progressImg_.fillAmount = 1 - math.min(slot4 / GameSetting.canteen_hero_fatigue_max.value[1], 1)

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

			if not slot0.showState then
				slot0.state = slot3:GetHeroState()

				slot0.curPisitionController:SetSelectedState(nullable(uv0, slot0.state) or "dorm")
				slot0.positionController:SetSelectedState(nullable(uv1, slot0.state) and "busy" or "normal")
			end

			if not slot0.canClick then
				if slot0.selFunc then
					slot0.selFunc(slot0.heroID, slot2, slot0.characterStateController)
				else
					slot0.characterStateController:SetSelectedState("normal")
					slot0.sameNameController:SetSelectedState("false")

					if slot0.archiveID == DormData:GetHeroArchiveID(slot2) then
						if slot2 == slot0.heroID then
							if slot0:EnableRecall() then
								slot0.characterStateController:SetSelectedState("select_recall")
							else
								slot0.characterStateController:SetSelectedState("select")
							end
						else
							slot0.positionController:SetSelectedState("normal")
							slot0.sameNameController:SetSelectedState("true")
						end
					end
				end
			end

			slot0.maskController:SetSelectedState("false")

			if slot0.maskFunc and slot0.maskFunc(slot0.heroID) then
				slot0.maskController:SetSelectedState("true")
			end
		end
	end
end

function slot0.SetCanClickAndState(slot0, slot1, slot2, slot3)
	slot0.showState = slot1
	slot0.canClick = slot2
	slot0.showFatigue = slot3
end

function slot0.RecallHero(slot0, slot1)
	slot0.recallHero = slot1
end

function slot0.OnPointerDown(slot0, slot1)
	slot0.downFunc = slot1
end

function slot0.InDragFunc(slot0, slot1)
	slot0.dragFunc = slot1
end

function slot0.ShowMaskCallBack(slot0, slot1)
	if slot1 then
		slot0.maskFunc = slot1
	end
end

function slot0.SelCallBack(slot0, slot1)
	if slot1 then
		slot0.selFunc = slot1
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if not slot0.canClick and slot0.onClickCom_ then
		slot0.onClickCom_.onValueChanged:RemoveAllListeners()
	end

	uv0.super.Dispose(slot0)
end

return slot0
