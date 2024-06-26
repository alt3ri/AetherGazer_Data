slot0 = class("SevenDaySignPage", BaseSignPage)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.hander_ = slot1
	slot0.activit_id = slot3
	slot0.gameObject_ = Object.Instantiate(Asset.Load(ActivityCumulativeSignCfg[slot0.activit_id].ui_path), slot2)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:Refresh()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.animPlaying = false
	slot0.scrollHelper = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_list, SevenDaySignItem)
end

function slot0.OnEnter(slot0)
	slot0:Show()
end

function slot0.OnShow(slot0)
	slot0:Refresh()
	slot0:RefreshSignItem()
end

function slot0.OnHide(slot0)
	if slot0.remainingTimer then
		slot0.remainingTimer:Stop()

		slot0.remainingTimer = nil
	end
end

function slot0.RefreshSignItem(slot0)
	slot1 = SignData:GetSevenDaySignInfo(slot0.activit_id)
	slot3 = 0

	if SignTools.GetSevenDaySignIndex(slot0.activit_id) ~= 0 then
		slot3 = slot2
	elseif slot1 ~= nil then
		slot3 = slot1.signCount
	end

	slot0.scrollHelper:StartScroll(#ActivityCumulativeSignCfg[slot0.activit_id].config_list, slot3)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:Refresh(slot1, ActivityCumulativeSignCfg[slot0.activit_id].config_list[slot1], SignTools.GetSevenDaySignState(slot0.activit_id, slot1))
end

function slot0.Refresh(slot0)
	if slot0.remainingTimer then
		slot0.remainingTimer:Stop()

		slot0.remainingTimer = nil
	end

	slot0.remainingTimer = Timer.New(function ()
		uv0:RefreshTime()
	end, 1, -1)

	slot0.remainingTimer:Start()
	slot0:RefreshTime()
end

function slot0.RefreshTime(slot0)
	if ActivityData:GetActivityData(slot0.activit_id) then
		slot0.m_timer.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(slot1.stopTime))
	end
end

function slot0.AutoGetReward(slot0)
	slot0.signIndex_ = SignTools.GetSevenDaySignIndex(slot0.activit_id)

	if slot0.signIndex_ > 0 then
		manager.ui:UIEventEnabledByUI(false, true)

		slot0.timer_ = Timer.New(function ()
			SignAction.QuerySevenDaySign(uv0.activit_id)
		end, 0.33, 1)

		slot0.timer_:Start()
	end
end

function slot0.GetItem(slot0, slot1)
	for slot6, slot7 in pairs(slot0.scrollHelper:GetItemList()) do
		if slot1 == slot7.index then
			return slot7
		end
	end

	return nil
end

function slot0.OnSign(slot0, slot1)
	if isSuccess(slot1.result) then
		if slot0.signIndex_ <= 0 then
			return
		end

		if not slot0:GetItem(slot0.signIndex_) then
			manager.ui:UIEventEnabledByUI(true, false)
			slot0:RefreshSignItem()

			return
		end

		slot2:StartPlayAnimator()

		slot0.timer_ = Timer.New(function ()
			if uv0:GetAnimator():GetCurrentAnimatorStateInfo(0).normalizedTime >= 2 or not uv1.animPlaying then
				if uv1.animPlaying then
					manager.notify:CallUpdateFunc(READY_TO_SKIP_SIGN_ANIMATION, true)
				end

				getReward2(uv2.item_list, {
					ItemConst.ITEM_TYPE.HERO,
					ItemConst.ITEM_TYPE.WEAPON_SERVANT
				}, handler(uv1.hander_, uv1.hander_.CheckSign))
				uv1.timer_:Stop()

				uv1.timer_ = nil
			end
		end, 0.033, -1)

		manager.ui:UIEventEnabledByUI(true, false)
		manager.notify:CallUpdateFunc(READY_TO_SKIP_SIGN_ANIMATION, false)
		slot0.timer_:Start()

		return
	end

	manager.ui:UIEventEnabledByUI(true, false)
	ShowTips(slot1.result)
end

function slot0.Dispose(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0.scrollHelper:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
