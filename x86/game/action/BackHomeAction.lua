manager.notify:RegistListener(ZERO_REFRESH, function ()
	CanteenData:RefreshCanteenDailyZero()
	DormitoryData:RefreshDormDailyZero()
	BackHomeCricketBattleData:RefreshCricketBattleDailyZero()
	DormData:RefreshDailyZero()
end)

function slot1(slot0)
	return nullable(BackHomeCfg, slot0, "type")
end

function slot2(slot0)
	return slot0 == DormConst.BACKHOME_TYPE.PrivateDorm or slot0 == DormConst.BACKHOME_TYPE.PublicDorm or slot0 == DormConst.BACKHOME_TYPE.VISITPUBLICDORM or slot0 == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM
end

manager.net:Bind(58001, function (slot0)
	BackHomeDataManager:InitAllSampleData(slot0)
	DormRedPointTools:UpdataGlobalRedPoint()
end)

slot3, slot4 = nil

return {
	CheckToEnterDormScene = function (slot0, slot1)
		uv0:EnterDormMap(slot1)
	end,
	EnterDormMap = function (slot0, slot1)
		slot3 = uv0(slot1)

		DormData:SetCurrentScene(slot1)

		if uv1(uv0(DormData.GetInstance():GetCurrectSceneID())) and uv1(slot3) then
			slot4 = UnityEngine.Camera.main.transform
			slot5 = slot4.localPosition
			slot6 = slot4.localEulerAngles

			OnExitDormScene()

			if slot3 ~= slot2 then
				DormLuaBridge.ChangeDormScene(uv2:CreateDormDataForExchange(slot1), function ()
					OnEnterDormScene()
					manager.ui:SetMainCameraPos(uv0)
					manager.ui:SetMainCameraRot(uv1)
				end)
			else
				slot7()
			end

			return
		end

		StartDormMode(uv2:CreateDormDataForExchange(slot1))
	end,
	CreateDormDataForExchange = function (slot0, slot1)
		slot2 = GetDormDataForExcehange()
		slot3 = BackHomeCfg[slot1]
		slot2.sceneName = slot3.scene
		slot2.dormMapCfg = BackHomeCfg.AllMapCfg

		if slot3.type == DormConst.BACKHOME_TYPE.VISITPUBLICDORM then
			slot2.sceneType = DormConst.BACKHOME_TYPE.PublicDorm
		elseif slot3.type == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
			slot2.sceneType = DormConst.BACKHOME_TYPE.PrivateDorm
		else
			slot2.sceneType = slot3.type
		end

		slot2.furnitureConfigs = BackHomeFurniture.AllFurnitureConfig
		slot2.mapFurnitureInfoS = RoomInfo.New()
		slot2.mapFurnitureInfoS.id = slot1
		slot2.mapFurnitureInfoS.sceneName = slot3.scene
		slot2.mapFurnitureInfoS.furnitureInfoS = DormData:GetDormSceneData(slot1).roomInfo.furnitureInfoS

		return slot2
	end,
	GetAllDetailInfo = function (slot0, slot1, slot2)
		uv0 = slot2
		uv1 = slot1

		manager.net:SendWithLoadingNew(58002, {
			nothing = 1
		}, 58003, uv2.GetAllDetailInfoCallBack)
	end,
	GetAllDetailInfoCallBack = function (slot0)
		if isSuccess(slot0.result) then
			BackHomeDataManager:InitAllDetailData(slot0)
			DormRedPointTools:UpdataGlobalRedPoint()

			if uv0 then
				uv0(uv1)

				uv0 = nil
				uv1 = nil
			end
		else
			print("获取后宅详情失败")
		end
	end
}
