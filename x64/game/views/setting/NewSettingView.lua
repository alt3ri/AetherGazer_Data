slot0 = class("SettingView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Setting/SettingUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.selectIndex = -1
	slot0.pages = {}
end

function slot0.OnPicSettingChange(slot0, slot1, slot2)
	if slot0.pages.Graphic then
		slot0.pages.Graphic:OnPicSettingChange(slot1, slot2)
	end
end

function slot0.OnSoundSettingChange(slot0, slot1, slot2)
	if slot0.pages.Sound then
		slot0.pages.Sound:OnSoundSettingChange(slot1, slot2)
	end

	if slot0.pages.Game then
		slot0.pages.Game:OnSoundSettingChange(slot1, slot2)
	end
end

function slot0.OnPushSettingChange(slot0, slot1, slot2)
end

function slot0.OnGameSettingChange(slot0, slot1, slot2)
	if slot0.pages.Game then
		slot0.pages.Game:OnGameSettingChange(slot1, slot2)
	end
end

function slot0.OnDownloaded(slot0, slot1)
	if slot0.pages.Sound then
		slot0.pages.Sound:OnDownloaded(slot1)
	end
end

function slot0.OnCancalDownload(slot0)
	if slot0.pages.Sound then
		slot0.pages.Sound:OnCancalDownload()
	end
end

function slot0.OnRemindChange(slot0, slot1, slot2)
	if slot0.pages.Remind then
		slot0.pages.Remind:OnRemindChange(slot1, slot2)
	end
end

function slot0.OnCooperationRestrictUpdate(slot0, slot1, slot2)
	if slot0.pages.Remind then
		slot0.pages.Remind:OnCooperationRestrictUpdate()
	end
end

function slot0.OnPolyhedronSwitchHero(slot0)
	if slot0.pages.PolyhedronTeamInfo then
		slot0.pages.PolyhedronTeamInfo:OnPolyhedronSwitchHero()
	end
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.toggleList = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, SettingToggleItem)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListenerScale(slot0.resetBtn_, nil, function ()
		uv0.curPage:RecoverTmpData()
	end)
	slot0:AddBtnListenerScale(slot0.resetDefBtn_, nil, function ()
		if uv0.curPage.ResetDefaultData then
			uv0.curPage:ResetDefaultData()
		end
	end)
	slot0:AddBtnListenerScale(slot0.quitBattleBtn_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_BATTLE"),
			OkCallback = function ()
				gameContext:DestroyCurRoutes()

				if uv0.params_.stageData:GetIsCooperation() then
					CooperationAction.LeaveCooperationBattle(function (slot0)
						BattleInstance.QuitBattle(uv0.params_.stageData, true, true)
					end, BattleFieldData:GetServerBattleID())
				else
					LuaExchangeHelper.GameOver(3)
				end
			end
		})
	end)
	slot0:AddBtnListenerScale(slot0.restartBtn_, nil, function ()
		manager.audio:DestoryCriAtom()
		BattleController.GetInstance():LaunchBattle(uv0.params_.stageData)
	end)
	slot0:AddBtnListenerScale(slot0.polyhedronSettlementBtn_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("POLYHEDRON_BATTLE_GIVE_UP_AND_SETTLE"),
			OkCallback = function ()
				PolyhedronAction.QueryPolyhedronGiveUp(function (slot0)
					if isSuccess(slot0.result) then
						manager.audio:PlayBGM("ui_battle", "ui_battle_lose", "ui_battle.awb")
						manager.audio:PlayEffect("ui_battle", "ui_battle_ultimate_out", "")
						manager.audio:PlayEffect("ui_skip", "ui_reset", "")
						AudioManager.Instance:DestoryPlayer("effect")
						DestroyLua()
						LuaExchangeHelper.GoToMain()
						OpenPageUntilLoaded("/polyhedronBlank/polyhedronOver", {})
					else
						ShowTips(slot0.result)
					end
				end)
			end
		})
	end)
	slot0:AddBtnListenerScale(slot0.polyhedronQuitBtn_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_BATTLE"),
			OkCallback = function ()
				manager.audio:PlayBGM("ui_battle", "ui_battle_lose", "ui_battle.awb")
				manager.audio:PlayEffect("ui_battle", "ui_battle_ultimate_out", "")
				manager.audio:PlayEffect("ui_skip", "ui_reset", "")
				AudioManager.Instance:DestoryPlayer("effect")
				DestroyLua()
				LuaExchangeHelper.GoToMain()
				OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
			end
		})
	end)
