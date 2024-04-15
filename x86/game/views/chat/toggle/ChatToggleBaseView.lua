slot0 = class("ChatToggleBaseView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.chatToggleID_ = slot3

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "name")
	slot0.text_.text = ChatToggleCfg[slot0.chatToggleID_].name
	slot0.text2_.text = ChatToggleCfg[slot0.chatToggleID_].name
end

function slot0.AddListeners(slot0)
	slot0:AddToggleListener(slot0.toggle_, function (slot0)
		if slot0 then
			uv0:OnClickToggle()
		end
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
	slot0.lockController_:SetSelectedState(tostring(slot0:IsLock()))
end

function slot0.IsOn(slot0)
	slot0.toggle_.isOn = true
end

function slot0.OnClickToggle(slot0)
	slot0:Go("chat", {
		chatToggleID = slot0.chatToggleID_
	})
end

function slot0.IsLock(slot0)
	return false
end

return slot0
