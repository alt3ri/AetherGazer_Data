manager.net:Bind(30099, function (slot0)
	BulletinAction.BulletinRefresh(slot0)

	slot1 = {}

	for slot5, slot6 in ipairs(BulletinData.GetBulletinIDList()) do
		for slot10, slot11 in ipairs(slot6) do
			table.insert(slot1, tostring(slot11))
		end
	end

	BulletinBoardMgr.inst:ClearCache(slot1)
end)
manager.notify:RegistListener(BULLETIN_QUITBATTLE, function ()
	manager.rollTips:TryToCreatTips()
end)

return {
	BulletinRefresh = function (slot0)
		BulletinData.refreshBulletin(slot0)
		uv0.UpdateUnread()

		if slot0 then
			for slot4, slot5 in ipairs(slot0.announcement_list) do
				if slot5.type == 103 then
					for slot9, slot10 in pairs(slot5.content) do
						if slot10.content_type == 2 then
							slot11 = SceneManager.GetActiveScene().name

							if GetIsInMainScene() then
								if BulletinData.GetIslogin() then
									BulletinData.SetCacheString(slot5.id, slot10.text)
									manager.rollTips:CountTipsAndCreate(slot10.text, slot5.id)
								else
									manager.rollTips:SetCachePop(true)
									BulletinData.SetCacheString(slot5.id, slot10.text)
								end
							else
								manager.rollTips:SetCachePop(true)
								BulletinData.SetCacheString(slot5.id, slot10.text)
							end
						end
					end
				end
			end
		end
	end,
	BulletinDelete = function (slot0)
		BulletinData.deleteBulletin({
			id = slot0
		})
		uv0.UpdateUnread()
		manager.notify:CallUpdateFunc(ON_BULLETIN_DELETE, BulletinData.GetBulletinPageList()[slot0])
	end,
	BulletinRead = function (slot0)
		BulletinData.SetReadFlagById(slot0)
		BulletinData.SetReadFlag(not BulletinData.GetReadFlag())
		uv0.UpdateUnread()
	end,
	UpdateUnread = function ()
		slot1 = 0
		slot3 = 0
		slot4 = 0

		for slot8, slot9 in pairs(BulletinData.GetBulletinPageList()) do
			if not getData("bulletin", "bulletin_" .. slot9.id) and manager.time:GetServerTime() < slot9.endTime then
				if slot9.type == 101 then
					slot2 = 0 + 1
				elseif slot9.type == 102 then
					slot3 = slot3 + 1
				elseif slot9.type == 104 then
					slot4 = slot4 + 1
				end
			end
		end

		manager.redPoint:setTip(RedPointConst.BULLETIN_UNREAD_101, slot2)
		manager.redPoint:setTip(RedPointConst.BULLETIN_UNREAD_102, slot3)
		manager.redPoint:setTip(RedPointConst.BULLETIN_UNREAD_104, slot4)

		return slot1
	end,
	OpenOperationUrl = function (slot0)
		slot3 = ""

		if GameToSDK.PLATFORM_ID == 1 then
			Application.OpenURL(string.format(slot0, PlayerData:GetPlayerInfo().userID, PlayerData:GetPlayerInfo().signUserId))
		else
			FrameTimer.New(function ()
				LuaForUtil.OpenWebView(uv0, true, function ()
					print("--->> open webView to portrait")
				end, function ()
					print("====>>> close webView recover")
				end)
			end, 6, 1):Start()
		end
	end
}
