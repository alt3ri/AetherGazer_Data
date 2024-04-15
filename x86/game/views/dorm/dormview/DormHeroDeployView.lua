slot0 = class("DormHeroDeployView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dorm/DormPersonnelAllocationUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.characterScroll = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, DormCharacterItem)
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.allCharacterController = ControllerUtil.GetController(slot0.quickRecall.transform, "useState")
end

function slot1()
	return Dorm.storage:GetData(DormCharacterManager.curGrabbingInfoNamespace, "eid")
end

function slot2(slot0)
	return DormUtils.GetEntityData(slot0).cfgID
end

function slot0.IndexOf(slot0, slot1)
	return table.indexof(slot0.dataList_, slot0.heroID)
end

function slot0.OnEnter(slot0)
	slot0.roomID = DormData:GetCurrectSceneID()

	if BackHomeCfg[slot0.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		slot0.maxNum = GameSetting.dorm_lobby_hero_max.value[1]

		slot0.stateController:SetSelectedState("public")
	else
		slot0.maxNum = DormConst.PRIVATE_CHARACTER_MAX_NUM

		slot0.stateController:SetSelectedState("private")
	end

	slot0.maxnumText_.text = "/" .. slot0.maxNum

	slot0:RefreshDormHeroList()
	slot0:RegisterEvents()
	slot0:RefreshPlaceHeroNum()

	slot0.postStartHandle = FrameTimer.New(function ()
		uv0.curGrabbing = uv1()

		if uv0.curGrabbing then
			uv0.selHeroID = uv2(uv0.curGrabbing)

			if uv0:IndexOf(uv0.curGrabbing) then
				uv0.characterScroll:ScrollToIndex(slot0, false, true, 0.2)
			end

			uv0.uilistSrex_.horizontal = false
		else
			uv0.selHeroID = nil
			uv0.uilistSrex_.horizontal = true
		end

		uv0.characterScroll:Refresh()

		uv0.postStartHandle = nil
	end, 1, false)

	slot0.postStartHandle:Start()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()

	if slot0.postStartHandle then
		slot0.postStartHandle:Stop()

		slot0.postStartHandle = nil
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:ShowMaskCallBack(function (slot0)
		if DormData:GetHeroTemplateInfo(slot0) then
			if slot1:GetHeroState() == DormEnum.DormHeroState.InCanteenEntrust or slot2 == DormEnum.DormHeroState.InCanteenJob then
				return true
			end

			if (slot2 == DormEnum.DormHeroState.InPublicDorm or slot2 == DormEnum.DormHeroState.InPrivateDorm) and slot1.hero_id ~= slot0 then
				return true
			end

			return false
		end
	end)
	slot2:RefreshUI(slot0.dataList_[slot1], slot0.selHeroID, slot1)
	slot2:InDragFunc(function (slot0)
		uv0.selHeroID = uv0.curGrabbing and uv1(uv0.curGrabbing) or slot0

		uv0.characterScroll:Refresh()
	end)
	slot2:RecallHero(function (slot0)
		if DormData:GetCurrectSceneID() == DormConst.PUBLIC_DORM_ID then
			slot3 = {}

			for slot9, slot10 in ipairs(DormitoryData:GetDormHerosByArchitecture(slot1)) do
				if slot10 ~= DormData:GetHeroTemplateInfo(slot0):GetHeroId() then
					table.insert(slot3, slot10)
				end
			end

			DormAction:DeployHeroInRoom(slot1, slot3, DormEnum.DormDeployType.ReCall)
		elseif slot1 then
			DormAction:RecallHeroInPrivateDorm(slot1, slot0)
		end
	end)
end

function slot3()
	if nullable(GameDisplayCfg.dorm_hero_first_set_dialogue, "value") then
		for slot5, slot6 in ipairs(slot0) do
			slot1 = 0 + slot6[2]
		end

		for slot6, slot7 in ipairs(slot0) do
			if math.random() * slot1 - slot7[2] < 0 then
				return slot7[1]
			end
		end
	end

	return 0
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_REFRESH_HERO_DEPLOY_LIST, function ()
		uv0.characterScroll:Refresh()
		uv0:RefreshPlaceHeroNum()
	end)
	slot0:RegistEventListener(DORM_CUR_GRABBING_CHARACTER_CHANGE, function (slot0, slot1)
		if slot1 then
			DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.UpCharacter)

			uv1.selHeroID = uv0(slot1)
			uv1.uilistSrex_.horizontal = false
			uv1.curGrabbing = slot1
		else
			DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.DownCharacter)

			uv1.uilistSrex_.horizontal = true

			if uv2() ~= 0 then
				manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, slot0, slot2)
			end

			uv1.curGrabbing = nil
		end

		uv1.characterScroll:Refresh()
	end)
	slot0:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, function ()
		uv0.characterScroll:Refresh()
	end)
end

