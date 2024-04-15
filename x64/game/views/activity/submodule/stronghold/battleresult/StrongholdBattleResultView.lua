slot0 = class("StrongholdBattleResultView", ReduxView)

function slot0.UIName(slot0)
	return "UI/CooperationBattleResult/CooperationResultUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.orderList = LuaList.New(handler(slot0, slot0.IndexOrderItem), slot0.m_orderList, StrongholdBattleResultOrderItem)
	slot0.intensifyList = LuaList.New(handler(slot0, slot0.IndexIntensifyItem), slot0.m_intensifyList, StrongholdBattleResultIntensifyItem)
	slot0.achieveList = LuaList.New(handler(slot0, slot0.IndexAchieveItem), slot0.m_achieveList, StrongholdBattleResultAchieveItem)
	slot0.skillController = ControllerUtil.GetController(slot0.gameObject_.transform, "skill")
	slot0.resultController = ControllerUtil.GetController(slot0.transform_, "result")
	slot0.itemInfoController = ControllerUtil.GetController(slot0.transform_, "itemInfo")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_quitBtn, nil, function ()
		BattleInstance.QuitBattle(uv0.stageData)
	end)
	slot0:AddBtnListener(slot0.m_statisticsBtn, nil, function ()
		JumpTools.OpenPageByJump("strongholdBattleStatistics", {
			stageData = uv0.stageData,
			battleTime = uv0:GetBattleTime()
		})
	end)
	slot0:AddBtnListener(slot0.m_infoMask, nil, function ()
		uv0.itemInfoController:SetSelectedIndex(0)
	end)
end

function slot0.OnTop(slot0)
end

function slot0.OnEnter(slot0)
	slot0.stageData = slot0.params_.stageData
	slot0.rewardList = slot0.params_.rewardList

	slot0:RefreshUI()

	if slot0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function ()
				uv0:CloseFunc()
			end
		})
	end

	slot0.itemInfoController:SetSelectedIndex(0)
end

function slot0.OnExit(slot0)
end

function slot0.RefreshUI(slot0)
	slot1 = PlayerData:GetPlayerInfo().userID
	slot2 = 1
	slot3, slot4 = slot0.stageData:GetIsCooperation()

	if slot3 then
		for slot8, slot9 in ipairs(slot4) do
			if slot9.playerID == slot1 then
				slot2 = slot8

				break
			end
		end
	end

	slot0.m_heroIcon.sprite = getSpriteViaConfig("HeroLittleIcon", slot0.stageData:GetHeroDataByPos(slot2).using_skin)

	slot0.orderList:StartScroll(3)

	slot0.m_difficultyLab.text = ActivityStrongholdCfg[slot0.stageData:GetDest()].difficulty_des

	if isSuccess(slot0.params_.result) then
		slot0.resultController:SetSelectedIndex(0)
	else
		slot0.resultController:SetSelectedIndex(1)
	end

	slot0.m_timeLab.text = slot0:GetBattleTime()
	slot0.main_activity_id = 0

	for slot12, slot13 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STRONGHOLD] or {}) do
		if table.indexof(ActivityCfg[slot13].sub_activity_list, slot0.stageData:GetActivityID()) then
			slot0.main_activity_id = slot13

			break
		end
	end

	if LuaExchangeHelper.GetBattleStatisticsData() then
		slot11 = slot9.choosedEffectID
		slot0.achieveDataList = {}
		slot12 = {}

		for slot17 = 0, slot9.finishedAchievement.Count - 1 do
			if ActivityStrongholdAchievementCfg[slot10[slot17]] and slot19.type ~= -1 then
				if slot19.type == 0 then
					table.insert(slot0.achieveDataList, slot18)
				elseif slot12[slot20] then
					slot12[slot20] = math.max(slot12[slot20], slot18)
				else
					slot12[slot20] = slot18
				end
			end
		end

		for slot17, slot18 in pairs(slot12) do
			table.insert(slot0.achieveDataList, slot18)
		end

		slot0.achieveList:StartScroll(#slot0.achieveDataList)

		slot0.intensifyDataList = {}

		for slot18 = 0, slot11.Count - 1 do
			table.insert(slot0.intensifyDataList, slot9.choosedEffectID[slot18])
		end

		slot0.intensifyList:StartScroll(#slot0.intensifyDataList)
	else
		slot0.intensifyList:StartScroll(0)
		slot0.achieveList:StartScroll(0)
	end

	slot10, slot11 = slot0.stageData:GetType()

	if BattleConst.STAGE_TYPE_NEW.STRONGHOLD ~= slot10 then
		slot11 = 0
	end

	if slot11 and slot11 ~= 0 then
		slot0.skillController:SetSelectedIndex(1)

		slot0.m_skillIcon.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdSkill/" .. slot11)
	else
		slot0.skillController:SetSelectedIndex(0)
	end
end

function slot0.GetBattleTime(slot0)
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function slot0.Dispose(slot0)
	slot0.orderList:Dispose()
	slot0.intensifyList:Dispose()
	slot0.achieveList:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.IndexOrderItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.rewardList, slot0.main_activity_id)
end

function slot0.IndexIntensifyItem(slot0, slot1, slot2)
	slot2:SetData(slot0.intensifyDataList[slot1])
	slot2:RegistCallBack(function (slot0)
		uv0:OnItemClick(slot0)
	end)
end

function slot0.IndexAchieveItem(slot0, slot1, slot2)
	slot2:SetData(slot0.achieveDataList[slot1])
end

function slot0.OnItemClick(slot0, slot1)
	slot0.itemInfoController:SetSelectedIndex(1)

	slot2 = ActivityStrongholdArtifactCfg[slot1]
	slot0.m_infoName.text = slot2.name
	slot0.m_infoDes.text = slot2.desc

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_infoDesTrans)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_infoTrans)
end

return slot0
