slot0 = class("GuildHeadIconSelect", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Club/ClubSelect"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller = ControllerUtil.GetController(slot0.transform_, "club")
end

function slot0.OnEnter(slot0)
	slot0.selectID_ = slot0.params_.selectID

	slot0.controller:SetSelectedState(tostring(slot0.selectID_))
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonCancel_, nil, function ()
		uv0:Back()
	end)

	slot4 = slot0.buttonOk_

	slot0:AddBtnListener(slot4, nil, function ()
		manager.notify:Invoke(GUILD_SWITCH_HEAD_ICON, uv0.selectID_)
		uv0:Back()
	end)

	for slot4 = 1, 5 do
		slot0:AddBtnListener(slot0["icon0" .. slot4 .. "Btn_"], nil, function ()
			uv0.controller:SetSelectedState(tostring(uv1))
			uv0:SelectHeadIcon(uv1)
		end)
	end
end

function slot0.SelectHeadIcon(slot0, slot1)
	slot0.selectID_ = slot1
end

return slot0
