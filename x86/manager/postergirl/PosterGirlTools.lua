return {
	GetLoadLightEffect = function (slot0, slot1)
		if HomeSceneSettingCfg[HomeSceneSettingData:GetCurScene()] and type(slot3.light_effect) == "table" then
			return true, slot3.light_effect[slot1 + 1], uv0.GetEffectLightChangeTime(slot0 + 1, slot1 + 1)
		else
			return false
		end
	end,
	GetEffectLightChangeTime = function (slot0, slot1)
		if HomeSceneSettingCfg[HomeSceneSettingData:GetCurScene()] and slot3.light_effect_delay and type(slot3.light_effect_delay) == "table" then
			return slot3.light_effect_delay[slot0][slot1]
		end
	end,
	ProduceCommonState = function (slot0, slot1)
		if PosterGirlConst.StateKay.init == slot0 then
			return PosterCommonInitState.New(slot1)
		elseif PosterGirlConst.StateKay.idle == slot0 then
			return PosterCommonInteractionState.New(slot1, PosterGirlConst.InteractionKey.idle)
		elseif PosterGirlConst.StateKay.shake == slot0 then
			return PosterCommonInteractionState.New(slot1, PosterGirlConst.InteractionKey.shaking)
		elseif PosterGirlConst.StateKay.touch == slot0 then
			return PosterCommonInteractionState.New(slot1, PosterGirlConst.InteractionKey.mainTouch)
		elseif PosterGirlConst.StateKay.quickclick == slot0 then
			return PosterCommonInteractionState.New(slot1, PosterGirlConst.InteractionKey.mainQuickTouch)
		elseif PosterGirlConst.StateKay.show == slot0 then
			return PosterCommonInteractionState.New(slot1, PosterGirlConst.InteractionKey.showing)
		elseif PosterGirlConst.StateKay.greet == slot0 then
			return PosterCommonGreetingState.New(slot1)
		end
	end,
	ProduceDlcState = function (slot0, slot1)
		if PosterGirlConst.StateKay.init == slot0 then
			return PosterDlcInitState.New(slot1)
		elseif PosterGirlConst.StateKay.init_spec == slot0 then
			return PosterDlcInitSpecState.New(slot1)
		elseif PosterGirlConst.StateKay.idle == slot0 then
			return PosterDlcInteractionState.New(slot1, PosterGirlConst.InteractionKey.idle)
		elseif PosterGirlConst.StateKay.shake == slot0 then
			return PosterDlcInteractionState.New(slot1, PosterGirlConst.InteractionKey.shaking)
		elseif PosterGirlConst.StateKay.touch == slot0 then
			return PosterDlcTouchState.New(slot1)
		elseif PosterGirlConst.StateKay.quickclick == slot0 then
			return PosterDlcInteractionState.New(slot1, PosterGirlConst.InteractionKey.mainQuickTouch)
		elseif PosterGirlConst.StateKay.show == slot0 then
			return PosterDlcInteractionState.New(slot1, PosterGirlConst.InteractionKey.showing)
		elseif PosterGirlConst.StateKay.mid2left == slot0 then
			return PosterDlcSwipeState.New(slot1, PosterGirlConst.ViewDirect.center, PosterGirlConst.ViewDirect.left)
		elseif PosterGirlConst.StateKay.mid2right == slot0 then
			return PosterDlcSwipeState.New(slot1, PosterGirlConst.ViewDirect.center, PosterGirlConst.ViewDirect.right)
		elseif PosterGirlConst.StateKay.left2mid == slot0 then
			return PosterDlcSwipeState.New(slot1, PosterGirlConst.ViewDirect.left, PosterGirlConst.ViewDirect.center)
		elseif PosterGirlConst.StateKay.right2mid == slot0 then
			return PosterDlcSwipeState.New(slot1, PosterGirlConst.ViewDirect.right, PosterGirlConst.ViewDirect.center)
		elseif PosterGirlConst.StateKay.debut == slot0 then
			return PosterDlcDebutState.New(slot1)
		end
	end
}
