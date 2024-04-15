slot0 = class("SPHeroChallengeScheduleView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeScheduleUI"
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

	slot0.curScheduleScroll = LuaList.New(handler(slot0, slot0.indexSchedule), slot0.uilistGo_, SPHeroChallengeScheduleStartItem)
	slot0.awardItme = CommonItemView.New(slot0.commonitemGo_1)
	slot0.btnController = slot0.controller:GetController("state")
end

function slot0.OnEnter(slot0)
	slot0.data = SPHeroChallengeData:GetCurActivityInfo()
	slot0.scheduleStart = slot0.data:CheckCurScheduleStart()

	slot0:RegisterEvents()
	slot0:InitCanChooseScheduleList()
	slot0:RefreshCanChooseScheduleList()
	slot0:RefreshHadChossScheduleList()
	slot0:RefreshDailyAwardInfo()
end

function slot0.OnTop(slot0)
	slot0:RefreshBar()
	slot0:BindRedPonit()
end

function slot0.BindRedPonit(slot0)
end

function slot0.UnBindRedPonit(slot0)
end

function slot0.RefreshBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:UnBindRedPonit()
	slot0:RemoveAllEventListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.autoBtn_, nil, function ()
		if not uv0.scheduleStart then
			SPHeroChallengeTools:AutoChooseSchedule()
		end
	end)
	slot0:AddBtnListenerScale(slot0.confirmBtn_, nil, function ()
		if uv0.hadChooseList and not uv0.scheduleStart then
			for slot4, slot5 in ipairs(uv0.data:GetScheduleDailyList()) do
				if slot5 == 0 then
					ShowTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_EMPTY")

					return
				end
			end

			if #slot0 < SpHeroChallengeConst.scheduleNum then
				ShowTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_EMPTY")

				return
			end

			SPHeroChallengeAction:ConfirmScheduleList(slot0)
		end
	end)
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(SP_HERO_CHALLENGE_SCHEDULE_CONFIRM, function ()
		JumpTools.OpenPageByJump("/spHeroChallengeMainView")
		ShowTips("ACTIVITY_HERO_CHALLENGE_SET_SCHEDULE_SUCCESS")
	end)
	slot0:RegistEventListener(SP_HERO_CHALLENGE_SCHEDULE_CHANGE, function (slot0)
		if slot0 then
			uv0:RefreshCanChooseScheduleList()
			uv0:RefreshSingleScheduleState(slot0)
		end
	end)
end

function slot0.Dispose(slot0)
	if slot0.scheduleTypePool then
		for slot4, slot5 in pairs(slot0.scheduleTypePool) do
			slot5:Dispose()
		end

		slot0.scheduleTypePool = nil
	end

	if slot0.curScheduleScroll then
		slot0.curScheduleScroll:Dispose()
	end

	if slot0.awardItme then
		slot0.awardItme:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.InitCanChooseScheduleList(slot0)
	if not slot0.initFlag then
		slot0.initFlag = true
		slot0.schedulePool = {}
		slot0.scheduleTypePool = {}

		for slot5, slot6 in ipairs(ActivityHeroChallengeScheduleCfg.get_id_list_by_type) do
			slot0.scheduleTypePool[slot5] = SPHeroChallengeScheduleTypeItem.New(slot0.typegroupGo_, slot0.contentTrs_, slot5)
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs_)
	end
end

function slot0.RefreshHadChossScheduleList(slot0)
	slot1 = slot0.data:GetScheduleDailyList()
	slot0.hadChooseList = {}

	for slot5 = 1, SpHeroChallengeConst.scheduleNum do
		if slot1[slot5] and slot1[slot5] ~= 0 then
			slot0.hadChooseList[slot5] = {
				scheduleID = slot1[slot5],
				index = slot5
			}
		else
			slot0.hadChooseList[slot5] = {
				index = slot5
			}
		end
	end

	slot0.curScheduleScroll:StartScroll(#slot0.hadChooseList)
	slot0:RefreshConfirmBtnState()
end

function slot0.RefreshDailyAwardInfo(slot0)
	slot1 = GameSetting.activity_hero_challenge_daily_time.value[1]

	slot0.awardItme:SetData({
		id = slot1[1],
		number = slot1[2],
		clickFun = function (slot0)
			ShowPopItem(POP_ITEM, {
				slot0.id
			})
		end
	})
end

function slot0.RefreshCanChooseScheduleList(slot0)
	if slot0.scheduleTypePool then
		for slot4, slot5 in ipairs(slot0.scheduleTypePool) do
			slot5:RefreshUI()
		end
	end
end

function slot0.indexSchedule(slot0, slot1, slot2)
	if not slot0.scheduleStart then
		slot2:RefreshUI(slot0.hadChooseList[slot1])
		slot2:RegisterCancelCallBack(function ()
			uv0:RefreshSingleScheduleState(uv1)
		end)
	end
end

function slot0.RefreshConfirmBtnState(slot0)
	slot1 = slot0.data:GetScheduleDailyList()
	slot2 = true

	for slot6 = 1, SpHeroChallengeConst.scheduleNum do
		if not slot1 or not slot1[slot6] or slot1[slot6] == 0 then
			slot2 = false

			break
		end
	end

	if slot2 then
		slot0.btnController:SetSelectedState("normal")
	else
		slot0.btnController:SetSelectedState("unusable")
	end
end

function slot0.RefreshSingleScheduleState(slot0, slot1)
	slot4 = {}

	slot0.curScheduleScroll:GetItemByIndex(slot1):RefreshUI((not slot0.data:GetScheduleDailyList()[slot1] or slot2[slot1] == 0 or {
		scheduleID = slot2[slot1],
		index = slot1
	}) and {
		index = slot1
	})
	slot0:RefreshConfirmBtnState()
end

return slot0
