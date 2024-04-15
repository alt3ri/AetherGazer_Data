slot0 = class("HardLevelBaseItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.hardLevel_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.lockController_ = slot0.controllerEx_:GetController("lock")
end

function slot0.OnEnter(slot0)
	slot0:IsLock()
	slot0:RefreshItem()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.isLock_ then
			uv0:LockTips()

			return
		end

		uv0:ClickBtn()
	end)
end

function slot0.LockTips(slot0)
	ShowTips("ERROR_FUNCTION_NOT_OPEN")
end

function slot0.ClickBtn(slot0)
end

function slot0.RefreshItem(slot0)
	slot0.lockController_:SetSelectedState(tostring(slot0.isLock_))

	slot0.hardText_.text = GetTips(BattleConst.HARD_LANGUAGE[slot0.hardLevel_])
end

function slot0.SetSiblingIndex(slot0, slot1)
	slot0.transform_:SetSiblingIndex(slot1)
end

function slot0.IsLock(slot0)
	slot0.isLock_ = false
end

return slot0