end

function slot0.OnTop(slot0)
	slot0:RefreshQuitType()
end

function slot0.OnEnter(slot0)
	slot0.toggles = slot0:GetToggleList()

	table.sort(slot0.toggles, function (slot0, slot1)
		return slot0:Order() < slot1:Order()
	end)
	slot0:RefreshBtns()
	slot0.toggleList:StartScroll(#slot0.toggles)
	slot0:SetSelectPage(1)
	slot0:RefreshQuitType()
end

function slot0.OnExit(slot0)
	for slot4, slot5 in pairs(slot0.pages) do
		slot5:OnExit()
	end

	if slot0.isSystem_ then
		manager.windowBar:HideBar()
	else
		manager.windowBar:HideBar()
		LuaExchangeHelper.ApplyBattleSetting()
	end

	slot0.isSystem_ = nil

	slot0:RecordStay(slot0.params_.selectType)
end

function slot0.RecordStay(slot0, slot1)
	if slot0:GetStayTime() == 0 then
		return
	end

	slot3 = 0

	if slot1 == "screen" then
		OperationRecorder.RecordStayView("STAY_VIEW_SETTING", slot2, 10201)
	elseif slot1 == "sound" then
		OperationRecorder.RecordStayView("STAY_VIEW_SETTING", slot2, 10202)
	elseif slot1 == "game" then
		OperationRecorder.RecordStayView("STAY_VIEW_SETTING", slot2, 10203)
	elseif slot1 == "skill" then
		slot0:RecordStaySkill(slot0.pages.skill and slot0.pages.skill.nType or 1)
	end

	slot0:UpdateLastOpenTime()
end

function slot0.RecordStaySkill(slot0, slot1)
	if slot0:GetStayTime() == 0 then
		return
	end

	slot3 = 0

	if slot1 == 1 then
		slot3 = 50201
	elseif slot1 == 2 then
		slot3 = 50202
	end

	OperationRecorder.RecordStayView("STAY_VIEW_SETTING_SKILL", slot2, slot3)
	slot0:UpdateLastOpenTime()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.toggles[slot1])
	slot2:SetSelect(slot0.selectIndex)
	slot2:RegistCallBack(handler(slot0, slot0.SetSelectPage))
end

function slot0.SetSelectPage(slot0, slot1)
	if slot1 == slot0.selectIndex then
		return
	end

	slot0.selectIndex = math.min(slot1, #slot0.toggles)

	for slot6, slot7 in ipairs(slot0.toggleList:GetItemList()) do
		slot7:SetSelect(slot0.selectIndex)
	end

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if slot0.curPage then
		slot0.curPage:SetActive(false)
	end

	if not slot0.pages[slot0.toggles[slot0.selectIndex]:GetName()] then
		slot0.pages[slot3] = slot2:UIClass().New(slot0, Object.Instantiate(Asset.Load(slot2:GetPath()), slot0.m_content), slot2:GetParams())
	end

	slot0.curPage = slot0.pages[slot3]

	slot0.curPage:SetActive(true)
	SetActive(slot0.resetGo_, slot2:IsSetting())
	SetActive(slot0.resetDefGo_, slot0.curPage.ResetDefaultData ~= nil)
end

function slot0.RefreshQuitType(slot0)
	if slot0.isSystem_ then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			NAVI_BAR
		})
		manager.windowBar:RegistBackCallBack(function ()
			uv0:BackFunc(function ()
				uv0:Back()
			end)
		end)
		manager.windowBar:RegistHomeCallBack(function ()
			uv0:BackFunc(function ()
				uv0:Go("/home")
			end)
		end)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
		manager.windowBar:RegistBackCallBack(function ()
			uv0:BackFunc()

			if uv0:GetIsContinuousFight() then
				uv0:Back()
			else
				gameContext:DestroyCurRoutes()
			end

			LuaExchangeHelper.ContinueGame()
		end)
	end
end

function slot0.GetIsContinuousFight(slot0)
	if slot0.isSystem_ or slot0.params_.stageData == nil then
		return false
	end

	return slot0.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON
end

function slot0.BackFunc(slot0, slot1)
	slot2 = false

	for slot6, slot7 in pairs(slot0.pages) do
		if slot7.CheckDataChange and slot7:CheckDataChange() then
			slot2 = true
		end
	end

	if slot2 then
		for slot6, slot7 in pairs(slot0.pages) do
			if slot7.SaveData then
				slot7:SaveData()
			end
		end

		OperationRecorder.Record(slot0.class.__cname, "panel/btn_save")
	end

	if slot1 then
		slot1()
	end
