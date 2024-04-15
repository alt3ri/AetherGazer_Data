ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("StrongholdHomeView", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/StrongholdHomeUI"
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_statrBtn, nil, function ()
		if not uv0:IsActivityTime() then
			return
		end

		JumpTools.GoToSystem("/cooperationBlank/strongholdMain")
	end)
	slot0:AddBtnListener(slot0.m_tipBtn, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_STRONGHOLD_DES"),
			key = uv0.gameHelpKey
		})
	end)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
end

return slot0