function slot0.AddUIListener(slot0)
	slot0.uilistSrex_.ExitScrollArea:AddListener(function ()
		if uv0.curGrabbing then
			return
		end

		if uv0.selHeroID then
			if DormData:GetHeroInfo(DormData:GetHeroArchiveID(uv0.selHeroID)):GetHeroState() == DormEnum.DormHeroState.InCanteenEntrust or DormEnum.DormHeroState.InCanteenJob == slot2 then
				ShowTips(GetTips("DORM_HERO_WORK_IN_CANTEEN"))

				return
			end

			if uv0:CheckCharacterNumMax() then
				slot3 = DormData:GetCurrectSceneID()
				slot4 = DormitoryData:GetDormHerosByArchitecture(slot3)
				slot5 = DormitoryData:GetDormArchivesByArchitecture(slot3)

				if BackHomeCfg[slot3].type == DormConst.BACKHOME_TYPE.PublicDorm then
					for slot9, slot10 in ipairs(slot5) do
						if slot10 == slot0 then
							ShowTips(GetTips("DORM_HERO_SAME_SET"))

							return
						end
					end

					slot6 = {}

					for slot10, slot11 in ipairs(slot4) do
						table.insert(slot6, slot11)
					end

					table.insert(slot6, uv0.selHeroID)
					DormHeroTools:GenerateHeroByDrag(uv0.selHeroID)
					DormAction:DeployHeroInRoom(slot3, slot6, DormEnum.DormDeployType.Place)
				elseif BackHomeCfg[slot3].type == DormConst.BACKHOME_TYPE.PrivateDorm then
					if slot2 == DormEnum.DormHeroState.InPublicDorm or slot2 == DormEnum.DormHeroState.OutDorm then
						DormHeroTools:GenerateHeroByDrag(uv0.selHeroID)
						DormAction:RecallHeroInPrivateDorm(slot3, uv0.selHeroID)

						return
					elseif slot2 == DormEnum.DormHeroState.InPrivateDorm then
						ShowTips(GetTips("DORM_HERO_SAME_SET"))

						return
					end
				end
			else
				ShowTips(GetTips("DORM_LOBBY_SET_MAX"))
			end
		end
	end)
	slot0:AddBtnListenerScale(slot0.backBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListenerScale(slot0.quickRecall, nil, function ()
		if #DormitoryData:GetDormHerosByArchitecture(DormData:GetCurrectSceneID()) > 0 then
			DormHeroTools:RecallAllHero(slot1)
		else
			ShowTips("DORM_NO_HERO_RECALL")
		end
	end)
end

function slot0.GetDormHeroList(slot0)
	slot1 = {}
	slot1 = DormHeroTools:GetBackHomeCanUseHeroList(slot0 or DormData:GetCurrectSceneID())

	CommonTools.UniversalSortEx(slot1, {
		ascend = true,
		map = function (slot0)
			if DormData:GetHeroTemplateInfo(slot0):GetHeroState() == DormEnum.DormHeroState.InPublicDorm then
				return 1
			elseif slot1 == DormEnum.DormHeroState.OutDorm then
				return 2
			elseif slot1 == DormEnum.DormHeroState.InPrivateDorm then
				return 3
			elseif slot1 == DormEnum.DormHeroState.InCanteenJob then
				if DormData:GetHeroTemplateInfo(slot0).jobType == DormNpcTools.BackHomeNpcType.cook then
					return 4
				elseif slot2 == DormNpcTools.BackHomeNpcType.waiter then
					return 5
				elseif slot2 == DormNpcTools.BackHomeNpcType.cashier then
					return 6
				end
			elseif slot1 == DormEnum.DormHeroState.InCanteenEntrust then
				return 7
			elseif slot1 == DormEnum.DormHeroState.InIdolTraineeCamp then
				return 8
			end
		end
	}, {
		ascend = true,
		map = function (slot0)
			return DormData:GetHeroTemplateInfo(slot0):GetFatigue()
		end
	}, {
		map = function (slot0)
			return DormData:GetHeroArchiveID(slot0)
		end
	}, {
		map = function (slot0)
			return slot0
		end
	})

	return slot1
end

function slot0.RefreshDormHeroList(slot0)
	slot0.dataList_ = uv0.GetDormHeroList()

	slot0.characterScroll:StartScroll(#slot0.dataList_)
end

function slot0.CheckCharacterNumMax(slot0)
	if BackHomeCfg[slot0.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		if DormitoryData:GetDormSceneData(slot0.roomID).archiveIDList then
			if slot0.maxNum <= #slot1 or slot0.maxNum <= (DormCharacterManager.GetInstance():GetCharacterNum() or 0) then
				return false
			else
				return true
			end
		end
	else
		return true
	end
end

function slot0.RefreshPlaceHeroNum(slot0)
	if BackHomeCfg[slot0.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		if DormitoryData:GetDormSceneData(slot0.roomID).archiveIDList then
			slot0.curnumText_.text = #slot1
		else
			slot0.curnumText_.text = 0
		end

		slot2 = false

		for slot6, slot7 in ipairs(slot1) do
			if GameSetting.canteen_hero_fatigue_max.value[1] <= DormData:GetHeroFatigue(slot7) then
				slot2 = true

				break
			end
		end

		if slot2 then
			slot0.allCharacterController:SetSelectedState("true")
		else
			slot0.allCharacterController:SetSelectedState("false")
		end
	elseif DormData:GetHeroInfo(DormitoryData:GetDormSceneData(slot0.roomID).archiveIDList[1]):GetHeroState() == DormEnum.DormHeroState.InPrivateDorm then
		slot0.curnumText_.text = 1
	else
		slot0.curnumText_.text = 0
	end
end

function slot0.Dispose(slot0)
	if slot0.characterScroll then
		slot0.characterScroll:Dispose()
	end

	slot0.uilistSrex_.ExitScrollArea:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
