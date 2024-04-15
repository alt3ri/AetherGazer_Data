slot0 = class("LoginSeverSelectPopItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController = slot0.m_controller:GetController("select")
	slot0.playerController = slot0.m_controller:GetController("player")
	slot0.maintainController = slot0.m_controller:GetController("maintain")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_btn, function ()
		_G.SELECT_REGION_SEVER_ID = uv0.data.serverId

		manager.notify:CallUpdateFunc(LOGIN_SEVER_UPDATE)
		PlayerPrefs.SetString("RegionServerId", uv0.data.serverId)
		uv0:Back()
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.data = slot1
	slot0.m_serverName.text = slot1.serverName

	if slot1.maintain then
		slot0.maintainController:SetSelectedIndex(1)
	else
		slot0.maintainController:SetSelectedIndex(0)
	end

	if slot1.serverId == _G.SELECT_REGION_SEVER_ID then
		slot0.selectController:SetSelectedIndex(1)
	else
		slot0.selectController:SetSelectedIndex(0)
	end

	if slot1.player and GetSDKLoginInfo() then
		slot0.playerController:SetSelectedIndex(1)

		slot0.m_playerName.text = slot1.player.nickName
		slot0.m_playerLv.text = GetTipsF("REGION_SERVER_PLAYER_LEVEL", slot1.player.currentLevel)
	else
		slot0.playerController:SetSelectedIndex(0)
	end

	if slot1.newServerFlag == 1 then
		SetActive(slot0.m_newTag, true)
	else
		SetActive(slot0.m_newTag, false)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
