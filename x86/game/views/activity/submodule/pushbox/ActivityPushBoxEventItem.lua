slot0 = class("ActivityPushBoxEventItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.levelCon_ = ControllerUtil.GetController(slot0.transform_, "level")
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.selectCon_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.cfg_.type == PushBoxConst.EVENT_TYPE.PUSH_BOX then
			saveData("activity_push_box", tostring(uv0.id_), 1)
			uv0.stateCon_:SetSelectedState("off")
		end

		if uv0.clickFunc_ then
			uv0.clickFunc_(uv0.id_, uv0.isClose_)
		end
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.isClose_ = false
	slot0.id_ = slot1
	slot0.cfg_ = ActivityCelebrationOrderCfg[slot1]

	if slot0.cfg_.type == PushBoxConst.EVENT_TYPE.BATTLE then
		slot0:RefreshBattle()
	elseif slot0.cfg_.type == PushBoxConst.EVENT_TYPE.PUSH_BOX then
		slot0:RefreshBox()
	end
end

function slot0.RefreshBattle(slot0)
	slot0.typeCon_:SetSelectedState("challenge")
	slot0.levelCon_:SetSelectedState(slot0.cfg_.hard)
end

function slot0.RefreshBox(slot0)
	slot0.typeCon_:SetSelectedState("box")
	slot0.stateCon_:SetSelectedState((getData("activity_push_box", tostring(slot0.id_)) or 0) == 0 and "on" or "off")
end

function slot0.RefreshCountDown(slot0, slot1)
	slot0.isClose_ = true
	slot0.id_ = slot1
	slot0.cfg_ = ActivityCelebrationOrderCfg[slot1]

	if ActivityPushBoxData:GetNextID(slot0.cfg_.main_activity, slot0.id_) == 0 then
		slot0.typeCon_:SetSelectedState("finial")

		return
	end

	slot0.typeCon_:SetSelectedState("rest")

	slot0.cfg_ = ActivityCelebrationOrderCfg[slot1]
	slot0.countDownTxt_.text = manager.time:DescCDTime(manager.time:GetNextFreshTime() - manager.time:GetServerTime())
	slot0.timer_ = Timer.New(function ()
		uv0 = manager.time:GetServerTime()
		uv1.countDownTxt_.text = manager.time:DescCDTime(uv2 - uv0)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.RegistClickFunc(slot0, slot1)
	slot0.clickFunc_ = slot1
end

function slot0.SetSelect(slot0, slot1)
	if slot1 ~= slot0.id_ then
		slot0.selectCon_:SetSelectedState("no")
	elseif slot0.cfg_.type == PushBoxConst.EVENT_TYPE.BATTLE then
		slot0.selectCon_:SetSelectedState("challenge")
	elseif slot0.cfg_.type == PushBoxConst.EVENT_TYPE.PUSH_BOX then
		slot0.selectCon_:SetSelectedState("box")
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
	slot0:StopTimer()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.clickFunc_ = nil

	slot0.super.Dispose(slot0)
end

return slot0
