slot0 = class("AstrolabeItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.transform_.localPosition = Vector3(0, 0, 0)
	slot0.posX = slot3

	slot0:InitUI()
	slot0:Init()

	slot0.nodeState = AstrolabeConst.NODE_STATE.LOCK
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.info_ = slot2

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
	slot0.activeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "name")
	slot0.selectController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "select")

	slot0:ShowSelect(false)
	slot0:AddBtnListener(slot0.nodeitemBtn_, nil, "OnClick")
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.info_ = slot1

	if slot1 then
		if not slot1.isUnlock then
			if slot1.isCanLock then
				slot0.nodeState = AstrolabeConst.NODE_STATE.CANLOCK

				slot0.activeController_:SetSelectedState("canUnlock")
			else
				slot0.activeController_:SetSelectedState("lock")

				slot0.nodeState = AstrolabeConst.NODE_STATE.LOCK
			end
		elseif slot1.isUnlock then
			slot0.activeController_:SetSelectedState("unlock")

			slot0.nodeState = AstrolabeConst.NODE_STATE.UNLOCK
		end

		if not slot0.heroViewProxy_.isSelf then
			slot0.activeController_:SetSelectedState("unlock")

			slot0.nodeState = AstrolabeConst.NODE_STATE.UNLOCK
		end

		if slot1.isEquiped then
			if slot0.posX == 1 then
				slot0.stateController_:SetSelectedState("red")
			elseif slot0.posX == 2 then
				slot0.stateController_:SetSelectedState("yellow")
			elseif slot0.posX == 3 then
				slot0.stateController_:SetSelectedState("bule")
			end

			slot0.nodeState = AstrolabeConst.NODE_STATE.EQUIPED
		else
			slot0.stateController_:SetSelectedState("gray")
		end

		slot0.nameText_.text = GetI18NText(HeroAstrolabeCfg[slot1.id].name)
	end
end

function slot0.ShowSelect(slot0, slot1)
	slot0.selectController_:SetSelectedState(slot1 and "true" or "false")
end

function slot0.Init(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.SetNodeNameIsHide(slot0, slot1)
	if slot0.nameText_ then
		SetActive(slot0.nameText_.gameObject, not slot1)
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.clickFunc = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnClick(slot0)
	if slot0.clickFunc then
		if not slot0.heroViewProxy_.isSelf then
			return
		end

		slot0:clickFunc()
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.GetItemInfo(slot0)
	return slot0.info_
end

function slot0.SetRedPoint(slot0, slot1)
	SetActive(slot0.notice_imgGo_, slot1)
end

function slot0.SetProxy(slot0, slot1)
	slot0.heroViewProxy_ = slot1
end

return slot0
