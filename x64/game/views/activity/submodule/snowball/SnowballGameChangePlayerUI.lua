slot0 = class("SnowballGameChangePlayerUI", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/JapanRegionSnowballCharacterChangeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot1()
	gameContext:Go("/snowballGameLevelUI", nil, true, false)
end

slot2 = Dorm.DormEntityManager.PutEntityAt

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AdaptScreen()
	slot0:InitHeroHeadIcons()

	slot0.changeController = ControllerUtil.GetController(slot0.transform_, "change")

	slot0:AddBtnListener(slot0.changeBtn_, nil, function ()
		SnowballGameData:SetLastSelectedPlayer(uv0.select)
		uv1(SnowballGameMgr.GetInstance():GetPlayerEID(), uv0.originalPos)
		uv2()
	end)
end

function slot0.OnEnter(slot0)
	slot1 = SnowballGameMgr.GetInstance()
	slot0.currentPlayer = slot1:GetPlayerCfgID()
	slot0.select = slot0.currentPlayer
	slot0.playerPos = Dorm.storage:PickData("snowball.pos.changePlayer").transform
	slot0.originalPos = slot1.playerSpawnPos

	uv0(slot1:GetPlayerEID(), slot0.playerPos)
	slot0:RefreshUI()
	slot0:StartTimer()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:StopTimer()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		if uv0.currentPlayer ~= uv0.select then
			SnowballGameMgr.GetInstance():SetPlayer(uv0.currentPlayer)
		else
			uv1(slot0:GetPlayerEID(), uv0.originalPos)
		end

		uv2()
	end)
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.InitHeroHeadIcons(slot0)
	slot0.heroBtnList = {}

	for slot6, slot7 in ipairs(SnowballGameUnitCfg.get_id_list_by_unit_type[0]) do
		slot8 = GameObject.Instantiate(slot0.headIconPrefab_, slot0.headIconRoot_)
		slot9 = {
			gameObject_ = slot8
		}

		slot0:BindCfgUI(slot8, slot9)

		slot9.id = slot7
		slot9.modeController = ControllerUtil.GetController(slot8.transform, "mode")

		slot0:AddBtnListener(slot9.btn_, nil, function ()
			if uv0.select == uv1 then
				return
			end

			uv0.select = uv1

			uv0:SetPlayer()
		end)
		table.insert(slot0.heroBtnList, slot9)
	end
end

function slot0.RefreshUI(slot0)
	for slot4, slot5 in pairs(slot0.heroBtnList) do
		if slot5.id == slot0.select then
			slot5.modeController:SetSelectedState("select")
		elseif slot5.id == slot0.currentPlayer then
			slot5.modeController:SetSelectedState("current")
		else
			slot5.modeController:SetSelectedState("normal")
		end

		slot5.icon_.sprite = getSpriteWithoutAtlas(SnowballGameUnitCfg[slot5.id].head_image)
	end

	slot0.changeController:SetSelectedState(slot0.select and slot0.select ~= slot0.currentPlayer and "enable" or "disable")
	slot0:SetHeroInfo(slot0.select)
	slot0:RefreshTimeText()
end

function slot0.SetHeroInfo(slot0, slot1)
	if slot1 == nil then
		return
	end

	slot0.name_.text = SnowballGameUnitCfg[slot1].name
	slot3 = SnowballGameUnitCfg[slot1]
	slot0.powerBar_.fillAmount = slot3.ready_show
	slot0.speedBar_.fillAmount = slot3.speed_show
	slot0.reloadBar_.fillAmount = slot3.cd_show
	slot0.accBar_.fillAmount = slot3.hit_show
end

function slot0.SetPlayer(slot0)
	slot1 = SnowballGameMgr.GetInstance()

	slot1:SetPlayer(slot0.select)
	uv0(slot1:GetPlayerEID(), slot0.playerPos)
	slot0:RefreshUI()
end

function slot0.RefreshTimeText(slot0)
	slot0.activityCountdown_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(SnowballGameData.activityID).stopTime, nil, true)
end

function slot0.StartTimer(slot0)
	slot0:StopTimer()

	slot0.timer = Timer.New(function ()
		uv0:RefreshTimeText()
	end, 1, -1)

	slot0.timer:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end
end

return slot0
