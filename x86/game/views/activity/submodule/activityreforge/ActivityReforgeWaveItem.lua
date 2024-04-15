slot0 = class("ActivityReforgeWaveItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = slot0.controllerEx_:GetController("status")
	slot0.selectController_ = slot0.controllerEx_:GetController("isselect")
	slot0.heroHeadItemList_ = {}

	for slot4 = 1, 3 do
		slot0.heroHeadItemList_[slot4] = ActivityReforgeHeroHeadItem.New(slot0["heroHeadGo" .. slot4 .. "_"])
	end
end

function slot0.SetClickHandle(slot0, slot1)
	slot0.clickHandle_ = slot1
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.waveID_ = slot2

	if slot0.index_ == slot3 then
		slot0.selectController_:SetSelectedState("true")
	else
		slot0.selectController_:SetSelectedState("false")
	end

	slot0.waveNum_.text = slot0.index_
	slot0.teamInfo_ = ActivityReforgeData:GetWaveTeamInfo(slot0.waveID_)

	if slot0.teamInfo_ == nil then
		slot0.statusController_:SetSelectedState("normal")
	else
		slot0.statusController_:SetSelectedState("hero")

		for slot8 = 1, 3 do
			slot0.heroHeadItemList_[slot8]:SetData(ActivityReforgeTeamCfg[slot0.teamInfo_.teamID].team_info[slot0.teamInfo_.level][slot8])
		end
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickHandle_ then
			uv0.clickHandle_(uv0.index_)
		end
	end)
end

function slot0.Dispose(slot0)
	for slot4 = 1, 3 do
		slot0.heroHeadItemList_[slot4]:Dispose()

		slot0.heroHeadItemList_[slot4] = nil
	end

	slot0.heroHeadItemList_ = nil
	slot0.clickHandle_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
