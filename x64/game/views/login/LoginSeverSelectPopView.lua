slot0 = class("LoginSeverSelectPopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/LoginInterface/LoginInterfaceServerPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, LoginSeverSelectPopItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_backBtn, function ()
		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
end

function slot0.OnEnter(slot0)
	slot0.server_data_list = {}

	for slot6 = 0, RegionServerMgr.instance:GetRegionServerInfoList().Count - 1 do
		slot7 = slot1[slot6]

		if slot7.gameUserInfoList.Count > 0 then
			slot10 = slot9[0]
		end

		table.insert(slot0.server_data_list, {
			serverName = slot7.serverName,
			maintain = slot7.maintain,
			newServerFlag = slot7.newServerFlag,
			serverId = slot7.serverId,
			player = {
				nickName = slot10.nickName,
				currentLevel = slot10.currentLevel,
				uid = slot10.uid,
				lastLoginTime = slot10.lastLoginTime
			}
		})
	end

	slot0.list:StartScroll(#slot0.server_data_list)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.server_data_list[slot1])
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
