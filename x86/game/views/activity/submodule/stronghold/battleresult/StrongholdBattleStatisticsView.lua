slot0 = class("StrongholdBattleStatisticsView", ReduxView)

function slot0.UIName(slot0)
	return "UI/CooperationBattleResult/CooperationStatisticsUI"
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

	slot0.staticHeroItemList = {}

	for slot4 = 1, 3 do
		table.insert(slot0.staticHeroItemList, StrongholdBattleStatisticsHeroItem.New(slot0["m_hero" .. slot4]))
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonShare_, nil, function ()
		manager.share:Share(function ()
			SetActive(uv0.goShare_, false)
			SetActive(uv0.goBack_, false)
		end, function ()
			SetActive(uv0.goShare_, true)
			SetActive(uv0.goBack_, true)
		end)
	end)
end

function slot0.OnEnter(slot0)
	slot0.stageData = slot0.params_.stageData
	slot1, slot2, slot3 = BattleTools.GetBattleStatisticsData()
	slot4, slot5 = slot0.stageData:GetIsCooperation()

	for slot9, slot10 in ipairs(slot0.staticHeroItemList) do
		slot10:SetData(slot5[slot9], slot1[slot9], slot3)
	end

	slot0.battleTimeText_.text = slot0.params_.battleTime
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.staticHeroItemList) do
		slot5:Dispose()
	end

	slot0.staticHeroItemList = {}

	uv0.super.Dispose(slot0)
end

function slot0.OnCooperationRoomInit(slot0)
	for slot4, slot5 in ipairs(slot0.staticHeroItemList) do
		slot5:RefreshState()
	end
end

function slot0.OnCooperationRoomUpdate(slot0)
	for slot4, slot5 in ipairs(slot0.staticHeroItemList) do
		slot5:RefreshState()
	end
end

return slot0
