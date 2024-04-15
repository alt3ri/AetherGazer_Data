ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("ActivityDressUpMainView", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_DressUpUI/NorseUI_3_0_DressUpMainUI"
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.isClick = false
	slot0.stateCtrl = slot0.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		JumpTools.GoToSystem("/rechargeMain", {
			childShopIndex = 2,
			page = 2
		}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
	end)
	slot0.speedBtn_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0.stateCtrl:SetSelectedIndex(0)

		uv0.anim_1.speed = 2
		uv0.anim_2.speed = 2
	end))
	slot0.speedBtn_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0.anim_1.speed = 7
		uv0.anim_2.speed = 7

		uv0.stateCtrl:SetSelectedIndex(1)
	end))
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.Show(slot0, slot1)
	if slot1 then
		SetActive(slot0.gameObject_, slot1)
		slot0.anim_1:Play("Fx_DressUpMainUI_cx", 0, slot0.normalizedTime_1 or 0)
		slot0.anim_1:Update(0)
		slot0.anim_2:Play("Fx_skin_loop_01", 0, slot0.normalizedTime_2 or 0)
		slot0.anim_2:Update(0)
	else
		if slot0.gameObject_.activeSelf == true then
			slot0.normalizedTime_1 = slot0.anim_1:GetCurrentAnimatorStateInfo(0).normalizedTime
			slot0.normalizedTime_2 = slot0.anim_2:GetCurrentAnimatorStateInfo(0).normalizedTime
		end

		SetActive(slot0.gameObject_, slot1)
	end
end

function slot0.RefreshUI(slot0)
	slot0.skinList_ = GameSetting.skin_return.value

	for slot4, slot5 in ipairs(slot0.skinList_) do
		slot0["skinImg_" .. slot4].sprite = getSpriteWithoutAtlas("TextureBg/Version/NorseUI_3_0/NorseUI_3_0_DressUpMainUI/" .. slot5)
	end

	slot0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(slot0.activityID_).stopTime)
	slot0.pressTxt_.text = GetTips("LONG_PRESS_FILM_ACCELERATE")
	slot0.accelerateTxt_.text = GetTips("ACCELERATING")
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.super.Dispose(slot0)
end

return slot0
