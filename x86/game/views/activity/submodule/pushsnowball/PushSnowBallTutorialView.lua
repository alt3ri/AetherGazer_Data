slot0 = class("PushSnowBallTutorialView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballTeachingEntrancePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		if uv0.timer_ then
			return
		end

		uv0.bgAni_:SetFloat("speed", -1)
		uv0.bgAni_:Play("EventPopUI1", 0, 1)
		uv0.bgAni_:Update(0)

		uv0.timer_ = Timer.New(function ()
			uv0:Back()

			uv0.timer_ = nil
		end, 0.18, 1)

		uv0.timer_:Start()
	end)
	slot0:AddBtnListener(slot0.playBtn_, nil, function ()
		slot0 = PushSnowBallData:GetSingleModelActivityIDByModelAndLevel(1, 1)
		slot1 = PushSnowBallCfg.get_id_list_by_activityId[slot0][1]

		BattleController.GetInstance():LaunchBattle(BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_SINGLE, GameSetting.push_snow_ball_tutorial_stage.value[1], {
			activityID = slot0
		}))
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.AddTimer(slot0)
end

function slot0.OnExit(slot0)
end

return slot0
