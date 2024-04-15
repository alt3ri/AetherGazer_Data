manager.net:Bind(12011, function (slot0)
	GuideData:InitGuideData(slot0)
end)
manager.net:Bind(12111, function (slot0)
	GuideData:InitWeakGuideData(slot0)
end)

slot1 = {}

return {
	GuideUpdateID = function (slot0)
		if not GuideData:IsFinish(slot0) then
			GuideData:FinishGuideID(slot0)
			manager.net:SendWithLoadingNew(12012, {
				mod_guide_id = slot0
			}, 12013)
		end
	end,
	GuideUpdateIDEnd = function (slot0, slot1)
		uv0[slot0] = slot1

		GuideData:FinishGuideID(slot0)
		manager.net:SendWithLoadingNew(12012, {
			mod_guide_id = slot0
		}, 12013, NewPlayerGuideAction.OnGuideUpdateIDEndCallBack)
	end,
	OnGuideUpdateIDEndCallBack = function (slot0, slot1)
		SDKTools.SendMessageToSDK("guide_complete", {
			guide_id = slot1.mod_guide_id,
			use_time = uv0[slot1.mod_guide_id] or 0
		})
	end,
	FinishWeakGuide = function (slot0)
		if not GuideData:IsWeakGuideFinish(slot0) then
			GuideData:FinishWeakGuideID(slot0)
			manager.net:SendWithLoadingNew(12112, {
				mod_guide_id = slot0
			}, 12113)
		end
	end,
	GuideUpdateNode = function (slot0)
	end
}
