slot0 = class("RaceCollectRewardView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/CharacterGuideUI/HeroPreviewUIRewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.raceItems_ = {}
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.raceIds_[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		HeroRaceCollectAction.ReceiveAllTasksReward()
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(RACE_COLLECT_REWARD_GET, function (slot0)
		uv0:UpdateView()
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	slot0:ShowDefaultBar()
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.raceIds_ = RaceEffectCfg.all

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.getLabel1_.text = HeroRaceCollectData:GetTasksReceivedCount()
	slot0.getLabel2_.text = "/" .. #CollectHeroRaceCfg.all
	slot3 = HeroRaceCollectData
	slot4 = slot3

	SetActive(slot0.receiveAllBtn_, slot3.HasRewardReceive(slot4))

	for slot4, slot5 in pairs(slot0.raceIds_) do
		if slot0.raceItems_[slot4] == nil then
			slot0.raceItems_[slot4] = RaceCollectRewardItemView.New(slot0.itemGo_, slot0.itemParent_)
		end

		slot0.raceItems_[slot4]:SetData(slot4, slot5)
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.raceItems_) do
		slot5:Dispose()
	end

	slot0.raceItems_ = {}

	uv0.super.Dispose(slot0)
end

return slot0
