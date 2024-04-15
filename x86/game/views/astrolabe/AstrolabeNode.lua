slot0 = class("AstrolabeNode")

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.transform_.localPosition = Vector3(0, 0, 0)
	slot0.posX = slot3
	slot0.aniStrCfg = {
		"yellow",
		"red",
		"blue"
	}

	slot0:InitUI()
	slot0:Init()
end

function slot0.SetParent(slot0, slot1)
	if slot0.transform_ then
		slot0.transform_:SetParent(slot1)

		slot0.transform_.localEulerAngles = Vector3(0, 0, 0)
		slot0.transform_.localPosition = Vector3(0, 0, 0)
		slot0.transform_.localScale = Vector3(1, 1, 1)
	end
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.info_ = slot2

	slot0:Render()
end

function slot0.InitUI(slot0)
	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.transform_)
	slot0.itemEventtriggerlistener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(handler(slot0, slot0.OnClick)))
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.info_ = slot2

	if slot1 then
		slot3 = {
			slot0.yellowAni_,
			slot0.redAni_,
			slot0.blueAni_
		}

		if HeroTools.IsSpHero(slot2.id) then
			if slot0.spAni_ then
				slot0.curAnimator.runtimeAnimatorController = slot0.spAni_.runtimeAnimatorController
			end

			slot0:ShowSpState(slot1)
		else
			slot0.curAnimator.runtimeAnimatorController = slot3[slot0.posX].runtimeAnimatorController

			slot0:ShowNormalState(slot1)
		end

		slot0.textTm_.text = GetI18NText(HeroAstrolabeCfg[slot1.id].name)

		if slot0.lineStar then
			SetActive(slot0.lineStar.gameObject, slot0.heroViewProxy_:GetNextIsEquiped(slot1.id, slot0.info_.id))
		end
	end
end

function slot0.ShowNormalState(slot0, slot1)
	if slot1.isEquiped then
		slot0.curAnimator:Update(0)
		slot0.curAnimator:Play("star1_" .. slot0.aniStrCfg[slot0.posX], 0, 0)

		slot0.nodeState = AstrolabeConst.NODE_STATE.EQUIPED
	elseif not slot1.isUnlock then
		if slot1.isCanLock then
			slot0.nodeState = AstrolabeConst.NODE_STATE.CANLOCK

			slot0.curAnimator:Play("lock1")
		else
			slot0.curAnimator:Play("lock2")

			slot0.nodeState = AstrolabeConst.NODE_STATE.LOCK
		end
	elseif slot1.isUnlock then
		slot0.curAnimator:Play("star2_" .. slot0.aniStrCfg[slot0.posX])

		slot0.nodeState = AstrolabeConst.NODE_STATE.UNLOCK
	end
end

function slot0.ShowNextEffect(slot0)
	if slot0.lineStar then
		SetActive(slot0.lineStar.gameObject, AstrolabeTools.GetNextIsEquiped(slot0.data_.id, slot0.info_.id))
	end
end

function slot0.ShowSelfEffect(slot0)
	if slot0.lineStar then
		SetActive(slot0.lineStar.gameObject, slot0.data_.isEquiped)
	end
end

function slot0.ShowNextSpEffect(slot0)
	slot1 = AstrolabeTools.GetNextSPNodeIsEquiped(slot0.data_.id, slot0.info_.id)

	if slot0.posX == 3 then
		slot1 = AstrolabeTools.GetLastIsEquiped(slot0.data_.id, slot0.info_.id)
	end

	if slot0.lineStar2 then
		SetActive(slot0.lineStar2.gameObject, slot1)
	end
end

function slot0.ResetEffect(slot0)
	if slot0.lineStar2 then
		SetActive(slot0.lineStar2.gameObject, false)
	end

	if slot0.lineStar then
		SetActive(slot0.lineStar.gameObject, false)
	end
end

function slot0.ShowSpState(slot0, slot1)
	slot2 = slot0.curAnimator

	if slot1.isEquiped then
		slot0.curAnimator:Play("star_sp_2")

		slot0.nodeState = AstrolabeConst.NODE_STATE.EQUIPED
	elseif not slot1.isUnlock then
		slot0.nodeState = AstrolabeConst.NODE_STATE.LOCK

		slot0.curAnimator:Play("lock_sp_1")
	elseif slot1.isUnlock then
		slot0.curAnimator:Play("star_sp_1")

		slot0.nodeState = AstrolabeConst.NODE_STATE.UNLOCK
	end
end

function slot0.ShowSelect(slot0, slot1)
	if slot0.icon_selectGo_ then
		SetActive(slot0.icon_selectGo_, slot1)
	end
end

function slot0.Init(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.SetNodeNameIsHide(slot0, slot1)
	if slot0.textTm_ then
		SetActive(slot0.textTm_.gameObject, not slot1)
	end

	slot0:SetRedPoint(false)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.clickFunc = nil

	if slot0.gameObject_ then
		Object.Destroy(slot0.gameObject_)

		slot0.gameObject_ = nil
		slot0.transform_ = nil
	end
end

function slot0.OnClick(slot0)
	if slot0.clickFunc then
		slot0:clickFunc()
	end
end

function slot0.RemoveAllListeners(slot0)
	if slot0.gameObject_ and not isNil(slot0.gameObject_) then
		slot0.itemEventtriggerlistener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerClick)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.GetItemInfo(slot0)
	return slot0.data_
end

function slot0.SetRedPoint(slot0, slot1)
	if slot0.notice_imgGo_ then
		SetActive(slot0.notice_imgGo_, slot1)
	end
end

function slot0.SetProxy(slot0, slot1)
	slot0.heroViewProxy_ = slot1
end

return slot0
