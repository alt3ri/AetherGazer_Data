slot0 = class("PushBoxItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.dirctMap_ = {
		"up",
		"right",
		"down",
		"left"
	}
	slot0.selectCon_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.AddUIListeners(slot0)
	slot0:AddPressByTimeListener(slot0.gameObject_, 0.1, function ()
		manager.notify:Invoke(PUSH_BOX_SELECT, uv0.index_)
	end, function (slot0, slot1, slot2)
		manager.notify:Invoke(PUSH_BOX_SELECT, uv0.index_)

		uv0.pressPos_ = slot1.position
	end, function (slot0, slot1, slot2)
		uv0.endPos_ = slot1.position

		if uv0.dragFunc_ then
			uv0.dragFunc_(uv0.pressPos_, uv0.endPos_)
		end
	end, slot0.index_)
end

function slot0.OnEnter(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.isLock_ = false
	slot0.index_ = slot1

	slot0:StopAni()
end

function slot0.SetPos(slot0, slot1, slot2, slot3, slot4)
	slot0.dirct_ = 0
	slot0.coordinateX_ = slot1
	slot0.coordinateY_ = slot2
	slot0.transform_.localPosition = Vector3.New(slot3, slot4, slot0.transform_.localPosition.z)
end

function slot0.GetCoordinate(slot0)
	return slot0.coordinateX_, slot0.coordinateY_
end

function slot0.SetSelect(slot0, slot1)
	slot0.selectCon_:SetSelectedState(slot1 and "click" or "normal")

	if slot1 then
		slot2, slot3, slot4, slot5 = PushBoxTool:GetCanPassDir(slot0.index_)

		SetActive(slot0.uGo_, slot2)
		SetActive(slot0.dGo_, slot3)
		SetActive(slot0.lGo_, slot4)
		SetActive(slot0.rGo_, slot5)
	end
end

function slot0.StopAni(slot0)
	slot0.dirct_ = 0

	slot0.ani_:Play("idle", -1, 0)
end

function slot0.PlayDirct(slot0, slot1)
	slot0.selectCon_:SetSelectedState("normal")

	slot2 = 0

	if slot1[1] == 0 and slot1[2] == 1 then
		slot2 = 1
	elseif slot3 == 1 and slot4 == 0 then
		slot2 = 2
	elseif slot3 == 0 and slot4 == -1 then
		slot2 = 3
	elseif slot3 == -1 and slot4 == 0 then
		slot2 = 4
	end
end

function slot0.SetLock(slot0, slot1)
	slot0.isLock_ = slot1
end

function slot0.IsLock(slot0)
	return slot0.isLock_
end

function slot0.GetCoordinate(slot0)
	return slot0.coordinateX_, slot0.coordinateY_
end

function slot0.SetSize(slot0, slot1)
	slot2 = slot1 / slot0.transform_.rect.width
	slot0.rect_.localScale = Vector2.New(slot2, slot2)
end

function slot0.RegistDragFunc(slot0, slot1)
	slot0.dragFunc_ = slot1
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
