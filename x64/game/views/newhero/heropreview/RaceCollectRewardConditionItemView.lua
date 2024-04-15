slot0 = class("RaceCollectRewardConditionItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:AddEventListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, CommonItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot3 = clone(ItemTemplateData)
	slot3.id = slot0.cfg_.reward[slot1][1]
	slot3.number = slot0.cfg_.reward[slot1][2]

	function slot3.clickFun(slot0)
		ShowPopItem(POP_ITEM, uv0.cfg_.reward[uv1])
	end

	slot2:SetData(slot3)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.getBtn_, nil, function ()
		HeroRaceCollectAction.ReceiveOneTaskReward(uv0.taskId_)
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(RACE_COLLECT_REWARD_GET, function (slot0)
		if table.indexof(slot0, uv0.taskId_) then
			uv0:UpdateView()
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.taskId_ = slot2
	slot0.raceId_ = slot3
	slot0.cfg_ = CollectHeroRaceCfg[slot2]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot3 = nil
	slot0.conditionLabel_.text = string.format(GetTips("COLLECT_HERO_RACE_DES"), slot0.cfg_.need <= HeroRaceCollectData:GetHeroRaceCount(slot0.raceId_) and slot1 or slot2, slot1, RaceEffectCfg[slot0.raceId_].name)

	slot0.uiList_:StartScroll(#slot0.cfg_.reward)

	if HeroRaceCollectData:GetTaskState(slot0.taskId_) == 0 then
		slot0.statusController_:SetSelectedState("unFinish")
	elseif slot5 == 1 then
		slot0.statusController_:SetSelectedState("canGet")
	elseif slot5 == 2 then
		slot0.statusController_:SetSelectedState("haveGet")
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()

	slot0.data_ = nil

	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
