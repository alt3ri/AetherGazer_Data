slot0 = class("NewHeroSurpassItem", ReduxView)
slot1 = {
	lockState = {
		selectLock = "1",
		name = "lock",
		normalLock = "2"
	},
	selectState = {
		name = "select",
		use = "2",
		unUse = "1"
	},
	useLockState = {
		name = "on",
		lock = "2",
		unlock = "1"
	},
	titleState = {
		lock = "2",
		name = "title",
		noTitle = "1",
		unlock = "3"
	},
	upState = {
		name = "up",
		noUp = "state0",
		canUp = "state1"
	}
}

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.parent_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.lockController = slot0.controllerexcollection_:GetController(uv0.lockState.name)
	slot0.selectController = slot0.controllerexcollection_:GetController(uv0.selectState.name)
	slot0.useLockController = slot0.controllerexcollection_:GetController(uv0.useLockState.name)
	slot0.titleController = slot0.controllerexcollection_:GetController(uv0.titleState.name)
	slot0.upController = slot0.controllerexcollection_:GetController(uv0.upState.name)

	slot0:AddBtnListener(slot0.btnbigitemBtn_, nil, function ()
		if uv0.clickCallBack then
			uv0.clickCallBack()
		end
	end)

	slot0.beginAlpha = slot0:GetAlpha()
	slot0.beginScale = slot0:GetScale()

	slot0:PlayLessenAni()
end

function slot0.ChangeLockState(slot0, slot1)
	slot2 = true

	for slot6, slot7 in pairs(slot0.starIdList or {}) do
		if slot7 <= slot1 + 1 then
			slot2 = false
		end
	end

	slot0.lockController:SetSelectedState(slot0.isGrow and uv0.lockState.selectLock or uv0.lockState.normalLock)

	if slot2 ~= slot0.isLock then
		slot0.useLockController:SetSelectedState(slot2 and uv0.useLockState.lock or uv0.useLockState.unlock)
	end

	slot0.isLock = slot2

	slot0:UpdateTitleState()
end

function slot0.RefreshUI(slot0, slot1)
	if not slot0.starStage then
		return
	end

	slot2 = slot1.star

	slot0:ChangeLockState(slot2)
	slot0.selectController:SetSelectedState(uv0.selectState.unUse)
	SurpassTools.UpdateSliImageFill(slot0.slistateblackImg_, slot0.starStage, slot2)

	slot5 = uv0.upState.noUp

	if checkGold(HeroStarCfg[slot2].gold_cost, false) and slot4.star_up <= slot1.piece and SurpassTools.GetNextSurpassStarID(slot2) == slot0.starIdList[1] then
		slot5 = uv0.upState.canUp
	end

	slot0.upController:SetSelectedState(slot5)

	if HeroStarCfg[HeroCfg[slot1.id].unlock_star].star == slot0.starStage then
		slot0.isBeginStarStage = true
	end
end

function slot0.SetStarStage(slot0, slot1)
	slot0.starStage = slot1
	slot0.starIdList = HeroStarCfg.get_id_list_by_star[slot1]

	SurpassTools.ChangeIconStarSpirte(slot0.iconImg_, slot1)
end

function slot0.SetClickCallBack(slot0, slot1)
	slot0.clickCallBack = slot1
end

function slot0.GetStarIdList(slot0)
	return slot0.starIdList
end

function slot0.GetTransform(slot0)
	return slot0.transform_
end

function slot0.GetPosition(slot0)
	return slot0.transform_.anchoredPosition
end

function slot0.SetPosition(slot0, slot1, slot2)
	slot0.transform_.anchoredPosition = Vector2(slot1, slot2)
end

function slot0.SetActive(slot0, slot1)
	slot0.gameObject_:SetActive(slot1)
end

function slot0.GetStarStage(slot0)
	return slot0.starStage
end

function slot0.ChangeAlpha(slot0, slot1)
	slot0.canvasgroup_.alpha = slot1
end

function slot0.GetAlpha(slot0)
	return slot0.canvasgroup_.alpha
end

function slot0.GetBeginAlpha(slot0)
	return slot0.beginAlpha
end

function slot0.GetScale(slot0)
	return slot0.transform_.localScale
end

function slot0.SetScale(slot0, slot1)
	if slot1 and slot1.x and slot1.x < 1 then
		slot0.animator_.enabled = false
	end

	slot0.transform_.localScale = slot1
end

function slot0.GetBeginScale(slot0)
	return slot0.beginScale
end

function slot0.PlayLessenAni(slot0)
	slot0.animator_:SetFloat("speed", -1)
	slot0.animator_:Play("Fx_btnbigItem_cx", 0, 0.4)
end

function slot0.PlayScaleAni(slot0, slot1)
	slot0.isGrow = slot1

	if slot0:GetScale().x <= 1.1 and not slot1 then
		slot0.animator_.enabled = false
	else
		slot0.animator_.enabled = true
	end

	if (slot1 and 1 or -1) == slot0.animator_:GetFloat("speed") then
		return
	end

	slot0.animator_:SetFloat("speed", slot2)

	slot4, slot5 = slot0:GetClipTimes()

	if slot1 then
		slot0.animator_:Play("Fx_btnbigItem_cx", 0, slot5 - slot4)
	else
		slot0.animator_:Play("Fx_btnbigItem_cx", 0, slot4)
	end

	if not slot1 then
		slot0:PlaySelectAni(false)
	end

	slot0.lockController:SetSelectedState(slot1 and uv0.lockState.selectLock or uv0.lockState.normalLock)
	slot0:UpdateTitleState()
end

function slot0.UpdateTitleState(slot0)
	slot1 = uv0.titleState.noTitle

	if slot0.isGrow then
		slot1 = slot0.isLock and uv0.titleState.lock or uv0.titleState.unlock
	end

	slot0.titleController:SetSelectedState(slot1)
end

function slot0.PlaySelectAni(slot0, slot1)
	if slot0.isBeginStarStage then
		slot0.selectController:SetSelectedState(uv0.selectState.unUse)

		return
	end

	if slot1 then
		slot0.selectController:SetSelectedState(uv0.selectState.use)
	else
		slot0.selectController:SetSelectedState(uv0.selectState.unUse)
	end
end

function slot0.GetClipTimes(slot0)
	slot1 = slot0.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime
	slot2 = slot0.animator_:GetCurrentAnimatorClipInfo(0)

	if slot0.animator_:GetCurrentAnimatorClipInfoCount(0) <= 0 then
		return 0, 0
	end

	slot4 = slot2[0].clip.length

	if slot1 < 1 and slot1 > 0 then
		slot4 = slot3 * slot1
	end

	return slot4, slot3
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