end

function slot0.GetToggleList(slot0)
	slot2 = slot0.params_.stageData
	slot0.isSystem_ = (slot0.params_.setType or SettingConst.SETTING_TYPE.SYSTEM) == SettingConst.SETTING_TYPE.SYSTEM

	if slot0.isSystem_ then
		table.insert({}, GraphicSettingToggle.New())
	end

	if slot2 and not slot0.isSystem_ and (slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX) then
		table.insert(slot3, IntelligenceSettingToggle.New({
			slot0.params_
		}))
	end

	table.insert(slot3, SoundSettingToggle.New())
	table.insert(slot3, GameSettingToggle.New(slot0.params_))

	if not slot0.isSystem_ then
		if not (slot2 and slot2:GetType() == BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL) and not (slot2 and slot2:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON) and not (slot2 and slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STRONGHOLD) and not (slot2 and (slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS)) and not (slot2 and slot2:GetType() == BattleConst.STAGE_TYPE_NEW.ARTIFACT) and not (slot2 and slot2:GetType() == BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL) then
			slot10 = {}

			if slot2:GetType() == BattleConst.STAGE_TYPE_NEW.RACE_TRIAL then
				slot13 = nil

				for slot17, slot18 in ipairs(RaceTrialData:GetCustomList(slot2:GetActivityID())) do
					slot13 = ActivityAffixPoolCfg[slot18].affix

					table.insert(slot10, {
						slot13[1],
						slot13[2]
					})
				end
			else
				slot10 = slot2:GetSettingShowAffix()
			end

			if #slot10 > 0 then
				table.insert(slot3, AffixSettingToggle.New({
					affixData = slot10,
					stageData = slot2
				}))
			end
		end
	end

	if not slot0.isSystem_ and slot2 and slot2:GetType() ~= BattleConst.STAGE_TYPE_NEW.LEVIATHAN_GAME and slot2:GetType() ~= BattleConst.STAGE_TYPE_NEW.SKADI_GAME and not table.keyof(GameSetting.setting_need_not_skill_info.value, slot2:GetStageId()) and GetSceneDataForExcehange().roleDataInLua[0] and (not HeroCfg[SkinCfg[slot5.ID] and SkinCfg[slot5.ID].hero] or HeroCfg[slot6].hide_info == 0) then
		table.insert(slot3, SkillSettingToggle.New({
			stageData = slot2
		}))
	end

	if not slot0.isSystem_ and slot2 and (slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS) then
		table.insert(slot3, ArtifactSettingToggle.New({
			stageData = slot2
		}))
	end

	table.insert(slot3, OperationSettingToggle.New())

	if slot0.isSystem_ then
		table.insert(slot3, RemindSettingToggle.New())
	end

	if slot2 and slot2:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON then
		table.insert(slot3, PolyhedronAdditionSettingToggle.New())
	end

	if slot2 and slot2:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON then
		table.insert(slot3, PolyhedronTeamInfoSettingToggle.New())
	end

	if slot2 and slot2:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON then
		table.insert(slot3, PolyhedronHeroInfoSettingToggle.New())
	end

	return slot3
end

function slot0.RefreshBtns(slot0)
	slot2 = slot0.params_.stageData
	slot0.isSystem_ = (slot0.params_.setType or SettingConst.SETTING_TYPE.SYSTEM) == SettingConst.SETTING_TYPE.SYSTEM

	SetActive(slot0.restartGo_, not slot0.isSystem_ and slot2 and (slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON))
	SetActive(slot0.quitBattleGo_, not slot0.isSystem_ and not slot0.params_.newbie and slot2:GetType() ~= BattleConst.STAGE_TYPE_NEW.POLYHEDRON)
	SetActive(slot0.polyhedronSettlementGo_, not slot0.isSystem_ and slot2 and slot2:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON)
	SetActive(slot0.polyhedronQuitGo_, not slot0.isSystem_ and slot2 and slot2:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON)
end

function slot0.Dispose(slot0)
	slot0.toggleList:Dispose()

	for slot4, slot5 in pairs(slot0.pages) do
		slot5:Dispose()
	end

	slot0.pages = {}

	uv0.super.Dispose(slot0)
end

function slot0.OnExitInput(slot0)
	if not slot0.isSystem_ then
		gameContext:DestroyCurRoutes()
		LuaExchangeHelper.ContinueGame()

		return true
	end
end

return slot0
