slot0 = class("ZumaGameViewChapterInfo", ReduxView)
slot1 = {
	btnState = {
		before = "state2",
		name = "btn",
		unOpen = "state1",
		canOpen = "state0"
	},
	diffcultState = {
		night = "state1",
		name = "diffcultShow",
		normal = "state0"
	},
	rewardState = {
		repeatShow = "repeat_show",
		name = "rewardState",
		firstGet = "first_get",
		firstShow = "first_show"
	}
}

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

	slot0.btnStateController = slot0.controllerexcollection_:GetController(uv0.btnState.name)
	slot0.diffcultShowController = slot0.controllerexcollection_:GetController(uv0.diffcultState.name)
	slot0.rewardStateController = slot0.controllerexcollection_:GetController(uv0.rewardState.name)
	slot0.conditionList = {}

	for slot4 = 1, 3 do
		slot0.conditionList[slot4] = ZumaConditionItem.New(slot0[string.format("condition%sGo_", slot4)])
	end

	slot0.rewardIcon1_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
	slot0.rewardIcon2_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.ChanllengeBtn_, nil, function ()
		ZumaAction.PlayZumaGame(uv0.selectZumaID)
	end)
end

function slot0.IsShowPanel(slot0, slot1)
	slot0.isShow = slot1

	SetActive(slot0.gameObject_, slot1)
end

function slot0.OnEnter(slot0)
	slot0:UpdateBtnController()
end

function slot0.RefreshUi(slot0, slot1)
	ZumaData:SetZumaRead(slot1.activity_id)

	slot0.selectZumaID = slot1.id
	slot0.selectZumaActID = slot1.activity_id

	slot0:IsShowPanel(true)

	slot0.nameText_.text = slot1.name

	if slot1.difficult == ZumaConst.ZUMA_DIFFICULT.ESAY then
		slot0.difficultText_.text = GetTips("ACTIVITY_ZUMA_LEVEL_DIFFICULTY_1")
	elseif slot2 == ZumaConst.ZUMA_DIFFICULT.HARD then
		slot0.difficultText_.text = GetTips("ACTIVITY_ZUMA_LEVEL_DIFFICULTY_2")
	elseif slot2 == ZumaConst.ZUMA_DIFFICULT.NIGHT then
		slot0.difficultText_.text = GetTips("ACTIVITY_ZUMA_LEVEL_DIFFICULTY_3")
	end

	slot0.rank1Text_.text = ZumaData:GetZumaStageScore(slot1.id) and slot3 or GetTips("ACTIVITY_ZUMA_NO_DATA")
	slot0.rank2Text_.text = slot3 and slot3 or GetTips("ACTIVITY_ZUMA_NO_DATA")
	slot0.firstRewardText_.text = slot1.first_reward
	slot0.repeatRewardText_.text = slot1.repeat_reward

	slot0:UpdateTaskList(slot1.activity_point_reward, slot3 or 0)
	slot0:UpdateBtnController()
	slot0:UpdateDifficultController()
	slot0:UpdateRewardController()
end

function slot0.UpdateBtnController(slot0)
	if not slot0.selectZumaID then
		return
	end

	slot0:StopTimer()

	if not ActivityData:GetActivityData(slot0.selectZumaActID) or not slot2:IsActivitying() then
		slot0.btnStateController:SetSelectedState(uv0.btnState.unOpen)
		slot0:AddTimer()
	elseif ZumaData:GetZumaBeforeIsFinish(slot1) then
		slot0.btnStateController:SetSelectedState(uv0.btnState.canOpen)
	else
		slot0.btnStateController:SetSelectedState(uv0.btnState.before)

		slot0.btnLockText1_.text = GetTips("ACTIVITY_ZUMA_OPEN_FRONT")
		slot0.btnLockText2_.text = GetTips("ACTIVITY_ZUMA_OPEN_FRONT")
	end
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()
	slot0:RefreshTime()

	slot0.timer_ = Timer.New(function ()
		uv0:RefreshTime()
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.RefreshTime(slot0)
	if ZumaData:GetZumaStageOpenTime(slot0.selectZumaID) then
		slot0.btnLockText1_.text = slot1
		slot0.btnLockText2_.text = slot1
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.UpdateDifficultController(slot0)
	if not slot0.selectZumaID then
		return
	end

	if ActivityZumaLevelCfg[slot1].difficult == 3 then
		slot0.diffcultShowController:SetSelectedState(uv0.diffcultState.night)
	else
		slot0.diffcultShowController:SetSelectedState(uv0.diffcultState.normal)
	end
end

function slot0.UpdateRewardController(slot0)
	if not slot0.selectZumaID then
		return
	end

	if ActivityZumaLevelCfg[slot1].difficult == 3 and ZumaData:GetZumaStageScore(slot1) then
		slot0.rewardStateController:SetSelectedState(uv0.rewardState.firstGet)
	elseif slot4 then
		slot0.rewardStateController:SetSelectedState(uv0.rewardState.repeatShow)
	else
		slot0.rewardStateController:SetSelectedState(uv0.rewardState.firstShow)
	end
end

function slot0.UpdateTaskList(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot1) do
		slot0.conditionList[slot6]:RefreshConditionState(slot7, slot2)
	end
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.conditionList) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
