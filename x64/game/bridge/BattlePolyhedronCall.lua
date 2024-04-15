slot0, slot1, slot2 = nil

function DoPolyhedronNextTrigger()
	LuaExchangeHelper.EnableATrigger(uv0, uv1)
end

function DoPolyhedronNextBattleTrigger()
	LuaExchangeHelper.EnableATrigger(uv0, uv1)
end

function slot3()
	LuaForCursor.SwitchCursor(false)
	JumpTools.OpenPageByJump("/polyhedronBlank/polyhedronBattle")
end

function slot4()
	JumpTools.OpenPageByJump("/polyhedronBlank")
end

function SendPolyhedronGetBattleStage()
	CheckManagers()

	slot1 = PolyhedronData:GetPolyhedronInfo():GetSavePoint()

	print("更新关卡点" .. slot1)

	if PolyhedronConst.SAVE_POINT_TYPE.BATTLE == slot1 then
		if PolyhedronConst.REWARD_TYEP.TEAMMATE == slot0:GetRewardType() then
			uv0()
		else
			uv1()
		end

		return 0
	elseif PolyhedronConst.SAVE_POINT_TYPE.REWARD == slot1 then
		return 1
	elseif PolyhedronConst.SAVE_POINT_TYPE.OPTION == slot1 then
		uv0()

		return 2
	end
end

function UpdatePolyhedronBattleHpUI()
	slot1 = manager.ui.uiMain.transform:Find("BattlePanel/ScreenAdjustContainer/PlayerInfo").transform
	slot4 = slot1:Find("hp/hp_value_text_max"):GetComponent("Text")
	slot1:GetComponent("PlayerInfoUI").enabled = false
	slot6 = PolyhedronData:GetPolyhedronInfo()
	slot7 = slot6:GetHeroPolyData(slot6:GetLeaderHeroId())
	slot10 = math.round(tonumber(slot4.text) * slot7:GetHeroHP() / slot7:GetHeroMaxHP())
	slot1:Find("hp/hp_value_text"):GetComponent("Text").text = slot10
	slot1:Find("hp/Slider"):GetComponent("Slider").value = slot10 / tonumber(slot4.text)
	slot11, slot12 = slot6:GetReviveCount()

	for slot17 = 0, manager.ui.uiMain.transform:Find("BattlePanel/ScreenAdjustContainer/RightTopButtons/MatrixResurrectCoin").transform.childCount - 2 do
		slot19 = slot13.transform:GetChild(slot17).gameObject.transform:GetChild(0).gameObject

		if slot17 < slot12 then
			slot18:SetActive(true)
		else
			slot18:SetActive(false)
		end

		if slot17 < slot11 then
			slot19:SetActive(true)
		else
			slot19:SetActive(false)
		end
	end
end

function SendPolyhedronSetNextTrigger(slot0, slot1)
	uv0 = slot0
	uv1 = slot1
end

function SendPolyhedronGetCharactorInfo(slot0)
	slot3 = slot0 + 1

	if PolyhedronConst.REWARD_TYEP.TEAMMATE == PolyhedronData:GetPolyhedronInfo():GetRewardType() then
		return slot1:GetEnlistHeroList()[slot3] and PolyhedronData:GetHeroUsingSkinInfo(slot4[slot3].heroId).id or 0
	else
		Debug.LogError("SendPolyhedronGetCharactorInfo config error")

		if slot3 == 1 then
			return 1011
		else
			return 0
		end
	end
end

function SendPolyhedronShowCharactorInfo(slot0, slot1, slot2, slot3)
	if slot0 + 1 ~= 0 and not PolyhedronData:GetPolyhedronInfo():GetEnlistHeroList()[slot0] then
		return
	end

	uv0 = slot1
	uv1 = slot2
	uv2 = slot3

	JumpTools.OpenPageByJump("polyhedronInteractiveHero", {
		index = slot0
	})
end

function SendPolyhedronHideCharactorInfo(slot0)
	uv0()
end

function SendPolyhedronNextMapIsExist(slot0)
	if PolyhedronData:GetPolyhedronInfo():GetGateData(slot0) then
		return PolyhedronTools.GetGateCfg(slot2.id, slot2.reward_type).gate_index
	else
		return 0
	end
end

function SendPolyhedronShowNextMapInfo(slot0)
	JumpTools.OpenPageByJump("polyhedronInteractive", {
		index = slot0
	})
end

function SendPolyhedronHideNextMapInfo(slot0)
	uv0()
end

function SendPolyhedronShowRewardInfo(slot0, slot1)
	if PolyhedronConst.SAVE_POINT_TYPE.REWARD == PolyhedronData:GetPolyhedronInfo():GetSavePoint() then
		uv0 = slot0
		uv1 = slot1

		JumpTools.OpenPageByJump("/polyhedronBlank/polyhedronBattle/polyhedronReward")
		LuaForCursor.SwitchCursor(true)
	else
		LuaExchangeHelper.EnableATrigger(slot0, slot1)
	end
end

function SendPolyhedronShowStoreInfo()
	JumpTools.OpenPageByJump("polyhedronBattle/polyhedronInteractiveShop")
end

function HidePolyhedronShowStoreInfo()
	uv0()
end

function SendPolyhedronShowExitInfo()
end

function SendPolyhedronHideExitInfo()
end

function SendPolyhedronShowTeamInfo()
end

function SendPolyhedronHideTeamInfo()
end
